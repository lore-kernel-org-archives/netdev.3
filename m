Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC239523789;
	Wed,  9 Sep 2026 23:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788996389; cv=none; b=hrmEoi19Fqv0bHHQ7CyVPz03AHVumku5qdq59MyT3aA82R53h0Oew4IPrO9Rc6dzkZPcnYxS/fPR+h/loIDcuvb5ghZMmcT6/wQMJVY8mP2ISV0YxnGycxr35dzgmWfW62MIc6mIHqGLzY0oRoouiaiKXxWaVcCgDu5n4MNkJ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788996389; c=relaxed/simple;
	bh=o6J9QzmygitULLoPTGVcSWzV2bRy2IL93iyTFPIz6Y4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ICMVZEaFVRD9mLU6CjkWPnLEq1NQIecuPFYqviZOxw2I95ht1Huv3nKrL3AWtdF+1NAEMIQ5H9gL5JrF62Ygn1NXfwTqMeGWY0Y1Z6kxA0s5riiNWmEFArIh9KViQar39A9DO5WbwGzcwv7JCRLH8v/Vh8PXAHvwJ1mT7e6w9/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=ZLh6GYtZ; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="ZLh6GYtZ"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1C0FB40B4DE;
	Thu, 10 Sep 2026 01:26:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1788996382; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=KjFa+0tDikevuBm4q9CtkZnRLbUXGml043SLQjo4Y20=;
	b=ZLh6GYtZUSHDlwpxATWxSRb0oIeM79jebqM94lRLuSLBRuSzFe+0Sjb2tO757S5xxuC/+2
	m4F4Vr/g8nnHJDp2fSovK1GqrGWMfe+F8u/syXv7tXb1Qtxm+YAfBf03HnA/LrlSE74vGG
	mnvRI7XoQM/iBrcnzoGTalHnKFDzyOdmJSDDx47B81xQaJuoBuxcc0CGeliOGm9bhBkkFF
	mqwDCeBQhSofPD9ULpjm2FLK22l3cVpCNZcw7otqLF2uqb/xJ1hAoyLM4TzKX/zCbcyDZb
	Ij+ryUfcMd+4FnInUtOsKwS+2z0qeCvmMRYkj770MUoVt/lOsTkDn9lUrzToHQ==
Message-ID: <7a3479c8-45cc-4b88-b111-c35d59f370e1@cjdns.fr>
Date: Thu, 10 Sep 2026 01:26:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next] net: phy: mediatek: support MT7530 PHYs on
 EN71221 MCM
To: Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, dqfext@gmail.com, SkyLake.Huang@mediatek.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>
References: <20260909213250.3184238-1-cjd@cjdns.fr>
 <aqHlfmYa249e3HRM@makrotopia.org>
Content-Language: en-US
From: Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <aqHlfmYa249e3HRM@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3


On 10/09/2026 01:02, Daniel Golle wrote:
> On Wed, Sep 09, 2026 at 09:32:50PM +0000, Caleb James DeLisle wrote:
>> The EcoNet EN751221 multi-chip module implementation of the MT7530
>> requires some additional configuration of the PHYs on startup.
>> The reason for this is not known, but it is possible that it has
>> to do with the fact that the EN751221 MCM implementation of the
>> MT7530 runs at an abnormal PLL frequency (362.5Mhz).
>>
>> Detect whether the MT7530 PHY is attached to the MDIO bus of an
>> EcoNet EN751221 switch and if so, apply the necessary register
>> updates.
>>
>> Co-developed-by: Matheus Sampaio Queiroga <srherobrine20@gmail.com>
>> Signed-off-by: Matheus Sampaio Queiroga <srherobrine20@gmail.com>
>> Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
>> ---
>>   drivers/net/phy/mediatek/mtk-ge.c | 61 +++++++++++++++++++++++++++++++
>>   1 file changed, 61 insertions(+)
>>
>> diff --git a/drivers/net/phy/mediatek/mtk-ge.c b/drivers/net/phy/mediatek/mtk-ge.c
>> index 73d9b72f9d9e..42b06c40d703 100644
>> --- a/drivers/net/phy/mediatek/mtk-ge.c
>> +++ b/drivers/net/phy/mediatek/mtk-ge.c
>> [...]
>>   static int mt7530_phy_config_init(struct phy_device *phydev)
>>   {
>> +	int ret;
>> +
>> +	if (mt7530_phy_is_en751221_companion(phydev)) {
> Please introduce a `.match_phy_device` operation for both, actual
> MT7530 and EN751221, similar eg. to `ksz8051_match_phy_device` in
> micrel.c.

Sounds good, since this will certainly collide with 
https://lore.kernel.org/netdev/20260827065930.2618729-2-cjd@cjdns.fr/ 
would you prefer them in the same patch, or as a patch set? If you'd 
like I can do this and the FE phy as a common patch set. Let me know 
what you prefer.

Thanks,

Caleb

