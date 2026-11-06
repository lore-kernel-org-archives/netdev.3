Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980208;
	b=vEEwalZPDAeeIj1UJ3Ag5MV+32iHQgcHuf634zKtpoPyzv6CBnppCTNoG5zHrviaOrGE
	 EbLXTZQqPXvcXk6ubtq/lXSiEYoFZC8jSWUf85+6mcJoJBzq1YAJeaUXrKdC5UlDRKs6W
	 REH0usqcKvC9ywjbYBrX2XJtZSNu2MrIuTyJ5/yqktkAnd8d1CL5i44GoalJMIJQpnjiU
	 haSUD1oTXwzl9sUQT/vK/AFTxIGgFwgV0jUi9w10/zIrX4oaEiUIiy4fKuJkAdLJlzDLb
	 afliNBy9HFSphA4XAopjZcoexSji/0M1DuM23rZnFT6Vbk9RHxqb1kq7scwJZkK/qOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980208;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=JPEkW85xL2Z5vupw5pGm1IHF5rTDX0+GjSNThZXwTZg=;
	b=w4xx72bfvdc4/o6zgsEZ8UHwvwuzOxyy2oWTO/68Ds38g55/9lDMeSIQxnE1X6KXr838
	 vTFu5MrYM0UCnosmbVd+pH9I5bmy+s0kdemCvlSehRbBvTDX18fiVySCLcQJcOhb43Yp1
	 nmkZc13mUsqxCa2jlsagQyIiDLjIbJj+/jd0MsNGm7NXy7whEorFRSlBFLxVHJ4I5VUz0
	 ZZw+8aEOo4TfuMYPKJpSiFhVF9FtkgPqDtPsSqwcgzEKEHgcAUvJlzyWYFdVRjDFoGRFJ
	 fT+I3hS2Hz6wcqKPP6LYbIN8d1xgpUUrXa82TVLgmJ/XSuIsx2WmJtQjldR2KFMEdrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=lVCBXira;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AFC606A329;
	Fri,  6 Nov 2026 15:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5AFC606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=lVCBXira
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JPEkW85xL2Z5vupw5pGm1IHF5rTDX0+GjSNThZXwTZg=; b=lVCBXiraIWnb4pXc0OF5xvO3h7
	E6y6zXegrJarYm7dxIjD/4YC8kdatUyKVZCJY2dqenTxhxbni5PlMBJ/aGE7bV9D5PhIKl9HArtgc
	HrKgw8350NW0Ig7wtiRFi0TzteXQ0++4S7Qrh/t22cZhENlbO+FuwvEHqXnJq0Bsa2kQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xPMCF-00EoSL-4g; Fri, 06 Nov 2026 16:49:43 +0100
Date: Fri, 6 Nov 2026 16:49:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>
Cc: Mieczyslaw Nalewaj <namiltd@yahoo.com>, linusw@kernel.org,
	olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk,
	luizluca@gmail.com, maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 08/10] net: dsa: realtek: rtl8365mb: re-latch
 the family D SerDes
Message-ID: <c5881bc0-8773-434a-8aad-2346a58bb146@lunn.ch>
References: <3bf4dd70-9771-497b-8c27-e925e0ef81eb@yahoo.com>
 <3ecac0ea-830b-47a0-931a-67fea637f0c3@yahoo.com>
 <au3hdMxLSilNxhnK@analog.com>
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
In-Reply-To: <au3hdMxLSilNxhnK@analog.com>

> > pcs_config() runs seconds before the far-end MAC even starts
> > configuring, so a single edge driven from there is not enough: the
> > receiver has nothing to latch onto yet. Neither is pcs_link_up(),
> > which is seconds early for the same reason. phylink does not help
> > either - it never calls rtl8365mb_pcs_get_state() for this port in
> > the first place, since mb->pcs.poll only arms phylink's own poll for
> > in-band links, and this CPU port is a fixed link.

Sorry, not been following this patch series.

One thing which might help here. Russell once said it should be
possible to use phylink with pcs to pcs links, rather than use
fixed-link. You then get all the phylink machinery, which might
trigger the pcs negotiation and get your link up?

I don't know of any board which actually does this, so i've no idea if
it really does work.

	Andrew
