Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667FA39D6D5;
	Tue, 18 Aug 2026 14:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064310; cv=none; b=cHmtU88rrlcC37Y4I1/+HFdwPa6eqKutal8NtUYLJK5Qo1Mo5jNRHPW7L4gta3jcYPI0hWrhQbUrxHdM6548u0IGOCy7H51tCmGDQVQTEam5tFWrm6+9uPMc+2HeqDNDe+0N2HXHNsFKZcxFdghTai9yQexSLvbNWK2TjYRiBvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064310; c=relaxed/simple;
	bh=pCLPljKlb3SjZPtd+3dUvUC2a9ehGYxjNjYf2noMkVI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YBa761LxEUUChkvdnwRj2rlSoadm/Rl5xEoteXwIPcWq6XKtpiFv7GGjtTaQOSmj3v8e8/fpJU007vugjLW2Pbrdk9Hy+JNTueWgqkjBKUcK48tBj23U21sZyO/Zmwrm7fXRGf8UUJCV2CtdcwHGdSnNfFDnXzD22ho29S41CfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejw6JTtE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejw6JTtE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81981F000E9;
	Tue, 18 Aug 2026 14:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787064309;
	bh=c7d9ILLdl2uuQua9nlVx5VA+VFdRGqZMMziyq+6TtNM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ejw6JTtEj2RXE01+LkkolUTifB1hteyc9s+hqHtIDbkQifeKWvV7fMoFX78BdI+QB
	 lZTYTHoCbO3NABFCslgxjl9HEJQEVyXFnvZbsxHrJz7C823kDW/YO8uPIENsVtNFKk
	 xb+hJ8ejFaHQ9VPwtKwsmzudIvLpqENibzkLNudrsT9Vx+x99mn1XSrum/cbpcOEQ9
	 Ldj+PlsE2WjK06yXGw8rL8oqrKV+D3pivv/JlYEwZ85ChzIG+Yr8dwf3rUQ/E7Z4gr
	 EHGWhTs+v506XJvG4upnJVGY/SMHDygCKC63BBxmk62Wx13K2ix4LEz7t+BMtoPx8v
	 Ntefd27PzzAVg==
Date: Tue, 18 Aug 2026 07:45:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Cedric Jehasse <cedric.jehasse@gmail.com>
Cc: Cedric Jehasse via B4 Relay
 <devnull+cedric.jehasse.luminex.be@kernel.org>, cedric.jehasse@luminex.be,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko
 <jiri@resnulli.us>, Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Luke Howard
 <lukeh@padl.com>, Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
Subject: Re: [PATCH net-next v8 2/3] net: dsa: mv88e6xxx: use the hw tx
 queues
Message-ID: <20260818074508.26e626b4@kernel.org>
In-Reply-To: <hgrxt3hlj6i7rcg7jxgyxzrxw6knk2eqykpiq7lgpu3zshprqq@ranq77v7pxbv>
References: <20260811-net-next-mv88e6xxx-cbs-v8-0-10d0baab2905@luminex.be>
	<20260811-net-next-mv88e6xxx-cbs-v8-2-10d0baab2905@luminex.be>
	<20260817105024.65be6d55@kernel.org>
	<hgrxt3hlj6i7rcg7jxgyxzrxw6knk2eqykpiq7lgpu3zshprqq@ranq77v7pxbv>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Aug 2026 10:59:35 +0200 Cedric Jehasse wrote:
> > Pretending that a DSA device has multiple Tx queues _from the stack_
> > makes no sense. You should be offloading PRIO as the root qdisc,
> > like mlxsw does. Then the rate limiters should be attached as children
> > of PRIO.  
> 
> This patch follows what the implementation i found in other dsa drivers.
> mlxsw seems to be the only driver handling TC_SETUP_QDISC_PRIO.
> Wouldn't that mean setting up cbs for a mv88e6xxx switch would use different
> tc commands than setting it up for another dsa switch (prio vs mqprio)?
> Is your comment specific to this driver, or for dsa drivers in general?

Maybe Vladimir can comment why he picked mqprio. He probably explained
it to me and I forgot.

My mental model is that mqprio offload is for the host ("NIC", IOW host
traffic egress). But if you're configuring a switch where most of the
traffic is internally forwarded within the ASIC. We should have a way
to report stats and offload status. There's no need to pretend we have
multiple host queues and waste memory.
