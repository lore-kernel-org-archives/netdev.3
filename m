Received: from out28-1.mail.aliyun.com (out28-1.mail.aliyun.com [115.124.28.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4100D377AA8;
	Thu, 10 Sep 2026 02:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789006433; cv=none; b=D1N511S82Vn5gwyYLQx2YXfFKhhJgevLoWuZ+ThXu2Qp1e2Vrwoe8rdf2nn0nSB6QVqu8V4iRM4nd8P8qsyftlgdBxSMX9Fxgzxcr6+x7awAsbECqXpImTaE9y/wj4c110ahCo2yPUnlDrwVaVPDDyKES8QJzwHAbIgYruL7mxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789006433; c=relaxed/simple;
	bh=ia6acwSXciTPWY474ZC9bNFUQPGmQMRF/Mkw7JWKP70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UySuzsFCOBmOWJrkAlyEVcFmmmXIG8gmKQ4G0ARroqjxc5C/jZ/23H+gOuYt6lgI/UIZG4P5IQ7AmXTsbxDuqKrkKZvVCrxOJtSfIS6a0GxG1nppKhPmtIkudw1sSbXLzCA8DmWYYLJc4reEmN2HYYlTZ24qUfiDYCbJ7A+xIfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2285654|-1;BR=01201311R561ec;CH=green;DM=|CONTINUE|false|;DS=SPAM|spam_ad|0.880871-0.000325482-0.118804;FP=16380463733967879957|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037022039;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.jA.ZRaE_1789006415;
Received: from 10.10.26.192(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jA.ZRaE_1789006415 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 10 Sep 2026 10:13:38 +0800
Message-ID: <01d589b2-73b9-4699-9a45-f869392778cd@motor-comm.com>
Date: Thu, 10 Sep 2026 10:13:35 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/6] net: dsa: motorcomm: initialize
 dsa_switch based on chipid
To: David Yang <mmyangfl@gmail.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
References: <20260908083614.2210505-1-kyle.switch@motor-comm.com>
 <20260908083614.2210505-2-kyle.switch@motor-comm.com>
 <CAAXyoMNkvyVN435bUwWuN+q8UmKbwnWbn+=uWt-nC2omBk94Lg@mail.gmail.com>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <CAAXyoMNkvyVN435bUwWuN+q8UmKbwnWbn+=uWt-nC2omBk94Lg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/10/26 00:18, David Yang wrote:
> On Tue, Sep 8, 2026 at 4:36 PM Kyle Switch <kyle.switch@motor-comm.com> wrote:
>> +       if (major == YT9215_MAJOR || major == YT9218_MAJOR)
>> +               mode = YT92XX_MODE_YT921X;
>> +
>> +       for (i = 0; i < ARRAY_SIZE(yt92xx_series_table); ++i)
>> +               if (yt92xx_series_table[i].mode == mode)
>> +                       return &yt92xx_series_table[i];
> Still redundant lookups here.
Ans: will be fixed in next patch.
>> -       ds->priv = priv;
> ds->priv is gone in the new register.
Ans: will be fixed in next version.
>>   static const struct of_device_id yt921x_of_match[] = {
>> -       { .compatible = "motorcomm,yt9215" },
>> -       {}
>> +       {
>> +               .compatible = "motorcomm,yt9215",
>> +       },
>> +       { /* sentinel */ }
> Leftovers.
Ans: will be fixed in next version
