Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DD616A956
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 18:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776192438; cv=none; b=qMwe1CL2Dnx0NgQHJbYrvMpFwCQRmy22GsDjahRnFNYm6tyZPdwGsthsBVuQdR4pt26TgGQabE07zSusPsyhnkPdLVoWY5doeqAzkR6+4EM4WLaOIAJEarmsX2CSFcM001eVkBRf6/FSAOqX3MQmV2wEgSmswlpvOJxiX9ZVacI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776192438; c=relaxed/simple;
	bh=Sku0h7Ch3Fs5+1PMTzIUyOHsNqy1OrGS78QCzj/btJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRDOh+FtID1//Tm1Igl7glSaLMz+QVkyrqzs5w+Zs8/wEmCAZftCqrKT9+IiwpFdv6ZeZqNk8XI//7P0UL8qylxPucePhjWuiJZXGfBwNjRpqHlRLaGu/WX67XlZSV8KjfRTFm2vbKkJvNail2fZu6KC0qLxyblDWvfpfbQKcnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1wCimx-0007vF-Cb; Tue, 14 Apr 2026 20:47:07 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wCimw-005O0b-1Y;
	Tue, 14 Apr 2026 20:47:06 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wCimw-00000009bqN-1Wo5;
	Tue, 14 Apr 2026 20:47:06 +0200
Date: Tue, 14 Apr 2026 20:47:06 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Carlo Szelinsky <github@szelinsky.de>,
	thomas.petazzoni@bootlin.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: pse-pd: fix out-of-bounds bitmap access in
 pse_isr() on 32-bit
Message-ID: <ad6LqkKrXwNJfN0B@pengutronix.de>
References: <20260414151331.745552-1-kory.maincent@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260414151331.745552-1-kory.maincent@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Kory,

On Tue, Apr 14, 2026 at 05:13:30PM +0200, Kory Maincent wrote:
> @@ -1340,6 +1341,11 @@ int devm_pse_irq_helper(struct pse_controller_dev *pcdev, int irq,
>  	if (!h->notifs)
>  		return -ENOMEM;
>  
> +	h->notifs_mask = devm_kcalloc(dev, BITS_TO_LONGS(pcdev->nr_lines),
> +				      sizeof(*h->notifs_mask), GFP_KERNEL);

May be better devm_bitmap_zalloc() instead of devm_kcalloc()?

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
