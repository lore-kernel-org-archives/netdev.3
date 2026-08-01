Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B032396590
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 15:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785596416; cv=none; b=EU9FUFFCn/2jyVyNARoXQ7JCp+Oc6yUlMXWw34y0Hd6bgQMFsfIzhYxh7AOOvuzdvYvS64mSwZ6owvMMu5zZWUM95txGiU72roj7yy0D5bAGbyRb5hONL9CH0N8UULh6hS7jWHeKfMZg/tmpY6kMA6RHtA7xkEBlAbPADRCr9+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785596416; c=relaxed/simple;
	bh=jzkQHN5Uu5UXJSzfDbDyu/o3nitAf3sYGoty6O/mfAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bso9oTTjQZt/BqKAidzyVWD+zW+g1Q5q6KGFNTJMcPVIpUqSRbYjCTp0BFdhnQMolbjYG7Yfw3A+oBTiqgxdS9TAM6R/zoOy/OPB4cgBE/BUNwByBz5Od48Ud5L6Ot3KDegppoU3Vl1CJMEaKtLjYHrs7Drx8HwMbBrubjFSTls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-495437bb891so5198345e9.1
        for <netdev@vger.kernel.org>; Sat, 01 Aug 2026 08:00:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785596411; x=1786201211;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4EchJ508zFELw66vNV/37VRQr//yd5N3PjzOiW3ndEU=;
        b=VEZUL9EphSCLkAesdzmABtdpRbEcgDx6bzdipUn25O/JMlVemB4quE5n/pt5fKgTcr
         MrC8zCYfXQ3Nzl0Q++B8hoqXN3l5so8bo3Z7iBk0vzuTbE3nUtACvYoftcknDTnms+yp
         Lo6SxE+f5W6wSOCCTR92qBtCZuSP5oNCyrZf7b7xPLlCWHcDsWokWZL8m7QfiPJinxya
         I7NF5h/f0QvXeaQJghRJjGk7LArOer9JP2ChUS/RZzDGveVTj+6PYDgNTdrzXmzp9TpY
         Lh2UsYKXUYo7kzeX+6DF+qK8AKNnZb2wVyhQOLQdqjQgZ+D7DbqHN4pGWb1VxmFUWNV3
         PtZg==
X-Forwarded-Encrypted: i=1; AHgh+RoiLYSGM8OgI0n4YequEPimtgU72vlMjoX28U1vje2hd3RQRo9DoOM3cREylsP0TBjeaFi2m0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTQmiTzd0b5Oqyty79LJ5keKw81avMYz6kz1m229n68tTQft/n
	oy0ghBMjY5l6T/i0CeeZrfl6fJ8f2UXh9br1PfWAmR3rqloCQpPhaCoW
X-Gm-Gg: AR+sD12nidiz+2xZe612t4E9zkuUudfZnEIi1fglrvfbF+kIuf6rDvUkuR6YiskT6v6
	qqGBHL8KiUpYpCY/R7L1REYVypFCODSF9h0DK/YxlIkYvuHSCkVLJrlPlfge6Wc9IOCGXH/vh17
	6E7L03T4c3K+DekDLZpiOFvcunCU7pRxEs5rR0reb4LcnU5bu0WUXRD7dVBjzfYgaDJssHWHDrr
	7uTZ4o3t0B7KG3b0D/KFuJAuuhkztJ91ekJb8UbqGi81Sv8cvgLSpozA2g1I/c/CGQc4gTmtreF
	F9z3PVfHwppu8FBx5j8m6Xwrv3F3BCLo7nHSGBFCo6WqEvk25s/lqUtRH3P0/gcH8oStyx8afNI
	Lv9KmHtvHsnS3NnzkCwYVhhIZoesL93duC1voXRMSpotsdH27AivmNGdUUNso3xU1QLpdsqDWod
	/alh6PFBlYzwRQPitIhvff8J+JMHxBXDLuKS/LFiJPGBf9NqV4DanMwo+ol7Ygl07JQT25YybsB
	DZkD3vSFXZeTNY8nm7BZSIeFQ==
X-Received: by 2002:a05:600c:1909:b0:495:41ea:f6e with SMTP id 5b1f17b1804b1-4980f3c90cemr42520525e9.8.1785596411390;
        Sat, 01 Aug 2026 08:00:11 -0700 (PDT)
Received: from [192.168.88.241] (78-80-108-129.customers.tmcz.cz. [78.80.108.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b67529sm62612585e9.8.2026.08.01.08.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2026 08:00:10 -0700 (PDT)
Message-ID: <d37125a4-1ab9-4d20-8dad-a0a5e832713d@ovn.org>
Date: Sat, 1 Aug 2026 17:00:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 1/1] net: openvswitch: reallocate update replies
 for mismatched IDs
To: Zhiling Zou <zhilinz@nebusec.ai>, netdev@vger.kernel.org,
 dev@openvswitch.org, i.maximets@ovn.org
Cc: aconole@redhat.com, echaudro@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 vega@nebusec.ai
References: <3b76cbe50252a5650c3b69c789ed36481d0bbee4.1785583308.git.zhilinz@nebusec.ai>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <3b76cbe50252a5650c3b69c789ed36481d0bbee4.1785583308.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/1/26 1:25 PM, Zhiling Zou wrote:
> ovs_flow_cmd_new() preallocates the optional reply skb before it takes
> ovs_mutex and before it knows which existing flow will be updated.
> 
> That is normally fine because the skb is sized from the request flow
> identifier.  That identifier also becomes the inserted flow's identifier.
> For updates, however, a request with a UFID may miss the UFID lookup and
> then fall back to the flow key lookup.  That lookup can legitimately find
> an existing key-identified flow.  UFIDs are optional and the flow key is
> the primary identifier.
> 
> For echoed replies, ovs_flow_cmd_fill_info() writes the matched flow's
> identifier, not the request identifier used for the preallocation.  A short
> request UFID can therefore leave too little room for the key identifier.
> The fill can then fail with -EMSGSIZE and hit the BUG_ON(error < 0) in the
> update path.
> 
> Once the update target has been resolved, reallocate the reply skb if the
> matched flow needs a larger reply than the request identifier allowed.  Do
> this before replacing the actions so the request can still fail cleanly if
> the rare extra allocation fails.
> 
> Fixes: 74ed7ab9264c ("openvswitch: Add support for unique flow IDs.")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> ---
> changes in v4:
> - Split the reply size comparison into current and desired variables as
>   requested by Ilya Maximets.
> - v3 Link: https://lore.kernel.org/all/c773b2726dda8d90eed6d42b2f9741810a7a46e1.1785288876.git.zhilinz@nebusec.ai/
> 
> changes in v3:
> - Compare computed reply sizes instead of UFID contents.
> - Inline the rare reallocation check and add spacing around the update checks.
> - v2 Link: https://lore.kernel.org/all/71380bcfbf3aed9a6a8a9daeef6592fa5a4fb245.1785211788.git.zhilinz@nebusec.ai/
> 
> changes in v2:
> - Preserve valid key/UFID mixed flow updates as requested by Ilya Maximets.
> - Reallocate the echoed reply skb with the matched flow identifier before replacing actions.
> - v1 Link: https://lore.kernel.org/all/fa4f85fe7becb164a8a1849aa77ceeb1c08b078c.1784881178.git.zhilinz@nebusec.ai/
> 
>  net/openvswitch/datapath.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
> index eaf332b156d73..d73d729176e1f 100644
> --- a/net/openvswitch/datapath.c
> +++ b/net/openvswitch/datapath.c
> @@ -1113,9 +1113,8 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
>  			error = -EEXIST;
>  			goto err_unlock_ovs;
>  		}
> -		/* The flow identifier has to be the same for flow updates.
> -		 * Look for any overlapping flow.
> -		 */
> +
> +		/* Look for any overlapping flow. */
>  		if (unlikely(!ovs_flow_cmp(flow, &match))) {
>  			if (ovs_identifier_is_key(&flow->id))
>  				flow = ovs_flow_tbl_lookup_exact(&dp->table,
> @@ -1127,6 +1126,29 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
>  				goto err_unlock_ovs;
>  			}
>  		}
> +
> +		if (unlikely(reply)) {
> +			size_t current, desired;

Unfortunately, this breaks the build.  Please, make sure the code
compiles without warnings before posting patches, don't just copy
suggestions.

Let's rename these into 'cur' and 'req' (required).

> +
> +			current = ovs_flow_cmd_msg_size(acts, &new_flow->id,
> +							ufid_flags);
> +			desired = ovs_flow_cmd_msg_size(acts, &flow->id,
> +							ufid_flags);
> +			if (current < desired) {
> +				struct sk_buff *resized;
> +
> +				resized = ovs_flow_cmd_alloc_info(acts, &flow->id,

This line is too long.  The line length check for netdev patches
is 80.  Move the id to the next line.

> +								  info, false,
> +								  ufid_flags);
> +				if (IS_ERR(resized)) {
> +					error = PTR_ERR(resized);
> +					goto err_unlock_ovs;
> +				}
> +				kfree_skb(reply);
> +				reply = resized;
> +			}
> +		}
> +
>  		/* Update actions. */
>  		old_acts = ovsl_dereference(flow->sf_acts);
>  		rcu_assign_pointer(flow->sf_acts, acts);

