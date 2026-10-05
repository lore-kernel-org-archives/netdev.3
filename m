Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB53B476051;
	Mon,  5 Oct 2026 09:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791194273; cv=none; b=tS0Yn9sBXg3oiNdk0esRvl7dq2D0qK+gP/4nbtGc4ehVS/C9/3JrP2P2LQywXa8XlPgS5Y1o2H4PxgErzvNuwYEyXCD9D6NbW+87bZtupwoOTauiFFhRE7OSS45B3YoYgJ5d7k+vSi3d5NcOQIuSGyS7TeSrwgdWKg0sRNMMPVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791194273; c=relaxed/simple;
	bh=NW+JFu5AUhMGQatFQG++BrYi5Vx0rzk0ULHspNSVPCQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJYeZlsqtuctQHe3RaK0QvLK4UOLpiD5YKB2Npb+FL6RzoKQ9PMFpJEU1tEIm5PN59YFSAW0q6I2f/iLU6+0FYy1RnV0PLbIl788tS66RmvLHcCUE78HrIVE0e1NSQWGJBQkdYVi3akaYqzzKEFh9qoaYCaTJ/XkpZc9uePTtnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=JeLV21uA; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JeLV21uA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791194269; x=1822730269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NW+JFu5AUhMGQatFQG++BrYi5Vx0rzk0ULHspNSVPCQ=;
  b=JeLV21uAMPdW4WxUAPOWOrNXuOd3gZv+71FkGGr3It9geOiC3NJK3PEX
   IcCFTQYGftHzzdxph1EnI6C4AxXb7K93arNqQVcn4n7dxOyPckToUwE+d
   rFNWaRYrtiBsN4XAE5uinpMOSM5jzHAQMnxdziWbbD5xElVvlPFp1Jr9F
   e9Ku0mLJvxIWoNP3lZTsmzVpHDuvnUPezQ9QpMtzxjcNjzPSofBjjJw4v
   bqrstaoIVMesOxY+hS3chFDxZ2p58pRgdwv18YhPehurQIcuT2F6wkVND
   my4+nv3oTLYnwN1EA8rpXmZdRmhlzi4Zz8Os42AyHQLPyvo51UwjtQfy9
   g==;
X-CSE-ConnectionGUID: mf9JFqQZQsKivlfVwyVS+Q==
X-CSE-MsgGUID: Lr+9/NGDRwWxqeEnXMMI9Q==
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="74825005"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 02:57:38 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Mon, 5 Oct 2026 02:57:37 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 5 Oct 2026 02:57:35 -0700
Date: Mon, 5 Oct 2026 11:57:35 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Quentin Freimanis <quentin@q-lab.dev>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Richard
 Cochran" <richardcochran@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] net: sparx5: start the TOD counters on non-PTP
 lan969x variants
Message-ID: <20261005095735.jzzlcdf6oljxpdpx@DEN-DL-M70577>
References: <20261005052826.14251-1-quentin@q-lab.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261005052826.14251-1-quentin@q-lab.dev>

> Currently the base non-PTP-capable lan969x variants don't forward any
> Ethernet frames:
> 
>   $ ip link set eth10 up
> 
>   $ ip addr add 10.0.0.54/24 dev eth10
> 
>   $ ping 10.0.0.1
>   PING 10.0.0.1 (10.0.0.1): 56 data bytes
> 
>   --- 10.0.0.1 ping statistics ---
>   7 packets transmitted, 0 packets received, 100% packet loss
> 
>   $ cat /proc/interrupts | grep fdma
>     20:          0  GIC-0  120 Level     sparx5-fdma
> 
>   $ ip -s link show dev eth10
>       RX:  bytes packets errors dropped  missed   mcast
>            20828     102      0       0       0      72
>       TX:  bytes packets errors dropped carrier collsns
>                0       0      0       0       0       0
> 
> Testing showed that starting the domain 0 TOD counter gets networking
> working again, but start all three for consistency with the PTP variants.

Tested-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Daniel Machon <daniel.machon@microchip.com>

Thank you for the patch! :-)
