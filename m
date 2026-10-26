Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793048955;
	b=D8Q05LrkuOpHupsIaeJn2u1FtaHbz3c8qQPS7LQF9hT+YWsuViZAn9jcGQmu+TIoVVOD
	 NoAmpEbUtt6IZwnDk2f0w1aCyvfldMlI3F30urkbBrAB0eGUTnJOWdjqnps+rKrvSe/nF
	 EuW3roRFf1jiunFoha4v/wjq13pYwVXAbRgyflXPSEFHTkFyotn8MuLdnBbZriTXyx5C8
	 y+dL3C5r99ivo8E0xP/iThIwb0tj9WoIc1saIEkL14fSkikokMAkuy4j1qEhnf92J6Rj5
	 7DKYWfzddmOYRBaG6ND+o6ZKiBbjv0iuPvI9J+oMi14z6sMzeBbY4ptQebfmRJRMyLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793048955;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=DuQ1Wcl/9/AjDY4J7olX6CC7aGgr2FQKZCCHnkWjylo=;
	b=IM5BPUPe2DEhVeWt0D/kW6r35qt0MCR0g1gHgovRxLiNfURrRRi3KJuDXNi6eivKE+62
	 7zysK7jWkPldxERC+j1wSDD14ONV1gx3dB38KhL1z+wplSsGJtsPUy0zeUAt605WSB5xI
	 n9DRGBIufYNuPOFh0lZ5U9PMdRJ3G2ObhROnUmXqASZllJe7+Wx95qtTU+Maa8YJj6tCS
	 9/+zo6gz98QEAh3T4h3796G0n/JvUMl2mpBgZ4GuuQgPode0U7Rb/woH7kj73l5c6fG0/
	 w1ISPm0MkhjbB/pw61oqST2Fi4MSZyKaSiMLLFrkgbphRLMitFEG6Iy3h35ubWeMKNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UEthL+LK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA557606A31D;
	Mon, 26 Oct 2026 21:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UEthL+LK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF011F031E5;
	Mon, 26 Oct 2026 21:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793048954;
	bh=DuQ1Wcl/9/AjDY4J7olX6CC7aGgr2FQKZCCHnkWjylo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UEthL+LK+SeCZfbCHGVzaV/gk0VshJ/5PD+uFYgI+2BE7WR8PgF7y8omMn261NDD4
	 qupOKV6GJlVnOdb5b9tOEe329pU+ho3qM2K2rykuS69mC3cSMa2nY8mIxbHAvjbW/T
	 AzPTo9vI2nBHfrhvwGUuPC7dmNnS2tfM3IkDALni6jQvH7PMQ3pqeix1j17AuyOQKF
	 zIiux1z25USkVLoIXdUx/zyyFiLLGBGwSJqquU6e5iEkAml06KDnYAXQLZckVng09v
	 MQfOCx2CaiMnhvi4v3/uvIFEjid7XMNww6HGfWiVUsCPbXP9ECVNeK9cgspxobiqh4
	 VBbZiOCrrc1TQ==
Subject: Re: [PATCH] net: lan966x: fix double fwnode_handle_put() and missing
 mdb deinit in probe error path
From: netdev-bot+sashiko@kernel.org
To: mashikiselby@gmail.com
Cc: horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 26 Oct 2026 21:09:13 +0000
Message-ID: <179304895357.3134.7579048649329959225@kernel.org>
In-Reply-To: <20261025203155.455075-1-mashikiselby@gmail.com>
References: <20261025203155.455075-1-mashikiselby@gmail.com>
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

Critical: 0 · High: 1 (2) · Medium: 0 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new cleanup_mdb label calls lan966x_mdb_deinit()
  (lan966x_main.c:1302) and then jumps to cleanup_switch, so the…
- [Low] The commit fixes a real refcount bug but has no Fixes: trailer.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the reworked
  error ladder keeps it.
- [High] This problem wasn't introduced by this patch, but it is in the
  error path the patch reworks.
- [Medium] The probe error ladder in lan966x_probe() never calls
  lan966x_mac_purge_entries(), unlike lan966x_remove() (line 1332).

--

net: lan966x: fix double fwnode_handle_put() and missing mdb deinit in probe error path

This commit reworks the error ladder in lan966x_probe(). Failures after
the port loop no longer reach cleanup_ports, so fwnode_handle_put(ports)
is not called a second time. A new cleanup_mdb label calls
lan966x_mdb_deinit(), and a new cleanup_switch label skips the fwnode
puts and goes straight to lan966x_cleanup_ports().

> In lan966x_probe(), fwnode_handle_put(ports) is called after the
> fwnode_for_each_available_child_node(ports, portnp) loop finishes.
> However, if lan966x_fdb_init(), lan966x_ptp_init(), lan966x_fdma_init(),
> or lan966x_vcap_init() subsequently fails, execution jumps to or falls
> through to cleanup_ports, calling fwnode_handle_put(ports) a second time
> and skipping lan966x_mdb_deinit().

[ ... ]

> Signed-off-by: Selby Mashiki <mashikiselby@gmail.com>

[Severity: Low]
Should this have a Fixes: tag?

Both the fwnode_handle_put(ports) after the port loop and the one under
cleanup_ports came in with commit 925f3deb45df ("net: lan966x: add
missing fwnode_handle_put() for ports node"). That commit has its own
Fixes: tag, so the double put is probably in stable trees as well.

Something like:

Fixes: 925f3deb45df ("net: lan966x: add missing fwnode_handle_put() for ports node")

and possibly, for the missing MDB deinit:

Fixes: 7aacb894b1ad ("net: lan966x: Extend switchdev with mdb support")

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> index e4c9c5812ccab..887385833b4d6 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> @@ -1271,7 +1271,7 @@ static int lan966x_probe(struct platform_device *pdev)
>  	lan966x_mdb_init(lan966x);
>  	err = lan966x_fdb_init(lan966x);
>  	if (err)
> -		goto cleanup_ports;
> +		goto cleanup_mdb;
>  
>  	err = lan966x_ptp_init(lan966x);
>  	if (err)

[Severity: High]
This is a pre-existing issue, but it sits in the error path being
reworked here. What happens to PTP clocks that are already registered
when lan966x_ptp_init() fails partway through?

lan966x_ptp_init() registers LAN966X_PHC_COUNT clocks and returns on the
first failure:

drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c:lan966x_ptp_init() {
    ...
	for (i = 0; i < LAN966X_PHC_COUNT; ++i) {
		err = lan966x_ptp_phc_init(lan966x, i, &lan966x_ptp_clock_info);
		if (err)
			return err;
	}
    ...
}

Suppose ptp_clock_register() fails for PHC 1 or 2. The clocks registered
before it stay registered, and lan966x_probe() jumps to cleanup_fdb,
which skips lan966x_ptp_deinit().

Those clocks have ptp->info pointing at lan966x->phc[i].info. That is
inside the devm-allocated struct lan966x, which is freed when probe
fails.

After that, could reading /sys/class/ptp/ptpN/clock_name (clock_name_show()
dereferences ptp->info->name), or any operation on /dev/ptpN, touch freed
memory?

lan966x_ptp_deinit() unregisters every PHC unconditionally, so it can't
just be called here. lan966x_ptp_init() would need its own unwind for
the clocks it already registered.

[ ... ]

> @@ -1298,10 +1298,15 @@ static int lan966x_probe(struct platform_device *pdev)
>  cleanup_fdb:
>  	lan966x_fdb_deinit(lan966x);

[Severity: High]
This isn't a bug introduced by this patch, and the reworked ladder keeps
it. lan966x_fdb_deinit() destroys lan966x->fdb_work before
lan966x_cleanup_ports() calls unregister_netdev() on the ports.

Suppose a port is already in a bridge when the ptp, fdma or vcap init
fails. Would unregistering that port go through this chain on a
workqueue that has already been destroyed?

lan966x_cleanup_ports()
  unregister_netdev()
    bridge unlink -> NETDEV_PRECHANGEUPPER
      lan966x_port_prechangeupper()
        lan966x_fdb_flush_workqueue()
          flush_workqueue(lan966x->fdb_work)

FDB events on the still-registered ports in that window would also reach
lan966x_handle_fdb()->queue_work(lan966x->fdb_work, ...) on the freed
workqueue.

If lan966x_fdb_init() itself fails (now goto cleanup_mdb), fdb_work is
NULL. Would the same unregister path then end up in flush_workqueue(NULL)
or queue_work(NULL, ...)?

lan966x_remove() avoids this by calling lan966x_fdb_deinit() only after
lan966x_cleanup_ports().

>  
> +cleanup_mdb:
> +	lan966x_mdb_deinit(lan966x);
> +	goto cleanup_switch;

[Severity: High]
Does this free the MDB and PGID lists while the port netdevs are still
registered?

lan966x_probe_port() calls register_netdev() inside the port loop. The
matching unregister_netdev() only runs later, in lan966x_cleanup_ports()
under cleanup_switch.

lan966x_mdb_purge_mdb_entries() and lan966x_mdb_purge_pgid_entries() call
list_del() and kfree() without taking any lock. During this window, the
switchdev notifier can still deliver PORT_MDB/HOST_MDB add and del for
these ports under rtnl, for example on bridge join replay or a bridge mdb
add from userspace:

lan966x_mdb_ip_add()
  lan966x_mdb_entry_get() / lan966x_mdb_entry_add()
    list_add_tail(&mdb_entry->list, &lan966x->mdb_entries);

Could the unlocked purge race with these handlers, corrupt the list, or
free an entry a handler is still using? Entries added after the purge
but before unregister_netdev() would also leak.

lan966x_remove() does it the other way round:

	lan966x_cleanup_ports(lan966x);
	...
	lan966x_mdb_deinit(lan966x);

Should lan966x_mdb_deinit() also run after lan966x_cleanup_ports() in
the probe error path?

> +
>  cleanup_ports:
>  	fwnode_handle_put(ports);
>  	fwnode_handle_put(portnp);
>  
> +cleanup_switch:
>  	lan966x_cleanup_ports(lan966x);
>  
>  	cancel_delayed_work_sync(&lan966x->stats_work);

[Severity: Medium]
This is a pre-existing issue, but since the ladder is gaining an MDB
deinit: does the probe error path leak the lan966x_mac_entry objects on
lan966x->mac_entries?

lan966x_remove() calls lan966x_mac_purge_entries() after
lan966x_cleanup_ports(). None of the probe error labels do.

The list is initialized in lan966x_init()->lan966x_mac_init() before the
port loop. After that, the ANA learn IRQ can allocate entries:

lan966x_ana_irq_handler()
  lan966x_mac_irq_handler()
    lan966x_mac_irq_process()
      list_add_tail(&mac_entry->list, &lan966x->mac_entries);

lan966x_mac_add_entry() can also add entries from FDB work once the
ports are registered.

If lan966x_fdb_init(), lan966x_ptp_init(), fdma_init or
lan966x_vcap_init() fails after that, these entries are never freed. The
devm-allocated struct lan966x that holds the list head is then released.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261025203155.455075-1-mashikiselby%40gmail.com
