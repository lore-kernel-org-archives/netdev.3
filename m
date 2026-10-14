Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535CD3AA4F9
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 02:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791946752; cv=none; b=Q2Cvp8kGn2DTZ/HAgLIN9RqJBjNwCPrq/J/eejHjlvYUwWuOXoP9ero9ybw3Uophu/KKzVNCpuWhD8qUqAAXY+JhcaWdsRHWPuFfdn80Y5IOmXNwN6p9fQslqQZ91f2GVy3sUtoYeBshsBDUMNztc7eWByIaQDE9o5TY3FRu2Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791946752; c=relaxed/simple;
	bh=SFhSwbGyMkobCZdCLU1B7iWT39MvncZ9ZC9tXhBcyhE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IOumCCPFumQfy2PWX523BYfUIjUur+wLoFDvW/FgwLxE5iERL1UH1xC1PBhlZLeUyisGPSssUxcYInWTK/3K7jNxvh0+mljoMvO6F0Jr59TA4a4oc3i+anIWlDqEY69WoFx9N7M69X3qQx1MS1fnkpt8o3aAY1ialmQPFAIaS2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SikkHv/q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SikkHv/q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B231F000FF;
	Wed, 14 Oct 2026 02:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791946750;
	bh=vRCyc5hA/RwtKOGXCWeOkA1X+mwdAhhkOWb6+DrQAt0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SikkHv/qAQuJgZUtk22ytuoCYv4zM+s9Rj5rCIM5Ym4X6IhPirsV0DvoRrTCmIgsn
	 +KRsuLmLOM0bNp9IeNKiFmfLiHgqb8QW58S22HtkLlwwqLgyvgwO9RynYBUvt4lB+G
	 Cug1BFvJYjffsrihEJobQ7KXQLYd3j7Bx8KCE0bzEFbBwZWXpLcHiselbyYuGlGFB6
	 Vkjw0F4+VlH5NX5Brsl9XoQXulAPGvLnqpkiF/HfF8niceyx9gXRuSTTgxLWtFyNx0
	 4BVivbHT3i6g5Pkf1x95ADYyUlPM5DVhfj1+xnxLFa0eU4NGIloUbt5ceCjljXHx+z
	 qX2rZe+LpgvfQ==
Subject: Re: [PATCH net v3 3/3] net: txgbe: keep MAC enabled for AML devices
 that support NCSI
From: netdev-bot+sashiko@kernel.org
To: jiawenwu@trustnetic.com
Cc: netdev@vger.kernel.org, mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, jacob.e.keller@intel.com, kees@kernel.org,
 zhaochenguang@kylinos.cn, aleksandr.loktionov@intel.com,
 u.kleine-koenig@baylibre.com, rmk+kernel@armlinux.org.uk,
 maciej.fijalkowski@intel.com, horms@kernel.org
Date: Wed, 14 Oct 2026 02:59:09 +0000
Message-ID: <179194674956.434549.1230595205361313006@kernel.org>
In-Reply-To: <20261013020626.5548-5-jiawenwu@trustnetic.com>
References: <20261013020626.5548-5-jiawenwu@trustnetic.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch has no effect on any txgbe device.

--

net: txgbe: keep MAC enabled for AML devices that support NCSI

This patch makes txgbe_mac_link_down_aml() leave MAC Tx and Rx enabled
when wx->ncsi_enabled is set. In that case it also stops txgbe_down()
from disabling the TX laser on AML 10G/25G devices. The goal is to keep
BMC pass-through working after the host interface goes down.

> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> index 26d0cfc58ee2c..9f1ce3e2e3a4d 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> @@ -458,8 +458,10 @@ static void txgbe_mac_link_down_aml(struct phylink_config *config,
>  {
>  	struct wx *wx = phylink_to_wx(config);
>  
> -	wr32m(wx, TXGBE_AML_MAC_TX_CFG, TXGBE_AML_MAC_TX_CFG_TE, 0);
> -	wr32m(wx, WX_MAC_RX_CFG, WX_MAC_RX_CFG_RE, 0);
> +	if (!wx->ncsi_enabled) {
> +		wr32m(wx, TXGBE_AML_MAC_TX_CFG, TXGBE_AML_MAC_TX_CFG_TE, 0);
> +		wr32m(wx, WX_MAC_RX_CFG, WX_MAC_RX_CFG_RE, 0);
> +	}

[Severity: High]
Is wx->ncsi_enabled ever set for txgbe devices?

Under drivers/net/ethernet/wangxun/, the only assignment seems to be in
ngbe:

drivers/net/ethernet/wangxun/ngbe/ngbe_main.c:ngbe_init_type_code() {
    ...
	wx->ncsi_enabled = (ncsi_mask == WX_NCSI_SUP ||
			   type_mask == NGBE_SUBID_OCP_CARD) ? 1 : 0;
    ...
}

txgbe_sw_init(), txgbe_init_type_code() and wx_sw_init() don't appear to
set it. struct wx lives in the netdev private area from
devm_alloc_etherdev_mqs(), which is zeroed, so the field would stay
false.

If that's right, on AML NCSI boards this path still clears
TXGBE_AML_MAC_TX_CFG_TE and WX_MAC_RX_CFG_RE:

txgbe_close()
  txgbe_down()
    phylink_stop()
      txgbe_mac_link_down_aml()

The new check in txgbe_down() would also still assert TX_DISABLE:

	case wx_mac_aml:
		phylink_stop(wx->phylink);
		if (!wx->ncsi_enabled) {
			/* Disable TX laser */
			wr32m(wx, WX_GPIO_DR, TXGBE_GPIOBIT_1, TXGBE_GPIOBIT_1);
		}

Wouldn't BMC pass-through still break on "ip link set dev X down", just
as it did before this patch?

An earlier commit in this series, "net: libwx: keep NGBE OCP cards MAC
enabled", seems to say the same thing: "'wx->ncsi_enabled' ... is not
assigned in TXGBE, so we use an explicit subsystem device ID mask in libwx
now".

Earlier on the same down path, txgbe_disable_device() checks the
subsystem ID directly:

	if (!(((wx->subsystem_device_id & WX_NCSI_MASK) == WX_NCSI_SUP) ||
	      ((wx->subsystem_device_id & WX_WOL_MASK) == WX_WOL_SUP))) {
		/* disable mac transmiter */
		wr32m(wx, WX_MAC_TX_CFG, WX_MAC_TX_CFG_TE, 0);
	}

So txgbe_disable_device() leaves MAC Tx on for NCSI SKUs, and then
txgbe_mac_link_down_aml() turns it off. That check also covers
WX_WOL_SUP. A test on ncsi_enabled alone would skip WX_WOL_SUP even if
the field were set.

Should txgbe_sw_init() set wx->ncsi_enabled from
subsystem_device_id & WX_NCSI_MASK, the way ngbe does? Or should these
checks use the subsystem ID test directly?

The SP-side patch in this series, "net: txgbe: keep MAC enabled for SP
devices that support NCSI", appears to rely on the same field in
txgbe_phy.c.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013020626.5548-2-jiawenwu%40trustnetic.com
