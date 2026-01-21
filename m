Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3540F2528FD;
	Wed, 21 Jan 2026 12:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769000037; cv=none; b=Y8JDBpWcJpfwhZdVay6RTqOwKI7iWUNLHP10fUVT3tNuMRJnYD8lfsBOTjC9Ose8uW5SGx58H6YmMycTYYTbJjN/o9oin69nRqLg+p7irKHfaRqrCxxuI7GTwQMtWSXvYFlUP1lUJSzG2w0w1k+6xAnd1Ipny/GEev72HIN8hL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769000037; c=relaxed/simple;
	bh=4phmGtycrcO8LPIqtsNwl4dIFnOcrk0E/9SXScOpNis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ma1yRfEBfm6ukVA99FVuR/HleXUmK/JhvmBl5vPgQvXNH+C3jP3qMmxbGgy854+wua9LytVYA9Xv1h5rff0/uENcutd69UT+8hqEutQayEF1OtxpOqdKt9c1HgMkBxIvWNZPcbOY8JjDO0NSYglGj/jlRWVvK03xPl7uLN5rEnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1viXiS-000000002FK-49Nh;
	Wed, 21 Jan 2026 12:53:45 +0000
Date: Wed, 21 Jan 2026 12:53:36 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v5 4/4] net: dsa: add basic initial driver for
 MxL862xx switches
Message-ID: <aXDMUEepq1sU_kfH@makrotopia.org>
References: <cover.1768225363.git.daniel@makrotopia.org>
 <cover.1768225363.git.daniel@makrotopia.org>
 <169e8a64d3f4db3139f2c85ac5164c52ca861156.1768225363.git.daniel@makrotopia.org>
 <169e8a64d3f4db3139f2c85ac5164c52ca861156.1768225363.git.daniel@makrotopia.org>
 <20260114225736.c7w3tpfol7bdc4so@skbuf>
 <aWgjnJEAV4M3WrcP@makrotopia.org>
 <20260114232259.2bvvijqa3rwrsgsu@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114232259.2bvvijqa3rwrsgsu@skbuf>

Hi Vladimir,

On Thu, Jan 15, 2026 at 01:22:59AM +0200, Vladimir Oltean wrote:
> On Wed, Jan 14, 2026 at 11:15:40PM +0000, Daniel Golle wrote:
> > [...]
> > In order to avoid the detour via staging, from my perspective there are two
> > ways to go from here:
> > 
> > a) Keep nagging MaxLinear to provide a switch firmware with an additional
> > firmware command which flushes the pre-configuration and puts the switch
> > in a well-defined state (all ports isolated, learning disabled) for DSA.
> > 
> > b) Extend the patch to cover all the API calls needed to do this
> > manually (more than double of LoC).
> > 
> > Obviously a) would be better for me and you, but MaxLinear indicated they
> > prefer not to release an new firmware adding that feature at this point.
> > 
> > b) would allow me to proceed right away, but it would burden reviewers
> > with a rather huge patch for initial support for this switch.
> > For the sake of making review more easy I'd prefer to still keep this
> > in a series of not terribly huge patches rather than a single patch
> > which immediately brings in everything (ie. have bridge and bridgeport
> > configuration in one patch, FDB access in the next, ...). Would a
> > series adding everything needed to end up with isolated ports be
> > acceptable?
> > 
> > Please let me know what you think.
> 
> Do you have the additional work required to isolate user ports prepared
> on some branch that can be pre-reviewed? I'm not sure that I have all
> information to make an informed comment.

I've sent a follow-up version of the series[1] adding support for the
switch which includes basic usage of BRIDGE and BRIDGEPORT firmware API
to make sure ports are always isolated.

The function mxl862xx_isolate_port() introduced for this purpose is
going to be changed quite a lot in upcoming follow-up series, as we do
need to track and free allocated bridges used for port isolation for now
once bridge offloading is going to be implemented.

Please let me know if this is acceptable.

Thank you!

Daniel

[1]: https://patchwork.kernel.org/project/netdevbpf/list/?series=1043728
