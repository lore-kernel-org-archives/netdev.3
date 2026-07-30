Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EB63C1F4B;
	Thu, 30 Jul 2026 21:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785447415; cv=none; b=a4+hJNpwS0c3DcUCFzM60wJ5/llN7g+a1VVvlFK4kKHkCpc3jl0R9MqYKtfXDWhO6wQfIobh4tWiVUgffAUg1sHJLm4NwkAJRqzMuR63HsHm56qLzT3uSL/r08irO2/EyHbSVqjMDwhF9thpb231f7kMFjQP80pEAQMtZWYrCxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785447415; c=relaxed/simple;
	bh=OfsMYWSKElRUzAExWbu5//FDYuy+tOKl2nXq6vYDM3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvycGtL4K3NIPMsl4+TsQsdEe0dv+S7KpqncAZ7moLfRwfaNwoB+xaBk/G0MdqdFrFC0ZyliOCDaoWRrwaafxB+ZwUHl6OQKd3QRNZfJNl9vOShIcnnt2HJq2faQGIgJK+X6gEdqafCUlAig6VpYIlb0Y6ATJQxdtSxuY/nc8Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ckLMvo9C; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ckLMvo9C"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eGpIqSUk2mChLjot8RRqzOHwtL++I70V4YakqH8Tv0k=; b=ckLMvo9Cx0PENix2miPHfBOMSG
	83BiDwzzOVNV2e1c0fmrhCBY8e92YXiUpcISsJBYb5fmpGnoJMoALVsVPSLA1fQN5swDB8T6Uo+CB
	PulHQzpfA+aqjwOQ0kdaUmUVjWPp2vkmMBxtgQTFwunYVv69hraj2VygjWxpHH34MWSY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wpYQj-00F49z-AA; Thu, 30 Jul 2026 23:36:41 +0200
Date: Thu, 30 Jul 2026 23:36:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 5/5] net: dsa: mxl862xx: document devlink
 flash and info support
Message-ID: <40199aa0-b7a2-4fb4-bd13-e5b4202dea5d@lunn.ch>
References: <cover.1784945329.git.daniel@makrotopia.org>
 <3a85832b8584543241bc9fe382fcb9849b78bd01.1784945329.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a85832b8584543241bc9fe382fcb9849b78bd01.1784945329.git.daniel@makrotopia.org>

On Sat, Jul 25, 2026 at 03:17:30AM +0100, Daniel Golle wrote:
> Describe the devlink info versions and the flash update behaviour,
> including the MCUboot rescue mode recovery, in a dedicated file under
> Documentation/networking/devlink/ and link it from the index. Add the
> new file to the driver's MAINTAINERS entry.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
