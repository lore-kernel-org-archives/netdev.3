Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EE91E1A3D;
	Wed, 30 Sep 2026 01:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790730571; cv=none; b=LpS4/LckW3SfG1uycPu/BWET2w9TDIV/QCQmlZ7mNKZzB8PMSH6m+/3TEh4j0cFgxYIV3l4Fi3AdynhvZ7ikAFX/Qu2uMsKkK9VrVLafOXGi/6JVM3cVtYkmJBhP0PGa9BPVfBkr94uNG2TQA/qTPDxrcjjgisQLn/hVwJ/tNlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790730571; c=relaxed/simple;
	bh=fWQtMqQtZ8CuGK4opxBxrzBeDCvijwDYNaKWzT5HhCM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EpynZnmstj8EMd6SIfjFWRe7oL+AiwY03NugnIHLi+rsZ1DQIhqLjLxL2M3lemFZsBTVFjDCgrExeUIkEySfwS53i0tpiKqdcsSCEmHo1QG+b844v8DYJ/vcy5gi4jG1/i8A98DEmbzUy58irAooxzcxlMjtYXe2+i3VBHIvtf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSOCQkQ8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSOCQkQ8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BAFC1F000FF;
	Wed, 30 Sep 2026 01:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790730569;
	bh=u4G3sKWZIlCfo2hjBMDIfRgFkOo3aOxVZX09z7zcj3o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fSOCQkQ8n6pZPkXZDoHF8wcQke84pv6gMjBzBCiLHDy/HlPQ2W+vniU8herUwFNWw
	 CHhSK0y28CdCLm4ik3KSQ4mNZcUQ0RY4hFihRosnnttXsJ6MNXm6fY3tSdcP7r5rmK
	 +2YzxFo0IwJFNYSQfsSMeEOpekooL5wY6D/5moaPR3voISvDqPDVL3UUWXUlj72OLE
	 9xlO7SF0SOhGcuEgROBaipK4VF3Wi2Id3nh4597MEpT9rYEYl7TF4twvm/8dFtpR7W
	 H8DETQggxKwciqIqAcjE9yPQ0W1LbP9H338mwHIhzeZPncnQWblTD5dj6rXq0xTwRj
	 0aQYnQbomFf1Q==
Date: Tue, 29 Sep 2026 18:09:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev-bot+sashiko@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 linux@armlinux.org.uk, nb@tipi-net.de, jitendra.vegiraju@broadcom.com,
 thomas.petazzoni@bootlin.com, alexis.lothore@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, pbrobinson@gmail.com
Subject: Re: [PATCH net-next v2 2/2] net: stmmac: Don't set or get RSS
 parameters when not supported
Message-ID: <20260929180928.546f23af@kernel.org>
In-Reply-To: <71adb267-2dd9-4225-91e5-19848a87eb49@bootlin.com>
References: <20260928145043.1228968-3-maxime.chevallier@bootlin.com>
	<179067171307.434549.1093187286398187440@kernel.org>
	<71adb267-2dd9-4225-91e5-19848a87eb49@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Sep 2026 10:57:10 +0200 Maxime Chevallier wrote:
> >> @@ -943,6 +949,9 @@ static int stmmac_get_rxfh(struct net_device *dev,
> >>  	struct stmmac_priv *priv = netdev_priv(dev);
> >>  	int i;
> >>  
> >> +	if (!stmmac_rss_is_supported(priv))
> >> +		return -EOPNOTSUPP;
> >> +  
> > 
> > [Severity: Medium]
> > Does this -EOPNOTSUPP break namespace-wide ETHTOOL_MSG_RSS_GET dumps?  
> 
> This was reported by Nicolai already, and other drivers report -EOPNOTSUPP
> here.
> 
> If we address that, I'd say we do that in the RSS ethnl code.

Let's get this in the same series, cause I'm not 100% convinced.
My instinct is that returning 0 size for indir table and key
would be correct and less hairy for the core to handle.
All pieces of RSS are optional so returning 0 size for everything
should be equivalent to having no RSS.
-- 
pw-bot: cr
