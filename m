Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4511B399CF5
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 17:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786642696; cv=none; b=KprBMCTTuIKoVYJlq1uc88l1jcdBHxK3a4T4dqdFZCME0NUlrG1XadrvOwe9gPVmkqmseVKJNmJyHgvsjEy44d7PflCAlBeSKwWC2Y6Ubq7u2zzKhlLRZqtHCQuG1zppMoWrlEeefyyuGBIbMQftgNgY9DWh+wqZ1EN4H58sF4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786642696; c=relaxed/simple;
	bh=GeJKyQhEjxucbTah049sAwM735AMlWpxeAb6ZnkGHjg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BRHWEES/rtgdlG1H8Mxad/k9AG7p5QvQ+Dk7UPLsHmTFVQle+vth8OPAjmoAPvjiku/cdB+CazCXg4a/6lbnf+mpXd8Dkeo5HlZPDAngQNMwU01K9EnzdSGvtzDOxlebJ2Vqi8i0cOyFK7gDUl2KY8S4IP6B/jWChD6QTxhDKh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjBEjZWm; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjBEjZWm"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a17cb94b26so72208a12.3
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 10:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786642693; x=1787247493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JfAvMGEbSBbRqdooleGngqLapQ1gPAZG8MmTQGDG2xY=;
        b=WjBEjZWmGMqcYk0ZoxIyLI87JtNjnCYeOZSikUu3dJHrwGBNuzG0CSRYPktxoUrF67
         Hq0IkuAff+YyHu/pTWS3fM5/pDF8RmeGQk3nXRiHpMGvcp82JPm+fIYdPk4GNwN61XwY
         vUTQektMha5dM7rVUm/SoLvVzCNO6OioCvLNmPr93lLa+1gNEKWSeFYQPrkXsQ9hi0Jl
         z8p4IjcnFE0Ezok1lLdOBBMxDFNiYcUvLWo3c9dLwq+k80zej+Yvcxv6hAV/PBsS/zJ1
         z7UBGLnOXX2EE8Jv3b3PKX1p89i8NTLayfmCMnHeEFBUsMW5vcSx3iKsiwvmTfE5UGpd
         QKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786642693; x=1787247493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JfAvMGEbSBbRqdooleGngqLapQ1gPAZG8MmTQGDG2xY=;
        b=IV+vgMat27OfhdvZl2vaPAvUn3UyjJu17Pfibp6thjhoQaW5VT1/cIl3cgnLxsVymX
         w6k7Wv5vr2OXXioCqLehgl0V6q0w5XxY7p1wCMbyUnL702TJjSMOpxZyFudDgtCeR9la
         ljVyB9pDp1V08c9/sl4CNZ00Zu72qmzSNkU13AokQAAUh49YMux98yOjAcTDWS9knl/L
         UZNZDsDBJAAHWYWYCdBmcKWcHGpRJJyytASihj/sQFeDIrDIbBRx80rxNI32sxSthxI1
         TTwhe1dBr/DB0Ga58LNytTe4icSp+0SVx9oVkqkC2SJFwt/gs1p3832TKL8VGc/PqY46
         T//A==
X-Gm-Message-State: AOJu0YwV1HKog1lvAic+XcOuX1ZsQtyX1z4iqHa1cB5Q9ErRGaXPisPV
	Ye4wd5mtoG7iVqwNnhUiisRCE52bakELZKO/PgH2UjaB49o4PogM+7g=
X-Gm-Gg: AR+sD114vK/UexBYIwDP/AIPYdd/B9/6tIvpek6/DC5C4zCX7eTzpwvOYOapLy/t0fn
	icjFe16Yd562YmJMdduF3+l6UegnHRpj8OrYYuSXtySx+CDlaereefVpdHCswqTuLAAWhQ4LiIn
	zQ/IdNHeWvH0kJzcuZ6N1H7f3FWoA5y25epf4fmmD5EnpCAz6ctFKwAhU81qrfo7fAivvUXCWgv
	LbrfOxVjM8hO68BKtqhcmb6sg2VjEkqw7bLg8Hvi/QSFPCmXHhAGEYFxPVYq63E5R7l9Io9u0tf
	7m/Nz8r6NGkhu1RQMOukUGabSUbhMZN17UYGnuCGH5WFdXuTY2tFeIFUX6sE5D5FIymN5jVsWk6
	pMQNapiVJ3Bm9fSlVwAaSQ5U9fXlqVb7XQHWFBYvqK1gU4VmSntLumfqxvK3VQusdReStqBwysB
	+9UKJFQLvnMpCadkkMq8Hn0fdHlAeWYUv2BCXLOPlfYz2aXvVwWSfR2h1MfuIenrLhRgMd0SGGL
	NARuNtP+9yb23L0RowkXZu0ZEEFZeH39WxxgQ==
X-Received: by 2002:a05:6402:390a:b0:6a1:da7a:917b with SMTP id 4fb4d7f45d1cf-6a38a9972b6mr52128a12.20.1786642693249;
        Thu, 13 Aug 2026 10:38:13 -0700 (PDT)
Received: from arch.tail2fcf52.ts.net (223-143-146-85.ftth.glasoperator.nl. [85.146.143.223])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a37f8a3522sm1217468a12.17.2026.08.13.10.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 10:38:12 -0700 (PDT)
From: Mark Sercombe <sercombe.joel.mark@gmail.com>
To: cooldavid@cooldavid.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mark Sercombe <sercombe.joel.mark@gmail.com>
Subject: [PATCH net-next] net: jme: fix typos in comments
Date: Thu, 13 Aug 2026 19:36:34 +0200
Message-ID: <20260813173634.461011-1-sercombe.joel.mark@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix several spelling mistakes in code comments in the jme driver:
These are comment only changes with no functional impact.

Signed-off-by: Mark Sercombe <sercombe.joel.mark@gmail.com>
---
 drivers/net/ethernet/jme.c | 4 ++--
 drivers/net/ethernet/jme.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
index 25ec5f757c68..31affb8e270a 100644
--- a/drivers/net/ethernet/jme.c
+++ b/drivers/net/ethernet/jme.c
@@ -826,7 +826,7 @@ jme_setup_rx_resources(struct jme_adapter *jme)
 		goto err_free_rxring;
 
 	/*
-	 * Initiallize Receive Descriptors
+	 * Initialize Receive Descriptors
 	 */
 	for (i = 0 ; i < jme->rx_ring_size ; ++i) {
 		if (unlikely(jme_make_new_rx_buf(jme, i))) {
@@ -1740,7 +1740,7 @@ jme_phy_calibration(struct jme_adapter *jme)
 
 	jme_phy_off(jme);
 	jme_phy_on(jme);
-	/*  Enabel PHY test mode 1 */
+	/*  Enable PHY test mode 1 */
 	ctrl1000 = jme_mdio_read(jme->dev, jme->mii_if.phy_id, MII_CTRL1000);
 	ctrl1000 &= ~PHY_GAD_TEST_MODE_MSK;
 	ctrl1000 |= PHY_GAD_TEST_MODE_1;
diff --git a/drivers/net/ethernet/jme.h b/drivers/net/ethernet/jme.h
index 860494ff3714..83a2f8ef6fda 100644
--- a/drivers/net/ethernet/jme.h
+++ b/drivers/net/ethernet/jme.h
@@ -465,7 +465,7 @@ jme_napi_priv(struct napi_struct *napi)
 }
 
 /*
- * MMaped I/O Resters
+ * MMaped I/O Registers
  */
 enum jme_iomap_offsets {
 	JME_MAC		= 0x0000,
@@ -660,7 +660,7 @@ enum jme_rxcs_bit_masks {
 	RXCS_WAKEUP	= 0x00000040, /* Enable receive wakeup packet */
 	RXCS_MAGIC	= 0x00000020, /* Enable receive magic packet */
 	RXCS_SHORT	= 0x00000010, /* Enable receive short packet */
-	RXCS_ABORT	= 0x00000008, /* Enable receive errorr packet */
+	RXCS_ABORT	= 0x00000008, /* Enable receive error packet */
 	RXCS_QST	= 0x00000004, /* Receive queue start */
 	RXCS_SUSPEND	= 0x00000002,
 	RXCS_ENABLE	= 0x00000001,
-- 
2.55.0

