Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793572396;
	b=Ysvem0kiSrmGH8TMI6+DdN2q289CiCh/fur0FLNaJwnN5E15BgTlT/5odI0Bvjhblp0r
	 YDslTvlbegk9ZPvLoXW2vpA1Y8L0L/TNPU9YlKci0F7Swn/aFJH9GOybTdUdoD23jN5jl
	 0dx9VkUpbM0TFKhRHY4UVWsZegMvu1/86To6n1NBZX9OxyrTBLvbIA/cYFN6dEqj3IoSf
	 o0bhLnam/mDVLPjhIrFh48nFgnUyFpEd46ow80W42Xh26anhJluxSei304tvcE1zs8CNy
	 BqvFy3XaSdQv4BG/P1y/fEI9pzZDChaLgi58Q1PFzW7NElLTDURjAqvNVlswXq/Bb1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793572396;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=iqBmhgJE4xY3IEg0XNHN66UMVsn+ddrhekbMptwp6Jk=;
	b=KzQ6dyw0Ey8krRlMR/Mbb/KvtJGP2Oi5Ool150F0QpAlZ+GfLt8Sh5KfpLIa914++qJH
	 ilKHIPKd+l+F4FdILY0ASUijFB4eW3keDqkL6t14HQmR7TPZ3ibW149NilhHC8UcYFFU4
	 hGKwKcK3oxzrPxzFbtRTTJYKbQm0FWERVmpqyz8U/Jyz0IlzLtM96QoGt19wtjyclFM2k
	 7Wstc985E6SRqi+XXlpf2fbfOmo2i8dDOej/nfqds4hdQCim8L9aSu4nGDC96qGbAZAzZ
	 iGdypXChgvFNVm1GYdpVZ1dQewwZD13A/YbFKzDmTXiVFLeJssb7585WvYKhY9NWjkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pye4YDxP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60CD606A32E
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 22:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pye4YDxP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0431F000C1;
	Sun,  1 Nov 2026 22:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793572395;
	bh=iqBmhgJE4xY3IEg0XNHN66UMVsn+ddrhekbMptwp6Jk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Pye4YDxPeu7OhKuyKaEqidyaEBf3JqIDbUQIlOyW3aWCISXYU+WLfsblCZPqHQoN+
	 daFQXxV3sHSYfwTG1c1LJGEhkSXvfPSm6m8MGoW3r92lg/JO5FLhgBqdh7EJ7HviOb
	 aOxUy/ObHCuJY6+uoboSr/8ifqF4GARkBOQW9r+uJG2L/2w6NozfFx+bVT+MQyF1JI
	 1WRO31fciU5iJKoCfsu9zA0Xz/oHP7rI18jtpDAHJ0rJcwN+SpyXL7bHqNCHjLCn32
	 +wgWWtomLVQT26z0Ps0dbYPn/r9kHRFYbUaa0Ykjx0KEPhwM/R01p548LC8oN5AN12
	 9bZ8Jeo7MRR1w==
Subject: Re: [net PATCH 03/13] fbnic: Keep the all-multi MACDA entry out of
 the address lists
From: netdev-bot+sashiko@kernel.org
To: alexander.duyck@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, kernel-team@meta.com, kuba@kernel.org,
 pabeni@redhat.com
Date: Sun, 01 Nov 2026 22:33:14 +0000
Message-ID: <179357239458.3131.3765676855851618737@kernel.org>
In-Reply-To:
 <179322337944.40667.340791169611814458.stgit@ahduyck-xeon-server.home.arpa>
References:
 <179322337944.40667.340791169611814458.stgit@ahduyck-xeon-server.home.arpa>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The rewritten layout comment in
  drivers/net/ethernet/meta/fbnic/fbnic_rpc.h says the reserved entry…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but a BMC
  multicast address can be silently dropped when the host fills the…
- [Low] This problem wasn't introduced by this patch, but the comments on
  the multicast scan loops in __fbnic_mc_sync…

--

fbnic: Keep the all-multi MACDA entry out of the address lists

The MACDA entry just below mac_addr_boundary is now kept for the BMC
all-multi wildcard. Before this, either the unicast or the multicast list
could take that entry, and the BMC rule then matched a host address. The
unicast scan now starts at mac_addr_boundary, and the multicast sync and
unsync scans start one entry below it.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
> index dc86b51f35830..0be71e6fd3d4e 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c

[ ... ]

> @@ -507,9 +508,10 @@ struct fbnic_mac_addr *__fbnic_mc_sync(struct fbnic_dev *fbd,
>  
>  	/* Scan from middle of list to top, filling top down.
>  	 * Skip over the address reserved for the BMC MAC and
> -	 * exclude index 0 as that belongs to the broadcast address
> +	 * exclude index 0 as that belongs to the broadcast address.
> +	 * The entry below the boundary is reserved for all-multi.
>  	 */

[Severity: Low]
This is a pre-existing issue, but the comment says the scan excludes
"index 0 as that belongs to the broadcast address". Broadcast is at
FBNIC_RPC_TCAM_MACDA_BROADCAST_IDX (4), and index 0 is
FBNIC_RPC_TCAM_MACDA_BMC_ADDR_IDX. The loop stops at:

	--i > FBNIC_RPC_TCAM_MACDA_BROADCAST_IDX

Since this comment is being edited anyway, could the index be fixed too?

fbnic_mc_unsync() in fbnic_netdev.c has the same text. This patch changes
the start of that loop, but its comment does not get the new reservation
sentence.

> -	for (i = fbd->mac_addr_boundary;
> +	for (i = fbd->mac_addr_boundary - 1;
>  	     --i > FBNIC_RPC_TCAM_MACDA_BROADCAST_IDX;) {
>  		struct fbnic_mac_addr *mac_addr = &fbd->mac_addr[i];
>  

[Severity: Medium]
This isn't a bug introduced by this patch, but the shared multicast
region is now 5..22. If the host fills it, can a BMC multicast address
get dropped?

When the first scan finds no free entry, the second scan in
__fbnic_mc_sync() walks BMC indices 3..1 and only matches entries that
already exist:

	while (--i) {
		...
		/* Only move on if we find a match */
		if (!ether_addr_equal(mac_addr->value.addr8, addr))
			continue;

So __fbnic_mc_sync() returns NULL even when BMC slots 1-3 are free.
fbnic_bmc_rpc_init() then logs the failure and skips the address:

		if (!mac_addr) {
			netdev_err(fbd->netdev,
				   "No slot for BMC MAC address[%d]\n", j);
			continue;
		}

By this point fbnic_bmc_rpc_check() has already cleared
FBNIC_FW_CAP_F_BMC_TCAM_REINIT, and nothing schedules a retry. If the
host addresses are already synced, __fbnic_set_rx_mode() never sees
-ENOSPC, so neither the host nor the BMC falls back to all-multi. With BMC
all-multi off, the BMC address stays unprogrammed until the next firmware
reinit.

This patch lowers the trigger from 19 host multicast entries to 18.

Later in the series, "fbnic: Rebuild the BMC rules from scratch on every
reinit" adds fbnic_bmc_mc_reserved(). That only keeps a copy that is
already in the BMC region, so a new, distinct BMC multicast address would
still fail.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.h b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.h
> index 3d4925b2ac75d..679ba0a1058d9 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.h
> @@ -156,9 +156,9 @@ enum {
>   * always go top-down with unicast, and bottom-up with multicast so that
>   * there should be free-space in the middle between the two.
>   *
> - * The entry at MADCA_DEFAULT_BOUNDARY is a special case as it can be used
> - * for the ALL MULTI address if the list is full, or the BMC has requested
> - * it.
> + * The entry just below the boundary is reserved for the ALL MULTI address,
> + * used if the list is full, or the BMC has requested it. Neither the unicast
> + * nor the multicast list allocates it.
>   */

[Severity: Low]
Is "used if the list is full, or the BMC has requested it" accurate? The
only place that fills this entry is fbnic_bmc_rpc_all_multi_config(), and
it does so only when BMC all-multi is on:

	mac_addr = &fbd->mac_addr[fbd->mac_addr_boundary - 1];
	if (fbnic_bmc_all_multi(fbd)) {

If the host multicast list is full and BMC all-multi is off,
fbnic_promisc_sync() puts the wildcard at PROMISC_IDX instead:

	mac_addr = &fbd->mac_addr[FBNIC_RPC_TCAM_MACDA_PROMISC_IDX];
	...
	} else if (mc_promisc && !fbnic_bmc_all_multi(fbd)) {

That agrees with the comment a few lines further down:

/* Reserved for use to record Multicast promisc, or Promiscuous */
#define FBNIC_RPC_TCAM_MACDA_PROMISC_IDX	31

The host only shares this entry, through FBNIC_MAC_ADDR_T_ALLMULTI, when
the BMC has already asked for all-multi. Otherwise the entry is unused.

Could the comment say "and" instead of "or", so it does not contradict
the PROMISC_IDX comment?

>  #define FBNIC_RPC_TCAM_MACDA_MULTICAST_IDX	5
>  #define FBNIC_RPC_TCAM_MACDA_DEFAULT_BOUNDARY	24

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179322311834.40667.5383039334126572422.stgit%40ahduyck-xeon-server.home.arpa
