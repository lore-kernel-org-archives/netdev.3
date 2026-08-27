Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD562D0C8F
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787841356; cv=none; b=rNOCfI32Caux22FX7NSFUhFVBhKjqrEl8YhYMkNES/+qACrdWZ7Noot4SxoPQU9FLa7SRX4/1APcPYTmZwOh5xk/v6dw26BocvkXhQU1mjiPYu40yh74iHJCmeiKhOhtahWSnHdM+D3dYSL8pnQGqXSeMlEZHGYScSfkZTgw7Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787841356; c=relaxed/simple;
	bh=OvCuE3tKhuByh3bh7M7tAUdCId7sWjvotChThY107eQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s3NdtkuGget3wYT92iP0T1S56ryfbTI7egj7GX06jzgN6cUD6urrvyRYoHYY57bCMcJTEKSYtVuBWXrivvp86+297bJiMB0DR2K52IcVYlVA6KAyDvWOEebe0t5D7/nTC84cdKQMDHTOhRkXjfztYrwRac0mCy/IxKFreNmjaps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=O8ZuG4JY; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="O8ZuG4JY"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a374bea882so3344273a12.1
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 07:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1787841353; x=1788446153; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BKzWbSJH9JlleRjv6GcxliujufDL4y1EreMLQdzQ5Js=;
        b=O8ZuG4JYk/T88A/KhRbMbOoCTWH30TPfEzzBHbskre3HDhnFEEAExjlSCNRs4iw+p3
         pMCzMI6ZqVuaVFQdb2DwIe4PFg25/1Hv62p8iwVS8nA5yXwCR59wEuG4MtZwsD0y6q3+
         fbSi2sj9OHOSdQWKteCkHmAZHUCNq/KPZqMrN/5MJRjRQLsYYOuPz9GB6BHQBq60q+HY
         otc5Xdrq3VIcL/LPkpYFk29nU6/E4ppOvlHAE3cLm2XF41Rc6hTt3NunTaMbMEM/vHUq
         MAonY2TFLKWX3iAqpNTbW/eEqHN3Scxbs+zoTHsYTFTLo/hAQXNQzmcfmPF9qlfOo6M1
         UFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787841353; x=1788446153;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BKzWbSJH9JlleRjv6GcxliujufDL4y1EreMLQdzQ5Js=;
        b=cE6F4G6DW+LQHtN7xq4I49cs13zMnZ3rX3OKXM4kD+PLLBAIyxHHPUf8Rqq/2UezwC
         PA0GcNwAtVOzl9FK6ajmAAWJeXPat8nue3LarcflnRXstv5CMUEKfl/PKQQpFxTmUmOU
         4QlmwvJPuXPtt00e/LSzsnWWnhj/34c24yu58L1YZRMQsNuC864pLJJWyxE9eGntWHNv
         Gm07EzPf2UDTn9BJNa115nemMjjwyHgBfHc/oqxRNOR74zja+lijnvbHzEd7vznLVfRC
         x8NpZLaUy66lxLCROxEaV0iYWEisTbulNj0lc3NhaGJnb2RYGpNBLF9S34k20DSWHz6T
         eqpA==
X-Forwarded-Encrypted: i=1; AHgh+Rr3oPeHusdlKYJqfoQKW1+MNMvkA8z3qCiBS+Q/AslmpRj52v9HvmUkoo26SL7IuKpQsQMBDn8=@vger.kernel.org
X-Gm-Message-State: AFuF++mQ16qdSxZ/HCoQLFey9qZNDUtmFSsJPyqI3Z/O7ExR5c3DFKqP
	J7kT63+ShkF/qwQPKNOPTGWr+AqcIHJsLS8HkUI5Nyi+1GQUYGTMFBI9hwp7HmXQqsfXFTlvzuJ
	cbl+pwrc=
X-Gm-Gg: AR+sD13kTYHWx3SS/kUkNO5QjdSA9Enip0914HMMXYMuNL46p/F0OFSI91oLLzkw9UN
	H7uEwbTIRbj25FdT39/+EwkrN5WDsM18xgtqPmYd1oAlG3HSSA6g+Amfx4IQ61BDEM/vwWArR6S
	6XOoWxmAPy1Rwno1kqbRzWBEvL987/GyiG14ycaMgvsTnTsybLXMdwpprodhD1nSaZFI18qsAas
	pfghaCjnBAek4RFMRLsByP8biUoRW+AaE8KnSKj8pD/GcGB3fzCuDrahIs3+49QYppeAkx8rajG
	ZDaHKI05B49YpDvPrF2r6dZK++MOo3c2hHnFKs/RdF+d00gvRyJM/87OZWALFarR16eae8KRKTX
	vllUQ4uqHhIKRiQbRsldwDSRB0MriOjCVyvXRxUBpADkxm9Ib+RzSs5qHPhdABvV5J4ZOHQd87p
	KuDJ9HS4vVCmPv5RdOQfgAbQZyF6K1GeSxog5d0BsvKkt6E8haPdAloOTKzesWWRyGJg3tV9D5x
	IVFE32uy07aQi1rSgE=
X-Received: by 2002:a17:907:c08c:b0:c21:752f:c44e with SMTP id a640c23a62f3a-c250bc0f7e6mr1797816966b.16.1787841352449;
        Thu, 27 Aug 2026 07:35:52 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a5d62dfsm738498266b.4.2026.08.27.07.35.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 07:35:51 -0700 (PDT)
Message-ID: <ddf53430-f3ce-4ca8-aacd-3fd8ffc81091@blackwall.org>
Date: Thu, 27 Aug 2026 17:35:50 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] net/bridge: out-of-bounds in br_forward()
Content-Language: en-US, bg
To: Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 Pablo Neira Ayuso <pablo@netfilter.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Phil Sutter <phil@nwl.cc>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
References: <fai12uKS5302YnCQV4E3zlDqcsAS5aGcMutS@bugs.sh>
 <apBJyKJ7zs4kUmpd@strlen.de>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <apBJyKJ7zs4kUmpd@strlen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/08/2026 17:29, Florian Westphal wrote:
> co <co+63bad23bb3b4cd85@bugs.sh> wrote:
>> We found a bug reachable in:
>>
>>      path    net/bridge/netfilter
>>      crash   out-of-bounds in br_forward()
>>      commit  7b5344954050 ("Merge tag 'nf-26-08-10' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf")
> 
> I'm looking into these reports, I think this is the same
> underlying bug as the other report; a variant of
> 
> ccb9fd4b8753 ("netfilter: revalidate bridge ports")
> 
> That bug uses nfnetlink_queue for RCU escape, the other two reports
> use defrag engine.
> 
> And sure, its br_netfilter again -- I think we will have to consider
> removing it even though it will break existing setups.
> 

+10

> As a compromise, I suggest to reject br_netfilter in user namespaces,
> i.e. call_iptables cannot be enabled anymore unless you have
> CAP_NET_ADMIN in init net.

+1000 :)

I absolutely agree on both counts.
