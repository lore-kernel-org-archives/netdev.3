Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D26D427F92;
	Mon, 10 Aug 2026 16:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786381006; cv=none; b=VbeMfQJDGmWTsfsT1qb0WEzyTbWiTfXXbChFS870fmkOyLYBzWMwwXtbrhrjbwwuArljuuylW5GvDJjD+yvEvoyXh1qqqCNrK01vD8MC6h7Otw0XS8n00bG9uXDO5e7+EmLTBsMRUxLuCz7hv/vInCYRcYhcOlkTSDvy9mt8eMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786381006; c=relaxed/simple;
	bh=zT57Kc6VYIRBHTmTRV3FJ+T2sBeZpTE6lG0pmkv1WjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bnhw2911Bdi/MGliGkNIh7E4zb4Mm3fSJPNMXJmIhI0yX9jjJcMZzzQX26ByXoYJCei8ChqthUiw8/gCSgs0yB8/f2EMffvZDThWsDQj2nHZys13pRSkRPYJQXXPl4omHTgQ4NBrDyTLBroJnEqvNAeQoy+y3jK02F1B8QEd/iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWS7g+vU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWS7g+vU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966D21F000E9;
	Mon, 10 Aug 2026 16:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786381004;
	bh=BWPkusVLENAArrc+B6J/z1uCewfn9djaIMTUNSKz/qg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HWS7g+vUPZ7eqc0C6di91ihuRonCUGeSB3zlT8bkHNhaniPRzZBGshWJ9yRXngdVo
	 hQe9gJSLCjV6BuvEPawqC533bAKbg7HJpcvv6OIBstXJPyFkIazCmFoG+XxOj3UMcG
	 v6fDY+cHfPP7qwZzk+2JEFkn2U/AD0MT/TpmWgUPdBluWLnRdHdkPoiaOWeWItV9Bq
	 +1NVQkQUInlPlSoJFDFrL0vBE2qTBtH1HuGBLw23hc5J8+8/BywafrEVM/K8VM7Cbm
	 CYwallFc+lzldg+nlhOF0oMOaP/kuBySqRLKthlkKjQMTQNXNqadt2R8tckeqnceAb
	 /T0VUJz6do0JQ==
From: Simon Horman <horms@kernel.org>
To: s-vadapalli@ti.com
Cc: Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	c-vankar@ti.com,
	vadim.fedorenko@linux.dev,
	v-singh1@ti.com,
	nm@ti.com,
	daniel.zahka@gmail.com,
	nora.schiffer@ew.tq-group.com,
	oss@vassilevski.com,
	grygorii.strashko@ti.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	srk@ti.com
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpsw-nuss: Fix port_id extraction from SRC TAG
Date: Mon, 10 Aug 2026 17:56:29 +0100
Message-ID: <20260810165629.788002-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807111738.2055900-1-s-vadapalli@ti.com>
References: <20260807111738.2055900-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260807111738.2055900-1-s-vadapalli@ti.com?part=1
---
--- Patch [1]: [PATCH net] net: ethernet: ti: am65-cpsw-nuss: Fix port_id extraction from SRC TAG ---
commit b0ed959d350c90d8b49f6f81eba7461fbc86dcf4
Author: Siddharth Vadapalli <s-vadapalli@ti.com>

net: ethernet: ti: am65-cpsw-nuss: Fix port_id extraction from SRC TAG

The RX path extracts the ingress MAC port ID from the CPPI5 descriptor's
16-bit Source Tag. Only the lower 8 bits carry the port ID, so the patch
masks the value with 0xFF before it is used as an index into
common->ports[].

> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> index 434a31080855..6330540979d7 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -1310,6 +1310,8 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_rx_flow *flow,
>  	k3_udma_glue_rx_cppi5_to_dma_addr(rx_chn->rx_chn, &buf_dma);
>  	pkt_len = cppi5_hdesc_get_pktlen(desc_rx);
>  	cppi5_desc_get_tags_ids(&desc_rx->hdr, &port_id, NULL);
> +	/* Port ID is contained in the lower 8-bits of the 16-bit Source Tag */
> +	port_id &= 0xFF;
>  	dev_dbg(dev, "%s rx port_id:%d\n", __func__, port_id);
>  	port = am65_common_get_port(common, port_id);
>  	ndev = port->ndev;

[Severity: High]
[Finding: main-1-0]
[Sources: opus-5]

The missing range check on port_id is pre-existing and not introduced by
this patch, but since the change is specifically about avoiding the
out-of-bounds access, would it be worth validating the value instead of
relying only on the mask?

After the mask, port_id is still an unvalidated hardware-supplied value in
the range 0..255, and am65_common_get_port() does raw pointer arithmetic
with no bounds check:

drivers/net/ethernet/ti/am65-cpsw-nuss.h:
    #define am65_common_get_port(common, id) (&(common)->ports[(id) - 1])

common->ports is a devm_kcalloc() array of exactly common->port_num
entries (1..AM65_CPSW_MAX_PORTS, checked in am65_cpsw_nuss_probe()), which
is typically 1 or 2 on shipping parts. So port_id == 0 gives ports[-1] and
any port_id above common->port_num reads past the end of the allocation.
The resulting pointer is dereferenced right away in
am65_cpsw_nuss_rx_packets():

    port = am65_common_get_port(common, port_id);
    ndev = port->ndev;
    ...
    if (port->xdp_prog) {

and ndev then flows into am65_cpsw_build_skb(), netdev_priv(),
netif_dormant() and ndev->stats.*. Can a stray low byte still produce the
same class of crash the commit message describes?

The driver already enforces the required index domain for this accessor on
the device tree path in am65_cpsw_nuss_init_slave_ports():

    if (!port_id || port_id > common->port_num) {
        dev_err(dev, "%pOF has invalid port_id %u %s\n",
            port_np, port_id, port_np->name);
        ret = -EINVAL;
        goto of_node_put;
    }

    port = am65_common_get_port(common, port_id);

Would the same !port_id || port_id > common->port_num test in the RX path,
dropping the packet and requeueing the page (bumping rx_errors, perhaps
with a WARN_ON_ONCE), be a more robust fix than the mask alone?

There is a second case even when the index is in range: ports disabled in
the device tree never get an ndev allocated, and every other iteration site
guards for that, for example in am65_cpsw_nuss_set_offload_fwd_mark():

    if (!port->ndev)
        continue;

The RX path uses port->ndev unconditionally, so an in-range port_id
belonging to a disabled port would hand a NULL net_device to
am65_cpsw_build_skb() and netdev_priv(). Should that case be rejected too?

As a small nit, would a named mask defined alongside the other CPPI5/AM65
definitions read better here than the bare 0xFF literal?
