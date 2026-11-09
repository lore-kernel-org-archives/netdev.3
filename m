Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243641;
	b=rjy+EXShqC6VUxAV9VSlzOlHzRvxQ+v3065cQMsUdH5yoZA+dPY4b/FU/to3YPvYPRCU
	 tbzxjW45njw7Hz7xAFXTX7PZI91cBBLonsDws/ayKWxDqHlC+b2JJg09fRlJec+DgTgU0
	 G2ro9Luq81b26TiaUFeruFUQBXG9XgMVK3EGVKoBYrlbfmTivq31pdMypizcbr3dNWsGT
	 SMzVsM4o1QUDHAheMdHTxUq2RE7fQO3i+LdQ/YqncVu77i8yrOAm6AoH8M4X4H9jOTwau
	 xL4uA2Ewhebs1JSfoUgZw72Hb4xyXP5Ho8tNK3M9PSz5EAswSgBgxiF8Gp4c6TwWHcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243641;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=yST6EV0KWAnwiiwzVHXcXJaNi9Dne4qI6KCjCJnlp2M=;
	b=KGEpLsGvivo3zR8i8qf1aFC7wivVlKcDXizDZk20wB/aj3RDNkZx8iPrDucTVETmDnTF
	 synJpEeztxBl3/CDrHsfBbcsH3SfQ47jvWmanhfQxlQWHUXKgFD9qtH5I2lQI3at5k5sg
	 Ryq3ovyZB884zu0FvI2GtTWPXeMQpxSRZwQKNSaU3NxUxF4T5Bl/Dclk00FKepvqrB0Xm
	 scEsic2HtLQO+vFoLa8GDcGC59oHYQLhWRJxxwrzLFOkbLS2JC9FHxRkvfPnrbvgOrJ0x
	 Kf//5++PWiH8eJHsNiklBWH3tHcTRMVV3C0wZR+yCepY8FP7rjFCEcgAzNaiOH+Kjng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P00gMXnB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E79C606A31C;
	Mon,  9 Nov 2026 17:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P00gMXnB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0ADE1F008A1;
	Mon,  9 Nov 2026 17:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794243640;
	bh=yST6EV0KWAnwiiwzVHXcXJaNi9Dne4qI6KCjCJnlp2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P00gMXnB194lgNZ/pOpAfEFBJxSH2rLwbV+pXfvvxV0AucuFEJ3PSVpP8VQNTD9tp
	 T8isWPRxyShgAMH2h6Jbasy/doRUWkR6Suck3AuxoIpK2W4KmMKnPn759rGEp+wMsw
	 9FmxTlgUuSDQigYQTurrFtbZbmnU9dr9Pnr4pofz6V+4+VFjfCRSjpeLZaH7+mOXLE
	 2Q7QCy3EGLCFv5mimODtseBM4vmfFy5LM5rB+pc51RTGsv3NLx7n900ydF3d52GH0l
	 KjZEcLvAgwn1SuXBwtRxId8AjqR6vTrajxDBMEPbuMhZTewTmcGHDb3UhggwVHyB61
	 4JvSrW78OpkZA==
Date: Mon, 9 Nov 2026 17:00:36 +0000
From: Simon Horman <horms@kernel.org>
To: laixiangwu <laixiangwu@cmss.chinamobile.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ti: icssg-prueth-sr1: Fix device_node refcount leak
 in prueth_probe()
Message-ID: <20261109170036.GT18859@horms.kernel.org>
References: <20261030085851.2019-1-laixiangwu@cmss.chinamobile.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030085851.2019-1-laixiangwu@cmss.chinamobile.com>

On Fri, Oct 30, 2026 at 04:58:51PM +0800, laixiangwu wrote:
> prueth_probe() takes references on the eth0_node/eth1_node device nodes
> with of_node_get() and stores them in prueth->eth_node[]. If either of
> the "ti,mii-g-rt" or "ti,mii-rt" syscon regmap lookups fails, probe()
> returns -ENODEV without dropping those references, leaking the device
> nodes.
> 
> Jump to the existing put_cores label so the error path releases the
> eth0_node/eth1_node references like all the other failure paths in the
> function do.
> 
> Fixes: e654b85a693e ("net: ti: icssg-prueth: Add ICSSG Ethernet driver for AM65x SR1.0 platforms")
> Signed-off-by: laixiangwu <laixiangwu@cmss.chinamobile.com>

Same feedback as for

- [PATCH] net: ti: icssg-prueth: Fix device_node refcount leak in prueth_probe()
  https://lore.kernel.org/all/20261030085651.1944-1-laixiangwu@cmss.chinamobile.com/

-- 
pw-bot: cr
