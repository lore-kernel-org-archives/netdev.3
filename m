Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9199844236E;
	Sun,  4 Oct 2026 14:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791122969; cv=none; b=kGUf52uWQUVgOGHdYi1OPpvhBlwWVOx3VZZW7CYyGECbQfHxFiCyagps8SE/0acya5uT/IBTCO2GPNWzSKUHhzGgptK2V0wMFvqrwcGcrS4GYPiQKCG96cQy8ze9z7cWONCve9CyHFLfKu3KcTug6dWN/LJdKTS8ZWiliK6LylU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791122969; c=relaxed/simple;
	bh=Kaa86eboQu/X3T7glwzC/YarM+pq0D1ynesTItEEd5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Dvq1Y6K21oZCSiPyd1HvqCz8PS/9TItP98T4BfIRFY4F0pxHg/Oq3qwkMi/lmaqNcEUX+sokYPShec79qT6B1RKRAow6wY3OuvVOZByUno3n/2mR8n21rlTZCNoNmVeDc6UdEDbnJ0E1t5a4rJ2HNV9fjzdWX3l3ZcD9qzaJ8XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bERDHDH1; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bERDHDH1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791122972; x=1822658972;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Kaa86eboQu/X3T7glwzC/YarM+pq0D1ynesTItEEd5Q=;
  b=bERDHDH1eTaysm8uKttQUnRZrzRn6jHA27cdxE3c2UNFo3y6bcPzndHW
   72kYVb3m1fVnmxRBOQgmZhaTe5K/81NCKpKy2SldJ+fu2wJ5RrJpiA8e9
   mZ8bTm6qpPBFeHWRgcEIOgZKNTgaI40QZCfT/dBiYvtHBBJAoAXQIfSPK
   nYPIzLkbBr7bt5xiGxZRQJkfct2rdq/Jg2im4mYVM//YoNvq2weIWc5ce
   78ApVwD2QqtJpij/8YSmcO0jNsnxx6JdNQ5OpuUwdbRBfnvHSvviGbMWB
   w+UzJN69n5Iv13WZBr+JNrV5Q3Zhl9wILzi1pw09NOBXYiRj5i4/fFGnB
   g==;
X-CSE-ConnectionGUID: nFlN5v7/QJyv4cm/z303NA==
X-CSE-MsgGUID: o64pbRNjTK6hxnTwGxhgfA==
X-IronPort-AV: E=Sophos;i="6.27,139,1787036400"; 
   d="scan'208";a="231648346"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2026 07:09:26 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Sun, 4 Oct 2026 07:09:21 -0700
Received: from [10.40.24.197] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Sun, 4 Oct 2026 07:09:17 -0700
Message-ID: <4ff8d16f-0a05-49bc-84b7-4d1b625a724c@microchip.com>
Date: Sun, 4 Oct 2026 19:39:16 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/4] net: phy: microchip_t1s: fix collision
 detection on PLCA status change
To: <netdev-bot+sashiko@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
References: <20260929125928.611784-2-parthiban.veerasooran@microchip.com>
 <179103456181.434549.13678740418494545404@kernel.org>
Content-Language: en-US
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
In-Reply-To: <179103456181.434549.13678740418494545404@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Thanks for the review.

I’ll look into the reported comments in all the patches in this series 
and get back with the necessary updates as soon as possible.

Thanks,
Parthiban V

On 03/10/26 7:06 pm, netdev-bot+sashiko@kernel.org wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 2
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The collision-detect (CDEN) setting is chosen from a software
>    copy of the PLCA enable state (priv->plca_enabled), not from the PHY's…
> - [Low] [Baseline decision: false.
> - [Low] [Baseline decision: false.
> 
> --
> 
> net: phy: microchip_t1s: fix collision detection on PLCA status change
> 
> This patch makes the collision detection enable bit (CDEN) follow
> autonomous PLCA/CSMA-CD transitions. It adds a PLCA status change
> interrupt and a resync in read_status(), and it takes the PRSCTL1
> fallback bit into account. It also adds a probe routine that allocates
> a per-PHY mutex and a cached plca_enabled value, and it treats
> plca_cfg->enabled as tri-state.
> 
>> diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
>> index 73c23d311d72a..5ce0304bf0952 100644
>> --- a/drivers/net/phy/microchip_t1s.c
>> +++ b/drivers/net/phy/microchip_t1s.c
