Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC3446AA6B;
	Mon,  5 Oct 2026 09:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791194252; cv=none; b=Ruk+wwvA6dZUkSRdFP5mkGZDyhkdcJpIgChvzFAltyjghbkwgrR7qRO1NwDxDY1KjiW4oJIhlWJHtNq6EhoSpF+XvOBZKDdu0MFDzpbcb+P0ghTcyjjFoY+Gxzn8IXWdrT9+MwUEJVB8jr7TVfxd6qxxntOuq6SuUqFy3DLjKw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791194252; c=relaxed/simple;
	bh=FnI22gGZfCfDnHzk7lIriAXAe4me8S7bjYtdl6/1wEU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I26JnFO1lhZ8LBpfuIlsG1lAo3GQzSTN9Jk7KYembL4vOoBl5/aqTmydLPJ20eGGC1DmEy7Z9M4FQgtbFkQOE8uh1ie5rGRUw9Y4fucbpO6TT8mtV3yN5l8hbDRQ5X8MdaamixO4Sf0NoOUf5gzc+htIWKRFzfRP7gUJonSxctg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D84S1x0D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D84S1x0D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8E51F0089A;
	Mon,  5 Oct 2026 09:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791194245;
	bh=NMloAzR+2Pe7j3nmsr86QJ3LwaoDGv+9aAC9FOMghk0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=D84S1x0Ddo+/roD/d/kytkgxb4LRli8nTXi0rLSnP293ej+Z1izsSjjgv9N+1XZGP
	 +8X1it2v8hjxBKpirCHryFkK4RwTEjqvd3kn3KSXLYH4BwjUqMry4AjnbEx6KvjsD/
	 CJnds0HLDmbaz6BO9VSJJY6nv3hghhlzFTbHtKmhKYvhbCluvCcjI+nW8zpBUUwMtB
	 DwGhqC6sBBNu4M2AzXbdlqPVzsH+uTG/Xx7pBBPKwUqxh0USsZzqMsumfMbURNwm88
	 bPYfhUzLTHmYgsRbDaHX/3V8/EiXAuu3DwHk5Wg4Dfya7Zv2d41Vh0KChsoEOAW1ka
	 SLOphFqqMArNQ==
Subject: Re: [PATCH net-next v5 7/9] r8152: add TGPHY register access for
 RTL8157 and RTL8159
From: netdev-bot+sashiko@kernel.org
To: hsu.chih.kai@realtek.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch
Date: Mon, 05 Oct 2026 09:57:24 +0000
Message-ID: <179119424413.434549.4219292227441567313@kernel.org>
In-Reply-To: <20261001091144.28191-8-nic_swsd@realtek.com>
References: <20261001091144.28191-8-nic_swsd@realtek.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 (1) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] On RTL8157/RTL8159, a TGPHY busy timeout leaves the device
  dead with no recovery.
- [Low] The commit message does not match the error-handling changes in
  the diff.
- [Low] In rtl_tgphy_access(), a write sets TGPHY_CMD_BUSY|TGPHY_CMD_WR
  in USB_TGPHY_CMD and returns without waiting for BUSY to clear.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the TGPHY
  timeout adds another way to reach it.
- [Medium] read_mii_word(), the driver's mii_if_info.mdio_read callback,
  returns -ENODEV when RTL8152_INACCESSIBLE is set.

--

r8152: add TGPHY register access for RTL8157 and RTL8159

This commit adds rtl_ops.phy_read/phy_write hooks. RTL8157 and RTL8159
now use the USB_TGPHY_ADDR/DATA/CMD command channel for PHY access, and
older chips keep the OCP base switching path. The PHY accessors and the
helpers built on them now return int. A TGPHY busy timeout latches
RTL8152_INACCESSIBLE.

> The status is checked only where an errno would otherwise be taken for
> register content or reported as success: the pause parameters,
> rtl8152_set_speed(), SIOCGMIIREG/SIOCSMIIREG, the PHY patch handshake
> and the PHY firmware version checks.
>
> The remaining callers, notably the hw_phy_cfg and init sequences,
> r8153_phy_status(), r8152_mmd_read(), EEE handling and the MII library
> callbacks, still ignore the status and rely on the latch to stop
> further access.

[Severity: Low]
Does this description match the diff?

r8153_phy_status() now breaks out of its loop when ocp_reg_read() fails.
r8153_get_eee() now returns the errno to ethtool. r8156_eee_en() returns
early when its read fails.

rtl8152_get_link_ksettings() now returns an errno to userspace.
rtl8153_in_nway(), r8156_mdio_force_mode() and rtl8152_fw_phy_fixup()
also return early on failure.

So ETHTOOL_GLINKSETTINGS and ETHTOOL_GEEE can now fail with -ENODEV, and
the message does not mention either. Could the message be updated to list
these paths?

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index f805ef0763d70..be8b0db15033b 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c

[ ... ]

> @@ -1664,16 +1675,33 @@ static void ocp_reg_write(struct r8152 *tp, u16 addr, u16 data)

[ ... ]

> +static int r8152_mdio_read(struct r8152 *tp, u32 reg_addr)
> +{
> +	u16 data;
> +	int ret;
> +
> +	ret = ocp_reg_read(tp, OCP_BASE_MII + reg_addr * 2, &data);
> +
> +	return ret < 0 ? ret : data;
>  }

[Severity: Medium]
This is a pre-existing issue, but r8152_mdio_read() can now return a
negative errno. read_mii_word(), the mii_if_info.mdio_read callback,
passes that value straight to drivers/net/mii.c, which treats it as
register bits:

read_mii_word() {
    if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
        return -ENODEV;
    ...
    ret = r8152_mdio_read(tp, reg);
    return ret;
}

read_mii_word() already returned -ENODEV for a latched device before this
patch. The TGPHY timeout adds another way to reach that state.

In mii_nway_restart():

    bmcr = mii->mdio_read(mii->dev, mii->phy_id, MII_BMCR);
    if (bmcr & BMCR_ANENABLE) {

-ENODEV is 0xffffffed as a bit pattern, so BMCR_ANENABLE tests as set.
The function then calls write_mii_word() and returns 0.

Would rtl8152_nway_reset() and rtl_ethtool_set_eee() then report success
on a latched device? mii_ethtool_get_link_ksettings() would also build
link modes from the errno bit pattern.

[ ... ]

> @@ -1906,100 +1950,219 @@ static void ocp_byte_set_bits(struct r8152 *tp, u16 type, u16 index, u8 set)

[ ... ]

> +static int wait_tgphy_cmd_ready(struct r8152 *tp)
> +{
> +	u16 ocp_data;
> +	int ret;
> +
> +	ret = read_poll_timeout(ocp_read_word, ocp_data,
> +				test_bit(RTL8152_INACCESSIBLE, &tp->flags) ||
> +				!(ocp_data & TGPHY_CMD_BUSY),
> +				2000, 20000, false, tp,
> +				MCU_TYPE_USB, USB_TGPHY_CMD);
> +
> +	if (ret) {
> +		rtl_set_inaccessible(tp);
> +		dev_err(&tp->intf->dev, "TGPHY cmd busy timeout\n");
> +	}

[Severity: Medium]
Should this latch go through the same recovery as r8152_control_msg()?
That path sets PROBE_SHOULD_RETRY while probe is still running, and
otherwise queues a limited number of resets:

r8152_control_msg() {
    ...
    rtl_set_inaccessible(tp);
    if (!test_bit(PROBED_WITH_NO_ERRORS, &tp->flags)) {
        set_bit(PROBE_SHOULD_RETRY, &tp->flags);
        return ret;
    }
    ...
    if (tp->reg_access_reset_count < REGISTER_ACCESS_MAX_RESETS) {
        usb_queue_reset_device(tp->intf);
        tp->reg_access_reset_count++;
    ...
}

Here only rtl_set_inaccessible() is called. On RTL8157/RTL8159 this seems
to have a few effects.

A timeout during rtl_ops.init(), or in the hw_phy_work queued from
rtl8152_probe_once(), is not caught by the PROBE_SHOULD_RETRY check in
rtl8152_probe_once(). Probe then succeeds and registers a netdev that
cannot reach the hardware.

A timeout in r8157_hw_phy_cfg()/r8159_hw_phy_cfg() after
rtl_phy_patch_request(tp, true, true) makes the matching
rtl_phy_patch_request(tp, false, true) return -ENODEV immediately.
PATCH_REQUEST stays set, ALDPS and EEE stay disabled, and no reset follows
to undo it.

If the link is up when the latch is set, rtl_work_func_t() and
rtl_hw_phy_work_func_t() return early, so the carrier is never cleared.
bottom_half() also returns early, so TX packets are silently dropped.

rtl8152_start_xmit() only stops the queue when tp->tx_free is empty, and
tx_free is not empty here. So the watchdog never calls
rtl8152_tx_timeout(), and skbs keep building up on tp->tx_queue.

Only system resume (rtl8152_resume()->usb_reset_device()) or a replug
seems to bring the device back.

The commit message says recovery is a separate problem. Before this
patch, PHY access on these chips went through r8152_phy_read() and
r8152_phy_write(), where a failure came from r8152_control_msg() and
queued a reset. Could the TGPHY timeout reuse that handling instead of
going around it?

[Severity: High]
This isn't a bug introduced by this patch, but this timeout is another
way to latch the device without queuing a reset. That makes an existing
problem in the close path easier to reach.

When RTL8152_INACCESSIBLE is set, rtl8152_close() does:

    if (res < 0 || test_bit(RTL8152_INACCESSIBLE, &tp->flags)) {
        rtl_drop_queued_tx(tp);
        rtl_stop_rx(tp);
    } else {
    ...
    free_all_mem(tp);

rtl_disable() also returns early on INACCESSIBLE and skips the
usb_kill_urb() loop over tp->tx_info[i].urb. Are TX bulk-OUT URBs that are
still in flight ever cancelled on this path?

free_all_mem() then calls usb_free_urb(), which only drops a reference
while the HCD still holds its own. It also kfree()s
tp->tx_info[i].buffer. Can the host controller then DMA from the freed
buffer and send its contents to the device?

When such a URB later completes, write_bulk_callback() adds agg->list
back onto tp->tx_free. If the interface was reopened in between,
alloc_all_mem() has already reinitialised tx_free and added the same agg.
Could that double list_add corrupt tx_free?

Disconnect looks safe, because usb_unbind_interface() calls
usb_disable_interface() before ->disconnect. A plain ifdown does not have
that protection.

> +
> +	return test_bit(RTL8152_INACCESSIBLE, &tp->flags) ? -ENODEV : ret;
> +}
> +
> +static int rtl_tgphy_access(struct r8152 *tp, u16 addr, u16 *data, bool write)
> +{
> +	u16 cmd = 0;
> +	int ret;
> +
> +	ret = wait_tgphy_cmd_ready(tp);
> +	if (ret < 0)
> +		goto out;
> +
> +	if (write) {
> +		cmd |= TGPHY_CMD_WR;
> +		ocp_write_word(tp, MCU_TYPE_USB, USB_TGPHY_DATA, *data);
> +	}
> +
> +	ocp_write_word(tp, MCU_TYPE_USB, USB_TGPHY_ADDR, addr);
> +
> +	cmd |= TGPHY_CMD_BUSY;
> +	ocp_write_word(tp, MCU_TYPE_USB, USB_TGPHY_CMD, cmd);
> +
> +	if (!write) {
> +		ret = wait_tgphy_cmd_ready(tp);
> +		if (ret < 0)
> +			goto out;
> +
> +		*data = ocp_read_word(tp, MCU_TYPE_USB, USB_TGPHY_DATA);
> +	}

[Severity: Low]
For a write, the command is posted with TGPHY_CMD_BUSY | TGPHY_CMD_WR and
the function returns without waiting for BUSY to clear. The second
wait_tgphy_cmd_ready() only runs under if (!write).

If the PHY never finishes that write, the call still returns 0. The
failure only shows up as a timeout on the next PHY access.

The commit message says the status is now checked where a failure would
otherwise be "reported as success". These callers would still report
success for such a write:

  SIOCSMIIREG in rtl8152_ioctl():
      res = r8152_mdio_write(tp, data->reg_num, data->val_in);

  the final MII_ADVERTISE write in rtl8152_set_pauseparam()

  the final MII_BMCR write in rtl8152_set_speed() when BMCR_RESET is not
  set

In the last case, rtl8152_set_link_ksettings() then stores tp->autoneg,
tp->speed, tp->duplex and tp->advertising.

ocp_adv_write() posts writes the same way, so this matches existing driver
practice. Should TGPHY writes also wait for completion, so the reported
status covers the write itself?

> +
> +out:
> +	return test_bit(RTL8152_INACCESSIBLE, &tp->flags) ? -ENODEV : ret;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001091144.28191-1-nic_swsd%40realtek.com
