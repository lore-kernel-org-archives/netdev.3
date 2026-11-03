Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793718235;
	b=pkjOiT4l5ZBxzpjDYb0/HApQOZMq/myajk8UqoleXU4jiM6xwt9Qooyn+ClNmdTHD4ym
	 /LiSWKfP4KewJ/jVXAtlMN5lNdxABmOq32SjFBxwEqjQ/nGIC6vdlnlIJb5dihvF+EJ+o
	 uLH39hH+i8MvFyJ4PHBAaCiHnaDKKXKZMsp73sSnYARHwcDcQ6CYzAPpLDWtzx0OocD1V
	 ru+FLUG+0OMbiOOGlqXqpXjHJpfbhaKDZhNfOVkB4LkcjKq2as9/ApqsQENu1H3pnsdtM
	 m2hf6KIr766vwjduNdkzBrfmhN45Ffc7l/bCx7BcDZAWrffSdp7YH6NCJ0q3S0VemDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718235;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=F3H+IwvYwWXk3rVx6Z21IVgW55vKXWiCDKEkydPhyIo=;
	b=Odz9qF8fXWrkblYd7I8jc7cjjtmVCFOZyGebz02IJC5C7UuNtJTBeCx/rrM3iNlMxNu0
	 x75W2Y8qd0EHt6ygn0OQarRVgYGM5jaeH7KX8v42BhFASHNvK5zCjetP7i2xfpHAx/tGa
	 2xRJJtQCMLFpqvtmlLeFB1oW/5TEDV7EmRzcCPx0E0/KYVDf3sooId/luYX0iZAegqPZm
	 M2J1Be9OcqTqmW3MzLhi+GFgYBVgZetMWw/HQ8ki2cTzTviFiMDabJBILqo9Jq4j/z+4f
	 4GmoPM04kro3nFbzQ6yHQ7XEv9yggtpyuNBOwxjTgf+aEwIW8+hXFao9opdgQpbPzRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Kq7qjwrF;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=HBirscCQ;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C3C606BA34
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 15:03:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4C3C606BA34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Kq7qjwrF;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=HBirscCQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793718233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F3H+IwvYwWXk3rVx6Z21IVgW55vKXWiCDKEkydPhyIo=;
	b=Kq7qjwrFuFsPSzQCdbrqcE4dd5THm3JJzI/ZKJG0aquYK/bS+cLxC1YX7CQL+i3eLTNhc8
	FoJHuRUr2qYZH6UY5YmE9FJNgJnzoR6ir7DU+NxcgN2ZlpuLKvmBw25a1cZl+Q7ljkwU/U
	DfF7+wq4L06h2tjFqApOJecKYkHuAlI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-LLs_b4HdN8CwkN1UGqtsLQ-1; Tue, 03 Nov 2026 10:03:52 -0500
X-MC-Unique: LLs_b4HdN8CwkN1UGqtsLQ-1
X-Mimecast-MFC-AGG-ID: LLs_b4HdN8CwkN1UGqtsLQ_1793718231
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48c6a1d4034so3805104f8f.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 07:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793718231; x=1794323031; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F3H+IwvYwWXk3rVx6Z21IVgW55vKXWiCDKEkydPhyIo=;
        b=HBirscCQLKgrtYz8akV5pzE7Bhkim3hENueS/FwJs+HhQTwE3BPCGo2MDeWEUauJYr
         Gj9fkTay0g8JHJJVZe7dpKMnmVIch1ze1cnFltOyG1VVcFyVtjC3i+mHDLynPCoVa7NS
         IjK3avdd2sRGp6hkmnmku+08yAROBuMZXmnl7cu8k0bpe1Rvbv9OPCcUSrsp5MK959nQ
         /DXEtqHysCmlE7uyUa+0SehFd/aUQdKr6e4TsrySI92zwBNpRs0ghwIaH9KKKAvtXrvR
         b2oE7ZJHZNmmPJ8Ww8rd5EsGhuy18zEyMyIOH4fihNae3cN0xfirqXMS7sdGCWmKw45Y
         lq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793718231; x=1794323031;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F3H+IwvYwWXk3rVx6Z21IVgW55vKXWiCDKEkydPhyIo=;
        b=h6gsMF2hZzGsHxy7PFqMHSA/sqgF+pMB1GakQ/S59cbrfd0aBxwRi7yat7DAIiH7Tf
         aFu6DerzdleSu/ofwyYSqKRTqkiQ1kP1r0K3GZtSuQScke1+StVTIOs+Q3sbTWb4gOBg
         b2JLfv5DUBMlOzX1BRCkUowwsbuhW/88W91usTOnu/mAzgUrpyxSCeCBI1OrSv74WAb4
         nGXi0AlnHkP1zlbdfSy1fQumijhsv8oCL1hgTGNzx4HhF74IsfPNkhZ6PhTYZ04NvYzh
         GTzLBt6840M1DU648/B/Fd1N2xyGsyJH2NU0sVVd+Hic5ncBh8nk3fRIUx+Dm1Q3CBfc
         oy3w==
X-Forwarded-Encrypted: i=1; AKwUvBwbGstrH8YEHH3Ut4GNBUDcdTDZ4JRHfOiTmxOPXtlhWjOTvpfwqszYbK40qmrRwh/Fqt2Yp6w=@vger.kernel.org
X-Gm-Message-State: APuU4Z+4zKYDmPCDHo44kVKpDsbsS28tgf63/BnM3+Ui5WdZAzcFUU0z
	C/GUhqck0PW19HYTMG4+ZyPzVMyrtzqsl6IAwV38TYrtuRUplmJ3RpMFcFg5tiw/yCsUZpXlkSI
	2va9AAzmI9OeuIDRKGd3TaozcQonHtPBrPg7R2xlMeIgDa1fQYXESCueoow==
X-Gm-Gg: AYBFou0xsoAuVaRBcg/cqan76jAChvNpBPD762VhhxAXJgiGc7Gt2+cj/rqieF2wmJn
	n/fNNTV4/mr0/UetviIAr8Yenz9iiU59pqZGDnSM61pi8zwBZmr4Y3U/reaPvI/krqFw0uZb7k0
	Eh/3k1I/Fcx0BLi3rEG4tFA7AYtGpVgmzMe/p0jqgO9zyToc6oHuLFmse/3xc5OLJfO0Ds4UzfI
	7AMrp96akC+Ql72sQ/LENKb3tFnLV5S6s126Zxc+cF3E8a8nmyxcf+4N4HQNSvw0acHVjdWLKvm
	cuyobdoM4k0arvupsKIWiGYA0vI/ZMp6v/UgZdxQHwjGG7z1m/sEwkyMK0re6qp+9rTS+HClaVV
	IthsS6iJoWYZvhEE3zbab6gdbNGRCxrhz2Vzqy9Ane0epyUro55W94fN8HYNqf1pypyCVg9seMk
	WIJCdCZYLYRAw590hHQPTz2u50BAUD0VRtwIpeQyomaZc=
X-Received: by 2002:a5d:5f85:0:b0:487:21be:dcc6 with SMTP id ffacd0b85a97d-48e6e5008a9mr29401903f8f.21.1793718231140;
        Tue, 03 Nov 2026 07:03:51 -0800 (PST)
X-Received: by 2002:a5d:5f85:0:b0:487:21be:dcc6 with SMTP id ffacd0b85a97d-48e6e5008a9mr29401859f8f.21.1793718230716;
        Tue, 03 Nov 2026 07:03:50 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71bab1a8sm25236204f8f.57.2026.11.03.07.03.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 07:03:49 -0800 (PST)
Message-ID: <1ddeaabf-61d2-426a-89a9-8408d7ef9cf4@redhat.com>
Date: Tue, 3 Nov 2026 16:03:48 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/sched: act_csum: guard skb pull length overflow
To: shaos <shawnq1@163.com>, jhs@mojatatu.com
Cc: Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
References: <CAM0EoMnP3VkEV6fOAMdZ9ma9egUpV4AFfB+44k4VD7jx2dHPNA@mail.gmail.com>
 <20261029125754.3835541-1-shawnq1@163.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261029125754.3835541-1-shawnq1@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/26 13:57, shaos wrote:
> Hi Jamal,
> 
> Thanks for offering to reproduce this. I have a fix below.
> 
> The length passed to pskb_may_pull() is computed from ipl and the
> network header offset. With an IPv6 jumbogram, that unsigned addition
> can wrap, allowing the helper to accept a short skb before the
> checksum path uses the original length.
> 
> The patch computes the pull length in s64 and checks it against
> skb->len before calling pskb_may_pull().
> 
> I tested this on c339f4010dea8 with the posted reproducer. The
> unpatched kernel matched the root-seeded checksum in 45/512 trials.
> With the patch, the malformed packet was dropped (tc action stats:
> dropped 1). A normal IPv6 UDP-Lite packet still had its checksum
> updated.
> 
> net/sched: act_csum: guard skb pull length overflow
> 
> An IPv6 Jumbo Payload option can provide a length close to UINT_MAX.
> Adding the network-header offset before the pskb_may_pull() check can
> wrap the requested length to zero or another short value. The checksum
> code then uses the original length and may read beyond skb->len.
> 
> Calculate the pull length in s64, reject negative values and values
> past skb->len, then narrow the value for pskb_may_pull().

Please don't mix the commit message with replies to maintainers. The
formal patch must not include small-talk.

> 
> Fixes: eb4d40654505 ("net/sched: add ACT_CSUM action to update packets checksums")
> Link: https://lkml.iu.edu/hypermail/linux/kernel/2610.2/16452.html
> Link: https://lists.openwall.net/netdev/2026/08/24/344
> Signed-off-by: shaos <shawnq1@163.com>

We need a real full name here.

> ---
>   net/sched/act_csum.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/sched/act_csum.c b/net/sched/act_csum.c
> index 5fff52a8ca90d..196b940cd6230 100644
> --- a/net/sched/act_csum.c
> +++ b/net/sched/act_csum.c
> @@ -137,8 +137,10 @@ static void *tcf_csum_skb_nextlayer(struct sk_buff *skb,
>   {
>   	int ntkoff = skb_network_offset(skb);
>   	int hl = ihl + jhl;
> +	s64 pull_len = (s64)ipl + ntkoff;

Please respect the reverse christmas tree order above.

/P

