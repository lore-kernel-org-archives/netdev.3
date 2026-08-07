Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC61E379C47
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 18:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786127997; cv=none; b=Ep06y7xFN7oocTVWlnP/J7txrKu8wGdJdufPjffhJbm5ekTZJBM+L0sBlFCEeZ3fi0EcSw/wCO2RxEt/VRCoBxmZlnhF6AQ3YLPzLqK02SNE+nOkxn0rxjDsXG45ZOiHaEV7C7Ra8KavMtwr+NzMNV7PD4xkUo82/D+weuDEyYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786127997; c=relaxed/simple;
	bh=maW/AdYWuK8BsDS8KSzSgHXYaUMsPA074OQ12rZ89jQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E9KiJ7maE7dQSbDc16buMo2C4q8QPLGvndeXl2BCe2URBgD1bFXl6XqQ8byAAnhCWhB/0xqQEHs3MHOVRj46YRpV4qzE09dwH8+pmTcgg0klGAkFTKOtxechNNqAutVwv3vN47dSZcJek/SB0t4fJSkQ0S4YZGfY7l1uDGvUtCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=JGdOxLQY; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="JGdOxLQY"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49553515a8bso55579515e9.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 11:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1786127994; x=1786732794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qtDiVIInccujlIt2Sqa5fOCnM6byWdzYUVqLrms+bSo=;
        b=JGdOxLQYIAf08iIXH8OXov3c2MCJhavqrQkD2FFn3I0S5u54qmyth1y9i+BFjbNcrq
         GzXXRpladfrP4+JRekhIAM0V5KPo/hb8kf0AVScUmxqR3g2desnt5JchGbw8/JHC8ibk
         QjBVt5TZOZ5JvAE94ih1KPz5Z/IZnjBU6XKIk/TZKgcDvQunMErE+TaKJ/l5xtBm9IpI
         tlkQJscd4+/Yd8FPCirZstVEr49k/lQFtDjxzTOhV1WGD9TVi11K5CEHmMVUXT3ZXCto
         GabnpE3mrcdTE9q3bo19uIbdztiU+PJ8J8AFC3+TKxZXIReWChjcTzG4tpHl48KQl07k
         ahww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786127994; x=1786732794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qtDiVIInccujlIt2Sqa5fOCnM6byWdzYUVqLrms+bSo=;
        b=NTsTea1lMX5ZWLv/ZbvX/g6THWUHmLwaHL0sZJKVEIlUdi9pXrK7qts4d9n3lJODnk
         okGlIEAVZZTINajb/KK6JhEgS8hOgISXAvLXz4irN8jUjhH7UU74BMBTjsDRr2JnX4jv
         BPJffRkNV0E9rVVp0MukFTEtQd6FtUb+nE+uaf5N3TfxBXM2GXi+UdYY1ZKNVcA6XT0S
         uGXXoU5Uo6aTkAEyqJGWtZ60KdZHVNgf99rOObB4ENJdt+MKcP5bJ78CjTgynyCQdTjd
         HiEJyritdN6VYA+MVEJ4Jm97svvPKYQnh8hkpzzDwD8qn56ZuoWcAza7I75kcpcOg4WZ
         Yohg==
X-Gm-Message-State: AOJu0YyvzUWc0ndoDlfgEbdTq0Lx9q59viqzkWn7Jw159YkJlvpYonwI
	vHpnKUeLyNXvOT3xJ6f2GviQSQwEVb8L0kYqWnSlXRgHhT2d6adypw1lih/HBZSoq1pMn+pHBnN
	70AZeuN14kgypZxx+HO+J+9+cFZi2SxKdtmPrZhhtK5E21758ZpFizSDDWn9WSNdKdnSIy9jBIs
	9zx3etgieSt2QDja1+MhEdTV6QlHXJlYnknoSjeAhQkrbfKWU=
X-Gm-Gg: AR+sD101PH7LAGoAKjkA2wG2CMUwEY+lTy2nA1VKY+QbwiCPrNSQzVCX0Ste1t467NN
	+3J8AmgcRFLhykUrkljWyMu/Fl84tq/QTVREB25JdtrBrDYlIRw7wMmMhVeIMrYTmMWYiZVD2Ly
	NHebNb0yBXYtOeiArZhyOYss8RPLa4VvHLrEZdGvrAUrZlptaXck/d2v+A0qNkBzWGz0lnXAbBV
	nvmnSD4MbT+BN6NOX+U8j4sQ/TngDMcSKjlS7Vh7Bg6/CppK/F21Zwysujud0cd+1cmqunx4Sof
	M1Gn+hw/LtwS6j9BSC2+l6VOYWZM5HgW35K0Xa8jC2L6dCoKMGYWiBiUMEn/3J+rpUH60mo8SM9
	CMK2gJiMRJ8q+orf+aKfCB68w0CWco0KSqCONk5nBeIoM/ML6E9RhAbnfi3P9/0dJyf+PjOtjY0
	+mSIV6dVMNXUVRRcJ9oH0hruWlwwBIfkutC968qLFx913DRAR0Jimac+A8T3/sH96/hnozCBRYZ
	ujxUwO2YDHr0IMLOzSSyp9IvAlawrsFMvid9LTALXzCmA+9qzMEVqGcmvx2oeW6YiXZYShB9rQK
	ZaA+I3idD/z1BhFoWv65yeyYcgAHzIIgqwWU14WHZLx8fVA4vWJswR/dANpeUq74oNOkOYTCHM/
	zssocGlfl5DSntfArxg==
X-Received: by 2002:a05:600c:45d2:b0:496:ca1f:a428 with SMTP id 5b1f17b1804b1-49959e42ac3mr136489715e9.19.1786127993990;
        Fri, 07 Aug 2026 11:39:53 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-499541b86f5sm166106135e9.0.2026.08.07.11.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 11:39:53 -0700 (PDT)
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
Subject: [PATCH v16 01/10] net: tls: reject TLS 1.3 offload in chcr_ktls and nfp drivers
Date: Fri,  7 Aug 2026 12:38:44 -0600
Message-Id: <20260807183853.2288959-2-rjethwani@purestorage.com>
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

These drivers only support TLS 1.2. Return early when TLS 1.3
is requested to prevent unsupported hardware offload attempts.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c | 3 +++
 drivers/net/ethernet/netronome/nfp/crypto/tls.c                | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
index f5acd4be1e69..29e108ce6764 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
@@ -431,6 +431,9 @@ static int chcr_ktls_dev_add(struct net_device *netdev, struct sock *sk,
 	atomic64_inc(&port_stats->ktls_tx_connection_open);
 	u_ctx = adap->uld[CXGB4_ULD_KTLS].handle;
 
+	if (crypto_info->version != TLS_1_2_VERSION)
+		goto out;
+
 	if (direction == TLS_OFFLOAD_CTX_DIR_RX) {
 		pr_err("not expecting for RX direction\n");
 		goto out;
diff --git a/drivers/net/ethernet/netronome/nfp/crypto/tls.c b/drivers/net/ethernet/netronome/nfp/crypto/tls.c
index 9983d7aa2b9c..13864c6a55dc 100644
--- a/drivers/net/ethernet/netronome/nfp/crypto/tls.c
+++ b/drivers/net/ethernet/netronome/nfp/crypto/tls.c
@@ -287,6 +287,9 @@ nfp_net_tls_add(struct net_device *netdev, struct sock *sk,
 	BUILD_BUG_ON(offsetof(struct nfp_net_tls_offload_ctx, rx_end) >
 		     TLS_DRIVER_STATE_SIZE_RX);
 
+	if (crypto_info->version != TLS_1_2_VERSION)
+		return -EOPNOTSUPP;
+
 	if (!nfp_net_cipher_supported(nn, crypto_info->cipher_type, direction))
 		return -EOPNOTSUPP;
 
-- 
2.25.1

