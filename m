Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C233848550A
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206888; cv=none; b=W/zwWY7DBjZtcncFtTHB7nbbhno5LYsDKt02Wa72uVZORj74K/Ke8Xy+H1V6Mzejv+w9YDu3Owtr95FOKvs+NszWY5DMF16KOdxjhG6pWiSUpHngB4qrJx0sgq/q+9bA3thzqdlAbhwyIREwXyCpsLR/TDpIK5XnnTFYLph6tGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206888; c=relaxed/simple;
	bh=akgxDLCMRWnju1F8nlTi8ruGP54ydtpCtXeCGsNTtP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uMnuAJeszR5Uw8IKOjqDAkufYbi9jKXlOqzPj9r4QcPAAb6DpeK3eVTxMEeSJBBnJcquJQyC51cJxHi2ZQVp+qu4Q+Kztx7DqN91XYRxg9CuhkdM3knXiY0bsjAT1QMcW9cXjT0sxeld10mkTQx5DCQxMaahNhM5SV55Kkzna1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdlMj8jl; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdlMj8jl"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a11603310fso16623205e9.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 06:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791206878; x=1791811678; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2UiFZMjxaNVOcwpMoTNUMbszzfHwtYL0qU2Yy5cm+FU=;
        b=RdlMj8jlCxNGEq20K+2pFddX44VQ7qcDVW0iXNleAhb4e2gJiZYizJJM2Mz9LNYywy
         uYnf54aD8sNAaJWoxfCYzfKaA0zIE/9838Xrs+HxJtnyQyoGDRrznPv9u8ewAdnx4hQe
         NIJ7cS/r1oAtCYbzQQa1yOOSCpSFaotjc7s3wp9Q/ZKQTsnzEvc0uCC5bsGbSGP+WcsH
         SueTPeKOcVHT2IrGDvcDko5h9u5GhOuLf1TsbQt1tPd2ZFr4IIGW5ecPMjFCFaNwyDi5
         UMz3JzWAf0bYquqPGYNx3tsfAcNgRPtEzupYedyrLdVqfTafHbC1nApl5sY6V7yAE4uH
         7ncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791206878; x=1791811678;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2UiFZMjxaNVOcwpMoTNUMbszzfHwtYL0qU2Yy5cm+FU=;
        b=v/VMrBVwHE973hES0ojweFuiSH+Xi7TPaT+ddBnEcJAoRaMkVRRRsZZ+kQ3VTsJPO7
         lKdnzyuhiEYgbgOP+vpsF94Leu7K0Zv+qhRwlt6iGxc88EaxY+063XCbSaFXaewz1VxI
         /p2QpeZQaA6S2BdzowQSGv89gDgOE3gecT7aO3hl9TUqSSoAYa/TN1Jstu8KLjCehnag
         4kBgZI/WvKP/BoKlvoDAUNLBb3VT35ef/6qhFKVUpxKDaPjTaohp5U/Cz6ES9i5LMPZ4
         PInNGmnze+JVGwCvGIA885IxEYoG+C6ncOtTucE+m+ubzjEIHcj+FhFzF96aI1L74qHC
         X+cQ==
X-Forwarded-Encrypted: i=1; AKwUvBzvskfbQ9i2PYC2UKpFpKqS5rQs2loiprJh9NDmNtpHSU2Y9uuv2r+8FvL3rhcX/7W9eznSMyQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lhBl3+ZRT7427SNj5dic3GCcJvesm/u8nEn5ocZa4AwLRyU55k
	sLDNKSBchlgSjgEcbxWZ6bwjNmSzARV40B6Byxh4t0dtAghlLK0aWz7C
X-Gm-Gg: AYBFou1GLfXubT1PHCBX2n8d5mr1RHjF1S/4VsU0w6l1u4ExlJLewGLpKFL12LjD7os
	oTtVDOaNZWP+bG5gd8Gj/kQPRA0E8spLD7ifCsa21V/YeA0PrBvxyWksjnQL9ZBn9A1V+wwfsk1
	uvP3M3YR5DQrYjBiU6qBaHJGGwZNjQF+sRAS2qYor4muhq4uLp+UFB2iF/qO5KDESJNDueB1yB3
	Wm7FZlkxw+Twu/XVsaIuiC4lhNuQGpAp/uHeI4sUGX59aRpczyhwIUOE5EwjOGEejTjjiE7Gj9e
	zDToerRBsnGY6nwBS3OAKU5aGxFoOpX3PwtSZfeN4wiTwLY6p/9W4ZMRGv0s89mgmbgMCl48sOE
	UxP1P9aXMQRIWxL/Ax1hQlCchDhxhalQOi+7gBvsW93SF+nQXoG/zZULj5tybxddKjzdHvY32qZ
	oIhtXNHKqz/U+Dyeb30apLwKsekxA4uiFWZutt/1feJsvS5hSdNMWOcK90osOoTV2FrL2U
X-Received: by 2002:a05:600c:474e:b0:49f:bd3c:bc1b with SMTP id 5b1f17b1804b1-4a02759b67emr197566455e9.22.1791206877810;
        Mon, 05 Oct 2026 06:27:57 -0700 (PDT)
Received: from metepc ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a16d6295f9sm260315305e9.14.2026.10.05.06.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 06:27:57 -0700 (PDT)
From: =?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
To: oe-linux-nfc@lists.linux.dev
Cc: david@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
Subject: [PATCH net v2] nfc: nci: fix out-of-bounds read in nci_core_reset_rsp_packet()
Date: Mon,  5 Oct 2026 16:26:28 +0300
Message-ID: <20261005132742.324374-1-omermetekaya0@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The skb->len != 1 guard admits a 2-byte payload where config_status
at offset 2 lies one byte past skb->len.

Fix by guarding the nci_ver and config_status accesses with an explicit
skb->len >= 3 check, and restoring the original skb->len != 1 condition
around nci_req_complete() so the NCI 2.x reset request stays pending
until CORE_RESET_NTF arrives.

Fixes: bcd684aace34 ("net/nfc/nci: Support NCI 2.x initial sequence")
Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
---
Changes in v2:
  - Preserve the original skb->len != 1 condition around
    nci_req_complete() so the NCI 2.x reset request stays
    pending until CORE_RESET_NTF arrives (reported by sashiko).
  - Fix NCI version labels in comment (NCI 1.x = 3-byte RSP,
    NCI 2.x = 1-byte RSP + NTF).

 net/nfc/nci/rsp.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
index e20df7fa0829..8226d09c99a5 100644
--- a/net/nfc/nci/rsp.c
+++ b/net/nfc/nci/rsp.c
@@ -32,22 +32,15 @@ static void nci_core_reset_rsp_packet(struct nci_dev *ndev,

 	pr_debug("status 0x%x\n", rsp->status);

-	/* NCI 2.x reset response carries nci_ver and config_status;
-	 * a 1-byte response is the NCI 1.x status-only form.
-	 * Require at least 3 bytes before reading those fields.
-	 */
-	if (skb->len == 1) {
-		nci_req_complete(ndev, rsp->status);
-		return;
-	}
-
+	/* NCI 1.x: 3-byte RSP; NCI 2.x: 1-byte RSP, request completed by NTF. */
 	if (skb->len >= 3 && rsp->status == NCI_STATUS_OK) {
 		ndev->nci_ver = rsp->nci_ver;
 		pr_debug("nci_ver 0x%x, config_status 0x%x\n",
 			 rsp->nci_ver, rsp->config_status);
 	}

-	nci_req_complete(ndev, rsp->status);
+	if (skb->len != 1)
+		nci_req_complete(ndev, rsp->status);
 }

 static u8 nci_core_init_rsp_packet_v1(struct nci_dev *ndev,
--
2.55.0

