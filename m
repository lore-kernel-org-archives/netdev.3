Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B98837B41B
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 18:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786128008; cv=none; b=ir61Wj9nkYrb9IS4scskbiO6MJf0eSyaHWxcj1O+eh0A/cmzB9SnJW2T9/cPl6SyRyhAZgLJcswS9u2Ferd0hE4GdPwKcis3cbYGagO+tic4N+LVcgJSh2j1SHaETbkqGnfxRrCu5+fw9JQvbSKKi3rRZlezaLdNfDEJ0LZFJ0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786128008; c=relaxed/simple;
	bh=yAjBdtzSxZzqazK4I4MclvRDi3Z09oilBmO66u8JyE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kniAL5qxO2L622EuG0uxDXGZzDPTmDBJhmtGCZZ2pnOl5gtSga1FppjTzErlBRn2VOPMl7iNbsLtEuhbUoNXMt+KVARqmPtkFpgY8DSjxdF1nDa2NvYgp8PN75wjzrkbd0ePSdKyiTh2c/7Jb3zqgHl5mzMkYhtRWa1uE+EAiZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=HeDxzhWl; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="HeDxzhWl"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso37062215e9.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 11:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1786128001; x=1786732801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L4EweZDFw2PX/IG413UeHfw+AVFQCjkdSWjHShCzuwY=;
        b=HeDxzhWlJ0HcGBaMOc2X1HHMT0KLnvnEUQBcmNB1odjjE5z1vkHWm1JG2sMmN9l4y3
         QMGcxwKzuVPHSW3Nlj7znLIGTOBTFGEqDxyP0Flww40k9yGbCwacELfYdORsH7P09iW7
         AEFd/HCJ/FPuNTv0QssU88zucg7C9EYt2P/Mmi7PKUf8mpyYi77otZxnpDas1S3oMdgz
         YCE4ZCGMY1XBpWspyPT0XRs3oCPT6Bt5PFkjeKKYjznZKFpffG5qg+qk76tU50wRq+7C
         1cFPJS1xG3ubO+LnzZB2sFerba0KWma/Y0qAeUCkL8T245jX3FFlr7BxOrnQDrFEPf4+
         Io6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786128001; x=1786732801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L4EweZDFw2PX/IG413UeHfw+AVFQCjkdSWjHShCzuwY=;
        b=qgomLnZ33WVJbJGQMc8Hs+FdT6WRVJHi7bsHSUg+f7EU//Uj2gph8LeB8QxWKdq/Y5
         UrDL1/FFp6Ysa36v1hAo3X/4uwtZaiQGgaj0FyTO7Uctc9r23FkVd8JrHkm9JxoAWIhN
         g+SB/RtJ/honxnEg4zQZPfgJ/YqCN71YX8N1MCj+PosQgzVXFGfZeSvg5NmBbfXS9/jg
         fPnS72ej3ShXdC9U5kJuksO3hFFdfHSebTCp6CF7NAn6KgiLp6rt2vuvxrVWZDG+X33E
         jXJ6Ci0U5TIurIUXqZhKx6bBQYavd2qSR/kaATEYs22I0JaI2fy8XXTYX+u58kLOKIJA
         igLg==
X-Gm-Message-State: AOJu0YywoyE9xs+xgD7NdyZ+Pjxqx6KcoQVN540mvW9tY3hyPbGIAsYH
	Qe/1qBOxm5d5f9t00AizfffXiulCRM4zuXEpE2onKVnI6GmXXsH3imqkxXIXpMEdtXpVqLe8Xnc
	kaLB8jK9WO6aD9m17SgkkRJMIYx5/Hshm+zY7NneOXIFZkW/LN+oc2zHSn266hVyLrnZ4vS2yUZ
	o4mbM5xrFOeQGlS/KG01RDQMxe4lUx9Jk6qCh4c1db4zgTtXI=
X-Gm-Gg: AR+sD10IhLy/MeLQ6l34cc+dXfG+xIh09wl+xnDhpZLhCGYsDvIrl4UVwfieYHo0rJx
	6RoweRAP6hSLqJi7B6bqoK99Jl8tOz7i5wzFaNFAbtk3ObvVZLbWSXN0PEtF8f8osjmyjUT3ML0
	k4Kbv75gAIbJRnNl2bg1gJIihgn9SU7E2x0ldVVYdkP4+9Drn7CB4Tlyp+GpdegNKRjiNyAdTZn
	Y27/3KIoSM5Zvul8aTR4g/82Ci9UkH1x2cD3R24sukMxDO9kY1smAReT59BB79+vrrsyUDHJX0p
	WRFpjk1CAh7LW9rGcn7O7Ji6dgoV9tXPWfaneTvdPJ49cYP2633bBozdpgWzvOOkujVNwls8tZO
	TJqfetz1lOxMS6IPNUv4c5FWDXSucFXl9c2mJuTCQzSrC7YboRQ5/cz0y3vKmIryUWHyi583YST
	1z8lUCH0RNRbT7rrscMJDdEJfpYP/K9FZcvNFHVFWwd3y++3xWuhV2xOx8eyQ0F4Iq1s3g3d0u1
	RaqKsmTYkwqC6N1UwC8+CQHErqtEusVc7mLeIbOTZixVnHbJJc/f37FFVKTDNy3MbORrXDo0qpJ
	zPq6UDA9Vi8TXOX1XOntLf+DvITjPxxcoaIKdrgPCM80I5+dJO99hByV4mfLGVMmj9dWAxHV3pG
	8VcGX96w=
X-Received: by 2002:a05:600c:a597:b0:499:4d50:7230 with SMTP id 5b1f17b1804b1-4994e7d9c03mr211783185e9.18.1786128001367;
        Fri, 07 Aug 2026 11:40:01 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-499541b86f5sm166106135e9.0.2026.08.07.11.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 11:40:00 -0700 (PDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	leon@kernel.org,
	andrew.gospodarek@broadcom.com,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH v16 02/10] net/mlx5e: add TLS 1.3 hardware offload support
Date: Fri,  7 Aug 2026 12:38:45 -0600
Message-Id: <20260807183853.2288959-3-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260807183853.2288959-1-rjethwani@purestorage.com>
References: <20260807183853.2288959-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable TLS 1.3 TX/RX hardware offload on ConnectX-6 Dx and newer
crypto-enabled adapters.
Key changes:
- Add TLS 1.3 capability checking and version validation
- Use MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_3 (0x3) for crypto context
- Handle TLS 1.3 IV format: full 12-byte IV copied to gcm_iv +
  implicit_iv (vs TLS 1.2's 4-byte salt only)

Tested with TLS 1.3 AES-GCM-128 and AES-GCM-256 cipher suites.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
Tested-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_accel/ktls.h    |  8 +++++++-
 .../mellanox/mlx5/core/en_accel/ktls_txrx.c        | 14 +++++++++++---
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
index 07a04a142a2e..0469ca6a0762 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
@@ -30,7 +30,9 @@ static inline bool mlx5e_is_ktls_device(struct mlx5_core_dev *mdev)
 		return false;
 
 	return (MLX5_CAP_TLS(mdev, tls_1_2_aes_gcm_128) ||
-		MLX5_CAP_TLS(mdev, tls_1_2_aes_gcm_256));
+		MLX5_CAP_TLS(mdev, tls_1_2_aes_gcm_256) ||
+		MLX5_CAP_TLS(mdev, tls_1_3_aes_gcm_128) ||
+		MLX5_CAP_TLS(mdev, tls_1_3_aes_gcm_256));
 }
 
 static inline bool mlx5e_ktls_type_check(struct mlx5_core_dev *mdev,
@@ -40,10 +42,14 @@ static inline bool mlx5e_ktls_type_check(struct mlx5_core_dev *mdev,
 	case TLS_CIPHER_AES_GCM_128:
 		if (crypto_info->version == TLS_1_2_VERSION)
 			return MLX5_CAP_TLS(mdev,  tls_1_2_aes_gcm_128);
+		else if (crypto_info->version == TLS_1_3_VERSION)
+			return MLX5_CAP_TLS(mdev,  tls_1_3_aes_gcm_128);
 		break;
 	case TLS_CIPHER_AES_GCM_256:
 		if (crypto_info->version == TLS_1_2_VERSION)
 			return MLX5_CAP_TLS(mdev,  tls_1_2_aes_gcm_256);
+		else if (crypto_info->version == TLS_1_3_VERSION)
+			return MLX5_CAP_TLS(mdev,  tls_1_3_aes_gcm_256);
 		break;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c
index 570a912dd6fa..f3f1be1d4034 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c
@@ -6,6 +6,7 @@
 
 enum {
 	MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_2 = 0x2,
+	MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_3 = 0x3,
 };
 
 enum {
@@ -15,8 +16,10 @@ enum {
 #define EXTRACT_INFO_FIELDS do { \
 	salt    = info->salt;    \
 	rec_seq = info->rec_seq; \
+	iv      = info->iv;      \
 	salt_sz    = sizeof(info->salt);    \
 	rec_seq_sz = sizeof(info->rec_seq); \
+	iv_sz      = sizeof(info->iv);      \
 } while (0)
 
 static void
@@ -24,9 +27,9 @@ fill_static_params(struct mlx5_wqe_tls_static_params_seg *params,
 		   union mlx5e_crypto_info *crypto_info,
 		   u32 key_id, u32 resync_tcp_sn)
 {
+	u16 salt_sz, rec_seq_sz, iv_sz;
+	char *salt, *rec_seq, *iv;
 	char *initial_rn, *gcm_iv;
-	u16 salt_sz, rec_seq_sz;
-	char *salt, *rec_seq;
 	u8 tls_version;
 	u8 *ctx;
 
@@ -59,7 +62,12 @@ fill_static_params(struct mlx5_wqe_tls_static_params_seg *params,
 	memcpy(gcm_iv,      salt,    salt_sz);
 	memcpy(initial_rn,  rec_seq, rec_seq_sz);
 
-	tls_version = MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_2;
+	if (crypto_info->crypto_info.version == TLS_1_3_VERSION) {
+		memcpy(gcm_iv + salt_sz, iv, iv_sz);
+		tls_version = MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_3;
+	} else {
+		tls_version = MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_2;
+	}
 
 	MLX5_SET(tls_static_params, ctx, tls_version, tls_version);
 	MLX5_SET(tls_static_params, ctx, const_1, 1);
-- 
2.25.1

