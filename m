Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793453910;
	b=GyDNyrayRgEgVXvzP83ciCPNhFIErItsumPmucAiBeYs3uUIg3vUCKGpxrlpJNYf1qAm
	 QxkQbtZd7cTMx3g3DMe5f22+u9jXwzeiL962/SlZZEHthF8JG/ZGyPw79SOtmjcy+f/0S
	 lWmES20TZvOsYOqjssVtQNNmLyG3U/kQos3F2qKeXtP3xlGSvXH+aE2rJK1VoasEnLQUq
	 YEOUZ3txhhvMI468WsgHBfDkzXZvDOtjjqnuj1pmSS7DkB0Q8RDPLqKLYsjeUdXe4kpy3
	 CP09CM19QSyXBArRrfQmrNk0Y45S2yL5lory3acssrzaO+NST4f1tNA5Q3ROGJn4vow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793453910;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=uKK4uO3b6cgYY3NW2OhlkI3Td0Hnhdg+Pwl5MaEe4Kg=;
	b=p/jt8YfDLF3/HvKbMWifSbZshTDMzFKCHqSXe8QFoGjZggSvEPzNZ9x6WNrhA957trpf
	 182pzf/XPtT4ZNmd0lIYWfriR9NCf1TGDYeNDsMAAbmH8vFDl9CFOxj3uKLepJhVl7b8e
	 G8tFP1tyJMwLZqL6UrO2IDmmXGCGHvm0pFt5Eqo0Bnki+wJjBnoPXQ/Yys5PJjLiLVV+D
	 HOCL+7ezPDFSL9GZDg7ZfWEEgBUPFx+symjAZYzhMLjXack5tcdr9YhltKdq+/S82zCf+
	 s2ki0SvBPHajjfd8vu0IUpJoVhzwkzADI2w2C1OGxSnHNRp8QRcIpfmlJR+26QnmG0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Uj+FP/tG";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6A2606A31A;
	Sat, 31 Oct 2026 13:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uj+FP/tG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A2F1F00919;
	Sat, 31 Oct 2026 13:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793453909;
	bh=uKK4uO3b6cgYY3NW2OhlkI3Td0Hnhdg+Pwl5MaEe4Kg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Uj+FP/tG3JTKdiLE9W6nVDmqAX64hVrmgW8gXFu4mM/KOkV6Db4nDv9qB+IjhXMJU
	 rZxr7XCj1kppWaX7Hn4kXzoIR8b/IBAsVHICIdre0O1/m36m3Yfb3Rio/1UxLweU4l
	 ZsdP7180BAZwhDOlkdq6EFBE7GMLrHcwCf6cF5YfkypS9QO2T6/8F4fScmWASJoMoj
	 CWAUE+F2PiP/i1q+vbqEF9lsXb2IqBjO1r5ljqVDmZXyBi7AAYW5enLpSb62CGJEfc
	 54u9L3kNawXeLdNnAcXakc0TYjGokCGvUb2NWvTfNv57b5gopurehENS6TMGRrThvG
	 lAKEK4Sk2GXEg==
Subject: Re: [PATCH net v2 1/2] net: ti: icssg-prueth: Fix bridge port_vlan
 and flooding state
From: netdev-bot+sashiko@kernel.org
To: m-malladi@ti.com
Cc: haokexin@gmail.com, jacob.e.keller@intel.com, pabeni@redhat.com,
 kuba@kernel.org, edumazet@kernel.org, davem@davemloft.net,
 andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com, vigneshr@ti.com,
 danishanwar@ti.com
Date: Sat, 31 Oct 2026 13:38:28 +0000
Message-ID: <179345390863.3131.11658341210139721104@kernel.org>
In-Reply-To: <20261027131732.3411403-2-m-malladi@ti.com>
References: <20261027131732.3411403-2-m-malladi@ti.com>
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

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The flooding restore misses the restart path the commit message
  is about.
- [High] At this commit, icssg_enable_fw_offload() has no NULL check on
  `emac = prueth->emac[mac]` (line 215).
- [Medium] The new flooding flags are written without any synchronization
  against the restore.
- [Low] Concern: the `!prueth->is_switch_mode` guard in
  icssg_enable_fw_offload() also covers HSR/PRP offload mode, so the…
- [Low] The commit fixes two user-visible bugs but has no Fixes: tag, and
  it bundles two unrelated fixes in one patch.
- [Low] The patch treats switch-mode flooding inconsistently.
- [Low] Concern: mc_flooding_enabled is updated only by
  emac_ndo_set_rx_mode_work(), while…

--

net: ti: icssg-prueth: Fix bridge port_vlan and flooding state

This patch sets port_vlan on both emacs when the driver enters switch
mode. It also records the UC/MC flooding state that IFF_PROMISC and
IFF_ALLMULTI set up in emac_ndo_set_rx_mode_work(). The recorded state
is reapplied from icssg_enable_fw_offload() after a firmware restart
when the driver is not in switch mode.

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index 591be5c8056b4..746afd5d00c9e 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -241,6 +241,16 @@ static void icssg_enable_fw_offload(struct prueth *prueth)
>  					icssg_set_port_state(emac, ICSSG_EMAC_PORT_VLAN_AWARE_ENABLE);
>  			}
>  		}
> +
> +		/* Re-apply flooding state cleared by firmware restart.
> +		 * Not needed in switch mode; FDB handles forwarding there.
> +		 */

[Severity: Low]
This isn't a bug, but does this comment match the rest of the driver?

It says flooding is not needed in switch mode. However,
emac_ndo_set_rx_mode_work() has no mode check, so in switch mode it
still enables UC/MC flooding and sets the tracked flags.
prueth_switchdev_attr_br_flags_set() also programs
ICSSG_EMAC_PORT_MC_FLOODING_ENABLE/DISABLE from BR_MCAST_FLOOD, and
that flag only applies while the port is bridged.

As a result, right after icssg_change_mode() enters switch mode, the
firmware has flooding off while uc/mc_flooding_enabled still say on. A
later promiscuity change then turns flooding back on.

Should the comment or the switch-mode handling be changed so the two
agree?

> +		if (!prueth->is_switch_mode && netif_running(emac->ndev)) {

[Severity: High]
Can this dereference a NULL emac in the single-port configuration?

At this commit, icssg_enable_fw_offload() does not check for NULL after:

	emac = prueth->emac[mac];

Before this patch, nothing in the loop body touched emac in plain EMAC
mode. The new block evaluates netif_running(emac->ndev) whenever
is_switch_mode is false.

prueth_probe() only sets up netdevs for DT nodes that exist (the
"single EMAC mode" case), so one prueth->emac[] slot stays NULL. The
first open of the remaining port would then go:

emac_ndo_open()
  icssg_enable_fw_offload()
    netif_running(emac->ndev)    <- emac == NULL

The next patch in the series ("net: ti: icssg-prueth: Fix R30 command
timing and NULL emac dereference") adds "if (!emac) continue;". Even so,
this commit on its own breaks bisection on single-port boards. Could
the NULL check be moved into this patch?

> +			if (emac->uc_flooding_enabled)
> +				icssg_set_port_state(emac, ICSSG_EMAC_PORT_UC_FLOODING_ENABLE);
> +			if (emac->mc_flooding_enabled)
> +				icssg_set_port_state(emac, ICSSG_EMAC_PORT_MC_FLOODING_ENABLE);
> +		}

[Severity: High]
Does this restore reach the restart path that the commit message
describes?

icssg_enable_fw_offload() has two callers: emac_ndo_open() on first
open, and icssg_change_mode(). On the bridge-link restart,
icssg_change_mode() runs after is_switch_mode has already been set to
true, so this block is skipped.

The restart that leaves a running, promiscuous port in non-offload
bridge mode is the switch to EMAC transition in
prueth_netdevice_port_unlink(). It calls prueth_emac_restart() directly:

	if (prueth->is_switch_mode) {
		prueth->is_switch_mode = false;
		emac->port_vlan = 0;
		ret = prueth_emac_restart(prueth);
		...
	}

prueth_emac_restart() only reissues the forward state:

	ret = icssg_set_port_state(emac0, ICSSG_EMAC_PORT_FORWARD);
	ret |= icssg_set_port_state(emac1, ICSSG_EMAC_PORT_FORWARD);

prueth_hsr_port_unlink() also calls prueth_emac_restart() directly.

For example, put eth1 and eth2 in br0 and then run
"ip link set eth2 nomaster":

1. del_nbp()->br_manage_promisc() runs. br_port_set_promisc() returns
   early for eth1 because eth1 is already promiscuous.

2. prueth_netdevice_port_unlink() reloads the EMAC firmware and returns.

eth1 is still a bridge port with IFF_PROMISC set, and its
uc/mc_flooding_enabled flags are still true. The firmware, however, now
has flooding disabled, and nothing calls ndo_set_rx_mode again.

Wouldn't unicast forwarding through eth1 stay broken?

Could the restore be done in prueth_emac_restart(), or from every
restart path? The "preserved across firmware restarts" comment on the
new fields in struct prueth_emac is also not true for these unlink
paths.

>  	}
>  }
>  
> @@ -1288,14 +1298,21 @@ static void emac_ndo_set_rx_mode_work(struct work_struct *work)
>  	if (promisc) {
>  		icssg_set_port_state(emac, ICSSG_EMAC_PORT_UC_FLOODING_ENABLE);
>  		icssg_set_port_state(emac, ICSSG_EMAC_PORT_MC_FLOODING_ENABLE);
> +		emac->uc_flooding_enabled = true;
> +		emac->mc_flooding_enabled = true;
>  		return;
>  	}

[Severity: Medium]
Can these flag updates race with the restore in
icssg_enable_fw_offload()?

emac_ndo_set_rx_mode_work() runs from schedule_work() without RTNL. It
sends the firmware commands first and stores the flags afterwards. Each
command holds emac->cmd_lock only for itself and can wait up to 10ms.

icssg_change_mode()->prueth_emac_restart()->icssg_enable_fw_offload()
reads the flags under RTNL. Nothing on that path cancels or flushes
rx_mode_work.

hsr_portdev_setup() opens this window when forwarding is not offloaded.
It calls dev_set_promiscuity(dev, 1), which queues rx_mode_work. It then
calls netdev_master_upper_dev_link(), which runs NETDEV_CHANGEUPPER->
prueth_hsr_port_link()->icssg_change_mode().

One possible interleaving:

rx_mode_work                            icssg_change_mode()
icssg_set_port_state(UC_FLOODING_ENABLE)
  (times out while PRUs restart)
                                        icssg_enable_fw_offload()
                                          uc_flooding_enabled false, skip
emac->uc_flooding_enabled = true;

The flags then say flooding is on while the firmware has it off. That
is the state this patch is meant to fix.

The reverse case, where promisc is being cleared, can leave flooding
enabled with IFF_PROMISC clear.

netif_device_detach() in prueth_emac_restart() does not clear
__LINK_STATE_START, so the queued work still passes its netif_running()
check.

>  
>  	if (allmulti) {
>  		icssg_set_port_state(emac, ICSSG_EMAC_PORT_MC_FLOODING_ENABLE);
> +		emac->mc_flooding_enabled = true;
> +		emac->uc_flooding_enabled = false;
>  		return;
>  	}

[ ... ]

> @@ -1919,7 +1936,8 @@ static int prueth_netdevice_port_link(struct net_device *ndev,
>  		    prueth->br_members & BIT(PRUETH_PORT_MII1)) {
>  			prueth->is_switch_mode = true;
>  			prueth->default_vlan = PRUETH_DFLT_VLAN_SW;
> -			emac->port_vlan = prueth->default_vlan;
> +			prueth->emac[PRUETH_MAC0]->port_vlan = prueth->default_vlan;
> +			prueth->emac[PRUETH_MAC1]->port_vlan = prueth->default_vlan;
>  			icssg_change_mode(prueth);
>  		}
>  	}

[Severity: Low]
This patch fixes two separate user-visible bugs, but it has no Fixes:
tags. Could it be split into two patches, each with its own Fixes: tag?

The single-emac port_vlan assignment appears to come from commit
abd5576b9c57 ("net: ti: icssg-prueth: Add support for ICSSG switch
firmware").

The flooding loss on restart comes from the restart-based mode change
in icssg_change_mode()/prueth_emac_restart(). That was added by commit
95540ad6747c ("net: ti: icssg-prueth: Add support for HSR frame forward
offload").

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261027131732.3411403-1-m-malladi%40ti.com
