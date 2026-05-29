Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D44E33F5B5
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 14:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780064870; cv=none; b=rXIckHIpQwqQuEeltuXXg+4aFJAQESnNf5N0mNqtzRsopS3Oji/tnlXD8T0km/2O1XWBrqZzg9CqgY+MXxV/eM3x9ABQ7XudU7noqsDyNMwsvZO65XuHGXvAw3r77977Ilq5uicxBu9489yWA8L2dW3AxRhU49T7XouwgeM2ad0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780064870; c=relaxed/simple;
	bh=sOrLwHx+x3rEUIRrS1K4KIB6iOQJgjMTMNgodC6yvpY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eyzUyud+aK8e89IrvMuHbA7mzSF7YaUCv9CqQl2KgCBEBxqADwHGpclGoN8/E7LJRtaeXC2BYa9htKQVhBDdk9+/5371MsbtwP6o4SUpZbleqk8izpyDvOOOKkj2TfjZCB1LsxQ1i7LgEU4SKA9H0T6ZtCotW8zG0PhHaoSvdSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKF0fBjE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKF0fBjE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D8E1F00898;
	Fri, 29 May 2026 14:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780064868;
	bh=+w8oWF7fJd867vDtDZwMcWjEEGTcWlKmSp7JmzmZjiU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KKF0fBjEjXbLzIdwz+nO274F94gcEplbfxGx8pAR0ra3HhKdGM4nxQbujEBuaYxWX
	 CUZE2Z4CgJCkS1YQ+09pKr9dVbur2ZUH/iv1FOiagHZQUDUR2nGQy/aT3B6csIiNvr
	 UuBL3iWf9wId3HfrJG0Fyh7Hbffw3BClD2oNt3JT2BWVaG+OvF9Pmduv+cUdlMdS2y
	 7Xo8ezW5eDmO4kP/3lNZs3IS3KquKIETrP9Yel8XOX1zEjtXsSLawv+0DT1maH3Iny
	 8v+kXFR7B7nF5zZw1MvboONtNSMinuR8OSXXhPqSDsNLEDmSM0bVnl0Gs184Ddq8Sk
	 nRncfoG35kuGQ==
Date: Fri, 29 May 2026 07:27:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, joshwash@google.com, tariqt@nvidia.com,
 haiyangz@microsoft.com, linux@armlinux.org.uk, willemb@google.com,
 ernis@linux.microsoft.com, sdf.kernel@gmail.com, kory.maincent@bootlin.com,
 danieller@nvidia.com, idosch@nvidia.com
Subject: Re: [PATCH net-next 04/14] net: ethtool: relax
 ethnl_req_get_phydev() locking assertion
Message-ID: <20260529072747.7543df9d@kernel.org>
In-Reply-To: <70c0a3dc-a522-4141-b98c-2ebc231b20ae@bootlin.com>
References: <20260528231637.251822-1-kuba@kernel.org>
	<20260528231637.251822-5-kuba@kernel.org>
	<70c0a3dc-a522-4141-b98c-2ebc231b20ae@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 10:43:04 +0200 Maxime Chevallier wrote:
> On 5/29/26 01:16, Jakub Kicinski wrote:
> > phydev <> netdev linking and lifecycle depends on rtnl_lock.
> > We want to switch to instance locks for most ethtool ops.
> > Let's add an assert that ops locked devices don't use phydev
> > today. If one does we can either opt the phy ops out of
> > being purely ops locked, or do deeper surgery to make phy
> > locking ops-compatible. I don't think there's any fundamental
> > challenge to make that work.  
> 
> Yeah untangling phylink/SFP/phylib from rtnl will be needed soon
> indeed, quite the can of worms...
> 
> But for the topo part, this change should do the trick.
> 
> At some point we'll need to convert a more embeded-oriented MAC
> driver to being ops-locked, to get a good idea of the amount of
> work in front of us.
> 
> Most of the constraints come from the different lifetimes of
> phy_device, sfp-bus and net_device, RTNL is the easy way to
> guarantee that the netdev doesn't dissapear under our feet.

True, I was thinking about it from an integrated driver perspective
where the same driver spawns all elements. In that case it's mostly
a matter of pointing them all to the right netdev instance lock.
But we'll figure it out :)

> Andrew and Russell were careful to get people to annotate
> the RTNL dependencies with assertions, this should make it easier
> to tackle the conversion :)
