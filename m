Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793572400;
	b=HS70N/aUr0WCHd9OHZ+XZ/4imFywHedAe1wEaPQ3qezLpE9Ann55kOHHwc4a1wh+hrLy
	 TwW3iB16sVmM7l7pxpy2qMwOARjN9TytyeVEpC5qiomUDHkmdIlw9OXeM/kWabu6CIpmF
	 2b2cXKi95baoljEwmV3oA4g401MgCoqHm65DcwCVdi92+bFNsAXJ5uj3wIpG39LDGJzC2
	 PCscOwznt6QsA+cJcV6wAF6FSKIdu4mvFLmgAav+qmfGSIwi2rHL3KG/M49aQmlH97vnb
	 8vnnMq2fporTr9HZ5qDbRVyn+j4wxLcAth7wx6Q58KjBhMOTuZR07FOEcj7WyHsBL6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793572400;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=6tjO2Dw0Jqt6zDf8e1OklFR5QzQZNKoFJmQX6JBmQUc=;
	b=eYoTX8aBNAhoRxB+35HZFvx4FnfjW443m8ygV3+v8qnUQ2AHup/sf6Mq4EoLqUzRJzPj
	 zgVPm2xzbD5vdQQMQkNeMs5odCE0cXjBkkZ52aD6g+f5HTD5yPDittyDlycas3VMmCeOK
	 GxE0vLLw6RmQv56R4umwvcx66z8cSjid7x70NdFYudEZ4zCRYqyyfiNlSguneLgXLlqoK
	 yP3e2QwcwXaeQ20MQDXPFgsQSiLIIwbkAqWZYvjgquKoz9Y4rAxdCejeacKuoxgLrFA3+
	 9dq/CXct4ZkKx1fW3ZrhTJw+/hag3TxAwKuyFyQM6TJOHsHPxAuyZgKQoGdc+MrgoLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ikt1tA0O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD4B60A2600
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 22:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ikt1tA0O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419FD1F00A1B;
	Sun,  1 Nov 2026 22:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793572399;
	bh=6tjO2Dw0Jqt6zDf8e1OklFR5QzQZNKoFJmQX6JBmQUc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ikt1tA0OTQJRvp1ZIXjS1kKTis+sZF0REy5tQ0ff+3UU6fiPUv61oA6pyf/bEis10
	 YA1fHQ5fp8zj98wHlOe2lUYiwEFB7T6skxWeLkczpcVc+lfQ5XOu4xkoQqAG40cPZk
	 zsz0RImwJxICD9ZRV+iTom0Disfw0ty5iLMux48M+HqlfXgrx+Tc3q0w0NqGmTGipF
	 PdfGPDmJHyK4oDPvQKLHzkTRsyv8kEd/LTE7D54xuiqJcFr+rJDKUdlCtV9oTJcNlN
	 yMfvKreiesEzyC7GAFralReidaMoaDd6ii2Xk4dC9fYuHURnBEJ/U2+yWnPZ0QAQC6
	 +oz5BhUnD8dgg==
Subject: Re: [net PATCH 08/13] fbnic: Rebuild the BMC rules from scratch on
 every reinit
From: netdev-bot+sashiko@kernel.org
To: alexander.duyck@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, kernel-team@meta.com, kuba@kernel.org,
 pabeni@redhat.com
Date: Sun, 01 Nov 2026 22:33:18 +0000
Message-ID: <179357239885.3131.16324198442382932800@kernel.org>
In-Reply-To:
 <179322341925.40667.5355631858927438954.stgit@ahduyck-xeon-server.home.arpa>
References:
 <179322341925.40667.5355631858927438954.stgit@ahduyck-xeon-server.home.arpa>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In fbnic_bmc_rpc_init()
  (drivers/net/ethernet/meta/fbnic/fbnic_rpc.c), two allocators hand out…
- [Medium] Because of the new teardown, a host multicast sync in the same
  pass can wipe the BMC tag that fbnic_bmc_rpc_init() just restored.
- [Medium] fbnic: BMC multicast slot loss and overwrite in
  fbnic_bmc_mc_reserved()

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the patch's
  argument that 'an entry rebuilt before the next hardware write is…

--

fbnic: Rebuild the BMC rules from scratch on every reinit

This commit makes fbnic_bmc_rpc_init() first tear down the BMC MACDA and
action rules with fbnic_bmc_rpc_disable() and then rebuild them from the
current firmware capabilities. It drops fbnic_bmc_rules_present() and adds
fbnic_bmc_mc_reserved() as a fallback for BMC multicast entries that
fbnic_sift_macda() moved into the BMC region. It also tags the all-multi
wildcard entry for the BMC on every pass.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
> index ee781a3e15285..e6b9b9d6511fa 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c

[ ... ]

> @@ -172,6 +175,77 @@ void fbnic_bmc_rpc_all_multi_config(struct fbnic_dev *fbd,
>  	act_tcam->state = FBNIC_TCAM_S_UPDATE;
>  }
>  
> +/**
> + * fbnic_bmc_rpc_disable - remove the BMC MAC and action rules
> + * @fbd: Pointer to fbnic device struct
> + *
> + * Strip everything a previous fbnic_bmc_rpc_init() programmed. Idempotent,
> + * and only marks shadow state; entries that are rebuilt before the next
> + * hardware write are rewritten in place rather than cleared and re-added.
> + */
> +static void fbnic_bmc_rpc_disable(struct fbnic_dev *fbd)

[Severity: Medium]
This isn't a bug introduced by this patch, but this comment assumes nothing
writes the MACDA and action TCAMs to hardware between the teardown and the
rebuild. Does that hold for every writer?

fbnic_bmc_rpc_check() uses netdev_lock() to serialize against the rx mode
and ethtool paths. __fbnic_pm_attach() in fbnic_pci.c, however, calls
fbnic_up() without RTNL or the instance lock:

drivers/net/ethernet/meta/fbnic/fbnic_pci.c:__fbnic_pm_attach() {
	rtnl_lock();
	fbnic_reset_hw_stats(fbd);
	rtnl_unlock();
	...
	if (netif_running(netdev))
		fbnic_up(fbn);
	...
}

fbnic_up() then goes on to __fbnic_set_rx_mode()->fbnic_write_macda().

The service task can still be alive at this point. On suspend,
fbnic_down()->fbnic_service_task_stop() uses cancel_delayed_work() rather
than the _sync variant. A pass that was blocked on RTNL then continues after
suspend drops it. It still sees netif_running() as true, so it calls
fbnic_bmc_rpc_check() and re-arms itself.

Suppose that pass runs fbnic_bmc_rpc_disable() on resume while the unlocked
fbnic_write_macda() is walking the table. fbnic_write_macda() would see the
transient DELETE state and do:

	if (mac_addr->state == FBNIC_TCAM_S_DELETE) {
		fbnic_clear_macda_entry(fbd, idx);
		memset(mac_addr, 0, sizeof(*mac_addr));
		continue;
	}

Could this wipe a BMC MACDA entry, or BMC rule 0, that fbnic_bmc_rpc_init()
is about to rebuild? The BMC would then have no Rx path until the next
REINIT.

The unlocked fbnic_up() and the non-sync cancel are older than this patch,
and later patches in the series don't change __fbnic_pm_attach(). This patch
adds one more transient shadow state that the race can expose.

[ ... ]

> @@ -179,6 +253,11 @@ void fbnic_bmc_rpc_init(struct fbnic_dev *fbd)
>  	struct fbnic_mac_addr *mac_addr;
>  	int j;
>  
> +	/* Start from nothing so a MAC the BMC no longer reports does not
> +	 * keep its tag, then rebuild from what firmware last sent.
> +	 */
> +	fbnic_bmc_rpc_disable(fbd);

[Severity: Medium]
Can this teardown let a host multicast sync later in the same open strip the
BMC tag that this function just restored?

Take a BMC-only multicast address M that fbnic_sift_macda() moved into BMC
slot 1, with a free shared slot S and M pending in the host multicast list.
At open, M is always pending because fbnic_clear_rx_mode() calls
__dev_mc_unsync(netdev, NULL) at ifdown. The sequence is:

__fbnic_open()
  fbnic_bmc_rpc_init()
    fbnic_bmc_rpc_disable()
      slot 1: BMC bit cleared, state DELETE, value M kept
    __fbnic_mc_sync(M)
      memcpy() slot 1 into S, slot 1 left in DELETE
    set_bit(FBNIC_MAC_ADDR_T_BMC, ...) on S
  fbnic_rss_reinit()
fbnic_up()
  __fbnic_set_rx_mode()
    fbnic_mc_sync(M)
      __fbnic_mc_sync(M)
        for loop matches S and breaks
        while (--i) loop matches the stale slot 1 copy
      set_bit(FBNIC_MAC_ADDR_T_MULTICAST, avail_addr->act_tcam)

No fbnic_write_macda() runs in between to clear slot 1. The second
__fbnic_mc_sync() therefore repeats the copy:

		if (avail_addr) {
			memcpy(avail_addr, mac_addr, sizeof(*mac_addr));
			mac_addr->state = FBNIC_TCAM_S_DELETE;
			avail_addr->state = FBNIC_TCAM_S_ADD;
		}

S now has slot 1's act_tcam bitmap, which the teardown emptied. Before this
patch slot 1 still had the BMC bit here, so the second copy kept the tag.

With only FBNIC_MAC_ADDR_T_MULTICAST left on S, __fbnic_write_tce_tcam()
would stop looping host Tx for M to the BMC. The firmware MACDA sync would
also stop marking M as a BMC address.

When the host later leaves M, __fbnic_xc_unsync() empties the bitmap and
deletes the entry. The BMC would then lose Rx for M until the next REINIT.

The same thing can happen if M was added while the interface was down, or
just before a service task REINIT. This also looks to be still present at
the end of the series.

> +
>  	/* Check if BMC is present */
>  	if (!fbnic_bmc_present(fbd))
>  		return;
> @@ -191,10 +270,16 @@ void fbnic_bmc_rpc_init(struct fbnic_dev *fbd)
>  		if (is_zero_ether_addr(bmc_mac))
>  			continue;
>  
> -		if (is_multicast_ether_addr(bmc_mac))
> +		if (is_multicast_ether_addr(bmc_mac)) {
>  			mac_addr = __fbnic_mc_sync(fbd, bmc_mac);
> -		else
> +			/* With the shared region full, keep the copy the
> +			 * teardown left in the BMC region in place.
> +			 */
> +			if (!mac_addr)
> +				mac_addr = fbnic_bmc_mc_reserved(fbd, bmc_mac);
> +		} else {
>  			mac_addr = &fbd->mac_addr[i++];
> +		}
>  
>  		if (!mac_addr) {
>  			netdev_err(fbd->netdev,

[Severity: Medium]
Does this fallback handle the case where the BMC changes or adds a
multicast address while the shared region is full?

fbnic_bmc_mc_reserved() only returns an entry in slots 1..3 whose value
already equals addr, and it skips DISABLED entries. Suppose
fbnic_sift_macda() earlier moved a BMC-only multicast address M1 into
slot 1, the host has filled every shared multicast slot, and the BMC
now reports M2 in place of M1:

fbnic_bmc_rpc_init()
  fbnic_bmc_rpc_disable()
    slot 1: BMC bit cleared, state DELETE, value M1 kept
  __fbnic_mc_sync(M2)
    no DISABLED or DELETE entry in the shared region, returns NULL
  fbnic_bmc_mc_reserved(M2)
    slot 1 holds M1, slots 2 and 3 are DISABLED, returns NULL
  logs "No slot for BMC MAC address"

The next fbnic_write_macda() then clears slot 1. The BMC is left with
no MACDA entry for either address, even though slots 1..3 are unused.

Because M2 never gets an entry, fbnic_sift_macda() has nothing to move
into the BMC region either. Three things stay missing until another
REINIT happens to run with a shared slot free:

  - Rx for M2 to the BMC
  - the TCE loopback of host Tx for M2
  - the firmware MACDA sync entry for M2

Dropping M2 here is not new. However, the commit message says an
address that changed "can take a freed slot, now that the multicast
sync reuses entries waiting for deletion". In this case the freed slot
is in the BMC region, which __fbnic_mc_sync() never hands out. So that
claim does not seem to hold once the address had been sifted.

Letting the fallback claim a free slot in 1..3 would also need to be
coordinated with the unicast branch. That branch takes slots by
position via fbd->mac_addr[i++] and does not check what this helper
has returned.

As it stands, take mcA sifted into slot 1:

  - With the order [uc0, mcA, uc1], the fallback hands back slot 1
    and uc1 then overwrites it.
  - With [uc0, uc1, mcA], slot 1 is overwritten before the lookup,
    and mcA is dropped even though slots 2 and 3 are free.

Would it work to place the unicast addresses first? The multicast
fallback could then take any slot in 1..3 that the unicast addresses
did not claim and that is DISABLED, in DELETE, or already holds the
address. Or is there a reason to keep the BMC region out of the
allocation for new multicast addresses?

[Severity: Medium]
Can the unicast branch overwrite the slot that fbnic_bmc_mc_reserved() just
handed back?

fbnic_bmc_mc_reserved() searches BMC slots 1..3, and the unicast addresses
take those same slots by position:

			mac_addr = &fbd->mac_addr[i++];

Neither path checks what the other has already taken in this pass.

Suppose the BMC previously reported one unicast address (slot 0) and a
multicast address mcA. fbnic_sift_macda() moved mcA into slot 1, and host
entries fill the shared multicast region. The BMC then reports two unicast
addresses plus mcA, in the order [mcA, uc0, uc1]:

  __fbnic_mc_sync(mcA) returns NULL: no shared entry is free or in DELETE,
  and the while (--i) loop finds mcA in slot 1 but breaks because avail_addr
  is NULL
  fbnic_bmc_mc_reserved(mcA) returns slot 1, which gets tagged
  uc0 takes slot 0
  uc1 takes slot 1 via i++ and overwrites mcA's value and mask

mcA then disappears from the MACDA and TCE tables, and nothing is logged.

With the order [uc0, uc1, mcA], slot 1 is overwritten first. Both lookups
then miss, and mcA is dropped with "No slot for BMC MAC address" even though
slots 2 and 3 are free.

The commit message says:

    One that the fbnic_sift_macda
    function moved into the BMC region is only pulled back out by the
    __fbnic_mc_sync function when a shared slot is free, so with the shared
    region full it is taken back in place by the new fbnic_bmc_mc_reserved
    function instead of being lost.

Doesn't that fail whenever the BMC reports more unicast addresses than
before?

Once the entry and its BMC tag are lost, __fbnic_write_tce_tcam() stops
looping host Tx for mcA to the BMC, and the firmware MACDA sync no longer
lists mcA. If the shared region is exactly full, BMC Rx for mcA is lost as
well. This lasts until a later REINIT succeeds.

Would it help to place the unicast addresses first? Another option is for
the multicast fallback to skip, or move out of, the slots the unicast
addresses need. This also looks to be still present at the end of the
series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179322311834.40667.5383039334126572422.stgit%40ahduyck-xeon-server.home.arpa
