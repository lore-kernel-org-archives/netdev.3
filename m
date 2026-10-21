Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792543934;
	b=nzfQbZqQHvtWg6LZxgTguD8nnrEW6Sh51cRAWmUW7OcEfbQGZ09B9cLhYq91nyW5k6If
	 CtRjDeVC1VbE49/RQnklJpBVeeFWHPcPksX+oVpAw22xW3VA5co34qLIEilX6/DcYee/T
	 PwwV8Yvk3FvDt3gdMMZgYLphP9lntYsXu5eFjXzQGnJ6sMzx6HUPwfCTLbLjbaMkAIed+
	 KagtYj6tiVgE0yY59pkSQyb0R+IoClkFsZ1AuPFrx9wTEVBaOrlfh/hHoUrOVSqhvqNra
	 p+o5mCdJ/El5/nQd/zaVllE0t+3AAiNIRNEacYYGUdP9w79pNo+xxbJU6QWQWqIFpkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792543934;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OFnyuTjp6nDQbfI+PY2nTqR22LRiPYhanZTcVnJoe1E=;
	b=5kCpv2e+NUqB141vXSfKZ/z79T/nJtgYHHOkgOQ0w+Nt1XYIFfxj68xIwYIOJ2tvLtPj
	 CU299IZVLWZVwpnWwz3PWnpQvHHsXWWIKzpCWxTlcf9AxXoXW2hAc/NrGOjvpPa/SVWdg
	 C2tQ7xPL2LofhkTkgpoJRrHXCAM9GTzJc0w5OXnkM47c13IWsfs5zNHkws20/vNw26sB8
	 zK2l9QS1U/aFbB1JfbxJFXsY1LKIOPEYHZ1LsH9keHDrtNLTl5FlpsJ8aBOGnfxQibje2
	 65W/zQ6mkzUjjlLOk5A5P0sit12fxwPBYJ7HJe6lpIMQheSU07y1UEiDxTPCz0fPdcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fiEQilr0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E163606A327;
	Wed, 21 Oct 2026 00:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fiEQilr0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3EDA1F000C9;
	Wed, 21 Oct 2026 00:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792543934;
	bh=OFnyuTjp6nDQbfI+PY2nTqR22LRiPYhanZTcVnJoe1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fiEQilr0kJXpZep7roXE6u7jFwrJex7onnQWiKFnD4iriZySDIom9i38Xu3Ilnu4R
	 svKXmyZG29WHdjB7iJSBXb9LRj7U/bJCLAcnjK50PRz8CEZoru+o03EtQ6dcUO8fxn
	 4uLTmU2YpnmadJ83pkj35tF+B2/ydK1VqQ1/eB6mTWP/9LPOaxWIgu3J4PbbQzCEJH
	 qj9jZ+4xnVsFoGN0jry1V30Meu+hkpfsxiQWWCzaWie94dkp3yvZHDNLHh1TbuWvDN
	 fNnw+BpFunpCp8SZheNa5n2MXDRxnsu+juRFvfruqtcBupu555sCrOZAfM5t6kOXYS
	 NRxg1zVph/EUA==
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
Subject: Re: [PATCH net-next v7 08/10] r8152: add TGPHY register access for RTL8157 and RTL8159
Date: Tue, 20 Oct 2026 17:52:13 -0700
Message-ID: <20261021005213.1255035-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261014081904.6491-9-nic_swsd@realtek.com>
References: <20261014081904.6491-9-nic_swsd@realtek.com>
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
r8152: add TGPHY register access for RTL8157 and RTL8159

This adds a TGPHY command channel backend for PHY register access on
RTL8157 and RTL8159. It is selected through new rtl_ops.phy_read and
phy_write hooks. The helpers built on ocp_reg_read()/ocp_reg_write() now
return int, and a subset of callers propagate the errors.

> This patch propagates the status only where an errno
> would otherwise be taken for register content or reported as
> success: the pause parameters, rtl8152_set_speed(),
> SIOCGMIIREG/SIOCSMIIREG, the PHY patch handshake and the PHY
> firmware version checks.
>
> Not handled here, and left to a follow-up series: the remaining
> callers, notably the hw_phy_cfg and init sequences,
> r8153_phy_status(), r8152_mmd_read(), EEE handling and the MII
> library callbacks, still ignore the status.

[Severity: Medium]
Is this description accurate? Some of the callers listed as still
ignoring the status do act on it in this diff.

r8153_get_eee() returns an errno from each of its ocp_reg_read() calls:

	ret = ocp_reg_read(tp, OCP_EEE_ABLE, &val);
	if (ret < 0)
		goto out;

r8153_phy_status() now leaves its poll on the first failed read:

	if (ocp_reg_read(tp, OCP_PHY_STATUS, &data) < 0)
		break;

rtl8152_get_link_ksettings() is not in either list. It now fails the
whole request when the OCP_10GBT_CTRL or OCP_10GBT_STAT read fails.

rtl8153_in_nway(), r8156_mdio_force_mode(), r8156_eee_en() and
rtl8152_fw_phy_fixup() also return early on a read failure now.

Could the commit message be updated to cover these changes?

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 558ccb4682c27..7c0de56266963 100644
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
On RTL8157/RTL8159, can this pass -ETIMEDOUT to the generic MII library
as if it were a BMCR value? read_mii_word() is the mii_if_info.mdio_read
callback, and it returns the result of r8152_mdio_read() unchanged.

mii_nway_restart() in drivers/net/mii.c does:

	bmcr = mii->mdio_read(mii->dev, mii->phy_id, MII_BMCR);

	if (bmcr & BMCR_ANENABLE) {
		bmcr |= BMCR_ANRESTART;
		mii->mdio_write(mii->dev, mii->phy_id, MII_BMCR, bmcr);
		r = 0;
	}

-ETIMEDOUT is 0xffffff92, which has BMCR_ANENABLE set. write_mii_word()
only filters RTL8152_INACCESSIBLE, and a TGPHY timeout does not set that
flag. So 0xff92 would be written to BMCR. That sets BMCR_RESET,
BMCR_LOOPBACK, BMCR_PDOWN and BMCR_ISOLATE, and the call still returns 0.

The path is:

rtl8152_nway_reset()
  mii_nway_restart()
    read_mii_word()
      r8152_mdio_read()
        r8157_phy_read()
          rtl_tgphy_access()
            wait_tgphy_cmd_ready() returns -ETIMEDOUT

rtl_ethtool_set_eee() also calls mii_nway_restart(). In addition,
mii_ethtool_get_link_ksettings() would decode link modes from the errno.

Before this patch, the only errno read_mii_word() could return was
-ENODEV, and write_mii_word() filters that case.

The commit message mentions this case, and the later patches in the series
do not seem to address it. rtl_ops_init() switches RTL_VER_16/17 to
r8157_phy_read() in this patch. Could read_mii_word()/write_mii_word()
handle the errno before or in this patch?

> @@ -1906,100 +1950,217 @@ static void ocp_byte_set_bits(struct r8152 *tp, u16 type, u16 index, u8 set)

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
> +	if (ret)
> +		dev_err(&tp->intf->dev, "TGPHY cmd busy timeout\n");

[Severity: Medium]
What happens if TGPHY_CMD_BUSY stays set while USB transfers still work?
Each PHY access then waits up to 20ms here, or 40ms for a read. It also
prints another error that is not ratelimited. There is no recovery, and
RTL8152_INACCESSIBLE is never set.

Most callers ignore the status and keep going. r8157_hw_phy_cfg() makes
well over a hundred PHY accesses, and the firmware loaders do one write
per firmware word:

rtl8152_fw_phy_nc_apply() {
    ...
	for (i = 0; i < num; i++)
		ocp_reg_write(tp, OCP_SRAM_DATA, __le16_to_cpu(data[i]));
    ...
}

rtl8152_fw_phy_union_apply() has the same loop.

All of this runs with tp->control held in the probe, resume, open and
reset paths. Could this stall for seconds or minutes and flood the log?
Would ratelimiting the message, or stopping the sequence after the first
timeout, avoid that?

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

[Severity: Low]
This is a minor point. The status of the USB_TGPHY_DATA, ADDR and CMD
transfers is not checked here.

A misdirected command does not seem possible. r8152_control_msg() calls
rtl_set_inaccessible() when a control transfer fails, so a CMD write that
follows a failed ADDR write is never sent.

rtl_tgphy_access() can still return 0 once after a failed transfer,
either for a write or when the final USB_TGPHY_DATA read fails. Would it
be cleaner to return -ENODEV when RTL8152_INACCESSIBLE is set at the end
of the transaction?

> +
> +	if (!write) {
> +		ret = wait_tgphy_cmd_ready(tp);
> +		if (ret < 0)
> +			goto out;
> +
> +		*data = ocp_read_word(tp, MCU_TYPE_USB, USB_TGPHY_DATA);

[Severity: Medium]
This isn't a bug introduced by this patch, but ocp_read_word() ignores
the return value of generic_ocp_read():

ocp_read_word() {
    ...
	generic_ocp_read(tp, index, sizeof(tmp), &tmp, type | byen);

	data = __le32_to_cpu(tmp);
    ...
}

RTL8152_INACCESSIBLE could be set between the second
wait_tgphy_cmd_ready() and this read, for example by
rtl8152_disconnect()->rtl_set_unplug(). In that case generic_ocp_read()
returns -ENODEV early, tmp stays uninitialized, and rtl_tgphy_access()
returns 0. SIOCGMIIREG could then copy that stack data into
data->val_out.

dev_ioctl() requires CAP_NET_ADMIN for SIOCGMIIREG, so unprivileged users
cannot reach this. r8152_phy_read() already has the same flaw.

[ ... ]

> @@ -4177,11 +4338,13 @@ static void r8153b_green_en(struct r8152 *tp, bool enable)
>  
>  static u16 r8153_phy_status(struct r8152 *tp, u16 desired)
>  {
> -	u16 data;
> +	u16 data = 0;
>  	int i;
>  
>  	for (i = 0; i < 500; i++) {
> -		data = ocp_reg_read(tp, OCP_PHY_STATUS);
> +		if (ocp_reg_read(tp, OCP_PHY_STATUS, &data) < 0)
> +			break;
> +

[Severity: Medium]
On RTL8157/8159, one 20ms TGPHY busy timeout now ends this poll, which
previously ran for up to 500 x 20ms. The function then returns 0 or a
stale masked value. Is that safe for callers that switch on the result?

r8157_hw_phy_cfg() {
    ...
	data = r8153_phy_status(tp, 0);
	switch (data) {
	case PHY_STAT_EXT_INIT:
		rtl8152_apply_firmware(tp, true);
		ocp_reg_clr_bits(tp, 0xa466, BIT(0));
		ocp_reg_clr_bits(tp, 0xa468, BIT(3) | BIT(1));
		break;
	case PHY_STAT_LAN_ON:
	case PHY_STAT_PWRDN:
	default:
		rtl8152_apply_firmware(tp, false);
		break;
	}
    ...
}

A return of 0 falls into the default case. That calls
rtl8152_apply_firmware(tp, false) and skips the EXT_INIT release writes,
even when the PHY really is in PHY_STAT_EXT_INIT. r8159_hw_phy_cfg() and
r8157_init() follow the same pattern.

The later r8153_phy_status(tp, PHY_STAT_LAN_ON) call also stops after its
first failed read. The PFM, ALDPS and related settings are then
programmed before the PHY reaches LAN_ON, and WARN_ON_ONCE() fires.

Before this patch, the loop always ran to its full timeout on these
chips.

[ ... ]

> @@ -4598,25 +4762,29 @@ static int rtl_phy_patch_request(struct r8152 *tp, bool request, bool wait)
>  	}
>  
>  	for (i = 0; wait && i < 5000; i++) {
> -		u32 ocp_data;
> -
>  		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>  			return -ENODEV;
>  
>  		usleep_range(1000, 2000);
> -		ocp_data = ocp_reg_read(tp, OCP_PHY_PATCH_STAT);
> -		if ((ocp_data & PATCH_READY) ^ check)
> +		ret = ocp_reg_read(tp, OCP_PHY_PATCH_STAT, &ocp_data);
> +		if (ret < 0)
> +			return ret;
> +		else if ((ocp_data & PATCH_READY) ^ check)
>  			break;
>  	}
>  
> -	if (request && wait &&
> -	    !(ocp_reg_read(tp, OCP_PHY_PATCH_STAT) & PATCH_READY)) {
> -		dev_err(&tp->intf->dev, "PHY patch request fail\n");
> -		rtl_phy_patch_request(tp, false, false);
> -		return -ETIME;
> -	} else {
> -		return 0;
> +	if (request && wait) {
> +		ret = ocp_reg_read(tp, OCP_PHY_PATCH_STAT, &ocp_data);
> +		if (ret < 0) {
> +			return ret;
> +		} else if (!(ocp_data & PATCH_READY)) {
> +			dev_err(&tp->intf->dev, "PHY patch request fail\n");
> +			rtl_phy_patch_request(tp, false, false);
> +			return -ETIME;
> +		}
>  	}

[Severity: Medium]
When request is true, PATCH_REQUEST is already set in OCP_PHY_PATCH_CMD
by the time these two new return ret paths run. Do they leave it
asserted? The -ETIME path releases it with
rtl_phy_patch_request(tp, false, false), but the errno paths return
without doing that.

Callers treat any non-zero return as "not acquired" and do not release:

r8157_hw_phy_cfg() {
    ...
	if (rtl_phy_patch_request(tp, true, true))
		return;
    ...
}

r8159_hw_phy_cfg() and rtl_ram_code_speed_up() do the same. A TGPHY
timeout on the OCP_PHY_PATCH_STAT read would leave the PHY in patch
request mode. r8157_hw_phy_cfg() would also skip the rest of its
configuration.

[ ... ]

> @@ -6629,7 +6815,10 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
>  		}
>  
>  		if (tp->support_2500full || tp->support_5000full || tp->support_10000full) {
> -			orig = ocp_reg_read(tp, OCP_10GBT_CTRL);
> +			ret = ocp_reg_read(tp, OCP_10GBT_CTRL, &orig);
> +			if (ret < 0)
> +				goto out;
> +
>  			new1 = orig & ~(MDIO_AN_10GBT_CTRL_ADV2_5G | MDIO_AN_10GBT_CTRL_ADV5G
>  					| MDIO_AN_10GBT_CTRL_ADV10G);
>  

[Severity: Medium]
The reads are checked now, but the writes in rtl8152_set_speed() still
are not. The commit message names this function as one where an errno is
no longer reported as success:

	if (orig != new1) {
		r8152_mdio_write(tp, MII_ADVERTISE, new1);
		tp->mii.advertising = new1;
	}
	...
	if (orig != new1)
		r8152_mdio_write(tp, MII_CTRL1000, new1);
	...
	if (orig != new1)
		ocp_reg_write(tp, OCP_10GBT_CTRL, new1);

If one of these writes times out on RTL8157/8159, tp->mii.advertising is
still updated. The function returns 0 as long as the BMCR write succeeds.
rtl8152_set_link_ksettings() then saves tp->advertising, tp->speed and
tp->duplex as if they had been applied.

The PHY patch handshake has the same gap. rtl_phy_patch_request() does
not check the result of the PATCH_REQUEST write:

	if (request) {
		ocp_reg_set_bits(tp, OCP_PHY_PATCH_CMD, PATCH_REQUEST);
		check = 0;
	} else {
		ocp_reg_clr_bits(tp, OCP_PHY_PATCH_CMD, PATCH_REQUEST);
		check = PATCH_READY;
	}

This has three effects:

- With wait false, a failed request or release returns 0. The firmware
  path uses this mode through rtl_pre_ram_code(..., !power_cut).
- With request true, a failed write polls for more than 5 seconds and
  then returns -ETIME instead of the real errno.
- With request false and wait true, a failed release runs all 5000
  iterations and still returns 0.

rtl_pre_ram_code() also turns any error into -ETIME, and
rtl8152_apply_firmware() ignores its return value.

Should these write results be checked as well?

> @@ -6660,20 +6849,23 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
>  	if (test_and_clear_bit(PHY_RESET, &tp->flags))
>  		bmcr |= BMCR_RESET;
>  
> -	r8152_mdio_write(tp, MII_BMCR, bmcr);
> +	ret = r8152_mdio_write(tp, MII_BMCR, bmcr);
> +	if (ret < 0)
> +		goto out;

[Severity: Medium]
Is the pending PHY reset lost when this write fails? PHY_RESET is cleared
before the write. On RTL8157/8159, r8152_mdio_write() can now return
-ETIMEDOUT before anything is sent to the hardware:

rtl_tgphy_access() {
	...
	ret = wait_tgphy_cmd_ready(tp);
	if (ret < 0)
		goto out;
	...
}

This can happen if the preceding OCP_10GBT_CTRL write is still busy.

r8157_hw_phy_cfg() and r8159_hw_phy_cfg() end with
set_bit(PHY_RESET, &tp->flags) so that the next rtl8152_set_speed()
resets the PHY. If this write fails, BMCR_RESET never reaches the PHY and
the flag is not set again.

Should PHY_RESET be restored on this error path?

[ ... ]
