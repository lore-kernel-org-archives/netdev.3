Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD27043C055
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 12:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781611474; cv=none; b=FsN0YpPcFYbmTRVWGkSTrMjctehHTIYGtUs1xYproR78ZCxyE4FxrJkSa4SRDd3ZmHUNOAfrbARebTWNMFp8fI60SWxDmds8Lseci2WimLvbtvThSmvKFrcPmbenb1fYfURhHK6LNuSJ3MAbEWqyXOOPwsKuLEfAxzCiWT2TQGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781611474; c=relaxed/simple;
	bh=/WESTBL+Tg2kPxaGx9LqBJWcIxfQG29/aVDxhNwgp50=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Fb5RYT6at3a6TUe+Eac97F6Qxl1w2DE2nPIW+IwsO4kZ/mftpjfaaV9+b6vk0mVZDXd8OdO67dv5PE4Xjg9kkJ7Fm6uD/csQjiZsHo2NtAxTj3jiY9GsVmIdRwTkHAafy22H8McqUCo0Lp3H3VKJVQlfAOPBuXLLdyhnhdH3cK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRHLeeLR; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRHLeeLR"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c86307c4e6bso1557709a12.0
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 05:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781611473; x=1782216273; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JVH7znTjFWA0bwu5sf/vJ2V8033VWhifM4UtG4Dd7PM=;
        b=NRHLeeLRaC8/NdJALwv84DWI/L2G0zHlG5V3OTNxOkWumTpYvTCraqQ8eS68yDCDM6
         NNnmYMmiIRuH3oJoOEbfNU2R0naG3OjMpyZKsrk1+tNzV+A9R0XqcEZEDpQI87Glf0xC
         ba25eNB+Afv/K8aPJlFZJAjjgMVxCc+DnAzlsbGYTDjcgLybSICyQHqWzbriArk59GqS
         0Z+szhGsxhbH/6RXmej4+Y5coeiyaXKj5H370i0amlNSanXqkE2QgvdwsADJLwP7+fn6
         zYFny5ewIOus1JzRT/CRnOm0pYF+ZZN6Q2OwkxGhROw37pVQN5qih+zaURwDKsPqPAKO
         GjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781611473; x=1782216273;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JVH7znTjFWA0bwu5sf/vJ2V8033VWhifM4UtG4Dd7PM=;
        b=GUCksob3kwAAuuxJTh/okhxyBlKy/VVySn/4P6shZgNVuNjEQh/wo0fg/PD+2ElrjX
         QZL6rBhY4i3l1jsgjNswXRPMweUH3wJbRctglKcpjxY5Ggn1MfhjI0T9DLzdV5hRwlGC
         29738cxD2T5wvUVkp8curnALAtguMoCUfZvIaTFv+qKHir8kLFZh2Y3FfWS7sSKUUEki
         wIGRijJRydI+cCmuZGUtmdyqC2WDplmSu0v5eilCm8hVJzYtA3fy7Heb2ysMnQmYgWpx
         zpLm9XMQRWGE61M41c3zJHx8Zh6y37lwVy3vscgXoJCBMZ/wu4USQMrn8joSZmX8CJKR
         Amsg==
X-Gm-Message-State: AOJu0YzvVuPgvNFiXWk1tC9dAOwkVKdPNVt63zd0EX7glty5EIxv8QPT
	CzAwfPLhdFGOX8Mzkv6u8MdAgbtKoavNwFgceI0IZLrq4mAKmkUzqbPlWX/Oz1Tv6haEbg==
X-Gm-Gg: Acq92OEUrIf+cjGtefCEaPUC3ZZm2R2nYb7EPTGWUnJdMIMRCbtM0oRjWNvIDW1eCJx
	EhMcLbhDOPC6QiR3Cj2cRcGXxaWCCUQFjIz4daGeitAejT3hrAu8w9ENsYqSGSNzqXF3SA9njja
	FFIpigxhXiHPqXzO81+W5ckbapsRyXKGJ98olU9ei4JunmiBZKlgHRzUHP6+TSSdqdMHkvNaUYN
	Ct8z9wpAqKkNiF4NeKZmk/rsf6UGYLxAypmxdDPnWFKWt5GtTyrE1/r9tIt9qk/L8vgdlLnwiwB
	+eLj5KLlW4Dhbka66T8gn0Ur6o4OJI+kNNs6+jV/g/Zw+cd9cgAONOcgMgLpQzdjl7drCZcCm5V
	jfD+P8vgAVV1RDsQec7+727x2eSaaPAeSy5LxqWJcg67xLnJaM56SwfS428dgChykkNS1L6Er4s
	WxVhZU58ZdcHLadH3A6RcE9eQ0T7A=
X-Received: by 2002:a05:6a20:7285:b0:3b4:669c:ee32 with SMTP id adf61e73a8af0-3b7e49d08a6mr3763004637.37.1781611473094;
        Tue, 16 Jun 2026 05:04:33 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c866325d156sm11768400a12.13.2026.06.16.05.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 05:04:32 -0700 (PDT)
From: Wayen Yan <win847@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v2] [net] net: airoha: Stop TX queues on error path in airoha_dev_open
Date: Tue, 16 Jun 2026 18:50:39 +0800
Message-ID: <178161146875.2165143.7400860261990016053@gmail.com>
Content-Type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

In airoha_dev_open(), if airoha_set_vip_for_gdm_port() fails after
netif_tx_start_all_queues() has been called, the TX queues remain
started while the device configuration is incomplete. This leaves
the device in an inconsistent state where packets could be
transmitted before the VIP/IFC port configuration is complete.

Add netif_tx_stop_all_queues() call on the error path to properly
roll back the TX queue state.

Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Signed-off-by: Wayen Yan <win847@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 31cdb11cd7..cf9c366907 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1715,8 +1715,10 @@ static int airoha_dev_open(struct net_device *dev)
 
 	netif_tx_start_all_queues(dev);
 	err = airoha_set_vip_for_gdm_port(port, true);
-	if (err)
+	if (err) {
+		netif_tx_stop_all_queues(dev);
 		return err;
+	}
 
 	if (netdev_uses_dsa(dev))
 		airoha_fe_set(qdma->eth, REG_GDM_INGRESS_CFG(port->id),
-- 
2.51.0


