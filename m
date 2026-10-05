Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFEE379ED6;
	Mon,  5 Oct 2026 08:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187372; cv=none; b=IvVOg7CyW6hWfSLDFJ4Tp/AiarprBQRWGw2wdIacIoVKdcO2C7aKqJOWlE9evVf1+DRSWssrB/EpCZOfuoHxAIdpQLc6TkuAlH0xawG4Xh7L+VMMpZFAK8R8fyvOPwonrVHxSsAUnd5QBReV6geqEWhicbiCVldDZxCfXJubDRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187372; c=relaxed/simple;
	bh=c9PLKgT9PjUa5yu+bQ7vVgGGhEb2VwiD0sBt+bFpVDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgQkCk/l7oJ3I2+XUoH7uHfyllHlYdnxLPO5beRqaxhmXeYEU5zrJK0+ZiERebJ++Yl6JNNmulX3FRPhSF5/+qQLVV/Z0YZiWY0/6uIlbq453Wi4RTcextsxDHH/9ZoDqo7N/S3pa3AaNK45CC9PcnWtuAWb/j0wQC5c97No6NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz21t1791187298tcd9050ed
X-QQ-Originating-IP: 275tgGnNQCORTtpj8gN1J7Q8ETEtg+ZTJDkvgVieLtY=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 05 Oct 2026 16:01:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16061130098445531546
EX-QQ-RecipientCnt: 11
Date: Mon, 5 Oct 2026 16:01:36 +0800
From: Yibo Dong <dong100@mucse.com>
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yaojun@mucse.com
Subject: Re: [PATCH net-next v15 5/5] net: rnpgbe: Add link status handling
 support
Message-ID: <3B0F410B16397174+20261005080136.GC53018@nic-Precision-5820-Tower>
References: <0FD7535DB8A65243+20261004065947.225144-1-dong100@mucse.com>
 <179118576816.434549.7440017946535436802@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179118576816.434549.7440017946535436802@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: NWujniBqiFoNMUXMm/py4Me40QAC5YYSYuEisp8qODSY2Uz1ZHq7mh45
	fwTjzeOUPrgCVSjyUwXz/+aWDFfl+4ajLAE5ZYC+FE9kb/KYFOu8AkuqOD5zvQrmdK1winz
	8FLi162prB6Eg5Xf+l2DKrH33Kj2YmANvFzPIxlMGOtGjdKA/TLW+O99/Ad6cWiCHsw9KBx
	YY7Rz7wIG7Y2GXKEKqSKNK6UM/9ECCnzhe+QpgWcd1mYim63nzILnI+aGj1dD2KiXMw6m12
	uxvFBRXX7SwXs0LoNo5NDK6bFzAKf71hj8rFo1sfKrQPs0yVa3rvqf/sQM6EY8B2y7UwgK9
	9A1mWuMaHljNkklacQs00e+7pWoT/uwaDS2PqGFKTj6fhr3Z/3ty92T5jgbyQy6s6eEM7b7
	OMyGgQ6QyVZasgfzj4oprjyFREJ4dCPTY/aQxd0OUGzTA7PK24Uj3DDrfhEKLB3fWT8mSru
	W1EzkcW/fKfGQ0nLqZqq1zD/2gKq+p/xnnsh9W5v32gMah/JWdy2aEYixQ2X0mMCjb8ZmzQ
	8xwj9t1KOlKeXluVbsoGW4A0yf0AyQKJiE1to1lwJLKtdwfPQzY8sbG0KlkaxVmbp1dhEj3
	Kymyev6esYOg4ezi3ziwSf76AVkav9fY75XOgmFTdFiJEKP5p0A24a7za5C5gHlZk+dBfrk
	3rVjrJGOWlJH2L/X4Kgb3WUZSrG9oith3/zzSZPmK6K99rLK148e7TfP1Vv6S6qL28SZ2Ee
	EPvVfbP8b1zSDxPcMxU9YPWgv0ExNYR/nkAml/5wvFEZ01KnzdE3yDgPhupN/y7o7fk7l/B
	++Nm0UHmx3FUSnUuWX88+ox7skdtuQZnStUL4XOmI8oVBA30pJqf64zh7kbXFdQD4G/hda1
	vtsMwkpku+gc66gboIPKPU/DDz2I+4zQEpigwnSrbqOI3HSGRpFJQrh1tAfFBuKXT83dOrm
	Asnx1GpjYgq0MizAxxTMc07k7tr1Nh74Savo5kTkbndiQLUuop+cbzhKnFaoaYTq5G+e4en
	ZVcMqjIhhUqI1/41TlkOXfqLsOS/0uj+ix/EK8yx+xo8ieLPEM6DWGaSQjTIU3ndLtLdL5j
	0Wt4otcCY55uMov0m+8vHc=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

On Mon, Oct 05, 2026 at 07:36:08AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 � High: 0 � Medium: 1 � Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] Only two PF-to-firmware command senders follow the mailbox
>   rule this patch documents.
> 
> --
> 
> net: rnpgbe: Add link status handling support
> 
> This commit adds handling of firmware link events for the rnpgbe driver.
> Link events arrive over the mailbox and a service task updates the
> carrier state. It also sends SET_PHY_UP and LINK_REPORT_EN on open and
> close, and adds a PHY_LINK_SET command at probe that fails probe if the
> firmware does not acknowledge it.
> 
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> > index 2310f01df1f50..ef00b948ad0f6 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> 
> [ ... ]
> 
> > + * On success the hardware mailbox remains locked. The caller must process
> > + * the event and call mucse_mbx_event_end() to acknowledge it and release
> > + * the hardware mailbox lock.
> > + *
> > + * Firmware releases the hardware mailbox lock before raising the event
> > + * interrupt and does not access the shared window again until the PF
> > + * acknowledges the event. Therefore, failure to acquire the lock indicates
> > + * a mailbox fault rather than transient contention.
> 
> [ ... ]
> 
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> > index e28f3193aa854..683e0ea741136 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> 
> [ ... ]
> 
> > +int mucse_mbx_set_link(struct mucse_hw *hw, u32 advertising, bool autoneg,
> > +		       u32 speed, u32 duplex, u32 mdix_ctrl)
> > +{
> 
> [ ... ]
> 
> > +	len = le16_to_cpu(req.r.datalen);
> > +	mutex_lock(&hw->mbx.lock);
> > +	err = mucse_write_and_wait_ack_mbx(hw, req.dwords, len);
> > +	mutex_unlock(&hw->mbx.lock);
> 
> [Severity: Medium]
> Could a pending LINK_CHANGE_EVT stop the firmware from picking up this
> command, or the POWER_UP command?
> 
> The kernel-doc of mucse_mbx_event_begin() says firmware does not touch
> the shared window until the PF acknowledges the event. Only
> mucse_mbx_phyup() and mucse_mbx_link_report() send through
> mucse_write_mbx_coalesce_event(), which calls mucse_ack_pending_event()
> first.
> 
> mucse_mbx_set_link() and mucse_mbx_powerup() go through
> mucse_write_and_wait_ack_mbx()->mucse_write_mbx_pf(). That path writes
> FWPF_SHM and bumps pf_req without checking FW2PF_CNT for an event that
> has not been acknowledged.
> 
> At teardown, rnpgbe_down() only warns if LINK_REPORT_EN(0) fails:
> 
>     err = rnpgbe_send_notify(hw, false, mucse_fw_link_report_en);
>     if (err) {
>         ...
>         dev_warn(&hw->pdev->dev, "Fw will still report link event\n");
>     }
> 
> The following SET_PHY_UP(0) drops the link, so firmware can post
> LINK_CHANGE_EVT. Then rnpgbe_rm_adapter() and rnpgbe_dev_shutdown() do:
> 
>     rnpgbe_free_mbx_irq(mucse);
>     rnpgbe_notify_powerdown(mucse);
> 
> rnpgbe_free_mbx_irq() frees the IRQ and cancels mbx_work. Nothing
> acknowledges the event, and POWER_UP(0) goes out on the
> non-coalescing path.
> 
> At probe, the driver never turns link reporting off. Suppose reporting
> was left enabled by a previous instance, for example after a crash or
> kexec with the interface up, and RESET_HW does not clear it. The new
> PHY_LINK_SET restarts autonegotiation, so an event could be posted
> while set_link or get_macaddr is in flight. Also, mucse_mbx_reset()
> treats an event that is already pending as consumed:
> 
>     val = mbx_data_rd32(mbx, MUCSE_MBX_FW2PF_CNT);
>     hw->mbx.fw_req = FIELD_GET(GENMASK_U32(15, 0), val);
> 
> If the firmware rule holds, the PF would wait out the mailbox ack
> timeout. At remove or shutdown that gives "Send powerdown to hw
> failed". At probe, the error from rnpgbe_setup_default_link() now
> fails the probe.
> 
> Should every PF-to-firmware sender acknowledge a pending event first,
> the way mucse_write_mbx_pf_coalesce_event() does? Alternatively,
> should a pending event be drained before these commands are sent?
> 
Same feedback with v14.
I think no need to handle this. rnpgbe_down only warns is because driver
should release memory for tx/rx even with a mailbox error.
After a system crash, the PCIe reset performed during system
initialization causes firmware to clear the driver-loaded, port-up and
link-event-enable states.
During a normal driver probe, mailbox synchronization is performed before
RESET_HW and PHY_LINK_SET. If an unexpected pending event prevents
mailbox synchronization, probe fails rather than continuing with an
ambiguous mailbox state. The driver does not need to distinguish whether
that failure was caused by firmware or by stale mailbox state.
Therefore, after successful synchronization and reset, no asynchronous
event can be pending when mucse_mbx_set_link() (which is called even before
mailbox irq is registered) is called.

> > +
> > +	return err;
> > +}
> 
> [ ... ]
> 
> -- 
> Sashiko AI review � https://netdev-ai.bots.linux.dev/sashiko/#/patchset/B438B0A83ACCA2DE%2B20261004065604.224873-1-dong100%40mucse.com
> 
