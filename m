Received: from mail-ed2-f11.google.com (mail-ed2-f11.google.com [74.125.228.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015F8428472
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 13:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785505418; cv=none; b=VJXaPJ11tmRY76LCT9lgRlCsLrB9js9K20ltXrhpYddjx8qwUD8BKvxQPz5gDFLxvBzSKFKROhoN4s8kYBhPw9MgNHYLjdyeI5Db1eK3PX25b77I0frNq2FI7SHojd17ID1xZiBySsY0HsVK9qwFjDYrOVjhPMgTMkOxXpk34NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785505418; c=relaxed/simple;
	bh=EqdU4u+6Ft1dVu3bgY5wxogDQ6jHRutxwSheAxUaOyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nw646NyoYjt5+LVtlfPniRPoILvBxap7J2phoLcAnaNSkZNb03s4loI/R9p2kQj7v3SeBMk03WgQE4+P0d0mVF8OGxWKM4gsLWf56PA0CdnUkOBuywJ1EiRo1bLeMC93UxsA9iuIW4ld8+35j9OV1jp3dxubBwkYtbXzt7XgQdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.228.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed2-f11.google.com with SMTP id 4fb4d7f45d1cf-69f4b000237so401130a12.0
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 06:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785505415; x=1786110215;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7gekbEKMahqrq477slabtPXrcasFqXXP5wGWUbow2GI=;
        b=fjkOndQQu2PXM0IdEoZbLL7UYSbZntsLqFFUivLbCPQ4RrpU5OlML21F+ZRzSr9yZR
         32xg8eTBgl8LAig+svAJG9LrJsHUzwWuHha1aBIbzK5f+kQ2Uy3RN3d7D7pO1/AI3l5Z
         gqU745+hfYbMaaxUs2vHWCK94ZpJG4iAXaevxce0HXIt3E2pOXJIxec9acqjDqFndoWE
         OHQXYQLgFl6fOgTB9vtUjsJZpJM83k+pPvo6o7cYpuXKBlA2Db367nq+qvgmaV/fFweG
         HLrlJo2jxQBOw+sC+2U8HZlNdCGggEyCRUKU3FfCYUB+N/gZmo170dkxhSOSQeb/sYcE
         i6bQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrv/zQkNul6jzVjM+6kiecYKFsk58y8rGd+E64YC27RqW3vAt5ClQquYy9jL43XXAZXCalgelI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGr7wvGg0Hug7+mgaScUMmL3iN+nSom++4Sq/o/FHcyVATqwEx
	fp8Cj+o5ePuaSAxroGSFckRWaWWBIzmNpR0mKxaMThU4HXTS/N9opbQI
X-Gm-Gg: AR+sD11GgNDdH3jfyXWQGWE2Y5LuOhKcbr8vVmT1HDbHwmUrwxeDgoK0AdrY0K9EXdg
	1qL51jYIVu9CqsUJyplsuvWdSag2T4Igf52eqhdvRQ0/uEukcAQAsLdOR88cmCz4OHYvUZsUYle
	8maKt1IagGJ/0fDE5lEVxn1BvZtC8oZrN6RHhPhDB4ygMTSd+jG8YB8y/VYlpUtUt3i+aMwFEui
	Tr3Zhkvpi2hJ3XoKoCrqM+HI6BFv897YNlyNmeTC6YiMUCxHHmWYNnSkIvn1xi3klmzvtjISls5
	pJhIg6AT/hRXIbRaYQeInmdE9bZC3c9H/Vsv8c2fztEEx09icx6BpBEYGuWxbDKqC1lgDwqHfpz
	soqTIZRrlTUntvfr52vbQ+Gl5eFaeKZqDpm64uNnHYkTU34z8LQ1Jpsa1OTuAI+qLJeThbLWGQd
	XdOGZApAi8iJfDI0ffQ6KUBaCxMkUMo36E+dwdPPsfu5FdSDZhvvs5h8wcz26rvCqr2JxwI+bcj
	8xGUbLK9aBjbvKZ1OL+ssQMXw==
X-Received: by 2002:a05:6402:518e:b0:698:50ea:2d97 with SMTP id 4fb4d7f45d1cf-6a098d097dcmr1272142a12.20.1785505415057;
        Fri, 31 Jul 2026 06:43:35 -0700 (PDT)
Received: from [192.168.88.241] (78-80-108-129.customers.tmcz.cz. [78.80.108.129])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a09c63d9aesm2053241a12.19.2026.07.31.06.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 06:43:34 -0700 (PDT)
Message-ID: <82d57a4c-297e-42e4-baac-5ea431c32447@ovn.org>
Date: Fri, 31 Jul 2026 15:43:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/1] net: openvswitch: reallocate update replies
 for mismatched IDs
To: Zhiling Zou <zhilinz@nebusec.ai>, netdev@vger.kernel.org,
 dev@openvswitch.org
Cc: aconole@redhat.com, echaudro@redhat.com, i.maximets@ovn.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, vega@nebusec.ai
References: <c773b2726dda8d90eed6d42b2f9741810a7a46e1.1785288876.git.zhilinz@nebusec.ai>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <c773b2726dda8d90eed6d42b2f9741810a7a46e1.1785288876.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/26 3:53 PM, Zhiling Zou wrote:
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
>  net/openvswitch/datapath.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
> index eaf332b156d73..3007d75b42145 100644
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
> @@ -1127,6 +1126,25 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
>  				goto err_unlock_ovs;
>  			}
>  		}
> +
> +		if (unlikely(reply &&
> +			     ovs_flow_cmd_msg_size(acts, &new_flow->id,
> +						   ufid_flags) <
> +			     ovs_flow_cmd_msg_size(acts, &flow->id,
> +						   ufid_flags))) {

This version seems fine too me code-wise, but this construct is hard to
read.  There isn't a particularly good way to format this, but maybe
something like the following will be easier on the eyes:

		if (unlikely(reply)) {
			size_t current, desired;

			current = ovs_flow_cmd_msg_size(acts, &new_flow->id,
							ufid_flags);
			desired = ovs_flow_cmd_msg_size(acts, &flow->id,
							ufid_flags);
			if (current < desired) {
				struct sk_buff *resized;

				resized = ovs_flow_cmd_alloc_info(acts,
								  &flow->id,
								  info, false,
								  ufid_flags);
				if (IS_ERR(resized)) {
					error = PTR_ERR(resized);
					goto err_unlock_ovs;
				}
				kfree_skb(reply);
				reply = resized;
			}
		}

Best regards, Ilya Maximets.

> +			struct sk_buff *new_reply;
> +
> +			new_reply = ovs_flow_cmd_alloc_info(acts, &flow->id,
> +							    info, false,
> +							    ufid_flags);
> +			if (IS_ERR(new_reply)) {
> +				error = PTR_ERR(new_reply);
> +				goto err_unlock_ovs;
> +			}
> +			kfree_skb(reply);
> +			reply = new_reply;
> +		}
> +
>  		/* Update actions. */
>  		old_acts = ovsl_dereference(flow->sf_acts);
>  		rcu_assign_pointer(flow->sf_acts, acts);

