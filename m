Received: from mail.kmu-office.ch (mail.kmu-office.ch [178.209.48.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E943939B3
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 18:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.209.48.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783450651; cv=none; b=VmSTqY7d6z4TKBG7NqCsRWdWlAXtSDqzPU1s1wRfx20tMoKoBAAtE0znsBg34vP0D99qkH15HCNqZe3oXwjzRS8cBjB3KxZi6+zXV28Fpf4lRxSYjAaN6pXVnL1K8btrVVoIXuBwLBOBO0HeiXyevIymIyww6gfYDHWYBbN06QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783450651; c=relaxed/simple;
	bh=SuirHauW++G4Ar/yk7wb9GuULubGuPXTLVBvK9iAPt0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=AvF4fN9lNm288gxshRiLgFdSSZhCJg5K+eM4nZ4orizORqx4txM3d6jPbaEYzc5pIgLxgxZGzhOAen35Q+ITmq2++1PDCBUCh/wY1cjA0QYxcopmBUoIj8spyl5a8U/zv92zE+U165KEcQl0jVH0We1ga8igYMmmukcI8ltkodk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=agner.ch; spf=pass smtp.mailfrom=agner.ch; dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b=VwgDDaMG; arc=none smtp.client-ip=178.209.48.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=agner.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=agner.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="VwgDDaMG"
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
	by mail.kmu-office.ch (Postfix) with ESMTPSA id B379F5C53A1;
	Tue,  7 Jul 2026 20:57:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
	t=1783450646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ydta7jlti9j4LmIExsQGl//hnKkqR/izt7WQIkW8wSk=;
	b=VwgDDaMGjWsUqJunxOtrOFCt44wvbqum4Kq9eG2b5+LsgfyrmGES1P+nzQLAsMnLbDZVbi
	heOXAVXP0PMW0lVmjqKmCACcMKv6fJRCvlHJT4IAoaHFh+UYMRmVoCici37dfthuAyQpWB
	qiGsWVx+hibrDeatdSYGaoS4B163lJ4=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 07 Jul 2026 20:57:26 +0200
From: Stefan Agner <stefan@agner.ch>
To: Jakub Raczynski <j.raczynski@samsung.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Russell King
 (Oracle)" <rmk+kernel@armlinux.org.uk>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Ovidiu Panait
 <ovidiu.panait.rb@renesas.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, regressions@lists.linux.dev
Subject: Re: [PATCH net] net: stmmac: resume PHY before reopening the
 interface on MTU change
In-Reply-To: <ak01QZhCKkq2FM33@AMDC4622.eu.corp.samsungelectronics.net>
References: <20260707162146.73823-1-stefan@agner.ch>
 <CGME20260707172005eucas1p2fdf3255132201e4e2c6fcc835fd2e805@eucas1p2.samsung.com>
 <ak01QZhCKkq2FM33@AMDC4622.eu.corp.samsungelectronics.net>
Message-ID: <75d9132549fce2298f581318e2d2e80f@agner.ch>
X-Sender: stefan@agner.ch
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026-07-07 19:20, Jakub Raczynski wrote:
> On Tue, Jul 07, 2026 at 06:21:46PM +0200, Stefan Agner wrote:
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> @@ -5884,6 +5884,15 @@
>> 
>>  		__stmmac_release(dev);
>> 
>> +		/* phylink_stop() in __stmmac_release() suspends the PHY.
>> +		 * IEEE 802.3 allows PHYs to stop their receive clock while
>> +		 * powered down, but the DMA software reset performed by
>> +		 * stmmac_hw_setup() requires a running receive clock.
>> +		 * Resume the PHY, as on system resume, to ensure its clocks
>> +		 * are running before reopening the interface.
>> +		 */
>> +		phylink_prepare_resume(priv->phylink);
> 
> Does it work without warnings? Nothing in dmesg?

With this patch applied, this is the dmesg log on MTU change:
[   56.761175] rk_gmac-dwmac fe010000.ethernet end0: Register
MEM_TYPE_PAGE_POOL RxQ-0
[   56.762769] rk_gmac-dwmac fe010000.ethernet end0: Link is Down
[   56.801327] dwmac4: Master AXI performs any burst length
[   56.801368] rk_gmac-dwmac fe010000.ethernet end0: No Safety Features
support found
[   56.801409] rk_gmac-dwmac fe010000.ethernet end0: IEEE 1588-2008
Advanced Timestamp supported
[   56.801780] rk_gmac-dwmac fe010000.ethernet end0: registered PTP
clock
[   56.801804] rk_gmac-dwmac fe010000.ethernet end0: configuring for
phy/rgmii link mode
[   61.032985] rk_gmac-dwmac fe010000.ethernet end0: Link is Up -
1Gbps/Full - flow control off

> phylink_prepare_resume() does have ASSERT_RTNL() which is not called anywhere.

I am not very familiar with the codebase, but Fable states:

> RTNL is held here: ndo_change_mtu is invoked from netif_set_mtu_ext(),
> which calls netdev_ops_assert_locked() — for a driver without instance
> locking such as stmmac that is ASSERT_RTNL() — right before calling the
> driver op. 

What I can definitely confirm is that without this patch applied, a MTU
change does not succeed, with it applied MTU change works and the
network interface remains functional.

--
Stefan
