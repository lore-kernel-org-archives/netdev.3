Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329704;
	b=BYyhIX+C6kXaMgL4gDArDhn7zZI0aWxbhX6MPgsSR2D9byk6pOTmbMgQXM2xWxefjxOA
	 J8aCklapytJOAc07z5wQnvf0qtL1W/C25GPXL+thYyWxnzT0O9FqpnUDaitwjKnGNasiJ
	 pJymQ7E6eV41ZTuMCZbRrwPFIzZQrN3KPDPyY6rF/0p1r8nRkCRoAzgbvxpr7SfnXZMyO
	 aDEzMgHh58naZg+1JqTFFxQ940dtI9JBYgKmJdETEVe81RCD0thOMoeZggd5qnd0qymFq
	 /0SPUbuyiwsW6JzTgNL6egUIXvaKEbXc6qeV2pubnWtrd+9Jp/eACxmXvw2+0kkTqRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329704;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=xtlNzexgpyraXnkzb2cGNwRrOc/5l0CGjaw5+9/Uw9c=;
	b=YSco4vNVbfvt4mDY2hjmhJ6eJfGaxAj8BWao/yDio0z0ZswJ26zMLW6/LvH+t0Mi4bmE
	 b51jM1NUFR1NcTjphEsnkqkyegnjjr5nR9gYvFpjESfMB9+0gREBvrO2g4O4NM3iVdhMo
	 TnYBTtqFPIA3fgYANmWj/QVgrh2J613/5C47xj9405+sfHz/1YLrZqdBkX16fdzckr7kB
	 YqnB2EGPIWNN9MQqlDFgt6OT6tn+Ke34+kRCb93Rlv0OrZ0BjnN2ei2PYwPtZg6338uR3
	 zbLpaZKlv+MvRfp4yYZrvSprqeu6OTVJ4RhKqMOibGDxZABBwH+ywNSb4y8Cq5ixSLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ckOW86Dv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C83606A334;
	Tue, 10 Nov 2026 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ckOW86Dv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C881F0089F;
	Tue, 10 Nov 2026 16:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794329704;
	bh=xtlNzexgpyraXnkzb2cGNwRrOc/5l0CGjaw5+9/Uw9c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ckOW86Dv7eBrMYpfPpQlv5/Ibg5XMJLvcfywM/egfYsdxWVtKR1vJOr1svAKtBrmg
	 hiyrpW2QLlO2giu15U6nqD3/97ZOHsUnzrwICpO6HfR4Sg5trE3gk5Hc3VgksIWpUQ
	 sVwcFwg62XOi7QIpVoNi9h58auDKR4t4QwAt+ZGj/Dp4gw8HBw1fFrnwklOL6l6yWG
	 RgyjyyqCabNwtLyrnfknW8peaHMSh/S88RWgWZQLWK81CnTAz7tOZ75xnoPpao+aey
	 ik9HUpKKCb2RHR/N6GHEXNpxyIf4wMi4o66l6MIpbgSNjVgETbSpAwlpLAZN79DxmM
	 j1Mv7WXP17kmw==
Subject:
 Re: [PATCH net-next 2/5] net: rnpgbe: Report link settings through ethtool
From: netdev-bot+sashiko@kernel.org
To: dong100@mucse.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, yaojun@mucse.com
Date: Tue, 10 Nov 2026 16:55:03 +0000
Message-ID: <179432970303.994134.1660961190803975260@kernel.org>
In-Reply-To: <BB3F0BAB3B9947AF+20261106112522.43965-1-dong100@mucse.com>
References: <BB3F0BAB3B9947AF+20261106112522.43965-1-dong100@mucse.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In mucse_mbx_fw_req_handler() (rnpgbe_mbx_fw.c:465-466), the
  patch takes the 2-bit firmware field FIELD_GET(ST_STATUS_MDIX_MASK /*…

--

net: rnpgbe: Report link settings through ethtool

This commit adds get_link_ksettings support to rnpgbe. At probe time it
queries firmware with GET_LANE_STATUS and reports the supported and
advertised link modes, autoneg, port type and PHY address from that
reply. It also caches the MDI-X state from LINK_CHANGE_EVT, and sets
the default link to autoneg on TP ports and to fixed 1000/full on fibre
and backplane ports.

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> index 4a18937927514..469818b83d70f 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c

[ ... ]

> @@ -435,6 +462,8 @@ static void mucse_mbx_fw_req_handler(struct mucse_hw *hw,
>  
>  		hw->speed = le16_to_cpu(req->link_stat.st.speed);
>  		hw->duplex = req->link_stat.st.flags & DUPLEX_BIT;
> +		hw->mdix = FIELD_GET(ST_STATUS_MDIX_MASK,
> +				     le16_to_cpu(req->link_stat.st.status));

[Severity: Low]
This stores the raw 2-bit firmware field (0..3) in hw->mdix. Is that
value guaranteed to use the ETH_TP_MDI_* encoding?

When the carrier is up on a TP port, rnpgbe_get_link_ksettings() copies
the value straight into the ethtool status field:

	if (status & MUCSE_LINK_TP)
		cmd->base.eth_tp_mdix = hw->mdix;

The ethtool uAPI only allows ETH_TP_MDI_INVALID, ETH_TP_MDI or
ETH_TP_MDI_X in eth_tp_mdix. ETH_TP_MDI_AUTO (3) is only valid for
control. Both linkinfo_fill_reply() and the legacy ioctl path pass the
value to userspace without checking it.

If firmware reports 3, userspace gets an invalid status. If firmware
reports 0 while the link is up, userspace sees "Unknown". If firmware
uses a different encoding, userspace sees the wrong MDI/MDI-X state.

The control path already sends ETH_TP_MDI_* values to firmware in
phy_link_set.tp_mdix_ctrl, so values 1 and 2 may well line up. Nothing
here documents or enforces that, though, and later patches in the
series don't change the parsing or the reporting code.

Could the firmware value be mapped to ETH_TP_MDI_* explicitly, with
anything unexpected reported as ETH_TP_MDI_INVALID?

The patch also adds a second MDI-X field definition, for the
GET_LANE_STATUS status word in rnpgbe_mbx_fw.h, and nothing uses it:

	#define MUCSE_LINK_MDIX		GENMASK(14, 13)

Neither this define nor ST_STATUS_MDIX_MASK documents its value
encoding. Is MUCSE_LINK_MDIX meant to be used, or can it be dropped?

>  		rnpgbe_set_link(hw, mucse_link_is_up(hw, req));
>  		/* update regs to notify link info is received */
>  		mucse_update_link_status_reg(hw, req);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/FB722C2F25FE9005%2B20261106112420.43050-1-dong100%40mucse.com
