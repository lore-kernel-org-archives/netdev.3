Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793012479;
	b=D6M+2kDezUHra+VrurepP3bi+mfl6YT8Am7TSpSwyLyW7gGKr5C7PELliq0tnm3sAIJK
	 RRCABVDDyA3A+4pFMtaK0KyWDEtMJ94T5sxDKf1TBa5twxiQaykndbueoUA1vvzeCDGeL
	 0gCN9ytnDsD0kndiyUxrePH9AFm2K9/no6LIVoaaWDxHeabQdNkfj6uhyQ0zvxzRv9dhd
	 6Fxu7UILXgB+bIvt8UpVG2XfA4iW3Aq1XAttttdGe5DB9GhRmDCWNtxzEK0KYo5NSeS7C
	 f2rfaPDLtGj6k9eV8ProXYn9b5ZzbUxL8s2cg77kDVOppTAlz6IyA2pv19vimqSQvPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012479;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=uOCQRgnNFMnRtqKzyVZEFxukrVshewCOyvp/mheAzcM=;
	b=geuIWUTMAevpDJEOrh8Xnue8aOLaydqCQ1QVquTcZ/HIZdMKOMZS2Ytu9qHrGKAaVwf/
	 JUBv8waSiNW6I/cQaZ5pCSH0joma9hyBMvRHfH7PVEp+i1ZijIX6f4R52Buuo99dQ5uKN
	 m9qxCI8+vS1ZAeNQ3Nyor05/D02tNWRQOEUDag08Rt0Ww8PfMkmkVQSzOPg5jexDms89/
	 HdZRkHl7PAZFu2YQyFm6QM3k6hYL7kuQp8Lj2xwmSnKxRZx4GUVpO2aO85XZYHOqbdoGe
	 aIYhM8GtkAgiecxUmT1Iu0JwYlL0UhQ0CwHf5bAOesnbuZbRhb/tHMP1wZyd1ItCRZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L860xw4h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7084606A31A;
	Mon, 26 Oct 2026 11:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L860xw4h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62C91F01825;
	Mon, 26 Oct 2026 11:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793012478;
	bh=uOCQRgnNFMnRtqKzyVZEFxukrVshewCOyvp/mheAzcM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=L860xw4h7CqAIueEtJC8dBtyeVLOrv5gGO2MJIvzXjzFvu03xHZu6P/i2SNsyA139
	 LjDeFq4soz5aiLpmxz728hpXECdD1PH4phHPaBrNmwJDjAEbLhQvBK8VpGueUp/XoQ
	 qYfDB11utqD8ys/7VEaU0QwiNciA3n7xXxpg+ndr/3gEMDnO9zSouOgHI4/N55gZOv
	 hJ75tgExIez/zSB+9AzoUgRgV5ZRHzCtKYo4ZcGERhnQMf06MAKGpXb7X6UYrekaPD
	 UmE4254yc9AvH+Bj8nAsey01jC11wHAAYJXQ6heXUm50c1TTfApci43R/UEMM++VhC
	 Zzhl1qg7SvLJA==
Subject: Re: [PATCH net] bonding: fix missing down path on speed/duplex
 failure after FAIL->UP
From: netdev-bot+sashiko@kernel.org
To: timur.stukan.linux@gmail.com
Cc: netdev@vger.kernel.org, liuhangbin@gmail.com, fmancera@suse.de,
 jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 26 Oct 2026 11:01:17 +0000
Message-ID: <179301247732.3134.17655450292431284280@kernel.org>
In-Reply-To: <20261022103821.89552-1-timur.stukan.linux@gmail.com>
References: <20261022103821.89552-1-timur.stukan.linux@gmail.com>
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

- [Medium] In 802.3ad mode, the new `link_prev_state == BOND_LINK_FAIL`
  branch in bond_miimon_commit()…

--

bonding: fix missing down path on speed/duplex failure after FAIL->UP

This patch adds a link_prev_state field that holds the slave link state
from just before the miimon commit. If bond_update_speed_duplex() fails
while committing a BOND_LINK_UP proposal for a slave that was in
BOND_LINK_FAIL, the slave now goes through the full down path, including
failover. That down path is moved into a new bond_miimon_slave_down()
helper.

> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 09aa45d71fabb..602ad697a9c2b 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c

[ ... ]

> @@ -2807,10 +2828,21 @@ static void bond_miimon_commit(struct bonding *bond)
>  			err = bond_update_speed_duplex(slave);
>  			netdev_unlock_ops(slave->dev);
>  			if (err && bond_needs_speed_duplex(bond)) {
> -				slave->link = BOND_LINK_DOWN;
>  				if (net_ratelimit())
>  					slave_warn(bond->dev, slave->dev,
>  						   "failed to get link speed/duplex\n");
> +				/* Coming from FAIL, the slave is still in
> +				 * use and may be curr_active_slave, so take
> +				 * it through the full down path. Coming from
> +				 * DOWN/BACK, it was never brought up, so just
> +				 * revert it to DOWN.
> +				 */
> +				if (slave->link_prev_state == BOND_LINK_FAIL) {
> +					if (bond_miimon_slave_down(bond, slave))
> +						do_failover = true;
> +					continue;
> +				}

[Severity: Medium]
In 802.3ad mode, does BOND_LINK_FAIL always mean the slave is still in use?

bond_slave_netdev_event() also sets BOND_LINK_FAIL on NETDEV_UP and
NETDEV_CHANGE, and that has nothing to do with downdelay:

drivers/net/bonding/bond_main.c:bond_slave_netdev_event() {
    ...
		if (bond_update_speed_duplex(slave) &&
		    BOND_MODE(bond) == BOND_MODE_8023AD) {
			if (slave->last_link_up)
				slave->link = BOND_LINK_FAIL;
			else
				slave->link = BOND_LINK_DOWN;
		}
    ...
}

The last_link_up check passes for any slave that has ever been up. That
includes a slave that is currently BOND_LINK_DOWN and not in use.

Take an 802.3ad slave in BOND_LINK_DOWN with a non-zero last_link_up. Its
carrier comes back, but the driver still reports unknown speed or duplex,
for example during slow autoneg:

bond_slave_netdev_event(NETDEV_CHANGE)
    slave->link = BOND_LINK_FAIL
bond_mii_monitor()
    bond_miimon_inspect()
        case BOND_LINK_FAIL, link_state up -> propose BOND_LINK_UP
    slave->link_prev_state = slave->link    /* BOND_LINK_FAIL */
    bond_commit_link_state()                /* link = BOND_LINK_UP */
    bond_miimon_commit()
        bond_update_speed_duplex() fails again
        bond_miimon_slave_down()

Before this patch, this path only set slave->link back to BOND_LINK_DOWN.

With this patch, a slave that was already down now gets:

- link_failure_count incremented again
- BOND_SLAVE_NOTIFY_NOW link-state events
- a "link status definitely down, disabling slave" message, with no rate
  limiting
- a call to bond_3ad_handle_link_change(slave, BOND_LINK_DOWN), which
  reruns aggregator selection and rebuilds the slave array

This can happen again on every NETDEV_CHANGE that arrives while the slave
is down. Could "Link Failure Count" in /proc/net/bonding keep rising for a
port that never actually came back up?

The new comment ("Coming from FAIL, the slave is still in use") and the
commit message only cover the downdelay case. Should this branch also
check that the slave was really in use, instead of relying only on
link_prev_state?

>  				slave->link = BOND_LINK_DOWN;
>  				continue;
>  			}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022103821.89552-1-timur.stukan.linux%40gmail.com
