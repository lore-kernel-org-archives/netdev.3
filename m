Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504926;
	b=BwuL/If2+Hu3IxtohkH2AJKk1ZDWcdG5SpChLxoLBJiZOYSA08TrO3HQPRAi9mSfCLGi
	 DGFY9HQCO4AEgfk1+NbxNUBsS6ovgmMxZLBIIH580ZFvXYWYTAK5TMKarfLMEuw3rQrr/
	 bB9iI4gnrbLl5K2rSb0kyJwiOiWSTR+97oI+vmKyap3RRKt4FaOMWAPGcSJAkR6rbHpW4
	 vsP22AY42WMcU4eRlRjh1UGlz3qSgBW/ELdHJAtNuj68Oxo6xdwBF3sE6BNoGf/cg4N36
	 iGfBdZyV4hM4dRGzH9aHgsNEOiO4KRTy5GY9qZ0Ay+a7evo31xGgFGsvkGJsHFH091g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504926;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=3+1HCFOuIMN80iGsOQMwOgwNj3bEV3gIzKqis9v3+sA=;
	b=lRNxkfZMQAh2A0CqmDykqwjZtnWhEqsYwt2owOrgZdifyJNSPyih8MyEjPisApwWXW7D
	 Q/CfqQfjHONw34GTepXbQFuyO4dAsWL9sPSMX17pF/UjX45s2tscMuEA1QpKZcwH9JdCF
	 FLtnc+hfAnjIVWJYPd/d2suGPfWGuhwpXUghsSNXwZsrrgG63TnY/z1G/tCbDxjgdMx9/
	 sx8x1lIyFkj6k8CH8GYaxwTNuMKuEwOPquzu7PzLYVc7r8rCkY28W8TIB/r/moyXNTCL7
	 Q34wkg9Prmtw+O26IdYs+fEoXb1cboI/gQNNzzrTRQbLvMZtYWPnslTlEfXjWFYriYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=WmMrUH+L;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E956E606A31C;
	Tue, 20 Oct 2026 14:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E956E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=WmMrUH+L
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3+1HCFOuIMN80iGsOQMwOgwNj3bEV3gIzKqis9v3+sA=; b=WmMrUH+L8ohTFjXap/o2k7dg7m
	EvS6Ao5CrAHMcjflH2TU8T8ro/gCbkyDD4qJ3gNKKHFpOZA3JuHkqb1MHjAP8CTfuUgHhaDF0BkKp
	0Ea5dQyvJ9NJAym8KIXwh0FIDmQLydUohs+yN35I7F1MJ5yZccH17tVGhFzeXVLA2ulE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xJAPg-00BrVO-Gk; Tue, 20 Oct 2026 16:02:00 +0200
Date: Tue, 20 Oct 2026 16:02:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Prashant Sengar <prashantsengar25031@gmail.com>
Cc: netdev@vger.kernel.org, Thangaraj.S@microchip.com,
	UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH net v2] net: usb: lan78xx: avoid NULL PHY dereference in
 WoL setup
Message-ID: <3a48b21c-0209-4dde-9356-b127eb5fa58e@lunn.ch>
References: <20261019193148.1381545-1-prashantsengar25031@gmail.com>
 <d9177176-75c2-4273-b5ba-d0c6afdad6c5@lunn.ch>
 <CABW1sBkKtBt0gipBNsNRWbwYy3GSDbe2d0TMBX8=whwu4WQmJg@mail.gmail.com>
 <7bff1292-9371-4e3e-8062-31a554aeee17@lunn.ch>
 <CABW1sB=n--dJDK2zieM1bzOjG3AEwfZLTZ6HJrXLG+F1R1LB1A@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABW1sB=n--dJDK2zieM1bzOjG3AEwfZLTZ6HJrXLG+F1R1LB1A@mail.gmail.com>

On Tue, Oct 20, 2026 at 06:23:56PM +0530, Prashant Sengar wrote:
> Thanks, Andrew.
> 
> I understand that LAN78xx needs to advertise its MAC WoL capabilities and
> implement mac_wol_set() for phylink to handle controller-managed WoL.
> 
> Since this would involve additional changes and testing, I would like to keep
> v3 focused on preventing the NULL dereference by calling
> phylink_ethtool_set_wol() unconditionally.

So there are two different things.

1) Avoid the crash.
2) Make it actually work with a fixed link.

For net, you can do a quick and simple fix, which makes ethtool set
wol/get_wol return EOPNOTSUPP if there is no PHY. It did not work
before, it still does not work, so no regression. But the crash is
gone. And keep calling phylib, rather than phylink.

For net-next, you can add proper WoL support using phylink, and make
fixed-link work. Since it never worked, this is new development, so
should be for net-next.

	   Andrew
