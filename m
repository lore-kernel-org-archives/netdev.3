Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57313BE179;
	Fri,  9 Oct 2026 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791537523; cv=none; b=Zf9YlCyptgHF2rI9QAB/Bvfz7QF9ff9GrPFQJhATcY/tAz7g2/Guq6V8shzMBs8NqA9BmXEvN9JBNXyJu7iKvh6ztwPVpmtSuF+4gISHiino4jXDdJ5iEaZaHGTCL7oxVT5xqdY9CJBTlVACjU9kQTTCBzmZzcmuSzgSiw1OW68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791537523; c=relaxed/simple;
	bh=xEp8iSDf+itQYNWGe8wti7pDxJf+ETt9+5LmDUKAVVU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aho6BdI81dvUncO2fN5CUKtn/RS51vtrzK/8TGoP/BAZ0riRyVI7I4P6WBTlTngyI80kqtaNBkGloGqfnL8q7QtWloYPuiy7kCFlVDcm+9mhOYodcz59SM5VB1ny8sBcg3GvTOHt69wJvNo9rramC6z7uPScYW0eTLDF4euFxrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=uZQGo3ik; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="uZQGo3ik"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791537521; x=1823073521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xEp8iSDf+itQYNWGe8wti7pDxJf+ETt9+5LmDUKAVVU=;
  b=uZQGo3ikdP1gX3ciENjMSFlPVDbtOALe3YFS6LSZBQZFsMq9nwV2fzOP
   GzY4M43q2RDC0zm9cUpO1K/VbM8G+9C+EM74o7wQMbklob01D6ofn0fJ6
   vbAxFgSnlQ3bpB00x0HM6JPgekZPl8S1vI24zZrP4LwuNYYsjGN0eP9X/
   rM1QdsHanrnoAVOYtMlC2QX4TtOBozIW/Ekl+OYOyXG0Py30r0giYQEeq
   LVzm7odaXtpKYFN1pJVyv6uVrZJvhlYBpwLZq2sz0b63cc9RwvlZqG64a
   E+c1viJnbTflcBsBfPEQe7x65HGXjuxeZMLYfgoMlFDasSPH3Jle5NRIM
   g==;
X-CSE-ConnectionGUID: ke98S+dgRzyPT1gXT4BY0w==
X-CSE-MsgGUID: E2u2KsBCSCKNeTccKkIWzA==
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="65085340"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Oct 2026 02:18:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 9 Oct 2026 02:18:35 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 9 Oct 2026 02:18:33 -0700
Date: Fri, 9 Oct 2026 11:18:32 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Rosen Penev <rosenp@gmail.com>
CC: <netdev@vger.kernel.org>, Chris Snook <chris.snook@gmail.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] net: ag71xx: Use default NAPI weight
Message-ID: <20261009091832.zpg546of2sbhzung@DEN-DL-M70577>
References: <20261007173628.657527-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261007173628.657527-1-rosenp@gmail.com>

> Drop the custom NAPI weight and let netif_napi_add() use the core
> default.
> 
> The old comment claimed larger weights wasted cycles and cache, but
> recent RX and TX path changes altered those tradeoffs. Keep the driver
> on the standard default unless measurements show a device-specific value
> is needed.
> 
> iperf3:
> 
> Before:
> 
> [ ID][Role] Interval           Transfer     Bitrate         Retr
> [  5][TX-C]   0.00-10.00  sec   327 MBytes   274 Mbits/sec   31            sender
> [  5][TX-C]   0.00-10.00  sec   325 MBytes   273 Mbits/sec                  receiver
> [  7][RX-C]   0.00-10.00  sec   170 MBytes   143 Mbits/sec    0            sender
> [  7][RX-C]   0.00-10.00  sec   170 MBytes   143 Mbits/sec                  receiver
> 
> After:
> 
> [ ID][Role] Interval           Transfer     Bitrate         Retr
> [  5][TX-C]   0.00-10.00  sec   341 MBytes   286 Mbits/sec   30            sender
> [  5][TX-C]   0.00-10.00  sec   338 MBytes   284 Mbits/sec                  receiver
> [  7][RX-C]   0.00-10.00  sec   184 MBytes   154 Mbits/sec    0            sender
> [  7][RX-C]   0.00-10.00  sec   184 MBytes   154 Mbits/sec                  receiver

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>

