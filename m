Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF0C47604B;
	Mon, 12 Oct 2026 09:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795977; cv=none; b=FPxxjR3KTJM/22qf33oENqp7aj9NlAjPvHQno6dUJQcFqWlXZVmOeyk17/L9ZZiEZYXyPP/YsAf0wbkjIfSrHEErwjvzrlbemoY0uxwhY8CQB8qYx51GAr6NYRcSLkFEwY99l96Tw119kzCVRw1ytEvVWrmS1mjguyJVfvoQMu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795977; c=relaxed/simple;
	bh=kA/ItF9h1nCFTxhEL0c1DqbZio4eueeDYTG33x1kJ3o=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kpVIZAzlaRBx9Ma4ZeT6/M0+/bdStrJflFUtNuab1ZkFrsxfbvoSJNmGpxPGpk8gAsDokSt6b8pRfqaqGQQp+ENQuKSNQyEq1okwToqtkiuiFFqCAv/sQqz5hqXnLuB7IXEAztDsceLiZamPNP4TTItS7WHCnv5GdG7yoCM9bxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdi4ucVh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdi4ucVh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3651F0089D;
	Mon, 12 Oct 2026 09:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791795975;
	bh=W0QWW9tfVH7jaXvptE8xrPFNAxGzARHCWq6cxFpjuAs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gdi4ucVhzjjf92DkdoIIDmQGE/7DcKuf8juvUkVhSSdtqqhFvuG0yXYFt28fSerwL
	 OSpisetJpG0v+GztHsfKnVFReLl1ZW+nJkbv5FTwoDUGeUPBmzsZIeZFJjx1UafDhD
	 TwdDlXYvxhgc2f9nkCe7BDV9h5wAJDlGSpi2mvLBptlw5u31FmhICrIaMHyLBhHZmv
	 //YcNrD8eo+roEcEGdoNARZJKLkXbZBLcYFf1tm48p96KPkOLD9AlXgLNjA4DEZoQj
	 GFB7zN8baVlK4VXAE47uD/OU6hzleOgMujJSEWcNca+AaQ/hpeEqnqyh7TyOQgXb8Q
	 8Xhk3bGXhQexA==
Subject:
 Re: [PATCH net-next v6 10/10] r8152: enable UPS for RTL8157 and RTL8159 QFN68
From: netdev-bot+sashiko@kernel.org
To: hsu.chih.kai@realtek.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch,
 mail@birger-koblitz.de
Date: Mon, 12 Oct 2026 09:06:14 +0000
Message-ID: <179179597459.434549.1231312772566693467@kernel.org>
In-Reply-To: <20261008081556.47901-11-nic_swsd@realtek.com>
References: <20261008081556.47901-11-nic_swsd@realtek.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] When the new backup-restore poll in r8157_ups_en() times out
  (20 ms after PCUT_STATUS is seen, polling…
- [Low] r8157_ups_en() open-codes the same PCUT_STATUS-gated poll on
  USB_GPHY_CTRL & BACKUP_RESTRORE (200 us interval, 20 ms timeout) that…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the new code
  relies on it.

--

r8152: enable UPS for RTL8157 and RTL8159 QFN68

This patch enables UPS on runtime suspend/resume for RTL8157 and RTL8159
QFN68 through a new r8157_ups_en() helper. It also extends
r8156_ups_flags() with per-speed EEE flags and 5G/10G speed encodings for
these chips. The disable path waits for backup-restore after a power cut.
On timeout it marks the device inaccessible.

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index b5092fdaa12c7..fc75e263b0e4c 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c

[ ... ]

> @@ -4484,6 +4522,49 @@ static void r8156_ups_en(struct r8152 *tp, bool enable)
>  	}
>  }
>  
> +static void r8157_ups_en(struct r8152 *tp, bool enable)
> +{
> +	if (enable) {
> +		r8156_ups_flags(tp);
> +
> +		ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_POWER_CUT,
> +				  UPS_EN | USP_PREWAKE | PHASE2_EN);
> +
> +		ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_MISC_2,
> +				  UPS_FORCE_PWR_DOWN);
> +	} else {
> +		ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_POWER_CUT,
> +				  UPS_EN | USP_PREWAKE);
> +
> +		ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_MISC_2,
> +				  UPS_FORCE_PWR_DOWN);
> +
> +		if (ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0) & PCUT_STATUS) {

[Severity: Medium]
This is a pre-existing issue that was not introduced by this patch, but
the new code relies on it. ocp_read_word() ignores the return value of
generic_ocp_read() and converts its local tmp anyway:

	generic_ocp_read(tp, index, sizeof(tmp), &tmp, type | byen);

	data = __le32_to_cpu(tmp);

When RTL8152_INACCESSIBLE is set, generic_ocp_read() returns -ENODEV
without filling the buffer. get_registers() also returns -ENOMEM without
writing the output, although that case is practically unreachable.

r8157_ups_en(tp, false) now runs on every runtime resume for RTL_VER_16
and RTL_VER_17_QFN68. Unlike wait_autoload_done(), it does not check
RTL8152_INACCESSIBLE.

If the device is already inaccessible, could uninitialized stack contents
decide both this PCUT_STATUS check and the BACKUP_RESTRORE poll below?

Depending on that garbage, this could poll for 20 ms and log a misleading
timeout. It could also call hw_phy_cfg() and rtl8152_set_speed() on a
device whose writes are all blocked, where the WARN_ON_ONCE in
r8157_hw_phy_cfg() may fire. r8156_ups_en() has the same pattern.

> +			u32 ocp_data;
> +			int ret;
> +
> +			ret = read_poll_timeout(ocp_read_word, ocp_data,
> +						ocp_data & BACKUP_RESTRORE, 200,
> +						20000, false, tp, MCU_TYPE_USB,
> +						USB_GPHY_CTRL);

[Severity: Low]
This isn't a bug, but this open-codes the same wait that
r8159_wait_backup_restore() already implements:

static int r8159_wait_backup_restore(struct r8152 *tp)
{
	...
	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0);
	if (!(ocp_data & PCUT_STATUS))
		return 0;

	return poll_timeout_us(ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_GPHY_CTRL),
			       ocp_data & BACKUP_RESTRORE, 200, 20000, false);
}

Could r8157_ups_en() reuse that helper so the two copies don't drift
apart?

Only r8159_init() calls the existing helper, and r8157_init() never waits
for backup-restore. This new path runs the poll for RTL_VER_16 too.

Does RTL8157 assert BACKUP_RESTRORE after a UPS power cut?
rtl_ram_code_speed_up() sets BACKUP_RESTRORE on VER_16, so this is
probably fine. If it doesn't, every UPS runtime resume on VER_16 would
time out and mark the device inaccessible.

> +			if (ret) {
> +				rtl_set_inaccessible(tp);
> +				dev_err(&tp->intf->dev,
> +					"backup-restore timed out\n");
> +				return;
> +			}

[Severity: Medium]
If this poll times out during runtime resume, can the interface be left
up but unusable with no recovery?

The call chain is:

rtl8152_runtime_resume()
  tp->rtl_ops.autosuspend_en(tp, false)
    rtl8157_runtime_enable(tp, false)
      r8157_ups_en(tp, false)
        rtl_set_inaccessible(tp)

r8157_ups_en() returns void, so rtl8152_runtime_resume() continues. It
sets WORK_ENABLE, resubmits intr_urb and returns 0.

After that, every register access fails early in r8152_control_msg():

	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
		return -ENODEV;

so it never reaches the usb_queue_reset_device() recovery further down.
rtl8152_resume() only resets on the system resume path:

	if (!runtime_resume && test_bit(RTL8152_INACCESSIBLE, &tp->flags))
		usb_reset_device(tp->udev);

The system sleep case looks fine. While the interface is up,
rtl_notifier() calls usb_autopm_get_interface() on PM_SUSPEND_PREPARE, so
the device is runtime-resumed first and the !runtime_resume fallback
catches the timeout.

A plain runtime resume on RTL_VER_16 or RTL_VER_17_QFN68 with autosuspend
enabled seems to stay broken until a replug or an unrelated reset.

Before this patch, rtl8157_runtime_enable(tp, false) had no failure path
for these chips. The commit message acknowledges this and leaves recovery
to a follow-up. Since this patch turns UPS on by default for these chips,
could this path queue a reset instead? r8152_control_msg() already does
this with usb_queue_reset_device(tp->intf).

> +
> +			/* clear USB fw_ver_reg */
> +			ocp_write_byte(tp, MCU_TYPE_USB, USB_FW_USB_VER, 0);
> +
> +			tp->rtl_ops.hw_phy_cfg(tp);
> +
> +			rtl8152_set_speed(tp, tp->autoneg, tp->speed,
> +					  tp->duplex, tp->advertising);
> +		}
> +	}
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008081556.47901-1-nic_swsd%40realtek.com
