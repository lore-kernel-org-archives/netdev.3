Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A294E46C842;
	Thu, 24 Sep 2026 23:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790290916; cv=none; b=rlER/IkCA/T22MBwpxjapcbJVviYb52oXAXqpCjLPGFQSHhSZPnu+WJb7Yl43HDGKE6JxCB9iL6IybN1BacJMv3OI2ukqIEP4dFEMIpeUQ5fPQaCspdMuh8HblpahslmfFSJY31ACK9V7jmCWzQXemUnVcfSrqUrPLVmiuwZFRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790290916; c=relaxed/simple;
	bh=3Sz0x5ZEqJm2nBRSaybVkPQpcxDRPLwMCXFI3/VNyO8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ablmjdUvFaRCyCj42gYnEG8lBprqGtSW1rjAnggLlR7QvCQqGhvdjjuzNMiHvYSk96k6e00Uk8o0ORXJ2yIxl64BRZEed1ne+p+noEwwNFpzK6qQOmEXA8yS3sEi135kyGiR4ZgxVh76DfECf727XbE1O/1j94Q1jlVogu2cMNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJyo2idh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJyo2idh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDEF1F00899;
	Thu, 24 Sep 2026 23:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790290914;
	bh=rPCVBB4hTDvi+POouFjvneMghN8/LLCAorH69tTr9Gg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dJyo2idhEEIXSez9eWL4rWusv5r+vSHI9Qv3xqhE3p3168uipgus/2t2W+7Z4wr1i
	 k0+JubWMCTJZISh1oelcgJRbmEAeCPxy6ikHvPttVSkg8orY1QzjnLSSE7KGy8HVCi
	 E54PMnKb4RormBZAF/ypJMxmMqxwgX0TsG9NS4s39js2buq/x5AXW+z7h4KMOIdHmO
	 9sTc6IY6NHGCEfdPXUjLjCp+hiUN6Whdoe6ZLEfC7c2IYzUSLMmz92CYYmt3eexF9c
	 hkeZrc0nz2wn+wQpHuGobE3Iq/E4URGz8Gs2Of1N+CP0oDkelXCT6jF43oVkX6hkR8
	 30uDVScIZKbyQ==
Subject:
 Re: [PATCH net-next 5/6] enic: manage V2 VF station and administrative MAC
From: netdev-bot+sashiko@kernel.org
To: satishkh@cisco.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sebaddel@cisco.com
Date: Thu, 24 Sep 2026 23:01:53 +0000
Message-ID: <179029091349.2160803.13530371744844163870@kernel.org>
In-Reply-To:
 <20260921-b4-enic-sriov-v2-vf-receive-control-v1-5-67a0a6e08d43@cisco.com>
References:
 <20260921-b4-enic-sriov-v2-vf-receive-control-v1-5-67a0a6e08d43@cisco.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit's central claim "Treat the PF administrative MAC as
  authoritative" is not enforced.
- [Medium] Unaligned memory accesses in ether_addr_equal and
  ether_addr_copy
- [Low] enic_vf_station_sync_reset() only clears ha->sync_cnt for the
  station address; at the target commit enic_open() calls it two…

Pre-existing issues:
- [Low] enic_reset_addr_lists() takes netif_addr_lock_bh() only around
  __dev_uc_unsync()/__dev_mc_unsync() and resets the driver-side mirrors…

--

enic: manage V2 VF station and administrative MAC

This adds V2 VF station-address management over the mailbox (delete plus add
in one compound request), keeps that address out of netdev secondary-unicast
synchronization, and adds a delayed work item plus a post-registration
refresh so the PF administrative MAC drives the VF operational address.

A few questions on the new code below.

> diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
> index 1c60e7a666aeb..16412c29e9321 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_main.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_main.c

[ ... ]

> @@ -1040,8 +1043,10 @@ void enic_reset_addr_lists(struct enic *enic)
>  {
>  	struct net_device *netdev = enic->netdev;
>  
> +	netif_addr_lock_bh(netdev);
>  	__dev_uc_unsync(netdev, NULL);
>  	__dev_mc_unsync(netdev, NULL);
> +	netif_addr_unlock_bh(netdev);
>  
>  	enic->mc_count = 0;
>  	enic->uc_count = 0;

[Severity: Low]
This isn't a bug introduced by this patch, but should the new critical
section in enic_reset_addr_lists() also cover the counter reset?

The address-list lock is dropped before enic->mc_count, enic->uc_count and
enic->flags are cleared, and those same fields are updated from the
ndo_set_rx_mode sync callbacks under netif_addr_lock. The baseline took no
address-list lock here at all, so this is pre-existing, and for V2 VFs at
the end of the series every writer of these counters runs under RTNL
(netif_rx_mode_run() asserts the ops-compat lock before invoking
enic_set_vf_rx_mode), so the reset does not appear reachable concurrently
today. Would extending the lock to the counter reset make the intended
invariant explicit?

> @@ -1065,6 +1070,456 @@ static int enic_set_mac_addr(struct net_device *netdev, char *addr)
>  	return 0;
>  }
>  

[ ... ]

> +static int enic_vf_keep_nonstation_sync(struct net_device *netdev,
> +					const u8 *addr)
> +{
> +	struct enic *enic = netdev_priv(netdev);
> +
> +	if (!ether_addr_equal(addr, enic->vf_station_addr))
> +		return -ENOENT;
> +	if (WARN_ON_ONCE(!enic->uc_count))
> +		return 0;
> +	enic->uc_count--;
> +
> +	return 0;
> +}
> +
> +static void enic_vf_station_sync_reset(struct enic *enic)
> +{
> +	if (!enic->vf_station_addr_valid)
> +		return;
> +
> +	/* The PF keys its MAC ledger by address. A station entry is also the
> +	 * receive filter for that address and must not retain a second core
> +	 * synchronization reference which could later delete the station.
> +	 */
> +	netif_addr_lock_bh(enic->netdev);
> +	__dev_uc_unsync(enic->netdev, enic_vf_keep_nonstation_sync);
> +	netif_addr_unlock_bh(enic->netdev);
> +}

[Severity: Low]
Does enic_vf_station_sync_reset() actually keep the station address out of
core unicast synchronization at this point in the series?

It only clears ha->sync_cnt for the matching entry; the entry itself stays
on netdev->uc. __hw_addr_sync_dev() re-syncs every entry whose sync_cnt is
zero, so the next __dev_uc_sync() recreates the reference, after which a
core unsync can call enic_uc_unsync() -> enic_dev_del_addr() on the station
address while enic->vf_station_addr_valid is still true.

In enic_open() the reset is two statements before enic_set_rx_mode():

	enic_vf_station_addr_set(enic, netdev->dev_addr);
	enic_vf_station_sync_reset(enic);
	vf_mac_added = true;
    }

    enic_set_rx_mode(netdev);

Worth noting this looks harmless by the end of the series: a later patch
("enic: configure V2 VF receive mode over mailbox") gives V2 VFs their own
ops table with only .ndo_set_rx_mode_async, guards the legacy
enic_set_rx_mode() call with if (!enic_is_sriov_vf_v2(enic)), and the async
collector skips any address equal to enic->vf_station_addr in both its add
and delete loops. Is the intent that this helper is only a stopgap until
that patch lands, and if so could it be squashed or the ordering noted?

[ ... ]

> +/* CMD_GET_MAC_ADDR is the PF-owned policy store. Re-read it after REGISTER so
> + * a lost notification cannot leave the VF using stale administrative policy.
> + */
> +static int enic_vf_admin_mac_refresh(struct enic *enic)
> +{

[ ... ]

> +		policy_changed = !ether_addr_equal(previous_policy, policy);
> +		apply_policy = pending || policy_changed ||
> +			!is_valid_ether_addr(enic->netdev->dev_addr);
> +		if (!apply_policy) {
> +			ether_addr_copy(selected, enic->netdev->dev_addr);

[Severity: Medium]
Why does vf_station_addr get __aligned(2) in this same patch while
the new MAC buffers next to it do not?

vf_admin_mac and vf_admin_mac_random_addr are plain u8[ETH_ALEN] and
rely purely on the packing of the preceding bool fields
(vf_station_addr_valid, vf_link_running, ...) to land on an even
offset. Both are passed to ether_addr_copy() and ether_addr_equal()
in enic_vf_admin_mac_notify(), enic_vf_admin_mac_cache_selected(),
enic_vf_admin_mac_work() and enic_vf_admin_mac_refresh(), and on
builds without CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS those helpers
cast to u16 * and do three 16-bit accesses. On architectures that
trap unaligned accesses that is a fault, elsewhere it is a silent
fixup cost. The same applies to the on-stack buffers policy,
selected, previous_policy and random_addr, which sit among bool and
u8 locals in enic_vf_admin_mac_work() and enic_vf_admin_mac_refresh()
and are handed to the same helpers.

The explicit annotation on vf_station_addr suggests the author was
already aware of the requirement, so the omission on the neighbouring
fields looks accidental. Should __aligned(2) be applied consistently
to the new struct fields and the local address buffers, or is the
intent that only vf_station_addr needed it for some reason that is
not obvious from the patch?

[Severity: Medium]
Is the commit message claim "Treat the PF administrative MAC as
authoritative" enforced on this path?

enic_vf_admin_mac_refresh() compares the freshly read policy against the
cached previous_policy, not against the operational netdev->dev_addr. When
the PF policy value has not changed and dev_addr is valid, apply_policy is
false and selected is taken from dev_addr, so an address that disagrees
with the policy is preserved rather than corrected.

Combined with the V2 branch of enic_set_mac_address_dynamic() below, can a
locally installed address survive every later registration and reconnect?

[ ... ]

> @@ -1072,6 +1527,45 @@ static int enic_set_mac_address_dynamic(struct net_device *netdev, void *p)
>  	char *addr = saddr->sa_data;
>  	int err;
>  
> +	if (enic_is_sriov_vf_v2(enic)) {
> +		if (!is_valid_ether_addr(addr))
> +			return -EADDRNOTAVAIL;
> +		if (ether_addr_equal(addr, netdev->dev_addr))
> +			return 0;
> +
> +		if (enic->vf_datapath_open &&
> +		    !READ_ONCE(enic->vf_registered))
> +			return -ENODEV;
> +
> +		/* An internal reset keeps IFF_UP set while its failed reopen leaves
> +		 * the datapath closed. Cache the requested address in that state; the
> +		 * next successful open installs it together with the datapath.
> +		 */
> +		if (!enic->vf_datapath_open) {
> +			err = enic_set_mac_addr(netdev, addr);
> +			if (!err)
> +				enic_vf_admin_mac_cache_selected(enic, addr);
> +			return err;
> +		}

[Severity: Medium]
Should this branch also check the requested address against
enic->vf_admin_mac?

With the datapath closed, the requested address is installed purely locally
via enic_set_mac_addr() with no mailbox request, so no PF policy check
happens at all. A nonzero administrative policy is then silently overridden:

  ip link set <vf> down      (__enic_stop() clears vf_datapath_open)
  ip link set <vf> address <C>

On the next internal reset or reconnect, enic_vf_admin_mac_refresh() sees
previous_policy equal to the fetched policy and a valid dev_addr, so
apply_policy is false and <C> is kept. The following enic_open() then calls
enic_vf_station_addr_replace(netdev->dev_addr) and fails with -EACCES
("Failed to register VF station address"), leaving the interface unable to
come up until the policy address is restored by hand.

Note that a repeated PF notification does still correct this, since
enic_vf_admin_mac_notify() re-arms on !enic->vf_admin_mac_pending, but that
requires the PF to notify again. Would gating this branch on the cached
policy, or making apply_policy compare policy against dev_addr, match the
stated intent better?

[ ... ]

> @@ -1807,6 +2302,25 @@ static int enic_open(struct net_device *netdev)
>  	if (!enic_is_dynamic(enic) && !enic_is_sriov_vf(enic))
>  		enic_dev_add_station_addr(enic);
>  
> +	if (enic_is_sriov_vf_v2(enic)) {
> +		if (!READ_ONCE(enic->vf_registered)) {
> +			netdev_err(netdev, "VF is not registered with its PF\n");
> +			err = -ENODEV;
> +			goto err_out_disable_wq;
> +		}
> +
> +		err = enic_vf_station_addr_replace(enic, netdev->dev_addr);
> +		if (err) {
> +			netdev_err(netdev,
> +				   "Failed to register VF station address: %d\n",
> +				   err);
> +			goto err_out_disable_wq;
> +		}
> +		enic_vf_station_addr_set(enic, netdev->dev_addr);
> +		enic_vf_station_sync_reset(enic);
> +		vf_mac_added = true;
> +	}
> +
>  	enic_set_rx_mode(netdev);
>  
>  	netif_tx_wake_all_queues(netdev);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921-b4-enic-sriov-v2-vf-receive-control-v1-0-67a0a6e08d43%40cisco.com
