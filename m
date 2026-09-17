Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4484FDA57;
	Thu, 17 Sep 2026 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789680311; cv=none; b=uSg6iEb7F5dJZv3eUXnEXNpEWj1oKglAlUw7JoJKNOGvFtMvF3MVNmZe2W2VhGgKhfqhYj4Td3xDnlRWrIq9S4eqxPc1b9VrYe6de5cl1MLKn0BK7Gz8anEPTNXMjxf9nY1VSbH17TWYG48WWCniVT+3fWvWnG57MJt0QXfCVV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789680311; c=relaxed/simple;
	bh=3Soqwa9aCnMRKp8Ckh5O4dwXgjowimeTvGOfgLH+uQg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VFUx9z7bChr8oabHbPVQNV0CsDCeULkVfKFN7EI6EAVWajkrFt6wHLPX9ifr6oQRyKdq4Fw6Q7Ne4lmonr4E9wMWuEySRHrahjrOqKyxpTvXYIeFxFbGNl9TkRRYfCqPrIabQ/FYRxZwIG0aiC+5Q+SfeSkzg7QdPqWtDmVpOCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxVaWUu9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxVaWUu9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F9D1F00898;
	Thu, 17 Sep 2026 21:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789680308;
	bh=33GWiymEFGZ9uHc1/28Y+Uzh4ovlAps01Ukc6z8eSPk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TxVaWUu9Z3GNPv+6+j8bbbvZyTBxvTvtA7LKQjT1dcTjLWFIkN8lgIaN0q1ixIx9I
	 m0Af0tTuP/3WefAZHP03IlM0xXE6BAitoGK7/6a25/Yh6+VtctuzF2VvgHuS1Sbsbt
	 P9BHtNbQ1qaC+dilJLrbh5Gkags2x7hPbz8NwVLUf0kXgY0Wf7fnbXawPyEUabU2yO
	 LbtMti9mcGe2l3XR39nuFoIVWvek3F8NdAFrxzWRkbuDd6SXfITdrtPPEdDOF8HAA/
	 tH4f7kp1qSGOJDA0H9n+w4iPns9R0OT9YndKnldUInvxX+uoguekVEb75e2RhBSPX/
	 HNZrDxZpkHCRg==
Subject: Re: [PATCH net-next v12 14/15] ax88179_178a: Add support for
 AX88179A/772D/279 EEPROM access
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
Date: Thu, 17 Sep 2026 21:25:07 +0000
Message-ID: <178968030755.22033.11537311081987859211@kernel.org>
In-Reply-To: <20260916-ax88179a-v12-14-60c04c9924a2@birger-koblitz.de>
References: <20260916-ax88179a-v12-14-60c04c9924a2@birger-koblitz.de>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 3 · Low: 0

- [Medium] The patch smuggles an undisclosed RX-path repair into an
  "EEPROM access" commit: `ax88179_bind()` now sets…
- [Medium] `ax88179_eeprom_access_params()`
  (drivers/net/usb/ax88179_lib.c:197-214) picks the hardware address…
- [Medium] `ax88179_get_eeprom()` (drivers/net/usb/ax88179_lib.c:237-249)
  only rejects `ret < 0` from `__ax88179_read_cmd()`, but…

--

ax88179_178a: Add support for AX88179A/772D/279 EEPROM access

This adds ethtool EEPROM read support for the AX88179A/772D eFuse array
and the AX88279 flash, by making the read block size and the access
command per-device instead of hardcoded 2-byte EEPROM words.  Write
access is refused for the newer parts.

> diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
> index 2601a8875b9e2..4c69568ec4a23 100644
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
> +
> +	ax179_data->chip_version = (ax179_data->chip_version & 0xf0) >> 4;
> +	ax179_data->is_ax88772d = 0;
> +	ax179_data->ip_align = 1;
                              ^^^

[Severity: Medium]
Is this ip_align assignment related to EEPROM access at all?  It looks
like an RX-path change that belongs to a different patch in the series.

ip_align has no EEPROM consumer.  Its only user is ax88179_set_multicast()
in ax88179_lib.c, which decides whether the hardware inserts the 2-byte
IP alignment pseudo header:

	data->rxctl = (AX_RX_CTL_START | AX_RX_CTL_AB | AX_RX_CTL_DROPCRCERR);
	if (data->ip_align)
		data->rxctl |= AX_RX_CTL_IPE;

That gating was introduced earlier in this series ("ax88179_178a: Add
AX179A/AX279 multicast configuration"), and until this commit nothing on
the ax88179_178a.c path ever set ip_align, so it stayed 0 from kzalloc.
Meanwhile ax88179_rx_fixup() strips the pad unconditionally:

	/* Skip IP alignment pseudo header */
	skb_pull(skb, 2);

Since ax88179_set_multicast() is wired as .ndo_set_rx_mode in
ax88179_netdev_ops, dev_open() -> __dev_open() -> dev_set_rx_mode() runs
it on every "ip link set up", and again on promisc/allmulti/multicast
changes.  Does that mean every frame received on classic AX88179/178A
adapters is shifted by 2 bytes in the intermediate commits of the series,
and that this line is the fix?

Would it make sense to move this initialization into the commit that added
the ip_align gating (or carry a Fixes: tag if that commit is already
applied), and mention it in the changelog?

>  	ax179_data->eeprom_read_cmd = AX_ACCESS_EEPROM;
>  	ax179_data->eeprom_write_cmd = AX_ACCESS_EEPROM;
>  	ax179_data->eeprom_block = 2;
> +	ax179_data->eeprom_wen = 0;
> +
>  	dev->net->netdev_ops = &ax88179_netdev_ops;
>  	dev->net->ethtool_ops = &ax88179_ethtool_ops;
>  	dev->net->needed_headroom = 8;

[ ... ]

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
Should the address encoding be derived from the raw chip_version nibble
here, rather than from the eeprom_read_cmd/eeprom_block pair that the same
request already uses?

chip_version comes straight from the device in ax88179_bind():

	ret = ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_CHIP_STATUS,
			       1, 1, &ax179_data->chip_version);
	...
	ax179_data->chip_version = (ax179_data->chip_version & 0xf0) >> 4;

and it is never checked against enum ax_chip_version in ax88179_lib.h,
which only defines 0x0, 0x4, 0x6 and 0x7.  For a device bound by
ax88179_178a.c that reports any nibble >= 0x6 (rebadged clone,
unenumerated silicon, or a register that reads back 0xf), bind() has
already declared word-addressable EEPROM (AX_ACCESS_EEPROM, block 2), but
this helper hands out eFuse-style (i << 4) or flash-style addresses.  Does
ethtool -e then return bytes from unrelated EEPROM addresses on such a
device?

The same nibble is now used to refuse writes:

	ax179_data = dev->driver_priv;
	if (ax179_data->chip_version >= AX_VERSION_AX88179A)
		return -EOPNOTSUPP;

Is that gate better expressed in terms of eeprom_write_cmd/eeprom_wen?  As
written, a legacy device reporting >= 0x6 loses ethtool -E even though
bind() configured AX_ACCESS_EEPROM with eeprom_wen = 0, which worked at
the parent commit.

There is also a predicate mismatch between the three users of the nibble.
ax88179a_bind() picks flash parameters with an equality test:

	if (ax179_data->chip_version == AX_VERSION_AX88279) {
		ax179_data->ip_align = 1;
		ax179_data->eeprom_read_cmd = AX88179A_FLASH_READ;

while ax88179a_get_eeprom_len() and this helper both use >=:

	if (ax179_data->chip_version >= AX_VERSION_AX88279)
		return AX88279_EEPROM_LEN;
	else
		return AX88179A_EEPROM_LEN;

For a nibble of 0x8-0xf, doesn't that combine eFuse geometry from bind
(AX_ACCESS_EFUS, 20-byte blocks) with the 16 KiB length and flash-style
addressing, so ethtool issues hundreds of AX_ACCESS_EFUS transfers with
addresses well past the 32 x 20 byte eFuse array and reports the results
as EEPROM contents?

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
      ^^^^^

[Severity: Medium]
Should this test be ret != ax179_data->eeprom_block instead of ret < 0?

__usbnet_read_cmd() in usbnet.c returns the number of bytes the device
actually transferred, and copies only that many:

	err = usb_control_msg(dev->udev, usb_rcvctrlpipe(dev->udev, 0),
			      cmd, reqtype, value, index, buf, size,
			      USB_CTRL_GET_TIMEOUT);
	if (err > 0 && err <= size) {
		if (data)
			memcpy(data, buf, err);

So a zero-length or short response is accepted here as a complete block,
and since the buffer is now kzalloc()ed, the untransferred remainder is
handed to userspace as 0x00.  Does that make a failed or partial device
read indistinguishable from an unprogrammed eFuse/flash region?

The old loop had the same ret < 0 test but only ever asked for a single
2-byte word; this patch now requests 20-byte AX_ACCESS_EFUS and 256-byte
AX88179A_FLASH_READ transfers per iteration, where a busy device or a
rejected address can legitimately short-read.

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
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916-ax88179a-v12-0-60c04c9924a2%40birger-koblitz.de
