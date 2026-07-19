Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB6F271443;
	Sun, 19 Jul 2026 11:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784462358; cv=pass; b=AVCviXOAMpWBPJZmN99CWyVXI7mcalZwi27wYUN80Dtv72njz+ASiRHEZUDbxfih5u/cWnC/qjyjipUmVxC6YjI/3bbLvAPuhXt0d6OQe2rBJJ/1kFdO4NSGAZcHLZc5LipmVp92YNqb3LLLqVNPE9CoYGjwDIl7bSomFg75Cvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784462358; c=relaxed/simple;
	bh=NcCjt5gMEzO/trevUdNMrSOLpz2ZQci3V8J4jHSf/lU=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RFSPs30LAGgog5nlI8APArAi57ipVohCweFR+hWvi1qfHabO4a5Pva+kx23wm62YZOMVuL+0ncqcz32tUwHzG91C/XquNgwFBf0EMnXfDBQi1C6zHH/zH7gC1O0C/w1KwM3vj2AzrM/vg/p8qA4bygia4+WV9doXgqGFQqaRECo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=WKfWFWFG; dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=/YtPfBks; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="WKfWFWFG";
	dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="/YtPfBks"
ARC-Seal: i=1; a=rsa-sha256; t=1784462320; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=NUuAoqeEzzOZUqwkc08xypSPM0JDXfZGkuoRjRe2Wsh9P/Y47p36MIK57EGXUkejo7
    qNqnehn8Mh78/7DHJnlBRZuyIxvxjtPVlHBbNDQev1eQABjqRRbGPp8s+6mpW536S+vi
    MjtQoNhBpzIOHYlHkItqECp+AJMrBC3iqFu4jcDHhOcQWnR0q0dt6oMkejA+VSah8rTN
    7QqieMqCa+skTym13QX/qrU0Y3RM1spzSrakW19K4GExdbZDxLUJF816hKa/vB4OJ1BW
    ug3PMvTZs7D+uC3t8/JZT7kGbO1c5NX5dl0Sm1v1zP2HdPk2GTV7kiEUpThFVCF59jbc
    JE2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784462320;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=l7k6IaGR7t9bwxAHN7i2vHEnnRdlc0Zaxj86nGvMKoE=;
    b=VnSB96okmIfoLaFJ+UzhplbGQsPEE8yCtc0YXe6KfDftm9bQ4YlZtcTnAMkLHknIjK
    CPM+m/hPeiKRnPt8/rY4NF4QjKljM7/IFe54OKYwv821YQQ6SwH94gmY0MbMHRdedHng
    iuAduwlsNvbS7waQ2fnp3MmNIsVu6QdLbRWlaYFtPR5mioq53AWcbN1B3P68haWzURYY
    LvDNceZ7l6vfIHM0TdFRIP98f69TtBpRLmli5HaoMzMeCvnxfus0UYPOao5NfKHQ6ywA
    CazF0/jIRi5s18sSI4+WxW0570KWkTA8OdzgFc17u+Ku4bzUxejq/WXIOL3DMUCqvULh
    Uh6w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784462319;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=l7k6IaGR7t9bwxAHN7i2vHEnnRdlc0Zaxj86nGvMKoE=;
    b=WKfWFWFGVxWfQW+eFy7ADpCSBOOZLU03sYJpcs2Y7r2CXrYQkYltlfjU2QMfx0MGP5
    t0kSo6i+shBibvlZt+bt/xKCJuFadS5Rok8esTrGVW9xSXJwEHJ2RnBGjNl76yWuvChW
    wgSAQlzb9W1EdGkEDf47rN3SINmIMdEkczceu1DmXCAHTYGt0j2QViDkgVh9x8X9OzdQ
    lbA/26CpRpE8K26o3Eq82LBRGUsfYjGV46ii+exJmkmfY856kAqVfbDKMuzv9e22ax6y
    HwhWkBxyM2ba7M/WsuEUS6pxUw5qEZALiR33vRZQcFVm8ULGO2PDFna43FcHPftoTUNQ
    OqDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784462319;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=l7k6IaGR7t9bwxAHN7i2vHEnnRdlc0Zaxj86nGvMKoE=;
    b=/YtPfBksaeaAZkGpqf2d7Z6yoW8v5H4dg4UgnQfM4HmFObImWwe8NiJs8vecxfTchu
    Jd+/LAlMk68f95mepBCw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIi+m7hzg"
Received: from void-ppc.a-eon.tld
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id eed0ee26JBwb3I9
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 19 Jul 2026 13:58:37 +0200 (CEST)
Subject: [PATCH net v3] net: dpaa: fix mode setting
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: Sean Anderson <sean.anderson@linux.dev>, Michael Walle
 <mwalle@kernel.org>, Madalin Bucur <madalin.bucur@nxp.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Christian Zigotzky <info@xenosoft.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 mad skateman <madskateman@gmail.com>, Damien Stewart <hypexed@yahoo.com.au>
References: <20260717132401.2653252-1-mwalle@kernel.org>
 <4f7497cf-83ed-47cd-2e7b-d06ebe319b61@linux.dev>
 <095e561e-1e36-9ea1-b0c6-958c825851cb@xenosoft.de>
Organization: A-EON Open Source
Message-ID: <e2e75972-13d0-1a5c-23ab-c44913806437@xenosoft.de>
Date: Sun, 19 Jul 2026 13:58:37 +0200
X-Mailer: BrassMonkey/34.2.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <095e561e-1e36-9ea1-b0c6-958c825851cb@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/07/26 18:31, Christian Zigotzky wrote:
> On 17/07/26 23:10, Sean Anderson wrote:
>> On 7/17/26 09:20, Michael Walle wrote:
>>> Before converting to the phylink interface, the init function would 
>>> have
>>> set a non-reserved I/F mode in the maccfg2 register. After 
>>> converting to
>>> phylink, 0 is written as mode, which is a reserved value (although it's
>>> the hardware default). Without a valid mode, a SGMII link is never
>>> established between the MAC and the PHY and thus .link_up() is never
>>> called which could set the correct mode according to the actual speed.
>>>
>>> Fix it by setting the maximum speed of the phy_interface_t in use in
>>> .mac_config() - just like the driver did before the phylink conversion.
>>>
>>> Fixes: 5d93cfcf7360 ("net: dpaa: Convert to phylink")
>>> Suggested-by: Sean Anderson <sean.anderson@linux.dev>
>>> Signed-off-by: Michael Walle <mwalle@kernel.org>
>>> ---
>>> I didn't grab Sean's Rb tag as this is somewhat different.
>>>
>>> Changes in v3:
>>>   - keep the mode setting also in .adjust_link().
>>>   - reword the commit message, to be (hopefully) more precise
>>>   - Link to v2: 
>>> https://lore.kernel.org/r/20260710143430.2276141-1-mwalle@kernel.org/
>>>
>>> Changes in v2:
>>>   - the setting is/was based on the maximum speed, not the current
>>>     speed. thus, move the setting into mac_config().
>>>   - Link to v1: 
>>> https://lore.kernel.org/r/20260706121011.1948906-1-mwalle@kernel.org/
>>>
>>>   .../net/ethernet/freescale/fman/fman_dtsec.c    | 17 
>>> ++++++++++++-----
>>>   1 file changed, 12 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/freescale/fman/fman_dtsec.c 
>>> b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
>>> index fe35703c509e..b8d70c0ecb6c 100644
>>> --- a/drivers/net/ethernet/freescale/fman/fman_dtsec.c
>>> +++ b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
>>> @@ -900,22 +900,28 @@ static void dtsec_mac_config(struct 
>>> phylink_config *config, unsigned int mode,
>>>   {
>>>       struct mac_device *mac_dev = fman_config_to_mac(config);
>>>       struct dtsec_regs __iomem *regs = mac_dev->fman_mac->regs;
>>> -    u32 tmp;
>>> +    u32 ecntrl, maccfg2;
>>> +
>>> +    maccfg2 = ioread32be(&regs->maccfg2);
>>> +    maccfg2 &= ~(MACCFG2_NIBBLE_MODE | MACCFG2_BYTE_MODE);
>>>         switch (state->interface) {
>>>       case PHY_INTERFACE_MODE_RMII:
>>> -        tmp = DTSEC_ECNTRL_RMM;
>>> +        ecntrl = DTSEC_ECNTRL_RMM;
>>> +        maccfg2 |= MACCFG2_NIBBLE_MODE;
>>>           break;
>>>       case PHY_INTERFACE_MODE_RGMII:
>>>       case PHY_INTERFACE_MODE_RGMII_ID:
>>>       case PHY_INTERFACE_MODE_RGMII_RXID:
>>>       case PHY_INTERFACE_MODE_RGMII_TXID:
>>> -        tmp = DTSEC_ECNTRL_GMIIM | DTSEC_ECNTRL_RPM;
>>> +        ecntrl = DTSEC_ECNTRL_GMIIM | DTSEC_ECNTRL_RPM;
>>> +        maccfg2 |= MACCFG2_BYTE_MODE;
>>>           break;
>>>       case PHY_INTERFACE_MODE_SGMII:
>>>       case PHY_INTERFACE_MODE_1000BASEX:
>>>       case PHY_INTERFACE_MODE_2500BASEX:
>>> -        tmp = DTSEC_ECNTRL_TBIM | DTSEC_ECNTRL_SGMIIM;
>>> +        ecntrl = DTSEC_ECNTRL_TBIM | DTSEC_ECNTRL_SGMIIM;
>>> +        maccfg2 |= MACCFG2_BYTE_MODE;
>>>           break;
>>>       default:
>>>           dev_warn(mac_dev->dev, "cannot configure dTSEC for %s\n",
>>> @@ -923,7 +929,8 @@ static void dtsec_mac_config(struct 
>>> phylink_config *config, unsigned int mode,
>>>           return;
>>>       }
>>>   -    iowrite32be(tmp, &regs->ecntrl);
>>> +    iowrite32be(ecntrl, &regs->ecntrl);
>>> +    iowrite32be(maccfg2, &regs->maccfg2);
>>>   }
>>>     static void dtsec_link_up(struct phylink_config *config, struct 
>>> phy_device *phy,
>>
>> Reviewed-by: Sean Anderson <sean.anderson@linux.dev>
>>
>> Christian, can you test this patch with ethernet at 100/1G speed if 
>> you still have
>> access to those P5020/P5040 boards?
>>
>> https://lore.kernel.org/all/0bfc8f3d-cb62-25f4-2590-ff424adbe48a@xenosoft.de/ 
>>
> I tested the patch today. I don't see any differences.
>
> Further information: 
> https://github.com/chzigotzky/kernels/releases/tag/v7.2.0-rc3-fman-dtsec-patch
>
> Christian
>
I tested further the new patch today and switching between 100Mbit/s and 
1Gbit/s works without any problems.

[ 1692.006428] fsl_dpaa_mac ffe4e8000.ethernet eth0: PHY 
[mdio@ffe4e1120:03] driver [Micrel KSZ9021 Gigabit PHY] (irq=POLL)
[ 1692.006448] fsl_dpaa_mac ffe4e8000.ethernet eth0: configuring for 
phy/rgmii link mode
[ 1692.021436] fsl_dpaa_mac ffe5e8000.ethernet eth2: PHY 
[mdio@ffe4e1120:07] driver [Micrel KSZ9021 Gigabit PHY] (irq=POLL)
[ 1692.021456] fsl_dpaa_mac ffe5e8000.ethernet eth2: configuring for 
phy/rgmii link mode
[ 1695.057699] fsl_dpaa_mac ffe4e8000.ethernet eth0: Link is Up - 
1Gbps/Full - flow control rx/tx
[ 2148.681140] fsl_dpaa_mac ffe4e8000.ethernet eth0: Link is Down
[ 2149.704534] fsl_dpaa_mac ffe4e8000.ethernet eth0: Link is Up - 
100Mbps/Full - flow control rx/tx
[ 2199.875179] fsl_dpaa_mac ffe4e8000.ethernet eth0: Link is Down
[ 2201.923103] fsl_dpaa_mac ffe4e8000.ethernet eth0: Link is Up - 
1Gbps/Full - flow control rx/tx

- Christian

-- 
Sent with BrassMonkey 34.2.2 (https://github.com/chzigotzky/Web-Browsers-and-Suites-for-Linux-PPC/releases/tag/BrassMonkey_34.2.2)

