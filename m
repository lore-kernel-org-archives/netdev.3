Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794169577;
	b=5KnyBv85XdkTS0FSXalfF6V9qvsFHYz/6R8kJS9bRwSI4XFbK9V8Di+2znNrLZ6VNDCX
	 0aTMY0Ri1pKgJwPPofseXzCrH5X13udLU08xMDBXo1WHKv7bDBrTbfCD4bxhtsJ+INLZO
	 v3brwHu2PDj9uEFOUqm5vx9slwDhVsLzjB7pN4E5TwWqNZiAnMPPphW9WXTmpAKbmsBv5
	 CAfY/BaOCMX37lZRxrJuYZqJRiJ6FnM9hy8s5zAoWhQsgkDI+z6Qjays8CPA1EhDAl9EE
	 pu9DOI11JeEX//xsfCGgeewLlG+/pUXuJgCbiZVGh9bjq0QcbkhtJnFSUr9gdoDvSbQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169577;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=IuU49qGy5a0Mx2ZFYbc77Y+f0YY1z5P/apxjQAzXaD4=;
	b=x1b/onavqOmxdOqMFfvLYVO+IIf9D6aBhrZt5Z1BxZv//44mFjq3hPQjYMm9Ro2qxH2V
	 7pWl/cVWafqwYLLMN4dSXA9qJONCaS1LyaA+wODhGdOzrF4a528HNTndd1dg3k4BeYZVQ
	 HpHTj+eq7Tc2BtHFH40g88F7u1yvUALG7MZicTQZcKlipK/aUFMtZEXowmjk/7t2/i3eG
	 1gu2gSdb2aM+VNkNGAFHs0wLqDoTuKgIH6upA1O2U9+JTjDnXRHNKzUE8r+SS0b3f6Isv
	 BX8FsgdXEx1GRo6Jq1Q8t80QOGs/sm+D+26uwP3oZCLHkreMLIN8RIzH156YHmHSICw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=machnikowski.net;
	spf=pass smtp.mailfrom=machnikowski.net;
	dkim=pass header.d=machnikowski.net header.i=@machnikowski.net header.a=rsa-sha256 header.s=zoho header.b=iDmYmwZV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.54
Received: from sender6-of-o54.zoho.com (sender6-of-o54.zoho.com [165.173.180.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B848606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 20:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B848606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=@machnikowski.net header.a=rsa-sha256 header.s=zoho header.b=iDmYmwZV
ARC-Seal: i=1; a=rsa-sha256; t=1794169550; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lzkYCHe2nMq5KQhzPCMnZsYvPYPFuIJCBeBeXeU2BpLgPJIwwmqpNdYZmN6CNhdHdc6PWET0jD3+e2ZBgjsFxtY7N5Aj+PN0zYTw8p5vtO/+ws+Put6JMpuzV1zgiU1kQSztKkD16YbkDG5QU+IJSOJAL9WqqxJbqvJlSBMp7fo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794169550; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IuU49qGy5a0Mx2ZFYbc77Y+f0YY1z5P/apxjQAzXaD4=; 
	b=h+B222Bkbs3HpoIxWpfd5cFIk3HJq24Gh/dl79E9X7YPvdTLrry3ovbQpcfefhe9Ij1gtq/kcdXP7VJDBtPIYDA8nsTWHzAwXE3Gt+BFZdPH9Vb3K2yTbSS3Dhg/zAogs1VndIlK/0qgpHrSH62hdw1BjSD4ivxTzIw5CLcBZJs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: a=rsa-sha256; b=iDmYmwZV4vyD9IqLDzjHQDdD0SC/fxt6shDjMoHs7uUOeY8mwM7qnNepSbK7B3xaNYs9Kc/HdNDQYjCG+cjSBypqweE1qN1Hf9cbac0TRetpVaJz0JVjKy83Z4JJ6FAKJSywRUZNz/vJBd12cvyEQmafJ15YycBAXq6MI14oXAS6/Eynl+4ZYF9bZmpqY6g8F+Wgz4pJHyKkjj4O2cnS9wmst91uN//aVOy6M6TR/P1mS2vKl1casZ8xhkL24DV6U/00eeJLJ9NVkkHhA2tsNJop8Wj3K+eNm/DQTmLl0yaPZOwMT6VNOOJe2yxMGdYV3TiPYeoJ8x0q8E5vPuraIw==; c=relaxed/relaxed; s=zoho; d=machnikowski.net; v=1; bh=IuU49qGy5a0Mx2ZFYbc77Y+f0YY1z5P/apxjQAzXaD4=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794169549889954.902555540799;
	Sun, 8 Nov 2026 12:25:49 -0800 (PST)
From: Maciek Machnikowski <maciek@machnikowski.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	maciek@machnikowski.net,
	richardcochran@gmail.com,
	milena.olech@intel.com,
	willemdebruijn.kernel@gmail.com,
	andrew@lunn.ch,
	vadim.fedorenko@linux.dev,
	horms@kernel.org,
	almasrymina@google.com
Subject: [PATCH v12 net-next 1/3] ptp_mock: Expose ptp_clock_info to external drivers
Date: Sun,  8 Nov 2026 21:15:01 +0100
Message-ID: <20261108201503.85000-2-maciek@machnikowski.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261108201503.85000-1-maciek@machnikowski.net>
References: <20261108201503.85000-1-maciek@machnikowski.net>
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
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>
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

