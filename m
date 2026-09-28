Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9F83DDAF7;
	Mon, 28 Sep 2026 13:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790600709; cv=none; b=b5FHJQIi6hG5E8CMilMFEVT1lnteGYRFA1krG6PyPd4vVY7SlRpyD/RqCFjQ1hIU/xpm7W2PmbFcI7DUOs3kr6jFqN4qALZJ8DvPdZO5TaUr39u48k5/El0przTZsc/Ub76UvOwmRHHnHfQZ5XjrS1eOutRvsyEvM36Ivgj1bKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790600709; c=relaxed/simple;
	bh=65+7vKuEvhuWFc/lEOTdpPleihYib6cFiBpcE5AQo5U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/ZZSkYESX45VN2nrGo6w35nae/E0r+Jk4E3+E8zxlkX2MR7uqdbjvXmJ3sOaJi1OzT+H6dJZm8YgN937f3I+laNt85nyq0uGA/w75sib2whJzoF2VMPjvTyuE7OP7IoXtBwpvSp6V8FXm8VHGkw/ICAVYMKCjRAnhiqAm7SvQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vmHxp/Jz; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vmHxp/Jz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790600708; x=1822136708;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=65+7vKuEvhuWFc/lEOTdpPleihYib6cFiBpcE5AQo5U=;
  b=vmHxp/JzfPy6TPF10/tru6+vygchPGZhUIPvB2639XW1TQivJ1qJHQSC
   IaMZKYW+YunDwk4auC1ionPeMIEqO8w3hskpL1zZCzEuUaFxRRJnfnqGy
   nUQAPKVjvlR44HYFQ+v5c/yD0JY7XuHlotUAR9um1wRhH+qPyDUzpZSfJ
   5Ao+fizIbET6JDOdKksxRL5Mhc91PwO3IsZJcc8S5bM48Ne6EdSkiCRrb
   25KMTm7yGvcrxMM3749gcxZoA+tjIydf+ugPlTF/gpd6sg+HfQahIPc8k
   QxozldBjWi9RiX2ApDg2jiKfoCBjdi4d65+f7DpI1lYOgk9YmXBwDdAm1
   Q==;
X-CSE-ConnectionGUID: iXTAp/08Sci8x7ZxUFv50w==
X-CSE-MsgGUID: hNDEykj2RiuvUDcZN6ZVLw==
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="295665390"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Sep 2026 06:04:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 28 Sep 2026 06:03:58 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 28 Sep 2026 06:03:56 -0700
Date: Mon, 28 Sep 2026 15:03:55 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Quentin Freimanis <quentin@q-lab.dev>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Richard
 Cochran" <richardcochran@gmail.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: sparx5: skip ptp deinit if init was skipped
Message-ID: <20260928130355.jxs4iqcd6jfoxezp@DEN-DL-M70577>
References: <20260928044542.29287-1-quentin@q-lab.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260928044542.29287-1-quentin@q-lab.dev>

Hi Quentin,

> sparx5_ptp_init() returns early on the base lan969x variants
> because they do not have the SPX5_FEATURE_PTP flag. It also returns early
> when no "ptp" interrupt is described. Unbinding the driver then causes a
> NULL pointer dereference when cleaning up uninitialized tx_skbs queues:
> 
>     Unable to handle kernel NULL pointer dereference at virtual address
>     0000000000000008
>     Call trace:
>     skb_queue_purge_reason+0x68/0x120 (P)
>     sparx5_ptp_deinit+0x64/0xc0
>     mchp_sparx5_remove+0x38/0x70
>     platform_remove+0x20/0x30
>     device_remove+0x4c/0x80
> 
> Before per-port tx_skbs were added, a NULL dereference would have happened
> when calling ptp_clock_unregister() on the never-registered PTP clocks.
> 
> Fix by returning early in sparx5_ptp_deinit() if PTP is not used.
> 
> Fixes: 0933bd04047c ("net: sparx5: Add support for ptp clocks")
> Signed-off-by: Quentin Freimanis <quentin@q-lab.dev>

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
Tested-by: Daniel Machon <daniel.machon@microchip.com>

Thanks!

/Daniel
