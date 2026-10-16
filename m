Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CA73CB550;
	Fri, 16 Oct 2026 19:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792179071; cv=none; b=cinFPTdsb1D/E1LJmPh0TRNnb2bqoMilZ6n/8IJe+adHEx7X3ILt4r+uLMOMb7mHBwsQov16wt+XGCDFrQxQRgljnrJJQxB749oRwICbPMZ55cBIS775MDtbH03gQGPmFGNR1brfBJPmams+aPRjsxIgL/8T09dGfR3pGIf17JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792179071; c=relaxed/simple;
	bh=yS3WAtbr3CH0Kc8j14aXvzqR3HkDhAguhlVl+RmKfdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GlJR83K14cc7q4y2cCXw3KbyC31rQ9HBRI8IpQAJN2iLoebXZLhTbKd+gxc98bRMRbXIwA84EoFWHhGMTIZVihQshrnU4m6GviUBiqEGN5IgdU/DEYRwF1zqZsL91BaKCIU+xCub3da9yPM/V316Xq1aePd7xgbcD/e8mvfDoHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=JZ4yNV5V; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="JZ4yNV5V"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E749C1095A8;
	Fri, 16 Oct 2026 21:31:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1792179062;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=cWKAp97uuwcOkyhGnwmcdV9GRcG/qs2w/Mc8xr3/noY=;
	b=JZ4yNV5VoUXE+V0iYpmUVm99bVQtqRrIYZ0Mb0GiV8H8eSIq2m0Ao2V0WFign3sv72Cc+W
	zEscgdkAciVY8/NHsUYK3yM3KLt2YPoX+UHbwuAYGqjUTtNrnX/GmNF/RWdVhOVtHhtqkT
	nkjkLheiq1KYK23+ObxnabNCVN5i2yYQUtMnMz5pDrsvIn/qdsPSbeDHhdwcWEQ3l8DOnh
	kYFoENJ8x9kT/yimVEeApLYVpcCg2DbY/CnjgHqxahP+loOBt/HO1hPCt/GeLs5Eh/jAXa
	OScMNH8sVpiLQhRzHiXqw2dffG6xBh+qpAjHJRMPodxbO0p0ZVqguEwwjKBQkQ==
Message-ID: <df4212fa-2fb8-40ab-872a-40bd8a35ba0b@nabladev.com>
Date: Fri, 16 Oct 2026 21:09:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH v2] enetc: Increase eMDIO MDC rate to 2.5 MHz
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20260924180607.60932-1-marex@nabladev.com>
 <AS4PR04MB93382AF6B2AC7B5F421019BB888B2@AS4PR04MB9338.eurprd04.prod.outlook.com>
 <af3d4fd1-9659-4d91-997f-6bb09ae06ba5@nabladev.com>
 <20261013152559.cnh2i7i36hak6z3t@skbuf>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20261013152559.cnh2i7i36hak6z3t@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 10/13/26 5:25 PM, Vladimir Oltean wrote:
> On Wed, Sep 30, 2026 at 06:19:04AM +0200, Marek Vasut wrote:
>> Are those clock which feed MDC clock available via clock framework on LS ?
>> If so, we could calculate the divider based on those clock.
> 
> Yes.
> 
> On LS1028A, the ENETC clock selection is made by a mux called HWA_CGA_M4_CLK_SEL
> (Hardware Accelerator Block Cluster Group A Mux 4 Clock Select).
> 
> You can describe that in ls1028a.dtsi like this (note that in the RM,
> the mux numbering is one-based, while in the device tree it is 0-based,
> so 3 is actually "MUX 4"):
> 
>   			enetc_mdio_pf3: mdio@0,3 {
>   				compatible = "pci1957,ee01", "fsl,enetc-mdio";
>   				reg = <0x000300 0 0 0 0>;
> +				clocks = <&clockgen QORIQ_CLK_HWACCEL 3>;
>   				#address-cells = <1>;
>   				#size-cells = <0>;
>   			};
> 
> Upon clk_get_rate(), the qoriq clockgen driver will use the device tree
> definition to index the hwaccel[] array and find the ls1028a_hwa4 structure.
> This defines what values the HWA4CSR register can legally take, and what
> each means. It will read HWA4CSR[HWACLKSEL] as 0011 (meaning Cluster PLL2
> divide-by-3). Then to calculate this clock rate, it knows it must read
> CGA_PLL2 and to divide by PLL_DIV3 (1200 / 3 = 400 MHz).
> 
> Note the ENETC PTP device already has this property defined (which is
> OK, all ENETC devices share the same clock).
> 
> Without a 'clocks' and/or 'clock-frequency' property, we have to figure
> out a default that works for everyone, or if that fails.
> 
> For example, with 400 MHz enet_clk on LS1028A, the original
> MDIO_CFG_CLKDIV value of 258 used to produce an MDC frequency of
> 400000000÷((258×2)+1)=773 KHz.
> 
> Your new MDIO_CFG_CLKDIV value of 66 produces 400000000÷((66)+1)=3 MHz,
> which is too high to be a default value. So from LS perspective, this
> patch needs to be reverted.
> 
> Generally it is assumed that low MDIO clock frequencies are not a
> problem. Otherwise, drivers/net/mdio/mdio-bitbang.c could never work.
> It seems TJA1120 is the odd one for requiring a maximum MDC clock
> period of 1000 ns.
> 
> Please use xgmac_mdio_set_mdc_freq() as model, since it exists to
> solve a very similar issue as you are trying to do.

All right, let's revert the original broken patch (already posted) and 
lemme prepare something similar to xgmac_mdio_set_mdc_freq(). Thanks !
