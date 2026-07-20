Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5843D3305
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 09:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784538823; cv=none; b=VpNCG5T52VyefuzBFB5C4iIL0efIBGydZfOWeZqsb2IByWnfr5a/fxAxaUH5Ei25i/qCeS7KjH/YYG8QXMjaGHi8lW7Y4ZY0U3R0mgzD7c1nxeRpdVV+FMQ8BJY5SKAZG7u83fmSEAftlgI50Nehx7HcrwCqrMKXdcus1hd3sa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784538823; c=relaxed/simple;
	bh=85noVtvBLi1tBODpLf1x2bVLhJvsuksgsZFmoemNzgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rjBKXnZmMMPDglgLhrWYazKhhZ4J8zdP0mXGCga8D4lEvr6rWVIoJc092+nuPmf6IhD0b1efxTAeov+NG1WSYi7AcF+gXn17SeSy5Z5uQPYpOxcUj5bA2tewK3ixc9pYucGliRZjCwUI9uCwdMkFmH0N1cOmqiZntsNY4m8XVS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=homqGH9s; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="homqGH9s"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47f64ca1c2dso437892f8f.2
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 02:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1784538820; x=1785143620; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9T/2cKnEZcfqKCJj5/x/Dfy01VrGSKU7EgzZYtP93MU=;
        b=homqGH9sMaGDvCLlIBl1C8UwFypei07f8GuLcNbDg1ej5bf6HMNg9GJPnpkp/qdnH1
         TCJrrOGogP+4hrvziH/wPfJrOdskYk3dFBiENRXabchZ02KT604K02tc62OpzH2w0kEo
         xRVy7POOZG5tMl2s6qNRplHWOBISH/1FuQ5jtdxdUY3QS5aSPF1R7CezS3ieEwbc40Z8
         fCPGEQvdVqc4hYVoqzyvAZhD96ZWsy1Qm36e22wf/Q8ppexJTT0rgo3IX2hfLXcwMLuW
         vj5Bf3/nrDIXygnqpV7CTjlWQnsuFAF0r6Z03wsIPwR4K9Wr9AkXPEwkSODAVLFSEpDF
         +6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784538820; x=1785143620;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9T/2cKnEZcfqKCJj5/x/Dfy01VrGSKU7EgzZYtP93MU=;
        b=dxkKQ/1zG8e0LoVn1xrgmIqhEcemZol+z1wEINFIrXZ97Z0RiiNqIHTKFnU7j/aI/i
         Csrs1AoW/VcXUL2xsy9r/1+JFweyXkn7pAcvTAI50uu5f0u4SDa1v4iYt2PMOffy9nBi
         JlUVjo11cpzJnodxx0GGGoK9pBj5pNYYnvo674g/Ws0f1j4R55Sb7Oyb7Ue+o/b4/DV4
         Z7hgZMPW6pxK6I1GuSSghQLz0L6sM2ZcrygRTA/36jBumsb9acpKG60ze8Hzr02viKNT
         IDMnMcPbR4JB4MIjnwPQZPEd+hOuDqSYdSE123JJt9UTKGrcO3EEMv2wYffvpha1osZ0
         ewhA==
X-Forwarded-Encrypted: i=1; AHgh+RoenY9wfu0s7jE7+LymQM+IdaIhRyrz1IJNRvl2JVCeT16ay/xbqDNFrHm+NVis0HA/F8EhavY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdxyYhexLyBJwyvLVUS+R/J32hiDEzKmmgVfHZYZjq17YTHGFF
	0tO72GpZEXqJQ79vIFEp4AYWH996tt7iKiNuudW/lvxU1HXYhILDdpxRzC/d3LR9Uzc=
X-Gm-Gg: AfdE7cmQGVnSrh1d5/K9XvVRVPBmBVDyuCccnJ749TvalRWzn/g3pjeWQRcSvBsFMkU
	z3cf/eCVUCreZSIujmIodixuBJaRzzEN5GRpT+S7hf9qTJFgIgRyCuOkaWrB59Hg3Sf5A9WQhpV
	0/G9wVKOUABOQu7FjrCfuaBOTxRyfCvPBR9NfT9rcgjjIgJMa+6ndon5C2dJhp36vOmf+jlje1d
	Uw1Dq6qJyH/PBcJXVUoBHSnrkUQXjqqELr0tgs1QINzsyyE7Ks1jpeDZCWclO0jjwsumotSlGDe
	IFYdNPZPc3A5ol/y0OWao+sHITlsNDQj5UOkA0xJbbINYcy+hedArkJ66wb7BMcn0SErFHsxqhH
	oibo96sfDm08684kxiXaQPvQlYbMsPGmqDP4vV0OAR558AJOpw2fijS63MNhRRth02Dz2/M4xv6
	AVZrfk/U8QzTHAgWrhVzxJxoBzJadNfzrI
X-Received: by 2002:a05:6000:188f:b0:475:f0c2:5afe with SMTP id ffacd0b85a97d-47f6233b1c9mr16250659f8f.52.1784538819747;
        Mon, 20 Jul 2026 02:13:39 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ee926dsm26438160f8f.35.2026.07.20.02.13.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 02:13:39 -0700 (PDT)
Message-ID: <2b923c1c-8c00-4375-9ec2-0fa9b073fa91@blackwall.org>
Date: Mon, 20 Jul 2026 12:13:38 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/5] ipv6: ndisc: Add ndisc_check_ns_na()
 validation helper
Content-Language: en-US, bg
To: Danielle Ratson <danieller@nvidia.com>, netdev@vger.kernel.org
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ja@ssi.bg, petrm@nvidia.com, fw@strlen.de, kuniyu@google.com,
 bridge@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1784463131.git.danieller@nvidia.com>
 <c7f894446494462bd72f717021aa4b6373f31131.1784463131.git.danieller@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <c7f894446494462bd72f717021aa4b6373f31131.1784463131.git.danieller@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/07/2026 16:34, Danielle Ratson wrote:
> Add ndisc_check_ns_na(), a standalone NS/NA packet validator modeled
> after ipv6_mc_check_mld(). It performs the RFC 4861 section 7.1.1
> (Neighbor Solicitation) and 7.1.2 (Neighbor Advertisement) mandatory
> checks that are relevant for software operating at the bridge level,
> where packets bypass the normal IPv6 stack path:
> 
>   - Hop Limit must be 255 (packet was not forwarded by a router)
>   - ICMPv6 checksum is valid
>   - ICMP Code is 0
>   - ICMP length is at least 24 octets (sizeof(struct nd_msg))
>   - Target Address must not be a multicast address
>   - All included options have a length that is greater than zero
>   - NS/DAD: destination must be a solicited-node multicast address
>   - NS/DAD: no Source Link-Layer Address option when source is unspecified
>   - NA: Solicited flag must be 0 when IP Destination is multicast
> 
> On success the function sets the skb transport header and returns 0,
> matching the convention of ipv6_mc_check_mld().
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> ---
>   include/net/ndisc.h    |   2 +
>   net/ipv6/Makefile      |   2 +-
>   net/ipv6/ndisc_snoop.c | 190 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 193 insertions(+), 1 deletion(-)
>   create mode 100644 net/ipv6/ndisc_snoop.c
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


