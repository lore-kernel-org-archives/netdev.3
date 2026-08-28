Received: from mta0.migadu.com (out-50.mta0.migadu.com [91.218.175.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBB430DED5
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 02:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787885414; cv=none; b=YNevdQAMk3G6b3xuQqx7KmB292K9kQQcGe24cH+8Geo+HHAVzxESn3OavoDqzfueY6ilhS+RknNGcLS6DTBijU0IpzLWM3rZWKj9bSzHGyl6uHhF0pUZshYNejdSzugBxjhPhCwLfzxcT8pgkLPyz6Y+sTCMMNNZ2h+TszEqiKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787885414; c=relaxed/simple;
	bh=PyLxxoQkuzWGfdy8Bdesmy9AppZutLYqvrD0li3nAA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHvryBInWiTAP2tfEstQS8YAHc0R4dtDz6lWVeTrBp+cDi0+jSRK32FKu2JurjGxYgRRo+u05yq91w7T6N3n6EJqLCOk0cfRD7zDKHW5NHvSKZsdMEXhK6Ntv/ukbZxwsczL5ozvkKdVuh989R3w2euqKOA7UVbvZcwLHPsLQMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NilnXoa0; arc=none smtp.client-ip=91.218.175.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NilnXoa0"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=PyLxxoQkuzWGfdy8Bdesmy9AppZutLYqvrD0li3nAA4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787885410; v=1; x=1788490210;
 b=NilnXoa0lUmRhzvGqEed4zgcKnCeu6DTtyyK3u+CNrdiFDxruvHfWaUz9aaW6dkYo7JBIqZb
 5/pzAChl2zreOkkFiyLnDw45G3pnXj0a0Z8wwl5wYRPaOfYwHoNxfflbTqRz1VWAPit+yDD3aeC
 D95dJQ1okiC46neaj9ibuqDI=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6a6b53d03bb3845f;
	Fri, 28 Aug 2026 02:50:10 +0000
X-Mizu-Trace-ID: 6a6b53d03bb3845f
X-Migadu-Flow: FLOW_OUT
Date: Fri, 28 Aug 2026 10:49:59 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: ramses@well-founded.dev
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Bohac <jbohac@suse.cz>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] bonding: fix initial last_rx vs ARP-monitor slack
 window
Message-ID: <apD3VyaIOmMlv6kK@fedora>
References: <20260827-bonding-last-rx-v2-1-7c3833822c23@well-founded.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827-bonding-last-rx-v2-1-7c3833822c23@well-founded.dev>

On Thu, Aug 27, 2026 at 01:44:42PM +0200, Ramses de Norre via B4 Relay wrote:
> From: Ramses de Norre <ramses@well-founded.dev>
> 
> Commit f31c7937c254 ("bonding: start slaves with link down for ARP
> monitor") initialises a freshly enslaved port's last_rx to
> jiffies - (arp_interval + 1) so that it does not "immediately cause
> fake detection of 'up' state". At the time, the comparison was a plain
> <= arp_interval and the value was just stale enough.
> 
> Commit da210f559019 ("bonding: add some slack to arp monitoring time
> limits"), four months later, added a +arp_interval/2 slack term to
> every comparison (now bond_time_in_interval()) but did not widen the
> init to match. Since then, bond_time_in_interval(bond, last_rx, 1) is
> true for the first ~arp_interval/2 after enslavement even though no
> packet has been received: the upper bound is last_rx + 1.5*delta and
> last_rx was set to jiffies - delta - 1.
> 
> If the ARP monitor tick lands in that window, bond_ab_arp_inspect()
> proposes the slave UP. If the slave is the configured primary,
> bond_ab_arp_commit() sets do_failover and the still-armed
> force_primary in bond_choose_primary_or_current() makes it the active
> slave regardless of primary_reselect. ARP validation as the active
> slave then fails (the link has not actually received anything; on
> SFP+ ports the PHY is often still negotiating) and the bond falls back
> to the backup. With primary_reselect=failure, force_primary has now
> been spent and the bond stays on the backup until something else
> triggers a reselect.

Can we set primary_reselect to always or better to avoid this? If you prefer
to using the primary slave.

> 
> Reproducer:
> 
>   ip link add bond0 type bond mode active-backup arp_interval 1000 \
>       arp_validate all arp_ip_target 192.0.2.1 \
>       primary eth0 primary_reselect failure
>   # eth0: SFP+ (slow link-up), eth1: RJ45 (fast link-up)
>   ip link set eth0 master bond0
>   ip link set eth1 master bond0
>   ip link set bond0 up
>   # bond0 lands on eth0 via force_primary, ARP-fails it before the
>   # SFP+ has carrier, falls to eth1, and stays there.
> 
> Initialise last_rx (and the per-target array, and last_tx) to two full
> intervals in the past so it is outside the slack window from the
> start.

Is this trying to init the backup slave down by default?

Thanks
Hangbin
