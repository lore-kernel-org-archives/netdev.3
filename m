Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3C63BB10D;
	Sat, 19 Sep 2026 01:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789781197; cv=none; b=muEdFIxcWrOmovw5MjV4CBkYyuGUZ4hqO6KL2Z6MmhlXfaCM9QsG2Uw6A65I6NPHkqCJDZMqvQ1jyywVGYraEyittTd7PmwJSPzwF0XWraqVkhcdbEnCeywMWRspbKC9x9rJHuNVgGRVLzxJnA5Rvh6NOydjIiDlabJedIQlLsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789781197; c=relaxed/simple;
	bh=+JQ1Dx5XkjyytN93QMO29NcWmzs1QbAW5dpWS/Y35og=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tLXK5ZuhBGb8LRKXHEkufbSsLry6vhSMQFhC076cjqMoDpWkT7/5rLf40XYLxbM4+8w96iTYx0gDLQ0WZiHHx1RZG8yR6boolxhR24E4r8+qAVVObrNucWr4IarJFhWTFMo2AV00wW7G104Nos3sIE5n7nhApfWZdr/sd8JQKFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q173/XSG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q173/XSG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035261F00898;
	Sat, 19 Sep 2026 01:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789781195;
	bh=0BfFY34GLPm1r10FGia6EVcgqB1yaR1uKfUp4aqsxiw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Q173/XSGu0LanFRYsVGLYDMV+Y/ko3QQtQZP/OCGtPbLLdaTx1uIBWb8BJf0MxO++
	 xEsEoXvjtA1G5YdNBgK9+2MGMeziOAvsZUFyaTm5rZuBf4vaFkOFrzegjFTxPwA1jF
	 qthYY/cB3GecSo/C9omI2I5gaa61WewwvCdi2LvOXiPeYx75tdJPQyl4Ew7lN093Cj
	 ltE6p7J/1wtbn7V5Uvn3rEPXJi3c/CqP+KX8ORYFxvPcnpHeJcbCBv8wDUIW/T20PW
	 0XuvqW65Lc8U++5AcG7FvG5VZ9LKGz5SQfDP0ez9V/9nUBXnQK59l2hs8a2a3tBreT
	 LqY6rfe8ssHbw==
Subject: Re: [PATCH net v4 3/7] net: stmmac: selftests: Check the
 dev->features for S-TAG offload testing
From: netdev-bot+sashiko@kernel.org
To: maxime.chevallier@bootlin.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 hkallweit1@gmail.com, alexis.lothore@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, kernel@esmil.dk, minda.chen@starfivetech.com,
 neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, jan.petrous@oss.nxp.com,
 ovidiu.panait.rb@renesas.com, Jose.Abreu@synopsys.com, nb@tipi-net.de,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, PKneuper@dspace.de,
 david.laight.linux@gmail.com
Date: Sat, 19 Sep 2026 01:26:33 +0000
Message-ID: <178978119359.22033.9215465331657761575@kernel.org>
In-Reply-To: <20260917215339.2022523-4-maxime.chevallier@bootlin.com>
References: <20260917215339.2022523-4-maxime.chevallier@bootlin.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] stmmac_test_svlanoff() is re-gated on NETIF_F_HW_VLAN_STAG_TX,
  but the test body it enables validates a *double-tagged* (QinQ) frame,…

--

net: stmmac: selftests: Check the dev->features for S-TAG offload testing

The S-TAG insertion selftest was gated on the dvlan (double VLAN) DMA
capability, which is not the same thing as S-TAG insertion support. This
commit switches the gate to NETIF_F_HW_VLAN_STAG_TX, and keeps the test
in tree so it starts working if the driver ever advertises that feature.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> index 2f9f7746c40ae..de02c0da56dc3 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> @@ -1415,7 +1415,7 @@ static int stmmac_test_vlanoff(struct stmmac_priv *priv)
>  
>  static int stmmac_test_svlanoff(struct stmmac_priv *priv)
>  {
> -	if (!priv->dma_cap.dvlan)
> +	if (!(priv->dev->features & NETIF_F_HW_VLAN_STAG_TX))
>  		return -EOPNOTSUPP;
>  	return stmmac_test_vlanoff_common(priv, true);
>  }

[Severity: Medium]
Does the new gate match what the test body actually validates?  The gate
now keys on single S-TAG transmit offload, but the code it enables appears
to expect a double-tagged (QinQ) frame.

In stmmac_test_vlanoff_common() the frame is built untagged (attr is
`struct stmmac_packet_attrs attr = { }` and attr.vlan is never set, so
stmmac_test_get_udp_skb() skips its `if (attr->vlan)` block), and exactly
one acceleration tag is attached:

	__vlan_hwaccel_put_tag(skb, htons(proto), tpriv->vlan_id);
	skb->protocol = htons(proto);

while the ptype registered for the svlan case listens for 802.1Q:

	tpriv->pt.type = svlan ? htons(ETH_P_8021Q) : htons(ETH_P_IP);

And stmmac_test_vlan_validate() skips a 4-byte inner tag before the IP
header when double_vlan is set:

	ihdr = ip_hdr(skb);
	if (tpriv->double_vlan)
		ihdr = (struct iphdr *)(skb_network_header(skb) + 4);
	if (ihdr->protocol != IPPROTO_UDP)
		goto out;

With a conforming NETIF_F_HW_VLAN_STAG_TX implementation the looped-back
frame is DA|SA|0x88A8|TCI|0x0800|IP.  After skb_vlan_untag() the ethertype
is ETH_P_IP, so the ETH_P_8021Q ptype is never matched, and even if it
were, skb_network_header(skb) + 4 lands 4 bytes into the IP header and the
IPPROTO_UDP check fails.  Wouldn't that make the test report -ETIMEDOUT
the moment the feature bit is advertised?

Along the same lines, can the current transmit path ever produce the frame
the validator wants?  stmmac_vlan_insert() in stmmac_main.c ignores
skb->vlan_proto and hardcodes the inner tag and type:

	if (stmmac_set_desc_vlan_tag(priv, p, tag, 0x0, 0x0))
		return false;

and vlan_enable() in stmmac_vlan.c selects C-VLAN insertion only:

	value &= ~VLAN_CSVL; /* Only use CVLAN */

So the only way the retained test could pass seems to be an implementation
that wrongly inserts an extra inner C-TAG.

Would it make sense to also adjust the frame and the validation here (for
example setting attr.vlan for an inner C-TAG with pt.type = ETH_P_IP, or
dropping the double_vlan expectation for the S-TAG case) rather than only
swapping the capability bit, so the test matches the semantics of the
feature it is now gated on?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917215339.2022523-1-maxime.chevallier%40bootlin.com
