Received: from relay9-d.mail.gandi.net (relay9.mail.gandi.net [217.70.178.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A8842CAEA
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 11:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785239348; cv=none; b=X+BIEKxGjGPVtVIaBUuSEvoU1naH1qzeTiDl2xI4Byk05rvW+eoQbZFxtb8lwioGcLgxAcy6N6uKB3yQZIuhSZg5qCO/09rrSvBo7XR5Na6mOmwbDU5bThxsMFgDBLUjYR2vBuvSYFd6Vbi6nwJzCq7/rDeUTG+SqF4wMF9ERxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785239348; c=relaxed/simple;
	bh=A63CALdm3ATgv+vf+Hw8dAO5Bu/y1WwZsCqcOfTtkrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nQlB/A3aJHj6kjwkvYYaQ5LEL8WY9MYA0lR4hMAgEAXqW9LHojLrvHYxi1wQNkXVZtUsZ6+phSxgxdtRjNr00Kd/o8U/V7HRFk/O8JKEi9QTnqNrmIrl/k6l+6qA/9ADWgLha7f7N2JhZbC2Vz/fAACByTsu24/X8clVrZrQhC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=ovn.org; arc=none smtp.client-ip=217.70.178.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ovn.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	by relay9-d.mail.gandi.net (Postfix) with ESMTP id B51AF46A5E;
	Tue, 28 Jul 2026 13:38:01 +0200 (CEST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 585E53EC56;
	Tue, 28 Jul 2026 11:37:59 +0000 (UTC)
Message-ID: <b1379813-255d-409e-81be-9c3f4faae900@ovn.org>
Date: Tue, 28 Jul 2026 13:37:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: openvswitch: reallocate update replies for
 mismatched IDs
To: Zhiling Zou <zhilinz@nebusec.ai>, netdev@vger.kernel.org,
 dev@openvswitch.org, i.maximets@ovn.org
Cc: aconole@redhat.com, echaudro@redhat.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, vega@nebusec.ai
References: <71380bcfbf3aed9a6a8a9daeef6592fa5a4fb245.1785211788.git.zhilinz@nebusec.ai>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <71380bcfbf3aed9a6a8a9daeef6592fa5a4fb245.1785211788.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: i.maximets@ovn.org
X-GND-Cause: dmFkZTGs1Gs2Xjv+Xip9WmRZvkt1p7Aa32tTwGSLc/gaXmQ/4Jv06o6BAsDKR6EIfX2L7ZI2+ABPgGSWqqXvd0UsJ+RCMg6brjf6N8DnXgbis4x5zPWdTm92VswPUeZ0nyJCWq0jS9Zgd98TMMov/t9VaOicxa0JiLov/mN2oCmh8+O2H5C/x0l1NM81ZR+GdD8Ivz20liYUsYzxyBsASKO2CMl2FZSz7JFDTXd4PE/IqKLA0vDCRFlySUUgEe5klaqDAlfuCHAUe0kB6A1CzxEO5LaKx1l2e1NwR/ieIot4hMGCIDmpg65xBnesaHrQjJr54LLFeuq9uVziqOQ/yfYXlmYvlXEVGtkRzDNkRZBtMTjgqC9Ai7pWKMoMtWZpaYqKTdZxAOhywKkFI5U7dwv43irlKARXzLlEA6tMzFwQzZ4SZzs6uRUcdLYiTp1/02cRlp+LG4CJb8ETTbqwwlUWD/JdDPy5Qgw/vdNzBREvWlU4APd9F7MJmQUivwL81FLJp9/pRpW9LLBTGVHvXPWjowyaZwMbSVQKU2Uff/ol+BxWiCRjS3ojZlBrD/NW544aKnTvBaxCBjstL5xcYB/Xh9z5T3TaS7icKbelFC2D5c6FxSfLKB65MMbTuxKvteqmSnlabmC6Tr0FZeLZ+NXwjmPLL7oui8S/Zg9P4EjMF7I4kw
X-GND-State: spam:medium
X-GND-Score: 400

On 7/28/26 6:35 AM, Zhiling Zou wrote:
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
> Once the update target has been resolved, reallocate the reply skb with the
> matched flow's identifier when it differs from the request identifier.  Do
> this before replacing the actions so the request can still fail cleanly if
> the rare extra allocation fails.
> 
> Fixes: 74ed7ab9264c ("openvswitch: Add support for unique flow IDs.")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> ---

Please, include all maintainers in CC list.  You're missing Jakub.
And you may drop ones with old nicira emails.

> changes in v2:
> - Preserve valid key/UFID mixed flow updates as requested by Ilya Maximets.
> - Reallocate the echoed reply skb with the matched flow identifier before replacing actions.
> - v1 Link: https://lore.kernel.org/all/fa4f85fe7becb164a8a1849aa77ceeb1c08b078c.1784881178.git.zhilinz@nebusec.ai/
> 
>  net/openvswitch/datapath.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
> index eaf332b156d73..18732337ea5d1 100644
> --- a/net/openvswitch/datapath.c
> +++ b/net/openvswitch/datapath.c
> @@ -800,6 +800,16 @@ static bool should_fill_actions(uint32_t ufid_flags)
>  	return !(ufid_flags & OVS_UFID_F_OMIT_ACTIONS);
>  }
>  
> +static bool ovs_flow_id_mismatch(const struct sw_flow_id *a,
> +				 const struct sw_flow_id *b)
> +{
> +	if (a->ufid_len != b->ufid_len)
> +		return true;
> +
> +	return ovs_identifier_is_ufid(a) &&
> +	       !!memcmp(a->ufid, b->ufid, a->ufid_len);

Why do we need this comparison?  We only want to check that the allocated
space is enough, just comparing the length should be sufficient.
The check may also be inlined, I suppose, as the function name will not
make much sense.

> +}
> +
>  static size_t ovs_flow_cmd_msg_size(const struct sw_flow_actions *acts,
>  				    const struct sw_flow_id *sfid,
>  				    uint32_t ufid_flags)
> @@ -1113,9 +1123,7 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
>  			error = -EEXIST;
>  			goto err_unlock_ovs;
>  		}
> -		/* The flow identifier has to be the same for flow updates.
> -		 * Look for any overlapping flow.
> -		 */

While at it, may be good to add an empty line here.

> +		/* Look for any overlapping flow. */
>  		if (unlikely(!ovs_flow_cmp(flow, &match))) {
>  			if (ovs_identifier_is_key(&flow->id))
>  				flow = ovs_flow_tbl_lookup_exact(&dp->table,
> @@ -1127,6 +1135,20 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
>  				goto err_unlock_ovs;
>  			}
>  		}

Here.

> +		if (unlikely(reply &&
> +			     ovs_flow_id_mismatch(&new_flow->id, &flow->id))) {
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

And here.

>  		/* Update actions. */
>  		old_acts = ovsl_dereference(flow->sf_acts);
>  		rcu_assign_pointer(flow->sf_acts, acts);

