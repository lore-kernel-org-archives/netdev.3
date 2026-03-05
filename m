Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30493A4F52;
	Thu,  5 Mar 2026 14:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720709; cv=none; b=qhrRwZfuq2jfbAOKhb0wSLreMZNMdfxHckqhCAMGaabqh7ausHv+hBD7dXZncrrNRnZ+qKusnN/z1rLnHRTSSmlorcv7/psTTrX8+HqjAF8qS60xc7D6Og8IJNrEFyYwSWuWoLhkV83bXZcPM4MzbD8hOaOxNwVyy285hkYD8vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720709; c=relaxed/simple;
	bh=jn3SqFSE9NEUL3pJAHFag0dmu3pCOQda1YU7o+1IXR4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZLqJproFfsRvWrnRLhRyhjs3bwq+RQ0v7zOQW1HMuAY1V2jVAsf+zHZeGHiKPzShnlccxr/X+Cc+FhgquAuPsBCcF7D6eIQnP5BSHnE2BdpanHPiAYVq7skT0c3WG+m5Q+/aAKRR1m+i6SEEgZWcuWrwLPubbsjUnkiho/tAVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wma/8TQ7; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wma/8TQ7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772720708; x=1804256708;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jn3SqFSE9NEUL3pJAHFag0dmu3pCOQda1YU7o+1IXR4=;
  b=wma/8TQ7RZYXLxLnx2zp7oAOkEUU9PGJ0imQEDi0HkL89z+tXwWu1sXo
   58CSEkalU017Duedqi7Zcn3//7Oa+hXe/LUeL5Rd9caerNISi+TixJ/Xq
   LtSa00Nv/3JczsoN7nkFAlYg26rj4QImbQIKTupXHJW10W+AVnLj96ZIt
   VgdbuCjBgNoDMajNxG+AFhUJm/sKAKCidFSDZ0eQF8jbfkDF1ry0JpT+l
   LTFnfhausvz8VlJyVZieIx97WF27d71ZfYC5KgnTBX2hIhwEIeu52fAXE
   pq9JlVYEALNwdJGEbxdydVaqb1zgv6B6K8mhwUaQvJU14mXXOWavJS9xf
   g==;
X-CSE-ConnectionGUID: T+2/TH5KS++p/V5ngvAyDg==
X-CSE-MsgGUID: /0KFBbrhTb2iQZBGPVTvNA==
X-IronPort-AV: E=Sophos;i="6.23,103,1770620400"; 
   d="scan'208";a="54265876"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 07:25:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 5 Mar 2026 07:24:26 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Thu, 5 Mar 2026 07:24:25 -0700
Date: Thu, 5 Mar 2026 06:24:24 -0800
From: Charles Perry <charles.perry@microchip.com>
To: Simon Horman <horms@kernel.org>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, "Claudiu
 Beznea" <claudiu.beznea@tuxon.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <charles.perry@microchip.com>
Subject: Re: [PATCH net-next 3/4] net: macb: add safeguards for jumbo frame
 larger than 10240
Message-ID: <aamSGKwG4i+7zBqV@bby-cbu-swbuild03.eng.microchip.com>
References: <20260303180318.1814791-1-charles.perry@microchip.com>
 <20260303180318.1814791-4-charles.perry@microchip.com>
 <20260305114010.GD90938@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260305114010.GD90938@kernel.org>

On Thu, Mar 05, 2026 at 11:40:10AM +0000, Simon Horman wrote:
> On Tue, Mar 03, 2026 at 10:03:17AM -0800, Charles Perry wrote:
> > The RX buffers for GEM can have a maximum size of 16320 bytes
> > (0xff in the RXBS field of the DMACFG register means 255*64 =
> > 16320 bytes).
> > 
> > The "jumbo_max_length" field (bits 0..13) of the DCFG2 register
> > can take a value of up to 16383 (0x3FFF). This field is not used
> > when determining the max MTU, instead an hardcoded value
> > (jumbo_max_len) is used for each platform. Right now the maximum
> > value for jumbo_max_len is 10240 (0x2800).
> > 
> > GEM uses one buffer per packet which means that one buffer must
> > allow room for the max MTU plus L2 encapsulation and alignment.
> > 
> > This commit adds a limit to max_mtu and rx_buffer_size so that
> > the RXBS field can never overflow when a large MTU is used.
> > 
> > With this commit, it is now possible to add new platforms that
> > have their gem_jumbo_max_length set to 16383.
> > 
> > Signed-off-by: Charles Perry <charles.perry@microchip.com>
> 
> Hi Charles,
> 
> I am sorry if this question is a bit naïve.
> 
> I understand the need to clamp the max_mtu to avoid overflowing RXBS.
> And that this hasn't been an issue up until now due to the maximum
> value of jumbo_max_len used in the driver.
> 
> But I'm unclear on the relationship between DCFG2 and the max_mtu.
> Why does it need to be set to a value larger than that corresponding to
> the maximum mtu and RX buf size?
> 

Hello Simon,

The DCFG2 register is the max_mtu value, there's some public documentation
for this for AMD versal [1]. "gem_jumbo_max_length" is a define in the RTL
code, the hardware designer probably makes a tradeoff between gate count
and the max_mtu. The maximum value for this is 0x3FFF (16383).

The maximum buffer size is 255 * 64 = 16320

The GEM driver, in its current state, uses one buffer per frame, so the MTU
needs to be clamped at the maximum buffer size.

We could just set 16320 instead of 16383 into the "jumbo_max_len" of
"struct macb_config" but it would mix information about what the hardware
supports vs what the software support. My approach is to put what the
hardware support in "struct macb_config" and clamp it later when
calculating max_mtu because we know we have a software limitation.

Thanks,
Charles

[1]: https://docs.amd.com/r/en-US/am012-versal-register-reference/IP_Config2-GEM-Register

> ...
