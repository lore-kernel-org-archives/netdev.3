Received: from m101-out-mua-6.websupport.se (m101-out-mua-6.websupport.se [109.235.175.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC32377EC2;
	Tue,  1 Sep 2026 05:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.235.175.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788242351; cv=none; b=XFy+FF6Z9E7Cm0W8eIHndJaNGFO9CEQr2AUWZaz9OPWjwlte2YmpMUeyvUsbSYHGn2meKiEEl8DZNt7xkLePAg7fU0LC7Vwml42urH7jnImt3XzwcZ8jY118Rqe5no15+ql3dyqfeHrysMzAV/UxlNOdnpZJhor+4wk3St0WtFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788242351; c=relaxed/simple;
	bh=7uuRZp7qeKh4R7noNFIXIYhCuhsLsbYCAsIHUDE9vGc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C8yzHcFQIFwNeOQ1HaKNbU2Pa2vzs9UWynEf9rdtL388xid9jZUJ2wfxrBSXZEOl3FV/O1xZ8Lt1cbWwlbusAF3Bsj9ZOP9XWhf7hFVLQsJ/JokIHv0yRWsg8Ad9wVaUpVRrWE1fgEv6rcFvy6yaZpMcLBiJI11l1l+MmBiviPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=palvencia.se; spf=pass smtp.mailfrom=palvencia.se; dkim=pass (2048-bit key) header.d=palvencia.se header.i=@palvencia.se header.b=KZ5UTKMS; arc=none smtp.client-ip=109.235.175.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=palvencia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=palvencia.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=palvencia.se header.i=@palvencia.se header.b="KZ5UTKMS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=palvencia.se;
	s=mail; t=1788241715;
	bh=YygSGBZu0R6mtENe2yptPbGK7gd+pjUTcphUn2rVuTo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KZ5UTKMS6tkX5fwRrcxEB4s0bZWbepjd0YohsrdLoFy1Tgmo5Oq/tpdj7NYPwqWnV
	 YWgGVUmIHskDAeWgSoezOW01N1V6XZuniezQyMxb2vN5pAhYKbr61k0Sz5bu3kCrnX
	 ZAotHbPqXwMyVdCbh8mmg/tmUU+Ef6aj4OJWhJFfobxXNB9NlrEHzHOhpfF7DmrDkD
	 HCOefuXkRvcPvF1BUXJqEf3SKRUXubRwgP0oL2PYpo3N1BqxtQGPU+BMtaHXlnWmM9
	 hvIEtARyqbjM9JHo1ihbObu0EC/NH1Oqj4oexiVG6UY5aTCAjuABCz1wtGUBaiOiuQ
	 05JeiBjexsung==
Received: from m101-u6-ing.websupport.se (unknown [10.30.6.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by m101-out-mua-6.websupport.se (Postfix) with ESMTPS id 4hYvzl60sSz1GVb;
	Tue,  1 Sep 2026 07:48:35 +0200 (CEST)
X-Authenticated-Sender: per@palvencia.se
Authentication-Results: m101-u6-ing.websupport.se;
	auth=pass smtp.auth=per@palvencia.se smtp.mailfrom=per@palvencia.se
Received: from rpi (unknown [213.204.219.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: per@palvencia.se)
	by m101-u6-ing.websupport.se (Postfix) with ESMTPSA id 4hYvzg2Zqwz2k72;
	Tue,  1 Sep 2026 07:48:31 +0200 (CEST)
Date: Tue, 1 Sep 2026 07:48:27 +0200
From: Per Larsson <per@palvencia.se>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Liu
 Changjie <liucj1228@outlook.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/6] arm64: dts: allwinner: a523: x96qpro+: enable
 Ethernet support
Message-ID: <20260901074827.39a649bc@rpi>
In-Reply-To: <20260809134607.65d66069@rpi>
References: <20260803101452.2993721-1-andre.przywara@arm.com>
	<20260803101452.2993721-7-andre.przywara@arm.com>
	<20260809134607.65d66069@rpi>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Out-Spamd-Result: default: False [1.90 / 1000.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,outlook.com];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:35790, ipnet:213.204.219.0/24, country:SE];
	RCPT_COUNT_TWELVE(0.00)[19];
	BAYES_HAM(0.00)[40.30%];
	HAS_X_AS(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	LOCAL_OUTBOUND(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,sholland.org,armlinux.org.uk,outlook.com,vger.kernel.org,lists.linux.dev,lists.infradead.org]
X-Out-Rspamd-Queue-Id: 4hYvzg2Zqwz2k72
X-Out-Rspamd-Server: m101-rspamd-out-4
X-Rspamd-Action: no action
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 466
X-purgate-ID: 155908::1788241715-3F2551C6-327DD7E6/0/0

On Sun, 9 Aug 2026 13:46:07 +0200
Per Larsson <per@palvencia.se> wrote:

> On Mon,  3 Aug 2026 12:14:52 +0200
> Andre Przywara <andre.przywara@arm.com> wrote:
> 
> > +		pinctrl-0 = <&ephy_25m_pin>;  
> 
> This should be &ephy1_25m_pin, right?

With this typo (and the one in patch 4/6) fixed, this series gets a
Tested-by: Per Larsson <per@palvencia.se>
since it eliminates the need to use hackier methods to get the ethernet
port to work on this box.
