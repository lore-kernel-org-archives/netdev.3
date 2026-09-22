Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619775616A2
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790083231; cv=none; b=jf8247ErXpBxZdtFMhXLno5W2biLFylr7qp3CZDPiyFnebEv3aRpTY3abx8vUyqrcm2G9hqX+Y+9Btn8sCZuugrZq8uP4BaDYN+lMcyxgi9DFmKt/xKLAcC7E8gA8n5rNe8QyRYxYZskddXzBqmtQ5V3w/a0XbalmQxHtCqfTxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790083231; c=relaxed/simple;
	bh=V7obrWHWdAK2sr9GRBu2vV54NRwonddAzRSGSOMaNfo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=t6L87+iq2OeyMVur9elNLvMulu1m9iWfzhXwq7CgAVYvWjEnkB8R56ar3T2bVz1d2icry4HVDPuO85G+u4IxaWZ551eGSE9IwgoaqE/ETXLpoFUg4NZ/Z1kRXpdNjdca78Wlj90qKWVoma7vxKBFhQlZP7qrDgkqEvwqSQ+DtVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=lnHd1NVp; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="lnHd1NVp"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 07798A02D4;
	Tue, 22 Sep 2026 15:20:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790083225; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dBu6Up7RjQ62pB4/IdXwodWU9rbgYbAkG6HPXs4Al+g=;
	b=lnHd1NVpSs6aI+bI4Dq0+TnClt6iqPrRypXFeZoVVm1i0wNcD0ARTeQ6XxzvtrXjN62l3e
	UNFwfGFjmV/sqYEwaxPXhQurCpox5Es5M8JZsz8xxzPML/rcHjGkKFWu5NhUZ45ihzY0Me
	ieX57l57xztdz0RwR6aM26Wt+4trFmU9OeUeImmVlqQvLR+Aq0jP7u5T7lhaGcM6S/L8tl
	EFRp2AYwkxijLQXcdAuY3dCLp0Do66iFI4UcXNs8fC0xxcdlfCao9+4lAmGO+L0rZoDa+b
	jV0yHjzrDy7mOk6/wd3oFqfRQx6E224REakvv1zH8F6U3+TTDuIF9XJ4wZ8eGg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Sep 2026 15:20:22 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Christian Lamparter <chunkeey@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, kuba@kernel.org,
 davem@davemloft.net, jacob.e.keller@intel.com, edumazet@google.com,
 maxime.chevallier@bootlin.com
Subject: Re: [PATCH net v2] net: emac: move setting of netops to fix crash
In-Reply-To: <49cd7343bc0e507c022071f3e2b5662b053dca73.1790007431.git.chunkeey@gmail.com>
References: <49cd7343bc0e507c022071f3e2b5662b053dca73.1790007431.git.chunkeey@gmail.com>
Message-ID: <26f6da2763e771c04815352597ae1c6d@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Christian

On 21.9.2026 18:28, Christian Lamparter wrote:
> fixes the following crash on driver initialization:
> 
> |BUG: Kernel NULL pointer dereference on read at 0x00000158
> |Faulting instruction address: 0xc0566b40
> |Oops: Kernel access of bad area, sig: 11 [#1]
> |BE PAGE_SIZE=4K  PowerPC 44x Platform
> |Modules linked in:
> |CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: GW 7.3.0-rc3+ #1
> |Tainted: [W]=WARN
> |Hardware name: MyBook Live APM821XX 0x12c41c83 PowerPC 44x Platform
> |NIP:  c0566b40 LR: c05648f8 CTR: c04c1e9c
> |REGS: c1053a20 TRAP: 0300   Tainted: GW  (7.3.0-rc3+)
> |MSR:  0002b000 <CE,EE,FP,ME>  CR: 24008808  XER: 00000000
> |DEAR: 00000158 ESR: 00000000
> |GPR00: c05648f8 c1053b10 c1063600 c1030000 c5ab3000 00000000 [...]
> |GPR08: 00000002 00000000 00000000 c1053b40 84002808 00000000 [...]
> |GPR16: cfffd210 00000002 c0beafcc cfffc960 00000000 c1030644 [...]
> |GPR24: c0beafbc c1037000 00000000 0000000a 00000000 c1030000 [...]
> |NIP [c0566b40] phy_link_topo_add_phy+0x2c/0x1d0
> |LR [c05648f8] phy_attach_direct+0x1a4/0x368
> |Call Trace:
> |[c1053b10] [c0811e04] klist_put+0x54/0xb4 (unreliable)
> |[c1053b40] [c05648f8] phy_attach_direct+0x1a4/0x368
> |[c1053b70] [c0564ae8] phy_connect_direct+0x2c/0x60
> |[c1053b90] [c056c7a8] of_phy_connect+0x50/0x74
> |[c1053bc0] [c0572a88] emac_probe+0xd50/0x119c
> |[c1053c90] [c04cb770] platform_probe+0x74/0xa4
> |[c1053cb0] [c04c8f08] really_probe+0x120/0x2b0
> |[c1053cd0] [c04c9254] __driver_probe_device+0x1bc/0x1fc
> |[c1053d00] [c04c9334] driver_probe_device+0x38/0xa8
> |[c1053d30] [c04c9560] __driver_attach+0xf4/0x10c
> |[c1053d50] [c04c6af8] bus_for_each_dev+0x68/0xd0
> |[c1053d90] [c04c7c34] bus_add_driver+0xcc/0x1ec
> |[c1053dc0] [c04c9f6c] driver_register+0xcc/0x110
> |[c1053de0] [c0aa3f40] emac_init+0x1c4/0x200
> 
> This bug showed up starting with v7.3-rc1. At the NIP in
> phy_link_topo_add_phy() is a netdev_need_ops_lock() check.
> This was added by the following
> commit ded86da4bbb7 ("net: ethtool: relax ethnl_req_get_phydev() 
> locking assertion")

ded86da4bbb7 was added in v7.2-rc1?

   $ git grep -c netdev_need_ops_lock v7.1 -- 
drivers/net/phy/phy_link_topology.c
   $ git grep -c netdev_need_ops_lock v7.2-rc1 -- 
drivers/net/phy/phy_link_topology.c
   v7.2-rc1:drivers/net/phy/phy_link_topology.c:1

> 
> The bug shows up because at the time of_phy_connect() was called, the
> netdev_ops were *not yet* determined. My fix is to move the code that
> sets netdev_ops+commac.ops+ethtool_ops further up as emac_init_config()
> derives that by looking at the device-tree and sets the required
> dev->phy_mode accordingly.
> 
> During review, the Sashiko bot's AI stated that the commac assignment
> became a dead store. Great catch! To keep the original behavior as-is,
> one mentioned option "set dev->commac.ops = &emac_commac_ops only in
> the non-gige case?" sounded like a great plan. So the dev->commac.ops
> assignment for the non-gige-case moves into the else block.
> 
> This patch was tested on a WD MyBook Live (RGMII). the device now works 
> again.

nit: [...] (RGMII). the device" -> The device

> 
> Fixes: ded86da4bbb7 ("net: ethtool: relax ethnl_req_get_phydev() 
> locking assertion")
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> ---
> 
> v2:
>   - "set dev->commac.ops = &emac_commac_ops only in the non-gige case"
>   - reworded commit message to include commac_ops and Sashiko
> v1: 
> https://lore.kernel.org/all/178999551085.2160803.13630958553679103031@kernel.org/
> ---
> [...]

With the commit message changed:

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks
Nicolai
