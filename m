Received: from out28-50.mail.aliyun.com (out28-50.mail.aliyun.com [115.124.28.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F278532E12E;
	Wed, 14 Oct 2026 01:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791941417; cv=none; b=G0KAIYZ4DskDnUqLbI7ogyAL0BHbLF7flODfIOryhcnhIWFj3hTYKcWwg3GDEAIWmivaFlAfKRcrSg4xFi1mancB13hTcxDXPEEV1TO6rel2GR/NecHnAwwETXtxeYzm9oAJHXegQoadcFbfaTAYC+0Jp+uRh3lWRwFY0IDRPkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791941417; c=relaxed/simple;
	bh=5XKjbVUj5f8dMa8hnGe4ZN5QFJG29y/OV31q8kODYb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cIaqUNyOX6jBXGxqNz3kdkTLkHuYJCj4sVChcG66cpwwaBhevQOm4LTNDOToqDlaZ0eB7H22lfLqFazDvYWOgK++nVNSWj3LbmUtYgt91fbodYLxbKn6EepYauKO4JC2cR7r8gVSPB8w/VdQiFgfHczj1EQAQ91i3BUz9FyLnZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.183254|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0412798-0.000810369-0.95791;FP=16709473490824910421|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037031241;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.jcDxmDH_1791941409;
Received: from 10.10.26.192(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jcDxmDH_1791941409 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 14 Oct 2026 09:30:10 +0800
Message-ID: <a0bf071c-7728-4ac7-b8e6-676e87d47ede@motor-comm.com>
Date: Wed, 14 Oct 2026 09:30:08 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v23 3/3] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 Frank.Sae@motor-comm.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com
References: <20260930194513.663575-1-kyle.switch@motor-comm.com>
 <20260930194513.663575-4-kyle.switch@motor-comm.com>
 <174750c5-0ded-4c26-a103-4d905f8c6dc6@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <174750c5-0ded-4c26-a103-4d905f8c6dc6@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/13/26 10:13, Andrew Lunn wrote:
>> +static int yt8824_config_utp_init_paged(struct phy_device *phydev)
>> +{
>> +	/* enable nibble */
>> +	ctrl = FIELD_PREP(YT8824_U0_U1_ENABEL_ODD_PREAMBLE, 3);
>> +	mask = YT8824_U0_U1_ENABEL_ODD_PREAMBLE;
> ENABLE.
>
>> +	/* 2.5G template tone */
>> +	ctrl = FIELD_PREP(YT8824_POWER_SAVIE, 0x83);
>> +	mask = YT8824_POWER_SAVIE;
> Is this meant to be SAVE?

yes. sorry for the spelling mistakes. In the next version, I'll check 
the spelling

of all macros added earlier.

>
> 	Andrew
