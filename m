Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4007D568555;
	Wed,  9 Sep 2026 13:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788960731; cv=none; b=gAqBlCkPLs2njpzHM4tssF3FmTqfO9tFiNCnSdpZGqnboQAocGwAzaJKvPZz3E0WqOAce0e1+A7q9NUUGciLyFL0RiMtI/e2SsxeHmltOIXmXqeZqS10AdNR2tZ4Jxua4i1mAMSjmpbToPi7KEsvXosmxGRfJ7HgkygMp6OT+Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788960731; c=relaxed/simple;
	bh=2cddmGxJvKE6p0fTPtnvk2b4v+6soNlOKOq0aF75KNE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DMObofyJAA5nqhzYJpFPYlDrLxgP2119G11U3lh1OH92ZlLJjOzDC+gaXT58VluLlO4l43Ij/7IAol1omkPGz8Vcuo5VZ7O+huMSYMrMayzeAAqYz/53gaKhQN9uqao9ZeFOOrN96Euz/O3J0BxEdkXUzD79fSu1Ta23+dmhPuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvI5BvFC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvI5BvFC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562D01F00A3D;
	Wed,  9 Sep 2026 13:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788960728;
	bh=IWftTjYMYtHuj5dvN9YtLjGRmBrY0BqTVweyBMNifCc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MvI5BvFC8eSn1eH3nVptiuHGS4BUfVhhx6H5TW7oIZuhlRZUWXjY3AuNuJqaZIawC
	 LtjMP2peqv2AxGTfAUReCaxe1NuYzJfGlI0W61aAAOHkWIulxUxfQLCcJ1XVPVWhrj
	 jm3aDUataPQOi5+TYU/flOs6q/x4CglZKfxbWs9EZAsiE3/2TQwlmVA677OQV9N7Rs
	 WYPFK0CcFhuGD0ttJe/PpHYDwKTOpK4UAdihUVi8w/O0ZXEAgreWiDNAm+dmTTOk7D
	 elXGuRXBuq96/nDy/4d4N+XMfnAUKN5ejoehvVd5QVGjOuRuCZ+cm6J/QzudQza9DS
	 OzpbJUEPY1tBQ==
Subject:
 Re: [PATCH net-next v2 2/8] r8152: support RTL8159 for different packages
From: netdev-bot+sashiko@kernel.org
To: hsu.chih.kai@realtek.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch
Date: Wed, 09 Sep 2026 13:32:07 +0000
Message-ID: <178896072788.219967.6492714424364526395@kernel.org>
In-Reply-To: <20260903072852.58695-3-nic_swsd@realtek.com>
References: <20260903072852.58695-3-nic_swsd@realtek.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

- [Medium] Fail-closed RTL8159 package detection with no error channel:
  `__rtl_get_pkg_det()` (drivers/net/usb/r8152.c:10234) returns the…
- [Low] The commit message ("RTL8159 comes in two packages, QFN68 and
  QFN100, which require different handling.

--

r8152: support RTL8159 for different packages

This splits RTL_VER_17 into RTL_VER_17_QFN68 and RTL_VER_17_QFN100, adds a
new PLA_PKG_DET register read during hardware version detection to tell the
two packages apart, and adds a QFN68-only register write in r8159_init().
All existing RTL_VER_17 switch arms are expanded to cover both new values.

A couple of questions below.

> r8152: support RTL8159 for different packages
> 
>     RTL8159 comes in two packages, QFN68 and QFN100, which require different
>     handling. Split RTL_VER_17 into RTL_VER_17_QFN68 and RTL_VER_17_QFN100.

[Severity: Low]
Could the changelog mention the behaviour changes that come along with the
enum split?

Three things are not described:

- a new USB control transfer is issued at version-detection time by
  __rtl_get_pkg_det() to read PLA_PKG_DET

- an RTL8159 with chip id 0x2020 is now reported as RTL_VER_UNKNOWN unless
  PLA_PKG_DET reads back as one of exactly four values, which makes probe
  fail with -ENODEV where the previous code always accepted the chip

- r8159_init() gains a QFN68-only write ("u2phy backup restore patch") to
  0xb99c

The last two in particular matter for anyone deciding whether to backport
this.

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 013e8d1abfc2..f01f442fa71a 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -64,6 +64,7 @@
>  #define PLA_MACDBG_POST		0xd38e	/* RTL_VER_04 only */
>  #define PLA_EXTRA_STATUS	0xd398
>  #define PLA_GPHY_CTRL		0xd3ae
> +#define PLA_PKG_DET		0xdc48
>  #define PLA_POL_GPIO_CTRL	0xdc6a
>  #define PLA_EFUSE_DATA		0xdd00
>  #define PLA_EFUSE_CMD		0xdd02
> @@ -290,6 +291,9 @@
>  #define IFG_144NS		BIT(9)
>  #define IFG_96NS		(BIT(9) | BIT(8))
>  
> +/* PLA_PKG_DET */
> +#define PKG_MASK		0x1e
> +

[ ... ]

> @@ -8716,6 +8739,10 @@ static void r8159_init(struct r8152 *tp)
>  	/* TX descriptor Signature */
>  	ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xd4ae, BIT(1));
>  
> +	/* Enable u2phy backup restore patch */
> +	if (tp->version == RTL_VER_17_QFN68)
> +		ocp_byte_set_bits(tp, MCU_TYPE_USB, 0xb99c, BIT(0));
> +

[ ... ]

> @@ -10202,9 +10231,33 @@ static int rtl_fw_init(struct r8152 *tp)
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
> +

[Severity: Medium]
Should __rtl_get_pkg_det() report the transfer status separately from the
register value?

Right now 0 is returned in three different situations:

- kmalloc_obj(*tmp) failed

- all three usb_control_msg() attempts failed, so the "if (ret > 0)" block
  is skipped and pkg_det keeps its initial value

- PLA_PKG_DET genuinely read back with no bits of PKG_MASK (0x1e) set

Since 0 is also a legal value of the new 0x1e field, can the caller tell
"register never read" from "package encoding 0"?

> @@ -10287,7 +10340,16 @@ static u8 __rtl_get_hw_ver(struct usb_device *udev)
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
> +			dev_info(&udev->dev, "Unknown package %#02x\n",
> +				 pkg_det);
> +		}
>  		break;

Following on from the above: with the failure sentinel 0 landing in the else
branch, does a memory allocation failure or three failed control transfers
turn a perfectly good RTL8159 into an unsupported device?

The chip id read itself already succeeded here, and before this patch every
0x2020 was driven as RTL_VER_17. Now both consumers of the result treat
RTL_VER_UNKNOWN as "not our device":

rtl8152_probe()
	version = rtl8152_get_version(intf);
	if (version == RTL_VER_UNKNOWN)
		return -ENODEV;

	for (i = 0; i < RTL8152_PROBE_TRIES; i++) {

so the -ENODEV happens before the RTL8152_PROBE_TRIES retry loop gets a
chance to run, and:

rtl8152_cfgselector_probe()
	if (__rtl_get_hw_ver(udev) == RTL_VER_UNKNOWN)
		return -ENODEV;

which leaves the adapter in CDC/NCM mode handled by r8153_ecm or cdc_ether
rather than switching it to vendor mode. Meanwhile rtl8152_table still
lists product 0x815a, rtl_ops_init() has an RTL_VER_17_* arm and
MODULE_FIRMWARE(FIRMWARE_8159_1) is still declared, so the device looks
supported everywhere else.

Would propagating the usb_control_msg() status out of __rtl_get_pkg_det()
(return code or out-parameter) and only reporting "Unknown package" when the
register was actually read work better here? Similarly, for a PLA_PKG_DET
strap encoding other than 0x18/0x1a/0x1c/0x1e (all four of which need bits 4
and 3 set), is rejecting the device preferable to defaulting to one of the
two variants as the baseline driver effectively did?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903072852.58695-1-nic_swsd%40realtek.com
