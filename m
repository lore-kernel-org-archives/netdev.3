Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF3A569F20;
	Wed,  9 Sep 2026 13:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788960735; cv=none; b=fracfuUmsMi+Ezo60nFBok7Vm0jSeXQ9o3jQ1EZQk8vtIMnEmtisih9lwYDy5SE4KfhOUrZaVqENUe9Kx9z18e5QPi6pxsR1ccfCSrjIC3RIgNW/D8vM0mlkyu+Z15EHthmWbTK3PFCx1Ile9j7HUB9ErDjoLXnfH7jOMWz7IWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788960735; c=relaxed/simple;
	bh=qW6CyD1H8F1c1L7pGA6h+btoJWHKdQnqRIMsCo4xJWI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j35mmnvKyXeNL/47YVuFfx1jrKYRP0K0+TMWEoSfFtaLvOzT98tJl28G4Zlw7zxsBEqT8QuiiINuRXnEZgBxnBzcqPpgEibNKdOb1fOLZzmyGlfDLgysCvRF7IgSJGMsEHurK5WDXu+JGZCw2bn0u5VbKaVg5CDhvhBXZ0bPVxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wc1EVimy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wc1EVimy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC411F00A3E;
	Wed,  9 Sep 2026 13:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788960733;
	bh=Fvoz9hlnlDgHjUKDOXUkg8ppuFUwK1it+tWdEVQnA3Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Wc1EVimyIaGkf1Pfq3X6kURUJ7ivDNwfo7Hhn/FKJ3WIlKWFi1IAHFcGZSGJuxg6u
	 PjDWoVKUVCiL7jaMQq3VNCyogD5FlSiTQEzdu66rX3DgcGGGAFVtNvaT2Qr2/zXsNx
	 Jhk04r/yjrqhKAjN6AS7DvzoDCLR2wlNjqmC05jDZl2GYh/nboI97JVp2VfgE9ron1
	 6wbRq2ARB/5X3h1bv+9gE8sFPyK4TYQLieJVx1pkOlbdBZRX0MGHgMeXxgNs6m0ok6
	 DmMpiEiWqLGXClIExaqtoORVVNeF93ZqYFjjyBmygda38uLGwZYaXpXhKmeoYycYV7
	 KardeWSYsHeaQ==
Subject: Re: [PATCH net-next v2 6/8] r8152: add TGPHY access support
From: netdev-bot+sashiko@kernel.org
To: hsu.chih.kai@realtek.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch
Date: Wed, 09 Sep 2026 13:32:12 +0000
Message-ID: <178896073255.219967.13050155285869902671@kernel.org>
In-Reply-To: <20260903072852.58695-7-nic_swsd@realtek.com>
References: <20260903072852.58695-7-nic_swsd@realtek.com>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 1

- [Medium] The new TGPHY PHY access path silently swallows failures.
- [Low] wait_tgphy_cmd_ready() (drivers/net/usb/r8152.c:2045-2053) is a
  functional duplicate of the pre-existing, already parameterised…

Pre-existing issues:
- [Medium] The new TGPHY helpers make control-flow decisions on, and can
  return to user space, uninitialized kernel stack bytes.

--

r8152: add TGPHY access support

This adds a TGPHY register access path for RTL8157 and RTL8159 using
USB_TGPHY_CMD/ADDR/DATA, so PHY registers can be reached without
reprogramming the OCP GPHY base. It also introduces phy_read/phy_write
pointers in struct rtl_ops so ocp_reg_read()/ocp_reg_write() dispatch to
either the existing r8152 path or the new r8157 path.

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 06fad895fce0..1fcb1cc5b4a1 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c

[ ... ]

> @@ -511,6 +514,10 @@
>  #define ADV_CMD_WR		BIT(1)
>  #define ADV_CMD_IP		BIT(2)
>  
> +/* USB_TGPHY_CMD */
> +#define TGPHY_CMD_BUSY		BIT(0)
> +#define TGPHY_CMD_WR		BIT(1)
> +
>  /* USB_UPS_CTRL */
>  #define POWER_CUT		0x0100
>  

[ ... ]

> @@ -1687,6 +1696,16 @@ static void ocp_reg_write(struct r8152 *tp, u16 addr, u16 data)
>  	ocp_write_word(tp, MCU_TYPE_PLA, ocp_index, data);
>  }
>  
> +static u16 ocp_reg_read(struct r8152 *tp, u16 addr)
> +{
> +	return tp->rtl_ops.phy_read(tp, addr);
> +}
> +
> +static void ocp_reg_write(struct r8152 *tp, u16 addr, u16 data)
> +{
> +	tp->rtl_ops.phy_write(tp, addr, data);
> +}
> +
>  static inline void r8152_mdio_write(struct r8152 *tp, u32 reg_addr, u32 value)
>  {
>  	ocp_reg_write(tp, OCP_BASE_MII + reg_addr * 2, value);

[ ... ]

> @@ -2023,6 +2042,61 @@ static int r8152_mdio_test_and_clr_bit(struct r8152 *tp, u16 addr, u16 clear)
>  	return data & clear;
>  }
>  
> +static int wait_tgphy_cmd_ready(struct r8152 *tp)
> +{
> +	u16 ocp_data;
> +
> +	return poll_timeout_us(ocp_data = ocp_read_word(tp, MCU_TYPE_USB,
> +							USB_TGPHY_CMD),
> +			       !(ocp_data & TGPHY_CMD_BUSY), 2000, 20000,
> +			       false);
> +}

[Severity: Low]
This isn't a bug, but is wait_tgphy_cmd_ready() needed at all?  The driver
already has a parameterised helper right above ocp_adv_read():

	static int wait_cmd_ready(struct r8152 *tp, u16 cmd)
	{
		return poll_timeout_us(u16 ocp_data = ocp_read_word(tp, MCU_TYPE_USB, cmd),
					!(ocp_data & ADV_CMD_BUSY), 2000, 20000, false);
	}

ADV_CMD_BUSY and the new TGPHY_CMD_BUSY are both BIT(0), and the poll
interval and timeout are identical, so wait_cmd_ready(tp, USB_TGPHY_CMD)
looks like an exact substitute.  With two copies, a later change to the
timeout or the addition of an RTL8152_INACCESSIBLE early-out would only
land in one of them.

[Severity: Medium]
This is a pre-existing issue and not introduced by this patch, but the new
helper makes a hardware-readiness decision on a value that can be
uninitialized stack data.  ocp_read_word() does:

	u32 data;
	__le32 tmp;
	...
	generic_ocp_read(tp, index, sizeof(tmp), &tmp, type | byen);

	data = __le32_to_cpu(tmp);

and generic_ocp_read() starts with:

	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
		return -ENODEV;

That early return never touches the caller buffer, and the return value is
not checked, so tmp keeps its stack contents.  A genuine transfer error is
not affected because get_registers() does memset(data, 0xff, size).

Can that make the poll condition !(ocp_data & TGPHY_CMD_BUSY) true on
garbage, so rtl_tgphy_access() proceeds to issue the ADDR/CMD writes?

The same value also reaches user space on the read side:

	r8157_phy_read() -> ocp_reg_read() -> r8152_mdio_read()
	    -> rtl8152_ioctl(SIOCGMIIREG) -> data->val_out

rtl8152_ioctl() only tests RTL8152_INACCESSIBLE once on entry, so if
rtl_set_unplug() sets the flag while the ioctl is in flight, does val_out
end up carrying up to two bytes of kernel stack?

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
> +
> +out:
> +	return ret;
> +}
> +
> +static u16 r8157_phy_read(struct r8152 *tp, u16 addr)
> +{
> +	u16 data = 0;
> +
> +	rtl_tgphy_access(tp, addr, &data, false);
> +
> +	return data;
> +}
> +
> +static void r8157_phy_write(struct r8152 *tp, u16 addr, u16 data)
> +{
> +	rtl_tgphy_access(tp, addr, &data, true);
> +}

[Severity: Medium]
rtl_tgphy_access() carefully produces -ETIMEDOUT when TGPHY_CMD_BUSY stays
set for the full 20 ms, but both wrappers drop it.  Is that intentional?

On the read side r8157_phy_read() returns the pre-initialised 0 to the
caller, which cannot tell it apart from a real register value of 0.  Since
almost every PHY operation in this driver is a read-modify-write, that 0
gets written straight back into the live register:

	ocp_reg_w0w1()
		data = ocp_reg_read(tp, addr);
		data = (data & ~clear) | set;
		ocp_reg_write(tp, addr, data);

	r8152_mdio_set_bit()
		data = r8152_mdio_read(tp, addr);
		r8152_mdio_write(tp, addr, data | set);

so every bit the hardware actually held outside the set mask is cleared.
The comment in r8152_control_msg() describes what that costs:

	"Much of the code in the driver doesn't check for errors...
	 Writing back modified garbage like this can fully wedge the
	 adapter, requiring a power cycle"

A stuck TGPHY_CMD_BUSY is not a USB transfer error, so the
RTL8152_INACCESSIBLE / usb_queue_reset_device() protection that normally
catches this does not trigger.

On the write side r8157_phy_write() is void, so a timeout in the entry wait
skips the DATA/ADDR/CMD programming entirely and returns silently.  Does
that leave tp->ups_info, the cached speed/EEE state and
rtl8152_set_link_ksettings() recording settings the PHY never received,
with nothing in dmesg?

The driver's existing implementation of the same ADDR/DATA/CMD plus BUSY
protocol propagates the error instead: ocp_adv_read()/ocp_adv_write()
return int and rtl_bmu_read()/rtl_bmu_write()/rtl_bmu_w0w1() check it.
Would it be reasonable to at least log the failure, or to give the new
rtl_ops.phy_read/phy_write callbacks an error channel?

A related question on wait_tgphy_cmd_ready(): it has no
test_bit(RTL8152_INACCESSIBLE, &tp->flags) early-out, unlike the polling
loop in rtl_phy_patch_request():

		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
			return -ENODEV;

Once the device is gone, does each PHY access then burn up to 20 ms twice?
r8157_hw_phy_cfg()/r8159_hw_phy_cfg() perform hundreds of accesses from
rtl_hw_phy_work_func_t(), and rtl8152_disconnect() waits for that work with
cancel_delayed_work_sync(&tp->hw_phy_work), so can an unplug turn into a
multi-second stall?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903072852.58695-1-nic_swsd%40realtek.com
