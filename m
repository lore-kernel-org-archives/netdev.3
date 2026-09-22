Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECE54DDB5F;
	Tue, 22 Sep 2026 06:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059979; cv=none; b=ujQJ3KBsrEJKdoA8Gks2e7wcOQmFw2PO1n6gIem8gPRUB+Z1ZnUMsg9RmXyB948l2aKCZ6/lGO3kMHu3VPJ3ZEI9BBQsP8xoS4c/5xwk01AlXfqmsL7hX4vgZUyl4cfvr7zNjU+kNUfsv+jrGHYRvmPlB8x/1lCp1muLZ5lTLV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059979; c=relaxed/simple;
	bh=yYZ6LsrXW8VV/CHXisJ3PPSdkbq4JlpJWRveowMKK5o=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NbccUaPS4D/UVVJ64W/03y3JuG4RU7AdqG5p3SaiGTL8nBQ42I8ZaARFAuIxIgS7cVCbglesC9XH005/v7FKdfFrWlwe8FCHPMczbPHJ51E9vZ07/WKPljWC+IXG3zivKMMTzN4ujdbfGU/9nBimTK8cyQQAEnZw5SCIts769+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cw2Nk47c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cw2Nk47c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1911F000FF;
	Tue, 22 Sep 2026 06:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790059978;
	bh=N9daKyTHUmdtas1hqa9gC2JfF8mqCPPC3a6sbCq+H98=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cw2Nk47ciEWQLfz8WhnzaP/dQtBwbUKUByvK9tABDUzGQKC0+PUBjw1LuHoahUbrS
	 Pv9zK92CIyExej1Ru4AeUd4edlEoVe4heqPrVmgzIXXg+DOtUgAWQ0PpwWo04fF+HP
	 HGmcBXGpZrBfl7GniM710YxH/Fj+rx9BqKpM9TLTBDlTbCVQ3ZdgkTPlgFpsc2P2EY
	 IAeF8dwhPjdJyP9o9bZE3bAZ43BzXUVaPanaF5nTon/6itLPHxdpkhXe/6fuzaWrPG
	 gHOV499m2zUQbpDrEH26NpFwLfNXnyph4tJ3RaGPxGjnWBGUBnA1qi+7gSiysPxJ4Y
	 mXtIpZTSSOznA==
Subject: Re: [PATCH net-next v14 1/7] r8169: prepare for multi irqs and napi
From: netdev-bot+sashiko@kernel.org
To: javen_xu@realsil.com.cn
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 22 Sep 2026 06:52:57 +0000
Message-ID: <179005997718.2160803.8057479940068191169@kernel.org>
In-Reply-To: <20260918061923.313-2-javen_xu@realsil.com.cn>
References: <20260918061923.313-2-javen_xu@realsil.com.cn>
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

- [Low] Commit message claims "there is no functional change", but the
  patch introduces two user-visible changes in…

--

r8169: prepare for multi irqs and napi

This converts the single struct napi_struct in struct rtl8169_private into a
dynamically allocated array sized by the number of IRQ vectors, and moves
IRQ request/free into helpers that iterate over that array.  irq_nvecs and
num_rx_rings stay at 1, so this is described as a preparation step for RSS.

>     Currently, irq_nvecs and num_rx_rings are still hard-coded
>     to 1, so there is no functional change.

[Severity: Low]
Is the "no functional change" statement accurate?  There look to be two
observable changes for the currently supported single-vector case.

The first is the probe banner in rtl_init_one(), which gains a field that
always reads "(1 total)" while irq_nvecs is hard-coded to 1.

The second is the new netif_napi_set_irq() call in r8169_init_napi().
netif_napi_add_weight_locked() leaves napi->irq at -1, and
netdev_nl_napi_fill_one() only emits the attribute when it is non-negative:

net/core/netdev-genl.c:netdev_nl_napi_fill_one() {
	...
	if (napi->irq >= 0 && nla_put_u32(rsp, NETDEV_A_NAPI_IRQ, napi->irq))
		goto nla_put_failure;
	...
}

So NETDEV_A_NAPI_IRQ goes from absent to present in NETDEV_CMD_NAPI_GET
replies for this driver.

Could the commit message mention both, or could the banner change be moved
to the patch that actually enables more than one vector?

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 5415ff62a286..a8214c48a775 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c

[ ... ]

> @@ -6005,6 +6087,15 @@ static int rtl_init_phylink(struct rtl8169_private *tp)
>  	return 0;
>  }
>  
> +static void r8169_init_napi(struct rtl8169_private *tp)
> +{
> +	for (int i = 0; i < tp->irq_nvecs; i++) {
> +		netif_napi_add(tp->dev, &tp->rtl8169_napi[i], rtl8169_poll);
> +		netif_napi_set_irq(&tp->rtl8169_napi[i],
> +				   pci_irq_vector(tp->pci_dev, i));
> +	}
> +}
> +

[ ... ]

> @@ -6215,8 +6317,9 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  			tp->leds = rtl8168_init_leds(dev);
>  	}
>  
> -	netdev_info(dev, "%s, %pM, %sXID %x, IRQ %d\n",
> -		    chip->name, dev->dev_addr, ext_xid_str, xid, tp->irq);
> +	netdev_info(dev, "%s, %pM, %sXID %x, IRQ %d (%u total)\n",
> +		    chip->name, dev->dev_addr, ext_xid_str, xid,
> +		    pci_irq_vector(pdev, 0), tp->irq_nvecs);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918061923.313-1-javen_xu%40realsil.com.cn
