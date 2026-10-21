Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792581937;
	b=Rl2Iul1n4xmRQ4z0UvEbPPNpFfv8FSLHiD3ls3+ZykkjSLX3xr8RyYhXR7mf8ZIwJSMW
	 bCLkZ00Vg+KJ3WabFI2vF5vrJPnFT+WMRzaLkbAGMVx4CYHONims92/7LhnNCFQNmAHvz
	 lH1Wjh9NKD7F+g8moRck998wGYQqyhJFUDfbasNwnX9JRxxQAE6ioQ6xqLmvLhdV25b0+
	 HCFqhFcOCzKi199nisIBaIx8IyTSIfCR6pzdzU/CxDxdOB/63pfLn/vrxcpFxvHPoMtO8
	 FBk3PlOUb5QIIS/rrreky0l9HFT7evOKnGWA3mxLRdeUOkdhjgM0SmneiPxaVQVWWVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792581937;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=e4Ze/vAO+3B8RU6Gc23uzZvY6MDhudox9hNR2cpt0FU=;
	b=aJ0HnbeOrfRkY/jovqozTWgNyzvpyRUcxhryirv5KG/EWzH9HXAsTOfiVr6UJLqAmeoM
	 u4klvbNJjht9s2kOmCjiFvvz1Dz9wdsZKSoObq6Wgm+q35uvphIZEIKTiwK1vwYXxlLDq
	 K+Ow90Sx2dwgbzzDPiO7QsQolSwMS6G257Iu7dKuqEdm3Or+sUQiUl/MgAL77pqota/P+
	 3ekgi1Zm+G3tl5cMMAFkFPJs97aeLRHpxq61E2hAmUaph9Kxc/yF5DI+W8pJzeyqsn9Tr
	 gKUyvOVwnJQTPxRvEplwvxz7bJDYyH6f3DVyEKO37b/9/NRm9FtJR52UegmtOyt5X2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=FLGmsb+k;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4481F606A31A;
	Wed, 21 Oct 2026 11:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4481F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=FLGmsb+k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792581937; x=1824117937;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f6mbtOsoHCOt/e4/sMr9Gei9ixDW9trlJp/NUEcYDZ4=;
  b=FLGmsb+kXXRda+QGqP7ExnbY6vQcffVVSgnL7TsodOK1I+3fYA5+jImJ
   t4ZgE6rymuA3/l/cRMZCeCZ80Yp2vX8auNS/goc5cUwoAO5fP6obw6ZXv
   oAbBW5QTxtATh6z8f1WTQT4o/7osPEswTeZCPX/hX46WXS/vYe2JuLBXC
   xegOaJCtjLZvT6phHnOOt+4fmA/Z4sY4zPb2LZyCr+t8ebfP+Zq3HlIYS
   8vcpaa6zMVkw/cTV2asKaJ+DCjJoqVTwMkKwtj87O9KV19W+rANcsEpL7
   z1kzKnJ+bUcK2MEMtX2syyjtGAeO8LG9TYswE+IekrAdzpwVjDBH1rQVn
   w==;
X-CSE-ConnectionGUID: lWCzV498TpKkNg5mcN8lnA==
X-CSE-MsgGUID: +wcjJoM9RbWrVnCYe05rdw==
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="65361838"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 04:25:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Wed, 21 Oct 2026 04:25:35 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 21 Oct 2026 04:25:33 -0700
Date: Wed, 21 Oct 2026 13:25:33 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Bjarni
 Jonasson" <bjarni.jonasson@microchip.com>, Lars Povlsen
	<lars.povlsen@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: sparx5/lan969x: do not read past skb->len when
 injecting a frame
Message-ID: <20261021112533.m6fh7xoqp74uevho@DEN-DL-M70577.microsemi.net>
References: <20261021-sparx5-inject-tail-bytes-v1-1-7dcc035c8ddf@microchip.com>
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
In-Reply-To: <20261021-sparx5-inject-tail-bytes-v1-1-7dcc035c8ddf@microchip.com>

> sparx5_inject() writes the frame to the injection FIFO one 32-bit word
> at a time, and pads frames shorter than 60 bytes with zero words.
> 
> Before this patch, the last word is loaded whole even when skb->len is
> not a multiple of four, so 1 to 3 bytes past the end of the frame are
> read. For a frame shorter than 60 bytes those bytes are also
> transmitted, as VLD_BYTES marks the whole last word valid and the
> padding starts at the next word.
> 
> Write the trailing bytes from a zeroed word. The number of words written
> and VLD_BYTES are unchanged.
> 
> Found by an AI code review agent, and reproduced on lan969x and sparx5
> with register injection: bytes 57 to 59 of a 57 byte frame were not
> zero. With the fix they are zero, and traffic still passes on both
> chips.
> 
> Fixes: f3cad2611a77 ("net: sparx5: add hostmode with phylink support")
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>

I somehow forgot to include the target tree. This one goes to net.

/Daniel

