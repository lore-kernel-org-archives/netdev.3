Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6267B4DDB48;
	Tue, 13 Oct 2026 10:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791885611; cv=none; b=HSdf5/jGWgw9jyRI1geNQ+yV+xWalQLv4jxIJo1ULsavktpB1BVmzjkRKw2rDSyDwca0xdjn+/40aXr468hmzrM3UWjp22tBVCjhWeOKN6DRiCEPANNd6Qq+UwigVHsuMQWj+TQL39/iX1yiylSsDaxnbepnx4v2vZ4lMRD6mko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791885611; c=relaxed/simple;
	bh=jRNeLEc4CkFn+42K5GGoJxjsljglo+VbUJsXlv25BsQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWKIsLVBVjJ3FLvLyfUNU54BLIbqNJUnUYskjM/oeWIwfQGp8nwYv1KS47iXDHqpb7Xt7BrV6ZExxga1p9pLeakeOSVIuvzPfewkb4yAvMNytJ7Xvk3qWQGCLIlTilFQ1IsjF3FUfXrPF736r/N8C/brQRGvgA40YJMWe3CWeDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=z/Wkm3je; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="z/Wkm3je"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791885608; x=1823421608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jRNeLEc4CkFn+42K5GGoJxjsljglo+VbUJsXlv25BsQ=;
  b=z/Wkm3jewuS8PTV9yHaQdGCZvjW3SzOAJ3iuM8ufpx0VZ0X2IXzh5QUw
   d3WcZ6TgA8ZHj5rgjq7dU8XDTIN8zWUJfKjOhD521+hg4IrF1d3tZ3vgn
   vC2RoFUjg6JjkgUTI7zt/JQ0sc0DtEVxCS/oq+/d8m4utl8Ls0sc+//bJ
   Hklf0V2pZPv3aBN/2YBF0rzx4r0N7uIp7XFvMW2GHjVlWu9Ck9GnJj9wc
   P19tCyC1sVdRhqdeWwRkKl4QvALkhVGchu61ZGM5FvC5qG8avoCatd9v0
   wh8XzpcyRi3DWW5vRmsXwpyvyDY+LaCoZRZKHiOEoKcUJ35ATI+sEM1qG
   w==;
X-CSE-ConnectionGUID: vpaZhoqiTvOZpvi+qGlENQ==
X-CSE-MsgGUID: EeHeYAIxRjKQvbUbgYF2XA==
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="232039876"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Oct 2026 03:00:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 13 Oct 2026 03:00:07 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 13 Oct 2026 03:00:05 -0700
Date: Tue, 13 Oct 2026 12:00:05 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Rosen Penev <rosenp@gmail.com>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, open list
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: ibm: emac: size RX buffers for the MTU
Message-ID: <20261013100005.37so7rsuq7e4meol@DEN-DL-M70577.microsemi.net>
References: <20261008035122.3182851-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261008035122.3182851-1-rosenp@gmail.com>

> Any MTU above ETH_DATA_LEN selects the largest MAL buffer size of 4080
> bytes. A DSA conduit always runs with a slightly larger MTU for the
> switch tag (1502 for qca8k), so every received frame then uses an 8K
> slab object and a 4K cache invalidate even though it is at most 1520
> bytes long. Size the buffers for the MTU instead, capped at the MAL
> maximum as before. Larger jumbo frames still span several descriptors.
> 
> emac_change_mtu() only resized the ring, which is also where the jumbo
> mode and the APM821xx maximum jumbo size are programmed, when the RX skb
> size changed. 1500 and 1502 now share a skb size, so also resize the
> ring whenever the old or new MTU is a jumbo one. Otherwise jumbo mode
> stays off and 1502 byte frames are dropped when the MTU is raised while
> the interface is up.
> 
> Routing a single TCP stream through the qca8k switch of a Meraki MX60
> (APM82181, iperf3 median of 3, A/B in the same boot):
> 
>           LAN->WAN   WAN->LAN  (Mbit/s)
>   before  538        476
>   after   564        498
> 

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
