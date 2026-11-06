Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793958063;
	b=bzVAqdEWcAGep631JzlVc/b15eup9eTo8fPL5KKI9F8wb7bQSZ8JadamZR9X2uWfcIXF
	 +xGOYXZZ++4h9Gc190i2jhIKJTwx4jADFc3THrFGiH0tnSJd+S2ti8mMPH2RVugiif7bS
	 6iqO2aEVxYMBVJpn2MsLYACQ3B/b7UfVY4mNArt69hAa+iyKDA7scWqaGfl01AyAXKW74
	 MmI+UfNF1o/UuugCiE4Gzh16Ym02dZz4cPePsdVboPT4m5ODAGQgE80dNKkNKIT7SwWdC
	 Srye501LH1zA57G2kXQWqeIMHzOjvFRd2qjUE/yPCWy9Sm+OwHkK8YbhNnjcz2AIPDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958063;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=sDfhFOPZ3KM2MaWTWl2qG7+3UHWyhGCSTPMLXUGyVC4=;
	b=TmJ18JeRWXF58Z25KTH7pk570rk1MstPwy1IVt/Dc/8sj/I7Ua9l0Akl4MKCzx9oiooR
	 9I2+BCIumJnPrVw1+VvrHePCYkY+2IKWXpusULzgvmYsn66hQyYBAmGLo315Z3hEXRViv
	 iBUh39IPBEjOiKLV2wA8gSKpNCg/0+lr4p07o+zC1flkBWb+glU6xmT4IirEGFoNj0feX
	 FS0IILi6dYSrLp0LNM0Ze/mr5VYHdf7x3ulng1FfUGG4/fxiMvvn4ZDLKXwaAjDgKjjTn
	 owhv67lPFtMcu+t+DGlHSncAPF5iYwNjxzSTpjZ8t/hji3Lu1HIRO8En9ykjNLenwyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=EhBIwCaL;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C92606A32F;
	Fri,  6 Nov 2026 09:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0C92606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=EhBIwCaL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793958062; x=1825494062;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CtjNrr0lV4K9AM7eEJ1v2UHLIwBoHkxGF4hGdBTO3p4=;
  b=EhBIwCaLlJblGfi55TV/PH0nhLXxrX8AmSRHjnAbRDPTsZtI04uzhcvy
   syqu5H2cKIwk5z6Qe+9Ui4/O6GBdpLPh72E6Lr3w5Mz9Skt80BGQkKYIH
   qBP6Tdj1g1CkKCPPWc69rQ6sAO/SU9UG0aYiZtw1+Ua0E7+/JAyaMyA14
   lv5D48fWjd8a5IzM/EFZVnfJdg1Ad7vldNFGBKFL3N22+VTiSxfZTTsr1
   Y/8gG2KCd4WcZ91nz9GuE15k2f0FmZT/dfm4wWAVsSAT15ZiyLXvZdmmt
   ig9lyEM4mWIw0tL1V4keGE8oIQrMM5ccuZD2HElxMsYqpK8DhPyBrEvMn
   A==;
X-CSE-ConnectionGUID: T9DjPCwITs2p8rbRmW24jg==
X-CSE-MsgGUID: GRg268VCR9SZiv4y+/lP1w==
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="233190422"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 02:40:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 6 Nov 2026 02:40:55 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 6 Nov 2026 02:40:53 -0700
Date: Fri, 6 Nov 2026 10:40:52 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: Florian Fainelli <f.fainelli@gmail.com>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, open list
	<linux-kernel@vger.kernel.org>, <macro@orcam.me.uk>
Subject: Re: [PATCH net-next 1/3] net: sb1250-mac: Add ethtool link settings
 support
Message-ID: <20261106094052.ryeppkdb7otdmjko@DEN-DL-M70577>
References: <20261105193435.2050321-1-f.fainelli@gmail.com>
 <20261105193435.2050321-2-f.fainelli@gmail.com>
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
In-Reply-To: <20261105193435.2050321-2-f.fainelli@gmail.com>

> The driver connects to its PHY through phylib, but does not provide
> ethtool operations. As a result, ethtool cannot report or configure the
> link settings.
> 
> Use the phylib get_link_ksettings and set_link_ksettings helpers, and
> provide ethtool_op_get_link for carrier reporting. The helpers return
> -ENODEV when the PHY is not attached, as the driver attaches it when
> the interface is opened and disconnects it when the interface is closed.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
