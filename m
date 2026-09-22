Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA3146D086;
	Tue, 22 Sep 2026 19:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106718; cv=none; b=BAOM5oLIPpe1QCLD301ZXEkq2dnWNGaF0l6CG3Agzo+V4oKDTuCl6gb2um800HrdYAtuXrdneU/v0FbOWEdGkf3zoaNnSP81/SSpzoxOFe/xEbr7/KCZIYO11ObYXdBwJimGyVrLKdebuj6HJiQhWtVodKiGkSp0gf9p9WYxA38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106718; c=relaxed/simple;
	bh=9R5CXjDYNBiUuqJqqxbarw4apjHiM4Oer8D+OA+W8ko=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lCkDbADF03Mom5vLZBTviHtGS5+j+eIeO2nbwPQVLXomM0Rz9tyjD61JavWDDCcdcddiySKhx8/lY8pchIcJ3S+MdjS8V8CfwQdTen5/y/aHecZYzhtQDYyBD503eheoGb2if/Ya4VOJ2I5Wlf2sVWk9R+Q9u842bwk17lDcHz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XoY1aLds; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XoY1aLds"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3C81F000FF;
	Tue, 22 Sep 2026 19:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790106716;
	bh=PsXty5IDKGkuqvA+Km0WMkwXIK2YK4kWiCl0RTrrt5I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XoY1aLds18uA1FkTmI+ll8odGN+bjDS/SknCH3GYfLwv5ChhZNwzCorR7WNnB5y8q
	 J32A7Xly8hOPG/3Qd4STyd5btIaA3oTU8DUo4HJasILMSZVpWBVypBNM9M5M1oL2fO
	 ChOPLx7UbKPgibAxCasebvWkYR/LWhctU26JMms/H92l30iwRoSmgLWowdkDCNvlUg
	 KeQAZRE5nUnzxb4cMfTLeyN4L9mdi/oMfw/NaNcHqHm42hJPe3shQKKx6D8XNK1vwa
	 8sTW0RCzN5TrGn0nYayGJvpd5vB5RybgvJyCzLbS0XO2tCbRVVrh11bcFZLR6LfvJb
	 Px+ixJavP+McA==
Subject: Re: [PATCH] net: usb: qmi_wwan: add common Huawei modem IDs
From: netdev-bot+sashiko@kernel.org
To: jackympoka22@gmail.com
Cc: bjorn@mork.no, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, 223556219+Copilot@users.noreply.github.com
Date: Tue, 22 Sep 2026 19:51:55 +0000
Message-ID: <179010671575.2160803.12741982130194822492@kernel.org>
In-Reply-To: <20260918193645.59374-1-jackympoka22@gmail.com>
References: <20260918193645.59374-1-jackympoka22@gmail.com>
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

Critical: 0 · High: 2 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Wrong interface number claimed for Huawei E1750 (12d1:1406),
  plus four further unverified interface-1 claims.
- [High] The new entry {QMI_FIXED_INTF(HUAWEI_VENDOR_ID,
  HUAWEI_PRODUCT_E173S6, 1)} binds qmi_wwan to Huawei 12d1:1c07…
- [Medium] Commit message does not describe the whole change.

--

net: usb: qmi_wwan: add common Huawei modem IDs

The commit adds seven HUAWEI_PRODUCT_* defines and converts the two
existing Huawei QMI_FIXED_INTF() entries to use them, while adding five
new Huawei product IDs bound at interface 1.  It also touches
qmimux_rx_fixup() and re-indents three Novatel table entries.

> diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
> index f51cf9cb9421..93aa403ed3e5 100644
> --- a/drivers/net/usb/qmi_wwan.c
> +++ b/drivers/net/usb/qmi_wwan.c
> @@ -216,10 +216,10 @@ static int qmimux_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
>  		if (netif_rx(skbn) != NET_RX_SUCCESS) {
>  			net->stats.rx_errors++;
>  			return 0;
> -		} else {
> -			dev_sw_netstats_rx_add(net, pkt_len);
>  		}
>  
> +		dev_sw_netstats_rx_add(net, pkt_len);
> +
>  skip:
>  		offset += len + qmimux_hdr_sz;
>  	}

[Severity: Medium]
Is this hunk intended to be part of this patch?  The commit message only
says:

    Add common Huawei product IDs to qmi_wwan fixed-interface mappings
    for broader generic Huawei modem coverage.

The rewrite looks functionally equivalent, but it is an edit to the qmimux
receive path in a commit that advertises itself as a USB ID addition.
Could it be split into its own patch so that a stable backport of the ID
list does not silently carry an rx path change?

> @@ -946,6 +946,13 @@ static const struct driver_info	qmi_wwan_info_quirk_dtr = {
>  };
>  
>  #define HUAWEI_VENDOR_ID	0x12D1
> +#define HUAWEI_PRODUCT_E1750	0x1406
> +#define HUAWEI_PRODUCT_E173	0x140c
> +#define HUAWEI_PRODUCT_K4505	0x1464
> +#define HUAWEI_PRODUCT_K3765	0x1465
> +#define HUAWEI_PRODUCT_K4605	0x14c6
> +#define HUAWEI_PRODUCT_E1820	0x14ac
> +#define HUAWEI_PRODUCT_E173S6	0x1c07
>  
>  /* map QMI/wwan function by a fixed interface number */
>  #define QMI_FIXED_INTF(vend, prod, num) \

[ ... ]

> @@ -1024,23 +1031,23 @@ static const struct usb_device_id products[] = {
>  	},
>  	{	/* Novatel USB551L and MC551 */
>  		USB_DEVICE_AND_INTERFACE_INFO(0x1410, 0xb001,
> -		                              USB_CLASS_COMM,
> -		                              USB_CDC_SUBCLASS_ETHERNET,
> -		                              USB_CDC_PROTO_NONE),
> +					      USB_CLASS_COMM,
> +					      USB_CDC_SUBCLASS_ETHERNET,
> +					      USB_CDC_PROTO_NONE),
>  		.driver_info        = (unsigned long)&qmi_wwan_info,
>  	},

[Severity: Medium]
Same question for the space-to-tab reindentation of the three pre-existing
Novatel entries (0x1410:0xb001, 0x1410:0x9010, 0x1410:0x9011): the commit
message does not mention any whitespace cleanup.  Would it be better as a
separate cleanup patch?

[ ... ]

> @@ -1229,8 +1236,13 @@ static const struct usb_device_id products[] = {
>  	{QMI_QUIRK_SET_DTR(0x05c6, 0x9625, 4)},	/* YUGA CLM920-NC5 */
>  	{QMI_FIXED_INTF(0x0846, 0x68a2, 8)},
>  	{QMI_FIXED_INTF(0x0846, 0x68d3, 8)},	/* Netgear Aircard 779S */
> -	{QMI_FIXED_INTF(0x12d1, 0x140c, 1)},	/* Huawei E173 */
> -	{QMI_FIXED_INTF(0x12d1, 0x14ac, 1)},	/* Huawei E1820 */
> +	{QMI_FIXED_INTF(HUAWEI_VENDOR_ID, HUAWEI_PRODUCT_E1750, 1)},	/* Huawei E1750 */

[Severity: High]
Is interface 1 the right interface number for 12d1:1406?  The only
in-tree description of that device's layout says interface 2 is the
reserved (non-serial) function:

drivers/usb/serial/option.c:option_ids[] {
	{ USB_DEVICE_AND_INTERFACE_INFO(HUAWEI_VENDOR_ID, HUAWEI_PRODUCT_E1750, 0xff, 0xff, 0xff),
	  .driver_info = RSVD(2) },
}

option_probe() only rejects the interfaces named in the RSVD mask:

	if (iface_is_reserved(device_flags, iface_desc->bInterfaceNumber))
		return -ENODEV;

so option binds interface 1 of 0x1406, and this new entry makes qmi_wwan
claim the same interface.  Note the neighbouring 0x140c, 0x14ac and 0x1c07
entries in option.c use RSVD(1), the opposite of 0x1406.

Does qmi_wwan_probe() catch this?  For an interface-number match it only
rejects non vendor-specific classes, the Quectel EC20 interface 0 case,
and two-endpoint interfaces:

drivers/net/usb/qmi_wwan.c:qmi_wwan_probe() {
	if (desc->bNumEndpoints == 2)
		return -ENODEV;

	return usbnet_probe(intf, id);
}

A 3-endpoint Huawei serial/PCUI interface passes all of those, and
qmi_wwan_bind() does no QMI validation, so the bind succeeds.  Depending on
which driver registers first, either the E1750 loses its ttyUSB port in
favour of a netdev and cdc-wdm node that never carry QMI, or the table
entry is dead code.  Either way interface 2 stays unclaimed.

> +	{QMI_FIXED_INTF(HUAWEI_VENDOR_ID, HUAWEI_PRODUCT_E173, 1)},	/* Huawei E173 */
> +	{QMI_FIXED_INTF(HUAWEI_VENDOR_ID, HUAWEI_PRODUCT_K4505, 1)},	/* Huawei K4505 */
> +	{QMI_FIXED_INTF(HUAWEI_VENDOR_ID, HUAWEI_PRODUCT_K3765, 1)},	/* Huawei K3765 */
> +	{QMI_FIXED_INTF(HUAWEI_VENDOR_ID, HUAWEI_PRODUCT_K4605, 1)},	/* Huawei K4605 */

[Severity: High]
Where does the interface 1 choice for 0x1464, 0x1465 and 0x14c6 come from?
In option.c these three carry RSVD(1) | RSVD(2), which only records the
interfaces option must not bind:

	{ USB_DEVICE_AND_INTERFACE_INFO(HUAWEI_VENDOR_ID, HUAWEI_PRODUCT_K4505, 0xff, 0xff, 0xff),
	  .driver_info = RSVD(1) | RSVD(2) },

Was the QMI function on interface 1 confirmed on these pre-QMI HSPA sticks,
for example with qmicli against the resulting cdc-wdm node?  Could the
commit message carry the lsusb output for each device it adds?

> +	{QMI_FIXED_INTF(HUAWEI_VENDOR_ID, HUAWEI_PRODUCT_E1820, 1)},	/* Huawei E1820 */
> +	{QMI_FIXED_INTF(HUAWEI_VENDOR_ID, HUAWEI_PRODUCT_E173S6, 1)},	/* Huawei E173s-6 */

[Severity: High]
Should 12d1:1c07 interface 1 be added here at all?  Commit 8f173e22abf2
("USB: serial: option: blacklist interface 1 for Huawei E173s-6"), which
added the RSVD(1) entry in option.c, says of this exact interface:

    It doesn't seem to respond to QMI if it's added to qmi_wwan so don't
    add it there - it's likely used by the card reader.

So the RSVD(1) mask records an interface option must leave alone, not a QMI
function.  Since qmi_wwan_probe() accepts any vendor-specific interface with
more than two endpoints and qmi_wwan_bind() does not verify the protocol,
this entry would create a wwan netdev plus /dev/cdc-wdm that never answer
QMI.  Was this tested on an E173s-6?

>  	{QMI_FIXED_INTF(0x1435, 0x0918, 3)},	/* Wistron NeWeb D16Q1 */
>  	{QMI_FIXED_INTF(0x1435, 0x0918, 4)},	/* Wistron NeWeb D16Q1 */
>  	{QMI_FIXED_INTF(0x1435, 0x0918, 5)},	/* Wistron NeWeb D16Q1 */

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918193645.59374-1-jackympoka22%40gmail.com
