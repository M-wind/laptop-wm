require("mime-ext"):setup({
  with_files = {
    makefile = "text/x-makefile",
  },

  with_exts = {
    FLAC = "audio/x-flac",
    zst = "application/zstd",
    bz2 = "application/x-bzip2",
    gz = "application/gzip",
    zip = "application/zip",
    nu = "text/plain",
  },

  -- If the mime-type is not in both filename and extension databases,
  -- then fallback to Yazi's preset `mime` plugin, which uses `file(1)`
  fallback_file1 = false,
})
