Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792500984;
	b=TIdtzhKA4Y4GqmCvO1TZtiE/zQ7/8tyANMoFQKLiaGZZm/NwZP1JDxalJYCZsmi7mZw6
	 5LH8ecK+JTYOsjGL+UfytKfaI6jnzqs+auvlHbLifAlKbpPraLcBL4hTHtUgoOLdIsFMO
	 fnW+S7M/jN/UXfmdETjPbfAUXtsZ/Lk7F1tdSpce6QV2ZxJxBWA68GgAaHB2c5Gb9HTMM
	 0wWNbMTCZJ5OkmVCYQoJIeJfjZy49Cxoc5oHn608Ev3g8Fnl9+1Enq9NWVstkiN6UEWF1
	 HtEHz2fdXpkkb9MbPlHCbRntzHRvdyzvQfGqXZqplADCgCmtPlTAjWcrwizUyS8Lohg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500984;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=y0p+Q9LXzaLBIMMlJ/HBg2Ufthoue90ekRvJZpos6F4=;
	b=1/jKeQ/IyowDGwz/udnIAVmlix8ndFOlcGd7XEoXFfXc0JBRn6uZ5zE9+aKwyHmZORyy
	 DbpfAuz+bLNubs0ayPLzL+z823ZYO/mLl7IwyU+/Pgcam3fd4e7L+Fqid8SxcTfQYThM8
	 sdYOzWi4sed9+reuv4hj2L45emr/GQhGyelqGypeyIlyvQLsfD8wUHa47645dZafnUq4n
	 tCdS/TL6V8ve/mRJOvJw+qwSBS9u7pn6QiF8R8ilZKx3SSezhAKlRZYioOvh2+UnmjnsR
	 iiqdmy/YodnLEm8FmVt6aadjvHx066AYoU0lS1BKR44i5e6/zF1LxipIvdm+APGlrrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=KLdm+iez;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EA6606A320;
	Tue, 20 Oct 2026 12:56:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2EA6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=KLdm+iez
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=y0p+Q9LXzaLBIMMlJ/HBg2Ufthoue90ekRvJZpos6F4=; b=KL
	dm+iezZN1XbqjBdBIVyQy3lrsCMavNDDGnIyOJfdkA83PhDX1gtJ9gtMTwx3KteDWG8Nm7Ho4R8Xs
	bfVjCg5ZFkeTaChEaj9MjorqW0K5PHe/Wx8Lp4jAGhHqQ0IHVkiZp4jcM6FXrsRrVlP04RbuNPJEV
	ojdqriEU5n+rfOc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xJ9O4-00Bqqm-Pz; Tue, 20 Oct 2026 14:56:16 +0200
Date: Tue, 20 Oct 2026 14:56:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Robert Marko <robert.marko@sartura.hr>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, lxu@maxlinear.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, lgirdwood@gmail.com,
	broonie@kernel.org, michael@walle.cc, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	lrosu@maxlinear.com, luka.perkov@sartura.hr
Subject: Re: [PATCH net-next v3 2/5] net: phy: mxl-gpy: add MxL86211C VDDP
 supply
Message-ID: <45f51f5e-9055-40cb-9e2c-4b53175556f1@lunn.ch>
References: <20261020093655.344585-1-robert.marko@sartura.hr>
 <20261020093655.344585-2-robert.marko@sartura.hr>
 <554ff2eb-af27-434f-be62-17246c7a302a@lunn.ch>
 <CA+HBbNF7DKkwu9X2=cykc1brHLmVnbYJe2VqbOH71S3sULu57A@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+HBbNF7DKkwu9X2=cykc1brHLmVnbYJe2VqbOH71S3sULu57A@mail.gmail.com>

On Tue, Oct 20, 2026 at 02:49:01PM +0200, Robert Marko wrote:
> On Tue, Oct 20, 2026 at 2:39 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > +/* Packet Manager Control */
> > > +#define VSPEC1_PM_CTRL               0x0c
> > > +#define VSPEC1_PM_CTRL_MDIO_VOL      BIT(14)
> >
> > Is this Packet or Power?
> 
> The datasheet calls it Packet Manager Control.

O.K, great. Putting Packet would be the sort of dumb typo my
brain/finger connection would do, so i just wanted to check.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
