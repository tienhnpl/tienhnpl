package com.example.class_nftcollection_040425.utils;


import java.util.regex.Pattern;

public class RegexUtil {
    private static final Pattern WALLET_PATTERN = Pattern.compile("^0x[a-fA-F0-9]{40}$");
    private static final Pattern URL_PATTERN = Pattern.compile("^(https?://).+\\.(jpg|jpeg|png|gif|bmp|webp)$", Pattern.CASE_INSENSITIVE);

    public static boolean isValidWalletAddress(String address) {
        return address != null && WALLET_PATTERN.matcher(address).matches();
    }

    public static boolean isValidImageUrl(String url) {
        return url != null && URL_PATTERN.matcher(url).matches();
    }
}

