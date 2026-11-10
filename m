Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274726;
	b=zZE35qwso4r7vbBQ+z3j45vnGLFOmWTrUSICNebX9ZSlEUq6O23pHT5ajf5+MUeCwXRS
	 DhmAKaMvdPFzeIbTRxUeASZ8NACKNWkPEv63enZAgsUBjH2icB5+OYm2uANdjBeoQSfAb
	 c9jWh7RwfpNuS9e3VzGptBfC/ETCVLdfU3GQG9YcgYr0D3cSYtTx7fmlh9tYb6cOSJnuJ
	 MURe2p2SWIaODWijSutw3BPIA+r1g6psrAY+9j5koX5oyj5GY1q03DTk4qgOUiWs4kRW+
	 sm+Pf+nKFMIv6klapHmZgsJxV6i011iNYLBRpwFswc1iIju3iJYJJ4JQQitGO09ybzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274726;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=2gT4xkmYTZQ1QAjCys64b42dgibXNxZEFuSdlN9sffs=;
	b=bk9IfGCVcsICggyk5Y0kjGJ91eqKiJakOk9iv5RswfxT5iu1AQTpEgzXPMBUA0SmknGg
	 TGanZE0+bV2FkOOupJEM7+rwCTwSKW+b8feunjg9kvV8i9lqd/Pyq/ZZ7MRKLfaqlRx/2
	 3qJuLsBoYdKSzzXomBOULvuDgycpkiqneqjkCFmdxRi3s0RQo7tb0N7f0PdL+3XgpuSr0
	 nqOzx9bye9H92pLn304RA10Z4077sb8OYAq19F/91LZLNAH+XE+T7KKF5KegZfrIaAVjS
	 4vZ+l0EVVB3Qdv1YS/q/V/xwapHiT3soISbhtghRd4qaLfhY/b0gT2PBAtw6LYmZ3ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gLz4jP3i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E34260A380C;
	Tue, 10 Nov 2026 01:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gLz4jP3i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39021F0089F;
	Tue, 10 Nov 2026 01:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274725;
	bh=2gT4xkmYTZQ1QAjCys64b42dgibXNxZEFuSdlN9sffs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gLz4jP3iyleYaVGjPMkdPys2zSbH1I6rbzb22Rtr28kAVdZewFJVM1S5oqwkJJMLk
	 39zhsSyX1ZuhQ2cUXtuZGb/LAqyYiLB4WF70ed0V23DxPvKr3UU9NxUJ1n9ZwxVz81
	 SYlLZFRJiQAjhIXtRgS8wN3/vrw8x/gw/s6gXzF2jcy9db9NKY58rw8oNJnpBEnuP0
	 zBtl7kbUkMuVSsP57MUVcyUApjOWxnChPIOACNM4nQyODbslVyKazSouIUpjGTauuC
	 XkbBJweLnwTPb9+WaPmY+DjTQ459TFHKPPWnJkNkPEqMQhlUJtMH4zPA7qHcb/bBWP
	 oGRExSre9AKOg==
Subject: Re: [PATCH net-next v20 12/13] ax88179_178a: Add support for
 AX88179A/772D/279 EEPROM access
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, chenhuacai@kernel.org, kernel@xen0n.name,
 edumazet@kernel.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 neuromoments@gmail.com, beganovic.emir@gmail.com
Date: Tue, 10 Nov 2026 01:38:44 +0000
Message-ID: <179427472449.994134.11592093531851838540@kernel.org>
In-Reply-To: <20261106-ax88179a-v20-12-37b5a1189983@birger-koblitz.de>
References: <20261106-ax88179a-v20-12-37b5a1189983@birger-koblitz.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The EEPROM request encoding is split across two independent
  sources that can disagree.
- [Low] struct ax88179_data has two fields, eeprom_write_cmd and
  eeprom_wen, that both bind routines set and nothing ever reads.

--

ax88179_178a: Add support for AX88179A/772D/279 EEPROM access

This patch extends ax88179_get_eeprom() to read the efuses on the
AX88179A/772D and the FLASH on the AX88279. The opcode and block size
come from per-bind state, and a new helper computes wValue/wIndex.
ax88179_set_eeprom() now returns -EOPNOTSUPP for AX88179A and later
chips.

> diff --git a/drivers/net/usb/ax88179_lib.c b/drivers/net/usb/ax88179_lib.c
> index b54e98e781f33..d5bbaa0c4e4c6 100644
> --- a/drivers/net/usb/ax88179_lib.c
> +++ b/drivers/net/usb/ax88179_lib.c
> @@ -210,36 +210,61 @@ int ax88179_set_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo)
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
> +	} else if (ax179_data->chip_version == AX_VERSION_AX88279) {
> +		*value = (i * ax179_data->eeprom_block) >> 16;
> +		*idx = (i * ax179_data->eeprom_block) & 0xffff;
> +	} else {
> +		*value = i << 4;
> +		*idx = 0;
> +	}
> +}

[ ... ]

> +	for (i = first; i <= last; i++) {
> +		u16 value, idx;
> +
> +		ax88179_eeprom_access_params(ax179_data, i, &value, &idx);
> +		ret = __ax88179_read_cmd(dev, ax179_data->eeprom_read_cmd,
> +					 value, idx, ax179_data->eeprom_block,
> +					 eeprom_buff + (i - first) * ax179_data->eeprom_block);

[Severity: Medium]

Can the addressing mode and the rest of this request disagree?

ax88179_eeprom_access_params() picks value/idx from chip_version alone.
The opcode and transfer length passed to __ax88179_read_cmd() come from
eeprom_read_cmd and eeprom_block, which are set at bind time. chip_version
is the raw upper nibble of AX_CHIP_STATUS, and neither bind routine
validates it.

In ax88179_bind() in ax88179_178a.c:

	ax179_data->chip_version = (ax179_data->chip_version & 0xf0) >> 4;
	...
	ax179_data->eeprom_read_cmd = AX_ACCESS_EEPROM;
	ax179_data->eeprom_write_cmd = AX_ACCESS_EEPROM;
	ax179_data->eeprom_block = 2;

Suppose a device bound by ax88179_bind() (generic 0b95:1790, AX88178A,
Cypress GX3, or one of the OEM IDs) reports a nibble >= 6. Would it then
get AX_ACCESS_EEPROM requests with efuse or FLASH style value/idx? Before
this patch the value=i, idx=1 encoding was always used.

The loop only checks ret == eeprom_block, so that data would go back to
userspace as EEPROM contents. ax88179_set_eeprom() would also start
returning -EOPNOTSUPP for a device that bind set up for word EEPROM
writes.

In ax88179a_bind() in ax88179a_devices.c, the geometry is chosen by
== AX_VERSION_AX88279 versus everything else:

	if (ax179_data->chip_version == AX_VERSION_AX88279) {
		...
		ax179_data->eeprom_read_cmd = AX88179A_FLASH_READ;
		...
		ax179_data->eeprom_block = 256;
	} else {
		...
		ax179_data->eeprom_read_cmd = AX_ACCESS_EFUS;
		...
		ax179_data->eeprom_block = 20;

ax88179a_get_eeprom_len() uses >= instead:

	if (ax179_data->chip_version >= AX_VERSION_AX88279)
		return AX88279_EEPROM_LEN;

With chip_version > 7, ethtool would see 16 KiB while the reads use the
20-byte efuse geometry. Couldn't that request efuse indices up to 819
when only 32 efuses exist?

ax88179a_get_drvinfo() and ax88179a_reset() both check for
chip_version < AX_VERSION_AX88179A. If that case happens under
ax88179a_bind(), this helper would send AX_ACCESS_EFUS with word EEPROM
value/idx and a 20-byte length.

ax88179_set_eeprom() doesn't block that case either. The legacy
AX_ACCESS_EEPROM word write loop and AX_RELOAD_EEPROM_EFUSE would then run
against the advertised 640-byte length.

Would it be more robust to store an explicit addressing mode in
ax88179_data at bind time, next to eeprom_read_cmd and eeprom_block?
ax88179_eeprom_access_params(), ax88179_set_eeprom() and the
get_eeprom_len callbacks could all use it. ax88179a_bind() could also
reject unknown chip versions, or default them consistently.

> +
> +		if (ret != ax179_data->eeprom_block) {
>  			kfree(eeprom_buff);
>  			return -EIO;
>  		}
>  	}

[ ... ]

> @@ -247,12 +272,17 @@ int ax88179_get_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom, u8
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

[Severity: Low]

This isn't a bug, but with writes disabled here for AX88179A/AX88279, are
the eeprom_write_cmd and eeprom_wen fields in struct ax88179_data used
anywhere?

Both bind routines set them. For example, ax88179a_bind() does this for
the AX88279:

	ax179_data->eeprom_write_cmd = AX88179A_FLASH_WRITE;
	ax179_data->eeprom_block = 256;
	ax179_data->eeprom_wen = 1;

There don't seem to be any readers, though. The only write path,
ax88179_set_eeprom(), still hard-codes AX_ACCESS_EEPROM:

	ret = ax88179_write_cmd(dev, AX_ACCESS_EEPROM, i, 1, 2,
				&eeprom_buff[i - first_word]);

The commit message says "no write access is provided". Should these
fields be dropped until a write implementation actually uses them?

>  	netdev_dbg(net, "write EEPROM len %d, offset %d, magic 0x%x\n",
>  		   eeprom->len, eeprom->offset, eeprom->magic);
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106-ax88179a-v20-0-37b5a1189983%40birger-koblitz.de
