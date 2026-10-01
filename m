Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA9041443E;
	Thu,  1 Oct 2026 03:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790825998; cv=none; b=tcsWqUPuH1iIm7D/e7DfDykkIUaYPIOf4bfXktww9DbtoSpZ/AH+vgVcb0ffT5Smpvwv1pIEvgVMoxGSgsyZuMH57+hb8ValJnOQZ78RuvqDWjLWA5ERaJJxPAxC9I0p7J/N9w98UHUbA+p5f9YqxycN/v6J4AEJ/wCaMAWT+wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790825998; c=relaxed/simple;
	bh=Av1Q5hxxEYWgt6Kv3s9rN3LbLRqg6EllL3wM/7EjA20=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FxnnbSis+nwX9zVC/OPHTLNe9iKwZjQ3L90ocYIrPj6F4rEaadwdLiFyOPsM2lq5TdRkyHPNXGSNc8xDXA0eU9MIHkW7rWNoD0pLkVKNggTu51BHF87YAdBOzC4QtKUtBns67hHBzbrmFIvnBw7Pscv9BJiYo++4dgMFcN1y9mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmzJO30J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmzJO30J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD731F00898;
	Thu,  1 Oct 2026 03:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790825988;
	bh=iOGvhpuW87r2saw8Tns0/0BNAiXUeWLRpemaGlj2j50=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cmzJO30Jt63C8AMgxg/01K5waaYeQDajfZt1i52em+0XoZu5/mjrtMizw1kyrggwy
	 Nk5UmFoB17gYOHhiEWcoKivloD/VRIr7wftRlNmr7FaU9QPzjIk1Gp8KQg49Zq9jLO
	 DfouKA3ygDzrcVhePn4JXL15JsDiaFVwj5gxFr8/Aq1B/WO0FJpDkuSllM+BWvwkWf
	 OVaWQuKcjLZTiuk9z4132QfUWFFXNdhfyuHXb8xrcZCiN/7/ZQAYKDkBM0RYCnxz+x
	 qIow86cNZZ8Fx5QSwVPSegLeI8hMEopDba7Y+mCYAf+KP9Gt4RTWHQETo6DQGQQwjU
	 fB140eCnAT0xg==
Subject: Re: [PATCH net-next v14 2/5] net: rnpgbe: Add basic TX packet
 transmission support
From: netdev-bot+sashiko@kernel.org
To: dong100@mucse.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaojun@mucse.com
Date: Thu, 01 Oct 2026 03:39:47 +0000
Message-ID: <179082598736.434549.1345359582954090530@kernel.org>
In-Reply-To: <B8B7AE6BED38AD9F+20260928033834.1033357-1-dong100@mucse.com>
References: <B8B7AE6BED38AD9F+20260928033834.1033357-1-dong100@mucse.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] rnpgbe_add_adapter() now calls netif_carrier_off() before
  register_netdev() (rnpgbe_main.c:264), and nothing at this commit…

--

net: rnpgbe: Add basic TX packet transmission support

This commit adds the basic TX path for the rnpgbe driver: TX descriptors,
buffer management, ring setup and teardown, and TX completion handling
from NAPI. It also keeps per-queue TX statistics in adapter-owned storage
and sets 56-bit streaming and coherent DMA masks.

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> index 6022a1a2ddf1e..265a3fcb07beb 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c

[ ... ]

> @@ -206,6 +254,14 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
>  		goto err_clear_interrupt;
>  	}
>  
> +	netdev->features |= NETIF_F_SG;
> +	netdev->hw_features |= NETIF_F_SG;
> +	if (dma_get_mask(&pdev->dev) > DMA_BIT_MASK(32)) {
> +		netdev->features |= NETIF_F_HIGHDMA;
> +		netdev->hw_features |= NETIF_F_HIGHDMA;
> +	}
> +
> +	netif_carrier_off(netdev);
>  	err = register_netdev(netdev);
>  	if (err)
>  		goto err_remove_mbx;

[Severity: Low]
rnpgbe_add_adapter() now calls netif_carrier_off(). At this commit, does
anything turn the carrier back on? I couldn't find a netif_carrier_on()
call anywhere in the driver. On a successful open, rnpgbe_up_complete()
only starts the TX queues:

rnpgbe_up_complete()
    rnpgbe_configure_msix(mucse);
    rnpgbe_napi_enable_all(mucse);
    rnpgbe_irq_enable(mucse);
    netif_tx_start_all_queues(netdev);

While the carrier is off, dev_activate() defers qdisc activation. So the
interface shows NO-CARRIER after open, and the new TX path looks
unreachable at this commit:

rnpgbe_xmit_frame()->rnpgbe_xmit_frame_ring()->rnpgbe_tx_map()

The commit message also doesn't mention the carrier change.

The later patch "net: rnpgbe: Add link status handling support" appears
to add netif_carrier_on() through rnpgbe_link_is_up(), so this is fixed
later in the series. Before this patch, rnpgbe_xmit_frame() dropped every
skb anyway, so TX doesn't get any worse.

Could netif_carrier_off() move into the link handling patch? Or could this
commit message mention it, so the intermediate state is clear when
bisecting?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/0A4D45AD9F6A0F14%2B20260928033701.1033196-1-dong100%40mucse.com
