Received: from mta1.migadu.com (out-204.mta1.migadu.com [95.215.58.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5641B3932CE
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 13:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787922846; cv=none; b=ILC+GIYATV+eFG5dybhzcGLJAzdFln/DqcoAXEptuablTruhnwBFDDTC9zgVCUYt6Szbv4geFvKqMo/2j1MPL28FSycgOdwWAQXivqka6P+sYTd+z9oGi9LNZJwHcZ29HjOsTHbxJGMqdGxpgubPFKS7uJUEny4Jjm+gFjHhNEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787922846; c=relaxed/simple;
	bh=/uU6ExnLVG8tAtofPabSQjz3nnh9Al8RD1/uyGGyRwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GWopxnr8A9G/Ws0QEMANSTS8pvX/iqfB0ruTBU7pwhoz3VFT8YfEy3jqOnjKDz9qSBIF0BvBaaR+CJfGRxJwjrupMryNLQFx0p1UvxpYVuGuU388Ib1Wd7mu4dpI6R3yvTX0DLgP4S65UlhYJE/3x3v5wd6t3wjOBxeWgaOPsyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ab0mLKLS; arc=none smtp.client-ip=95.215.58.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ab0mLKLS"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/uU6ExnLVG8tAtofPabSQjz3nnh9Al8RD1/uyGGyRwE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787922842; v=1; x=1788527642;
 b=ab0mLKLSYKni1Yn1cpe1G22RYFOfCOAqM4B9Gc5qj3+XmMMNXEZRbuVfdTrFsy5o2jPM9/HJ
 /CMhFaWfH1jxX8uXrwrlmCJqvxrRU8exSqw7AlY/VpdFvNawsF2UevDvtc+sX1EqI0dF1s1OE7W
 mKOYsJ99ut+ZiAv6p5Cg0eQY=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ffb82de6059f5183;
	Fri, 28 Aug 2026 13:13:52 +0000
X-Mizu-Trace-ID: ffb82de6059f5183
X-Migadu-Flow: FLOW_OUT
Message-ID: <f0b9caba-7851-444c-a242-44e4a35dd0e4@linux.dev>
Date: Fri, 28 Aug 2026 21:13:44 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: pch_gbe: Propagate device restart errors from
 resume
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260828105722.29952-1-pengpeng@iscas.ac.cn>
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <20260828105722.29952-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/8/28 18:57, Pengpeng Hou 写道:
> pch_gbe_up() can fail while allocating the IRQ or receive and transmit
> buffers.  The resume path ignores that result and attaches the netdevice
> even though restart did not complete.
>
> Return the restart error, leave the netdevice detached, and restore the
> PHY and PCI device to the suspended resource state.  pch_gbe_up()
> already frees allocations made before its failure.
>
> The issue was identified via static analysis and manually reviewed.
>
> Fixes: 77555ee72282 ("net: Add Gigabit Ethernet driver of Topcliff PCH")
>
> Assisted-by: LLM
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>   drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
> index 88c5c52e0e38..737bdc9d569e 100644
> --- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
> +++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
> @@ -2449,7 +2449,7 @@ static int pch_gbe_resume(struct device *device)
>   	struct net_device *netdev = pci_get_drvdata(pdev);
>   	struct pch_gbe_adapter *adapter = netdev_priv(netdev);
>   	struct pch_gbe_hw *hw = &adapter->hw;
> -	u32 err;
> +	int err;
>   
>   	err = pci_enable_device(pdev);
>   	if (err) {
> @@ -2462,8 +2462,14 @@ static int pch_gbe_resume(struct device *device)
>   	/* Clear wake on lan control and status */
>   	pch_gbe_mac_set_wol_event(hw, 0);
>   
> -	if (netif_running(netdev))
> -		pch_gbe_up(adapter);
> +	if (netif_running(netdev)) {
> +		err = pch_gbe_up(adapter);
> +		if (err) {
> +			pch_gbe_phy_power_down(hw);

The comment in pch_gbe_phy_power_down() explicitly says that the PHY
cannot be powered down when WoL is enabled or AMT is active.

Please do not call it unconditionally here.

Thanks,
Xuanqiang

> +			pci_disable_device(pdev);
> +			return err;
> +		}
> +	}
>   	netif_device_attach(netdev);
>   
>   	return 0;
