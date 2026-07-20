Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2C92F8E9E
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 18:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784571258; cv=pass; b=aG2aEZL0Ua85+1vkMa/nM+Z5HMNHaubLV5QIA4BTEycvuxExVWfUan/mjJrgK+DTUeOnQhykq9laQ35+5hGRTy/y4O11nQdHdzeg4aczqAPm5JIsv7MBWbvltT791BpSobI6swTDQFjQlJ5a4ZwVJeA0OUZmBu7TappNwModces=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784571258; c=relaxed/simple;
	bh=MoM3SUix+VxL4tI1A6QdAmDJIiPaAbH+OcVvVY++ClI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqA/Qm7kq5Z3CsGno8mjfuIUI8bv+5+niyEUxqssFl7LWCXPsC+8VoAaESVXO9ffQCzPw1VAX2ccvM1WtkgRD2i99UlREwHvfhDhqNomWLBdWh9fdv/fvJ81YGlM6YSss0M3Dm0okBsG7pIlXev92299VF0BroEaViLCJpLtxKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=IjuR1mAN; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="IjuR1mAN"
ARC-Seal: i=1; a=rsa-sha256; t=1784571232; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Gw9gsVlXioqhQzlYN/Mg8nYtfTJKLVGWNz5xchxJM2pailSupdHSSU8d+ly6UPFfc5HdGzlAo62d7yhIMWGiTk+kYQrAOK7JVqaUIyDtvp1x29uagC9xz7VV1uc3yqbD1g3EA8vJWyFrddloIsFFi6OaB6BnnYJUb+cDMeYo94c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784571232; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SJxqPj9zaGlWPM4nlGDQpIgEQMxyM7a2QhbaV9sOkHs=; 
	b=l3vQUyGgzktCSOf2NFripAwy8ySLfseu8sIfKajYUyEc2qoagCGSQ3MULxCAFUY3nFm2SJZVVp3ZYvvvE7r4uEZhwJM38mtfwRdSMh1C5ceUZnR4M4uuvu/uosPkhnMds2YhMh5ySn9x3fRGAFtkS5UzlgV69+Hk/f7q/niP1u0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784571232;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=SJxqPj9zaGlWPM4nlGDQpIgEQMxyM7a2QhbaV9sOkHs=;
	b=IjuR1mANiWN6quyhF3Gzph8z/o/92xqz0TYGwc2Uvch/hyeOxCBu64VQ1BO5OZNW
	dlbM0W04oAs7swRx9hvFMPCIl6o/fFgM+KooYmBKOBeKE6tt2NJQU8cJARfnzLevFg3
	K4Tr/ugqrfW3gTKwq3mIs2tFxeqmYLXWNttjCs2GAP2yIDcQni3ylM9PWlqNyTdml+T
	w633p81KVW893O+zIfEjfkLaPYSSyVU6kblnGLRk/aNCHKzO6pJECIrOFacMwMGy9WK
	IvwqwMZUwC6h+G9QLGfXC5gXrlmPX6iC2uDa1uhURmBbWyPQKUBt2gcQFJlayhhB+O+
	4XqG/sRGEw==
Received: by mx.zohomail.com with SMTPS id 178457123060835.55599237306933;
	Mon, 20 Jul 2026 11:13:50 -0700 (PDT)
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
Subject: [PATCH v7 net-next 1/3] ptp_mock: Expose ptp_clock_info to external drivers
Date: Mon, 20 Jul 2026 20:11:11 +0200
Message-ID: <20260720181113.3293-2-maciek@machnikowski.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720181113.3293-1-maciek@machnikowski.net>
References: <20260720181113.3293-1-maciek@machnikowski.net>
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

