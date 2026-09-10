Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94A8367B7E
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 08:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789030325; cv=none; b=dsmBaFf3hK/BlVWhRz6673HQ19hjTqQtuE2SzK3oCugHKCbclQGrLqlsje1elOni9AiwBk/Ov2uNFVjJD730wm2VZvcGARwjLLLuae+aOKOO7IOuRB1wAnyOWx8K1LUetupX+W8Z9kOpXWE/x/nnYqjqeWLfQW1hzt5sO7t2eQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789030325; c=relaxed/simple;
	bh=TXzO4CxPzjTWN3U88b9u7QNjcehYD1X95K6OmaJcnBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=alkfGa1SWfYT+0PoyE0q+ZfM+8sg119wUp5SVF665/SUNXMOYgznqRMteDcBJsi0RNwCr/9yMl6QKF935kU43C0RA7MYAuDSPAAoT4uze5/HrxuVYT3BFUlx7gI9lz8StPl4WDiLJHVvhaF7K9gLrY8jdcksMqsd2V6i1XdvgHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=m/qWy0qS; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="m/qWy0qS"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A98194E415B7;
	Thu, 10 Sep 2026 08:51:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7BA26602B8;
	Thu, 10 Sep 2026 08:51:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CC76311C78279;
	Thu, 10 Sep 2026 10:51:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789030317; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=TBLkc4TPeJSt/F5BCY8MXYJHCqRMVqlyOb7GOdhCGeg=;
	b=m/qWy0qSwc5w5dL1z8Bhusn/fEg/7Pj2WypzTvNWlIxazW6w86wFo4WSiP2FgBRPvjTJMG
	Pcce/QZife/H1E4GDDFi2zI8L0Xi+JP9X+Fe27jHAqeNUvIG8NMVGuNkje8TYQz4DS32Jg
	lWlJ7RRWGop3KbwsL70wXDKHMM8IVhkwRiRJR612OP2aPoxB8i+n/KwPZR2PwMfTJ+B4MD
	PJPU3GvBDSDtdcSKOYeLy0hjmV+Ig0E3ii1QenVTpiqTlIr2Avd4z5JqA3SkDKVJKa3Qsi
	MrPsaKJakTBQvnicil6VLh1Xc6pzOJHCnxBAOfAigIOUlup5gVI+PN8zd/zKAQ==
Message-ID: <4a07a3d6-b515-43b6-918d-87806c479430@bootlin.com>
Date: Thu, 10 Sep 2026 10:51:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: fix stale descriptors and DMA mapping
 leak on Tx map failure
To: ZhaoJinming <zhaojinming@uniontech.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260910-stmmac-fix-vlan-desc-leak-v1-1-6b07dca5e5e8@uniontech.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260910-stmmac-fix-vlan-desc-leak-v1-1-6b07dca5e5e8@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/10/26 07:19, ZhaoJinming wrote:
> In stmmac_xmit(), when the DMA mapping of the linear part or of a
> fragment fails, the error path only frees the skb.  This leaves behind
> the DMA mappings already created for the linear part and for the
> fragments mapped before the failure, which are never unmapped.
> 
> The VLAN context descriptor programmed by stmmac_vlan_insert() is also
> left behind with its OWN bit set while tx_q->cur_tx has been advanced
> past it, so the DMA engine later consumes the orphaned descriptor and
> applies its stale VLAN tag to an unrelated frame.
> 
> Release the descriptors and their DMA mappings in the dma_map_err path
> with stmmac_release_tx_desc() and stmmac_free_tx_buffer(), walking from
> first_entry to entry, then roll back tx_q->cur_tx and release the VLAN
> context descriptor.
> 
> Fixes: 30d932279dc2 ("net: stmmac: Add support for VLAN Insertion Offload")
> Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 29 +++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 24656b35350b14454fb10deced6516eb89e2c0c9..2e36c27e2cfb436af3566cf1c3e70d32ce9830a0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4769,12 +4769,12 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
>  	unsigned int nopaged_len = skb_headlen(skb);
>  	u32 queue = skb_get_queue_mapping(skb);
>  	int nfrags = skb_shinfo(skb)->nr_frags;
> -	unsigned int first_entry, tx_packets;
> +	unsigned int first_entry, entry, tx_packets;
>  	struct stmmac_txq_stats *txq_stats;
>  	struct dma_desc *desc, *first_desc;
>  	struct stmmac_tx_queue *tx_q;
>  	int i, csum_insertion = 0;
> -	int entry, first_tx;
> +	int first_tx, ret;
>  	dma_addr_t dma_addr;
>  	u32 sdu_len;

Please follow the reverse xmas tree ordering, from longest line to shortest

The rest seems OK. By any chance, do you have a reproducer ?

Maxime

