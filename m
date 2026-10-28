Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793190318;
	b=Bk7jligkVJGjN78Rrg4L4bGDqB8d32RESIa3DQCjrHRR4EiHI7girbB4IN/OgOUfirrz
	 KviClwF3+qowMIpxBGAH8buqqL9cV2V5BozqVWj7WNqNFzKgzrMpHS4b58GB2A0F4gt6L
	 evNy6SjdGpTecLCRpnf72XyX6nRH9CiLzDJC5gGsTdfo7RakjnFtBaqk30+dsODaDOhvt
	 ThZ9ytU9ipSMrCIs5tk2VOgj1J8LrpKUdAwoKvmLEAnZh6B81RD5cAa1vuRFzxZOYYuNO
	 XsFg48vTc2iT0OKuTL9quGoAmFJDDdsXnnmzbHtzW4zwErlyY5NIFsWaa8bvRkj22yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793190318;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=s4OWMi3a8s2wA4xLjiaf+j11RhfHAHM82llxPPU2rPM=;
	b=1WfBFBWn4zmMe1uW34h0rlIFlTS7lYo4vgBMWIjEFDEBZeqBqvJ5a+hFmFFsvbti+FYk
	 nzojK7sojjLFfjC7hFHPoC3X12ewjK4mBkSDpJvAhGPHtA3PCOzsOEDOolwARJMzuVRuI
	 cw3aGwIpW+A6PWL2oz6GZUNGyoNElx+UoYD/IeKXW0m7p95SufOVyc3uUzQMLrmUDP6GV
	 pdzUFWWBnK5sKC3B/j30Tp2CaKIubN8c6EJ8KznKuJOQ7Rw/Zz20cgfwtyAofs7asx7Gs
	 CUstDPbGs+rkkdT1WtOpIrzgNzVdzLh5o6WIAMMf8t6HzBpgjChIDcdGaYvrd6VjsNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D9Y6eDhf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193D9606A31A;
	Wed, 28 Oct 2026 12:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D9Y6eDhf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DA11F01825;
	Wed, 28 Oct 2026 12:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793190317;
	bh=s4OWMi3a8s2wA4xLjiaf+j11RhfHAHM82llxPPU2rPM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=D9Y6eDhfcdUsVH6F3wKJudaPj7jPaGHuZORFmOjXXcbSKHAU1uhVxVXLARYT5V5al
	 jpEOTV4dygvds5SG4gyqbHvCAGElNhUnGxxZREz+e+5RFHLOoO16yzI3lpLH/s3EZH
	 /XY6Y/OR2A43RpPdgt09SJ51P5Aigg9cYK9l4T2KwNFCLw0iV0dM8ioE4OE1P2o09d
	 3LRajvFZXdPywZmCrxTzUmNmgQhJERuRG3Mq2dZVny5q1i5ZCknxZIFPaKjcE3NtW3
	 GGwi1wUe82jPFo5v+xzBx+tMFvBV0gdnYhMtxmb6xsikTUj2fphiNcpMs+w9j1sn6S
	 iebHacYGO7Mfw==
Subject:
 Re: [PATCH net v3] bonding: fix initial last_rx vs ARP-monitor slack window
From: netdev-bot+sashiko@kernel.org
To: ramses@well-founded.dev
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, jbohac@suse.cz, edumazet@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, razor@blackwall.org,
 liuhangbin@kylinos.cn
Date: Wed, 28 Oct 2026 12:25:16 +0000
Message-ID: <179319031668.3134.15966773474485635933@kernel.org>
In-Reply-To: <20261027-bonding-last-rx-v3-1-54907f1fb042@well-founded.dev>
References: <20261027-bonding-last-rx-v3-1-54907f1fb042@well-founded.dev>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch ages last_tx along with last_rx (new_slave->last_tx
  = new_slave->last_rx), so last_tx is now two intervals old instead of…

--

bonding: fix initial last_rx vs ARP-monitor slack window

This commit moves the initial last_rx seed in bond_enslave() from one
arp_interval in the past to two. The goal is to keep the seed outside the
arp_interval/2 slack window that commit da210f559019 added. The
per-target array and last_tx get the same seed, because they are copied
from last_rx.

> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 7019e5d8fdc8e..269384fadfa6f 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -2123,7 +2123,7 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>  		new_slave->link = BOND_LINK_DOWN;
>  
>  	new_slave->last_rx = jiffies -
> -		(msecs_to_jiffies(bond->params.arp_interval) + 1);
> +		(2 * msecs_to_jiffies(bond->params.arp_interval) + 1);
>  	for (i = 0; i < BOND_MAX_ARP_TARGETS; i++)
>  		new_slave->target_last_arp_rx[i] = new_slave->last_rx;
>  

[Severity: Medium]
Just after this hunk, bond_enslave() copies the same value into last_tx:

	new_slave->last_tx = new_slave->last_rx;

So last_tx now also starts two intervals old. Could that cause a spurious
UP->DOWN transition in bond_loadbalance_arp_mon(), used by balance-rr,
balance-xor and broadcast with arp_interval set?

A slave enslaved with carrier OK starts as BOND_LINK_UP. On the first
arp_work pass, the UP branch checks last_tx before this slave's first
bond_send_validate() call in the same loop:

	if (!bond_time_in_interval(bond, last_tx,
				   bond->params.missed_max) ||
	    !bond_time_in_interval(bond, READ_ONCE(slave->last_rx),
				   bond->params.missed_max)) {

		bond_propose_link_state(slave, BOND_LINK_DOWN);
	...
	if (bond_slave_is_up(slave))
		bond_send_validate(bond, slave);

Unlike bond_ab_arp_inspect(), this path has no last_link_up grace. The
comment there says each slave is given "as long as it needs to get the
tx/rx within the delta".

bond_time_in_interval() accepts jiffies up to:

	last_act + mod * delta_in_ticks + delta_in_ticks/2

With d = arp_interval in jiffies, J0 = enslave time and the new seed
J0 - 2d - 1, the upper bound is:

  missed_max = 2 (default): J0 + d/2 - 1
  missed_max = 1:           J0 - d/2 - 1

With the old seed and missed_max = 2 the bound was J0 + 1.5d - 1, which a
first tick at or before J0 + d never crossed.

The arp_work tick phase does not depend on when the slave is enslaved.
With default settings, does that mean roughly half of enslavements into a
running load-balance bond see the slave marked down on the first tick,
before any probe has gone out? With missed_max = 1, would every carrier-up
slave be marked down on its first tick?

When that happens, link_failure_count is incremented, "interface is now
down" is logged, and do_failover is set if this is curr_active_slave. The
link only comes back on the next tick, after the first ARP has been sent.

Documentation/networking/bonding.rst describes arp_missed_max as:

	Specifies the number of arp_interval monitor checks that must
	fail in order for an interface to be marked down by the ARP monitor.

The commit message says:

  Seed last_rx (and with it the per-target array and last_tx) two
  intervals in the past, so it is outside the slack window from the
  start.

It does not mention the effect on the UP->DOWN checks in
bond_loadbalance_arp_mon(). Would it make sense to keep last_tx at its
previous seed, or to describe this behaviour change in the commit message?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261027-bonding-last-rx-v3-1-54907f1fb042%40well-founded.dev
