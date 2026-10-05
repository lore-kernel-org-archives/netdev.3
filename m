Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44D84734D0;
	Mon,  5 Oct 2026 09:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791194254; cv=none; b=Qq8mYNHe/5hO+3A+wZ16wM+ZTPT1uywufrkpsv0okCpwTUz6InjN/tZVX6X1I26k4wiUb8g/Q4xr5ucn1Oh/w9N7nPs6da1utO7vAStDRgEf8lFBMYdsUxCzlCPDkLg/l9taok9hSiCzuocEbcClc6R+q4J2EVe+tKjgmJCAH+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791194254; c=relaxed/simple;
	bh=iqXV41MDTEL5dNvvoxkjU88Iw6M+LEtHHjNYyj6yEl0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FudmXPNGa+C9HCr6wXTYr+AQ/GR5u20wWKofvpwznZQ/vo7Lu1fj4O4oOZkk2OjIxX00jYV7qTIIr8qsWfOdaQYCWeubsF87xQUFlXzJ1BrMT0lAzg3mrGYRp4QyvG9u71Wmy8A61iQaUamfwxALaw6rxIVr5FaUmpZ2Sb43XvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvYwQ0fu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvYwQ0fu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99331F000FF;
	Mon,  5 Oct 2026 09:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791194247;
	bh=Z1MGtxS2XyOSeJMxKVHUy/kSQLhy96iQZYOgz4ubjBM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dvYwQ0fucJnTcfndxc+uSSN7btaCi7Sf/mf6uwrHLkdCgxwfKhkB+MnQXwYbtna0w
	 Tj77ahJ5lhx5NSoRoRBZBCdpjXBKYPbIpY8FioTSVE14K8fifO2239Jo/Uo5z2Dxw8
	 ue2AxH4HVTfGI4n1tM5vIT+lTbSJKSG64JxuMos2VrxfK61onXz8zQjvKNNWDywj0t
	 sm2L0sL7TObgmKpVbUwKnisePbN+aUE5oxUUI9MHV7WqKKEtBu9ANsKQWideeSsv6R
	 iYL7nM/xJHxJr4eZ3atE9F5SbyGFJ2kpqli1SSGkpkNyypBHR34JDRcmdYMRCm+/im
	 h1zTPP7LTn39Q==
Subject:
 Re: [PATCH net-next v5 9/9] r8152: enable UPS for RTL8157 and RTL8159 QFN68
From: netdev-bot+sashiko@kernel.org
To: hsu.chih.kai@realtek.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch
Date: Mon, 05 Oct 2026 09:57:26 +0000
Message-ID: <179119424653.434549.3037572645986849314@kernel.org>
In-Reply-To: <20261001091144.28191-10-nic_swsd@realtek.com>
References: <20261001091144.28191-10-nic_swsd@realtek.com>
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

- [Medium] If the new backup-restore poll in r8157_ups_en(tp, false)
  times out during runtime resume on RTL_VER_16 or RTL_VER_17_QFN68, the…

--

r8152: enable UPS for RTL8157 and RTL8159 QFN68

This patch adds r8157_ups_en() and calls it from rtl8157_runtime_enable()
for RTL_VER_16 and RTL_VER_17_QFN68. When UPS is disabled and PCUT_STATUS
is set, the new disable path polls for backup-restore to finish. It also
extends r8156_ups_flags() with per-speed EEE flags and the 5G/10G speed
encodings.

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index b2e4b071d84f0..baac964fea80f 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c

[ ... ]

> @@ -4486,6 +4524,49 @@ static void r8156_ups_en(struct r8152 *tp, bool enable)
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
> +			u32 ocp_data;
> +			int ret;
> +
> +			ret = read_poll_timeout(ocp_read_word, ocp_data,
> +						ocp_data & BACKUP_RESTRORE, 200,
> +						20000, false, tp, MCU_TYPE_USB,
> +						USB_GPHY_CTRL);
> +			if (ret) {
> +				rtl_set_inaccessible(tp);
> +				dev_err(&tp->intf->dev,
> +					"backup-restore timed out\n");
> +				return;
> +			}

[Severity: Medium]
If this read_poll_timeout() times out during a runtime resume on
RTL_VER_16 or RTL_VER_17_QFN68, does anything recover the device?

The path looks like this:

rtl8152_resume()
  rtl8152_runtime_resume()
    tp->rtl_ops.autosuspend_en(tp, false)
      rtl8157_runtime_enable(tp, false)
        r8157_ups_en(tp, false)
          rtl_set_inaccessible(tp)

r8157_ups_en() returns void, so rtl8152_runtime_resume() keeps going and
returns 0. The reset fallback in rtl8152_resume() skips the runtime case:

	if (!runtime_resume && test_bit(RTL8152_INACCESSIBLE, &tp->flags))
		usb_reset_device(tp->udev);

The register reads in the poll succeeded, so r8152_control_msg() never
queued a reset. After that, every access returns early before
r8152_control_msg() gets to its reset logic:

	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
		return -ENODEV;

r8152_submit_rx(), the interrupt callback and bottom_half() also return
early while the flag is set.

Would the interface then stay unusable until some unrelated reset, such
as rtl8152_tx_timeout() when TX traffic stalls, or a replug? An idle
interface would get neither.

Before this patch these chips never entered UPS on runtime suspend, so
this resume failure looks new.

Could this path queue a reset, or otherwise pass the error back, in the
runtime resume case?

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

> @@ -4644,9 +4725,28 @@ static void rtl8157_runtime_enable(struct r8152 *tp, bool enable)

[ ... ]

>  	} else {
>  		r8153_queue_wake(tp, false);
>  		rtl_runtime_suspend_enable(tp, false);
> +
> +		switch (tp->version) {
> +		case RTL_VER_16:
> +		case RTL_VER_17_QFN68:
> +			r8157_ups_en(tp, false);
> +			break;
> +		default:
> +			break;
> +		}
> +
>  		r8157_u2p3en(tp, true);
>  		if (tp->udev->speed >= USB_SPEED_SUPER)
>  			r8153b_u1u2en(tp, true);
>  	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001091144.28191-1-nic_swsd%40realtek.com
