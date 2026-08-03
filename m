Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAB3B672;
	Mon,  3 Aug 2026 04:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785732681; cv=none; b=W3cI7z8IBMk63ZrYrnvgYhcmNaYCRle/NEubVWygwF8bs1qmmvnYC0M0nI4348uusi7tt6TyHagw7JXE9o56P13MLea+Q8lI6BhRq7fTqInzr/qHJGd5I3bF6UcyWv7zP1E4+831e/dTEiZWmy4gCKeoKruqFDLWNYMrXwyGkCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785732681; c=relaxed/simple;
	bh=lquJqh82uQncxLUplVwoSd7UdgD/7Rge09swQKKkCms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/NQbKqO+dU2yCmCfPuGae8WTsi4HTwWW36EGrXb1SiOPUCstEiIEqobgCCEHroq/zQ0z+zElWoqpFN99Cp8cCuRv0XX8zCVYH5rwIT0wDQH1fYVP9fTyQ+jOFQOx6ktr64As3YXRi6s9+v3faMkazsYL8yTzKggoWzidpDYV+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YVaMSzW5; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YVaMSzW5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785732679; x=1817268679;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lquJqh82uQncxLUplVwoSd7UdgD/7Rge09swQKKkCms=;
  b=YVaMSzW5vb4biLFlYilfcM4qh7ie3c2azfcJWL/OOhPYlWp49n75sNwU
   jcL4yCdeNFzgQdGDedtNQkXDbaP4Q0as6G8qGi7KDY+WHqX/+Zlf+zDvI
   /KSlc23SlQHtUG629QgrJPKFiEAjKVklVFaDC17PLDb+zFtn3aYMPBnoU
   uXFVDq+dQQeP6pGc2JAvLJ2WidsYLWq4DbBhTB9pYJl3p77+i/7E+P98F
   m7YSFlJ26xluLqtPtKqmz57+Md/ubhx/nLb/GW4s+Yh6cJlbKhADgprCk
   5/0lxQ+guJZKnONeCvHAVv6ri6Jr+kj6gBDV+MNe05wDZMiDR7bnpKpLr
   w==;
X-CSE-ConnectionGUID: zxnCeb6ORsyfXwLe4v0rgQ==
X-CSE-MsgGUID: tRidjnUfShS16iqbZP6qsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11863"; a="97634788"
X-IronPort-AV: E=Sophos;i="6.25,201,1779174000"; 
   d="scan'208";a="97634788"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2026 21:51:18 -0700
X-CSE-ConnectionGUID: caQDK0m0SPOAzPKQ8tRFRQ==
X-CSE-MsgGUID: oyJrpe0CS/O7GYKUNkj2UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,201,1779174000"; 
   d="scan'208";a="261729304"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP; 02 Aug 2026 21:51:15 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 8CF1A99; Mon, 03 Aug 2026 06:51:14 +0200 (CEST)
Date: Mon, 3 Aug 2026 06:51:14 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Fan XinRan <shinjiangjiang@gmail.com>
Cc: westeri@kernel.org, YehezkelShB@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: thunderbolt: Tear down DMA paths before
 stopping the rings
Message-ID: <20260803045114.GO20844@black.igk.intel.com>
References: <20260731170442.45530-1-shinjiangjiang@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260731170442.45530-1-shinjiangjiang@gmail.com>

Hi,

On Fri, Jul 31, 2026 at 05:04:42PM +0000, Fan XinRan wrote:
> tbnet_tear_down() stops both rings and frees their frame buffers before
> calling tb_xdomain_disable_paths().  tb_ring_stop() zeroes the ring's
> descriptor base and tbnet_free_buffers() unmaps and frees the pages the
> frames sit in, so by the time __tb_path_deactivate_hop() polls the hop's
> 'pending' bit, anything still in flight has nowhere to drain to.
> 
> This is the mirror image of the setup path.  tbnet_connected_work()
> already documents the invariant:
> 
> 	/* Both logins successful so enable the rings, high-speed DMA
> 	 * paths and start the network device queue.
> 	 *
> 	 * Note we enable the DMA paths last to make sure we have primed
> 	 * the Rx ring before any incoming packets are allowed to
> 	 * arrive.
> 	 */
> 
> Teardown should undo that in reverse, but does not.
> 
> On an ASMedia ASM4242 host router the 'pending' bit then never clears:
> every teardown burns the full 500 ms timeout and
> __tb_path_deactivate_hop() returns -ETIMEDOUT.  Raising the timeout to
> 5 s does not help, so the hop is not slow to drain, it never drains
> at all.
> 
> The failure is invisible above the thunderbolt core.
> __tb_path_deactivate_hops() is void and only calls tb_port_warn();
> tb_path_deactivate(), tb_tunnel_deactivate() and
> __tb_disconnect_xdomain_paths() are void as well, and
> tb_disconnect_xdomain_paths() ends in an unconditional "return 0".  So
> tb_xdomain_disable_paths() reports success and the netdev_warn() below
> it never fires.  Repeated teardowns eventually take the XDomain control
> channel down, after which the peer node is gone and only a power cycle
> brings the controller back.
> 
> Deactivating the paths first fixes it.  Measured with kretprobes on a
> stock v6.17 tree with no other patches applied, on a link that was up
> and had just carried traffic:
> 
>   before: __tb_path_deactivate_hop() returns 0 for the first hop, then
>           -ETIMEDOUT for the second 500335 us later
>   after:  0 for both, 525 us apart
> 
> Alternating the two orderings ABBA over three load levels, four
> teardowns per arm: every teardown failed before the change (21 of 21
> that ran), none failed after (0 of 24).  The before arms ran short
> because the link died partway through.  The same split shows up when
> the interface is enslaved to a bond instead of just brought down, which
> is how I ran into this in the first place.  Throughput and latency after
> the change are unchanged.
> 
> Hosts whose routers drain the hop despite the stale descriptor base see
> no functional difference, since the paths end up deactivated either way.
> 
> Fixes: 4944269305df ("thunderbolt: Properly disable path")

I don't think this is correct tag. IIRC at that point the networking driver
did not even exist yet.

> Signed-off-by: Fan XinRan <shinjiangjiang@gmail.com>

This makes the driver follow the CM guide mode closely too as  it suggests
that the paths are torn down in this order.

I tested on a couple of Intel systems and did not see any issues either.

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

> ---
> Notes for reviewers, not for the commit log:
> 
> I can only test this on an ASMedia ASM4242 host router - I have no Intel
> host router to check for regressions on, and that is the gap I would most
> like a second opinion on.  The argument that other hosts are unaffected is
> that the paths end up deactivated in both orderings, and that the window
> this opens (rings still armed while tb_xdomain_disable_paths() runs) cannot
> take new traffic: __tb_path_deactivate_hop() clears hop.enable before it
> starts polling, and tbnet_tear_down() has already called netif_stop_queue().
> That is an argument, not a measurement.
> 
> Details left out of the commit log to keep it short:
> 
> - The three load levels were idle, 100 pings, and 3 s of iperf3 before each
>   teardown.  The 21 vs 24 asymmetry is because the "before" arms stopped
>   early when the link died: 8 teardowns completed idle, 7 under light load,
>   6 under heavy load.  Only one arm per load level died, so I would not read
>   a dose-response into that on its own.
> 
> - The failing hop is an ingress hop on a non-NHI port:
>     thunderbolt 0000:70:00.0: 0:5: hop deactivation failed for hop 0, index 1
> 
> - The enslave run is a smaller sample (the link dies faster there, so the
>   before arm only got two teardowns in): -ETIMEDOUT on both before the
>   change, 0 after.  Note the interface also gets destroyed on enslave
>   regardless of the ordering - that looks like a separate problem and this
>   patch does not claim to fix it.
> 
>  drivers/net/thunderbolt/main.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
> index 02a9165..a04c090 100644
> --- a/drivers/net/thunderbolt/main.c
> +++ b/drivers/net/thunderbolt/main.c
> @@ -386,11 +386,16 @@ static void tbnet_tear_down(struct tbnet *net, bool send_logout)
>  				break;
>  		}
> 
> -		tb_ring_stop(net->rx_ring.ring);
> -		tb_ring_stop(net->tx_ring.ring);
> -		tbnet_free_buffers(&net->rx_ring);
> -		tbnet_free_buffers(&net->tx_ring);
> -
> +		/* Tear the paths down before stopping the rings.  This mirrors
> +		 * tbnet_connected_work(), which enables the paths last so the
> +		 * Rx ring is primed before packets can arrive.  Stopping a
> +		 * ring zeroes its descriptor base and tbnet_free_buffers()
> +		 * unmaps and frees the frame buffers, leaving anything still
> +		 * in flight with nowhere to drain to;
> +		 * __tb_path_deactivate_hop() then waits for the hop's
> +		 * 'pending' bit, which on some host routers never clears in
> +		 * that state.
> +		 */
>  		ret = tb_xdomain_disable_paths(net->xd,
>  					       net->local_transmit_path,
>  					       net->tx_ring.ring->hop,
> @@ -399,6 +404,11 @@ static void tbnet_tear_down(struct tbnet *net, bool send_logout)
>  		if (ret)
>  			netdev_warn(net->dev, "failed to disable DMA paths\n");
> 
> +		tb_ring_stop(net->rx_ring.ring);
> +		tb_ring_stop(net->tx_ring.ring);
> +		tbnet_free_buffers(&net->rx_ring);
> +		tbnet_free_buffers(&net->tx_ring);
> +
>  		tb_xdomain_release_in_hopid(net->xd, net->remote_transmit_path);
>  		net->remote_transmit_path = 0;
>  	}
> --
> 2.43.0
