Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AFC3F0A9B;
	Thu, 15 Oct 2026 23:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792107415; cv=none; b=mOI2Ph9AZQxRReGPuKvERr//9I1DSSOtNLTYiI39XQvTykdUO2+sWBaNDs6Ggvy/XrgVQ7oLALNBUZa3x3ogp/EjJpQ1Dk7Z9LDU5Jkj9eCglYN4yj28pt+5nWPX+wDqgaeK9o2xbmPPrwlWtZRCCR8uzkfqUvJ1WacEDZR/C/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792107415; c=relaxed/simple;
	bh=nwqyWYHyqalOt3oD67S8Ik+1eMrvc/JVWi1vuMulADM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nyPz6GHlZVBKr0SZpeTe8MBsvqQ/BBvopp1ux2OEk46zBcILTbt6KB5NSfXbA9LipTrKaek6OPz/Vbe+qAvGmra1oAIfoAhjYyEMl9YTV88bVzLLpocUuvyz1dUAS7IMfTXeEMZMjyaxawlmigTsDMxAtg5GbBG7v/cJvcDPsko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LY1JkJOS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LY1JkJOS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572CE1F000C4;
	Thu, 15 Oct 2026 23:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792107414;
	bh=sDbldnx1eZ//vxHr0/tLnnKthK+28bXbrhnsFJMTMq4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LY1JkJOSLWADAUm2I/Ja+wKOJr1N8GWTCg2z8p4WsmRVff5Mcd+0aY4w3tasZQPIo
	 AIhAJbC/qQKbF1SPIXnGZN7q3lFjt7vJ/sxbHym2n32/mjTZ0Jv8CQgrApMLbBsCli
	 LDQ7RIgjtM4H7Q0630uBo1C2IcxF+5B5xKkx0PinrSJAJ+9n53N8r566qjsgmnapHe
	 39wFrB3HlZPJOx3+fHuKnbY5mSKy6SCyZl5n/hCgut5oxbcZPF+q+0YycoPdmdTFlt
	 a486U9wor6hBV3XjRYN9p790SDDQEb4KrU89dl6KOZt7aHXUZ1hCv8UJOPJCaTnXgK
	 zSOFCAEQ7stxA==
Date: Thu, 15 Oct 2026 16:36:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev-bot+sashiko@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 linux@armlinux.org.uk, lorenzo.bianconi@oss.qualcomm.com, nb@tipi-net.de,
 jitendra.vegiraju@broadcom.com, thomas.petazzoni@bootlin.com,
 alexis.lothore@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, pbrobinson@gmail.com, joe@dama.to
Subject: Re: [PATCH net-next v3 1/3] net: rss: Require indir table size or
 hash key size to support RSS
Message-ID: <20261015163652.21ff3a98@kernel.org>
In-Reply-To: <bfc0027a-932e-42f3-93b3-49ab5474abd6@bootlin.com>
References: <20261002142806.1299041-2-maxime.chevallier@bootlin.com>
	<179121059086.434549.5364767976780818051@kernel.org>
	<d6e61c8b-cd3d-43fe-b4ac-19ff5d790b0f@bootlin.com>
	<20261006163349.61c738e8@kernel.org>
	<bfc0027a-932e-42f3-93b3-49ab5474abd6@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Oct 2026 11:04:44 +0200 Maxime Chevallier wrote:
> >> Yes it does, that's the intended behaviour here. RSS bits are all optional,
> >> but does it make sense to report hashing params when the indirection table
> >> is size 0 and key len is 0 ?  
> > 
> > Not sure if there's an implementation in the tree but 
> > it's possible to implement poor man's RSS on strict
> > power-of-2 queue set with some hashing built into the
> > Rx engine, without a key. We'd still want to control
> > which fields are hashed in this case.
> > 
> > In the Netlink API we combine the two so we'd break this?  
> 
> Hmm I wasn't aware of that :( I guess the safe choice is to check on -EOPNOTSUPP
> for .get_rxfh() + 0-len indir table / 0-size key and skip the device during the
> dump instead of returning early ?

Not sure I'm following the suggestion, isn't that what the v3
already does? I think the API was suggesting we let the device
progress into the dump, and rely on the existing "unset" checks
before the nla_put_ calls filter out the data which wasn't provided
(which may be all the data).

Not sure it's worth it, could you poke around to see if a device
which reports zero-length key + indir table actually exists?

