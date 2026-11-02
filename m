Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793628497;
	b=DZMZseyfRpzYGTBn7ALEXU5nG8JcPC2jx+vTP1JgLG80BIJYYkEqT/Fh5SgvBP68xxwv
	 cpaORax06dNGpuJ6iW1QCDNWQhk6YhfwcWhSxos0Y9zpEf/oQbFNwPnVFnK+O0pC+UX3U
	 uKA4AHEyBSllPYzRYwPN7iaxokNsGI9JNAJziQhu5igWs3bd09Uy1awwJxut+wlNKoDse
	 x4Y+vEn4Cibqng3Un0kma+dnrbXjfHSFnmLewGYAjD2pwEpXWuWn67Y1HsE3mo7IJ3QVn
	 dzbRP1qirN4rkpz5JiHnX6GqqgmEBYHL8KbgwOJG+xHCN08zzeEX/uCBAeVXJRW6tHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793628497;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=1XXS1yBXm7iXcmQ6DOH8yooQHsnJf+YUASejRax8G7w=;
	b=nCDKT2HF4UFMK7EYnT6rr4qk/AMM87wbfuKaSh0BT4K14lD0K+Ggofa6nJ23v6CQhcsB
	 43+iE2Snzu560Wb89g479A6tSD+DYZ3sV0skYDNukHNCr2tDcqkMZ0FfiOfqfpXbIz0Pe
	 YzCLMY1ynYnBDN6B/G2IQz+bEwGe2ZubNpCGsDYwocWbBkYlNwqP9mUcW7GHbFrpipE8d
	 4rsm3KISDMhcloehKJyrg1a1YQUNJJla76GupHsepRvZSlevgnn0qENaPP7MbO5KEJfHS
	 /I/7tJKouewJ9pV7q8AW4FbWyttOyw0drd/kEJ8CmNztkTPp5aVLJR0Iykw2E79RpjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=pgo3JHIg;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3171606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 14:08:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3171606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=pgo3JHIg
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 284311A1410;
	Mon,  2 Nov 2026 14:08:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E8E2660750;
	Mon,  2 Nov 2026 14:08:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8764210328C5E;
	Mon,  2 Nov 2026 15:08:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793628487; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=1XXS1yBXm7iXcmQ6DOH8yooQHsnJf+YUASejRax8G7w=;
	b=pgo3JHIg/PSfAriRcsT0Aa5RkhhoM/DSEn6FnyIB8OK3h1A5qkSLfvvT8VYS7n+oVW6ztm
	B9uPw+DMpzxLN2rya0bD50OxII0ur9DLxGN1Oe5aqVLiGIQ1+B0Euk9Jg12HgxF+5Q1ejS
	i9v6LfPXqmqMoGEucANQtoMEIOE0mfsus1X+myUe9QSCHBFXbUGYYVdE6Bfw1DxC+lHPqo
	rjDC33zf8YwNEbZrh+1KQbqPqz1ZfYJIx9mknYM4kbAgsKvhFErA0LvsfsdKkUK211SX+4
	qqdZ8BMHep+Uw5zOd5jtKlqZVJgkiXdnO1JKxucOrjz+rd3czBWRU107yUFVrw==
Message-ID: <b11e5cf0-7cbb-47f4-8d73-664ea2e5da0b@bootlin.com>
Date: Mon, 2 Nov 2026 15:08:03 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [RFC PATCH net-next] net: pse-pd: Don't be a regulator provider
To: Kyle Swenson <kyle.swenson@est.tech>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20261020-pse_regulator_fixes-v1-1-fd6084a22cba@est.tech>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261020-pse_regulator_fixes-v1-1-fd6084a22cba@est.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Thanks you for this work!

On 10/20/26 21:27, Kyle Swenson wrote:
> Commit ffef61d6d273 ("net: pse-pd: Add support for budget evaluation
> strategies") introduced an unusual regulator usecase- that is, a device
> that's both a consumer and provider of the same regulator: every PI is
> registered as a regulator whose "vpwr" supply is also requested by the
> PSE core for the power domain.

The unusual usecase was not introduced in that commit but in the initial 
support for PoE. With Oleksij, we initially thought that a PSE PI is 
something providing power therefore it look like a regulator provider 
behavior. In that case if we nest PSE PI and the regulator framework, 
the featured added for the PSE PIs could improve regulator framework and 
feature already supported by the regulator could be useful for the PSE 
PI case. Due to this idea, we had nested the frameworks and each PSE PI 
register a regulator provider. The thing is that there is no device that 
could represent the regulator consumer, the real device is the PD 
plugged on the Ethernet port but it is not represented by the software.
Finally we end up with this unusual usecase to have each PSE PIs to be a 
regulator provider and its own consumer.

However along the development no advantage of using such usecase 
appeared except for the power budget, but it is different because it is 
related to the PSE PI supply parent not the PI itself. This is the 
"vpwr" supply described in the binding.
This usecase was for now, only adding code complexity, function wrapper, 
and several deadlock issues as you have described below.

> This ended up causing a significant amount of complication for the PSE
> core, and can result in an ABBA deadlock that lockdep doesn't see.  The
> deadlock can happen when PSE ops are running concurrent with the
> pse_isr, and I noticed it when a PoE port is enabled via ethtool and
> that PoE port has a device that is ready to be powered.
> 
>    - As a regulator provider, PSE's ops (is_enabled, enable, disable, ...)
>      take pcdev->lock while the core already holds the regulator lock
>      (regulator lock -> pcdev->lock).
> 
>    - As a consumer of the power-budget API, pse_isr(),
>      pse_ethtool_set_pw_limit() and pse_ethtool_set_prio() call
>      regulator_request/free_power_budget() (which take the supply's regulator
>      lock) while holding pcdev->lock, from contexts that are not regulator
>      callbacks (pcdev->lock -> regulator lock).
> 
> And this can deadlock because the locking order between pcdev->lock and
> the regulator lock is inverted in the two paths.
> 
> Lockdep doesn't flag this deadlock because regulator_lock_nested() takes
> the lock via ww_mutex_trylock(), and apparently lockdep doesn't record a
> dependency for a trylock.  However, if the trylock is adjusted to always
> block, lockdep does report the ordering violation.
> 
> One way to fix this complication is to not register a regulator provider
> per PI and reduce the pse_core's usage to only be a regulator consumer.
> The regulator core used to provide some behaviour as a side effect of
> the PI regulator, which the PSE core now does itself:
> 
>    - Enabling a PI enabled its "vpwr" supply, and a PI found enabled when
>      its control was acquired took a reference on it. Each PI now tracks
>      whether it holds an enable reference on the power domain supply.
> 
>    - The "vpwr" supply was resolved from the PI node, then from the
>      controller node. It is now requested with of_regulator_get() from
>      the same nodes, and power domains are matched on the provider node
>      rather than with regulator_is_equal().  Consequently, PSE_CONTROLLER now
>      depends on OF.
> 
>    - A supply whose provider has not registered yet still leaves the PI
>      without a power domain, as before. pse_control_get() used to return
>      -EPROBE_DEFER until that supply resolved, since getting the PI
>      regulator resolved its supply; it now succeeds right away.
> 
>    - A failing hardware disable is still not reported, and the supply
>      reference is still released, as the regulator disable callback did.
> 
>    - A failing regulator_disable() of the supply is not retried, as with
>      the regulator devres helpers: the regulator core may already have
>      dropped the consumer's enable reference when it reports the error.
> 
> User visible changes:
> 
>    - pse_ethtool_set_pw_limit() hands the limit in mW straight to
>      pi_set_pw_limit(). A controller without pi_set_pw_limit() now
>      returns -EOPNOTSUPP, where it used to return -EPERM once the PI voltage
>      had been read.
> 
>    - The PI regulators no longer show up in the regulator sysfs and
>      debugfs, and over-current and over-temperature events are no longer
>      sent on a regulator notifier chain. The ethtool notifications are
>      unchanged.
> 
> Fixes: ffef61d6d273 ("net: pse-pd: Add support for budget evaluation strategies")

Not sure we should write this as a fix as it is a big change of the 
framework and it is related to the initial support for the PoE.

Also as it is a big rework it is hard to read. Could you split this 
patch in a series?
You could first add the new helpers, then replace the call for regulator 
consumer functions in the ethtool functions, then remove the regulator 
provider.
If needed, you can add "#if 0" around regulator specific call for the 
purpose of having more readable patch. Of course they should be removed 
at the end of your series.

After a quick look this seems good.
You can also remove the pse_send_ntf_worker() and send notification 
directly in the irq_handler.

> Signed-off-by: Kyle Swenson <kyle.swenson@est.tech>
> ---
> RFC: I'm posting this RFC to discuss how the ABBA deadlock in the PSE
> core should be fixed.  The deadlock was pointed out by Sashiko in [1],
> and I've hit it in testing [2]:
> 
>    > This isn't a bug introduced by this patch, but choosing the static
>    > budget strategy exposes a lock ordering problem that already exists in
>    > the PSE core.
>    >
>    > pse_isr() holds pcdev->lock and ends up taking the supply regulator
>    > lock [...] An admin enable running at the same time takes the locks in
>    > the opposite order [...] The ww_mutex scheme cannot break a cycle
>    > that includes the plain pcdev->lock mutex.
> 
> With no PI regulator, nothing takes pcdev->lock from inside a regulator
> callback, so only the pcdev->lock -> regulator lock order remains.
> 
> This RFC is one approach of probably several possible ways to fix the deadlock.
> That said, after exploring this approach, I've found several other problems
> others have hit in their drivers on the list get fixed as a result:
> 
> Setting a power limit on an unpowered port fails
> ------------------------------------------------
> 
> The core needs a port voltage to turn mW into uA for the regulator
> API [3]:
> 
>    >     netlink error: Can't calculate the current, PSE voltage read is 0
>    >     netlink error: Result not representable
> 
> Kory's suggestion was that pi_get_voltage should not return 0 [4]:
> 
>    > To have this working the pi_get_voltage should return some value
>    > even with no PD plugged.
> 
> The Realtek PSE MCU driver already works around it this way [5]:
> 
>    > core: return constant voltage when MCU reports zero, in case the
>    > port is not delivering. This avoids "Voltage null" errors in case a
>    > power limit is set while port is not delivering (Sashiko)
> 
> The limit is now handed to pi_set_pw_limit() in mW, so no voltage is
> needed and pi_get_voltage has no remaining user in the core.
> 
> Overflow and precision loss in the mW -> uA -> mW conversion
> ------------------------------------------------------------
> 
> The conversion can overflow on drivers that report a measured
> voltage [6]:
> 
>    > For the largest allowed limit, 99900 mW, that overflows below about
>    > 46.5 mV. Only 0 V is rejected, and si3474 reports the measured
>    > voltage of each port. A negative result then hits the BUG_ON() in
>    > regulator_check_current_limit().
> 
> The conversion is removed, along with pse_pi_get_current_limit(), so
> the possibility of losing precision on the way back to mW is gone too.
> 
> Use-after-free in the PI regulator ops
> --------------------------------------
> 
> The PI regulator ops can run after the PI array is freed [7]:
> 
>    > When regulator_unregister() flushes a pending disable, the
>    > regulator core invokes pse_pi_disable(), which dereferences
>    > pcdev->pi[id] [...] At that point the PI array is already freed, so
>    > this is a use-after-free.
> 
> The PI regulator and its ops are removed.
> 
> Regulator enable count out of step after a failed disable
> ---------------------------------------------------------
> 
> pse_pi_disable() always returns 0, so the regulator's enable count
> gets out of step with the PI state after a failed disable [8]:
> 
>    > a further disable attempt calls regulator_disable() with
>    > use_count == 0, which the regulator core rejects with a WARN and
>    > -EIO.
> 
> Each PI now tracks its own enable reference on the power domain supply.
> A failed hardware disable is still not reported, as before.
> 
> PI lookups returning -EPROBE_DEFER after registration
> -----------------------------------------------------
> 
> PI lookups can keep returning -EPROBE_DEFER after the controller has
> registered, because pse_control_get() goes through the PI regulator
> [9]:
> 
>    > A PI lookup in that window still returns -EPROBE_DEFER:
>    >
>    > pse_control_get_internal()
>    >   regulator_get_exclusive()
>    >     _regulator_get_common()
>    >       regulator_resolve_supply()
> 
> pse_control_get() no longer gets a regulator. A PI whose supply has not
> registered yet is still left without a power domain, as before.
> 
> Power domain matching
> ---------------------
> 
> Power domains are now matched on the provider's DT node instead of
> regulator_is_equal() on the rdev->supply.

Yes thanks for listing all these issues, that was kind of all the ones I 
had in mind to express my wish to remove the support for the PIs regulator.
I can add also that we can also remove the pse_send_ntf_worker() 
function and synchronize the ethtool notification with the PSE interrupts.

> Drawbacks
> ---------
> 
> Maybe some drawbacks of the approach (but I'm biased, so hopefully
> others can point out more severe problems):
> 
>      * PI regulators are dropped from sysfs/debugfs
>      * There is now a hard dependency on OF.  I'm not sure if this
>        matters, since there's not a PSE driver with ACPI match tables in
>        the tree.  Perhaps if one is added, the supply lookup can be reworked at
>        that point.
> 
> The broader trade-off of dropping the PI regulator was discussed in
> [10], [11] and [12].
> 
> Finally, while this is fixing a deadlock I've hit pretty often in
> testing, and has a "Fixes" tag, to me it's adjusting an intentional
> design point of the PSE core, which implies it's a new change.  I don't
> have a preference either way, and it doesn't matter for RFC.
> 
> [1] https://lore.kernel.org/netdev/179080386247.434549.15817042587071985098@kernel.org/
> [2] https://lore.kernel.org/netdev/asM8rcKC1n1Tn4JD@est-xps15/
> [3] https://lore.kernel.org/netdev/20260820142429.2285172-1-kyle.swenson@est.tech/
> [4] https://lore.kernel.org/netdev/41dd51e5-ac20-48b5-9e7c-4d2d261f3402@bootlin.com/
> [5] https://lore.kernel.org/netdev/20260728084307.2129515-1-jelonek.jonas@gmail.com/
> [6] https://lore.kernel.org/netdev/20261018082314.48950-11-github@szelinsky.de/
> [7] https://lore.kernel.org/netdev/20260813200653.980170-3-github@szelinsky.de/
> [8] https://lore.kernel.org/netdev/20260818162606.3981504-1-kuba@kernel.org/
> [9] https://lore.kernel.org/netdev/179239893933.3135.9046263155258328713@kernel.org/
> [10] https://lore.kernel.org/netdev/bb8eaf92-2b5b-46a1-b39d-a29ae273a3b5@bootlin.com/
> [11] https://lore.kernel.org/netdev/atb-3EIJynaRwuwe@pengutronix.de/
> [12] https://lore.kernel.org/netdev/0378ccc3-4807-4d63-8e61-03b465952929@bootlin.com/
> ---

...

> +/**
> + * pse_pi_supply_np - node the "vpwr" supply of a PI is looked up from
> + * @pcdev: a pointer to the PSE controller device
> + * @id: index of the PSE PI
> + *
> + * The PI regulator used to resolve its "vpwr" supply through
> + * regulator_resolve_supply(): first on the regulator device, whose node was
> + * the PI node, then on the parent device, the controller, whose own
> + * vpwr-supply is parsed before of_get_child_regulator() walks its children.
> + * of_regulator_get() walks the children of the consumer device, the
> + * controller, so the walk over the PI node's own children is not kept: a
> + * vpwr-supply in a child node of a PI is no longer found from that PI. The
> + * PI node is used only when it names a supply itself, because otherwise the
> + * child walk would answer from a sibling PI's supply before the controller
> + * node had its turn.

Not sure I understand it well but PI nodes do not have children. We 
should resolve the regulator for the PI node only, as described in the 
binding.

-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

