Received: from mail-wm2-f4.google.com (mail-wm2-f4.google.com [74.125.225.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DE74746BE
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 11:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784807275; cv=none; b=T7Jkb0QUEz/RVJq+oVtULuNmWisztkU2FfAyeDamwrDzr9QuYYUNuEOraq8iZju8kZST/DNaRZjvQS5x8ezg24h4kkuKYqOcBunlbgRs3ZPYnUF7BM0tCcvnMm4N8Mf23trv2JGCBS+Iy594lOx0SlKDefesJosTjkIkST5mjyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784807275; c=relaxed/simple;
	bh=EvzQLjQr9juH92Xu1971yxW24wI2VP7Oun1D0z8PyXc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sxZpvJEppkX7c2VhisekFXa1TaphUNQMkps/4t5BQ69lALV2bNnI8aeKPU60r6XXyiVfkA3wuhGUHoyqJfulEoq2m6UAU58BrfVhsZhlOSS1nm7ZRMjHkFwn1D4br9ufkuhg9Tsvu2uf1pqgaQEPoDb0d2S6o0tNTkvr/SA4wn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f4.google.com with SMTP id 5b1f17b1804b1-4955f00e593so1429205e9.0
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 04:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784807266; x=1785412066;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oBa8MuywSPFRoGUD/cFA9Gxfe1unjK9ltOmb6O6qpKM=;
        b=ANlqeAq6ARF9KJIBArB/JeMCkvGh9cjOalsdiZfYWCVb7YBQnaUe1fME799ZYwXVhL
         cq+hw3XJraVsYpsHTr6OMtNGKykZfi9iteE/OhxIA6yGBGw5sPOdoz6OE/Bt84LtQiJ3
         H9UlxsEeSeIBgKJLd/J5k0qhZIRDJRO+Iu/OVgjn8s2DPeOT/rsZNAxjvfPYWBAxa+zX
         /BPoRR4PT7dkpwgWcMhXph9ZW4HOKPhrFniLsoNjaer3RJUw8nOnayZxLpiyQJo3dptm
         MP5NDUTvB3a+6NxvtxuXbHmAR+uMp2QhQsEdTUi9TWvocYbXwPHDPiKnkSQcYpH/qL3o
         bv7Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp0AObqdB2MWH0H5A4ulEtjc7ErP585HtLmfi5SMyquZ1X+mGYwfhbNaPeRgOnpMwRkPXcJsxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyogSGt8IpPf8oLl7t/fcdKpovkmwrjnalYThFItso7hJisyvsb
	KlPs2WbZUQSr9Jjau7g3bxgrfucN4qRhs+KPq4TI2veYOHsDjQy/dJ7l
X-Gm-Gg: AR+sD12q/TfxQNdWusWV2POaW8q8pc4awocsfR5Ps/guTGME42UWzHdaZgOsMyTf2O8
	lxxtVx/9XL6F1bbN1gAYewIIdp3RaC5DKxV262Oy10IWp3U3j1CqQ1tb3mTMdUVDlNHYwk4ZffI
	lhVwzchoqWTwepQghCpbc1aW1eCtKdgYjJ0zxyxJIjZjN8jsqdn8r85ayvGmke/G5TyhlCNuGkX
	/7QAW/ERYQc3eiyeGSHSdEApqtZrKtS91Kcy3vXdPNWRN94+gORGlIGYv75clyk4CrjiRJVyfAX
	zY8YNiUKb/Tu010cegqcHUPfClrNGVu5CP7QrJRhQZIGjMlyhzGxU3eKeReyniRaq5ExWQFbtXv
	uwhO9qiQkpU8uRpyQzcVmIYrB6EyKMuEVQOKbQ5XzY9uLNzYCI/8eKrgJOxZs65RzjALZBQYiqz
	1dDYZS2v/wZgjbZFFI9eUBfxw5w5m4oY5/ZQ7NGk0=
X-Received: by 2002:a05:600c:35d0:b0:495:5d5b:7533 with SMTP id 5b1f17b1804b1-49573ccd91fmr28334105e9.13.1784807265687;
        Thu, 23 Jul 2026 04:47:45 -0700 (PDT)
Received: from [192.168.88.241] (78-80-108-129.customers.tmcz.cz. [78.80.108.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495653731b2sm222333505e9.4.2026.07.23.04.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 04:47:45 -0700 (PDT)
Message-ID: <5e647e2a-bf06-4a5a-8a04-a5913041ddd5@ovn.org>
Date: Thu, 23 Jul 2026 13:47:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, netdev@vger.kernel.org, dev@openvswitch.org,
 linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com,
 tgopinath@linux.microsoft.com, kys@microsoft.com, aconole@redhat.com,
 echaudro@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH v2] net/openvswitch: check Ethernet header length before
 key_extract()
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
References: <20260723042304.88332-1-blbllhy@gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20260723042304.88332-1-blbllhy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/26 6:23 AM, Cen Zhang (Microsoft) wrote:
> When a packet arrives on an ARPHRD_NONE device (e.g. TUN),
> ovs_flow_key_extract() trusts the user-provided skb->protocol field: if
> it is ETH_P_TEB, the packet is classified as MAC_PROTO_ETHERNET and
> key_extract() is called without ensuring the skb has ETH_HLEN (14) bytes
> of linear data. key_extract() unconditionally pulls 2 * ETH_ALEN bytes
> for MAC addresses and parse_ethertype() pulls 2 more, either of which
> triggers a kernel BUG in __skb_pull() when the linear area is too small.
> 
>   kernel BUG at include/linux/skbuff.h:2848!
>   RIP: 0010:key_extract+0xa7e/0xd90 net/openvswitch/flow.c:933
>   ovs_flow_key_extract+0x419/0xa70
>   ovs_vport_receive+0x222/0x390
>   netdev_frame_hook+0x3e0/0x630
>   tun_get_user+0x2d0c/0x38e0
> 
> Fixed by adding checks in key_extract() before pulling the Ethernet
> header.
> 
> Fixes: 217ac77a3c25 ("openvswitch: allow L3 netdev ports")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Link: https://lore.kernel.org/all/20260721143602.64677-1-blbllhy@gmail.com

This link should not be here, it doesn't make sense as part of the commit
message.  It should be in the change log under the cut line.
Maintainers will add the Link tag for the version that will actually be
applied.

Adding the Link tag to workaround the checkpatch warning also doesn't make
sense.  The warning is there for a reason.  If there is a separate public
report, then you can link it, otherwise just live with the warning or drop
the Reported-by tag.

Also, the tree name 'net' is missing in the subject prefix.

> Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> ---
> v2: Moved the check into key_extract() per Ilya Maximets.

You also changed the check, which is not right, IMO.  More on that below.

> 
>  net/openvswitch/flow.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
> index 66366982f604..de7b77d6702a 100644
> --- a/net/openvswitch/flow.c
> +++ b/net/openvswitch/flow.c
> @@ -926,6 +926,9 @@ static int key_extract(struct sk_buff *skb, struct sw_flow_key *key)
>  		skb_reset_network_header(skb);
>  		key->eth.type = skb->protocol;
>  	} else {
> +		if (unlikely(!pskb_may_pull(skb, ETH_HLEN)))
> +			return -EINVAL;
> +

We should keep the check_header as it was in the previous version of
the patch.  It distinguishes the cases of the length mismatch and the
memory allocation failure.  While it's not critical in this scenario,
it is more consistent with the rest of the code.  The error can be
sent to userspace from this location and it should be more granular
than just EINVAL in all cases, and the check_header() provides this
granularity.

Best regards, Ilya Maximets.
