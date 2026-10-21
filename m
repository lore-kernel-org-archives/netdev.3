Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792579657;
	b=PxzaS6YhtG4chgwTHIjx8KM2Tsyxpq53vRZe7KGmJ9/q/xJ4o4Bft74vkH44xunO5uN0
	 9tRsoMsDadP7ETKqbTyVrnY31YPlCbNVpbIvQ7r8+pj+aCZvvG2gubep7ydIh12XoMycK
	 rl5GzDr2cyY1C5KQ56H63SYuInBZGV/0EALCnolhM9/w40T6NWmbA9vDds0jvKgp00d14
	 pI20sDPrsrkwx/Huor+HiIupMFleAFc04GFbA0XtPkWVBusztUy23F40o1V6r/LpCUBFi
	 SNhDX9LQdgQikWowGQjEmNw9bnqsHlqDeIYb4f7S4daqatDsn43s1A+RpJ2ZdnABtMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792579657;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=i2XnVCM8zloM7xwChl2t+8i6moX4Lf98Pksgvz5JXf8=;
	b=X/SKKY9yHicETVdMi8cOAqk4HAsKUA9664S8sSCFCYI+p44Bn1IbGIQrEbRAgcGuCzfi
	 i4vn4Rz1klAIjZOYYNjwSgwkW5AFxDR+MEqLyKdKiVGwoHFZTegztuKYhJ/QdS4HU1ZHu
	 W/Pjt3Cl+Hus32Ui8xZ7oLAbuezBouxuOdc0RPwsz+QPdUSvI51OxvY73AyLFTf0Z79va
	 WTJiS8K/b0ph331YJHfVTXqay/TJpNFk/R1nkZQs3QC/2fw0N4ViriHYPbTx/SRL2yfh7
	 s7vCN4R3/UAzJGdZpdRK8ei8P4CR8kbO2EzXB+nHwHLfcDzGUB7c7pm7BnjC8ZMZbMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=nghl5JJg;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4AA606A31E;
	Wed, 21 Oct 2026 10:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A4AA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=nghl5JJg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792579662; x=1824115662;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Piu0mVngncDSBVd1Q3hPEyJeVV1nRG49aac+V1nrbng=;
  b=nghl5JJg5iqWmq8Xy4SrQfH7ALED5tlE2CGOgHZpHsRqRaGnBUDcu5F7
   V53AlQbeMbVaH2AfdgbzQbnjr2QLhcTPfOt4u5btrkY1fR1e0iMyp0R/W
   CiXdpO1XDUM2ArTg7dKyD3CVmr56RsZ61mK2I1BIc9umlvHZKtTulzbtw
   JHwJV3jXrAn07PsqWA6lWygg0/dmof4zO8br32UDBMViHQidcZomNRIBj
   Z6AW8UbHNke0ZGQ4LOpfcDxuwV3VuM9DlfMDpjrGddZGU5Pc1qVbvh5nT
   /LOKxCeZuB/sXwfCNlAKtmuX4ZXv0hjPnXdZ8rymldLQZP5IEbcjpQvCo
   g==;
X-CSE-ConnectionGUID: DzLHbg0tTvq+Bws4Pu00UQ==
X-CSE-MsgGUID: ThXTFMWRTWSRCFIW2zl2fg==
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="75804691"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 03:47:36 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Wed, 21 Oct 2026 03:47:29 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 21 Oct 2026 03:47:27 -0700
Date: Wed, 21 Oct 2026 12:47:27 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Rosen Penev <rosenp@gmail.com>
CC: <netdev@vger.kernel.org>, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?=
	<rafal@milecki.pl>, Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Felix
 Fietkau <nbd@openwrt.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: bgmac: rate limit RX error messages
Message-ID: <20261021104727.tlefjvmslr7xjqcf@DEN-DL-M70577.microsemi.net>
References: <20261018231629.39734-1-rosenp@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261018231629.39734-1-rosenp@gmail.com>

> When the RX ring is full the RX FIFO overflows. With RX overflow
> continue enabled, the DMA engine then writes one frame with a bogus
> length (always 0x45c2 on a BCM4716), which the driver drops with
> "Found oversized packet at slot %d, DMA issue!".
> 
> Under sustained overload this happens on every NAPI poll. On an Asus
> RT-N16 a 950 Mbit/s UDP stream to the router printed about 1450 such
> lines in 20 seconds. The messages are printed from NAPI context, so
> with a serial console the router spends most of its time printing.
> 
> The frames are already accounted in rx_length_errors and rx_errors.
> Rate limit both RX error messages. With this change the same flood
> printed 60 lines while rx_length_errors counted 14297 dropped frames.
> 
> Fixes: 6a6c708469c9 ("bgmac: add check for oversized packets")
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Not sure there is a preferred choice between net_ratelimit() and e.g.
dev_err_ratelimited(), the difference seems to be that the latter keeps a limit
per call site rather than a global one. Since it already calls netdev_err(), i
suppose this makes sense.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>

