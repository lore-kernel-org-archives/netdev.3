Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BFD4AAC41
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 22:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789685106; cv=none; b=iPQXNUZKyf/galsCfO1IT2VaUxTkoFozbn3vqVWZlmx4KN9yj7Qor07inQlxx5oKLVzQDbJ6yUfeh8ZO7yO3I9PAZqaEH+a5OzYmOwyHkOgbVuJIRGYamhdrEkT/WfENPNOBWJEek3VQB0P/ECXIY3MEUyFmdFQ0LMz7DQn6GHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789685106; c=relaxed/simple;
	bh=dbFEtAs657aOaXzCVFnrqGB3ssOLGeqdbaERb0Ntr9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dsxXerMnOxYXJgk7kPOAWU/dIoP6boskEi5hTX+xT5mq590k+HKaPUN5viniyOyB/THoue01F92CeW5ieufjOkGK9OihSTdgSf7VWULlioXzz1oSJalQbZCLt8aRYXrT41M9Z8Wpa2yTR2TiBbCKyu4VWJXRR4Co4y0QlUe/ImM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=a045R4z2; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="a045R4z2"
Received: by mail-oo2-f41.google.com with SMTP id 006d021491bc7-6b1ae6b200fso74043eaf.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 15:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789685103; x=1790289903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eqrv5il5QtNhMEbp6IcbgySExjwUXtCImrzPDQtxd7Y=;
        b=a045R4z2nPx7bmh/kSXbjIRKwnh4WCvoyeZf+QyuTpdGb6BltZX7D4koEH/DKYJyFf
         24oIUlustLb/oK4ozNv7BGxHzNORYVKQmadLm7lw4Kbt0sSvHnpqKKvLwSgp0c0FvdNQ
         BPXT4xcwPjO3SagwvMregia47SeoepQTb5EwSTLkc5/lZDkTQX8uvaoa4FzwGDQHwQWw
         LGQF+S5HkQ5evflIv30nBpGLr1nGFK/YaInGV19drPb2RFby5dp7sY+LBAv8TAgsMz+u
         GKPC+nDz1wB9Xtk69wgwmQPqFHS7V1aeul5YbtihynLXEr3OSblkxdvftShHBUb4O1kf
         vlVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789685103; x=1790289903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eqrv5il5QtNhMEbp6IcbgySExjwUXtCImrzPDQtxd7Y=;
        b=OxadlxDl03KSrWVd0w/Vfc/f4w+qv5/K316kyO42djJ0wOa7KkqrZsc6LxbJ1S8QfF
         tkFsFbhlqnhJw3nZ/j6vORNIm/bYd9O15U5jHEPMPaqpR6pRoj5seM77KaDRoLJUMeof
         sum1frtfoRkT5z10wRdcs0ky+QYt8xXg4XGKSWd7XBIkui7N+f30jBgAAY58I0qBvlpg
         eK0PXZPVa+OZ6EfreYeA6rNbjn7rFg0xpNsC9OUSQnlddukLrEG7swLfdZ2pFMp5BU/s
         O7/urYfjHIxAN1KtHwUL2VLLPbxHIA+pjrDEEOlIQ26m1HNbxhG452/cNe9+qUNiCs+0
         ASmw==
X-Gm-Message-State: AFuF++mVd7xnZesSPKOPqcLS73H48uoQQU42JXpJh4cGnRYNSXjTQZZW
	nbUAHaIVgpoDmtn0F8Vh0AjofQPS7dWCUS9CHL8oEFOJBq92phjuA2U31qTmEwGu2xOQznIkt+/
	nC8ODX7BJffy/L4D1FL0hxK+acd6t1onVxc/6YDCOgHGSdRU8X+Ept4ivEWbbVfNg3u3MrPsVBO
	k29t5QdppsvdTOPesSkkooon56CcOrH/AOAKQfRjyyyEKVOWg=
X-Gm-Gg: AYBFou2qvojavRrF+VVLypueGL8VatY9AqoqvYewaI6MNY3jLuPWWYSrYxV7cklrHl4
	PXDJ8MQGaUI5c43Fo3grFwdreIujq1rvXCKH6XRWD5orvWLOKYoP9mzAGoFYunCIVqw/qmMksLc
	dhmseFFnFXa4jddFxbf0rhY/ddwMM7bDEXsC3IcPS95daKUw3AptCSknma0hOGpjSQ5XV0qHiua
	mm0TAObgzvgbWYmWbW05wSHFN5l39K9dvzmwqxMqc8CJcIJtpSL0dvhuYNCz25PYPYkW8z9NcBR
	pjbqABoqxlCY7yjxXBdSLZzbTEJ4MI6J3ZXDn5bDjfpqJzDyKVNnZPAmaLlPeDnJVllX8IYZjpm
	ehqodqpff4GijoVZuorwWOmDcEe8fYPwysKoI858G6Vs4eqRRDEPkxZrsuSEbET/65uTnULdK8+
	XXemxYetTGcidP/vDjeRqu1+XLVNRPXea/uudg082fV8FLT7TQy3WJzm3jcPpW25yc1EIdYjNGn
	F7B460oy6VzmHVBpegJDfaUPJCk7qy9D05o1g9uvYPtr5JZgfKHWP6GA7c/wbCjQFP59GGfwI7k
	IDY5dOTuEJGKiIBzpbNoXKKYx6ZqMr2I8KyIOrlAkhYEdYZxugxCUvA9fazwFVHVGfOyF0wK9mM
	XAFbn8xNpGDVOpMw+Dw==
X-Received: by 2002:a05:6820:4c08:b0:6b7:46fa:1692 with SMTP id 006d021491bc7-6ca9be5036cmr549025eaf.39.1789685102220;
        Thu, 17 Sep 2026 15:45:02 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-4870ac16ec0sm88605fac.5.2026.09.17.15.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 15:45:01 -0700 (PDT)
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
Subject: [PATCH net-next v17 02/15] net/mlx5e: add TLS 1.3 hardware offload support
Date: Thu, 17 Sep 2026 16:35:13 -0600
Message-ID: <20260917224355.2288021-3-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260917224355.2288021-1-rjethwani@purestorage.com>
References: <20260917224355.2288021-1-rjethwani@purestorage.com>
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
2.50.1

