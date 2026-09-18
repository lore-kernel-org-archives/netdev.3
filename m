Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584E25172D6
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 17:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789752238; cv=none; b=ae+PhEbzdUA26gSaKUMRGO/g2kwVhwNfaqb2+Rx5Ny8Wm4WF+sks6e69NqEVq0PFsl/cZE2mM3FH9uiemLwSR5/YGrrdiqaWi5uP267z2PNFUxhJGrQxyWHFy2l3mPtLxnQBscgPDV7R/9VHoba/q6WMe3W3pOOLuEgGyazwwHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789752238; c=relaxed/simple;
	bh=YIjlZKIm+IFO56oHuR2t4YL5KZwQ2kRZEAKcQevolLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JMj2URASsFRhDopESyHBcc5z+WR+Gn5+pxZCyfymScheoRBdtCuCQTsqT0vSW7LSO6ieyACp5gmHR8VWnqMab9QmiNkZpP4cvpHX/aQQEeLiyBnEomGPeA8PLfw9xEQDmm3fprPqhK+MXgyg9bacTvQNhJP3mVofyZJi86fEsTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49ccea58fe3so2200625e9.1
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 10:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789752234; x=1790357034;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zLyNnBxb3LiRUxaaBPI15vkPRVnqKuYKpEiINQXaj50=;
        b=zVF1EnB6QgP3JF+Sromsikh6Lw1ZCB5eCbOGnSSv/uMnO86vNvgnkYKcAOvtJ/3BJo
         6aII4GeIjn21jBnTbJBa2diItd/OnJn1Q3OV959RJlNVCkJ4hyNXtM5kQ0KTQEfZlXja
         Oty0AJM8Gi+My9XdDDNej6TMoCYZBPgcDm0g8VVYFhrgpnvyQhVroZ6XOs6CtMdcoV4y
         54j8OHXIHPHCKNxtJO2zFJVHtNL7ZjRX3UCTNQkc9+5iIcTx49GQKx+SYWf2xAgz09QG
         o1wZZjZfH2YnFtQAvWf4YxKylOi31mPGepKpEJjRDtC8+vUOycR+va9/nC6DM89xXfWa
         yTQw==
X-Forwarded-Encrypted: i=1; AKwUvBxqBiJx11sFlYEZ1RiM2wqmOIXJRz8PecuhL5brbUdqUgJihoD/qx5VlRBtLDIk2UE29yHXRrI=@vger.kernel.org
X-Gm-Message-State: AFuF++mqRFGGJX2PUG4cEVodIHAfUCCTbW75RAu5a0E40lra9wo+37hq
	MsswJ7lRgBdaG0YzKDKAIYu0ebq4oNGa9WSsB2KcA6crn5z8ZAWMP45W
X-Gm-Gg: AYBFou2seipIigEvVrXGTRsQKoDZ81eUk67fuDKIBDpFjRKqOT29yoRWKjx1NvffBs2
	sDFFKwVeEBM5v/tBdqICn2D0QlTcB1eiqzzNd7ZJbtYp/9rr9wVm7t4+Mi4RZS+omULGIRUTMH5
	IXOiSmyupq3mRd209JJqngCY5IorP6FR+Swh12DPAxFuQJk8fOEovtT1tTLKUHX6MfRJbAue6Jh
	qlPRRV2NV+Z64ea7zoBFa9FrGytdNgHbMkoZCxj0r1T16hZP8/UmZFDpeHJPusr6yzUCjHu1VTR
	MIr95+sTEO9NmrL5jCLb8ncUNF3/cwFoRotk951hqPnEeg3WdfAUGHvHL5ynLId08JxCmBmaeSv
	Lr0pqYF81JokqYe7RTvQRv2PgfggqM+5ey2JSwyaT9LgHZyFDzo+MrPfd/Diiph7LJncEt8vwFa
	LGUfuELosq1Ymhaw1kcJmMQUPC6HCtZl/vsQ7a11UFw3x+XMim/uxW34ETQPixP1yY6V+sarP9Q
	fWBBw7TV501MGdNJafh7LzssFptEIbxWKPqvDQ8QLBTa6vlrob5
X-Received: by 2002:a05:600c:3b29:b0:49c:fc6c:bdfa with SMTP id 5b1f17b1804b1-49fc57469bbmr43372925e9.17.1789752234306;
        Fri, 18 Sep 2026 10:23:54 -0700 (PDT)
Received: from [192.168.88.241] (37-48-42-237.nat.epc.tmcz.cz. [37.48.42.237])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd10d21asm8649175e9.12.2026.09.18.10.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 10:23:53 -0700 (PDT)
Message-ID: <2bd2dd1e-19d7-4f89-b921-f7a07fea9a7a@ovn.org>
Date: Fri, 18 Sep 2026 19:23:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ipv6: do not let ipv6_find_hdr() return an offset
 past the packet end
To: Norbert Szetei <norbert@doyensec.com>, netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Ilya Maximets <i.maximets@ovn.org>,
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 dev@openvswitch.org, linux-kernel@vger.kernel.org
References: <8F80BA1A-DDFD-432D-9075-242A3435FEB5@doyensec.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <8F80BA1A-DDFD-432D-9075-242A3435FEB5@doyensec.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/16/26 9:57 PM, Norbert Szetei wrote:
> ipv6_find_hdr() walks the extension header chain, skipping each header by
> the length that header itself declares.  ipv6_optlen() returns up to 2048,
> and the skip is never checked against skb->len, so the offset stored in
> *offset can point past the end of the packet.
> 
> openvswitch installs that offset as the transport header, and
> update_ipv6_checksum() then reads and writes the transport checksum field
> out of bounds:
> 
>   BUG: KASAN: slab-use-after-free in inet_proto_csum_replace16+0x445/0x470
>   Read of size 2 at addr ffff88810b754b06 by task ovs_ipv6_oob/629
>   CPU: 4 UID: 1000 PID: 629 Comm: ovs_ipv6_oob Tainted: G N 7.3.0-rc3+ #348
>   Call Trace:
>    inet_proto_csum_replace16+0x445/0x470
>    set_ipv6_addr+0x3dd/0x460
>    do_execute_actions+0x6a3d/0x7c40
>    ovs_execute_actions+0xfd/0x480
>    ovs_packet_cmd_execute+0xc38/0xf20
>    genl_rcv_msg+0x59e/0x870
>    netlink_rcv_skb+0x18b/0x450
>    genl_rcv+0x2d/0x40
>    netlink_unicast+0x6bc/0xa20
> 
>   The buggy address belongs to the object at ffff88810b754980
>    which belongs to the cache skbuff_small_head of size 704
>   The buggy address is located 390 bytes inside of
>    freed 704-byte region [ffff88810b754980, ffff88810b754c40)
> 
> Other callers use that offset too, so bound it here rather than in one
> caller.
> 
> Reject a header whose declared length does not fit in the packet.
> ipv6_find_hdr() already fails with -EBADMSG on a malformed chain, so this
> adds no new failure mode.
> 
> Fixes: f8f626754ebe ("ipv6: Move ipv6_find_hdr() out of Netfilter code.")
> Suggested-by: Ilya Maximets <i.maximets@ovn.org>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Norbert Szetei <norbert@doyensec.com>
> ---
> v2:
>   - fix ipv6_find_hdr() instead of the openvswitch caller, per the review
>     of v1
>   - dropped the openvswitch change
>   - retitled
> v1: https://lore.kernel.org/netdev/114FAFBD-F7BC-46AE-AF9F-0D15124F130E@doyensec.com/
> 
> Reproducer available on request.
> 
>  net/ipv6/exthdrs_core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/ipv6/exthdrs_core.c b/net/ipv6/exthdrs_core.c
> index 9d06d487e8b1..4a9748338cf4 100644
> --- a/net/ipv6/exthdrs_core.c
> +++ b/net/ipv6/exthdrs_core.c
> @@ -278,6 +278,9 @@ int ipv6_find_hdr(const struct sk_buff *skb, unsigned int *offset,
>  			hdrlen = ipv6_optlen(hp);
>  
>  		if (!found) {
> +			if (skb->len - start < hdrlen)
> +				return -EBADMSG;
> +
>  			nexthdr = hp->nexthdr;
>  			start += hdrlen;
>  		}

Beside the inaccurate Fixes tag that Ido already flagged, the change
looks good to me.

Reviewed-by:  Ilya Maximets <i.maximets@ovn.org>
