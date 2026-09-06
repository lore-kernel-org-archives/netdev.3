Received: from out28-98.mail.aliyun.com (out28-98.mail.aliyun.com [115.124.28.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F4E282F24;
	Sun,  6 Sep 2026 02:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788660541; cv=none; b=BfgiOoPN7sU2L/71iemTZfGUZzH1uaGjH+60G3/8zYcDN8bX0hTk/2bD3KdxWkXO0RNdxuw8k5NOOXtQV7tnuR7tp3txnIBDJg6HHUwcizCat5+Z90l7jARLq4zZ58rcz0MnNhR0qJ0M/OAnHpPCzuVmAaTfJz00LMumZrn9Ha0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788660541; c=relaxed/simple;
	bh=REJL2qftvjdYkJVjLxVJ/XhBxsgNq9ygtfYqiPtUoCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gdCGJD6aECuilyD4REeYYjijgFEGwlKPySCklscz3x3QZz8FuL0BfXYs6v/KEQ0YHq2CXuI0lrKOC3Ce8TiPQlaACP/t8KkN/4+442c8Wleqf/i5cRfkZ6Oj490oVzR4yX0+8RRq2F/Zdxd7cyhr/xIU8HZu6n53/ELYEm468A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.09682168|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.106801-0.000368766-0.892831;FP=16808028613710462489|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037031241;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.j6exzN2_1788660531;
Received: from 10.10.26.192(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.j6exzN2_1788660531 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 06 Sep 2026 10:08:53 +0800
Message-ID: <27a16f29-14a9-40d0-941b-f07d5b63ec4a@motor-comm.com>
Date: Sun, 6 Sep 2026 10:08:50 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/6] net: dsa: motorcomm: refactor
 registration path for upcoming switch families
To: David Yang <mmyangfl@gmail.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
References: <20260904095416.1692962-1-kyle.switch@motor-comm.com>
 <CAAXyoMN-RX1aY_isyajES5LgiDMp7_YTbM=jiS6d-8o2kKQXqg@mail.gmail.com>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <CAAXyoMN-RX1aY_isyajES5LgiDMp7_YTbM=jiS6d-8o2kKQXqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/5/26 01:03, David Yang wrote:
> On Fri, Sep 4, 2026 at 5:54 PM Kyle Switch <kyle.switch@motor-comm.com> wrote:
>> +               .name = "YT921X",
> nit: We usually stylize it with "YT921x".
Ans: okay,will be fixed in next version.
>
>> +       if (major == YT9215_MAJOR || major == YT9218_MAJOR)
>> +               mode = YT921X;
>> +
>> +       for (i = 0; i < ARRAY_SIZE(yt92xx_series_info_table); ++i)
>> +               if (yt92xx_series_info_table[i].mode == mode)
>> +                       return &yt92xx_series_info_table[i];
> Redundant if you use both indexed assignment and lookup routine, since
> you know the index already.
>
>>   static const struct of_device_id yt921x_of_match[] = {
>> -       { .compatible = "motorcomm,yt9215" },
>> -       {}
>> +       {
>> +               .compatible = "motorcomm,yt9215",
>> +               .data = &yt92xx_series_info_table[YT921X],
> Redundant if you use both runtime identification and the match data.
> Also I'm concerned with early IO operations, although I didn't see any
> incorrectness here.

Ans: we have considered this issue before. in the next version, we

will consider whether to do it via chip_detect() or using indexed

assignment. From your suggestion, what are the side effects of each

approach and which of the two approaches do you recommend?

>
>> +enum yt92xx_mode {
>> +       YT921X,
>> +       YT922X,
>> +       YT_MAX,
>> +};
> nit: Use prefix/suffix like YT92XX_MODE_YT921X or YT921X_SERIES to
> avoid too broad names and future name collision.
Ans: okay, will be fixed in next version.
>>   struct yt921x_priv {
>>          struct dsa_switch ds;
>>
>> +       const struct yt92xx_series_info *series_info;
>>          const struct yt921x_info *info;
> nit: Better to use const struct yt92xx_series *series for simplicity.
Ans: okay.
