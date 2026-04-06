Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D03E2D4816
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775466399; cv=none; b=pok8EQHy2HnnHythN5Q5XuH0CojnXW8V5Cbz5SqEMdx5LzHPtb6eHOZNbwTfdNxvPayoCf61cXYdchR6BNe6nD+k9RxUNYSvgCC74nwcPvkv1BU1DmtTP/QmjpTzd4Hrab+qw2WLXmJfy9JrRl1Sp1MOHKNnsTcdxhsTS4wMF0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775466399; c=relaxed/simple;
	bh=VfE417mO2SukjVNPjjFP0ubgR2q8aBP+cD83aqjp8CU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qW0/eGU67TUhEk32Hs8QsUSQoS3GyEF7UYx9kcFFRiSSkORQQWVd3HhXt1Q1vlxxEhp2fCqwzjhxov6K1NSfT54JYswmI05RYWyw6GkHExakprc8Rukg7wWFqs5koplc47tWD/6DZwoDi1laBQwinT0EIXgJKrVPC7lizTNM5Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=FSd4GMUt; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="FSd4GMUt"
Received: (wp-smtpd smtp.wp.pl 16673 invoked from network); 6 Apr 2026 11:06:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1775466393; bh=d8U0tbA0U+a1sTKaYaAgDmYVd2FSU5vu1PgfxjFtGp0=;
          h=Subject:To:Cc:From;
          b=FSd4GMUtj+o2O79k2XhKpBnvVdMzveF7BRjpSGiQtDt0c1X6YuedC/gkdhl7aZPcK
           kLNWbXT5WwC+DmkGhYRPGTJ+7sgOgQu/2CYGjMhdk9Y/82FLYtgHEh4GVQdD/840ZO
           Fgs9ZBMgRbIcx6vw1iuFzjg+kY1PSIGIpGebkYseGq9OSQbdLMUYTZJtfJt3yPObwt
           IFRKXCI5PnQsfVjDA1lp7PYVErhf7I7P+8kYImXDPq/eOBwL8O6Zc1ufYqodcJO7fB
           cGL9NCNtkZW++5m+yeGVSloGQXXZkEDGb9KauqBh+LP7jf5Aadqacyg+KeYL88H2+d
           YMJgpzHI5AnDw==
Received: from 83.5.32.228.ipv4.supernova.orange.pl (HELO [192.168.2.103]) (olek2@wp.pl@[83.5.32.228])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <marek.vasut@mailbox.org>; 6 Apr 2026 11:06:33 +0200
Message-ID: <afe58c43-ccce-4ace-80d2-a3ed09e166c9@wp.pl>
Date: Mon, 6 Apr 2026 11:06:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH v5 3/3] net: phy: realtek: Add property to enable
 SSC
To: Marek Vasut <marek.vasut@mailbox.org>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Conor Dooley <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Ivan Galkin <ivan.galkin@axis.com>,
 Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Michael Klein <michael@fossekall.de>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, devicetree@vger.kernel.org
References: <20260326210704.58912-1-marek.vasut@mailbox.org>
 <20260326210704.58912-3-marek.vasut@mailbox.org>
 <a03960a2-f313-4c12-98f2-d032ce4a45ad@wp.pl>
 <22564dd5-c2b5-46ec-b083-6239a3ff5a2f@mailbox.org>
Content-Language: pl
From: Aleksander Jan Bajkowski <olek2@wp.pl>
In-Reply-To: <22564dd5-c2b5-46ec-b083-6239a3ff5a2f@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-WP-MailID: 3454027ddb15dd59209e195785fd7180
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [YSPc]                               

Hi Marek,

On 05/04/2026 23:59, Marek Vasut wrote:
> On 4/5/26 10:23 PM, Aleksander Jan Bajkowski wrote:
>
> Hi,
>
>>> +static int rtl8211f_config_clkout_ssc(struct phy_device *phydev)
>>> +{
>>> +    struct rtl821x_priv *priv = phydev->priv;
>>> +    struct device *dev = &phydev->mdio.dev;
>>> +    int ret;
>>> +
>>> +    /* The value is preserved if the device tree property is absent */
>>> +    if (!priv->enable_clkout_ssc)
>>> +        return 0;
>>> +
>>> +    /* RTL8211FVD has PHYCR2 register, but configuration of CLKOUT SSC
>>> +     * is not currently supported by this driver due to different bit
>>> +     * layout.
>>> +     */
>>> +    if (phydev->drv->phy_id == RTL_8211FVD_PHYID)
>>> +        return 0;
>>> +
>>> +    /* Unnamed registers from EMI improvement parameters 
>>> application note 1.2 */
>>> +    ret = phy_write_paged(phydev, 0xd09, 0x10, 0xcf00);
>>> +    if (ret < 0) {
>>> +        dev_err(dev, "CLKOUT SSC initialization failed: %pe\n", 
>>> ERR_PTR(ret));
>>> +        return ret;
>>> +    }
>>> +
>>> +    ret = phy_write(phydev, RTL8211F_SSC_CLKOUT, 0x38c3);
>>
>> Only registers 0x10–0x17 require paged operations. The remaining 
>> registers
>> are mapped directly into the PHY address space. This is mentioned in 
>> commit
>> 650e55f224a575cdb18c984b95036109519502d1. Paged and direct access return
>> the same results. With this in mind, I believe that 
>> RTL8211F_SSC_CLKOUT is
>> an alias for RTL8211F_PHYCR2 and is described on page 45 of the 
>> datasheet[1].
>>
>> 1. RTL8211F(I)-CG/RTL8211FD(I)-CG Datasheet
> This is a good point indeed, I think I can simply set PHYCR2 bits 
> 7,12,13 to enable the CLKOUT SSC ?
Sounds correct.


Regards,
Aleksander
