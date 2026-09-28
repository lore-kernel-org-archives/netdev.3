Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8754A2A5E;
	Mon, 28 Sep 2026 11:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790594417; cv=none; b=lIocy6c4EEJkX33olFG5FenyRb0HkR2hkALui2yBAp5Roi9YvxfOKZb8w9fIk1nLJcdOv1fXkKTqHms1eiWdZpkAdN3hwab8Ts4NFCzzPYw8zLVLWbGIwAxu+tPH5Ra4zv1TXT1rRut21F235EZbu9eXSY4GH7JFPvCElhX+m1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790594417; c=relaxed/simple;
	bh=eVKVz8zyU/xkTeKcO8zjXPp4Q0x6ugEWp8ba6melv2o=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u92K7mdyy4xf/N2pBrowP30F5yXvRrV3byzC9lvNjMQwXVmb2ycGdQUze8E5NFx71aMXMS7x0V/uiYNE/dKZjvHNTDSDQzl3zsRCavXfujiDHsoC78z9x+K9E48RG8QTvOaOdai1qRT/b4AoEuuD54Z2iazlYzO/YRXr2GpIKdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tub8Nfby; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tub8Nfby"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790594420; x=1822130420;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eVKVz8zyU/xkTeKcO8zjXPp4Q0x6ugEWp8ba6melv2o=;
  b=tub8NfbyTgyJZQwGE30zLMS/3P5O8ZDE5+uGJpJsnUfKFc2GC9Rs+73W
   8Rd9w+PANSCcXD6mLEeTlDu0fp2hRwbk+2mPOOJrMKPSXxD/J8S0UmSau
   RZYfpY6Rfqam6Mrm3FIL7378I4NiJ04cEc9f1gIOcV831QQZ7RddblB/y
   gHgGtJmveLBXabLI9+vajcvIfCBYhhzJpNctWRAEhBQ07ToCBZQxAF1yO
   /DFj7k0FPySNSVUQKlISfbCSmHKTQ6v6S7tEgmog2q1A2EyGdcMZTNtGN
   DB7IEoy9fTX4UDdEwniCD/t3MlV5mZZONrmvBvSaJza2hH99/r3TT4l9m
   g==;
X-CSE-ConnectionGUID: Rcqqv1qZS4SmX2CMsJEirg==
X-CSE-MsgGUID: dGnnbf+FQx6LrQWEDpPxLA==
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="63313098"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Sep 2026 04:20:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 28 Sep 2026 04:20:13 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 28 Sep 2026 04:20:04 -0700
Date: Mon, 28 Sep 2026 13:20:00 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Quentin Freimanis <quentin@q-lab.dev>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, Lars Povlsen
	<lars.povlsen@microchip.com>, Bjarni Jonasson
	<bjarni.jonasson@microchip.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: sparx5: make ports inherit the switch base mac
 address type
Message-ID: <20260928112000.uzvaqkbaapiyjd2v@DEN-DL-M70577>
References: <20260928045012.30178-1-quentin@q-lab.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260928045012.30178-1-quentin@q-lab.dev>

> When the switch uses a random base MAC address it does not mark each
> port's address as random:
> 
>   $ dmesg | grep "MAC addr"
>   sparx5-switch e00c0000.switch: MAC addr was not set, use random MAC
>   $ cat /sys/class/net/eth0/addr_assign_type
>   0
> 
> 0 is NET_ADDR_PERM, so userspace thinks this is a stable address. Fix by
> tracking the base MAC address assign type in the sparx5 struct and
> applying it to each port's netdev.
> 
> Fixes: f3cad2611a77 ("net: sparx5: add hostmode with phylink support")
> Signed-off-by: Quentin Freimanis <quentin@q-lab.dev>

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
