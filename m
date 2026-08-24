Received: from mail-ej2-f3.google.com (mail-ej2-f3.google.com [74.125.228.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C1340F725
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 11:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787571506; cv=none; b=Hk/hE9LX4l2fArI2jeqYMU2gjHfYvKmKJNFiP9itZvcQYOaKVqpEqmYgzTVqNM5D8Y9Z1By9YJW6cyDtMKVVjruT+E+GLmEOn1me9ifO6bSPDOMeoAlBREYS52bIu4JvurDEikPTRqhbPHYpJsbIDzlbJwXGXiQ1fcS+7ZzfJfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787571506; c=relaxed/simple;
	bh=B9aFDxxpy59KvTSrXtpA91Y+JcUGhDK4gpygo9R89Yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JExtiWuZ+6nZRNY5Ma0gcLCIh25hk43n4nvCyQ0NE8Vq8e3pOio8HiexMV1DN9m3GkWEy/Bi8oCZMyjKKmWKeerNRIiIVBJWQM50VYJ0ov1+v7mFZ+6PFTMd2b4kP10OA8lXGczEaa2IMCnu72rACbWGIrd8bC1dgwklbYBd4Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.228.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej2-f3.google.com with SMTP id a640c23a62f3a-c15dc93e168so210059566b.1
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 04:38:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787571503; x=1788176303;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ui9avbDrEP43w25MsGCaef1apua94rZiC1pGTaJKsP0=;
        b=oJHnqI1WFP3SstsKE+PoX3+KHgaaaFiJAYi3f2u05HKg2Y31YV5LdEJ08kyE19hztE
         P7iMKwBVyUqURZX9JdpqhmxaxjmlL0kWsgme+tSzxC4tzmV4+kQ+SZ8lRmaFI01w9X67
         NkDxxU8n03vmI53RvU7l6hie0069SneNtrNhHscoeQ4fI19Mh4RkIpnppxwrzWjeGHKz
         CpKkIID/0x7iTfSdd6mmOSw4nAnPvALDP9Zj5dLWV+NUV/QNsEzCo96uv+O2VP+ALLFW
         dxK8A0OipwPMZ59vJnyrNbXxvrs24dJeRqeuB0ygsnnFCmf+GBh+OU/7cJH2HJYx80cR
         OrRw==
X-Forwarded-Encrypted: i=1; AHgh+RpnRYORj9x3VGruBosjq1htpntKo30tksrX3Qi5qE7o+pfbgLSFDmCQBPO0cO5EcBdFSyebu3c=@vger.kernel.org
X-Gm-Message-State: AFuF++mXWFc3ra1kirK5tbSSGIDLMGDcJ4FTsaHZaXSjS2l1CHj2gsOM
	EGD3/THuda+0wxpnW8KsyMur42H0cI3rkslSJH5nJg2Ef9ibBOaY6LjM
X-Gm-Gg: AR+sD10XbSjZLEaHqBVHQ11MSCUZza++3/jTsFDpRcNzDMJyhurVhbjfngMOud4atSW
	4I3YsJFGCg38dVGUmicKiyb6zru+hUsHXZaVtlUdBZb84qB8v+I4aVH87z1Kog7u7uWE9xXgyWq
	2fDhDTCUTl1aTaasKmoMMIF5gNlxmXREu98z1T+/v53jPwqrrCgcwmcpPHDzwGKBeSdjpSBBd5D
	oWRKsxlsaZkcs69xw5wJiWIqxPMlfwOO6HPJEi0ptOOwz1oFgIa16Wog1sc5yoTB29L/8FrQrhi
	RZ/qjLBTj+XvMlRRhJs+jxE5NHuyhIQ0I5LNhKS49rorgoTvFaHAdBZvJ9p3UXVZ1bl1wJw4Sor
	+aOO84TtUPCIczdMsVQzTOS0KfvMB9M7MWi/+TMCo+6IP5tgzeTbjcDLIOUnF8dhZ+XZJDxWTC6
	/a0lyctgaVyN2xgpK54l7ca+OGplfTw+jXHNqb5fn/I5x3Hg82R5GESqHxC5KWAe3dgHvdETHIf
	rhTdDu1cmB8C1l4n0H8YA==
X-Received: by 2002:a17:906:9c93:b0:c24:6687:bf6a with SMTP id a640c23a62f3a-c2492663ee3mr1901078466b.21.1787571502740;
        Mon, 24 Aug 2026 04:38:22 -0700 (PDT)
Received: from [192.168.88.241] (89-24-57-65.nat.epc.tmcz.cz. [89.24.57.65])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249685c573sm1528423166b.51.2026.08.24.04.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 04:38:21 -0700 (PDT)
Message-ID: <c96b6c6f-1155-45d2-a117-489f1c48c8ef@ovn.org>
Date: Mon, 24 Aug 2026 13:38:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 0/3] net: don't strip zerocopy frag markers from a
 forwarded skb
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Ilya Maximets <i.maximets@ovn.org>, Jakub Kicinski <kuba@kernel.org>
Cc: Norbert Szetei <norbert@doyensec.com>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Kuan-Ting Chen <h3xrabbit@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, dev@openvswitch.org,
 Jongmin Jang <payload.jang@gmail.com>, Willem de Bruijn <willemb@google.com>
References: <F3B9E5BA-0AC1-4AD1-A7D9-F38033304270@doyensec.com>
 <34c64d08-0484-4f3b-b61a-ed68115d01a4@ovn.org>
 <20260821170950.3e278b1f@kernel.org>
 <86c61c39-901e-489e-aec9-fafe639276e7@ovn.org>
 <willemdebruijn.kernel.125b8a9cdc49a@gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <willemdebruijn.kernel.125b8a9cdc49a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/22/26 10:55 PM, Willem de Bruijn wrote:
> Ilya Maximets wrote:
>> On 8/22/26 2:09 AM, Jakub Kicinski wrote:
>>> On Fri, 21 Aug 2026 23:45:41 +0200 Ilya Maximets wrote:
>>>> Unfortunately, this needs a rebase now that a conflicting change
>>>> for skb_zerocopy() was merged:
>>>
>>> Ugh, I was supposed to merge this first, wasn't I? Sorry.
>>
>> Not a huge deal, I guess, the conflict is mechanical and the patches
>> are simple.  I can take care of manual backports once we get the
>> 'failed to apply' emails.  Just a bit of busy work.
>>
>>> I was hoping for Willem to TAL since skb_tx_error() is a tx ZC
>>> thing, now I realized that he wasn't CCed :S (please do so on v4)
>>
>> FWIW, I CCed a few people on v1 to have a conversation about a proper
>> fix, but that wasn't fruitful.  So, if I were Norbert, I wouldn't
>> include them for the new versions either as doing so always feels like
>> me being annoying. :)
> 
> Having a look now.

Thanks!

>  
>> For now, the plan is to get v4 of these targeted fixes into net and
>> stable and then remove skb_tx_error() entirely once net-next is open,
>> as it seems to have lost all of its prior meaning.
> 
> The original use case in tun_net_xmit introduced in commit
> 149d36f7187c ("tun: report orphan frags errors to zero copy callback")
> still exists. Not sure you can remove the function entirely.

The skb_tx_error() prescribes to call kfree_skb() right after it and
all the callers more or less do that (with the fixes applied).

skb_tx_error() does two things:

1. skb_zcopy_downgrade_managed() that takes extra references on frags.
2. Calls skb_zcopy_clear(skb, true);

The kfree_skb() called right after does:

 __kfree_skb
   skb_release_all
     skb_release_data
       if (skb_zcopy)
         bool skip_unref = shinfo->flags & SKBFL_MANAGED_FRAG_REFS;
         skb_zcopy_clear(skb, true);
         if (skip_unref)
           <skip unreferencing the frags, which is the same as taking
            the extra reference>

So, unless I'm missing something, the kfree_skb() already does everything
that skb_tx_error() does.

The fact that skb_tx_error() calls skb_zcopy_clear() with 'true' though
feels weird.  I would understand the need for the function, if it was
actually signalling the error and not success.  But you switched false
to true in commit 1f8b977ab32d ("sock: enable MSG_ZEROCOPY") nine years
ago and it seems like nobody complained so far...

> 
> The bug is hit when this function is called with a cloned or shared
> skb. The original zerocopy path through tun_net_xmit was probably
> expected to not have this problem.
> 
> Commit 0110d6f22f39 ("tun: orphan an skb on tx") explains why this
> orphan in tun_net_xmit was needed: a (vhost) zerocopy skb injected in
> tap1 arriving at tap2 and not being read there indefinitely. Such
> loops are not allowed for zerocopy.
> 
> Commit 868eefeb17d4 ("tun: orphan frags on xmit") then added the
> frags orphan. Since an skb can be cloned on this tap to tap path,
> e.g., with a packet socket, I think the bug goes back to the original
> commit that introduced the first caller of skb_tx_error, commit
> 149d36f7187c ("tun: report orphan frags errors to zero copy callback")
> 
> If respinning it may be worthile to link to this thread.

