Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CC93F39CD
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 22:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786659663; cv=pass; b=sK8zZGkPE/P1aiD08Y1NfnwbHPrSRVzwcLnoP6e3qaERvv5npFomn2Mqc/A/M4TEnTyYo3e8VSRE6idKJ0gR9trQhsZAfE02wT/u3sTGaGZWBx7GM/kmJJFhRjrGDy9vSw1+Hx6zLgSheK1WpEzVLU6YJpsyua1JqLAcvtZzgpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786659663; c=relaxed/simple;
	bh=MoM3SUix+VxL4tI1A6QdAmDJIiPaAbH+OcVvVY++ClI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bDoCc8VlF1dBzS3PTDi93OQFVm8V8N253tbi2HadKh9Md3GAvuL//8rWU5lr08FT/jnX870/VMeFJAExMLsSewNHmtBeAAVHPJ7sHwpb3JGaHzb+TUqmJhKQsFQLoFlMVzmZPNwB8x6MlS6Ok+A8zKny0R77nCwqC8ZNHOxCWuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=KKZkniBi; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="KKZkniBi"
ARC-Seal: i=1; a=rsa-sha256; t=1786659633; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fjn59wp+wRPQuXLqPmgxGFNEyCqGZj8abrq6UUNCPoQVtgAelC4BVxth0fUDUfJHFqMjyBUw7/Rco1fcXhWfI7WS+mWjMKC8n2C19qHyp+BXd/htmG92Y3aQEOSHfM/wqDMi+G+eeiNJdq5+wcCxGxrhlTnUN5srVIzhTlXQZ4s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786659633; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SJxqPj9zaGlWPM4nlGDQpIgEQMxyM7a2QhbaV9sOkHs=; 
	b=G2nC04iUIaLz90MVD9j/CfY9ywUQA0fkb0ATis6HLyIGpRmruEHYLK12kwvDW7obTZKrJiKfeJbrYWsu3MEysbiPsdJHADngChLN/ryUPytIPfB6nHCxAPdd+pLLqIf6Pr9/C0NfJSdTUdecBbhtSnlTEhtdrAo/SKHY5+POcLE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786659632;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=SJxqPj9zaGlWPM4nlGDQpIgEQMxyM7a2QhbaV9sOkHs=;
	b=KKZkniBirWF2tvsQeDI41nVFN9aQweJL6zWWIUVdNtu/iUC9ixC32AGOLqksR5QI
	S9rRri2MZyLxGDkXhImgn/1cgxhW3X1Eb790Y5HgrDmDdxP+5g+4hRDAaraa2JEFwJA
	NgTpKVADTCJ9jW4wUO53vrDNkPEl8p+0T57vGYjrql0d9986g9sLMatjt7EdcgA2+H4
	4i6hRa0gmD0dSmVy4qd4BCvCNZJ0DFycbODoXP3AyTmmpTkitm3A+t73pun5rnbvdhH
	54B0gcXqW/7e+UadxJK5gCPEK61ABPQPPe/iPP1J3/CATjdPQrCf6r9a7MHvNYTgkD1
	Gh0NaFnAiQ==
Received: by mx.zohomail.com with SMTPS id 1786659629750578.468002893259;
	Thu, 13 Aug 2026 15:20:29 -0700 (PDT)
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
Subject: [PATCH v9 net-next 1/3] ptp_mock: Expose ptp_clock_info to external drivers
Date: Fri, 14 Aug 2026 00:20:21 +0200
Message-ID: <20260813222023.2460-2-maciek@machnikowski.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813222023.2460-1-maciek@machnikowski.net>
References: <20260813222023.2460-1-maciek@machnikowski.net>
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

