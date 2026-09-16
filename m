Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F443F5BE5;
	Wed, 16 Sep 2026 06:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541264; cv=none; b=G+Kiv22UnGKn5Z7y2UtUb/jkhJdNAnPm2HMWmtvc4sb4xE+aexndrbW56nN1FCUYTJUnA+kuxCFl1VLemvwB3STlkO+4TncVwXTYVdiXdCUxVa/ZJn4ne95fgsKHpUZSy5Tkqvb9oATBmkL4U5d6Ur3h7KGFrmJa5vKjjNSOYLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541264; c=relaxed/simple;
	bh=L0NkT2xmHELTyd2j103tabVYbeCkJg6TY3qHv32hius=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YWaCrNL85sCL1c2eJCvpuV32T/hBJKS8Xgx6drrTnC2QLegsK9SZ8+qrSnUvgD4WKGOXGt59NrEsYYfjsonPTKbUQnZZVPJ6OoijOxhZbU/+FrPele0mhWt4X3P09vyHvGwEhfILKF8FsMz4yl+fDwCNjit+1c6qzn18VgeLgrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0pW+TK7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0pW+TK7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EEC1F00893;
	Wed, 16 Sep 2026 06:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789541259;
	bh=XoWTgTXyTSXH4k1+CZotQ9kHn8M2l1WPWjOARxGJJ6E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=l0pW+TK7zDuRgAe67rC4Xw4ub5mgxV4Y6be/BuDb0UYSq8XoLmirroEtoFz/785AG
	 QTscP5amyt1gidwODGwX8Nxr0Ogu3YVbO9CBl8K3rDiRf9LU7MbpKT1Hv88NAugqDP
	 8UMZVBLSzXTyY6cXzTHT5dqSpFF4AKtssxyYtQhVJ4fUDHUfngeDlVPAfMVOq9TG9n
	 uaZx33gO3GCaXHVPKU/IJ2qwv1tavCoPjMPisVNnZejPXLTOqLB/KG2z3rmPqPfidI
	 JLGk8fuBDwM1HpjmPDGEsGF1jDHVXJG5q3YOecUdvMpb7i8iWjQyGmJ3Akfu3UyRqw
	 SbE5qkha/wrxA==
Subject: Re: [PATCH net-next v11 14/15] ax88179_178a: Add support for
 AX88179A/772D/279 EEPROM access
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
Date: Wed, 16 Sep 2026 06:47:38 +0000
Message-ID: <178954125868.22033.6143317038478457508@kernel.org>
In-Reply-To: <20260914-ax88179a-v11-14-5ea7a925ba6d@birger-koblitz.de>
References: <20260914-ax88179a-v11-14-5ea7a925ba6d@birger-koblitz.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 3 · Low: 1

- [Medium] Undisclosed behaviour change to the already-supported
  AX88179/AX88178A devices: ax88179_bind()…
- [Medium] The EEPROM access method is selected by three different,
  mutually inconsistent predicates over the same unvalidated device-…
- [Medium] For the AX88179A/AX88772D efuse path the new
  ax88179_eeprom_access_params() (drivers/net/usb/ax88179_lib.c:210-212)…
- [Low] Dead store on the new error path of ax88179_bind(): after
  `kfree(ax179_data);` the code clears the local variable (`ax179_data =…

--

ax88179_178a: Add support for AX88179A/772D/279 EEPROM access

This adds ethtool EEPROM read support for the AX88179A/772D efuses and the
AX88279 flash by generalising ax88179_get_eeprom() over a per-chip block
size and address encoding.  ax88179_bind() now samples the chip version and
initialises the new eeprom_* fields, and ax88179_set_eeprom() refuses
writes on the newer parts.

A few questions below.

> diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
> index 1d35ef90eceb7..55564aa0ca63f 100644
> --- a/drivers/net/usb/ax88179_178a.c
> +++ b/drivers/net/usb/ax88179_178a.c
> @@ -687,6 +687,19 @@ static int ax88179_bind(struct usbnet *dev, struct usb_interface *intf)
>  	ax179_data->resume = ax88179_resume;
>  	ax179_data->suspend = ax88179_suspend;
>  
> +	ret = ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_CHIP_STATUS,
> +			       1, 1, &ax179_data->chip_version);
> +	if (ret < 0)
> +		goto err_nodev;

[Severity: Medium]
Is the behaviour change for the already-supported parts intentional?  Before
this patch ax88179_bind() had no register read that could abort the probe;
now a single failing control transfer for AX_CHIP_STATUS makes bind return
an error for every driver_info entry using ax88179_bind() (AX88179,
AX88178A, Cypress GX3, D-Link, Sitecom, Samsung, Lenovo, Belkin, Toshiba,
MCT, AT-UMC*), and usbnet_probe() then goes to out1 -> free_netdev(), so no
netdev is created at all.

The commit message only says:

    The AX88179A/772D devices have 32 efuses with 20 bytes each,
    which can be randomly programmed. The AX88279 has 16K FLASH.

    Provide ethtool read capability for these devices.

Could the message mention that the legacy probe path now depends on this
read succeeding, and that ethtool -E on the legacy parts becomes conditional
on the device-reported version nibble (see the new gate in
ax88179_set_eeprom() below)?

> +
> +	ax179_data->chip_version = (ax179_data->chip_version & 0xf0) >> 4;
> +	ax179_data->is_ax88772d = 0;
> +	ax179_data->ip_align = 1;
> +	ax179_data->eeprom_read_cmd = AX_ACCESS_EEPROM;
> +	ax179_data->eeprom_write_cmd = AX_ACCESS_EEPROM;
> +	ax179_data->eeprom_block = 2;
> +	ax179_data->eeprom_wen = 0;
> +
>  	dev->net->netdev_ops = &ax88179_netdev_ops;
>  	dev->net->ethtool_ops = &ax88179_ethtool_ops;
>  	dev->net->needed_headroom = 8;
> @@ -711,6 +724,12 @@ static int ax88179_bind(struct usbnet *dev, struct usb_interface *intf)
>  	ax88179_reset(dev);
>  
>  	return 0;
> +
> +err_nodev:
> +	kfree(ax179_data);
> +	ax179_data = NULL;
       ^^^^^^^^^^^^^^^^^^

[Severity: Low]
Does this assignment do anything?  ax179_data is a local that goes out of
scope immediately, while dev->driver_priv was published earlier in
ax88179_bind():

	dev->driver_priv = ax179_data;

so dev->driver_priv keeps pointing at the freed allocation.  Was
dev->driver_priv = NULL; intended here, or can the store simply be dropped?

There is no use-after-free today: usbnet_probe() jumps to out1 on bind
failure, which skips info->unbind and frees the netdev (and therefore the
private area) right away.

> +
> +	return ret;
>  }
>  
>  static void ax88179_unbind(struct usbnet *dev, struct usb_interface *intf)
> diff --git a/drivers/net/usb/ax88179_lib.c b/drivers/net/usb/ax88179_lib.c
> index 3b498206c50d5..db77b7d4539ec 100644
> --- a/drivers/net/usb/ax88179_lib.c
> +++ b/drivers/net/usb/ax88179_lib.c
> @@ -194,36 +194,61 @@ int ax88179_set_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo)
>  	return 0;
>  }
>  
> +static void
> +ax88179_eeprom_access_params(struct ax88179_data *ax179_data, int i, u16 *value, u16 *idx)
> +{
> +	/* AX88179 has a word-addressable EEPROM
> +	 * AX88179A uses EFUSES with 20 bytes length
> +	 * AX88279 has an EEPROM addressable in 256 byte blocks
> +	 */
> +	if (ax179_data->chip_version < AX_VERSION_AX88179A) {
> +		*value = i;
> +		*idx = 1;
> +	} else if (ax179_data->chip_version >= AX_VERSION_AX88279) {
> +		*value = (i * ax179_data->eeprom_block) >> 16;
> +		*idx = (i * ax179_data->eeprom_block) & 0xffff;
> +	} else {
> +		*value = i << 4;
> +		*idx = 0;
> +	}
> +}

[Severity: Medium]
Can the three predicates over chip_version disagree?  The address encoding
is chosen here with range tests, but the command and block size are chosen
elsewhere with different tests.

ax88179a_bind() in ax88179a_devices.c uses an exact match:

	if (ax179_data->chip_version == AX_VERSION_AX88279) {
		ax179_data->eeprom_read_cmd = AX88179A_FLASH_READ;
		ax179_data->eeprom_block = 256;
	} else {
		ax179_data->eeprom_read_cmd = AX_ACCESS_EFUS;
		ax179_data->eeprom_block = 20;
	}

ax88179a_get_eeprom_len() uses a range test:

	if (ax179_data->chip_version >= AX_VERSION_AX88279)
		return AX88279_EEPROM_LEN;
	else
		return AX88179A_EEPROM_LEN;

and the new code in ax88179_bind() hardcodes AX_ACCESS_EEPROM with
eeprom_block = 2 while still storing whatever nibble the chip reported.

The nibble from AX_CHIP_STATUS is not validated anywhere, so for a value
above AX_VERSION_AX88279 the helper picks the split flash addressing while
bind configured AX_ACCESS_EFUS with 20-byte transfers, and
get_eeprom_len() advertises 16 KiB.  Symmetrically, a legacy device
reporting a nibble >= AX_VERSION_AX88179A gets AX_ACCESS_EEPROM issued with
efuse or flash addressing at a 2-byte length, and ethtool -E turns into
-EOPNOTSUPP.  Would it be better to derive the addressing from
eeprom_read_cmd/eeprom_block, or to reject unknown version nibbles at bind
time?

[Severity: Medium]
For the efuse branch, are wValue and wIndex right?  The comment in this same
function says the efuses are 20 bytes long, ax88179a_bind() sets
eeprom_block = 20, AX88179A_EEPROM_LEN is (32 * 20) = 640, and
ax88179_get_eeprom() below derives first/last, the per-row buffer offset and
the transfer length from eeprom_block.  But the address here advances by 16
per row:

	*value = i << 4;
	*idx = 0;

The existing AX_ACCESS_EFUS user in this driver family passes a byte offset
in wValue and the access length in wIndex:

drivers/net/usb/ax88179_178a.c:ax88179_check_efuse() {
	...
	if (ax88179_read_cmd(dev, AX_ACCESS_EFUS, 0, 64, 64, efuse) < 0)
		return -EINVAL;
	...
}

Under that convention consecutive 20-byte reads spaced 16 bytes apart
overlap by 4 bytes per row and can only reach bytes 0..515 of the 640-byte
range ethtool is told about, and wIndex = 0 asks for a zero-length access
while 20 bytes are requested on the wire.

Does the failure stay silent?  __usbnet_read_cmd() copies only the bytes the
device actually returned and reports a positive value, and
ax88179_get_eeprom() only tests ret < 0, so a short or rejected efuse access
is handed to userspace as a successful read of the kzalloc'ed zeros.

Has the AX88179A redefined AX_ACCESS_EFUS so that wValue is a shifted row
index and wIndex is unused?  If so a comment would help, otherwise the
stride and the length field look inconsistent with eeprom_block = 20.

> +
>  int ax88179_get_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom, u8 *data)
>  {
>  	struct usbnet *dev = netdev_priv(net);
> -	u16 *eeprom_buff;
> -	int first_word, last_word;
> -	int i, ret;
> +	struct ax88179_data *ax179_data;
> +	int first, last, i, ret;
> +	u8 *eeprom_buff;
> +
> +	ax179_data = dev->driver_priv;
>  
>  	if (eeprom->len == 0)
>  		return -EINVAL;
>  
>  	eeprom->magic = AX88179_EEPROM_MAGIC;
>  
> -	first_word = eeprom->offset >> 1;
> -	last_word = (eeprom->offset + eeprom->len - 1) >> 1;
> -	eeprom_buff = kmalloc_array(last_word - first_word + 1, sizeof(u16),
> -				    GFP_KERNEL);
> +	first = eeprom->offset / ax179_data->eeprom_block;
> +	last = (eeprom->offset + eeprom->len - 1) / ax179_data->eeprom_block;
> +
> +	eeprom_buff = kzalloc((last - first + 1) * ax179_data->eeprom_block, GFP_KERNEL);
>  	if (!eeprom_buff)
>  		return -ENOMEM;
>  
> -	/* ax88179/178A returns 2 bytes from eeprom on read */
> -	for (i = first_word; i <= last_word; i++) {
> -		ret = __ax88179_read_cmd(dev, AX_ACCESS_EEPROM, i, 1, 2,
> -					 &eeprom_buff[i - first_word]);
> +	for (i = first; i <= last; i++) {
> +		u16 value, idx;
> +
> +		ax88179_eeprom_access_params(ax179_data, i, &value, &idx);
> +		ret = __ax88179_read_cmd(dev, ax179_data->eeprom_read_cmd,
> +					 value, idx, ax179_data->eeprom_block,
> +					 eeprom_buff + (i - first) * ax179_data->eeprom_block);
> +
>  		if (ret < 0) {
>  			kfree(eeprom_buff);
>  			return -EIO;
>  		}
>  	}
>  
> -	memcpy(data, (u8 *)eeprom_buff + (eeprom->offset & 1), eeprom->len);
> +	memcpy(data, eeprom_buff + eeprom->offset % ax179_data->eeprom_block, eeprom->len);
>  	kfree(eeprom_buff);
>  	return 0;
>  }
> @@ -231,12 +256,17 @@ int ax88179_get_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom, u8
>  int ax88179_set_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom, u8 *data)
>  {
>  	struct usbnet *dev = netdev_priv(net);
> +	struct ax88179_data *ax179_data;
>  	u16 *eeprom_buff;
>  	int first_word;
>  	int last_word;
>  	int ret;
>  	int i;
>  
> +	ax179_data = dev->driver_priv;
> +	if (ax179_data->chip_version >= AX_VERSION_AX88179A)
> +		return -EOPNOTSUPP;
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914-ax88179a-v11-0-5ea7a925ba6d%40birger-koblitz.de
