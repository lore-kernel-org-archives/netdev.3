Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F9D503BC7;
	Fri, 18 Sep 2026 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789750033; cv=none; b=bFJcA0Ck0QyqNZi9gE99Z4dEUYjV07HTN30Ailz0Id50PuV7Y9F8q8XaXk6QtqZM2MvDSTOKgriTsp3CXFTb+g5qeJMg6QE5xI5suezcIEVUBBail7LMGlcflyVZJsMk7Fo/f3cpSq9KOxMszO60F30S0uI6cndUqRrloWIgBWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789750033; c=relaxed/simple;
	bh=9dUsgZfaC5ynjRqR2mA+KiuUZWGt+cEcc7zD5LHnQ6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pnfe4+SBJsfIbjtk9C1YPu1DYQjPofJzcxrBHZxWhHxk+eODA1WSd/NdxJKUltSb+dQOB2NDuAZ6s3Ew1HH8nGZn/3dpCvtoY5mDnOnSMRetykdHwz2XLg2JkG10/OJxYs/zhdgMtZdE5D0sARj/YPV0Vj+ENZUSzir1VoblnS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=vr5SqXfF; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="vr5SqXfF"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 749D64E2238;
	Fri, 18 Sep 2026 18:47:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1789750028; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=UGJR71OzTgD+793duzAUbf0/RDM0BWmknQdjIdLI5eM=;
	b=vr5SqXfF0KNC0ux6YFkuxs5vjPbJena3DLzmT+4x73Q2hVXk1qQ8w7dX052VRmll4vWq5s
	a/bNS9bajAf0A9iBXzvkrKwpRqVSbFukRv6IQK4Vt9/bCKTzBgFNiJoEZoFWP0MaBa0Ca4
	H+pGAW10l7scr+jBL9f6PD8w0WprFUy0lZBr/fLSRx7/TidEsvyjXLTCQh5cE3jyCgUcS3
	6e200wqSoPwsbtWfzJOcWx+Ma4tjZVmk2kTcbYetHfLQSbsohSeo+D+bU1r0KXURGMAl0z
	9/6EXSR9mxNiLCd1ITpa4ZHYaqxW71/e8vAURTik4Z7RNpK200NGwOUOj3dNGQ==
Message-ID: <accc40a4-f447-498c-ab45-96d1f2d2cc33@cjdns.fr>
Date: Fri, 18 Sep 2026 18:47:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next] net: phy: mediatek: do not match MT7530 PHY if
 10/100 only
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, daniel@makrotopia.org, dqfext@gmail.com,
 SkyLake.Huang@mediatek.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20260918161156.377822-1-cjd@cjdns.fr>
 <4fe68c4b-b72e-4cbb-9a0e-2731ec68888c@lunn.ch>
Content-Language: en-US
From: Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <4fe68c4b-b72e-4cbb-9a0e-2731ec68888c@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3


On 18/09/2026 18:29, Andrew Lunn wrote:
> On Fri, Sep 18, 2026 at 04:11:56PM +0000, Caleb James DeLisle wrote:
>> An EcoNet SoC 10/100 PHY uses the same ID as the MT7530 PHY, but a true
>> MT7530 PHY always has gigabit support so they can be distinguished by
>> the presence of the ESTATUS_1000_TFULL flag. Add a match_phy_device
>> which refuses to match if the PHY is not gigabit.
> Don't you also need the opposite in mtk-fe-soc.c? Otherwise don't you
> rely on the load order of the PHY drivers?

The collision is in econet-fe-soc.c of 
https://lore.kernel.org/netdev/20260827065930.2618729-3-cjd@cjdns.fr/

And I notice now that I did add it in that patchset as well, but this 
implementation is better done and that patchset is probably going to 
have a v2 so I think it's better to accept it here.

Thanks,

Caleb

>
>      Andrew
>
> ---
> pw-bot: cr
>
