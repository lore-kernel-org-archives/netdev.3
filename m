Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274711;
	b=VHR2U1HDtF/zcd1eejb9fR5HvBLgtRYE7S3rrGwoGDNPrwRWmxoYKgPZT4fzOjXupQkQ
	 nSrJsd6oRXtGRTplvntxdkwriWWnoRovA7jNnoUQPaopE+TR7Eg7xNwRae1xCsCtyc6tI
	 SmE7hZc1DZqP6t+2DoZoj+KCGIIAe7RlRrH0no08EGT4FfefZOF6HpNgsQsNgUhAl7SE4
	 MEr+DR11BUqgWWr3NJv1RNG0slAlqt81l/2ql/b6fW6ItPdjFzRuUT4m6DZ9j6bQvXdV4
	 AWYeHM9NMN878+qYw4bFG10YyDfg+jT8u2b7zsxPI59tnyeG9NsCHKydBDsuhW/yhOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274711;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Su/uMX+ApZIjipiA8KePgZGhQr+mwH/KvKqJqOZRBlU=;
	b=fbhblBnitY54f9iH7k9HCrweXBg2fgv+VgqNC4AUS4VDsVzzU+SubuSpi6ClfOVgGVEI
	 +PD0H/ePSwd5/UQtmgfqWD33j0XIDn7dVIvdZY+EfFFnKZq4IZKtp/lAKTOxF6be9tBu7
	 SUWYCpqCfDa7hvmBPdDAXpwM62BBM9oiBsHSUKX938AKFLWyNvr6A4z7afd16tgr28XTb
	 1EdZI8xK9X3WSikDN1nPEjJnBqFnqnu2pFT6hYAFy0HCTsEjFS+xgVtP26NsyXdFOCMcf
	 uyUd1WTdY1dw7A1GeoydgqGKV7dRMhPQ+6Tluwap+xiSHH0jlgi269e+DEmtgAM7ejQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cdnEq3Zp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F37F60A2634;
	Tue, 10 Nov 2026 01:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cdnEq3Zp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35751F008A1;
	Tue, 10 Nov 2026 01:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274710;
	bh=Su/uMX+ApZIjipiA8KePgZGhQr+mwH/KvKqJqOZRBlU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cdnEq3Zp/Gqo8U6RBnHlSxZ9mf3/ARX0MXfVpAHwgIQ/bQ71J0thFuUB3B4/0Q21Q
	 y0i7ottg+dIprxQvL52M+7dSjR9WPbxFYXIMHjYAiFqUj/hvzUBX5iBjmOU3rnMqDh
	 5Ywf5mJrvIs9gfOUtmv/k06PGEiLAlwJ8kFby5xlVIel02jxhKup72UNQYOKu7QyVf
	 Fl6iEpaVDe7+Sact1eQYwHjd8AHwmBbryTALcKYzqmyXKf/bJI8n31w/F6VvDZRBcf
	 BvmrPgpg7hrKNiMEMfuXGxxaXUqi4srbTcWBMzqEfKyCvbQgM4hRC9ed44KTlVCCqV
	 EfLPnYIMYxW1w==
Subject: Re: [PATCH net-next v20 01/13] phylink: Add phylink_mac_interrupt
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, chenhuacai@kernel.org, kernel@xen0n.name,
 edumazet@kernel.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 neuromoments@gmail.com, beganovic.emir@gmail.com
Date: Tue, 10 Nov 2026 01:38:29 +0000
Message-ID: <179427470922.994134.16776316201780098943@kernel.org>
In-Reply-To: <20261106-ax88179a-v20-1-37b5a1189983@birger-koblitz.de>
References: <20261106-ax88179a-v20-1-37b5a1189983@birger-koblitz.de>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] phylink_mac_interrupt() (drivers/net/phy/phylink.c:1629-1637)
  loads pl->phydev with no lock, no RCU and no reference, then calls…
- [Low] phylink_mac_interrupt() reads pl->phydev with a plain load (`phy
  = pl->phydev;`) and no lock.

--

phylink: Add phylink_mac_interrupt

This commit adds phylink_mac_interrupt(), an exported wrapper that passes a
link-change interrupt received by the MAC to phylib by calling
phy_mac_interrupt() on the PHY attached to the phylink instance. It is meant
for drivers that want to stop polling the PHY.

> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index e885da1c28311..a87eaa2f3db5b 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -1616,6 +1616,26 @@ static bool phylink_link_is_up(struct phylink *pl)
>  	return pl->netdev ? netif_carrier_ok(pl->netdev) : pl->old_link_state;
>  }
>  
> +/**
> + * phylink_mac_interrupt() - wrapper for phy_mac_interrupt()
> + * @pl: a pointer to a &struct phylink returned from phylink_create()
> + *
> + * Passes a link-change interrupt received by the MAC to phylib.
> + * This function may be called in interrupt context, and therefore cannot take
> + * a mutex. However, it is safe to assume that the reference to phy does not
> + * disappear during the call, as only an SFP module may be unplugged to make a
> + * PHY disappear. SFP modules however do not support interrupts.
> + */
> +void phylink_mac_interrupt(struct phylink *pl)
> +{
> +	struct phy_device *phy;
> +
> +	phy = pl->phydev;
> +	if (phy)
> +		phy_mac_interrupt(phy);

[Severity: Medium]
Is the lifetime argument in the kernel-doc above accurate? It says:

  "it is safe to assume that the reference to phy does not disappear
  during the call, as only an SFP module may be unplugged to make a PHY
  disappear. SFP modules however do not support interrupts."

phylink_disconnect_phy() is not specific to SFP. Any MAC driver can call it
under RTNL at runtime, for example from ndo_stop or on unbind.

Also, the interrupt here comes from the MAC, not the PHY. Whether an SFP PHY
supports interrupts doesn't seem to matter, and phylink_mac_interrupt() has
no check on phy->is_on_sfp_module or phy->irq.

phylink_disconnect_phy() clears pl->phydev under locks that this IRQ path
never takes. It then stops the PHY without waiting for lockless readers:

drivers/net/phy/phylink.c:phylink_disconnect_phy() {
    ...
		mutex_lock(&phy->lock);
		mutex_lock(&pl->state_mutex);
		pl->phydev = NULL;
    ...
	if (phy) {
		flush_work(&pl->resolve);
		phy_disconnect(phy);
	}
}

Could this interleaving happen?

CPU0 (MAC IRQ)                 CPU1
phylink_mac_interrupt()
  phy = pl->phydev;
                               phylink_disconnect_phy()
                                 pl->phydev = NULL;
                                 phy_disconnect(phy)
                                   phy_stop_machine()
                                     cancel_delayed_work_sync(
                                         &phydev->state_queue);
  phy_mac_interrupt(phy)
    phy_trigger_machine()
      phy_queue_state_machine()
        mod_delayed_work(..., &phydev->state_queue, ...);

If so, state_queue gets re-armed after the cancel has already finished.

On SFP module removal, sfp_sm_phy_detach() frees the phy_device right after
the disconnect:

drivers/net/phy/sfp.c:sfp_sm_phy_detach() {
	sfp_remove_phy(sfp->sfp_bus);
	phy_device_remove(sfp->mod_phy);
	phy_device_free(sfp->mod_phy);
	...
}

sfp_remove_phy() reaches phylink_disconnect_phy() through
phylink_sfp_disconnect_phy(), and phy_device_remove() does not cancel
state_queue. Would this leave a delayed work queued inside a freed
phy_device? On the non-SFP paths, it would restart the state machine on a
stopped, detached PHY.

The only caller in this series, ax88179a_status(), does not seem to hit
this today. usbnet_stop()->usbnet_status_stop() kills the interrupt URB
before ax88179a_unbind() disconnects the PHY.

This is an exported, generic API, though. Should the kernel-doc tell
callers to quiesce their interrupt source before calling
phylink_disconnect_phy()? Or should phylink synchronize this itself, for
example with RCU and a grace period before phy_disconnect()?

[Severity: Low]
pl->phydev is read here with a plain load and no lock held.
phylink_bringup_phy() and phylink_disconnect_phy() write it with plain
stores under phydev_mutex and state_mutex. Will KCSAN report this as a data
race?

Without READ_ONCE(), the compiler may also reload pl->phydev after the NULL
check. The pointer passed to phy_mac_interrupt() could then differ from the
one that was tested. If a writer stored NULL in between, could
mod_delayed_work() end up called on &NULL->state_queue?

The current caller, ax88179a_status(), does not race with connect or
disconnect. Even so, would READ_ONCE() (or rcu_dereference()) here, paired
with WRITE_ONCE() (or rcu_assign_pointer()) in the writers, be appropriate?

> +}
> +EXPORT_SYMBOL_GPL(phylink_mac_interrupt);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106-ax88179a-v20-0-37b5a1189983%40birger-koblitz.de
