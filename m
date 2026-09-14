Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4588140F721;
	Mon, 14 Sep 2026 23:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427528; cv=none; b=ZMThVAobjYBf8VFKRjvoz/0820KERCMbZ91xZLuHENIphZYBkP0yU3FblH3svzJforXy1XQB5QLO6YISBEZVXfaOYZayy4r/HziQQbY+iQr2FY89Ec+5c5Yq1+8PI65lwSerBjVlB2j2X6TNwO9ViWodfUROoCMi8vgOTSQup0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427528; c=relaxed/simple;
	bh=UHBUb6wDxTC/hoIZhGec5BV2YDVXc/hZhNTTv7JvXwM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qADIWgN6H2jkzakE63UZ4Vd7dyYGgoX4EqnyC6lC0LE+JBLqKX46reg9Xk2DVlc12DVU2yQBbxTXZYTu8vrbi8Su7nW5LaickGXopgaoOBt1FB+3tR2PWChugYULrXixe23WlEBEebr9WhdFIMZyTS/RhkCgTcScDim2OGHGzdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWnF0jp5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWnF0jp5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFDF1F000FF;
	Mon, 14 Sep 2026 23:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789427527;
	bh=VPBcQ1s/Neqe5bBeiaRgv2/YCtroUlvM+3Akfn43y9o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HWnF0jp5dz7NZQeWnRReOjBienarewY5C+zrhtpVXlEmwRY8576FSHEGGrfV4szME
	 1c8x6rufgwfCrZNxOr/OFuKNGdxTtYcbNCer2Tj/IaK92hlL3Rw6auRZZgZKLWQfJj
	 1WH19pB+49cTL+8+8pOLl4lzQUwFCtMvSqBv6dR0ccxi9VBp+Jy9ZyicwT/Ic/NU5J
	 jQie7rms5ycUSjE+NuVuzU5WorP71859T4cnQNcmoRzvGoDu0V75YzM9Q7rIrtGhol
	 EehGvu+rENh+O/xW819MO20IXOeOPxd0JFfQ3kD18wSHwzL1RvjgHySSg+yiX0ez+u
	 th4jNX3evoOzw==
Date: Mon, 14 Sep 2026 16:12:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: tmbates12 <tmbates12@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>, Stanislav Fomichev <sdf@fomichev.me>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/4] netlink: fix ynl spec tooling robustness
 bugs
Message-ID: <20260914161206.40a049ed@kernel.org>
In-Reply-To: <CAC4WM+zvK1zFuPfS5WnzuDR3b_DRX==x_S=Gg7LSLgZb9=33Ng@mail.gmail.com>
References: <20260908-ynl-robustness-v1-0-f255214c0f30@gmail.com>
	<20260910192314.209ecb01@kernel.org>
	<CAC4WM+zvK1zFuPfS5WnzuDR3b_DRX==x_S=Gg7LSLgZb9=33Ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Sep 2026 13:35:16 -0400 tmbates12 wrote:
> On Thu, 10 Sep 2026 22:23:14 -0700 Jakub Kicinski wrote:
> > Why are you doing this? What's your intended use?
> > YNL extensions for classic families are unlikely to be accepted.
> > It's definitely not a goal for us to backfill all the ancient baggage.  
> 
> As part of work I've been doing on switchdev based ethernet switches
> for configuration and state monitoring, I'd like to avoid having to rely
> on shelling out to iproute2 to query bridge VLAN devices.
> Parsing its output is fine as it can emit structured JSON
> output, but as bridge(8) always resolves the ifindex to its interface
> name, additional lookups are required in order to find the ifindex.
> 
> Is a bridge VLAN spec something you would consider at all, or should
> I drop the idea before writing it up?

I see, so you have a real use for this.
Let's get patch 1 reposted and merged, and then send out the whole
thing, we can judge how much hacking it takes to support the bridge.

> > So you know that the Fixes tags are pointless and yet you add them?
> > Please, if it's not a bug that needs to go to LTS it should not have
> > a Fixes tag :/  
> 
> Understood, I will drop the Fixes: tags.
> 
> I will be dropping patches 2/4 and 3/4 based on your comments on each.
> I'll drop 4/4 as well, since I'm not planning to submit the OVS spec
> work it would need to go with.

Do you mean kernel side code gen for OVS? I thought we have specs for
most of OVS already, we just don't use them for kernel code gen (since
it's a pretty stable code base).
