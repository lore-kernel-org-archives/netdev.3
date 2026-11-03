Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793750017;
	b=U1t82Ij0TV28U+1ed7GjPasvwvT9qBOseBu3UPrSzYdBP63ntxPS97UOH2pYJRDMsdSJ
	 n9aqNjxwVRE/zQMOLtKo6LCpGAZkufk0IFejfvtLsHH6JNUXVfwZBSH+WGyI+eB8PwO9i
	 0Tk4oWuX2Plbrp//xhNKy7kiq/E5qX/wcUkQ9d5P+Zwql/9Bzu5IvyGVD5PDAkfNj3t47
	 1PODnoKtoU5AoC+P10s/c0EWcAj2s6TPf278UAn/eGK6g0F41aOEqphAJesn7fELlnlmT
	 Fd0doto1Wcmsl+KDHW0FCTwOG+/xzHMQpEbZZB89rGGMwJK2uTXI9TfD/hnUyKlFFsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793750017;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=FCxDyXzDC9Nna1mQ+atYpDFv5LRrgLZY5FChqGmM6cQ=;
	b=s2me1nAoJ1sNL5jdCz9pJeaI6C+UrEd0RK3/4HqP9vhzG+vEC6Y2q2z4KMYqV2uTq1Jx
	 THyGyfG8lUPxlziirS93Cb8wiEZMFq61rKnjhyLdqPsoTw4oQrD05DHY0tF/FuJf9Q7H9
	 A07Kti/vEl42D9i/zcIzRV9N78wMvihX75R8p0E2ILCBl1WtYcgUMIRLRq/WT/exuahqi
	 xy4XvJpyLpfPWqaYjyhpdPNl1leQA4W42j1BnCBusA8oJbWliWG+ogEl5VrWPA7pVeAW/
	 9jMC+jGnDx2wP9b75flGjH+0fxzzZD/h+MuPgIxPAim8IBZJHcqQ5TRNm+7JouABbwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PSCN4g9T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD01C606A31B;
	Tue,  3 Nov 2026 23:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PSCN4g9T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918341F000C1;
	Tue,  3 Nov 2026 23:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793750016;
	bh=FCxDyXzDC9Nna1mQ+atYpDFv5LRrgLZY5FChqGmM6cQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PSCN4g9TuMDimXIzqf114a9G+Iyk8iCulvyK98N/g9ZiEhHBlZkFgdqC+Rl4zYeHI
	 mvddaeAFCFKfu8pNgkgWmQcP8TZmcpRWhNc8CaHQPbeL5205KfoNNLHGU+l2wCXO1T
	 NI/XaHoHlHE8zfE7iO6bTszz6ehviQSxHLJmcaUBWQjPInzbXvUK0yQ9C95HMVFI7f
	 jStlkwywjo4tXpLyCCf8yqpw2/PGnLEYquUwYRZHDkqPfkhONBTqfy8ypSNgaOyx2T
	 nfkh35Gd3lDqBERgrvmhUAovyoq7zsrE4Cznk8VaobxBqAy+B429cNWx0+yXOMaC1n
	 s+p50vC4xwReg==
Subject:
 Re: [PATCH net] net: usb: lan78xx: resume phylink on non-reset USB resume
From: netdev-bot+sashiko@kernel.org
To: stefanomunari.sm@gmail.com
Cc: Thangaraj.S@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 o.rempel@pengutronix.de, rmk+kernel@armlinux.org.uk, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 03 Nov 2026 23:53:35 +0000
Message-ID: <179375001506.488856.4516083483989818643@kernel.org>
In-Reply-To: <20261102235133.23011-1-stefanomunari.sm@gmail.com>
References: <20261102235133.23011-1-stefanomunari.sm@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 3 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] RTNL self-deadlock.
- [Medium] Self-hang caused by re-entering runtime PM from inside the USB
  resume callback.
- [Medium] On a normal (non-reset) resume, phylink is now restarted after
  the MAC datapaths are already enabled.
- [Low] Check-then-act race (TOCTOU) between the dev_open snapshot and
  phylink_resume().

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  lan78xx_suspend() inverts the lock order.

--

net: usb: lan78xx: resume phylink on non-reset USB resume

This moves the phylink_resume() call out of lan78xx_reset_resume() and
into the end of lan78xx_resume(). Both resume paths go through that
function, so phylink is restarted on a plain USB resume as well (e.g.
s2idle). The call is made only when the resume succeeded and the
interface was open.

> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index 181e8c087655c..0136818e8cb02 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -5371,6 +5371,12 @@ static int lan78xx_resume(struct usb_interface *intf)
>  out:
>  	mutex_unlock(&dev->dev_mutex);
>  
> +	if (!ret && dev_open) {

[Severity: Low]
Is the dev_open snapshot still valid by the time RTNL is taken?

dev_open is read under dev->dev_mutex. The mutex is then dropped, and
phylink_resume() is called on the strength of the old value without
checking EVENT_DEV_OPEN again.

lan78xx_stop() runs under RTNL, takes dev_mutex, clears EVENT_DEV_OPEN and
calls phylink_stop(). It could land in the gap between mutex_unlock() and
rtnl_lock():

  lan78xx_resume()                    lan78xx_stop() [rtnl held]
    dev_open = true
    mutex_unlock(&dev->dev_mutex)
                                        mutex_lock(&dev->dev_mutex)
                                        clear_bit(EVENT_DEV_OPEN, ...)
                                        napi_disable(&dev->napi)
                                        phylink_stop()
                                        mutex_unlock(&dev->dev_mutex)
    rtnl_lock()
    phylink_resume()
      phylink_start()

If that happens, phy_stop() warns because the PHY is still HALTED from
suspend. phylink and the PHY state machine are then started on a closed
interface, and lan78xx_mac_link_up() can call lan78xx_rx_urb_submit_all()
while NAPI is disabled. The next lan78xx_open() would call phylink_start()
again.

Userspace is frozen during system resume. However, netns cleanup runs on
netns_wq, which is not freezable, and it can close physical devices under
RTNL through default_device_exit_net() -> dev_change_net_namespace().

Would checking EVENT_DEV_OPEN again after rtnl_lock() close this window?

> +		rtnl_lock();

[Severity: Medium]
Can this rtnl_lock() deadlock when the caller already holds RTNL?

lan78xx_resume() is also the runtime resume callback. A runtime resume
runs synchronously in the context of whoever calls
usb_autopm_get_interface(), and several of those callers hold RTNL. For
example:

  __dev_ethtool()                 [rtnl_lock() held]
    lan78xx_get_stats()
      lan78xx_update_stats()
        usb_autopm_get_interface()
          rpm_resume(intf) -> rpm_resume(udev)
            usb_resume_interface()
              lan78xx_resume()
                rtnl_lock()

Other RTNL-holding callers of usb_autopm_get_interface() are
lan78xx_change_mtu(), the eeprom/wol ethtool ops and the phylib MDIO
accessor lan78xx_mdiobus_read().

A correctly opened interface holds an autopm reference until
lan78xx_stop(), so it shouldn't be able to runtime suspend. But
lan78xx_open() sets EVENT_DEV_OPEN before it submits the interrupt URB,
and it doesn't clear the bit when the submission fails:

drivers/net/usb/lan78xx.c:lan78xx_open() {
	...
	set_bit(EVENT_DEV_OPEN, &dev->flags);

	/* for Link Check */
	if (dev->urb_intr) {
		ret = usb_submit_urb(dev->urb_intr, GFP_KERNEL);
		if (ret < 0) {
			...
			goto done;
		}
	}
	...
done:
	mutex_unlock(&dev->dev_mutex);

	if (ret < 0)
		usb_autopm_put_interface(dev->intf);
	...
}

If autosuspend is enabled, the device can then runtime suspend with
EVENT_DEV_OPEN still set. On the next resume from an RTNL holder, which
can be an unprivileged ethtool -S, dev_open is true. The task then calls
rtnl_lock() on the mutex it already holds.

The stale EVENT_DEV_OPEN comes from an existing problem in
lan78xx_open(). Before this patch, though, only the .reset_resume path
took RTNL. Should the runtime resume path avoid taking RTNL here, or
should the lan78xx_open() error path be fixed along with this change?

> +		phylink_resume(dev->phylink);

[Severity: Medium]
Can phylink_resume() re-enter runtime PM from inside the USB resume
callback?

  lan78xx_resume()
    phylink_resume()
      phylink_start()
        phy_start()
          __phy_resume()
            genphy_resume()
              lan78xx_mdiobus_read()
                usb_autopm_get_interface()

lan78xx_mdiobus_read() and lan78xx_mdiobus_write() both start with:

	ret = usb_autopm_get_interface(dev->intf);
	if (ret < 0)
		return ret;

During a runtime resume, rpm_resume(intf) resumes the parent udev before
it marks the interface RPM_RESUMING. Inside usb_resume_interface() ->
lan78xx_resume(), the interface is therefore still RPM_SUSPENDED and the
udev is RPM_RESUMING.

The nested rpm_resume() on the parent waits uninterruptibly for the
parent to leave RPM_RESUMING. Only this same task can make that happen.

Resume paths that don't already hold RTNL, such as remote wakeup from
hub_wq or an async pm_wq resume, would hang after the new rtnl_lock(). In
that case RTNL stays held forever as well.

As with the rtnl_lock() comment above, this needs the stale
EVENT_DEV_OPEN left by a failed lan78xx_open(). A correctly opened
interface holds an autopm reference until lan78xx_stop().

The same hang already existed for runtime reset-resume, because
lan78xx_reset_resume() called phylink_resume() unconditionally. This
patch removes that case for closed interfaces, but adds it to the normal
.resume path whenever dev_open is set. smsc95xx dealt with the same kind
of problem by using _nopm MDIO accessors.

[Severity: Medium]
Does restarting phylink at this point run lan78xx_mac_link_up() while the
MAC datapaths are already enabled?

Earlier in lan78xx_resume(), lan78xx_start_tx_path() sets MAC_TX_TXEN_
and FCT_TX_CTL_EN_. The RX path is also still enabled, because
lan78xx_set_suspend() ends with lan78xx_start_rx_path() for wake
detection.

phylink_start() won't call mac_link_down() first, because phylink_stop()
already cleared the old link state during suspend. When the link
resolves, lan78xx_mac_link_up() does:

drivers/net/usb/lan78xx.c:lan78xx_mac_link_up() {
	...
	/* make sure TXEN and RXEN are disabled before reconfiguring MAC */
	ret = lan78xx_update_reg(dev, MAC_CR, MAC_CR_SPEED_MASK_ |
				 MAC_CR_FULL_DUPLEX_ | MAC_CR_EEE_EN_, mac_cr);
	...
	ret = lan78xx_flush_rx_fifo(dev);
	...
	ret = lan78xx_flush_tx_fifo(dev);
	...
}

and lan78xx_flush_tx_fifo() documents:

/* The caller must ensure the Tx path is stopped before calling
 * lan78xx_flush_tx_fifo().
 */

The reset-resume path already had this ordering. This patch adds it to
every normal .resume of an open interface. It may matter most when the
link comes back at a different speed or duplex.

Should the TX/RX paths be stopped before phylink_resume() here?

> +		rtnl_unlock();
> +	}
> +
>  	return ret;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but the commit message says the
new code mirrors lan78xx_suspend(). lan78xx_suspend() takes the two locks
in the opposite order from ndo_open/ndo_stop:

drivers/net/usb/lan78xx.c:lan78xx_suspend() {
	...
	mutex_lock(&dev->dev_mutex);
	...
		rtnl_lock();
		phylink_suspend(dev->phylink, false);
		rtnl_unlock();
	...
}

lan78xx_open() and lan78xx_stop() are called with RTNL held and then take
dev->dev_mutex. Suspend therefore uses dev_mutex -> rtnl_mutex, while
open/stop use rtnl_mutex -> dev_mutex.

Will lockdep report a possible circular locking dependency on the first
system suspend with the interface up?

An actual deadlock would need a non-frozen RTNL holder to open or close
the interface while lan78xx_suspend() holds dev_mutex and waits for
RTNL. Netns cleanup on netns_wq is one such holder.

The new resume code avoids the inversion because it drops dev_mutex
first. The suspend side still has the inversion, which came in with
e110bc825897 ("net: usb: lan78xx: Convert to PHYLINK for improved PHY and
MAC management").

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102235133.23011-1-stefanomunari.sm%40gmail.com
