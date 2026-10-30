Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357453;
	b=dstZ6QJ82vmiXLGMfuJDvsJrxebLWb42fEMFtG5aSCAhD9f5ZRGKMpGRiJWTvEqaj0Uv
	 1TpsyKyxmeOVBtseJISONOc06N0Dai2y9wWZm4e/07emli4VjLS25Y1gUYLsFiqtK+zIv
	 upgvEj5R7+QZeUllY31cwFN8vrkSs2/xTEBJ00Cvdfv4Fp2EiNeSmFui4cPx+8ngNiHKC
	 HWGEpyIGiolX/PpF2SRtl8L6oyX2pQVHs3BlBzrVf9861aao4BTqhMc2yWUZzYqaQZU4q
	 Tzi/UM33IkAC5pFpFj9oQ7XdJiJuvLY9MrwWYXNYDosmw37sGA1AzbhZ1rXtA1GsiYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357453;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=3ZA1tFIQbefFkP0k1Tx7ybaXRmfxV/nEBepijkpjAgg=;
	b=B0HQAnIKS3Jb4y6yVsLx2/hr2T9BdKiz/6HOJZL1Gj/pFb3sFfRswGEXQb6wB0ROyYIn
	 kqqDwZtr2tnvf8B+5CpVrm1vEpPgGxFN7b/81/wbq0bIhLZrTN7IXij/GdFeATuhS1VlF
	 iNM5J7VcBrqturvWGG5jq0bvaYkaXXTEKE4AuGjANGIRafAZPwF/ck9bksx/OR7gMmAEU
	 9jYOtfPB4MGSE+DRsjs2thGLzXxsCuVYdaHqAsmrkrgil4c5oAa2W+R0z15cqPOsN8mZe
	 YIFsFtUc54/DXJnpYGKmMXLoy9HkMQ227rTPcC1Gs+fVNyfV43N8Rd1pVY6O2qDIuBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CxOdNEIH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36646606B979;
	Fri, 30 Oct 2026 10:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CxOdNEIH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7933A1F000C1;
	Fri, 30 Oct 2026 10:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793357453;
	bh=3ZA1tFIQbefFkP0k1Tx7ybaXRmfxV/nEBepijkpjAgg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CxOdNEIHHgwssYhKwmgc//1ZAjB1rGJWu73+RkAkWS2DonjemBGQs4gvvlgVitqJz
	 281Lgnu0wWAImoTpPH9sdd6YHBX+mNtmsAwczMwKX7G0o/dzk/vvxDbQZ9BPXUoyLY
	 vO70fmZEuTnGCADkyQllCua2LJAFzSXmQctuXiKJQsx/21WZRVW90P4cp4ud4kbc/V
	 WJc1sLtmlWd4xn+ywxeGJ+6jgJtbmHaeFffSDLsIAVsEPKL3dju9ojiRh3gftbxlh+
	 1wyIM2nM1ZWlVf3dX7Os/lV0MxSngisB6J7jTW5AtZmoRYgUziQpfhk67Bd6iAmDNU
	 h+hWxV6O7qIvQ==
Subject: Re: [PATCH net v2] bonding: fix missing down path on speed/duplex
 failure after FAIL->UP
From: netdev-bot+sashiko@kernel.org
To: timur.stukan.linux@gmail.com
Cc: netdev@vger.kernel.org, hangbin.liu@linux.dev, razor@blackwall.org,
 fmancera@suse.de, jv@jvosburgh.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Fri, 30 Oct 2026 10:50:52 +0000
Message-ID: <179335745203.3134.6448413016247418659@kernel.org>
In-Reply-To: <20261028104758.299129-1-timur.stukan.linux@gmail.com>
References: <20261028104758.299129-1-timur.stukan.linux@gmail.com>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In 802.3ad mode, a slave that has already gone through the
  full down path can now go through it a second time.
- [Medium] The fix only sends `slave->link == BOND_LINK_FAIL` through the
  full down path.

--

bonding: fix missing down path on speed/duplex failure after FAIL->UP

With this patch, bond_mii_monitor() no longer pre-commits BOND_LINK_UP
proposals, so bond_miimon_commit() can still see the previous link state
when the speed/duplex lookup fails. Slaves coming from BOND_LINK_FAIL now
go through the regular down path, including failover. That path is moved
into the new bond_miimon_slave_down(), and DOWN/BACK slaves are still
reverted to DOWN directly.

> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 7019e5d8fdc8e..9bafcddbb453c 100644
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
> +				if (slave->link == BOND_LINK_FAIL) {
> +					if (bond_miimon_slave_down(bond, slave))
> +						do_failover = true;
> +					continue;
> +				}

[Severity: Medium]
Does slave->link == BOND_LINK_FAIL always mean the slave is still in use?

In 802.3ad mode, bond_slave_netdev_event() can set FAIL on a slave that
is already DOWN:

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

last_link_up is a timestamp and is never cleared. Take a slave that was
up once and then went through the down path. If NETDEV_CHANGE arrives
when carrier returns and speed/duplex is still unknown, the slave is
relabelled FAIL. The next bond_miimon_inspect() sees FAIL with carrier up
and proposes BOND_LINK_UP from the "recovered before downdelay expired"
branch.

There is also a race: inspect proposes UP for a DOWN/BACK slave, and a
carrier notifier sets FAIL between rcu_read_unlock() and rtnl_trylock()
in bond_mii_monitor().

Before this patch, bond_mii_monitor() committed the UP proposal first.
That overwrote the notifier's FAIL, and a speed/duplex failure then only
did slave->link = BOND_LINK_DOWN. With the new skip in bond_mii_monitor():

	if (slave->link_new_state == BOND_LINK_UP)
		continue;

FAIL is still set when this branch runs. If speed/duplex is still
invalid, bond_miimon_slave_down() runs a second time for a port that is
already disabled.

Would that increment link_failure_count again and log "link status
definitely down" twice? It would also send another NOTIFY_NOW lower state
event, rerun bond_3ad_handle_link_change(BOND_LINK_DOWN), and possibly
request failover.

The patch notes call the notifier relabelling pre-existing, but only for
the FAIL->DOWN downdelay route. This looks like a new route to the same
double down accounting, and the new comment states the "still in use"
assumption as fact.

> +				slave->link = BOND_LINK_DOWN;
>  				continue;
>  			}

[Severity: Medium]
Can an in-use slave reach this fallback with slave->link == BOND_LINK_UP?

bond_miimon_inspect() runs under RCU only. In the BOND_LINK_BACK case it
can propose BOND_LINK_UP once updelay expires or ignore_updelay is set.

Between rcu_read_unlock() and rtnl_trylock() in bond_mii_monitor(),
another RTNL holder can call bond_select_active_slave(). Examples are
__bond_release_one(), bond_enslave(), the primary/prio/active_slave
option setters and NETDEV_CHANGENAME. If that picks the BACK slave, it
gets promoted:

drivers/net/bonding/bond_main.c:bond_change_active_slave() {
    ...
		if (new_active->link == BOND_LINK_BACK) {
			...
			new_active->delay = 0;
			bond_set_slave_link_state(new_active, BOND_LINK_UP,
						  BOND_SLAVE_NOTIFY_NOW);

			if (BOND_MODE(bond) == BOND_MODE_8023AD)
				bond_3ad_handle_link_change(new_active, BOND_LINK_UP);

			if (bond_is_lb(bond))
				bond_alb_handle_link_change(bond, new_active, BOND_LINK_UP);
    ...
}

The slave is now curr_active_slave with link == UP, and in alb/tlb it
holds the bond MAC. bond_mii_monitor() skips the UP proposal. If
bond_update_speed_duplex() then fails here, the FAIL check is false. The
active slave is set to DOWN without bond_miimon_link_change(), TLB/RLB
cleanup or failover. The next inspect sees DOWN with no carrier and does
nothing.

bond_enslave() can leave the same link == UP / link_new_state == UP state
if it completes in that window, even when its own speed/duplex check
failed.

This path behaves the same as before the patch. But the new comment says
DOWN/BACK slaves were never brought up, and that is not true here.

Would checking for "not DOWN/BACK", or for slave == curr_active_slave,
catch this case as well as FAIL?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028104758.299129-1-timur.stukan.linux%40gmail.com
