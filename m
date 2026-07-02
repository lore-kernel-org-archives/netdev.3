Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092EA2E2DD2
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 17:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012329; cv=none; b=u39iFYNH6T9ttrGH4Jn570hVGE7jA5sQNHzRENyyfKBeB/7Ovd123PqPIlFYEoG2daj4cVtl9g4WRuy8Mr7/jrGWjy7ue+bgr9aq3JPB/AVDYDbIuZglJ/20Bto8sxcFWK1ossCKlIGO0aePLWhXryuVwXla4FaJRdkcg8EQ0HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012329; c=relaxed/simple;
	bh=z1cqIfGke7T0b8xMxNl/NhQAv83pNTgQHNtqjcDMa90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJb4lHJ5dyIeEZjDKmDA4oWwMoAn4QfDGm/C5fge+pR+jn8jRI2Vwb72gzWgnTv8o/G1i+SRX+vmYUom7oHj1xt/FuWh26X/i/A7FXg73XTuO1sreIQl6Z0jKD/JrOa6pRxUXa/MN2c+UzpsKGI2OkKXozR+E3MwTfBUvc+aYHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lIErxrsO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lIErxrsO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HGS+v1TKz5afliQ+dRAWzgxiAR6QloFBynSXvurA7vc=; b=lIErxrsOcv/ehkA9K6JG1kuNuH
	Q0TXsnYbhoWH/lO1yTSnv06z401jlklLwlAkdhDxg1Oy5Nom4/++ColJSnRb+oiC7aEvupKeuixl4
	76ieqvH/nQMWnMzO63VvJaIqYGlGg7O2JQdLe11XuVLoi9/kBmWc8k+xo7SaLUXpnKO8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wfKxJ-00APDF-JI; Thu, 02 Jul 2026 19:12:05 +0200
Date: Thu, 2 Jul 2026 19:12:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "D H, Siddaraju" <siddaraju.dh@intel.com>
Cc: Michal Kubecek <mkubecek@suse.cz>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, Shubham Das <Shubham.Das@intel.com>,
	Balaji Chintalapalle <balaji.chintalapalle@intel.com>,
	Vijay Srinivasan <vijay.srinivasan@intel.com>,
	Magnus Lindberg <magnus.k.lindberg@ericsson.com>,
	Niklas Damberg <niklas.damberg@ericsson.com>,
	Jonas Wirandi <jonas.wirandi@ericsson.com>,
	Siddaraju DH <siddarajudh@gmail.com>
Subject: Re: [PATCH ethtool] man: ethtool: link 10000baseCR to SFF-8431,
 Appendix-E SFP+ DA
Message-ID: <e603f91b-8f98-4101-a091-0e6007dfdec1@lunn.ch>
References: <20260702145002.1024439-1-siddaraju.dh@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702145002.1024439-1-siddaraju.dh@intel.com>

On Thu, Jul 02, 2026 at 08:20:02PM +0530, D H, Siddaraju wrote:
> From: Siddaraju DH <siddaraju.dh@intel.com>
> 
> Annotate the 10000baseCR entry in the advertise mask table so users
> understand what physical media this mode it actually represents.
> 
> 10000baseCR does not correspond to any IEEE 802.3 *base-CR PMD.
> It has no autonegotiation, no link training, and no mandatory FEC.
> The industry standard for this media type is SFF-8431 Appendix-E
> Direct Attach cable, also known as 10G_SFI_DA.
> 
> This change follows the conversation from netdev mail thread with
> subject: "the confusing 10000base_CR. Shouldn't it be 10000_SFI_DA?"
> 
> Signed-off-by: Siddaraju DH <siddaraju.dh@intel.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
