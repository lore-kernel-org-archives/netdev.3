Received: from out28-50.mail.aliyun.com (out28-50.mail.aliyun.com [115.124.28.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C18B44E66D;
	Fri,  4 Sep 2026 09:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514655; cv=none; b=pekboBZ7WLADzhrwzjY7af0vw0+YfJwQQ34lLZWg74fYNyvBEkEg+f1seLa6/ZI+XkjVlZ0EDCUGhaKgbsKJFF392a1Szu/w0REt0O1J5yuGE1+tMXtZKzEV5AOFjNUonolhtWWU1ztC9fCrk9grxOCWVKG4tmrjXadodjinXJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514655; c=relaxed/simple;
	bh=qyxRmIdk4yIKfiujfdUW/iRTWmApfe3X/mU5UK+w2+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DXd29lzVMed5747D9vxEPPK7R53xOEVJfu/PlsPUQzmPsk2b/2rZEtU8iZPMwBT84I5bPPBLXOA1WZZhQUYp963qxH9UZmJiLMP5TIcVfDLoPUUGfdRnqOmeO3xV1CPUaTcZpxWILnQavTK74tTBJPhL16CnBuFBOeWKTcC1cbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07574246|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.089456-0.00158794-0.908956;FP=14598350820424158359|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033040074035;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.j5KgdWn_1788514641;
Received: from 10.10.26.192(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.j5KgdWn_1788514641 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 04 Sep 2026 17:37:24 +0800
Message-ID: <65c09830-acc1-4501-aaf0-9dbe0b5427ef@motor-comm.com>
Date: Fri, 4 Sep 2026 17:37:21 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next v2] net:dsa:yt922x: Add support for Motorcomm
 YT922x
To: Andrew Lunn <andrew@lunn.ch>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com, horms@kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com
References: <20260820080542.2017118-1-kyle.switch@motor-comm.com>
 <10c23416-dce1-4ec6-91bd-3e9eda9b18a3@lunn.ch>
 <3e87da63-420b-4582-956c-2ecd853b0619@motor-comm.com>
 <d3c8d8b7-7998-42ef-a518-9acb9a4c6038@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <d3c8d8b7-7998-42ef-a518-9acb9a4c6038@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/28/26 21:19, Andrew Lunn wrote:
>>>> +static int yt922x_port_sds_init(struct yt921x_priv *priv, int port,
>>>> +				phy_interface_t interface)
>>>> +{
>>>> +	int addr;
>>>> +	u16 data;
>>>> +	int res;
>>>> +
>>>> +	addr = yt922x_sds_phyaddr_get(port,
>>>> +				      YT922X_PHY_REG_TYPE_SDS_COMMON_EXT,
>>>> +				      YT922X_PHY_REG_SPACE_SGMII);
>>>> +	if (addr < 0)
>>>> +		return -EINVAL;
>>>> +	/* write protect */
>>>> +	res = yt921x_intif_ext_write(priv, addr, 0x4be, 0xd);
>>>> +	if (res)
>>>> +		return res;
>>>> +	/* CDR */
>>>> +	if (interface == PHY_INTERFACE_MODE_100BASEX) {
>>>> +		res = yt921x_intif_ext_write(priv, addr, 0x406, 0x0);
>>>> +		if (res)
>>>> +			return res;
>>>> +		res = yt921x_intif_ext_write(priv, addr, 0x416, 0x3458);
>>>> +		if (res)
>>>> +			return res;
>>>> +	} else {
>>>> +		res = yt921x_intif_ext_write(priv, addr, 0x406, 0x800);
>>>> +		if (res)
>>>> +			return res;
>>>> +		res = yt921x_intif_ext_write(priv, addr, 0x416, 0x4558);
>>>> +		if (res)
>>>> +			return res;
>>>> +	}
>>>> +	/* PLL */
>>>> +	if (interface == PHY_INTERFACE_MODE_USXGMII) {
>>>> +		res = yt921x_intif_ext_write(priv, addr, 0x43a, 0x1006);
>>>> +		if (res)
>>>> +			return res;
>>>> +		res = yt921x_intif_ext_write(priv, addr, 0x43f, 0x3029);
>>>> +		if (res)
>>> What is this function doing?
>> Ans: Complete some init configuration according to serdes interface mode.
> Sorry, missed this email until today.
>
> Which SERDES? The switches SERDES, or the PHY SERDES.
>
> We normally refer to the switch SERDES as a PCS, and have a PCS driver
> for it. Sometimes you also need a generic PHY. Please look around at
> other devices and understand the architecture.
>
> The PHYs SERDES interface is configured by the PHY driver. The MAC
> driver should never touch PHY registers. Same as the PHY driver should
> never touch MAC registers.

Ans: Okay, this is the switch SerDes. We will refer to the existing

implementation and modify the code logic accordingly

>
>         Andrew
