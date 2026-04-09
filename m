Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D354A35;
	Thu,  9 Apr 2026 04:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775707445; cv=none; b=c4TBx8zT6z7BpFzRQtyo1REJNXlep00EqJevfkW8/RqwhHeWvkD5Ed5Z/BMQFSmwdOQdzGGIhsbfWoBkMnnouI7P/CWGGI1lfUO295f7A63t3AJmSo1kNpomikzegXtUByfeJsjgeC6MWDQMOt3jFO4yjzKKJpN5vXuC2demu+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775707445; c=relaxed/simple;
	bh=xkNRkKhYozl5VFDwEt/FsJv4EP98oP5zZC4JZ4maLnc=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oYjWkuOK0rf297qyo49r03G5YqS6+ktXkt8eep6AUQLv0/UKVY9LLQ10KZEUVhhFhoB/nQgGIcg/M/A1iaeer5g1qcepR2+mTCfTcGQAJnrrhzk6IS3M+FSprvNkI9dAmyo+t/7xcx2Lc0yMlIYzNUI3T40V1feMJXgNmC494oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=el9z2OBb; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="el9z2OBb"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=XGowp3X4zGzDAYt5cRM9/V9fvsjxmXKIfFOYdzzA4TI=;
	b=el9z2OBbyIbvH1r31HLTFkpsNPWttG7koMnjsy24DlQPZLKAAlD2hs826Mt0+pSd1pA2QM1nO
	IlrE2lVlwJr25nSHMtIINZl6lKqcgztJkrqU3lrkTEm+Y7O2ga2foB3eR7JfRIysgO+ay+AUL2D
	8UyLUy2xCai5lUEwvcYEi08=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4frmNm48DgzmV8Q;
	Thu,  9 Apr 2026 11:57:44 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 9130440539;
	Thu,  9 Apr 2026 12:04:00 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 9 Apr 2026 12:03:59 +0800
Message-ID: <18967454-0af4-44e5-98ba-11af95ef505f@huawei.com>
Date: Thu, 9 Apr 2026 12:03:58 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shenjian15@huawei.com>,
	"liuyonglong@huawei.com" <liuyonglong@huawei.com>, "chenhao (EZ)"
	<chenhao418@h-partners.com>, yangshuaisong <yangshuaisong@h-partners.com>
Subject: Re: [PATCH net-next 0/2] net: ethtool add VxLAN to the NFC API
To: Jakub Kicinski <kuba@kernel.org>
References: <20220817143538.43717-1-huangguangbin2@huawei.com>
 <20220817111656.7f4afaf3@kernel.org>
 <5062c7ae-3415-adf6-6488-f9a05177d2c2@huawei.com>
 <20220822095327.00b4ebd5@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20220822095327.00b4ebd5@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2022/8/23 0:53, Jakub Kicinski wrote:
> On Mon, 22 Aug 2022 22:46:14 +0800 huangguangbin (A) wrote:
>
> I understand your motivation and these are very valid points.
> However, we have to draw the line somewhere. We have at least
> three ways of configuring flow offloads (ethtool, nft, tc).
> Supporting all of them is a lot of work for the drivers, leading
> to a situation where there's no "standard Linux API" because each
> vendor picks a slightly different approach :(
> TC seems the most popular because of the OVS offload, so my preference
> is to pick it over the other APIs.


Hi, Jakub,

I have recently taken over this job and used tc flow to configure flow steering to a specific queue.
Currently, the community already supports FLOW_ACTION_RX_QUEUE_MAPPING, so the previously discussed issue no longer exists.

However, we have encountered new problems:
1. First, the driver does not support FLOW_ACTION_REDIRECT, and the NIC is not a switching device.
     Therefore, I personally think that the driver does not need to implement switchdev.
2. However, the VF itself supports flow rules, and its capabilities are the same as those of the PF.
     The VF supports drop and select_queue, and the VF rules are configured through the PF.
3. However, it seems that tc flow does not have a proper parameter to specify the vf_id to tell the PF
     which VF to configure the rules for.

Therefore, we have encountered a problem in supporting tc flow for the VF.
A feasible idea is to use chain_index to indicate the vf_id.
However, this changes the original meaning of chain_index, which may cause confusion.
Or perhaps I missed some feature about vf in TC Flow?

I'd appreciate your insights on how to proceed.
Are there existing mechanisms or planned extensions to address VF-specific rule configuration?

Thanks,
Jijie Shao


