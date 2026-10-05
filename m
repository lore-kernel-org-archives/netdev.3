Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E616472F90;
	Mon,  5 Oct 2026 09:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791194254; cv=none; b=Cz3q/GY+a8zWzm8DWBifxc5A3HuzMWUwZvl2Y2BVM0uUpv7c4+mmEd3sOGVtP9xBTCM2YLGVhYgL88FnV+grPUXyvUslSX41u79D+P+m3apC00SZkg9m5hthtkUBs3AsYx0wbnwSRfDZqT4szPh6wR1k7p07moUXtmSjB3+HDwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791194254; c=relaxed/simple;
	bh=y1B/fnyYgO5ZK1Sc7OdJR0M6m5yCco54vA7djfsFc4g=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FgXmlYkmYvTV0nSb7zm2JQpN/7vBfuUQOjT2nqp5IF6YJZuTZfZIe2MG/HF4LLUNQyPUJX6qX5vuEDBe4g8f4zzXk5UYVGw9RjX39ZRc7r3dYEtjkZM7NcCmbh9X3XhUS5QMu9i5aznWOkd7VGsJihqYQ1i+xeAeIAXa2xDrzGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJzLQZn5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJzLQZn5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF781F0089B;
	Mon,  5 Oct 2026 09:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791194246;
	bh=OpABEf3G71G9Bqyz89H6k4NfzFLcR5gq2x/6QBtWSq0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FJzLQZn5RYsOlRLXc8IqRFdOuFI8y0bbzpkHx8oq6/nNbt/KyxfOVkJiwQ1b+Wfj3
	 xuDZ9vsmr1xmkd0VNBqXBtv0WBYly4xyhg+OH7ZazQuPB9GXGa5JlpzL9SP9F+ovF9
	 uyHhaycItQRRkmKXkEqS2xD99QGN6NiKdP5V/ITZ8iF9T3ZghWbSyRw/nyXvz1PsjL
	 lZCFyNaj59q+dQsSt/GMW4M/zTufmkQes/49+V/1z7/XYQ+LzIC4Z0uoM7W8tivVmr
	 vVguiaSOPtekNP0DPIDHoMGKFKj2Vp7lbVwB/HqfqD4ZRVA3dFxYAbjIH158zqaBvR
	 2fxJHk6IxCeXQ==
Subject: Re: [PATCH net-next v5 8/9] r8152: extract rtl_fc_pause_pkt_en() and
 apply it to RTL8156/8157/8159
From: netdev-bot+sashiko@kernel.org
To: hsu.chih.kai@realtek.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch
Date: Mon, 05 Oct 2026 09:57:25 +0000
Message-ID: <179119424533.434549.3306919352569058576@kernel.org>
In-Reply-To: <20261001091144.28191-9-nic_swsd@realtek.com>
References: <20261001091144.28191-9-nic_swsd@realtek.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message says this patch is an extraction ('extract
  rtl_fc_pause_pkt_en() and apply it'), but the body describes two…
- [Low] rtl8157_enable() passes the live PLA_PHYSTATUS value
  (rtl8152_get_speed()) to rtl_fc_pause_pkt_en() without checking…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the new
  PLA_PAUSE_LIMIT read-modify-write calls go through a helper chain that…

--

r8152: extract rtl_fc_pause_pkt_en() and apply it to RTL8156/8157/8159

This commit moves the RTL8156B flow-control setup out of r8156b_init()
into a new helper, rtl_fc_pause_pkt_en(), and calls it for RTL8156A,
RTL8156B and RTL8157/RTL8159. For RTL8156A it adds the FC timer and
FLOW_CTRL_PATCH_OPT setup, and for RTL8157/RTL8159 it programs the new
PLA_PAUSE_LIMIT register from rtl8157_enable() based on the link speed.

> Only RTL8156B (VER_12/13/15) got the full sequence, from
> r8156b_init(). RTL8156A (VER_10/11) toggled FC_PATCH_TASK in
> rtl8156_enable() without the FC timer and FLOW_CTRL_PATCH_OPT setup
> that has to precede it, and RTL8157/RTL8159 (VER_16/17) got no
> flow-control configuration at all.

[Severity: Low]
This paragraph describes two existing hardware misconfigurations that
the patch corrects, but the only trailer is Signed-off-by. Should this
carry Fixes: tags, and perhaps a short note on the symptom users see?

Before this patch, r8156_init() never wrote USB_FC_TIMER or
FLOW_CTRL_PATCH_OPT for VER_10/11. r8156a_post_firmware_1() only sets
FW_IP_RESET_EN and the U3PHY parameters. Even so, rtl8156_enable()
toggled FC_PATCH_TASK on every link-up:

    ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_FW_TASK, FC_PATCH_TASK);
    usleep_range(1000, 2000);
    ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_TASK, FC_PATCH_TASK);

For VER_16/17, nothing in the driver programmed SLOT_EN, the FC timer
or a pause limit.

Two other patches in the same series fix these chip families and do
carry Fixes: tags (195aae321c82, fd3c7d080df5, ad2a55b63b41):

  "r8152: fix up and down register settings for RTL8156/8156B/8157/8159"
  "r8152: add rtl8157_unload and rtl8157_change_mtu"

Without Fixes: tags on this patch, the stable and backport tooling
can't tell which trees need it.

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index be8b0db15033b..b2e4b071d84f0 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c

[ ... ]

> @@ -6174,6 +6179,105 @@ static void r8152b_enter_oob(struct r8152 *tp)
>  			   RCR_APM | RCR_AM | RCR_AB);
>  }
>  
> +static void rtl_fc_pause_pkt_en(struct r8152 *tp, u16 speed)
> +{

[ ... ]

> +	case RTL_VER_16:
> +	case RTL_VER_17_QFN68:
> +	case RTL_VER_17_QFN100:
> +		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR, SLOT_EN);
> +
> +		num_pause_pkts = 0xa;
> +		ratio = 10000;
> +
> +		if (speed & _10bps) {
> +			ratio /= 10;

[ ... ]

> +		} else if (speed & _10000bps) {
> +			ratio /= 10000;
> +		} else {
> +			/* No rate bit is set: the link dropped after
> +			 * the caller checked it, or the PHY reported a
> +			 * 500 or 1250 Mbit/s sub-rate, which the driver
> +			 * never advertises. Disarm the limit.
> +			 */
> +			dev_err(&tp->intf->dev, "Unknown link speed\n");
> +			ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_PAUSE_LIMIT,
> +					  PAUSE_LIMIT_EN);
> +			break;
> +		}

[Severity: Low]
Is dev_err() the right level for the link-down case? The comment calls
a link drop an expected race. However, it logs the same "Unknown link
speed" error as an unsupported 500/1250 Mbit/s rate.

rtl8157_enable() passes the raw rtl8152_get_speed() value and does not
check LINK_STATUS:

    speed = rtl8152_get_speed(tp);
    rtl_fc_pause_pkt_en(tp, speed);

set_carrier() is the only caller that confirms LINK_STATUS before
calling ops->enable. Three other callers check only the cached
netif_carrier_ok(): rtl8152_post_reset(), rtl8152_set_coalesce() and
rtl8152_change_mtu(). For example:

rtl8152_post_reset()
    if (netif_carrier_ok(netdev)) {
        mutex_lock(&tp->control);
        tp->rtl_ops.enable(tp);
          rtl8157_enable()
            rtl_fc_pause_pkt_en()   /* no rate bit set */
              dev_err("Unknown link speed")

The PHY link may be down, or still renegotiating after a USB reset.
In that case no rate bit is set, so this arm logs an error and clears
PAUSE_LIMIT_EN. The next link-up through set_carrier() then reprograms
the limit.

Would checking !(speed & LINK_STATUS) before the rate decode keep the
two cases apart and avoid the false error?

> +
> +		log2_ratio = ilog2(ratio);
> +		num_pause_pkts -= log2_ratio;

[ ... ]

> +		ocp_word_w0w1(tp, MCU_TYPE_PLA, PLA_PAUSE_LIMIT,
> +			      PAUSE_LIMIT_MASK | PAUSE_LIMIT_EN,
> +			      num_pause_pkts << 4);

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch. The
new PLA_PAUSE_LIMIT read-modify-write calls go through helpers that
can send kernel heap bytes back to the USB device.

r8152_control_msg() treats any non-negative usb_control_msg() result
as success, including a short read. get_registers() then copies the
full requested size out of a kmalloc() buffer that was never
initialized:

drivers/net/usb/r8152.c:get_registers() {
    ...
	tmp = kmalloc(size, GFP_KERNEL);
    ...
	if (ret < 0)
		memset(data, 0xff, size);
	else
		memcpy(data, tmp, size);
    ...
}

PLA_PAUSE_LIMIT is 0xe61e. ocp_read_word() therefore reads the dword
at 0xe61c and keeps the upper 16 bits. If a malicious device returns
only 2 bytes, those bits are leftover heap contents.

ocp_word_w0w1() changes only the selected bits and writes the rest
back to the device:

rtl8157_enable()
  rtl_fc_pause_pkt_en()
    ocp_word_w0w1(PLA_PAUSE_LIMIT)
      ocp_read_word()
        generic_ocp_read()
          get_registers()   /* short read, memcpy of stale bytes */
      ocp_write_word()      /* stale bytes written back to device */

Should get_registers() compare ret with size, or zero tmp, so a short
read is not treated as a complete one? The same pattern affects every
read-modify-write helper in the driver.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001091144.28191-1-nic_swsd%40realtek.com
