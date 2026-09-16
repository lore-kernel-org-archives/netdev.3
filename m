Received: from out28-169.mail.aliyun.com (out28-169.mail.aliyun.com [115.124.28.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767D836F411;
	Wed, 16 Sep 2026 00:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789519304; cv=none; b=STJrRjf4EsMhplV6uJ4ks/7Iqdy610Fq60y6U1TPRKEqUuPkSkH27UhSn0EBtX33R5ZxEjOoZD2npsxM8eEZQDDZXa5wmqapcuzSPz6s6AM8Ib6i6qI0iEGhoHmPmbOL1JefcfUYIWkhM2abKjqpHGtAt8XmfNhaH4RVT/14Bpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789519304; c=relaxed/simple;
	bh=XTmXF+DcWOLz2da0MbDlhvUuKjXqsnmRkUlgHzvUP/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TpHXs5RPZxBIScCdFcoTPwAS1ArEqucmlryzkWSEY7NLA84kvnlMK4QpTIoCC2vk2N2WvQLwrj8Y79tjZ1Ix61N3idP5BfnDtJfSrIn05C3srBb3pmxV3bU8Eb9feI+1vY207WmZ+fFUuT9eWtHgCrjQ26WoSP+NTJjuorPnmQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1066961|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0107248-0.000963259-0.988312;FP=7698849270438870102|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037032089;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.jEWW67-_1789519287;
Received: from 10.10.26.192(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jEWW67-_1789519287 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 16 Sep 2026 08:41:29 +0800
Message-ID: <3d6235e4-89cb-4881-8c7c-0de2a6206bca@motor-comm.com>
Date: Wed, 16 Sep 2026 08:41:26 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 3/3] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
To: Andrew Lunn <andrew@lunn.ch>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, jie.han@motor-comm.com
References: <20260915082152.3104633-1-kyle.switch@motor-comm.com>
 <20260915082152.3104633-4-kyle.switch@motor-comm.com>
 <c1b1409e-c01e-4074-8e38-73e630deb751@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <c1b1409e-c01e-4074-8e38-73e630deb751@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/15/26 20:33, Andrew Lunn wrote:
>> +	res = of_get_phy_mode(np, &priv->interface_mode);
>> +	if (res < 0) {
>> +		phydev_warn(phydev, "%s, phy-mode missing in DTS.\n", __func__);
>> +		priv->interface_mode = PHY_INTERFACE_MODE_INTERNAL;
> In the binding you say phy-mode is a required property. So if it is
> missing, it should be a fatal error.

Ans: I had considered this issue before submitting the patch.

         Between using a default value and returning an exception,

         the code currently chooses to provide a default. This will be

         changed to return an fatal error in a later version.

>
> 	 Andrew
