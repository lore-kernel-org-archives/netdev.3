Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8B9226D05;
	Wed, 26 Aug 2026 00:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787705997; cv=none; b=GBGUS9pb0y1hMfcLgPDF6fbHE1ZKCz+xKGvFksVUHiQPe3T0v5ePX5py9DVvxTyyVHOt/g4/P3kavwca/R01mJSIrh+oNTqfR4N4kOj4eoucmQA1vw5kG7tjRSChQpm1Uz+yKh9bSn+SlTPEPan67gIX0kauMHDAMpfNRqG+ZxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787705997; c=relaxed/simple;
	bh=KXGI0iKaZmT839Wx1OWbGMxwNFK55RyTUtTtSZq4Nn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQuX59CFe75ZKjqYI/gzszJ8Gph53LB4rDAYnlju39Q4Q8GTp1JPwqmHCVDeNM/bcvGcRNXh01qQEOhIURWSVBrsbHEPi7ME4tLkJyy7KTUJh0A2UIf3xoY2q+33Xi5GVi30i1zg71Er3E2F0/dCOisGLb17vt/05pi5wqefiqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=pass smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=qgWkSdsN; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="qgWkSdsN"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 247351C6BA7;
	Wed, 26 Aug 2026 02:59:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1787705992; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=NYZTQkL5Jzv5jHcLk9d/FWbuGL1zpQHqOJLwaJI1Qdk=;
	b=qgWkSdsNodFTmessuFQuNJNkTikXGeDFLJioSMdU5XVoHnZLlYBxtSWEfobf56AHPm6tbk
	DUAjtqoxNxpejWOOsUFTtoFXv6fwmzGfOeXKC2FYBMKZhi4HAJqjtbCTKbjY7bjn6whkOA
	zgUqOuqc2gCXUlrjVtDlTOSixrOnEI6NrXFbtiO5khf/GWEGH7uvHpqD3lgIEyYdIcuvJj
	SATbSE+uD//L6aeHTQgUHhWg84x89vtWZukmQHkmDcva9hD8c5D6QaEZA7yC4IAO81AbJm
	r2IVR7BQcBhfme4EDgSC3lYmNnPkr1Umvsayfm5C/GFeY2K94SnST489EBYCww==
Message-ID: <a75b6b15-f86b-4cb2-934c-87583b5bb02c@cjdns.fr>
Date: Wed, 26 Aug 2026 02:59:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next 3/3] net: phy: mediatek: support EcoNet EN751221
 gbit SoC PHY
To: Andrew Lunn <andrew@lunn.ch>, ansuelsmth@gmail.com
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, daniel@makrotopia.org, dqfext@gmail.com,
 SkyLake.Huang@mediatek.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20260825193456.1823985-1-cjd@cjdns.fr>
 <20260825193456.1823985-4-cjd@cjdns.fr>
 <d7d86078-8a29-4e7f-a62e-91f6b266bea1@lunn.ch>
Content-Language: en-US
From: Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <d7d86078-8a29-4e7f-a62e-91f6b266bea1@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3


On 26/08/2026 02:00, Andrew Lunn wrote:
>> +static int en751221_tx_amp_compensation_tbl[2][TRANSFORMER_TYPE_MAX][MDI_TYPE_MAX][CALIB_CONST_TYPE_MAX][4] = {
> const?
Ahh yes, indeed all of them should be. Note to Ansuel: This is relevant 
to your Airoha code as well.
>
>> +static u8 en751221_zcal_to_r50ohm[64] = {
> const?
>
>> +	125, 125, 125, 125, 125, 125, 124, 121, 118, 115, 112, 110, 108, 105, 103, 101,
>> +	 99,  97,  95,  77,  75,  73,  72,  70,  68,  67,  65,  64,  63,  45,  44,  43,
>> +	 41,  40,  39,  38,  37,  36,  35,  34,  32,  32,  31,  30,  13,  12,  11,  10,
>> +	  9,   8,   8,   7,   6,   5,   5,   4,   3,   2,   2,   1,   0,   0,   0,   0
>> +};
>> +/* EN751221 also mirrors RG_BG_RASEL into CHIP SCU register 0x16c. */
>> +static void en751221_gphy_mirror_rext(struct phy_device *phydev, u8 zcal)
>> +{
>> +	struct regmap *chip_scu;
>> +
>> +	chip_scu = syscon_regmap_lookup_by_compatible("econet,en751221-chip-scu");
> Does this need a change to the binding document?


Not as far as I know. econet,en751221-chip-scu is defined in 
mfd/syscon.yaml because it's a catch-all for configuration that the 
engineers didn't know what to do with.


>
>> +static int en751221_gphy_config_init(struct phy_device *phydev)
>> +{
>> +	phy_write_mmd(phydev, MDIO_MMD_AN, MDIO_AN_EEE_ADV, 0);
> Why is the EEE register being cleared?


 From reading the reference implementation, I get the impression that 
this hardware is something of a basket case. There was a certain amount 
of "write three times and then read back" type magic that I just omitted 
because it really looks like they were actively debugging and as soon as 
it started working they shipped the code exactly as it was.


In the case of disabling EEE, I thought it more prudent to follow them 
because I don't have every SoC that this PHY ever appeared on and I 
would rather not diverge too greatly and risk it being unreliable on 
some devices.


>
>> +
>> +	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_52B5);
>> +	__mtk_tr_write(phydev, 0x1, 0xf, 0x00, 0x00002b);
>> +	__mtk_tr_write(phydev, 0x1, 0xf, 0x03, 0x082422);
>> +	phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);
>> +
>> +	ret = phy_write(phydev, MII_CTRL1000,
>> +			ADVERTISE_1000FULL | CTL1000_PREFER_MASTER |
>> +			CTL1000_AS_MASTER | CTL1000_ENABLE_MASTER);
> What does this default to?
It starts with only ADVERTISE_1000FULL. I don't know why the engineers 
wanted to set it to master, but its definitely intentional.
>
>> +
>> +	phy_set_bits(phydev, MII_BMCR, BMCR_ANRESTART | BMCR_ANENABLE);
> Why? config_aneg() will do this, if needed.


Okay this is probably just because the code I was working from is very 
old. I will review this and see if it's truly needed.


Also you're certainly more knowledgeable than me about what to expect 
from PHY hardware, so if it is your opinion that setting master and 
disabling EEE are probably not a real workaround for stability problems, 
then I'll be happy to give it a try with these omitted.


Thanks,

Caleb


>
>       Andrew
