Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792647920;
	b=qnedYSQdjLf1/iePyIAoL4SHd/nVO8P1m0wC82XAlkgc7HiDOlhxvFwWvZOIvSC7pqX6
	 gATC2l3wL5Mb5LvW3sYf0SEcCOS6c57E+TD0yEGhBLIgcIMaOefIYzYAab45nALDKisOo
	 aWtptc/vjzY4YkVsIfMWs0gUO8Q4jrPFamhv6wTiK4urka/sq+i2VBZyo1b68hyu5V4yu
	 NUjzsdK0g/41ay8M0j3mJnUpjAq90RYZ16kiPgBobhzi2a+z8gq33kzWtju1Q6iuE92lZ
	 fys2fxRKlQbKwx5y+vaPTU+STpNYQ3aM/rfcZ5V8q4JhHkXVCjo0Bmwmucv7dzPs1pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792647920;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=XO9HFPUF4+hpZOrjYKiB3h14ahCEy7YjYReUr1uq2so=;
	b=N4+QTG309Yi/phv5OTuK+1t+vf47feFMsQ/IG0WeWqcrKb47fZD8eEWra+ZGjCKppTD/
	 MfMkHianFZQGksNo9JJBuHbGaxdzPCAMb4zxuD0ab98zl6xSZNDi7O9faI52kDb2DUTtu
	 DVc/nxjvOdTTgfTxrU/PZRCkmSDXr+7vvLo/f6QbA2/FzmTUi30aBFIvf7JJcQIrNJead
	 yEQyPcnP4gi0w0HMMfaASxogUCO3UftjShwhf02C8v5M0665XDITxNPKX8noupf6GLAXU
	 qAEfNYXsf4l1drNMM1ZOjNwUSc/5OaIRkAM23R8nofohKzbBrcgNvxETFy/nDBLzsjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YjOiGxfB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF7D606A31A;
	Thu, 22 Oct 2026 05:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YjOiGxfB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24221F000C1;
	Thu, 22 Oct 2026 05:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792647919;
	bh=XO9HFPUF4+hpZOrjYKiB3h14ahCEy7YjYReUr1uq2so=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YjOiGxfBrLc+EuesZdH/kYrdpm0LsyvRh8jK6IdJAGomoBixBj+vI+mKdPV3PBcyI
	 rHdtbbpVNHLJLdGxpX/cNQuvvIT8rnpToePXfU0e7XEbHw8bB88qmoBjytNXiRVaAf
	 iX19BPLz5kGlmPTI7ySNbqpPs9TmnZugTMiAzfOd1hGr8K7SBmTKNUPwYhUXy417bu
	 hvqzq5TNxslSRxXj5/AWQl7YnunDk8XkcRuJFCmhEoRHAocXUMHiTJdLfzdAYveXfg
	 Ror4azhC1trx9/qi0UW9aT+bRAQNU9JNI9Mnvvc4/C22V5ZE7HiGYdH+sj8fslS1fp
	 njnKY6x/RcJVg==
Subject: Re: [PATCH v1] qlcnic: Protect loopback filter hashes
From: netdev-bot+sashiko@kernel.org
To: 18983559317@163.com
Cc: shshaikh@marvell.com, manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 22 Oct 2026 05:45:18 +0000
Message-ID: <179264791828.3135.11094725561677433933@kernel.org>
In-Reply-To: <20261020024417.517941-1-18983559317@163.com>
References: <20261020024417.517941-1-18983559317@163.com>
X-sashiko-severity: Critical
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 1 · High: 1 · Medium: 1 (3) · Low: 0 (2)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] The patch leaves mac_learn_lock held on one return path in
  qlcnic_send_filter() (drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c).
- [High] On 82xx adapters the patch makes an AB-BA deadlock between
  mac_learn_lock and the TX queue 0 lock much easier to hit.
- [Medium] qlcnic: memory leak of struct qlcnic_filter in loopback filter
  removal

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but all three
  periodic callers of qlcnic_prune_lb_filters() check only…
- [Medium] This problem wasn't introduced by this patch, but two places
  unhash a struct qlcnic_filter and decrement its counter without…
- [Medium] This problem wasn't introduced by this patch, but
  qlcnic_prune_lb_filters() and qlcnic_delete_lb_filters() ignore the…
- [Low] This problem wasn't introduced by this patch, but in the loopback
  branch of qlcnic_add_lb_filter() the capacity check `if…
- [Low] This problem wasn't introduced by this patch, but no teardown
  path frees rx_fhash nodes.

--

qlcnic: Protect loopback filter hashes

This commit widens mac_learn_lock and rx_mac_learn_lock so that each one
covers a whole hash-table operation on the learned MAC filter tables.
Aging and teardown now hold the lock across the firmware delete, the
unhash and the kfree(). The TX and loopback RX paths hold it across the
count check, the lookup, the timestamp update and the insertion.

> diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c
> index e58176badc1f..c7309ecf6023 100644
> --- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c
> +++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c
> @@ -635,6 +635,7 @@ void qlcnic_prune_lb_filters(struct qlcnic_adapter *adapter)
>  	unsigned long expires;
>  	u8 cmd;
>  
> +	spin_lock_bh(&adapter->mac_learn_lock);
>  	for (i = 0; i < adapter->fhash.fbucket_size; i++) {
>  		head = &(adapter->fhash.fhead[i]);
>  		hlist_for_each_entry_safe(tmp_fil, n, head, fnode) {
> @@ -646,14 +647,14 @@ void qlcnic_prune_lb_filters(struct qlcnic_adapter *adapter)
>  							  tmp_fil->faddr,
>  							  tmp_fil->vlan_id,
>  							  cmd);
> -				spin_lock_bh(&adapter->mac_learn_lock);

[Severity: High]

mac_learn_lock is now held across qlcnic_sre_macaddr_change(). Can this
deadlock against the transmit path on 82xx adapters?

On 82xx, change_macvlan is qlcnic_82xx_sre_macaddr_change(). That calls
qlcnic_send_cmd_descs(), which takes the TX queue 0 lock:

qlcnic_prune_lb_filters()
  spin_lock_bh(&adapter->mac_learn_lock)
  qlcnic_sre_macaddr_change()
    qlcnic_82xx_sre_macaddr_change()
      qlcnic_send_cmd_descs()
        tx_ring = &adapter->tx_ring[0];
        __netif_tx_lock_bh(tx_ring->txq);

qlcnic is not LLTX, so qlcnic_xmit_frame() runs with the txq lock held.
qlcnic_send_filter() now takes mac_learn_lock on every transmitted packet:

CPU0                                CPU1
HARD_TX_LOCK(txq0)                  qlcnic_fw_poll_work()
qlcnic_xmit_frame()                   qlcnic_prune_lb_filters()
  qlcnic_send_filter()                  spin_lock_bh(&mac_learn_lock)
    spin_lock(&mac_learn_lock)          qlcnic_send_cmd_descs()
                                          __netif_tx_lock_bh(txq0)

The same inversion already existed between the non-loopback branch of
qlcnic_add_lb_filter() and the TX insert path. This patch adds a periodic
holder that issues firmware commands under the lock. It also widens the TX
side from insert-only to every packet.

Given that, does this part of the commit message hold up?

  "The existing firmware-command path is already called under these
  spinlocks, so no new lock class or lock ordering is introduced."

Could the expired entries be moved to a private list under the lock, with
the firmware deletes and kfree() done after the lock is dropped? An
RCU-protected lookup on the TX side would be another option.

qlcnic_delete_lb_filters() has the same mac_learn_lock -> txq0 nesting. In
__qlcnic_down() the earlier netif_tx_disable() makes this unlikely, but
lockdep will still record the order.

>  				adapter->fhash.fnum--;
>  				hlist_del(&tmp_fil->fnode);
> -				spin_unlock_bh(&adapter->mac_learn_lock);
>  				kfree(tmp_fil);

[Severity: Medium]

This isn't a bug introduced by this patch, but the return value of
qlcnic_sre_macaddr_change() is ignored here and in
qlcnic_delete_lb_filters(). The software record is always unhashed and
freed, and fhash.fnum is always decremented.

On 82xx, qlcnic_send_cmd_descs() can return before anything is posted:

	if (!test_bit(__QLCNIC_FW_ATTACHED, &adapter->state))
		return -EIO;
	...
		} else {
			adapter->stats.xmit_off++;
			__netif_tx_unlock_bh(tx_ring->txq);
			return -EBUSY;
		}

The 83xx/VF mailbox path can also fail with -ENOMEM or -EIO.

In those cases, does the MAC/VLAN stay programmed in the adapter's L2
filter table after the driver has forgotten it? The driver would then go
on learning more entries up to fmax.

The non-loopback branch of qlcnic_add_lb_filter() unhashes only on success
(if (!ret)).

>  			}
>  		}
>  	}
> +	spin_unlock_bh(&adapter->mac_learn_lock);
> +	spin_lock_bh(&adapter->rx_mac_learn_lock);
>  	for (i = 0; i < adapter->rx_fhash.fbucket_size; i++) {
>  		head = &(adapter->rx_fhash.fhead[i]);

[Severity: Medium]

This is a pre-existing issue, but does this rx_fhash aging loop ever run
when only RX loopback records exist? All three periodic callers,
qlcnic_fw_poll_work(), qlcnic_83xx_periodic_tasks() and
qlcnic_sriov_vf_periodic_tasks(), skip the whole function based on the TX
table count:

	if (adapter->fhash.fnum)
		qlcnic_prune_lb_filters(adapter);

Loopback RX can fill rx_fhash while fhash stays empty. One example is a
host that only transmits from adapter->mac_addr, which qlcnic_send_filter()
skips.

In that state stale RX records are never aged. Once rx_fhash reaches fmax,
would every newly seen loopback MAC be rejected indefinitely?

[ ... ]

> @@ -679,6 +679,7 @@ void qlcnic_delete_lb_filters(struct qlcnic_adapter *adapter)
>  	int i;
>  	u8 cmd;
>  
> +	spin_lock_bh(&adapter->mac_learn_lock);
>  	for (i = 0; i < adapter->fhash.fbucket_size; i++) {
>  		head = &(adapter->fhash.fhead[i]);

[Severity: Low]

This is a pre-existing issue, but this teardown only walks adapter->fhash.
Are the qlcnic_filter nodes in rx_fhash ever freed other than by aging?

__qlcnic_down() calls this only when fhash.fnum is non-zero.
qlcnic_remove()->qlcnic_free_lb_filters_mem() then frees the bucket arrays
without walking them:

	if (adapter->rx_fhash.fmax)
		kfree(adapter->rx_fhash.fhead);

Any nodes still linked in rx_fhash, or in fhash if this function was
skipped, would be leaked on device removal.

[ ... ]

> diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
> index 761ef3bc8193..2aefb6e9a2eb 100644
> --- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
> +++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
> @@ -207,27 +207,33 @@ static void qlcnic_add_lb_filter(struct qlcnic_adapter *adapter,
>  		 (adapter->fhash.fbucket_size - 1);
>  
>  	if (loopback_pkt) {
> -		if (adapter->rx_fhash.fnum >= adapter->rx_fhash.fmax)
> -			return;
>  
>  		head = &(adapter->rx_fhash.fhead[hindex]);
>  
> +		spin_lock(&adapter->rx_mac_learn_lock);
> +		if (adapter->rx_fhash.fnum >= adapter->rx_fhash.fmax) {
> +			spin_unlock(&adapter->rx_mac_learn_lock);
> +			return;
> +		}
> +
>  		tmp_fil = qlcnic_find_mac_filter(head, &src_addr, vlan_id);

[Severity: Low]

This isn't a bug introduced by this patch, but the capacity check still
runs before qlcnic_find_mac_filter(). When rx_fhash is full, a loopback
packet from a MAC already in the table returns without refreshing
tmp_fil->ftime.

Could qlcnic_prune_lb_filters() then age out those active RX records after
QLCNIC_FILTER_AGE, even though loopback traffic continues? Until the
record is re-added, a non-loopback packet from that MAC would miss the
qlcnic_delete_rx_list_mac() handling.

Should the fmax check reject only new insertions, after the lookup fails?

[ ... ]

>  		hlist_add_head(&(fil->fnode), head);
>  		adapter->rx_fhash.fnum++;
>  		spin_unlock(&adapter->rx_mac_learn_lock);

[Severity: Medium]
This is a pre-existing issue, but are the qlcnic_filter nodes leaked
when they are unhashed outside the aging and teardown paths?

In the non-loopback branch of qlcnic_add_lb_filter(), a match in
adapter->fhash is removed like this:

	if (!ret) {
		hlist_del(&tmp_fil->fnode);
		adapter->fhash.fnum--;
	}

A match in adapter->rx_fhash goes through qlcnic_delete_rx_list_mac(),
which does the same thing with fil and adapter->rx_fhash.fnum. Neither
site calls kfree(), and the pointer is dropped on return. These
objects come from GFP_ATOMIC allocations in qlcnic_send_filter() and
the loopback branch of qlcnic_add_lb_filter(). Both
qlcnic_prune_lb_filters() and qlcnic_delete_lb_filters() pair
hlist_del() with kfree().

Because fnum is decremented, fmax does not bound this. One filter
would leak per MAC move event, for example a VM migration. Ordinary RX
traffic can reach this whenever drv_mac_learn or rx_mac_learn is
enabled.

Teardown has a similar gap. __qlcnic_down() calls
qlcnic_delete_lb_filters() only when fhash.fnum is non-zero, and that
function drains adapter->fhash but never walks adapter->rx_fhash. On
removal, qlcnic_free_lb_filters_mem() then frees the bucket arrays
without walking them:

	if (adapter->rx_fhash.fmax)
		kfree(adapter->rx_fhash.fhead);

Any nodes still linked in rx_fhash would be leaked at that point. The
same applies to fhash if the drain was skipped.

This patch already reworks the locking in these paths. Could the
missing kfree() calls, and an rx_fhash drain under rx_mac_learn_lock,
be added here or in a follow-up?

[Severity: Medium]

This is a pre-existing issue, but is tmp_fil leaked after the
non-loopback branch just below unhashes it?

qlcnic_add_lb_filter() {
	...
			if (!ret) {
				hlist_del(&tmp_fil->fnode);
				adapter->fhash.fnum--;
			}
	...
}

qlcnic_delete_rx_list_mac() does the same with fil:

	if (!ret) {
		hlist_del(&fil->fnode);
		adapter->rx_fhash.fnum--;
	}

Neither site calls kfree(), and the pointer is dropped afterwards.
qlcnic_prune_lb_filters() and qlcnic_delete_lb_filters() both pair
hlist_del() with kfree().

Because fnum is decremented, fmax does not bound this. One filter would
leak per MAC move event, for example a VM migration.

[ ... ]

> @@ -330,6 +336,7 @@ static void qlcnic_send_filter(struct qlcnic_adapter *adapter,
>  	hindex = hval & (adapter->fhash.fbucket_size - 1);
>  	head = &(adapter->fhash.fhead[hindex]);
>  
> +	spin_lock(&adapter->mac_learn_lock);
>  	hlist_for_each_entry_safe(tmp_fil, n, head, fnode) {
>  		if (ether_addr_equal(tmp_fil->faddr, (u8 *)&src_addr) &&
>  		    tmp_fil->vlan_id == vlan_id) {
> @@ -337,6 +344,7 @@ static void qlcnic_send_filter(struct qlcnic_adapter *adapter,
>  				qlcnic_change_filter(adapter, &src_addr,
>  						     vlan_id, tx_ring);
>  			tmp_fil->ftime = jiffies;
> +			spin_unlock(&adapter->mac_learn_lock);
>  			return;
>  		}
>  	}

[Severity: Critical]

With spin_lock() now taken before the bucket walk, is mac_learn_lock
released on the table-full path right after this loop? The unchanged code
in qlcnic_send_filter() still returns without an unlock:

	if (unlikely(adapter->fhash.fnum >= adapter->fhash.fmax)) {
		adapter->stats.mac_filter_limit_overrun++;
		return;
	}

Once fhash.fnum reaches fhash.fmax, the next transmitted frame with a new
source MAC/VLAN would return from qlcnic_xmit_frame() with the lock still
held. On 82xx, fmax is QLCNIC_LB_MAX_FILTERS divided by the number of
active PCI functions, so only a few dozen entries.

Would every later user of the lock then spin forever? That covers the next
qlcnic_send_filter() call, the non-loopback branch of
qlcnic_add_lb_filter() in NAPI, qlcnic_prune_lb_filters() from
qlcnic_fw_poll_work(), and qlcnic_delete_lb_filters() from __qlcnic_down().

__qlcnic_set_multi() sets drv_mac_learn automatically in accept-all mode
when FDB learning is off, for example when the port is in a bridge. In a
bridged or VM setup, frames with varied source MACs forwarded out of this
port could fill the table.

The commit message says the transmit path holds the lock "while checking
the count, looking up, updating timestamps, and inserting a new node". The
count-check return looks like it is missing a spin_unlock().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020024417.517941-1-18983559317%40163.com
