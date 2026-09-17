Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0D94E56C7
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789656261; cv=none; b=VA6B4RWvd5nlouZLXKJg8e4AvgO7TrgTMQhRIKwTbCdRsXBqfsVBqoL7u91N7xzg0NqQoZ11fft+/J9SJv1Fi5ew9orYvjpjCKpGmLYeOzeJzULzYXomfG+sKPrFAzJUk7DULpomsM7RTUja4nhAwfTac82QwreRMbiB479/Bv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789656261; c=relaxed/simple;
	bh=wWFrmPZdYXd7YwWTy9eTwd5LSF+K84lu9Y2vEN80o7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LD3j6lDhCs6iVEByQep9nNwoLYfaty9gUEOs9NC9GmFB2XbScA/vT5HXRkTEEDaLNmqtyzG4NJNNbriiXL2mlKRpuHRzqql/Re0ywuiIS6QVR6VYeUpr1+e064d8kTCmZjYjGmyuU6IwCwzOZntphD0rm6lkToiUnsgtmhgYGzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1MOjl+0; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1MOjl+0"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-868a9c48f9eso912664b3a.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 07:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789656251; x=1790261051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=22gw0ZGKrgRtPwCbXT3ngxxxz9UmWAY8ZGfEsrb6sco=;
        b=E1MOjl+0nwwQ49HcCMwiGX7M/dm4AUeA7GBY4kDRqWwerphYVS6yngIewQkxgQ6xnp
         gztP3YB69HdYO3inYGZSOkmN7LbclP68v6iXT7Lxlrv+Qu2T5bYe1V4atVNJiEDDarVT
         arodqhXuHPqRgfld5MqpvsBS1PQCuhq9cYQ934wN/e9oklvgNDVuNE+4oXgM8mYipk/d
         dMA7C1KqUnaFa+Ogr4EJO4H081GgV/SfJgfTAdq9ogWOyFeugqpzb425YjzyZ8TMbFh3
         9rt7No3szN7mB2Fs38pP8xPZD0bVhotlAV7WrXpP7ZW+RMIV3fTK8c+PPBI8sQQ0Yeyg
         JdlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789656251; x=1790261051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=22gw0ZGKrgRtPwCbXT3ngxxxz9UmWAY8ZGfEsrb6sco=;
        b=IyMw5VTLzceFhz8Q7MBrCzJYZhfG/J9y+6z5c66tlWOdjHFxke/RlZEBHbipVpeGZN
         KuTK2NLq0HqITQ7VYyRlFyrLlsas3LUhe8ywyAfryp+AUCPvUQDZIy5OJcEPYCkbpVzF
         Eaf1zHrOnjVD1sCh95shosK1gRubTlP2qFoQyAOWe6TEBTHNlNX+FqcOMq1hlEdPWh+P
         4EwM7hOAsVsuX/z9VHJJDemfea2AxpEn70XtlSVsw/N9BDzHW9fuDhqcgwblJVfqy98T
         VPrC0j5Rq+RIcIghu5Xgb/rJ5+6lVfz1twP60oYLDfs3v/pfuWf5w2rTJ5YCB3oI0sc/
         JHcQ==
X-Forwarded-Encrypted: i=1; AKwUvBx/0QVO/COXgOddq7lDHNS+bDLOITyg0f95F/2cDNUf8PYKkSZhhRNyNSeFAsBdsKhiwEb68B4=@vger.kernel.org
X-Gm-Message-State: AFuF++kYR3KCKgErW1+obNk2zfG27myLDioutJQKM9Ph63oyjJXX5PPy
	m0a8gc/0xh7/UDz5ii+kteaaCgEqQZkqX0dLswBa295b/mVOYXQdtVEVplC50vtyMso=
X-Gm-Gg: AYBFou1nvGTMzZYOg8fnu2DBeDK1jjCoyy2y2bt+ZUqrEh6ez9orJvqsYrEKMJxMBT3
	VZqWodSccIKcR0F8U3BetJtJUO7yT70VoXoFA3y0VL6t/fcjGvlhWSn9pDp6epJgF0cZgvdWcop
	PEcAYYyBFbEK30y+2gS3J0SJxfAfe36j40efdAm2BZQKU39ii2tlSp7BwGjgSgQhvbnlqV85in+
	Y3Sq9hftbj1KgcvU04965t82b63h0aOxN2xwKFJR655sDV6kejw6uS3qlTvkFJqATmJVhqRPUZs
	MX45OOcQMgUBSub18RQ+UIODziTjiDzm/aRFOdyGK1Ec5a9F211U0nkOsDKk7pe9nkaZV45RZ7a
	3U8zyBpd4nqFe+QqNqiq9lPRDbKltPYvbNxmOOY6MNzlEPgToSLQj4SYivcUHXwUzCPi/iz5F2g
	v0mSZNL5WEsKeyUb+yW9cDGaSB9JitiOFZU1hGkxLzFKMSndkWVgFpMgyxijjsiPvQLtfCDo88B
	YQSCX3CODeWY0iDXJfWE+lhzGUsNRkVCdkjgdNvmA==
X-Received: by 2002:a05:6a00:398f:b0:848:4424:2b8e with SMTP id d2e1a72fcca58-8723adafcb6mr14166549b3a.3.1789656250736;
        Thu, 17 Sep 2026 07:44:10 -0700 (PDT)
Received: from localhost.localdomain (59-127-145-64.hinet-ip.hinet.net. [59.127.145.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87201d1b275sm2962034b3a.51.2026.09.17.07.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 07:44:10 -0700 (PDT)
From: Zhi-Jun You <hujy652@gmail.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sujuan Chen <sujuan.chen@mediatek.com>,
	Rex.Lu@mediatek.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Zhi-Jun You <hujy652@gmail.com>
Subject: [PATCH net v4 2/3] net: ethernet: mtk_wed: fix reset condition for rx wdma
Date: Thu, 17 Sep 2026 22:43:34 +0800
Message-ID: <20260917144335.19466-2-hujy652@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917144335.19466-1-hujy652@gmail.com>
References: <20260917144335.19466-1-hujy652@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In mtk_wdma_rx_reset, only the wdma rings that weren't allocated are
reset which is wrong.

Fix this by inverting the reset condition so allocated rings will be
reset.

Fixes: 4c5de09eb0d0 ("net: ethernet: mtk_wed: add configure wed wo support")
Signed-off-by: Zhi-Jun You <hujy652@gmail.com>
---
Changes in v4:
- Patch added for issue raised by Sashiko
- Link to Sashiko review: https://sashiko.dev/#/patchset/20260724172040.1653-1-hujy652%40gmail.com
---
 drivers/net/ethernet/mediatek/mtk_wed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index d55042ccaff1..3f0be70c3f14 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -257,7 +257,7 @@ mtk_wdma_rx_reset(struct mtk_wed_device *dev)
 	wdma_w32(dev, MTK_WDMA_RESET_IDX, 0);
 
 	for (i = 0; i < ARRAY_SIZE(dev->rx_wdma); i++) {
-		if (dev->rx_wdma[i].desc)
+		if (!dev->rx_wdma[i].desc)
 			continue;
 
 		wdma_w32(dev,
-- 
2.47.3

