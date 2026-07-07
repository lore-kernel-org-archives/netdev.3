Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5DB3750BE
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 02:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783391856; cv=none; b=JRedRimE8V5vBCrZEK/HAknVK7bp5ps/Gve0y6JY3KNBCTZKCXznFa8ND3RUxXUr/u1v9VPf5s8qZWc+ZpOU65udjQ92XbB+2txE47TE21mLL10PLSAxklEneYY/mOo0riOKUraGmuBGwqIM3I2ENeUGqcw/v2adA6JwERwZ0kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783391856; c=relaxed/simple;
	bh=uFaDu1M29QjV1NMBRbwwJuAMpePKLdMa7L+bG/15AWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J9wHIehqekDoDW63gy9GRRb8yRqTR5zuI1ql/SZpGH3HUEwxPp5gWwzVBAM4heOjGntvsHazhekCzGaVk85RiP6bViEdXZbeG6TFVpf2086jfHRG3YLfjLXe/1rJGtJw4CZv2XpSiOnJC0sYB18sFn6TLw5JdzBU2H1NUN/lD6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=B3gT6S1/; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="B3gT6S1/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=3GHkig73pIhx4aXv7cxivnimg+Vg+quBYDk/2xWgxPk=;
	b=B3gT6S1/SyTZueyfLo1WYPgpLRIrK7Olup1BTG232V3/m1Feu9vh5tnbE5ky93
	6/fbzNJ5zl4Y10sGc6Y1/rvKEdm8YAwMxBkBuv5nQ/Mc9u/2Dqt6EHYNbN5Ogg8V
	C0Q2ZsWj1rnbyz5BHFIz0Uj1x5GiBYwJLYTWiV7FfDsE4=
Received: from [172.21.20.151] (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgA3ixszZkxqVBL2Fw--.29608S2;
	Tue, 07 Jul 2026 10:36:37 +0800 (CST)
Message-ID: <dbcfecb3-7b5e-4d53-b4ac-486fded1e192@163.com>
Date: Tue, 7 Jul 2026 10:36:40 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: skbuff: use net_zcopy_get() instead of
 refcount_inc()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kerneljasonxing@gmail.com, kuniyu@google.com
Cc: mhal@rbox.co, bjorn@kernel.org, jiayuan.chen@linux.dev,
 netdev@vger.kernel.org, minhnguyen.080505@gmail.com
References: <20260706100229.13812-1-luyun_611@163.com>
 <willemdebruijn.kernel.250ccf6e7c9be@gmail.com>
Content-Language: en-US
From: luyun <luyun_611@163.com>
In-Reply-To: <willemdebruijn.kernel.250ccf6e7c9be@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgA3ixszZkxqVBL2Fw--.29608S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF18JF4fGr4UGFy8uryUWrg_yoW8Gw1Dpr
	1YkFy0kFs8Gr43AFn2qr4rXr15tws8tFZxGFWS9a43Zr909r9aqFWDGF4Skay7Ar4xKryI
	qr17uayrGF9xXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR573PUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC7BVUI2pMZjVlGAAA3G


在 2026/7/6 21:55, Willem de Bruijn 写道:
> Yun Lu wrote:
>> From: Yun Lu <luyun@kylinos.cn>
>>
>> The net_zcopy_get() increments the uarg->refcnt, which is called both
>> in pskb_carve_inside_header() and pskb_carve_inside_nonlinear().
>> Also use net_zcopy_get() in pskb_expand_head for code consistency.
>>
>> No functional change intended.
>>
>> Signed-off-by: Yun Lu <luyun@kylinos.cn>
>> ---
>>   net/core/skbuff.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>> index 18dabb4e9cfa..bcf3b2c65fb9 100644
>> --- a/net/core/skbuff.c
>> +++ b/net/core/skbuff.c
>> @@ -2326,7 +2326,7 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
>>   		if (skb_orphan_frags(skb, gfp_mask))
>>   			goto nofrags;
>>   		if (skb_zcopy(skb))
>> -			refcount_inc(&skb_uarg(skb)->refcnt);
>> +			net_zcopy_get(skb_zcopy(skb));
> This adds some unnecessary instructions in skb_zcopy.
>
> It's not terrible and I see the consistency argument. But would make
> more sense to update the recently added pskb_carve_.. variants instead.

Thanks for your review.

The skb_zcopy() does indeed make repeated checks. So following your 
suggestion,

I have modified the code as follows:

-                       net_zcopy_get(skb_zcopy(skb));
+                       net_zcopy_get(skb_uarg(skb));

Does it seem more reasonable?

And I plan to modify all three functions in patch version 2.


