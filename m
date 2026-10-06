Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CD63876B7;
	Tue,  6 Oct 2026 23:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791329632; cv=none; b=CgSKMGGDIyQfKjd5brRmw74cMV7+LAjGyNkGz3ziaDqVf4EiZDkDdw9BCV9YsCj5jr6plnMNRG6Z78OzrOOknRTh4uu7MxeRuGy6WU2wAGl0muaw1b14JNkXWuy2YKz+wbtCCs0+cyZn7Ik7RzkLMaLQhH8OkIcLcRRmqBvbWdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791329632; c=relaxed/simple;
	bh=rmDrskrJsi/kwBicdDywelOvJ9Rek/lzsmAzTKPSyCM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E0OcHj/YsXeBr15621u0dHzCzTgqz9gWNNEBn3dHuoQr5dKUI2kxMzDcDCOh+JERmz35JYp6RDvbBD4jIBS7do3DfZMtU7DdLavxE3c6+hk52mXaJ3srU6F3kimx1QnXf4AwzP7MQBU85LigqBMt8jSIsR8cRjcZhxQ7CYI7GR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvUyGXER; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvUyGXER"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458C11F0089B;
	Tue,  6 Oct 2026 23:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791329631;
	bh=zm8j7s6dPbe68KVfUZh47NlPhrjF01bigXUXsBDCEJA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LvUyGXERuHldy1RvQ0Y8rrzYpA/YI/r+2a1j9oknazUvbUrCHMLeoLeDQX8ZwhRVG
	 z8q0k5GuuU9KxJq0q+H4n74pDWMa+qW2CybIrZQulQShrjCwMnjTlOdrkum3ss7xXM
	 76GJ3otPNaz/ZiZ1XgePKUxFuQSMN82dtM05mL6EDJb5F0Hd4eQJhRV2Kbdk3x8TTo
	 JjLMXVi7/OTtP4whUpRLP+aW5WPdrrCpkQ41nZSOq+CAhPa1+Jku1xySfaMhyFdEmA
	 0n5LPO/nyFTmEdxoYBcKCmfjYD2IGasey0tkRIjYFcLNpahx6ht/xIN+Zk5axDeKEM
	 scg7F4PsAEaWg==
Date: Tue, 6 Oct 2026 16:33:49 -0700
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
Message-ID: <20261006163349.61c738e8@kernel.org>
In-Reply-To: <d6e61c8b-cd3d-43fe-b4ac-19ff5d790b0f@bootlin.com>
References: <20261002142806.1299041-2-maxime.chevallier@bootlin.com>
	<179121059086.434549.5364767976780818051@kernel.org>
	<d6e61c8b-cd3d-43fe-b4ac-19ff5d790b0f@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Oct 2026 09:59:29 +0200 Maxime Chevallier wrote:
> > [Severity: Medium]
> > rss_get_data_alloc() is shared by RSS_GET, RSS_SET and RSS_CREATE. Does
> > this drop flow-hash reporting for devices that have ->get_rxfh but report
> > 0/0 sizes?  
> 
> Yes it does, that's the intended behaviour here. RSS bits are all optional,
> but does it make sense to report hashing params when the indirection table
> is size 0 and key len is 0 ?

Not sure if there's an implementation in the tree but 
it's possible to implement poor man's RSS on strict
power-of-2 queue set with some hashing built into the
Rx engine, without a key. We'd still want to control
which fields are hashed in this case.

In the Netlink API we combine the two so we'd break this?
