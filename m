Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F864F30E3
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 10:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850586; cv=none; b=nryjGQ0FPzRI6IasmQRYC+DHUk8tp96ZKym0y7VZp+3o6bcTYcYCZbI/xQUfAU7i1uwyCRux/OUuFJAUk6PgYfCV6QZPw1C+t6NOcRcm3dTcP2Hes0Z7B373UZ2xfw+tXY1VPuC6AOcN3yqr0bly1gaTBMvGexlg3QAXe+7nR+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850586; c=relaxed/simple;
	bh=wm9gFnEf7G1u1znhKWcEkas0zXUtbE2LUztT3PW6ZpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m/vN4MiU/xQoo8Vr0gy/jKHyg+ypNZxGRpbsOHhoEnxP+pNpCROxM5Bpy3USQB22VJDFRd3S6JCsYGEkv8gUTa8IFPJ3ju2mB6UQOAKSyNAHBHdNTsT20vZBv/AxcogcyM7XZam8eEDkC1vbE1/vUTxp4GNvU4RCjsVrmpiO+Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PyPE97hr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=so3EZON+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PyPE97hr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="so3EZON+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790850583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GgNMValwnNfKPiIj5Wmg9a1QcCmP1z/ZNinu2DpQbLo=;
	b=PyPE97hrWWtDnJe97tKIqFZ9FJoglOhAi34fupt+86387nK5ENtg0CqmL62x87YJve2awF
	0WKW4yLuZBnubfi25Kr7Bs9hoPwIwfiMWGNSO97K4/jl7dF73udnxBjkZ6p08OFG3T8VC4
	wllD5olORve1qvTE2gpWmMmoYcjZGY8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-vVPiS4QgOwKxTRq19gP-9w-1; Thu, 01 Oct 2026 06:29:42 -0400
X-MC-Unique: vVPiS4QgOwKxTRq19gP-9w-1
X-Mimecast-MFC-AGG-ID: vVPiS4QgOwKxTRq19gP-9w_1790850581
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49e7631c43aso60489175e9.3
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 03:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790850581; x=1791455381; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GgNMValwnNfKPiIj5Wmg9a1QcCmP1z/ZNinu2DpQbLo=;
        b=so3EZON+EIpbgAqsszZnW+2lF2ofmJFEdG6KNl0Wp/WyaQGCeqYtA5QT6ddmL0pgio
         W8LRRPobIhNksTlIvcafNJjwGJKGrvdu5N/Y67ClEXO7u/NePxgcc5IRGMxSc/joNu7i
         N7NgDCm5+87uGRvqqrbsj5KsrLyd62+2fohLuY1Dcs/6n2DmORM3Woyg26psI0tSoAR7
         whbPzpJZQNHeFv1bdNkrAUt1VzIe40sv+PD97rIX7e+8wf+rlKFXVQL9cGqFoUAIJry7
         8ijZF2K8/PnA1hrUcUduCyKZ+Usw+4vqFxGcftViVtxM7aT1Q5cTqpKxuV39OmDgSf69
         ZV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790850581; x=1791455381;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GgNMValwnNfKPiIj5Wmg9a1QcCmP1z/ZNinu2DpQbLo=;
        b=lUViIqrwkIQKyHklAQGJfs48mJFmAD6GYyhtBP137ML6tX61mUeGN86aoWaUXts1ja
         SVO6yqGCBboWjS6I7Ig2Tib7JaPku+mU1myb5WFOlE/cr0LOvcXYkrX3lublYXH4Myxc
         9dAiQ9KbVeHuCTdnyqfECnnJBHa2rTvTBHtSiTYaWdxWkdTWGLcrx1Gw22ajppVJnPlb
         mUG5Y3XAr+eODZZDEiYvnlYpaXXn4KLhSnJ+nkp9rrb22OapdMQKXJIZB/E5o4cc2ZR5
         ZxsMTJ7JKE7CgP41vfcE/5YfSnhHqAT3R56oTJkL1GxMFUpl5yr33kuEGzIFkb/AvYAs
         +G3w==
X-Forwarded-Encrypted: i=1; AKwUvByDM2G8Ri1Ej8iur7lzBRuGiHNp0GohBVFTYAiYr+CKYnbs/z27QKf6P/D0i/t7t2LuYDBDPdE=@vger.kernel.org
X-Gm-Message-State: AFuF++nMJuaMuwP+7QxNJoptCc50+/57azJigXrZ4IZUEg1ZUO5Z5mt4
	f+t2BCut2lcfdMZEMwcdY/jHvCMksBBHdJw/10aFDFd5ofAeklTOBBcRlE9kOgOSdS115UA9Aw+
	tIitbJ77FPmiKfYfQf5y2MKIOyu1c9/8ydupa1dFL5KEa/EfXPUYZ7uclOw==
X-Gm-Gg: AYBFou2GdHX54GIDWogdu0gf3rLdz64cRMZGQGv6deLDYuE+YRSeyfsOeHANJuHu4L6
	aJLkmi76JsHg+Eyw2LBod9EpNP/AamCounB9Rdom288mfcEENOKOOpBCEis9Y6aBb/lZfuEAcBm
	hoctRY4FrsduUVbpqV971v6XD7Rn4hBNqyhz4C8OknFTZloFxlLTiKWkj/2M0tjZmVWPm5w4CcO
	UJWdbE8RmsFlZTNVg50I+CapdZ99+o8EWPj1p8l5n4EUK8iklNrSYsIVUHuvZszIBj3MAG7WROJ
	7trfYCSbqrEAaLd5ejzEN2le0Ul3Xv6nC9okO56uac3g9LeVBpDmzfa4eyxTgEmTESPfaVUYG6L
	tVOy9/EvsWp/9El6mkcg8TV0jte4MjcziffMaptsc/6E6XbUV+dX+Wi1vvZtba8BJ1yqBBnqWuQ
	==
X-Received: by 2002:a05:600c:8b33:b0:4a0:20c7:6d4c with SMTP id 5b1f17b1804b1-4a020c77b5bmr23433185e9.0.1790850580677;
        Thu, 01 Oct 2026 03:29:40 -0700 (PDT)
X-Received: by 2002:a05:600c:8b33:b0:4a0:20c7:6d4c with SMTP id 5b1f17b1804b1-4a020c77b5bmr23432645e9.0.1790850580054;
        Thu, 01 Oct 2026 03:29:40 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a020f7f1c2sm26326245e9.2.2026.10.01.03.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 03:29:39 -0700 (PDT)
Message-ID: <933a5c5e-149f-44cb-852c-932e4d823fb0@redhat.com>
Date: Thu, 1 Oct 2026 12:29:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 0/5] net: pse-pd: decouple controller lookup
 from MDIO probe
To: Carlo Szelinsky <github@szelinsky.de>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Corey Leavitt <corey@leavitt.info>,
 Jonas Jelonek <jelonek.jonas@gmail.com>, Simon Horman <horms@kernel.org>,
 Aleksander Jan Bajkowski <olek2@wp.pl>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, netdev-bot+sashiko@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260927191850.1370515-1-github@szelinsky.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260927191850.1370515-1-github@szelinsky.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/27/26 21:18, Carlo Szelinsky wrote:
> This is v7 of Corey's series [1]. It takes the PSE controller lookup out
> of the MDIO probe path, so a modular PSE controller driver no longer makes
> the PHY (and any DSA switch behind it) spin on -EPROBE_DEFER until the PSE
> module loads.
> 
> v6 [7] drew a large AI review [8], which I have now answered point by point
> in that thread. Paolo's reading was right: most of the [High] findings
> described the state of the tree between the old patches 3 and 5, which the
> old patch 5 then fixed. Rather than argue that in five changelogs, v7 folds
> those three patches into one, so the rtnl detour and the deferred release
> never exist at any commit. That also removes a real bisect hazard: the old
> patch 3 on its own hung lantiq_etop and sni_ave on probe, and the old patch
> 4 was what repaired it.
> 
> Per Documentation/process/maintainer-netdev.rst I ran LLM review over v7
> before posting, more than once. Patches 3 and 4 exist because of what it
> found, and it changed patch 2 and the phy patch as well:
> 
> Patch 2 reorders pse_controller_unregister() around the new event, because
> a subscriber runs arbitrary teardown inside it. The controller is unlinked
> from pse_controller_list first, so a lookup racing the teardown resolves
> nothing rather than a controller whose pcdev->pi[] pse_release_pis() is
> about to free. v6 disclosed that as pre-existing and reachable only from
> phy registration; it is reachable from more than that here, because after
> the last patch a second controller registering runs a PSE_REGISTERED walk
> that calls of_pse_control_get() for every phy on mdio_bus_type, which is
> exactly the two-controller board I test on. disable_irq() moves up for the
> same reason: pse_isr() queues notifications and reaches pcdev->pi.
> 
> cancel_work_sync() moves the other way, to after the event rather than
> before it. A subscriber dropping the last pse_control reference reaches
> __pse_control_release(), which calls regulator_disable() if the PI is
> still on. With the static budget strategy that retries any port on the
> same power domain waiting for power, and if the domain is still over
> budget it sheds a lower priority port through pse_disable_pi_pol(),
> which queues a notification and calls schedule_work(). Draining the
> worker before the walk would leave work queued behind it, racing the
> kfifo_free() below. Draining after it also stops the worker's own
> transient reference, taken by pse_control_find_by_id(), from becoming
> the last one once pse_release_pis() has freed the array.
> 
> [9] makes a related reordering for net, independently of any
> subscriber, so pse_controller_unregister() will conflict when [9]
> back-merges. The order is not identical: [9] leaves the unlink below
> cancel_work_sync() and pse_flush_pw_ds(), which it can, having no event
> to place. Here the event has to sit after the unlink and before the
> frees, and cancel_work_sync() after the event, so the unlink moves to
> the top. The merged function wants this order, which contains [9]'s fix:
> 
>      if (pcdev->irq)
>              disable_irq(pcdev->irq);
>      mutex_lock(&pse_list_mutex);
>      list_del(&pcdev->list);
>      mutex_unlock(&pse_list_mutex);
>      blocking_notifier_call_chain(&pse_controller_notifier,
>                                   PSE_UNREGISTERED, pcdev);
>      cancel_work_sync(&pcdev->ntf_work);
>      pse_flush_pw_ds(pcdev);
>      pse_release_pis(pcdev);
>      kfifo_free(&pcdev->ntf_fifo);
> 
> I am happy to send that as a follow-up on top of the merge if that is
> easier than carrying it in the conflict.
> 
> Kory, a specific ask on patch 2. The reason cancel_work_sync() sits below
> the event and not above it is that __pse_control_release() can re-enter
> your budget code: regulator_disable() on a PI that is still on runs
> _pse_pi_disable(), and with the static strategy that retries a pending
> port on the same power domain and, if the domain is still over budget,
> sheds a lower priority one through pse_disable_pi_pol() - which queues a
> notification and calls schedule_work() from inside the walk. I have
> tested that path rather than only reasoned about it, but the ordering
> rests on your design, so I would rather you looked at it than have it
> ride in unremarked.
> 
> Patch 4: each PSE PI regulator is registered with a "vpwr" supply. The
> regulator core deliberately treats an unresolved supply at registration as
> non-fatal, so pse_controller_register() completes and PSE_REGISTERED fires
> for a controller whose PIs cannot be handed out yet: regulator_get_exclusive()
> in pse_control_get_internal() resolves the supply itself and keeps
> returning -EPROBE_DEFER until the vpwr provider appears. Before this series
> the MDIO layer propagated that and deferred probe retried it. After it,
> phylib has no event left to retry on, and the port would silently lose PSE
> for good. Patch 4 checks every PI's supply before registering anything, so
> the PSE driver's own probe defers and deferred probe handles the ordering.
> It checks exactly the PIs the registration loop creates a regulator for,
> including a controller with no pse-pis node, and it follows both stages
> the core uses - the PI node, then the controller device - because a
> vpwr-supply written once on the controller node is invisible from the PI
> node but resolves at stage two. It stops short of the core's
> device_is_bound() gate, so a probe interleaving with the provider's own
> can still resolve late; the changelog says so.
> 
> Patch 3: that makes -EPROBE_DEFER an ordinary return from
> pse_controller_register(), which has no error unwind at all. The kfifo and
> the PI array plus its OF references are leaked on every failure, once today
> and on each retry after patch 4, and a partial pse_register_pw_ds() leaves
> devm-allocated power domains in the global xarray for the next registration
> to trip over. Patch 3 adds the unwind, at two depths: pse_pi_ops index
> pcdev->pi[], and the PI regulators are devm-registered, so once one exists
> the array cannot be freed here at all and stays leaked as it is today. It
> is released on the failures that happen while it exists and before the
> first PI regulator does - setup_pi_matrix() and the supply check - which is
> where the ordinary deferral now lands.
> 
> The same reviews caught two things in the phy patch. The error paths of
> phy_device_register() could leak a handle: device_add() puts the phy on
> the klist before its own later failure points, so a PSE_REGISTERED walk
> can attach one that nothing releases. A put at the out: label does not
> work, because by then device_add() has unwound the phy off the bus and
> the PSE_UNREGISTERED walk would miss it too. phydev->psec_detached now
> covers registration as well as removal, so no handle is attached in that
> window. And that flag is a plain bool rather than another bit in the
> flags word, since it is written under pse_phy_lock() while its
> neighbours are written under phydev->lock and rtnl.
> 
> No Fixes: tag. 5e82147de1cb ("net: mdiobus: search for PSE nodes by
> parsing PHY nodes") is the commit to blame, but this is a refactor
> across two subsystems plus a new export, and tagging it would invite a
> stable backport of all that to cure a probe-retry loop.
> 
> Two changelog errors from v6 are also fixed: netsec does not deadlock (its
> MDIO bus comes up in probe, not from ndo_init), and the module-unload
> rationale was backwards (try_module_get() pins the provider, so rmmod is
> refused before the unregister path ever runs).
> 
> How it works: pse_core gets a notifier chain (REGISTERED / UNREGISTERED).
> phylib subscribes, owns phydev->psec, and attaches the handle when the
> controller shows up instead of during probe. fwnode_mdio loses its PSE
> awareness, so no -EPROBE_DEFER leaves it and the probe-retry loop is gone.
> 
> On the tags: Jonas tested the v4 shape and Aleksander tested the v6
> locking, which is unchanged here. Neither tested the fixes above. On the
> folded phy patch the code they exercised is intact, so I have kept their
> tags there. Jonas's tag also rides on patch 2, and that one did change in
> v7 - pse_controller_unregister() is reordered around the event - so it is
> the weakest of the three. Patch 1 only gained a kernel-doc correction. I
> would rather say so here than let it pass silently; happy to drop any of
> them if either would prefer.
> 
> Tested on a Realtek rtl9303 PoE switch with an HS104 PSE controller on
> i2c, with a PD drawing power on one port:
> 
>   - clean boot, no probe-retry loop, the controller registers once
>   - rmmod is refused while a phy holds a handle
>   - i2c unbind: the notifier walk drops the handle and the port powers
>     down, and ethtool reports no PSE attached
>   - i2c bind: the handle comes back and the PD is powered again
>   - six unbind/bind cycles, no warning, power domain index stable
> 
> Also exercised under QEMU, on arm64 under KASAN, PROVE_LOCKING and
> kmemleak. The device tree has a PSE controller, a second one whose vpwr
> provider never appears, and an MDIO bus with two phys, only one of which
> references a PI. Unbinding the controller detaches that phy's handle and
> rebinding re-attaches it; the other phy is never touched; unbinding the
> MDIO bus releases a live handle; and the controller with the missing
> supply defers instead of registering. A third controller puts its
> vpwr-supply on the controller node rather than the PI nodes, which the
> core resolves one stage later - that one has to defer too, and on the
> code before patch 4's second stage it registers instead. The new
> WARN_ON in patch 5 stays silent across six unbind cycles and kmemleak
> reports nothing.
> 
> The same test setup stages an over-budget static-priority domain, so that
> dropping the last reference really does reach pse_disable_pi_pol() and
> schedule_work() from inside the walk - the case patch 2's
> cancel_work_sync() placement exists for. I checked that with a
> dump_stack() rather than by reasoning about it: releasing phy1's handle
> in the walk lands in _pse_pi_disable(), the retry picks a pending port on
> the same domain, the domain is short, and a lower priority port is shed.
> No lockdep splat, which is the result I wanted most: that path re-enters
> the regulator core from a notifier callback, under the chain's rwsem and
> pse_phy_mutex.
> 
> Build matrix, all linking a real vmlinux: PHYLIB=y, PHYLIB=m (the config
> that failed to link in v5), PHYLIB=n, PSE_CONTROLLER=n, and CONFIG_OF=n.
> 
> Tested-by: Carlo Szelinsky <github@szelinsky.de>
More feedback from clashiko. Low prio remarks, items addressed later
in the series and ask for fixes tag could be ignored, but still a few
things that look real there.

/P

