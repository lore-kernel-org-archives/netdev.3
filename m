Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925D952D2AF;
	Tue,  8 Sep 2026 19:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788894593; cv=none; b=ZYXztyOcgboVV+UgAAUNNdVMQCoMJ0IQqJs9uSiALQBrQs9bU++nrpoispArtc2eEetby0iLU1MhSqSlUemgK2yrPW8w1w3jtxNMCL2WpN2NM9XRtl0hAbsIZajLlwm96rxwuDPwPd7hxxBW5A8IeSTo8fWrbYvzYekzmj5AK4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788894593; c=relaxed/simple;
	bh=8Gn9sTRp+r3Vs40mCZvrdgMX49pZc2jZNUAyIsAwcYQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nZMqLsK9LUX7W9J4fYHLvVszcXCNsbyv8hp6bOCMflvwaRmBTNSnF5qMEtwD5jBJeICayNnzSOKya0ttMcsz3N56HuiSUunFoCOuWBJxI97sgtvjvb8X/yPzCRHnA9/7B/8AUWhnghUjwgulB1MIJ3/1IKllkB8bOZFZfya/hUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BD4U0N/u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BD4U0N/u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932E21F00A3A;
	Tue,  8 Sep 2026 19:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788894592;
	bh=ShZPixbch8fWqtBbcpGK5jzoXmS03HTd5PFnoP1cYPA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BD4U0N/uarbMTMPFa8xI9lqJv/ktrxP68NKaJzqah8FnaU5kQjAyOXHzNYED25Qi7
	 wSqtqKEG0GsPR37Wau8hJA3GqdO+4akt2BwjNxanCRlo4L52ZwgeNO7CXiZSe5l8XD
	 VGFloHo8tIxHaPj6A9kOyBQ021CfkOLe7R/kAmt+wkhLgG0Y1KE0cq0ufs6QuRQPqu
	 KAzJkfj7x+1OKRcdegZxRVs7XfreXeTs9GbOBrJO7Vx6WNEwMQhkjmUoAxtwYX836L
	 YoCpPbA2hrYKTCGaO0qVRpp3cBaNW7U+k4ZYM614QYb5akUf8jYateB02pccHNnO/F
	 YJJDzi2ijQhcA==
Subject: Re: [PATCH net v3] bonding: fix slave_cnt leak on XDP error paths
From: netdev-bot+sashiko@kernel.org
To: hangbin.liu@linux.dev
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, daniel@iogearbox.net,
 joamaki@gmail.com, razor@blackwall.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, liuhangbin@kylinos.cn
Date: Tue, 08 Sep 2026 19:09:51 +0000
Message-ID: <178889459114.219967.6984751596437332187@kernel.org>
In-Reply-To: <20260907-bond_slave_cnt-v3-1-57df3b3cf2cb@kylinos.cn>
References: <20260907-bond_slave_cnt-v3-1-57df3b3cf2cb@kylinos.cn>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 1 · High: 0 · Medium: 0 (1) · Low: 0

- [Critical] Newly introduced slab out-of-bounds write in
  bond_update_slave_arr(): moving `WRITE_ONCE(bond->slave_cnt,…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the XDP
  error paths the patch touches are still incompletely unwound: the…

--

bonding: fix slave_cnt leak on XDP error paths

This moves the WRITE_ONCE(bond->slave_cnt, bond->slave_cnt + 1) in
bond_enslave() from just above netdev_compute_master_upper_features() down
to after the XDP setup block, so that the three XDP failure exits which
"goto err_sysfs_del" no longer leave slave_cnt incremented.  The increment
is placed just before the bond_update_slave_arr() call.

Link to v2: https://lore.kernel.org/r/20260903-bond_slave_cnt-v2-1-02e27304ca36@kylinos.cn
Link to v1: https://lore.kernel.org/r/20260902-bond_slave_cnt-v1-1-36e95bf4a6ff@kylinos.cn

> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index a9bff7663eeca..1514a8ba0888d 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -2284,7 +2284,6 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>  		}
>  	}
>  
> -	WRITE_ONCE(bond->slave_cnt, bond->slave_cnt + 1);
       ^^^^

[Severity: Critical]
Can removing the increment from here overflow all_slaves->arr[] in
bond_update_slave_arr()?

By the time control reaches this point, bond_master_upper_dev_link() has
already linked the new slave into bond->dev->adj_list.lower, so
bond_for_each_slave() now walks N+1 slaves while bond->slave_cnt is still N.
bond_update_slave_arr() sizes its arrays from slave_cnt and then fills them
with an unchecked store:

drivers/net/bonding/bond_main.c:bond_update_slave_arr() {
	...
	usable_slaves = kzalloc_flex(*usable_slaves, arr, bond->slave_cnt);
	all_slaves = kzalloc_flex(*all_slaves, arr, bond->slave_cnt);
	...
		all_slaves->arr[all_slaves->count++] = slave;
	...
}

The window that now runs with the stale count includes
bond_select_active_slave(), which is a few lines below:

	if (bond_uses_primary(bond)) {
		block_netpoll_tx();
		bond_select_active_slave(bond);
		unblock_netpoll_tx();
	}

and that reaches bond_update_slave_arr() for balance-tlb/balance-alb:

bond_select_active_slave()
  bond_find_best_slave()        /* returns a slave in BOND_LINK_BACK */
  bond_change_active_slave()    /* BOND_LINK_BACK branch */
    bond_alb_handle_link_change()
      if (bond_is_nondyn_tlb(bond))
              bond_update_slave_arr(bond, NULL);

With one pre-existing slave, slave_cnt == 1 while the lower list holds two
entries, so arr[1] is stored past the end of the allocation, and count is
left at 2 so the RCU TX fast path then dereferences a garbage slave pointer.

The configuration needed looks like supported options only, and no XDP
program is required:

	ip link add bond0 type bond mode balance-tlb miimon 100 \
		updelay 10000 tlb_dynamic_lb 0
	# enslave eth0 (carrier up) so it enters BOND_LINK_BACK
	# wait one miimon tick so slave->delay < params.updelay
	# enslave eth1

A second entry point exists for 8023AD/XOR/TLB/ALB if a slave driver's
ndo_bpf delivers NETDEV_UP/NETDEV_CHANGE/NETDEV_DOWN synchronously during
dev_xdp_propagate(), since bond_slave_netdev_event() also calls
bond_update_slave_arr() for bond_mode_can_use_xmit_hash() modes.

For comparison, the release side keeps the invariant in the safe direction:
__bond_release_one() rebuilds the arrays before decrementing slave_cnt, so
slave_cnt is never smaller than the number of linked slaves there.  Would it
be safer to keep the increment where it was and instead add the matching
decrement to the XDP failure paths (or add a dedicated error label that
undoes it)?

>  	netdev_compute_master_upper_features(bond->dev, true);
>  	bond_set_carrier(bond);
>  
> @@ -2332,6 +2331,9 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>  			bpf_prog_inc(bond->xdp_prog);
>  	}
       ^^^^

[Severity: Medium]
This isn't a bug introduced by this patch, but the XDP error exits being
adjusted here are still only partially unwound.

The three "goto err_sysfs_del" cases in this block ("Slave does not support
XDP", "Slave has XDP program loaded" and the dev_xdp_propagate() failure)
enter a chain of labels:

	err_sysfs_del -> err_upper_unlink -> err_unregister -> err_detach ->
	err_close -> err_restore_mac -> err_restore_mtu -> err_free ->
	err_undo_flags

None of those labels calls dev_set_promiscuity(slave_dev, -1),
dev_set_allmulti(slave_dev, -1), bond_hw_addr_flush() or
bond_slave_ns_maddrs_del().  Those undo steps exist only in
__bond_release_one():

drivers/net/bonding/bond_main.c:__bond_release_one() {
	...
		if (old_flags & IFF_ALLMULTI)
			dev_set_allmulti(slave_dev, -1);

		if (old_flags & IFF_UP)
			bond_hw_addr_flush(bond_dev, slave_dev);
	...
}

which a failed enslave never reaches.  So when the bond is IFF_PROMISC,
IFF_ALLMULTI or IFF_UP and has an xdp_prog attached, does a failed enslave
leave the candidate device with a leaked promiscuity/allmulti refcount, the
bond's synced mc/uc addresses (plus the lacpdu multicast address in 8023AD
mode) still installed, and the NS-target multicast addresses added by
bond_slave_ns_maddrs_add() still present?  Since the device is no longer a
slave, is there any path left that can drop those refcounts?

>  
> +	/* Increase the slave count before rebuilding the slave arrays. */
> +	WRITE_ONCE(bond->slave_cnt, bond->slave_cnt + 1);
> +
>  	/* broadcast mode uses the all_slaves to loop through slaves. */
>  	if (bond_mode_can_use_xmit_hash(bond) ||
>  	    BOND_MODE(bond) == BOND_MODE_BROADCAST)

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907-bond_slave_cnt-v3-1-57df3b3cf2cb%40kylinos.cn
