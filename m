Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792543935;
	b=GeGzUp98xBQpz1tp1eUkrV6bNZiWKGJQR/QuGecLAz14n+hzPXDILaLeKCu0vukfklLl
	 caBi7skize3pHegGDAsWJe+K9QwtGhzsHq86G+jTTyZ28LKgr2Db2eXzc4nZaBPVIVXoZ
	 cbM/Pi91nYG/zqewZ+DgRT9fCq0rxJCJ/Tg4ig2Hbq82tbD/0g7cd4MMUV1+XOPwTTyZn
	 I8pZfbL6NkKvU8EMqSTct84SyInx9aUV8RpQQA85ZhjgNW9uh/bJt327/Y/MBwJ8GbyF6
	 +iCX5d08c75CZqrSx0CuJp7ep4nOJsUPQTOcVkwMZyjncNwBM6I2Upis5Cc2tKaoIIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792543935;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mSMY52hIg7vAcjDlf2LPfos459LIsVBRRd++d9Y3/3o=;
	b=wTaTA++xyk5ltMxzMSaCCh0IMGKUh5wP6+K/BQF2+V9YiIr0Qxn8tjdTUxBfFao/5tIl
	 rxS0cKZrCR8xmgF3lR2Ad/0OMQoHaiNBhoKSlU9nKqAzERks6pfzb/Z3Y6UScoIUcoKXx
	 2+0jwyc5d3M1qzfxlBRoG1TeLb3vUmZpvma03nQCUa9STrWMWdcHEQyLcyf2S80m2AkIx
	 adUHh5avwwbzGxTzxk10k2zdktsuhfsv/cd8fcqd5XF+fx0lxA2MwhrjBTDef1vV04V1T
	 26+ezRfU2vqYNeIBpR8+vRvtFthOQkjeNJnjv7+MQLqxo/9PL65ku1cdOo2Ax7eqCsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oUrlgWNb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C476606A334;
	Wed, 21 Oct 2026 00:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oUrlgWNb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7091F000CD;
	Wed, 21 Oct 2026 00:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792543935;
	bh=mSMY52hIg7vAcjDlf2LPfos459LIsVBRRd++d9Y3/3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oUrlgWNbShcp2IfJXHva/yfbd4HCjdm3HUzusQFH7rxQkPUe1O3vP06EXoYfNJjYV
	 3AcbhyAu6qxb67lCqE+limZ9IA6ybTu4N/Jqbdx3nSlZCGDa8ZRxz0jdP8x9ktiZV6
	 aOXIcUKbAv3fQ9jH8A4qZG2NiSt5Ohs1gmlYmi2Q9CxUXYtoMqnwoypBg2blrvzl1G
	 /HxY+ULQlVZ794GHegELxwp+QA+T2TknhApj8DKD/lO1s1S6RtEvr4lxVcP1lBNfzE
	 1pCuXGgUFDgJBfc9NUbJ6vfDEyVEQkDEIVS+QAbh6unn0TI8KLhLJbj96qUDpNxlwM
	 a9JRUBe9m0wmA==
From: Jakub Kicinski <kuba@kernel.org>
To: hsu.chih.kai@realtek.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	nic_swsd@realtek.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	edumazet@google.com,
	bjorn@mork.no,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	mail@birger-koblitz.de
Subject: Re: [PATCH net-next v7 10/10] r8152: enable UPS for RTL8157 and RTL8159 QFN68
Date: Tue, 20 Oct 2026 17:52:14 -0700
Message-ID: <20261021005214.1255071-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261014081904.6491-11-nic_swsd@realtek.com>
References: <20261014081904.6491-11-nic_swsd@realtek.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
r8152: enable UPS for RTL8157 and RTL8159 QFN68

This patch adds r8157_ups_en() and calls it from rtl8157_runtime_enable(),
so UPS is now switched on and off during runtime suspend and resume for
RTL_VER_16 and RTL_VER_17_QFN68. It also adds per-speed EEE flags and
5G/10G speed encodings to r8156_ups_flags(), and skips the lite_mode
encoding for those chips.

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 95f510da376de..7a1b34db1d88b 100644
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

[Severity: Medium]
This is a pre-existing issue, but this patch adds more callers of the
ocp_byte_w0w1() read/modify/write path, and that path depends on
get_registers():

drivers/net/usb/r8152.c:get_registers() {
    ...
	if (ret < 0)
		memset(data, 0xff, size);
	else
		memcpy(data, tmp, size);
    ...
}

usb_control_msg() accepts short IN transfers. Could a malicious device
reply with fewer than size bytes and leave stale kmalloc() data in the
part of tmp it never wrote?

ocp_byte_w0w1() then writes that byte back with only the masked bits
changed:

	ocp_data = ocp_read_byte(tp, type, index);
	ocp_data = (ocp_data & ~clear) | set;
	ocp_write_byte(tp, type, index, ocp_data);

That would let the device read back up to 8 bits of stale heap data per
read/modify/write. This does not happen with init_on_alloc. Every
read/modify/write in the driver has the same pattern, and this patch does
not change get_registers().

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

[Severity: Low]
This isn't a bug introduced by this patch, but ocp_read_word() ignores
the return value of generic_ocp_read() and uses its local tmp anyway:

drivers/net/usb/r8152.c:ocp_read_word() {
	__le32 tmp;
    ...
	generic_ocp_read(tp, index, sizeof(tmp), &tmp, type | byen);

	data = __le32_to_cpu(tmp);
    ...
}

If RTL8152_INACCESSIBLE is already set, generic_ocp_read() returns
-ENODEV without writing the buffer. The same happens if kmalloc() fails
in get_registers(). Would the PCUT_STATUS check here, and the
BACKUP_RESTRORE poll below, then test an uninitialized stack value?

When the device is inaccessible, the writes that follow do nothing, so
the most likely visible effect is a KMSAN report. Every ocp_read_*
caller is affected.

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
Can this leave the interface unusable after a runtime resume, with
nothing to recover it?

With this patch, runtime suspend on RTL_VER_16 and RTL_VER_17_QFN68
enables UPS power cut by default. That means any runtime resume that
finds PCUT_STATUS set will run this wait:

rtl8152_runtime_resume()
  tp->rtl_ops.autosuspend_en(tp, false)
    rtl8157_runtime_enable(tp, false)
      r8157_ups_en(tp, false)
        read_poll_timeout() times out
        rtl_set_inaccessible(tp)

r8157_ups_en() returns void, so rtl8157_runtime_enable() carries on, and
r8157_u2p3en() and r8153b_u1u2en() quietly do nothing.
rtl8152_runtime_resume() then runs napi_disable()/napi_enable(),
rtl8152_get_speed() and usb_submit_urb(), and returns 0.

rtl8152_resume() has a reset fallback, but it is skipped for runtime
resume:

	if (!runtime_resume && test_bit(RTL8152_INACCESSIBLE, &tp->flags))
		usb_reset_device(tp->udev);

Once the flag is set, r8152_control_msg() also returns early:

	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
		return -ENODEV;

This happens before it gets to the usb_queue_reset_device() logic, so
later register accesses cannot start a recovery either.

The netdev stays registered and up while every hardware access is
skipped. That lasts until a replug, a system suspend/resume, or an
unrelated reset. Before this patch, rtl8157_runtime_enable() had no such
wait.

The commit message mentions this and defers recovery to a follow-up
series. Since this path is on by default for these chips, should this
patch at least queue a USB reset here (for example with
usb_queue_reset_device(tp->intf)) or pass the error back?

> +
> +			/* clear USB fw_ver_reg */
> +			ocp_write_byte(tp, MCU_TYPE_USB, USB_FW_USB_VER, 0);
> +
> +			tp->rtl_ops.hw_phy_cfg(tp);

[Severity: Low]
This isn't a bug introduced by this patch, but r8157_hw_phy_cfg() can
return early after it has already turned EEE and ALDPS off:

drivers/net/usb/r8152.c:r8157_hw_phy_cfg() {
    ...
	r8153_aldps_en(tp, false);
	rtl_eee_enable(tp, false);
    ...
	if (rtl_phy_patch_request(tp, true, true))
		return;
    ...
}

If the PHY patch handshake times out (for example -ETIME when
PATCH_READY never appears), the code skips re-enabling EEE and ALDPS and
skips set_bit(PHY_RESET). By then r8153_eee_en() has already cleared
tp->ups_info.eee.

hw_phy_cfg returns void, so r8157_ups_en() goes straight on to
rtl8152_set_speed() and runtime resume reports success. Does EEE and
ALDPS then stay off until the PHY is reconfigured? Would the next UPS
suspend also leave out the new per-speed EEE flags in r8156_ups_flags()?

The hw_phy_work path and r8153b_ups_en()/r8156_ups_en() share the same
early return. This patch adds one more caller.

> +
> +			rtl8152_set_speed(tp, tp->autoneg, tp->speed,
> +					  tp->duplex, tp->advertising);
> +		}
> +	}
> +}

[ ... ]
