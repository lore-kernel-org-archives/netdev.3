Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793453911;
	b=izJDOsovgUDQ1bJfbPkHhrCZTcQxG7CTQjIcaS1lxOe13cP4/xqrxpJQULsR/EFF84cF
	 6UYWKOM1eUm17wNgpBgC5Z6z9WfmQu6+5Aig7zXvSLkWn8WgcUig1MYqzfZvh53NSyOjX
	 GLqQdNZD3xbP1bQ4SFp8sa8/QnMdTc5Vaw9xxkOfc+nWjqrsYAtokzW2ZN+Cnf6nizPJR
	 qM1qsTBgaVr6FvUgIvweterKgcQzdnuDnG7sgBFYz+eTWmuN59OirDKVlD3r6IhJUmACc
	 GSNVJjyFIsrKiXtZp2n35WpXIpRvA2U0XlV7xCn1/J0iNRmOSpZX/MHbdo4LZjzvIeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793453911;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=jusxyOC6tYlJdH/ZE6LTo1YpYYnLHVl36GtN11/2NOI=;
	b=1CGHLhWWcZFefzsdSA/mSa+mecAIz3GG2Mo4gpXxw4YF1ewIHhfG8L6a0NGYDdm69zGm
	 O7LRQcarfgUsbhsDpYaiQe9N7cJvT/1KNejNhTTEUz0MwVLSXkqpnWvRaBTweCEhAcPc9
	 msvvcmL+Nn6no3G5A0qO5H6Ee3S/BdgKtGTNZBMN6/w/EiH27BjzfVeSRjSjx14d6bD6t
	 GFsovDLjG48rGrXaGt8+vmGluOfhw358gO7aAhoy3MHamKvxzrbflQGaN/ot/4BIlcSUv
	 bkCD2UkenaO1By3UcaHmhTg+bgZ15Knaw3rwKGxGTuEb/AmJ4nI3oqGy8d9SYqsUOlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DwfibxUE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62688606A31C;
	Sat, 31 Oct 2026 13:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DwfibxUE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD831F00919;
	Sat, 31 Oct 2026 13:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793453911;
	bh=jusxyOC6tYlJdH/ZE6LTo1YpYYnLHVl36GtN11/2NOI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DwfibxUEDI8GOYfy/0eBZG0mS56fEN0hvy3NjH5FiMzGqrZOObgRPLwMRMSWx+no6
	 JkNr/TWxhtX2TnfzC+GfOOLJDPFBJ69z6txJgUXRr+FlIVx4FFOM6B2m6JB44SMlQm
	 PBz9A2ZrBEm1ZrJMjoy6+mgitgvwAiSIP9V0a7a3itHk9xS2mm+2tijla/PbB3Ncqh
	 gwrXYCSRxHROOuxVGa7JcOTgvmQzIWMYY7YnxJFUZIWQgGRwyLphV3GC6agFt+kkoh
	 Upm1+lTQv/uMgKe58hCLLZYEUtJBtqmD84Sn2CAVXbY4hGtfcPT5BY1tLFK1lreIuD
	 ElqHPQLa3tggA==
Subject: Re: [PATCH net v2 2/2] net: ti: icssg-prueth: Fix R30 command timing
 and NULL emac dereference
From: netdev-bot+sashiko@kernel.org
To: m-malladi@ti.com
Cc: haokexin@gmail.com, jacob.e.keller@intel.com, pabeni@redhat.com,
 kuba@kernel.org, edumazet@kernel.org, davem@davemloft.net,
 andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com, vigneshr@ti.com,
 danishanwar@ti.com
Date: Sat, 31 Oct 2026 13:38:29 +0000
Message-ID: <179345390998.3131.14702616619238898955@kernel.org>
In-Reply-To: <20261027131732.3411403-3-m-malladi@ti.com>
References: <20261027131732.3411403-3-m-malladi@ti.com>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 3 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The commit message describes the crash as happening when "the
  first port opens before the second is initialized".
- [Medium] The NULL-emac guard this patch adds to
  icssg_enable_fw_offload() fixes a crash introduced by the previous…
- [Medium] The patch fixes a user-visible regression but has no Fixes:
  tag.
- [Medium] prueth_emac_restart() (line 1858) stops and restarts the PRU
  firmware while phylib is still running for the active ports.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  prueth_cleanup_tx_ts() (icssg_common.c:1424-1434) frees every non-NULL…

--

net: ti: icssg-prueth: Fix R30 command timing and NULL emac dereference

This patch moves the per-port emac_adjust_link() reconfiguration in
prueth_emac_common_start() so it runs after prueth_emac_start() has booted
the PRU firmware. The goal is to stop R30 commands from timing out. It
also adds a NULL check for the prueth->emac[] slots in
icssg_enable_fw_offload().

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index 746afd5d00c9e..9afda5da3ca3a 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -213,6 +213,8 @@ static void icssg_enable_fw_offload(struct prueth *prueth)
>  
>  	for (mac = PRUETH_MAC0; mac < PRUETH_NUM_MACS; mac++) {
>  		emac = prueth->emac[mac];
> +		if (!emac)
> +			continue;

[Severity: Medium]
The commit message says icssg_enable_fw_offload() "dereferences a NULL
second emac slot when the first port opens before the second is
initialized". Is that what actually triggers it?

prueth_probe() calls prueth_netdev_init() for both ports, which fills both
prueth->emac[] slots, before the first register_netdev(). So at ndo_open
time a slot is only NULL when the port is missing from DT or disabled
there.

In the baseline, every emac dereference in icssg_enable_fw_offload() was
under is_hsr_offload_mode or is_switch_mode, and both of those modes need
two ports. The dereference that plain EMAC mode can reach seems to come
from the previous patch in this series, commit 12b7fbafdb45 ("net: ti:
icssg-prueth: Fix bridge port_vlan and flooding state"):

    if (!prueth->is_switch_mode && netif_running(emac->ndev)) {

Take a single-port board with that commit applied but not this one. The
first emac_ndo_open()->icssg_enable_fw_offload() would then dereference a
NULL emac, so a bisect would land on the intermediate commit.

Could this guard be folded into that patch, with the R30 ordering change
kept as its own patch?

>  		if (prueth->is_hsr_offload_mode) {
>  			if (emac->ndev->features & NETIF_F_HW_HSR_TAG_RM)
>  				icssg_set_port_state(emac, ICSSG_EMAC_HSR_RX_OFFLOAD_ENABLE);
> @@ -288,13 +290,22 @@ static int prueth_emac_common_start(struct prueth *prueth)
>  		ret = icssg_config(prueth, emac, slice);
>  		if (ret)
>  			goto disable_class;
> +	}
> +
> +	ret = prueth_emac_start(prueth);
> +	if (ret)
> +		goto disable_class;
> +

[Severity: Medium]
This fixes a user-visible regression: R30 FORWARD commands time out, and
prueth_emac_restart() then fails when ports with link up join or leave a
bridge or HSR. The commit has no Fixes: tag, though.

The emac_adjust_link() call ahead of prueth_emac_start() came from
06feac15406f ("net: ti: icssg-prueth: Fix emac link speed handling").

The emac->link = 0 reset, which makes adjust_link send FORWARD on every
restart while the link is up, came from 147792c395db ("net: ti:
icssg-prueth: Fix ping failure after offload mode setup when link speed is
not 1G").

Should this carry Fixes: tags for one or both of those, so that stable
trees containing them also pick up this fix?

> +	/* Reset link state and reconfigure after firmware is running.
> +	 * Must be done after prueth_emac_start() so that R30 commands
> +	 * (e.g. ICSSG_EMAC_PORT_FORWARD from emac_adjust_link) reach
> +	 * the PRU firmware instead of timing out with stale R30 values.
> +	 */

[Severity: Medium]
Does this close the R30 timeout window completely?

prueth_emac_restart() stops and restarts the firmware without calling
phy_stop() and without holding phydev->lock. That means phylib can still
call emac_adjust_link() on its own while the PRU is halted:

prueth_emac_restart()
    prueth_emac_common_stop()       <- PRU halted
    prueth_emac_common_start()
        icssg_config()
            emac_r30_cmd_init()
        prueth_emac_start()

Suppose the link changes (autoneg completes, or the link flaps) after
prueth_emac_common_stop(), or between emac_r30_cmd_init() and
prueth_emac_start(). The phylib state machine then calls
emac_adjust_link()->icssg_set_port_state(). That writes the R30 command
words to a halted PRU, times out in read_poll_timeout(), and leaves the
words in place. This looks like the same failure the commit message
describes.

There is also a data race on the link fields. icssg_config() writes
emac->speed and emac->duplex, and this loop writes emac->link = 0, all
without phydev->lock. The phylib callback updates the same fields while
holding phydev->lock.

Should the restart path quiesce phylib, or hold phydev->lock, across the
stop/start window?

> +	for (slice = 0; slice < PRUETH_NUM_MACS; slice++) {
> +		emac = prueth->emac[slice];
> +		if (!emac)
> +			continue;
>  
> -		/* Reset link state to force reconfiguration in
> -		 * emac_adjust_link(). Without this, if the link was already up
> -		 * before restart, emac_adjust_link() won't detect any state
> -		 * change and will skip critical configuration like writing
> -		 * speed to firmware.
> -		 */
>  		emac->link = 0;
>  
>  		mutex_lock(&emac->ndev->phydev->lock);

[Severity: High]
The loop only checks emac. Can emac->ndev->phydev still be NULL at this
point?

prueth_probe() fills both prueth->emac[] slots and then does:

prueth_probe()
    register_netdev(prueth->emac[PRUETH_MAC0]->ndev);
    emac_phy_connect(prueth->emac[PRUETH_MAC0]);
    register_netdev(prueth->emac[PRUETH_MAC1]->ndev);
    emac_phy_connect(prueth->emac[PRUETH_MAC1]);

Userspace can open eth0 as soon as it is registered, for example via udev
or a network manager. emac_ndo_open() sees emacs_initialized == 0 and
calls prueth_emac_common_start(). This loop then reaches slice 1, where
emac[1] is non-NULL but its ndev->phydev has not been set yet. So
mutex_lock(&emac->ndev->phydev->lock) dereferences NULL.

prueth_remove() has a similar window:

    phy_disconnect(prueth->emac[i]->ndev->phydev);
    prueth->emac[i]->ndev->phydev = NULL;
    unregister_netdev(prueth->registered_netdevs[i]);

emac[0] stays non-NULL here. If eth1 is opened during this window, the
loop walks slice 0 with a NULL phydev.

emac_ndo_stop() already checks if (ndev->phydev) before phy_stop(). The
dereference itself existed before this patch. However, the commit message
describes this exact scenario, "the first port opens before the second is
initialized", and that scenario still crashes.

Should this loop also skip slices that have no phydev?

[Severity: High]
This is a pre-existing issue, not one introduced by this patch. On link
down, the emac_adjust_link() call made from this loop (and from the phylib
state machine) reaches prueth_cleanup_tx_ts():

    } else {
        netif_tx_stop_all_queues(ndev);
        prueth_cleanup_tx_ts(emac);
    }

prueth_cleanup_tx_ts() frees every non-NULL emac->tx_ts_skb[] slot. No
lock synchronizes it with the TX path or the tx_ts IRQ thread. Also,
netif_tx_stop_all_queues() does not wait for an icssg_ndo_start_xmit()
that is already running on another CPU.

Can this end up freeing an ERR_PTR? The xmit path reserves a slot in
prueth_tx_ts_cookie_get() first:

    emac->tx_ts_skb[i] = ERR_PTR(-EBUSY); /* reserve slot */

and stores the skb in icssg_ndo_start_xmit() only later:

    emac->tx_ts_skb[tx_ts_cookie] = skb_get(skb);

If cleanup runs between those two stores, it calls
dev_kfree_skb_any(ERR_PTR(-EBUSY)).

The xmit error paths also free the slot and set it to NULL. And
tx_ts_work() does:

    skb = emac->tx_ts_skb[tsr.cookie];
    emac->tx_ts_skb[tsr.cookie] = NULL;	/* free slot */

and uses and frees skb later on. Could a concurrent
prueth_cleanup_tx_ts() free the same skb in between, causing a double
free or a use-after-free?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261027131732.3411403-1-m-malladi%40ti.com
