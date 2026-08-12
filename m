Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8542B4B04B7
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 18:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786559863; cv=pass; b=TX2QFjBcKCUI8h82oH8aAinHZfAxBGEg8+hFKKH3fBHzEiEBCLufAyVb4zTmj7xyGPNnKZJj54F5TUsRw1bspuD13syTiH6fBMw15PziuS1eGjJFKWNYOAhK2ag0xRnVBdrost+W3hiBYx2CHd57w4yLdAdssLu2TQ5OAK3bka8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786559863; c=relaxed/simple;
	bh=MoM3SUix+VxL4tI1A6QdAmDJIiPaAbH+OcVvVY++ClI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jXXIpjtLfuGLQnKCrk29/O/oes/pl1SURQNm05Rg6MHlAOV0HZzvLh8a1htWa4NeCQTiEr6K+Q2kdQrYZwDTagSDM/Nzf+E7LsVqzbTXjlzu91garYsMuXFDWK2eV1owzyvOX8yRbkhFn865tT7tnKc58/+OBD2GnDpv5N3Vd5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=P5ErwRZM; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="P5ErwRZM"
ARC-Seal: i=1; a=rsa-sha256; t=1786559838; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BPQMM0df0SiWXKoNaZwlwr1SA6rhRQptxg0+9hpj3vkr5yLrVQUoFBAEkE3eHEGIqkakED5qURGAbWqp6h0aInogverp6SYIiYpN36dRVmBguMDy+sdVvheFs6y2QGoSzEwjhjQ/tW24P7jPDk8+LB00VdZcpzwQENizMMDPUrI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786559838; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SJxqPj9zaGlWPM4nlGDQpIgEQMxyM7a2QhbaV9sOkHs=; 
	b=J+xbO5PXwWZrirO+fQu5usz4Qqe7DDUSQRfdlnJdYW56rps8dBsjBQrbkYSaDig0nmqWLGDcFmvtNJeKhpgNPI2jsdysYRnOxymH8xn3Muie17OeUjNmPWgA4un/61bclxfT/5K4N1Kvo98DPgjswObNu8GUKVoHuC2cumpPfUc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786559838;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=SJxqPj9zaGlWPM4nlGDQpIgEQMxyM7a2QhbaV9sOkHs=;
	b=P5ErwRZMA2qDvWsjaNDwfDsEGkEVKd8pPe4fcYah7GvsDuLaxYupibC3QE72KlRN
	yo8QVkalGvcx8mruU3VEHQdnsvKJLq3FkznmaZXRZPgoPabarlPrVWXhmOry5XivlH3
	XRX2q7baARE3lHf/47v8c/q3psZBKz0xdf/Vne/xxAHzAcXji+mOpKxgNFOzZvMBiSy
	mi5kx8yfz8g3vhs/wz4T4ZGW7UnUv8P+HPPEHsOxzNnq56S1HvXDXvRF3Gu25cljqZe
	pSWv/EyQzfy9CpErtnmh4vcMNkQ39KmhWOZGrRAQ6REPwp/r17m3cCkPE+KLnX2TcEu
	nwFQhH0R1A==
Received: by mx.zohomail.com with SMTPS id 1786559834821148.3306653841853;
	Wed, 12 Aug 2026 11:37:14 -0700 (PDT)
From: Maciek Machnikowski <maciek@machnikowski.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	maciek@machnikowski.net,
	richardcochran@gmail.com,
	milena.olech@intel.com,
	willemdebruijn.kernel@gmail.com,
	andrew@lunn.ch,
	vadim.fedorenko@linux.dev,
	horms@kernel.org
Subject: [PATCH v8 net-next 1/3] ptp_mock: Expose ptp_clock_info to external drivers
Date: Wed, 12 Aug 2026 20:37:06 +0200
Message-ID: <20260812183708.312412-2-maciek@machnikowski.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812183708.312412-1-maciek@machnikowski.net>
References: <20260812183708.312412-1-maciek@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Allow exposing the ptp_clock_info of the ptp_mock to the external drivers.
Convert spinlocks to SLIS to allow gettime to be called from the netdevsim.
This is a prerequisite for implementing ptp support on netdevsim.

Co-developed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>
---
 drivers/ptp/ptp_mock.c   | 26 ++++++++++++++++++--------
 include/linux/ptp_mock.h |  5 +++++
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/ptp/ptp_mock.c b/drivers/ptp/ptp_mock.c
index 4d66b6147121..7a4e5f3274a6 100644
--- a/drivers/ptp/ptp_mock.c
+++ b/drivers/ptp/ptp_mock.c
@@ -49,15 +49,16 @@ static u64 mock_phc_cc_read(struct cyclecounter *cc)
 static int mock_phc_adjfine(struct ptp_clock_info *info, long scaled_ppm)
 {
 	struct mock_phc *phc = info_to_phc(info);
+	unsigned long flags;
 	s64 adj;
 
 	adj = (s64)scaled_ppm << MOCK_PHC_FADJ_SHIFT;
 	adj = div_s64(adj, MOCK_PHC_FADJ_DENOMINATOR);
 
-	spin_lock(&phc->lock);
+	spin_lock_irqsave(&phc->lock, flags);
 	timecounter_read(&phc->tc);
 	phc->cc.mult = MOCK_PHC_CC_MULT + adj;
-	spin_unlock(&phc->lock);
+	spin_unlock_irqrestore(&phc->lock, flags);
 
 	return 0;
 }
@@ -65,10 +66,11 @@ static int mock_phc_adjfine(struct ptp_clock_info *info, long scaled_ppm)
 static int mock_phc_adjtime(struct ptp_clock_info *info, s64 delta)
 {
 	struct mock_phc *phc = info_to_phc(info);
+	unsigned long flags;
 
-	spin_lock(&phc->lock);
+	spin_lock_irqsave(&phc->lock, flags);
 	timecounter_adjtime(&phc->tc, delta);
-	spin_unlock(&phc->lock);
+	spin_unlock_irqrestore(&phc->lock, flags);
 
 	return 0;
 }
@@ -78,10 +80,11 @@ static int mock_phc_settime64(struct ptp_clock_info *info,
 {
 	struct mock_phc *phc = info_to_phc(info);
 	u64 ns = timespec64_to_ns(ts);
+	unsigned long flags;
 
-	spin_lock(&phc->lock);
+	spin_lock_irqsave(&phc->lock, flags);
 	timecounter_init(&phc->tc, &phc->cc, ns);
-	spin_unlock(&phc->lock);
+	spin_unlock_irqrestore(&phc->lock, flags);
 
 	return 0;
 }
@@ -89,11 +92,12 @@ static int mock_phc_settime64(struct ptp_clock_info *info,
 static int mock_phc_gettime64(struct ptp_clock_info *info, struct timespec64 *ts)
 {
 	struct mock_phc *phc = info_to_phc(info);
+	unsigned long flags;
 	u64 ns;
 
-	spin_lock(&phc->lock);
+	spin_lock_irqsave(&phc->lock, flags);
 	ns = timecounter_read(&phc->tc);
-	spin_unlock(&phc->lock);
+	spin_unlock_irqrestore(&phc->lock, flags);
 
 	*ts = ns_to_timespec64(ns);
 
@@ -171,5 +175,11 @@ void mock_phc_destroy(struct mock_phc *phc)
 }
 EXPORT_SYMBOL_GPL(mock_phc_destroy);
 
+struct ptp_clock_info *mock_phc_get_ptp_info(struct mock_phc *phc)
+{
+	return &phc->info;
+}
+EXPORT_SYMBOL_GPL(mock_phc_get_ptp_info);
+
 MODULE_DESCRIPTION("Mock-up PTP Hardware Clock driver");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/ptp_mock.h b/include/linux/ptp_mock.h
index 72eb401034d9..e33188dec2b7 100644
--- a/include/linux/ptp_mock.h
+++ b/include/linux/ptp_mock.h
@@ -16,6 +16,7 @@ struct mock_phc;
 struct mock_phc *mock_phc_create(struct device *dev);
 void mock_phc_destroy(struct mock_phc *phc);
 int mock_phc_index(struct mock_phc *phc);
+struct ptp_clock_info *mock_phc_get_ptp_info(struct mock_phc *phc);
 
 #else
 
@@ -33,6 +34,10 @@ static inline int mock_phc_index(struct mock_phc *phc)
 	return -1;
 }
 
+static inline struct ptp_clock_info *mock_phc_get_ptp_info(struct mock_phc *phc)
+{
+	return NULL;
+}
 #endif
 
 #endif /* _PTP_MOCK_H_ */
-- 
2.55.0

