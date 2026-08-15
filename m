Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B11C37F8C7
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 06:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786775539; cv=pass; b=kXGNeN+u2rNbgOHdJbm8FU77K2c4NDmAFd5KgIxyYhxgCoOo2ewGtGu62mBxY+mMrBSVUo0l9/DIM81Jt/5XZaenLyTh8B7wcrdssRFvcgUikhzu/4oqH74WWoIlVBR6kwlAFmVRJ3WFJapWSsisvK6dPzDr7nKwojf1VO2+gDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786775539; c=relaxed/simple;
	bh=c0/bUlypG7PmLDyExMB56rmBWVNa7xMhaEr9XHwGsF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmsV8OpxTRfW3F29E+r2wGsQ+xXf0vPtuQVD79VGcEqqDwDVnQmPqoawPHTFAEQf9ROexytjtg1wr1LfK/zynpJTGVLI+0dPfdatyXZF1UOCC8sR1RqR9QJ3/XvF/4Bod/DyDe2xSCOdpvbbk6JgdmJAjAlTH8ikwgZ3o1Mx940=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=nXwu8glO; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="nXwu8glO"
ARC-Seal: i=1; a=rsa-sha256; t=1786775516; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Vd24WTuKG0YImoHcUM8iVQ7lWbYT89UpYv3iv0D3EChWKPFgYtqgkkwyP8oqXQnhcBFdVUiLFxN1hFebfsz61dwcoXis+Uo9pL3+LnEd7oSg/yf3lBCkt5FLas760fXMdzmBBYbkTk1UyzRYXouHsrK7VkpGnmlIDfDrK70A368=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786775516; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TMipRwi3Zn+WHvHwtAE1dGnp+ssec6geqTqK5C58iNc=; 
	b=A73cgM7xJWJYZHEbU6QQ0ipQJOp9EL1xjl8EMTEpjw2rvEcuCr9OQB1MWIR2H+46ocBQ5GXqTz4wESh9uD6tX4fBevcC+oX+Ol1e6R0WDF7REK+xg/plWi0hkz5vAkqLCHnMIruDwvLrCu/Ann6TPmzcvoIQIiyOnnA54iD8tbg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786775516;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=TMipRwi3Zn+WHvHwtAE1dGnp+ssec6geqTqK5C58iNc=;
	b=nXwu8glO1vOqOl2oO8V0UC6x0RIul5oiI5MY4nc3Ndb+i3+TUG/Q3Jt77gXzT9sN
	vx5x1IKGxWa+H8B0jsZsJO9tQPkoqMDsdApQGeKmUm/4lh85BQ0D8sYtHjHj2dEMWeL
	0P/dRklTvRCOWJLH+4EaMF/Kzgfi9YmJSitY7hzyK/1yfzbmmLgq3KqDB1xipNtR9h+
	b+Gun+y0+/InO5xaPRHNBoMynUGAP3KfTdZy1rDvH8I0zUVLDNpQcNM6T05iF4TtQPD
	CLu6EfSk8ZgipSNB05rwECkenVaKXkpSJlEPTGVHYQy3let2rck5+tVbx/nEcghEE4N
	L6ozjwv9Gg==
Received: by mx.zohomail.com with SMTPS id 1786775514980107.94645383851821;
	Fri, 14 Aug 2026 23:31:54 -0700 (PDT)
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
Subject: [PATCH v10 net-next 1/3] ptp_mock: Expose ptp_clock_info to external drivers
Date: Sat, 15 Aug 2026 08:31:46 +0200
Message-ID: <20260815063148.2952-2-maciek@machnikowski.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260815063148.2952-1-maciek@machnikowski.net>
References: <20260815063148.2952-1-maciek@machnikowski.net>
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
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
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

