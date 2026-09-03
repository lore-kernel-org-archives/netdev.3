Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4EF3783AF
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 11:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436417; cv=none; b=AshF6lcrgc4dGj5IHipD5WTJMTlud1QmykwTJuYXNjJq4n0Ufo5uLFul2ifmp1zvKDnrk1Bosm3mFjmqWyFzt5rjJYpLms0gLpTB7NTVOjJVDkHJ6YqNv0jz7aQzxm25fL8SKaky7jZIEJGjiHZBMuAYQonGKaeiQxAmQ38UltY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436417; c=relaxed/simple;
	bh=n8bYwUuczfiLpKJBTVZcPnuCkq/6sKoANFxiZETDYO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fDhZBQAA/XDQ/akyAAkNuwr8hj5xC6Qj0bEL0CwyKG7tRz1BJck8BE72TdKVAj80dyL5xdf5n+Eeffxd+qIpV9G1sy7F9SWCySFzS3vWSX/K9Ygv5+3uzx7/Lu56QUFf0X35qSbGB4iElSWahiehg6HP0TTJzR96eI7ML19H+RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=XtoSS7CG; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="XtoSS7CG"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-485850cbac3so134284f8f.3
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 04:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788436412; x=1789041212; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DWtVn0VNYx4CTej3FUQm8/Jbit0379zH7sDkhF+JYSk=;
        b=XtoSS7CGWtbxaSwFkXKYcNubg0WrICRBln6dslQojxOaNssImT3MmexXYpgiCfBn6a
         AozBZu+Edxvma3n5znCI5HxZeCXYR+A+qoL4MrfaUQAD0D/a9UjEkioTUXePzSsRKitS
         GFrA0xcMnq0mebXzIYGaYX4BmUmt7bBe2N5tgFD06Or/vtXCuk8r8CevQLFg1n1jrYe2
         3CSMHEPkbzBuz+jbBIikcJEURbe2+df4t2h0NtBymfSIGxFlkgIs6jXrc08mOopV8rG6
         v/4aGUF8xhKCLjXLbNdmpYr5H8u+O+g/YTRy5v12JkjoxBttt/P3mDGan9fUc7mqk6ks
         4gkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788436412; x=1789041212;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DWtVn0VNYx4CTej3FUQm8/Jbit0379zH7sDkhF+JYSk=;
        b=ldfdzugYwUJiICRYKPDfzphU6unfu51nYtdGVOSPZKyvvDjTQkT/lqfO/lliMS1mhx
         a+IcstweNhyge3wvm+Q+ARYd0flw9egJka3kPfTfcGxx2W+QS0x8NbqRPv/fXuqN41DM
         SWEF5Nx3rfCFp5jxMSuJppMd13aMwppPdL2+gSepKkW08fsT6+dSUSGf0+OC62Yya9X0
         fnZvhJ66ziTvZUC8bWIf2ZjVQnOGVnEsRR+2U6TTGIIewQCmDC2Wfy7aZfOcwHdl0Boc
         aLGPnCh8QLxYodas5yWZt2bl+vfjwZ/TYHNj7f5v5IZSuoiscAqNCFeGtyFu56ZrBQ7u
         wEMw==
X-Gm-Message-State: AFuF++k6OKwVYvJ2gWP3t84PTJlp4xIRTrp3hQd3VThYj2uW7vFkYokw
	0HV9t3sn5GixiWwyjqu7fJG8Wmz4ExQ3HpE/m68DDpEpHO/7j7G8c90JreXg76vs8Wk=
X-Gm-Gg: AYBFou3qN7utTBwPBS2ZG0yDfs50dBvxJtkYsvW7abpRxQ7+aHjD2UrZfHYiqvFHDSP
	h57EoOUshWKiYXPaRgUBEpG2awPYh21LXiqwoqcG8S1njOPNeUckpRDmiEChWU/rbeHs2YUA+4l
	nibEO5awjaeggRziP6zWQYqCsxQGZT5goWXz780gTudASe5jAQN2DAZZJizeiba0PP9MjlETX0Z
	g/tAYQuHY27QtztUjTfQUF2U17l7XcSnrIoSiB922oodo9PURUgQVOgc1Pf6odTfc2y2v8fLvk1
	qzSC4/Ifme4YM2CVsopS7tc+kePADUDBrIJ5gqN1rAtPKdrLbe0VzUZTJl4NgiM/mTb8eCmxUJj
	35PJJa02MmVlNCspNPbS/Z1EBFpG2MILK7EflPF4dzGDOkLJzLPHsUrbn59KNHZPAvl/l3CsgwV
	y5s3Umb2oXeJlrhcbWADEb+DZ8hv5Fui+VXJUaxSY/ilVppMazNvcF6qQe9JAuMDFgsvif0GQez
	XLa/C0UZoTZ70bMZJU=
X-Received: by 2002:a05:6000:603:b0:484:3326:983b with SMTP id ffacd0b85a97d-48488f225d7mr19056142f8f.26.1788436411919;
        Thu, 03 Sep 2026 04:53:31 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e80020sm13725881f8f.10.2026.09.03.04.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 04:53:31 -0700 (PDT)
Message-ID: <fe5f07d4-775c-4fe1-a4e8-384dbc11d7e7@blackwall.org>
Date: Thu, 3 Sep 2026 14:53:29 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] bonding: fix slave_cnt leak on XDP error paths
Content-Language: en-US, bg
To: Matthieu Baerts <matttbe@kernel.org>, Hangbin Liu <hangbin.liu@linux.dev>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hangbin Liu <liuhangbin@kylinos.cn>, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Jussi Maki <joamaki@gmail.com>
References: <20260903-bond_slave_cnt-v2-1-02e27304ca36@kylinos.cn>
 <62271715-fbd6-4047-9b69-b2bda40db056@kernel.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <62271715-fbd6-4047-9b69-b2bda40db056@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/09/2026 13:38, Matthieu Baerts wrote:
> Hi Hangbin,
> 
> On 03/09/2026 10:10, Hangbin Liu wrote:
>> From: Hangbin Liu <liuhangbin@kylinos.cn>
>>
>> When bond_enslave() succeeds up to the XDP setup stage, slave_cnt is
>> already incremented. If XDP setup subsequently fails, the error paths
>> jump directly to err_sysfs_del, bypassing the slave_cnt decrement.
>>
>> This causes slave_cnt to drift upward on each failed enslaving attempt,
>> which would lead to unbalanced traffic distribution with round-robin
>> mode.
>>
>> Fix it by moving the slave_cnt increasement after XDP setup.
> Thank you for the fix, but it looks like it causes multiple KASAN
> issues, see:
> 
>   - https://netdev.bots.linux.dev/flakes.html?ld-remote=virt-bonding-dbg
> 
>   -
> https://netdev.bots.linux.dev/branch_deltas/net-next-2026-09-03--09-00.html
> 
> e.g.
> 
> 
> https://lore.kernel.org/netdev/20260903-bond_slave_cnt-v2-1-02e27304ca36@kylinos.cn/raw
> 
> Cheers,
> Matt

Waaait a second, it is moved after slave arr update, yes that would cause those.
I missed it in the review, in my suggestion I specifically said it must be before
the slave array update because it uses slave_cnt.

It must be moved up. :)

Thanks,
  Nik

