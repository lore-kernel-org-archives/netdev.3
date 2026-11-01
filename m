Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793572399;
	b=e/A/3xg5gAOAexA+QmY7MQgvMyYGU/quzc8xa1lrY0pJx3RmhTlJh1lkf0bYrfrpXiCA
	 du2vxv8DIey9OTAR1C5s/1toM5N9UFmCdn5MJmZpie+VGenxeVWH7qbn1JODGYQxYFKSm
	 Fvl+TwXD6e6yKyLSs3S01/zbX4qLP5BsGJs5hQ2nVa01fomCdvlDwID70I4TOIV1lvHrT
	 2QGdpH79AaPUqjogC74yjNs2aXtRZDX898eZAjD/v8jbhDUkLmmqVGT9jFqG90DYQLU35
	 f835VeTwkTnnsJftScF0gwQG4VTjjKTt9FqaOtOx5oIGbKFTFhb9HNFRqEDojDARb6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793572399;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ARyuzk3bSIav9DkEaFJGnTBzFlTcTbf7rDuKX3nPQUs=;
	b=4LKdmXgnb8UVJ0S+ncdsoWYTAbNoGy3H+lI5VoudO9DVlalbkcLP9FjKpt8GstSt3550
	 2R9GOuY0VqjsbZwFHvAMCIWpnJQpHvlXs94j5mbKmEEtxf7jlLrFV4T6cH7btBGAX+Wfz
	 ZJAMSE++9hfM9qFl77r7flSfkSiCsaxu9M7r/ln6ZV+DSPg4XU7wv661LqBWW59ABtZ2I
	 5B1GDmYUtnYZGe3TMhaGf4LC4Ox3bj4GC6nJso9qjrkKI46grI09b8sEYBwiGMzAOjLg5
	 OvwEDXrY1hTpWAmIl4wYfaBI0kI3xzlPiWR4W9SzbanU+Y9gfRVl5WMPhF4S5dZ39AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hu4t6Nt4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7B0606A33D
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 22:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hu4t6Nt4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3023B1F000C1;
	Sun,  1 Nov 2026 22:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793572398;
	bh=ARyuzk3bSIav9DkEaFJGnTBzFlTcTbf7rDuKX3nPQUs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hu4t6Nt4jbgRjLv7B4hOU3o8YFbf7fU1EkO1xzEHuDj4SwbVdoLKAG/yGevYYGvOe
	 4qnBv8QMIp7XgFC47aI1hajmQ/Ab1UdTGP62veB2IJSaQnO/e1lnyC2ZieEsBtBSxg
	 CHAhplDoANb5OD5t67bQ+O8aFCrZtLLeeWwPDYQG0NLQZK7rAC8O8IhN2rrR5bb640
	 IVWKIY4SoOFW6ir4A5+DPH8oJ4UltIdV+83va9MXfJ+RQuvFz01Ot68/LTV7VKHxOt
	 KZ2nzAgxju7tewMyer6AVKuwSFtYcntCahLRtBbSKjjWFy83ssn/4+hBj64lGW7cX8
	 GA3ihwjivit7A==
Subject: Re: [net PATCH 07/13] fbnic: Let the multicast sync reuse an entry
 waiting for deletion
From: netdev-bot+sashiko@kernel.org
To: alexander.duyck@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, kernel-team@meta.com, kuba@kernel.org,
 pabeni@redhat.com
Date: Sun, 01 Nov 2026 22:33:17 +0000
Message-ID: <179357239774.3131.13011880728523916297@kernel.org>
In-Reply-To:
 <179322341021.40667.10115759993706472767.stgit@ahduyck-xeon-server.home.arpa>
References:
 <179322341021.40667.10115759993706472767.stgit@ahduyck-xeon-server.home.arpa>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch fixes two defects in __fbnic_mc_sync().
- [Medium] A full-region multicast swap can still drop the device to all-
  multi with room to spare when the removed host address is also tagged…

--

fbnic: Let the multicast sync reuse an entry waiting for deletion

This patch lets __fbnic_mc_sync() treat MACDA entries in the DELETE state
as free. This lets a full multicast region swap one address for another
in a single rx mode pass. It also resets a matched DELETE entry, clearing
its tags, so fbnic_write_macda() no longer wipes the tag the caller has
just set.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
> index d69c91066508f..ee781a3e15285 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
> @@ -520,12 +520,16 @@ struct fbnic_mac_addr *__fbnic_mc_sync(struct fbnic_dev *fbd,
>  	     --i > FBNIC_RPC_TCAM_MACDA_BROADCAST_IDX;) {
>  		struct fbnic_mac_addr *mac_addr = &fbd->mac_addr[i];
>  
> -		if (mac_addr->state == FBNIC_TCAM_S_DISABLED) {
> -			avail_addr = mac_addr;
> -		} else if (ether_addr_equal(mac_addr->value.addr8, addr)) {
> +		if (mac_addr->state != FBNIC_TCAM_S_DISABLED &&
> +		    ether_addr_equal(mac_addr->value.addr8, addr)) {
>  			avail_addr = mac_addr;
>  			break;
>  		}
> +
> +		/* An entry waiting to be deleted is as good as a free one */
> +		if (mac_addr->state == FBNIC_TCAM_S_DISABLED ||
> +		    mac_addr->state == FBNIC_TCAM_S_DELETE)
> +			avail_addr = mac_addr;
>  	}

[Severity: Medium]
Can a full-region swap still end in all-multi with a slot free, when the
address being removed is also tagged for the BMC?

Take this setup:

- every shared multicast slot is in use
- one of those slots holds address A with both the MULTICAST and BMC tags
- one of the BMC-only slots below it is DISABLED

Now the host leaves A and joins B in one rx mode pass:

__hw_addr_sync_dev()
  fbnic_mc_unsync(A)
    __fbnic_mc_unsync()
      clears the MULTICAST bit. The BMC bit stays set, so
      __fbnic_xc_unsync() leaves the entry VALID, not DELETE.
  fbnic_mc_sync(B)
    __fbnic_mc_sync()
      finds no match and no DISABLED or DELETE slot, and B is not
      in the BMC region, so it returns NULL
    returns -ENOSPC

__fbnic_set_rx_mode() then turns on all-multi:

	err = __hw_addr_sync_dev(mc, netdev, fbnic_mc_sync, fbnic_mc_unsync);
	if (err == -ENOSPC)
		mc_promisc = true;

Later in the same pass, fbnic_sift_macda() moves the now BMC-only A into
the free BMC slot and marks its shared slot DELETE. fbnic_write_macda()
then frees that slot.

Nothing retries the sync of B, so its sync_cnt stays at zero. Wouldn't the
device then stay in all-multi with a free slot until the address lists
next change? That is the symptom the commit message describes as "the
device can sit in all-multi with room to spare until then".

[ ... ]

> @@ -551,9 +555,12 @@ struct fbnic_mac_addr *__fbnic_mc_sync(struct fbnic_dev *fbd,
>  		break;
>  	}
>  
> -	if (avail_addr && avail_addr->state == FBNIC_TCAM_S_DISABLED) {
> +	if (avail_addr && (avail_addr->state == FBNIC_TCAM_S_DISABLED ||
> +			   avail_addr->state == FBNIC_TCAM_S_DELETE)) {
>  		ether_addr_copy(avail_addr->value.addr8, addr);
>  		eth_zero_addr(avail_addr->mask.addr8);
> +		bitmap_zero(avail_addr->act_tcam,
> +			    FBNIC_RPC_TCAM_ACT_NUM_ENTRIES);
>  		avail_addr->state = FBNIC_TCAM_S_ADD;
>  	}

[Severity: High]
Does __fbnic_uc_sync() need the same fix? It has both of the patterns this
patch fixes for multicast, and it is left unchanged:

drivers/net/ethernet/meta/fbnic/fbnic_rpc.c:__fbnic_uc_sync() {
	...
		if (mac_addr->state == FBNIC_TCAM_S_DISABLED) {
			avail_addr = mac_addr;
		} else if (ether_addr_equal(mac_addr->value.addr8, addr)) {
			avail_addr = mac_addr;
			break;
		}
	}

	if (avail_addr && avail_addr->state == FBNIC_TCAM_S_DISABLED) {
	...
}

The first pattern is the swap. Suppose the unicast region is full and one
secondary unicast address (a macvlan, for example) is swapped for another
in a single rx mode pass. That hits the same unsync-before-sync ordering:

- fbnic_uc_unsync() only marks the old entry DELETE
- __fbnic_uc_sync() returns NULL
- fbnic_uc_sync() returns -ENOSPC

In __fbnic_set_rx_mode() that sets uc_promisc, which also forces
mc_promisc:

	if (err == -ENOSPC)
		uc_promisc = true;
	...
	mc_promisc |= !!(netdev->flags & IFF_ALLMULTI) || uc_promisc;

The new address keeps a sync_cnt of zero. Won't the device then stay fully
promiscuous, with a free slot, until the address lists change again?

The second pattern is the matched DELETE entry. The else-if branch can
match a DELETE entry by address and return it still in DELETE. The caller
then sets its tag, and fbnic_write_macda() wipes the entry, tag included:

		if (mac_addr->state == FBNIC_TCAM_S_DELETE) {
			/* Invalidate entry and clear addr state info */
			fbnic_clear_macda_entry(fbd, idx);
			memset(mac_addr, 0, sizeof(*mac_addr));

There seem to be two ways to reach this for unicast.

In the first, the interface is down and an ethtool ETHER_FLOW rule for
unicast DA X is deleted:

- fbnic_clear_nfc_macda() skips fbnic_write_macda() when !netif_running(),
  so the entry stays in DELETE.
- A new rule for X then goes through
  fbnic_set_cls_rule_ins()->__fbnic_uc_sync(), gets the DELETE entry, and
  sets the idx bit.
- On ifup, fbnic_write_macda() wipes the entry.

The act TCAM rule then points at an empty MACDA index. Can that index
later be handed out for a different address, so the rule steers the wrong
traffic?

In the second, host secondary unicast X shares an entry with an NFC rule:

- On ifdown, fbnic_clear_rx_mode() and fbnic_clear_macda() leave the
  entry NFC-only.
- Deleting the NFC rule while the interface is down moves it to DELETE.
- On ifup, fbnic_uc_sync(X) matches the DELETE entry and sets
  FBNIC_MAC_ADDR_T_UNICAST.
- fbnic_write_macda() then wipes the entry.

Wouldn't traffic to X be dropped, while the core counts X as synced and
never retries it?

fbnic_set_cls_rule_ins() picks __fbnic_mc_sync() or __fbnic_uc_sync() by
address type and handles both results the same way. After this patch, only
the multicast branch is sure not to return an entry still in DELETE.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179322311834.40667.5383039334126572422.stgit%40ahduyck-xeon-server.home.arpa
