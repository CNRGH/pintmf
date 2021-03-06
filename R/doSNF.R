#' init_SNF
#'
#' @param data List of matrices.
#' @param K Number of clusters
#' @param sigma Variance for local model
#'
#' @return a list of \code{clust} the clustering of samples and
#' \code{fit} the results of the method SNF
#' @import SNFtool
#' @importFrom dplyr %>%
#' @export
init_SNF <- function (data, K,   sigma=0.5){
  K_n <- min(10, nrow(data[[1]])-1)
  dat <- lapply(data, function (dd){
    dd <- dd %>% as.matrix
    W <- dd %>% dist2(dd) %>% affinityMatrix(K=K_n, sigma=sigma)
  })
  W <-  SNF(dat, K_n, K_n)
  clust.SNF = W %>% spectralClustering(K)
  res <- list(clust=clust.SNF, fit= W)
  return(res)
}
