Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52114519B1;
	Tue, 11 Aug 2026 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464312; cv=none; b=dfOodV5CjS64M6xK9wf2lURq9EjktlNit55o8Gtl4N8vXjlJmhIXRo6RKE5nTF8PaIyzrpCY30ei97UjYeLKhIGLzQWWfrBiLUXd9vyg8x0IkGfrGt+1OnrvSRri7+8RU2CgtzFiyTfA4q7X8Fp7GbrnxnrvwMTMJCp3c79lEB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464312; c=relaxed/simple;
	bh=KVkDfpN4qFfLDMqrOInIWAKFx/T/3QAb+S3fEsWVm5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kc8SW3tETnn0myf1Csh6hRR+nJp04Uw3yU1yC3DS1znpYfQwBlJ8awvdZRn5cJJIccGz5A9za7IiAIfzVsXw5MNjpxTEOM9SGchkwDaaDdxk/nS6x1OhwHsEti2Jol49j2Zn7jcZ8EcVqSdqOskij4LXSkxGbs470aYKN8hpxHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=d+ggZfmD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lo5oDwzz; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="d+ggZfmD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lo5oDwzz"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id CC885EC0231;
	Tue, 11 Aug 2026 12:05:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 11 Aug 2026 12:05:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786464309;
	 x=1786550709; bh=zqidzY+BampYtE/nOZEib1htnwGjsRJJ1wONgzGOPCk=; b=
	d+ggZfmDN4rbc72Xil2fy5MLJ/MJ6ALWJ8mbVtlmiZ9BXla7Koac1khXBTA+RCdp
	qwjXqUikwgiEF6BsRGY13oNCm921aB0TIsk4BCvNEfpTFFM5h5XRKTZYXpn6RVM4
	/hd3Hhc/YP+EUEFuXv6p5NmcpzXHEYRqdVXWLWnswv6TTcAaWh30b0Qs1cixTQ3B
	NLd728PTCc5KC7/dQgaEtiX+b4VUaZfuXfhq40ieGRWbwZ3tZXmMxdwSPxv6l2lD
	Bte8ZJOuCxrW7uf7seYabgxY0HhSVcbf/D39G77U4R7OxkqyK59F1Krc8Zcc2bcW
	DWqxzcl0gmdcy92DybJNww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786464309; x=
	1786550709; bh=zqidzY+BampYtE/nOZEib1htnwGjsRJJ1wONgzGOPCk=; b=L
	o5oDwzzVnHz8MHlQeEBix6F3hu6KqWV8NtHGzDetG71zC1i5eGacnOBGYXBDguQE
	XKu3ibFoBpSKn8jzC+o1ZmiLofRgxzyy0oIhb9/QAgueW3jDjgvxHWeBlfPVUGC+
	FAoCCy9iJKoXuLcVtKiveQb/aXKK1L44fcelXht0rksiS4AbzdpMUDo96ClAcwxM
	XzATwJEFisCKV2oRjrqO/APOLyJyPQfekudlnHX90/OtvTe4q8RBroKuPjSK3szh
	vQFfDPF95jVdl4l3wSdKJ47VKhJFHLOdST4jOH0WlXQgdIJdSWcgBC6aBUlUkpPZ
	9QrwqQpaSb8CicAY33t1Q==
X-ME-Sender: <xms:NUh7alnJcZMMg94nU7s69s8NUZTzBO5flmXsBUMMjOAoninQwpMgbQ>
    <xme:NUh7aplMjWsBEYcKd3cEfmSq9xqEtt2y2sENUreBkjFb6gsnYRcCnDhjJw_iHI8Wn
    FzClQlxuHxzOB3k2L8bBgDYS7VQopqsNv3rl4bnm3xpvgQFKte0nQ>
X-ME-Received: <xmr:NUh7aqUyplN9vcalytM9lAcD8FeLMp-bMRhUdbwgQF_KIjGApgQ3uPCvnXwfQAC8jVT1XuYSPC6pdyrGU-T-QZrJ27vHbKE>
X-ME-Proxy-Cause: dmFkZTEcdCROLuiysp8uGk10uhdQUBXvLkeDFruJAASHfHD4IGLRMaTPWndx0zISdzB5bK
    1b04fIAYW73mZvQCoXdYl+FxlriN3o3U6H5waRUdwWpiwfVeL9wXpDB+6d0gs3GC718W4n
    lh3z8pHjUTILslF7HB+Sre7ZxJSwYfvLHn63UNun39OJCit/JuWFstxBoJ7y/3Ejl/fYx+
    vh+W7b/kTC59k32MaoWWCFUzkGPnVxwHaEBbmtyDyftDkYmsSTri+IwDw6M62abEUeycja
    /bKxrSdWXvsgHaE8UOgwU11N40h7s6fosNNXtN6ZutD0zI8WJq6RYvRBgQHYrm4/UJ//FC
    5Y9z/uqk2hs8nZH8UJiogvwBfvtK6bC11c3aT1krJLLVv6xFYcHMq2SYyL/LKl/I3aabFq
    uKP99a9NaS3En/cELJbQ2CSe7kMkwcjGICrPtCVs6X3181e0tV3XjZ6RNX9zecm0qP6tbS
    QGz1FVQoYFiRvndqyAAJfqoH3u4woO8mVEnvMeDYSt8/AXf/lMptiAzhQDe7KEvjmeJDWf
    Zr76w1SIVaT6NVe9y8tITFl3SLJvFQF/gOGv/9T7Ce2P6MyXq/3rSFSp+25ox6v98l+KgV
    h8rO0Ke7kt9VpUNyORY5INa9kYOEsT8i1JZ9JlCMfVf2XR7jDeiXmo70voeA
X-ME-Proxy: <xmx:NUh7an9leheqmE5POPl51zxSlZV0sp6oaPsDM1VwSaRJbKQNqxoovQ>
    <xmx:NUh7anoQGEWAdAxqETh5lwmU8CxwYaN6UKiA7KhKf7xLX5vayfPouQ>
    <xmx:NUh7aplWewpvBuax3Zlxaz6-PQQzfBrTXs8BQgSceRt4Zjq9C3rtEw>
    <xmx:NUh7arZeA99dNTkaVF37-o8dx_-IFQjSo1jhp-cQxh6Jr-k01Octpg>
    <xmx:NUh7alcQL2Yg-jYNyqI_8Pv6_xVyJ-gYtpWnIq8TyJv2CNFwAvj_Y2xl>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 12:05:08 -0400 (EDT)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"DavidS. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Sergey Shtylyov <sergei.shtylyov@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH net-next v2 05/10] net: ethernet: ravb: Propagate error from ptp_clock_register()
Date: Tue, 11 Aug 2026 18:01:55 +0200
Message-ID: <20260811160200.2049987-6-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811160200.2049987-1-niklas.soderlund+renesas@ragnatech.se>
References: <20260811160200.2049987-1-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If the PTP clock registration failed the error is silently ignored.
Before reworking all callers of ravb_ptp_init() handle and propagate the
error so it can be used.

Link: https://sashiko.dev/#/patchset/20260610102432.3538432-2-niklas.soderlund+renesas@ragnatech.se?part=1
Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
* Changes since v1
- New in v2.
---
 drivers/net/ethernet/renesas/ravb.h     |  2 +-
 drivers/net/ethernet/renesas/ravb_ptp.c | 13 +++++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 013ced6dcf29..39892f0f8e62 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1160,7 +1160,7 @@ void ravb_modify(struct net_device *ndev, enum ravb_reg reg, u32 clear,
 int ravb_wait(struct net_device *ndev, enum ravb_reg reg, u32 mask, u32 value);
 
 void ravb_ptp_interrupt(struct net_device *ndev);
-void ravb_ptp_init(struct net_device *ndev);
+int ravb_ptp_init(struct net_device *ndev);
 void ravb_ptp_stop(struct net_device *ndev);
 
 #endif	/* #ifndef __RAVB_H__ */
diff --git a/drivers/net/ethernet/renesas/ravb_ptp.c b/drivers/net/ethernet/renesas/ravb_ptp.c
index 1c9b33d1b8b9..473a2aedb745 100644
--- a/drivers/net/ethernet/renesas/ravb_ptp.c
+++ b/drivers/net/ethernet/renesas/ravb_ptp.c
@@ -312,10 +312,11 @@ void ravb_ptp_interrupt(struct net_device *ndev)
 	ravb_write(ndev, ~(gis | GIS_RESERVED), GIS);
 }
 
-void ravb_ptp_init(struct net_device *ndev)
+int ravb_ptp_init(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	unsigned long flags;
+	int ret = 0;
 
 	priv->ptp.info = ravb_ptp_info;
 
@@ -337,6 +338,13 @@ void ravb_ptp_init(struct net_device *ndev)
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	priv->ptp.clock = ptp_clock_register(&priv->ptp.info, &priv->pdev->dev);
+	if (IS_ERR(priv->ptp.clock)) {
+		ret = PTR_ERR(priv->ptp.clock);
+		priv->ptp.clock = NULL;
+		ravb_ptp_stop(ndev);
+	}
+
+	return ret;
 }
 
 void ravb_ptp_stop(struct net_device *ndev)
@@ -346,5 +354,6 @@ void ravb_ptp_stop(struct net_device *ndev)
 	ravb_write(ndev, 0, GIC);
 	ravb_write(ndev, 0, GIS);
 
-	ptp_clock_unregister(priv->ptp.clock);
+	if (priv->ptp.clock)
+		ptp_clock_unregister(priv->ptp.clock);
 }
-- 
2.55.0

