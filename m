Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274712;
	b=XlQ8x1Ti1EujNUPTkNKGlxNAEVzMrnIBjhO8QMtmgeZ+MSkshpTFUSP+2zt8iBP6F5d0
	 WlmteTjZa4v2fRTyxjGZsXDfxYqs7fvfLq7MOYB2zApyV44OVH4e2+0z4mbsYnKZuk0Tw
	 HrqqmVrzPwEqzY4NUqr933wnQh60N12Fixb8O0Tvc413PnbWzKGNi7xmrrgbnRm3K+fbv
	 GjAFyx051cHWuULGUtgUGn69vUISSF5/y+oact55UZomDa2VTvJgBLAQ/doEoqAYRJYq0
	 Ptjr/Wcqkesr4ca9OeSHx+TPCd+kCOR1FPeQ9kEVsJlJCk2sPSCDNlkV7ATYLuxWIjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274712;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Y7tdQjym8J95a6/U7vV5Laz+tn2VaoFtzuNilhh5ksk=;
	b=XuEdWLOV9vdo/kT+lIHZCN1h0zy9L20cYKPnvfVfe0n4vfgb/Zl+I3yuMrMKFdUF6Rf6
	 delCe9+e6jVQmcI2wE2Qyi6wKZuz8v3PSneFgAi9QADVBcM3Ck4EbYUZCMEARbvqYKNUl
	 R8hP9SHg3AJ9xhhgFRHLgrO3z1JkE/yMIDrTceA9oKFddK0slsrvh2UUqk/9c+VzAFKuj
	 b92MBYp/Ocb2b1dvY/aqbr2AMUj/oHkqKc6ppS/dYmexh3Gf/YHVs5lmFzvenwDR/RHm2
	 UX2ZbpWcrY1/EIrV/I3vuFRLirtkL8UKGP3AuFFNLbry0VfWi+dATXXKw5Gg9BW/zqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T9iwtHTS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892FD60A2638;
	Tue, 10 Nov 2026 01:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T9iwtHTS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464F61F008A6;
	Tue, 10 Nov 2026 01:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274712;
	bh=Y7tdQjym8J95a6/U7vV5Laz+tn2VaoFtzuNilhh5ksk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=T9iwtHTSmGwuxvHxrInQGPul4KPymMJNuF3MT725oS+oZMYUrKIssTUxzFPcus5uD
	 UMvGwyk5oMJnSpzGr7v7LF5BJmMrIyRNleX+6cBQ5+E2DOJQ22VRNutLnDZhxfzUJ+
	 6kEIhKPKul7dOnzAHg1U7eixVW9S2rbINTI1oDSMd6PS95+KrBOi8aKjlDiNJPhmJy
	 9w4wiUwd4NDUDVhkmZSBluD9HoOB6T/fwcwCQyyIAuqWuFjuX1yuyu4Bq6vMa+w3kR
	 k1Pphlg3KogGyc8/uyoSTrOvyu0JkzVvbr5h4PbXmgHXPSFzHVWgc27S4ZcwVfYrop
	 H5p8ibCA16+Jg==
Subject: Re: [PATCH net-next v20 03/13] ax88179_178a: Split driver into
 library and device specific code
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, chenhuacai@kernel.org, kernel@xen0n.name,
 edumazet@kernel.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 neuromoments@gmail.com, beganovic.emir@gmail.com
Date: Tue, 10 Nov 2026 01:38:30 +0000
Message-ID: <179427471082.994134.5058142083124643699@kernel.org>
In-Reply-To: <20261106-ax88179a-v20-3-37b5a1189983@birger-koblitz.de>
References: <20261106-ax88179a-v20-3-37b5a1189983@birger-koblitz.de>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message describes a pure code move plus a module
  rename ('Split the ax88179_178a module code into code common to ...…
- [Medium] The new `medium_status_mutex` is documented as protecting
  AX_MEDIUM_STATUS_MODE (ax88179_lib.h:161), but in this commit only…
- [Medium] `ax88179_change_mtu()` (ax88179_lib.c:396-438) now returns an
  error from the new `err_out` path, but only after it has already done…
- [Medium] The patch renames the kernel module from ax88179_178a.ko to
  ax88179.ko (Makefile lines 15-16: `obj-$(CONFIG_USB_NET_AX88179_178A)…

Pre-existing issues:
- [Medium] In the moved `ax88179_get_eeprom()` (ax88179_lib.c:191-223),
  `eeprom_buff` comes from `kmalloc_array()` (line 205, not zeroed).
- [Medium] `ax88179_set_features()` (ax88179_lib.c:339-366, moved
  unchanged) toggles the checksum-offload registers by XOR on the…

--

ax88179_178a: Split driver into library and device specific code

This commit moves the register definitions, the USB command helpers and
the common ethtool/netdev callbacks of the ax88179_178a driver into a new
ax88179_lib.c and ax88179_lib.h. It also renames the module to ax88179 and
adds MODULE_ALIAS("ax88179_178a") for the old name.

> diff --git a/drivers/net/usb/Makefile b/drivers/net/usb/Makefile
> index 4964f7b326fbc..ddd76fa71e2ee 100644
> --- a/drivers/net/usb/Makefile
> +++ b/drivers/net/usb/Makefile
> @@ -12,7 +12,8 @@ obj-$(CONFIG_USB_HSO)		+= hso.o
>  obj-$(CONFIG_USB_LAN78XX)	+= lan78xx.o
>  obj-$(CONFIG_USB_NET_AX8817X)	+= asix.o
>  asix-y := asix_devices.o asix_common.o ax88172a.o
> -obj-$(CONFIG_USB_NET_AX88179_178A)      += ax88179_178a.o
> +obj-$(CONFIG_USB_NET_AX88179_178A)      += ax88179.o
> +ax88179-y := ax88179_178a.o ax88179_lib.o

[Severity: Medium]
This renames ax88179_178a.ko to ax88179.ko. The only compatibility added
is MODULE_ALIAS("ax88179_178a") in ax88179_178a.c.

The alias keeps "modprobe ax88179_178a" working. Will configuration that
matches on the real module name still take effect? For example:

  - "blacklist ax88179_178a" in modprobe.d. kmod compares the blacklist
    against the resolved module name, and the usb:v0B95p1790... modalias
    now resolves directly to ax88179.
  - module_blacklist=ax88179_178a on the kernel command line, which is
    compared against mod->name.
  - Anything that checks /sys/module/ax88179_178a.

Users of this device family often blacklist the vendor driver so that
cdc_ncm binds instead. The later patch "ax88179_178a: Add HW support for
AX179A-based chips" also relies on OS configuration to choose between this
module and cdc_ncm.

After an upgrade, could such systems quietly end up with this driver bound
again?

The rename is still there at the end of the series, which also renames the
Kconfig symbol and the usb_driver name to ax88179. Could the commit message
mention this limitation of the alias?

[ ... ]

> diff --git a/drivers/net/usb/ax88179_lib.c b/drivers/net/usb/ax88179_lib.c
> new file mode 100644
> index 0000000000000..063427ff55e42
> --- /dev/null
> +++ b/drivers/net/usb/ax88179_lib.c
> @@ -0,0 +1,461 @@

[ ... ]

> +int ax88179_get_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom, u8 *data)
> +{

[ ... ]

> +	first_word = eeprom->offset >> 1;
> +	last_word = (eeprom->offset + eeprom->len - 1) >> 1;
> +	eeprom_buff = kmalloc_array(last_word - first_word + 1, sizeof(u16),
> +				    GFP_KERNEL);
> +	if (!eeprom_buff)
> +		return -ENOMEM;
> +
> +	/* ax88179/178A returns 2 bytes from eeprom on read */
> +	for (i = first_word; i <= last_word; i++) {
> +		ret = __ax88179_read_cmd(dev, AX_ACCESS_EEPROM, i, 1, 2,
> +					 &eeprom_buff[i - first_word]);
> +		if (ret < 0) {
> +			kfree(eeprom_buff);
> +			return -EIO;
> +		}
> +	}
> +
> +	memcpy(data, (u8 *)eeprom_buff + (eeprom->offset & 1), eeprom->len);

[Severity: Medium]
This is a pre-existing issue that this patch moves without changes. Can
this memcpy() hand stale heap bytes from eeprom_buff to userspace?

eeprom_buff comes from kmalloc_array() and is not zeroed. Only ret < 0
counts as a failure. __usbnet_read_cmd() copies only the bytes that were
actually transferred and returns that short count:

drivers/net/usb/usbnet.c:__usbnet_read_cmd() {
    ...
	if (err > 0 && err <= size) {
		if (data)
			memcpy(data, buf, err);
    ...
}

If a device answers a 2-byte read with 0 or 1 bytes, eeprom_buff keeps
uninitialised bytes, and ETHTOOL_GEEPROM returns them to the caller.

ax88179_set_features() has a similar problem. Its u8 tmp is never
initialised, so a failed 1-byte read leads to a stack byte being XORed and
written to the COE register.

A later patch in the series, "ax88179_178a: Add support for
AX88179A/772D/279 EEPROM access", fixes the get_eeprom part. It switches to
kzalloc() and checks ret != ax179_data->eeprom_block. The set_features part
is still present at the end of the series.

[ ... ]

> +int ax88179_set_features(struct net_device *net, netdev_features_t features)
> +{
> +	u8 tmp;
> +	struct usbnet *dev = netdev_priv(net);
> +	netdev_features_t changed = net->features ^ features;
> +
> +	if (changed & NETIF_F_IP_CSUM) {
> +		ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_TXCOE_CTL, 1, 1, &tmp);
> +		tmp ^= AX_TXCOE_TCP | AX_TXCOE_UDP;
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_TXCOE_CTL, 1, 1, &tmp);
> +	}

[Severity: Medium]
This isn't a bug introduced by this patch, since the function moves
unchanged. Can the XOR toggle leave the hardware checksum offload out of
sync with net->features?

ax88179_reset() always turns on every COE bit, whatever net->features says:

drivers/net/usb/ax88179_178a.c:ax88179_reset() {
    ...
	*tmp = AX_TXCOE_IP | AX_TXCOE_TCP | AX_TXCOE_UDP |
	       AX_TXCOE_TCPV6 | AX_TXCOE_UDPV6;
	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_TXCOE_CTL, 1, 1, tmp);
    ...
}

ax88179_reset() runs from ax88179_resume() and from ax88179_net_reset().
Consider this sequence:

  ethtool -K tx off   -> TXCOE TCP/UDP cleared
  suspend/resume      -> ax88179_reset() sets all TXCOE bits again
  ethtool -K tx on    -> tmp ^= AX_TXCOE_TCP | AX_TXCOE_UDP clears them

NETIF_F_IP_CSUM ends up set while the MAC no longer fills in IPv4 TCP/UDP
checksums. Would CHECKSUM_PARTIAL frames then go out with bad L4 checksums?

Writing the absolute state derived from features, instead of toggling,
would avoid this. The code is still the same at the end of the series.

[ ... ]

> +int ax88179_change_mtu(struct net_device *net, int new_mtu)
> +{
> +	struct usbnet *dev = netdev_priv(net);
> +	struct ax88179_data *data;
> +	u16 tmp16;
> +	int err;
> +
> +	data = dev->driver_priv;
> +	mutex_lock(&data->medium_status_mutex);

[Severity: Medium]
The commit message describes this as a split of existing code plus a module
rename, but some of it is not a straight move. Compared with the code
removed from ax88179_178a.c:

  - struct ax88179_data gains medium_status_mutex, which ax88179_bind()
    initialises.
  - ax88179_change_mtu() now takes that mutex, checks every register
    access and can return an error. The old version had no lock and always
    returned 0.
  - The BUG_ON(!dev) checks in __ax88179_read_cmd() and
    __ax88179_write_cmd() are dropped.

Should these behaviour changes go in a separate patch with their own
justification, or at least be described in the commit message?

> +	WRITE_ONCE(net->mtu, new_mtu);
> +	dev->hard_mtu = net->mtu + net->hard_header_len;
> +	if (net->mtu > 1500) {
> +		err = ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE,
> +				       2, 2, &tmp16);
> +		if (err < 0)
> +			goto err_out;

[ ... ]

> +	mutex_unlock(&data->medium_status_mutex);
> +
> +	/* max qlen depend on hard_mtu and rx_urb_size */
> +	usbnet_update_max_qlen(dev);
> +
> +	return 0;
> +
> +err_out:
> +	mutex_unlock(&data->medium_status_mutex);
> +	return err;
> +}

[Severity: Medium]
On this error path, do net->mtu and dev->hard_mtu keep the new value even
though the MTU change is reported as failed?

Both are updated before any AX_MEDIUM_STATUS_MODE access. err_out does not
restore them and does not call usbnet_update_max_qlen(). The core does not
roll back on error either:

net/core/dev.c:netif_set_mtu_ext() {
    ...
	orig_mtu = dev->mtu;
	err = __netif_set_mtu(dev, new_mtu);

	if (!err) {
    ...
	return err;
}

So after a failed USB transfer:

  - userspace gets an error, but dev->mtu shows the new value
  - the NETDEV_CHANGEMTU notifiers are skipped
  - rx_qlen/tx_qlen no longer match hard_mtu

A retry with the same MTU then hits this check in netif_set_mtu_ext():

	if (new_mtu == dev->mtu)
		return 0;

It succeeds without touching the hardware, so AX_MEDIUM_JUMBO_EN stays
wrong for that MTU.

The old code always returned 0, so this inconsistency is new in this patch.
The function is the same at the end of the series.

[ ... ]

> diff --git a/drivers/net/usb/ax88179_lib.h b/drivers/net/usb/ax88179_lib.h
> new file mode 100644
> index 0000000000000..9111a1395eb2f
> --- /dev/null
> +++ b/drivers/net/usb/ax88179_lib.h
> @@ -0,0 +1,195 @@

[ ... ]

> +struct ax88179_data {
> +	struct mutex medium_status_mutex;  /* protect AX_MEDIUM_STATUS_MODE */

[Severity: Medium]
The comment says this mutex protects AX_MEDIUM_STATUS_MODE, but
ax88179_change_mtu() is the only function that takes it. Is that enough to
protect the register?

None of the other accessors in ax88179_178a.c take the mutex:
ax88179_suspend(), ax88179_link_reset(), ax88179_reset(),
ax88179_net_reset() and ax88179_stop().

ax88179_link_reset() runs from the kevent work without RTNL:

usbnet_deferred_kevent()
  info->link_reset(dev)
    ax88179_link_reset()

That means it can run at the same time as ax88179_change_mtu(), which runs
under RTNL. One possible interleaving:

  ax88179_change_mtu()              ax88179_link_reset()
  read AX_MEDIUM_STATUS_MODE
                                    write new speed/duplex mode
  write stale mode | JUMBO_EN

The MAC speed and duplex would then disagree with the PHY until the next
link event.

It can also go the other way. ax88179_link_reset() reads
dev->net->mtu <= 1500, then ax88179_change_mtu() sets JUMBO_EN, then
ax88179_link_reset() overwrites the register without JUMBO_EN. Would jumbo
frames then be dropped?

By the end of the series the AX88179A mac_link_up path in
ax88179a_devices.c also takes the mutex. The legacy accessors in
ax88179_178a.c and several accessors in ax88179a_devices.c still do not.

Should the other accessors take the mutex too, or should the comment say
what the mutex actually serialises?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106-ax88179a-v20-0-37b5a1189983%40birger-koblitz.de
