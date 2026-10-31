Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793465800;
	b=kvBu1DiIpYhJUBglvNvoxD7NZ+wZwwlwg5PBGOGcEVklVHD2B9RJB4kZCGqQkalU4nIx
	 Zx8LVtSotVjHK7AKDfNFfzzy9ZUzjHcDUzNGnQtlhBYdYGbTmZE2ylVk9BG/eYYRBTEdZ
	 RU9zV65Sv7nGsvDdXDLXaFmTHIHqmhJD0/tyDipzxArl/GDaS0My40pJNGMYpB3QWFc+K
	 ekmH5EIk6iEBI7i5KgOAQ5gdeBi3cTvBJHMI+Bpi6BuCEKEY3GP2qACmnrG8SEue3Nl7R
	 8v65mohAw2YOadj8DDsK5Jrwi2rpNdEonePgYWQ5tXAnmPlBoGK3rik8MwEMGxHrOoQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793465800;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=/gm11AgcMVDtH/k5ZLBxRNaHsELsWXQSa84+hualrSs=;
	b=qpnnBeuI8DnPQ1WZowfSuxyhnpmzYRtCxAyyhLR4yyGVE90k7gjuRMwp5XEfy74Ye2QJ
	 HZEcvvRvX7sAsaT9A23quGzW+1x9+cWz26MRthY2mz2WXPAXA4duxRlM0x+q8HQqt/mTH
	 DTV9O8FtZ3pdT1/TEjPMgMPZxBfL7DvqlUUcUY4gP/Ul3QIdj3b0uK2P4OntRCpmOr3nA
	 BFTaOIKTtnnu1zjnK1UyD+bhaZCIRl2fahMFhUAZ2MridsUNzhI1DQyUcLsrFVcqSU7Rf
	 FhkDIDNxXe6K9UZDIJ2W+sLlHTGz8paEPytdzuyfIEObGCYenQCs8rq6iVy3wx1B3WA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=machnikowski.net;
	spf=pass smtp.mailfrom=machnikowski.net;
	dkim=pass header.d=machnikowski.net header.i=@machnikowski.net header.a=rsa-sha256 header.s=zoho header.b=BQdvH2ZI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
Received: from sender5-of-o54.zoho.com (sender5-of-o54.zoho.com [165.173.182.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFAD606A31A
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 16:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FFAD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=machnikowski.net header.i=@machnikowski.net header.a=rsa-sha256 header.s=zoho header.b=BQdvH2ZI
ARC-Seal: i=1; a=rsa-sha256; t=1793465777; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GB1nLVkomHS8y5QoNipdxNlBhB587EZTScSBObc31ipHR2bE8WW34R7kcypTxo3uJINe6fvuGZ11hJWWagH1wqbVcvMdAsXCoyIFnwQkdKbPHU2cwKGcoqDFB77542NtlWSKjuEmh2+VMTDu7gVWToiFeA2pzc8J/UuZiErDrCc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793465777; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/gm11AgcMVDtH/k5ZLBxRNaHsELsWXQSa84+hualrSs=; 
	b=Q/f2Iw0tWLGukCSguWFRVRdhpr1MmsRXGoSHK28OZpDZLyV80wCzq9mlZi0DkspalukZipxX52RhaDA6OG+82RK/axgaT8TGnlyLzGktwMTBnsW1+9X6+uzHCLeSSURT/cxsXm8rBjn3mnFZ64KsADkli6Qm29Vq7OYaaeuJAo8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: a=rsa-sha256; b=BQdvH2ZIVAFalPRXqylRGVOj+pv0gy36X9g+qGIJsqizfq1tIAPfQ5NE0nvN+mtpi9ikcFPRCwqslyncw12g9ZS91JAhCI85dYNdlgEd1isdm/TY4TbSvBnwaW79CrPd5PH0gKuHQmnMj0a+pNh722Cvyl2jN3hZ52FPpbp3sm18OjOS7ROkt4J6M9jLE9bLPyWtR0e6MClou0g50SIeSeFdLaeS1mpWApSduzD/IpXDy0FKXNYmIFAXVXMHLq31ZHfr2mCw1dTb/4cBVsmObo9RcBHdh8GE+r7XoaMuDCD4Zk/bZrOSCN3xGtDikTZqm1hbENj40e9BXZYb7oDqrA==; c=relaxed/relaxed; s=zoho; d=machnikowski.net; v=1; bh=/gm11AgcMVDtH/k5ZLBxRNaHsELsWXQSa84+hualrSs=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179346577489898.86769602174502;
	Sat, 31 Oct 2026 09:56:14 -0700 (PDT)
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
Subject: [PATCH v11 net-next 1/3] ptp_mock: Expose ptp_clock_info to external drivers
Date: Sat, 31 Oct 2026 17:28:02 +0100
Message-ID: <20261031162804.1893-2-maciek@machnikowski.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261031162804.1893-1-maciek@machnikowski.net>
References: <20261031162804.1893-1-maciek@machnikowski.net>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Allow exposing the ptp_clock_info of the ptp_mock to the external drivers.
Use spin_lock_irqsave() in the PHC callbacks to allow gettime to be called
from the netdevsim transmit path.
This is a prerequisite for implementing ptp support on netdevsim.

Co-developed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/ptp/ptp_mock.c   | 26 ++++++++++++++++++--------
 include/linux/ptp_mock.h |  7 +++++++
 2 files changed, 25 insertions(+), 8 deletions(-)

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
index 72eb401034d9..8f5d248db65c 100644
--- a/include/linux/ptp_mock.h
+++ b/include/linux/ptp_mock.h
@@ -10,12 +10,14 @@
 
 struct device;
 struct mock_phc;
+struct ptp_clock_info;
 
 #if IS_ENABLED(CONFIG_PTP_1588_CLOCK_MOCK)
 
 struct mock_phc *mock_phc_create(struct device *dev);
 void mock_phc_destroy(struct mock_phc *phc);
 int mock_phc_index(struct mock_phc *phc);
+struct ptp_clock_info *mock_phc_get_ptp_info(struct mock_phc *phc);
 
 #else
 
@@ -33,6 +35,11 @@ static inline int mock_phc_index(struct mock_phc *phc)
 	return -1;
 }
 
+static inline struct ptp_clock_info *mock_phc_get_ptp_info(struct mock_phc *phc)
+{
+	return NULL;
+}
+
 #endif
 
 #endif /* _PTP_MOCK_H_ */
-- 
2.56.0

