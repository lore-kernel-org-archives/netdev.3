Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793361019;
	b=na4VxetyoGvA4VCnBcbhXTf7fNEJw1tCb56usxr+grVp+XLJGWVDGdy6ZFhtDzYrcewq
	 qXATqrwFaDKzkITJFPY/2DuHLUZ2n3aqkZW9PqHL2xaM/mZr2XvKLnOKrExj5boOPhZ59
	 ysSsUmWAXHpfIkG/FP9FE3CWbGmvh9wn/2YYB9QCoDFHOSLDEOEgywUbDdOm1r6l3Y3yZ
	 Oz8F6QlxYM3ytUzn3s+k7dqMS2T+sOKiaRWQJBB2MEdcUt1E1nn7Lukv8qPsBiq7+vUB7
	 2kvPIpxV3jkGUuI+sTQcsnizZEhlWVANbVs/ImVjE6wV9h1guFkuWew3zmtnAha4hJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361019;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=8VG0mWXUK1UFcStaiKwUURYv58tMB9hixdZ4vYpcZP0=;
	b=RXbJU4Gn0tHdNkBtvA/uM+vtzOj0a08fBcogu8YJ/+4+e3UyvcTSfcB8IUdPCib3V15R
	 WGxrW7kBS2hdH0vRzZASVs/jZbst+8pPv2+I5MmmRv6IKZVZV2+z5qni/6GDF8Tp5oC4V
	 Gy2iPdU1e6GKWWVp73y/gds8xBZD/k5GWd8WiC7hH4KpREXKE2G4YPFl2SdSJBdH8XLlO
	 Qvv2kyEXgkf/944hRNkQo0OsS/vcHEQ2bb2P4VCtC50ZIIL6gCjpC8o3aTsTg1GUIupWB
	 hYk+WXwmxoeoWcVs3eVYpWoALJ6ljoNO5X4mhCRlImwgI6xg8vsZyJwSYAqg3uMao3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M8bfTpnc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9C3606A322;
	Fri, 30 Oct 2026 11:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M8bfTpnc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F391F000C1;
	Fri, 30 Oct 2026 11:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793361018;
	bh=8VG0mWXUK1UFcStaiKwUURYv58tMB9hixdZ4vYpcZP0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=M8bfTpncscMhnnbbOCvAQgBJFTf//W+3TNv4mYLvtA516bhr6WvLkjFL1tx1j75wE
	 Y+9Y2SwNaMMUy6Had8YaB7IQ+OVWEjBMZHRCun7tPhR0eg5drwuycDJ69rdhSgLpkk
	 zr55i9DgngZBtkfm8hmGnCj8Bj6mgsNwYaDMS10bN03lCNI6rjg0+8BeWVp3SC0/aJ
	 HxjxpjB+eipJtkSXER2Q6YRLQGK7YUlmQ8PW5YykK10Bui8KipUeVT+MhuM1autSc1
	 lN5uLGrKfsjSkjn6ke3aDebz0kCFuGfMCZw5YLepsYswFUMaHIr+0yVkdwEHMXWIdh
	 x05/IkAeBvXgA==
Subject: Re: [PATCH net v4 2/2] bonding: give a slave that starts UP a full
 arp_missed_max window
From: netdev-bot+sashiko@kernel.org
To: ramses@well-founded.dev
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, jbohac@suse.cz, edumazet@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, razor@blackwall.org,
 hangbin.liu@linux.dev
Date: Fri, 30 Oct 2026 11:50:17 +0000
Message-ID: <179336101737.3134.5509394527190638689@kernel.org>
In-Reply-To: <20261028-bonding-last-rx-v4-2-4d8e4cd47467@well-founded.dev>
References: <20261028-bonding-last-rx-v4-2-4d8e4cd47467@well-founded.dev>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch only covers a slave enslaved while the ARP monitor is
  already running.

--

bonding: give a slave that starts UP a full arp_missed_max window

This commit changes bond_enslave() so that a slave that starts UP has
last_rx seeded from last_link_up. Before, it was seeded one arp_interval
in the past. The goal is a full arp_missed_max window before the
load-balance ARP monitor can report the slave down.

> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index bfa4cb97e647c..de5b196f4a1ee 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -2160,9 +2160,12 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>  	if (new_slave->link == BOND_LINK_DOWN)
>  		new_slave->last_rx = jiffies -
>  			(2 * msecs_to_jiffies(bond->params.arp_interval) + 1);
> +	/* Give a slave that starts UP a full arp_missed_max window. Not
> +	 * seeding it later than last_link_up keeps bond_arp_rcv() from
> +	 * trusting ARPs on backup slaves before the active one got a reply.
> +	 */
>  	else
> -		new_slave->last_rx = jiffies -
> -			(msecs_to_jiffies(bond->params.arp_interval) + 1);
> +		new_slave->last_rx = new_slave->last_link_up;

[Severity: High]
Does this fix still miss the case where the ARP monitor starts some time
after enslavement?

The new seed is the enslave time. It goes into last_rx, every
target_last_arp_rx[i] and, a few lines below, last_tx. If the bond is down
when the slave is enslaved, recv_probe is NULL and arp_work is not queued.
So last_rx is not updated by bond_rcv_validate(), and last_tx is not
updated by bond_arp_send()/bond_ns_send().

Later, bond_open() starts the monitor right away without re-seeding these
fields:

drivers/net/bonding/bond_main.c:bond_open() {
    ...
	if (bond->params.arp_interval) {  /* arp interval, in milliseconds. */
		queue_delayed_work(bond->wq, &bond->arp_work, 0);
		WRITE_ONCE(bond->recv_probe, bond_rcv_validate);
	}
    ...
}

bond_option_arp_interval_set() does the same thing when arp_interval is
turned on at runtime.

The first bond_loadbalance_arp_mon() run then checks the enslave-time
values, before bond_send_validate() has sent any probe on the slave:

drivers/net/bonding/bond_main.c:bond_loadbalance_arp_mon() {
    ...
			if (!bond_time_in_interval(bond, last_tx,
						   bond->params.missed_max) ||
			    !bond_time_in_interval(bond, READ_ONCE(slave->last_rx),
						   bond->params.missed_max)) {

				bond_propose_link_state(slave, BOND_LINK_DOWN);
    ...
				slave_info(bond->dev, slave->dev, "interface is now down\n");
    ...
}

Take missed_max=1 and arp_interval=1000. If more than 1.5s passes between
enslave and "ip link set bondX up", a healthy slave is marked down. Its
link_failure_count goes up, and failover runs if it was curr_active_slave.
The next run brings it back up.

If arp_interval is enabled on a running bond whose slaves were enslaved
long ago, every UP slave could go down at the same time for one interval.

The old seed behaved the same way here. Still, the commit message says the
slave "gets a full arp_missed_max window for its first reply". That does
not seem to hold when monitoring starts after enslavement.

Would it make sense to also re-seed last_rx, last_tx, target_last_arp_rx[]
and last_link_up when the ARP monitor is started in bond_open() and
bond_option_arp_interval_set()?

>  	for (i = 0; i < BOND_MAX_ARP_TARGETS; i++)
>  		new_slave->target_last_arp_rx[i] = new_slave->last_rx;
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028-bonding-last-rx-v4-0-4d8e4cd47467%40well-founded.dev
