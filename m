Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4465644F54F;
	Mon, 21 Sep 2026 08:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789979435; cv=none; b=W1vR7nLiXNqtixc5nV3VOmrNnDngqVSdRlYJOf78PeeZ3wrabAlGHdwi2sOhbu5uQi4N4EuNZu3oNU32/wNPnotztVttdtFJaNL5fso6ZwhFUgLju6Eyi9zEis6Zia0eD5itwAyE5eS632lo2FJQgJgCTrtHvd9HuaT/3wR2ydk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789979435; c=relaxed/simple;
	bh=rM2ZUIB/3BfLVVfCHCyqnkDXPS8MZJ8efTNz0EFFAaw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=St1ZSadhEzh6Ccj9GI1dmTiOIrLqnZuTtlWdQdrk5kvj1QkKGMCajrrnEzsmK1zzvYcRXVoxdi7rU8riGXSx8eRgW1TD/spk48lv2kKH7lPS36KuVFRNI2UYS5Gin+Y8S2H/ZIjL2857jrIsXmkIgcJgAf3ErRZdkhWfg4f6YlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIpcT3aP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIpcT3aP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE771F00893;
	Mon, 21 Sep 2026 08:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789979433;
	bh=UbfNGOQhNZ21srVMGo7eKhNp2orhOxDwusAwsJDP4rw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MIpcT3aPnztR82TjD0+FTMaPb1EW6mDepEwPP7NKff7kLHzJNiAy7C2iepVY332cd
	 PtHeVr9fBsD+5f8LKXwyYABM0K1MYga9Q1U4MrSJfTw504DioL4neqrGTpPbNPOrJb
	 ULzJLqRqfaMSeoxJlV6yIja9Wtw//dDHlf4v4yjnwRPqzmA9ADIBlW59xMdmt8x0Nk
	 P6PwfkwLjqK2Mwp2hv7WrMvQjQaiByLSGSOXs7QQd3kNxHRLmwMESWZ+38jbvI2ndq
	 u299KWxtZm29iVm4YNxO7mYWKKvYrh//t959Z6cIp6qHBGPVJA7IeQWlAT1/xvc5ZC
	 GssOByPGN6Jqg==
Subject: Re: [PATCH net-next v4 2/8] r8152: split RTL_VER_17 into QFN68 and
 QFN100 package variants
From: netdev-bot+sashiko@kernel.org
To: hsu.chih.kai@realtek.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch
Date: Mon, 21 Sep 2026 08:30:32 +0000
Message-ID: <178997943250.2160803.10390789676459730535@kernel.org>
In-Reply-To: <20260917070637.62827-3-nic_swsd@realtek.com>
References: <20260917070637.62827-3-nic_swsd@realtek.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] A failed or unrecognised PLA_PKG_DET read makes an already-
  identified RTL8159 (chip ID 0x2020) unusable.
- [Low] The commit message states the patch splits the enum and updates
  'every switch/case on RTL_VER_17', but it does not mention that the…
- [Low] The new diagnostic in __rtl_get_hw_ver() uses
  `dev_info(&udev->dev, "Unknown package %#02x\n", pkg_det)`.

--

r8152: split RTL_VER_17 into QFN68 and QFN100 package variants

This splits RTL_VER_17 into RTL_VER_17_QFN68 and RTL_VER_17_QFN100 and
updates the version switches accordingly. The package is detected by
reading the new PLA_PKG_DET register through a new __rtl_get_pkg_det()
helper called from __rtl_get_hw_ver() for chip ID 0x2020.

A couple of questions below.

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 00b0fda306c30..9ce072c38b5b5 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c

[ ... ]

> @@ -6404,8 +6419,15 @@ static int rtl8156_enable(struct r8152 *tp)
>  	set_tx_qlen(tp);
>  	rtl_set_eee_plus(tp);
>  
> -	if (tp->version >= RTL_VER_12 && tp->version <= RTL_VER_17)
> -		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_RX_AGGR_NUM, RX_AGGR_NUM_MASK);
> +	switch (tp->version) {
> +	case RTL_VER_10:
> +	case RTL_VER_11:
> +		break;
> +	default:
> +		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_RX_AGGR_NUM,
> +				  RX_AGGR_NUM_MASK);
> +		break;
> +	}

[Severity: Low]
This isn't a bug, but the changelog only says "update every switch/case on
RTL_VER_17 in the driver to handle both", and this hunk does something
else: the positive range test

	if (tp->version >= RTL_VER_12 && tp->version <= RTL_VER_17)

becomes an exclusion list, so every version other than RTL_VER_10 and
RTL_VER_11 that reaches rtl8156_enable() now clears RX_AGGR_NUM_MASK by
default.

With the versions rtl_ops_init() currently routes to rtl8156_enable() the
resulting register writes are identical, and the later patch "r8152: split
rtl8156_enable/up/down into per-chip-family functions" removes this switch
again, so there is no behavioural change in the tree.

Could the changelog mention the inverted version gate, since it is not just
an enum rename?

[ ... ]

> @@ -10182,9 +10211,33 @@ static int rtl_fw_init(struct r8152 *tp)
>  	return 0;
>  }
>  
> +static u32 __rtl_get_pkg_det(struct usb_device *udev)
> +{
> +	u32 pkg_det = 0;
> +	__le32 *tmp;
> +	int ret, i;
> +
> +	tmp = kmalloc_obj(*tmp);
> +	if (!tmp)
> +		return 0;
> +
> +	for (i = 0, ret = 0; i < 3 && ret != 4; i++)
> +		ret = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
> +				      RTL8152_REQ_GET_REGS, RTL8152_REQT_READ,
> +				      PLA_PKG_DET, MCU_TYPE_PLA, tmp,
> +				      sizeof(*tmp), USB_CTRL_GET_TIMEOUT);
> +
> +	if (ret > 0)
> +		pkg_det = __le32_to_cpu(*tmp) & PKG_MASK;
> +
> +	kfree(tmp);
> +	return pkg_det;
> +}

[Severity: High]
Can __rtl_get_pkg_det() report a read failure to its caller?

Both the allocation failure path and the "all three control transfers
failed" path return 0, which is also a legal register value (PKG_DET bits
[4:1] all zero), so the caller cannot tell an -EPIPE/-ETIMEDOUT/-ENOMEM
from real strap data.

Two smaller points in the same helper:

The loop's success condition is ret == 4, but the value is consumed when
ret > 0, so a short control transfer would be accepted and the unread
bytes of the kmalloc'ed (non-zeroed) buffer would be folded into pkg_det.
Should this test be ret == sizeof(*tmp), matching the loop?

The version read a few lines above retries and complains with
dev_warn("Needed %d retries to read version") when the transfer misbehaves.
Would it be worth propagating an error here in the same spirit, e.g.
returning the usb_control_msg() error via an out parameter?

>  static u8 __rtl_get_hw_ver(struct usb_device *udev)
>  {
>  	u32 ocp_data = 0;
> +	u32 pkg_det = 0;
>  	__le32 *tmp;
>  	u8 version;
>  	int ret;

[ ... ]

> @@ -10267,7 +10320,16 @@ static u8 __rtl_get_hw_ver(struct usb_device *udev)
>  		version = RTL_VER_16;
>  		break;
>  	case 0x2020:
> -		version = RTL_VER_17;
> +		pkg_det = __rtl_get_pkg_det(udev);
> +		if (pkg_det == 0x1e || pkg_det == 0x1c) {
> +			version = RTL_VER_17_QFN68;
> +		} else if (pkg_det == 0x18 || pkg_det == 0x1a) {
> +			version = RTL_VER_17_QFN100;
> +		} else {
> +			version = RTL_VER_UNKNOWN;

[Severity: High]
Following on from the helper above: does a single failed PLA_PKG_DET read
make an already identified RTL8159 unusable?

The chip has been positively identified from PLA_TCR0/TCR1 as 0x2020 at
this point, but a failed read yields pkg_det == 0, which lands in the else
branch and becomes RTL_VER_UNKNOWN. In rtl8152_probe():

	version = rtl8152_get_version(intf);
	if (version == RTL_VER_UNKNOWN)
		return -ENODEV;

	for (i = 0; i < RTL8152_PROBE_TRIES; i++) {

so the -ENODEV happens before the RTL8152_PROBE_TRIES retry loop and a
transient control-transfer error is not retried at probe level either.

rtl8152_cfgselector_choose_configuration() has the same test:

	/* Switch the device to vendor mode, if and only if the vendor mode
	 * driver supports it.
	 */
	if (__rtl_get_hw_ver(udev) == RTL_VER_UNKNOWN)
		return -ENODEV;

which leaves the device in its default CDC configuration, and
rtl8153_ecm_probe() then treats the zero version as "r8152 does not
support this device":

drivers/net/usb/r8153_ecm.c:
	if (rtl8152_get_version(intf))
		return -ENODEV;

Before this patch chip ID 0x2020 unconditionally bound as RTL_VER_17.
Would it make sense to keep binding when the PKG_DET read itself fails,
and only fall back to RTL_VER_UNKNOWN for a value that was actually read?

The same else branch is also taken for the twelve other encodings
PKG_MASK = 0x1e can produce. Is rejecting the device the intended
behaviour for those, or should one of the two packages be the default?

> +			dev_info(&udev->dev, "Unknown package %#02x\n",
> +				 pkg_det);

[Severity: Low]
Does this format string produce the intended padding? The kernel
vsnprintf() counts the "0x" emitted by the '#' flag inside the field
width, so "%#02x" behaves like "%#x": pkg_det == 0 prints as 0x0 rather
than 0x00. The sibling message in the default case of the same switch uses

	dev_info(&udev->dev, "Unknown version 0x%04x\n", ocp_data);

Would "%#04x" be what was meant here?

> +		}
>  		break;
>  	default:
>  		version = RTL_VER_UNKNOWN;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917070637.62827-1-nic_swsd%40realtek.com
