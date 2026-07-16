Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520373D3CF0;
	Thu, 16 Jul 2026 13:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208115; cv=none; b=maS+ny7z6ROqpTWipIwh0K8z9fePDUuGiVGL8u6AEzbF1bAKh0zl10deWIK63etMYV4WO0g2flu4mkZAGK2G1r/g+gOfXHXn72z2FzpGr9Y1gUn/NNhtCx+Zn6jDe73/I/ZYrDkZ6LE7Fdhm1uDRZt/hliK2H+Nr4uKlBZfDuz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208115; c=relaxed/simple;
	bh=pwSh+4CViHPimHYs2Q8vLnoycstp01UZnR42oyV5n2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVSEA1kQGiFZ3lkYbMbid0iP29hbt4HsEHixz8Utjy+eKoPHGl1VIWatG0YmVRel87CT3WW+BEA5lz9Z7xqh/r+Ki6A5rIzdytgkb1Svx56fNFIvAutVQTat0CWMsCnvDgl8agY49iXGnSC9naZuHrCzYgOwzbBEPJezD68jRPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDTn+lSQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDTn+lSQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B896E1F000E9;
	Thu, 16 Jul 2026 13:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784208113;
	bh=tlxu4ssB6h1spXn1nBX5qq15i+cmHHwSqMtYQQxDoes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JDTn+lSQ0zVpEhRh9pVJPQBB27l04CmAPGshQikR7C7pNNDW+hvBxU/sVKC7v187B
	 OuYkndvTMQi1E0WWMXanBHzPrSpi27XwrrhpXJnGL6IVt1xEWv/uKuE0EhOSWXEQmj
	 xz/G/OKfOPNCcvavLyfSTWuIVGTM6ahqfEHWHQZ0hBlE+rhrV/qrxhpjvouT1b3+ob
	 lvd3tuxmFoB4XeXosxeHHEnm2Paql+AyDJzTPjC8j7ujzGWOTY5EdyiO1ijNbhynOl
	 cikcw/Yb1GDNRTeAKkT1NOV3bFPCQxmXGJgrNKHgK40LRFU3nni3T9IqRzmfrv1wn3
	 esdLn45B0LMlQ==
Date: Thu, 16 Jul 2026 14:21:49 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	asantostc@gmail.com, gustavold@gmail.com,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v3 0/9] netconsole: stop charging netpoll users
 for netconsole-only data
Message-ID: <20260716132149.GK95246@horms.kernel.org>
References: <20260710-netconsole_move_more-v3-0-6f63f76b28bc@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-netconsole_move_more-v3-0-6f63f76b28bc@debian.org>

On Fri, Jul 10, 2026 at 04:38:52AM -0700, Breno Leitao wrote:
> This work continue to untangle netconsole and netpoll, improving
> memory usage for netpoll users that are not netconsole.
> 
> struct netpoll is shared by every netpoll consumer in the tree:
> bonding, bridge, team, vlan, macvlan, dsa and netconsole. The non-
> netconsole users only need a per-port handle that lets them transmit
> SKBs.
> 
> Yet struct netpoll has accumulated a pile of fields that exist only
> to serve netconsole's printk path:
> 
>   - skb_pool / refill_wq: the fallback skb pool find_skb() falls back
>     on when alloc_skb() returns NULL, plus the workqueue that refills
>     it.
>   - local_port / remote_port / remote_mac: the source and destination
>     UDP ports and the destination ethernet address used to build
>     outgoing log packets.
> 
> Every netpoll user that allocates a struct netpoll pays for all of
> these fields, even though it never queues a single skb on the pool,
> never sends a UDP frame and never looks at any of the addressing.
> 
> Move this netconsole-only state out of the shared struct into struct
> netconsole_target, where its only consumer already lives.
> 
> After the series every passive netpoll consumer drops
> sizeof(sk_buff_head) + sizeof(work_struct) + 2 * sizeof(u16) +
> ETH_ALEN bytes per port (plus padding), and struct netpoll keeps only
> what belongs to the generic poll/transmit abstraction or what netpoll
> core still reads itself.
> 
> Follow-ups
> ----------
> local_ip, remote_ip and ipv6 are still in struct netpoll. Moving the
> addressing additionally requires relocating netpoll_setup() -- whose
> only caller is netconsole -- and its IPv4/IPv6 helpers, so it is left
> for a follow-up to keep this series focused on a single responsibility
> transfer.
> 
> This is pure code motion with no functional change. The pre-existing
> target/device teardown races reported against v1 have since been fixed
> independently (as suggested by Jakub) and are already in the tree, so,
> re-posting this one.
> 
> --
> 
> Changes in v3:
> - Added a fix for a pre-existing cleanup-skip leak (released/joined targets).
> - Added an skb-pool init-once patch closing an init/teardown race; rebased.
> - Link to v2: https://lore.kernel.org/r/20260702-netconsole_move_more-v2-0-1ebedd921dcb@debian.org
> 
> Changes in v2:
> - Rebase on net-next, now that the prerequisite netconsole
>   teardown-race fixes are merged.
> - Squash the local_port and remote_port moves into a single patch.
> - v1: https://lore.kernel.org/r/20260524-netconsole_move_more-v1-0-909d1ab398b4@debian.org

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>

