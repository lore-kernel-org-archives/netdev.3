Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE142388385;
	Mon,  3 Aug 2026 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785775598; cv=none; b=t/LlDJ0q7jL6wjvby1u8bIsutI53Ze+aowEtm8uIBXXlp/jtcQGJ51wSPait1kSfdkCG77EFtQ6FAsySgyQeglECuZvcB/a8KNa6vxX/bc9uLy23UiKCHN32Ab+8cKWzP0Ev+KvwH5w81ksu68EsAJplRG2L9wtb6Cs92/UfhGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785775598; c=relaxed/simple;
	bh=Pbh6UPSpoybrpGLQu1d+4xoK2AIsAMzDFDDk/7PPQy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=raN0Q0a/N/JxY008vSN2rnz0Lr+BmVsKYJGCotN62ZTzsZHTV1g+59RnhfSHfLaVE0UEV0xxQpyqarcuxQc8Ptgdbc4TXekkqLlL6ktHPd8vAbNwBeg4UKq4frIDfBtMMiLiC9J6vwREDmPaCfDUBzfuok5lh5yRCe5HZWvpir4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=D8VXbyXn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="D8VXbyXn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=p3P51v8Pp+kfjQZvn9d42tiHB+e6mckj4zmi8I6qVew=; b=D8
	VXbyXniBMuPzK6zM7bemsOaGltWS/XM9WsWaPHsbC1enc6l197I2vr8xAihV6muWLnKLNZHVj/R0L
	tkqcowWTHW4ItTdrlfs03/olDrfsVXdh0S+EeW1ckyZK37vSA2ARkiNIWfBrbXjUto3MmNDc8d7rB
	T8W7hkxgLgr6cwY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wqvo4-00Fm6D-Pk; Mon, 03 Aug 2026 18:46:28 +0200
Date: Mon, 3 Aug 2026 18:46:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Martin Kaistra <martin.kaistra@linutronix.de>
Subject: Re: [PATCH 3/4] net: dsa: Add support for SoC-e SDSA tags
Message-ID: <6129c629-370e-4081-89d2-6dbf1a142cd7@lunn.ch>
References: <20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
 <20260729-devel-vstrassheim-soce-dsa-ml-v1-3-be569dae1b20@linutronix.de>
 <df7e7e04-80fc-4b80-9afd-0e9bc14a759f@lunn.ch>
 <723a256eb9d5aa64e7037f98eabeeb99257f03f2.camel@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <723a256eb9d5aa64e7037f98eabeeb99257f03f2.camel@linutronix.de>

On Mon, Aug 03, 2026 at 05:37:26PM +0200, Vasilij Strassheim wrote:
> On Wed, 2026-07-29 at 19:22 +0200, Andrew Lunn wrote:
> > > @@ -98,6 +98,12 @@ config NET_DSA_TAG_EDSA
> > >  	  Say Y or M if you want to enable support for tagging frames for the
> > >  	  Marvell switches which use EtherType DSA headers.
> > >  
> > > +config NET_DSA_TAG_SDSA
> > > +	tristate "Tag driver for SoC-e switches using EtherType SDSA headers"
> > > +	help
> > > +	  Say Y or M if you want to enable support for tagging frames for the
> > > +	  SoC-e switches.
> > > +
> > 
> > These entries are sorted, so it probably should be between
> > NET_DSA_TAG_RZN1_A5PSW and NET_DSA_TAG_LAN9303.
> 
> I will insert it as suggested. To better understand, what is the sort order?

The tristate string.

    Andrew
