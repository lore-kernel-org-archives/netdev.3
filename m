Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793361018;
	b=gKgqrivk0H3RZSwk9T7JrQEiqhbdCuMCcdNyt2/olR1wPwbGCQ1I55E+jBGg1NxYpPgr
	 3YjKCdX7AJN5mtcEugu/QCqeUZVAa3mUtBI35yyt0M8M/AHwnbY5HX06vKvA1Bf/xIrmX
	 egKdQgTGKhax+KWRqC1C5r6WFmyz2BWx0tNMjUZOrX7mFUon7hVl+/WEQTx4KqeraQ/hs
	 ZRNX4SXotOJ6yseAgjE8JSGiZnGvnonKCYG7ZHkwTOs2BK0Ytm0DzrLy9R/T2e1L/RvM0
	 +ZXhm+O/V+LQ8uJRvepumHk53/xZntaAYWv3xHx4XfdrhPnG7VAGfmuor8dPoXk9f1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361018;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Y9tBmDBq/iPVr3cFIkD6fj2R0wR42yUYH0vH9Q6hm8w=;
	b=XKZ7buePwUrSnm1ELBlw5+V5dwd9GNdj+5GTVhGAVCaVshAmFkeokPisvqnyWCJRiXro
	 nghutgGXFf6GdfzWK1OlpJfk23bjJ4wDuvUnAWWS/1G9/qBtl2uH7q/MqRcHxK4Ro9R+u
	 bPoxnQmXaMgY96XxO9Ts2LIzJPK2yYIEZHVO2JJeHqIwhKOZACSuDWsT+6A/UOzJGVtbd
	 bWo+EUhLsolkK0FKDNgxOiR+l5vWZz/No4hciFiOZoAn+wxUgeOQaRzd9UjyjLLKo27Zz
	 or3N2ysN+hHVF4WMTNIT9G12DSpnhT0i4g6wfOkjVmpVkIifX+Le8okcAhwFeNEuKnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MhwjKS+u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7121606A31A;
	Fri, 30 Oct 2026 11:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MhwjKS+u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6FF1F00A02;
	Fri, 30 Oct 2026 11:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793361017;
	bh=Y9tBmDBq/iPVr3cFIkD6fj2R0wR42yUYH0vH9Q6hm8w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MhwjKS+uEfmB5Fc3XczwnXAcC9A2SoD3pah764QVtGDOG8CutmPrVYC5Zczz39Oga
	 g7ZsGKqq/QL+ZuKarItT9cZSyCdO311W1Zppjz7M2slaiN5BAsvDe9RW580mktmvaH
	 lGwRkL2vRb+bDC2FaYGoCX2QbQvi+ll3U5RsVAHhX8h9SteBHZgV8qhYRImGTYJnV3
	 u1nNWfO+fhhOP2auj45MLDrcuHeNw/Vef+TeHw9vAejJ7z7LhYeGpPkrLI3oWarE5V
	 rCsAvl3WBMgHhjgvpfK7HkVGDpLUruEjFVwg4Gub7ngSikmAP6IuD2hUvLr5aeWYht
	 hA5zGKtNo3YnA==
Subject: Re: [PATCH net v4 1/2] bonding: fix initial last_rx vs ARP-monitor
 slack window
From: netdev-bot+sashiko@kernel.org
To: ramses@well-founded.dev
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, jbohac@suse.cz, edumazet@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, razor@blackwall.org,
 hangbin.liu@linux.dev
Date: Fri, 30 Oct 2026 11:50:16 +0000
Message-ID: <179336101608.3134.1827486120303560891@kernel.org>
In-Reply-To: <20261028-bonding-last-rx-v4-1-4d8e4cd47467@well-founded.dev>
References: <20261028-bonding-last-rx-v4-1-4d8e4cd47467@well-founded.dev>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new DOWN-slave seed in bond_enslave()
  (drivers/net/bonding/bond_main.c:2160-2162, `last_rx = jiffies - (2 *…
- [Low] The new comment in bond_enslave() (bond_main.c:2156-2159) says
  the DOWN seed keeps the slave DOWN 'until a real reply arrives'.

--

bonding: fix initial last_rx vs ARP-monitor slack window

This patch moves the last_rx, target_last_arp_rx[] and last_tx seeding in
bond_enslave() so it runs after the initial link state is set. A slave
that starts DOWN is now seeded two arp_intervals in the past, which puts
it outside the arp_interval/2 slack that bond_time_in_interval() adds.
Slaves that start UP keep the old seed.

> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 7019e5d8fdc8e..bfa4cb97e647c 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c

[ ... ]

> @@ -2159,6 +2152,22 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>  
>  	if (new_slave->link != BOND_LINK_DOWN)
>  		new_slave->last_link_up = jiffies;
> +
> +	/* The ARP monitor's up test includes arp_interval/2 of slack, see
> +	 * bond_time_in_interval(). Seed a slave that starts DOWN outside
> +	 * that window, so it stays DOWN until a real reply arrives.
> +	 */

[Severity: Low]
This isn't a bug, but is "until a real reply arrives" accurate? More than
ARP replies can move last_rx forward.

With arp_validate=none (the default), bond_rcv_validate() updates last_rx
for any received frame:

drivers/net/bonding/bond_main.c:bond_rcv_validate() {
    ...
	if (!slave_do_arp_validate(bond, slave)) {
		if ((slave_do_arp_validate_only(bond) && is_arp) ||
    ...
		    !slave_do_arp_validate_only(bond))
			WRITE_ONCE(slave->last_rx, jiffies);
    ...
}

With backup validation, bond_arp_rcv() also accepts broadcast ARP requests
on backup slaves, with sip and tip swapped:

drivers/net/bonding/bond_main.c:bond_arp_rcv() {
    ...
	else if (curr_active_slave &&
		 time_after(slave_last_rx(bond, curr_active_slave),
			    curr_active_slave->last_link_up))
		bond_validate_arp(bond, slave, tip, sip);
    ...
}

Would wording like "until it receives qualifying traffic" fit better? The
commit message makes the same claim and may need the same change.

> +	if (new_slave->link == BOND_LINK_DOWN)
> +		new_slave->last_rx = jiffies -
> +			(2 * msecs_to_jiffies(bond->params.arp_interval) + 1);

[Severity: Medium]
This seed uses the arp_interval in effect at enslave time. What happens if
ARP monitoring is turned on later, or the interval is raised?

Here are two ways the seed can end up inside the up window.

If the slave is enslaved under miimon (arp_interval == 0) with no carrier,
it starts BOND_LINK_DOWN and the seed is just jiffies - 1.

If the slave is enslaved with, say, arp_interval=100 and the interval is
then raised to 1000, the seed (t0 - (2 * d_old + 1)) still falls inside
the window that bond_time_in_interval() builds from the new interval:

drivers/net/bonding/bond_main.c:bond_time_in_interval() {
	int delta_in_ticks = msecs_to_jiffies(bond->params.arp_interval);

	return time_in_range(jiffies,
			     last_act - delta_in_ticks,
			     last_act + mod * delta_in_ticks + delta_in_ticks/2);
}

In both cases bond_option_arp_interval_set() writes the new interval and
starts arp_work right away. It does not reseed last_rx,
target_last_arp_rx[] or last_tx on existing slaves:

drivers/net/bonding/bond_options.c:bond_option_arp_interval_set() {
    ...
			WRITE_ONCE(bond->recv_probe, bond_rcv_validate);
			cancel_delayed_work_sync(&bond->mii_work);
			queue_delayed_work(bond->wq, &bond->arp_work, 0);
    ...
}

The path then runs bond_activebackup_arp_mon() -> bond_ab_arp_inspect(),
and bond_time_in_interval(bond, last_rx, 1) returns true. That proposes
BOND_LINK_UP for a slave with no carrier that has received nothing.

If that slave is the configured primary, force_primary may still be
pending. Under miimon the primary was DOWN, so
bond_choose_primary_or_current() never used up force_primary. The primary
then becomes active, fails ARP validation, and with
primary_reselect=failure the bond stays on the backup. That is the same
result as the reproducer in the commit message.

arp_interval has no BOND_OPTFLAG_NOSLAVES, and bond_open() does not reseed
either. The follow-up patch in this series ("bonding: give a slave that
starts UP a full arp_missed_max window") only changes the UP branch.

Should bond_option_arp_interval_set() also reseed slaves that are DOWN?

> +	else
> +		new_slave->last_rx = jiffies -
> +			(msecs_to_jiffies(bond->params.arp_interval) + 1);
> +	for (i = 0; i < BOND_MAX_ARP_TARGETS; i++)
> +		new_slave->target_last_arp_rx[i] = new_slave->last_rx;
> +
> +	new_slave->last_tx = new_slave->last_rx;
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028-bonding-last-rx-v4-0-4d8e4cd47467%40well-founded.dev
