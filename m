Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4ED37A85C;
	Mon,  5 Oct 2026 07:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791185770; cv=none; b=jn39ELfLiF/t+AtELAdfc4WHVdOyA2dZ665Q+k7rkeFggKEPXtn4y+W1medyPiejkuaK2tYIgl5Tq5jIb3ntEuqvtvvfR+aFlBlMLnUakETM0uJM+0uG5xlPzGQjlbj1Z9cF9WTHQ8AFBMdwEg/ecZmydiQ4J2fm/FBS3ayNASc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791185770; c=relaxed/simple;
	bh=YV/ViyhJ+egMq6qE/Z5S9GNbo5Ukq6eXG150/uM9Kyc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PD0p+WNfgEf5IxaG57VdrfQ9KTW0/SK5qC04tgYs2IVdr6V7f5wwGqr5Tv89vgj4LWU6yrelUb0ueKsy8lV0HIvsxOVRvC+IuCf/dxlCNKoQiJn1WYzHtgkbz59TsVC2Ch1R3Nsqq+u1dMTG0v+Tb6ZbyqdJ1OBm9u/Q3aQalvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqiPPlHU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqiPPlHU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B941F000FF;
	Mon,  5 Oct 2026 07:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791185769;
	bh=bf5kQbHXQqvwD5eXlquu0rrhNYozh9nHt2RR52WdqWg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JqiPPlHU0Sggpg8LGWjOnJGenhxPoHIjV19WRoVBDuOUVuSsTictdfboWtdO3Pt86
	 X//MNaljk8ybZku+AqgItChdSNKEoqLWL/ryrDyV4rUToNX7qp3hlJO6dVtMmbzKHH
	 hpVJaGgxX9qz19qXV/AyBgHU6QCQiH9emDE7UMEW9cX8NMuWwKjUx/vy1KWY9oQIwb
	 9gT0GFupV9OPeSrtTl/Z0jOhceBdsc4ymaRmP1b2B0qqDs5KxDWK6w4oOyH810ZZyY
	 5zmLqxmvyjuE5TK21whrVGdpWe4lMCJuiQ8E6G1H5nwy8WZBIWpmlRDwAun2FNzdkn
	 Re8+FW9u8i/HQ==
Subject:
 Re: [PATCH net-next v15 5/5] net: rnpgbe: Add link status handling support
From: netdev-bot+sashiko@kernel.org
To: dong100@mucse.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaojun@mucse.com
Date: Mon, 05 Oct 2026 07:36:08 +0000
Message-ID: <179118576816.434549.7440017946535436802@kernel.org>
In-Reply-To: <0FD7535DB8A65243+20261004065947.225144-1-dong100@mucse.com>
References: <0FD7535DB8A65243+20261004065947.225144-1-dong100@mucse.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Only two PF-to-firmware command senders follow the mailbox
  rule this patch documents.

--

net: rnpgbe: Add link status handling support

This commit adds handling of firmware link events for the rnpgbe driver.
Link events arrive over the mailbox and a service task updates the
carrier state. It also sends SET_PHY_UP and LINK_REPORT_EN on open and
close, and adds a PHY_LINK_SET command at probe that fails probe if the
firmware does not acknowledge it.

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> index 2310f01df1f50..ef00b948ad0f6 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c

[ ... ]

> + * On success the hardware mailbox remains locked. The caller must process
> + * the event and call mucse_mbx_event_end() to acknowledge it and release
> + * the hardware mailbox lock.
> + *
> + * Firmware releases the hardware mailbox lock before raising the event
> + * interrupt and does not access the shared window again until the PF
> + * acknowledges the event. Therefore, failure to acquire the lock indicates
> + * a mailbox fault rather than transient contention.

[ ... ]

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> index e28f3193aa854..683e0ea741136 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c

[ ... ]

> +int mucse_mbx_set_link(struct mucse_hw *hw, u32 advertising, bool autoneg,
> +		       u32 speed, u32 duplex, u32 mdix_ctrl)
> +{

[ ... ]

> +	len = le16_to_cpu(req.r.datalen);
> +	mutex_lock(&hw->mbx.lock);
> +	err = mucse_write_and_wait_ack_mbx(hw, req.dwords, len);
> +	mutex_unlock(&hw->mbx.lock);

[Severity: Medium]
Could a pending LINK_CHANGE_EVT stop the firmware from picking up this
command, or the POWER_UP command?

The kernel-doc of mucse_mbx_event_begin() says firmware does not touch
the shared window until the PF acknowledges the event. Only
mucse_mbx_phyup() and mucse_mbx_link_report() send through
mucse_write_mbx_coalesce_event(), which calls mucse_ack_pending_event()
first.

mucse_mbx_set_link() and mucse_mbx_powerup() go through
mucse_write_and_wait_ack_mbx()->mucse_write_mbx_pf(). That path writes
FWPF_SHM and bumps pf_req without checking FW2PF_CNT for an event that
has not been acknowledged.

At teardown, rnpgbe_down() only warns if LINK_REPORT_EN(0) fails:

    err = rnpgbe_send_notify(hw, false, mucse_fw_link_report_en);
    if (err) {
        ...
        dev_warn(&hw->pdev->dev, "Fw will still report link event\n");
    }

The following SET_PHY_UP(0) drops the link, so firmware can post
LINK_CHANGE_EVT. Then rnpgbe_rm_adapter() and rnpgbe_dev_shutdown() do:

    rnpgbe_free_mbx_irq(mucse);
    rnpgbe_notify_powerdown(mucse);

rnpgbe_free_mbx_irq() frees the IRQ and cancels mbx_work. Nothing
acknowledges the event, and POWER_UP(0) goes out on the
non-coalescing path.

At probe, the driver never turns link reporting off. Suppose reporting
was left enabled by a previous instance, for example after a crash or
kexec with the interface up, and RESET_HW does not clear it. The new
PHY_LINK_SET restarts autonegotiation, so an event could be posted
while set_link or get_macaddr is in flight. Also, mucse_mbx_reset()
treats an event that is already pending as consumed:

    val = mbx_data_rd32(mbx, MUCSE_MBX_FW2PF_CNT);
    hw->mbx.fw_req = FIELD_GET(GENMASK_U32(15, 0), val);

If the firmware rule holds, the PF would wait out the mailbox ack
timeout. At remove or shutdown that gives "Send powerdown to hw
failed". At probe, the error from rnpgbe_setup_default_link() now
fails the probe.

Should every PF-to-firmware sender acknowledge a pending event first,
the way mucse_write_mbx_pf_coalesce_event() does? Alternatively,
should a pending event be drained before these commands are sent?

> +
> +	return err;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/B438B0A83ACCA2DE%2B20261004065604.224873-1-dong100%40mucse.com
