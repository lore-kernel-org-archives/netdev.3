Received: from mail-yx2-f8.google.com (mail-yx2-f8.google.com [74.125.224.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151FEC8EB
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 04:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791173753; cv=none; b=GXcynI8Yox1EzugwTvoDCt1+BZe4Z3vn2hMRx8YRnmY6xMdKEoCjs3f9LYn2A5ki/r2zS2j8WKFR1ufUQJE0PrwXItUFpYw933o9CFJYMR6P9tOOtqyHt2L/FoAQAgNDmQbm+Y1/SwkIFpwe4q+4Dvsir37w8qCR68Aq2zrl4Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791173753; c=relaxed/simple;
	bh=Ol495Yd1bB9OG/RIDv/QVy7GjKIVdA/eEWiihj9bEt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EwLd82g/RjE7sWxgLjqmdsPd1EjQHjk0VkA9fYUFSWb9lrO4N2Xaus9oCbdfIywvO/UEoIVBkU90Iv8YFQVXRjSreoJdn4IHW441+D+IGaIfRyBGLqttYrzJ4ns9WpWuJXBA3kTzdbitRrgfLamz4UyWu0GQ0HTgN/rXwsxVJfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sHONQFvq; arc=none smtp.client-ip=74.125.224.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHONQFvq"
Received: by mail-yx2-f8.google.com with SMTP id 956f58d0204a3-66cde2e181cso471776d50.0
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 21:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791173751; x=1791778551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WffhMcSo+8l7cweCHxFJooIzIC81MEZIr3lUnbAuzfw=;
        b=sHONQFvqA4JbN6SEh+mjlVXd6UjxGIfQHrjLTrwz1yarsJRkkbOijbPJaOERGOHxp6
         eWvbHTYzkN8EPKeDOhg2rawdCjLgf+s4hBHG0Jmb1Qqo/4HHs6s8bpBHMX7tkt23rR9V
         7Axo0AV356PdvBMH01RmctS02ueQZVQD7uFs+tcV9PzBVFlNyWvbtZSPFmYi0+JCs+Mu
         KtX9NuCQ2Z8ew3nw2b5vLNVreZzoAaR9hhRJ+hdaPSKQTbgzHzwQjZHqjKUhEUg75uiQ
         h/ZF/ynb5Fm0gpng77WfAcJTj2fqNPifeRH/16SkM6/futENkNHTefFzl7ZWO623JC+I
         PnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791173751; x=1791778551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WffhMcSo+8l7cweCHxFJooIzIC81MEZIr3lUnbAuzfw=;
        b=Gx7tXxq1/9UyM4n8scjYt8c5zRBMTvXflS13jFzMBN1ug49MFFENV3uqQkmudkFmEQ
         5QKX88wnB4DGT12OdNh8TqzZohoO2tBnOmsEqGUrDd5+BNy/Ya+Glikv/0Tp+kJyT/y4
         iP9w6KM7lyyYesg5nZ0bT9pRVwYNtEQR9shbhHkvCKLGzryv8aBAwC5lQPyzOiPHTNzB
         YJS+hPUtv/VVy/Xpe68FqvQaNrSvv3XUxRwRx6K0iC6wygWZ8jjiYkykWg2yelk/SdUM
         dl7UyTa8OdoqPdAS9wgKm1jgFwgSHi5wvVmbe+6quZ8pPsj+oof0MFhpPOX6789GAPqB
         NxXw==
X-Gm-Message-State: AFq9FYJoDzU3C0GMNWod75TO1Y8zQow7IdR2dgYL5eScuaHyATF0m2mV
	obIkCYIojE6pp1iLeI/y6FFXSjo+IIR5hktWDti10f3llNz3bxTZwq6ZpbsEQJzaiSJP8A==
X-Gm-Gg: AYBFou0x9K/bsA2Pw3MddDtWS+7itmC+yDv01GM9nY0K1r1y9RpSHwtr9guLYVbKSqM
	yU9EhQCQUwu+j1wc+ykBhgMLtCR0FWjcfZ/+XS0ZVMvgOT+A2Ozb05dXYK3pLZ0QPj8Ki1gipPN
	mKuDNWZxeOekNMCKrY+NMtQPRKmAWkuyQis8N5YKjMAsL/J1E6eBZLQd0k9JQsZtSdr8gw8HAD+
	gcAXP6Vr/MrDq0ZIj7ZqdS8SqVA8gbW1BB5oxm6/ovoje5SUr8bqxNZG9JraKpR36F/zkAThghw
	8e8ulqXZALPFm5JZ2H6yu+IFij3to9zNM4Twedy3ZTjN1eKnIPmuR0T5MD3NN7WFPmK1GzR67nf
	vJevn19c1bWoy0/maFNpRGO05+R0u09saoJSrH7HpH+RsxlGrcZ3wX2Bs5Pf20PDIYKGIrbI/DD
	aPMNRiE49qTTEpuZ82rLjI2WqhrmyUmqEk0hvGF1AmNvTjgmHQT9O3mHWRswEPckJi8YpmA1JmK
	lIubII823SeDw6fh9LAmJu47tPA1shftZdMIadmhMfR4BSzPReZ
X-Received: by 2002:a53:b64a:0:b0:671:5818:1591 with SMTP id 956f58d0204a3-677abff80f1mr3069658d50.20.1791173751046;
        Sun, 04 Oct 2026 21:15:51 -0700 (PDT)
Received: from Xinshengs-MBP.attlocal.net ([2600:1702:7d20:7d20:edd1:61d6:442f:e3ff])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-677c1bf368esm2205213d50.20.2026.10.04.21.15.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 04 Oct 2026 21:15:50 -0700 (PDT)
From: Xinsheng Zhu <xinsheng.zhu.ny@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	oliver@neukum.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net] net: usb: cdc_ncm: reject short GET_NTB_PARAMETERS responses
Date: Mon,  5 Oct 2026 00:15:25 -0400
Message-ID: <20261005041525.49111-1-xinsheng.zhu.ny@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

usbnet_read_cmd() returns the number of bytes read on success, which may
be smaller than the requested size. cdc_ncm_init() calls it and only
checks for negative return values, allowing initialization to continue
with an incomplete NTB parameter response.

The context is allocated and zero-initialized by kzalloc_obj() in
cdc_ncm_bind_common(). Bytes missing from a short response therefore
remain zero and may be interpreted as device-provided parameters.

Require the return value to equal sizeof(ctx->ncm_parm), consistent with
the existing exact-length check for GET_MAX_DATAGRAM_SIZE in
cdc_ncm_set_dgram_size().

Signed-off-by: Xinsheng Zhu <xinsheng.zhu.ny@gmail.com>
---
 drivers/net/usb/cdc_ncm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 35db38cb3e4a..66f40f0d9c27 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -524,7 +524,7 @@ static int cdc_ncm_init(struct usbnet *dev)
 			      |USB_RECIP_INTERFACE,
 			      0, iface_no, &ctx->ncm_parm,
 			      sizeof(ctx->ncm_parm));
-	if (err < 0) {
+	if (err != sizeof(ctx->ncm_parm)) {
 		dev_err(&dev->intf->dev, "failed GET_NTB_PARAMETERS\n");
 		return err; /* GET_NTB_PARAMETERS is required */
 	}

base-commit: 6dc989ea46b96ce170840174b4a38c4a387fb005
-- 
2.54.0 (Apple Git-157)

