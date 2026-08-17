Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10094447819
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786985267; cv=none; b=ffqbyL4v67mbcgj8UZHvTinNXng6WBhyY1v5r86fEVXF1x434EaMgTP82DBfJBOLw5sb4XeDqcih8bXHxfnbvJWtUDqsn7IcPru1vwb/wF8IaM5+g8nCpvCON1iuFU+nuV5aeUS/JIlr9Ax0s0kWG04hFwyVZjnv320FBECtY1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786985267; c=relaxed/simple;
	bh=S0YihGns/HogDj6mdTaYduxc4sX4rOFFjlMglxenAsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rFAJ/LrrtiyOVvnjfqKnNqR3tqQum6EWfhdjw1kltumKhz4TjFMglBt3LmbHvWRKK8OmOyMgRLZnH/FsoG0LmVmkK10diEEx/kNHewnIgOLJq/GY7xlYbFUydbKCPwD/W5Kxvb1oo+2J4U+F6QHj88eOoUnkUQQ3eJVCwOyYUYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-470713a9053so855131f8f.0
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 09:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786985262; x=1787590062;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W2f8MmagPFbk9XG5LRo+qCezm6yoGph0yYValvhduB4=;
        b=rWjN3G7ic+djSfmESVO08mM/QTFWZbAs6EZ0TJarBtYoDKH7R+ezDhXsHrLMKEWAqk
         3DH7HKXnyO+8p6N40LtWjV1E/XypcFqwKr5MxLM6f4e1vMyTcoVAOe1vwHaghpmj9Er9
         9IGN3ihX/rFawjS1BfhYLQZYHWjbxG/Dz/0MO8SIbCQNsrrmgMFsJVtptlO6WUgRtp0c
         x2bwdd9Dbp9AGj3oqvUya/yGH/DAB/9XbMZ6WgC/x5RTPgGjDzGNjB+cxQWopLJ7vTU4
         6mdjskm3N9qOqF0zAbR3h/6lv1J9D5zLTtjm9VmbwYXO+weIesgw2kRtt9BOzrMQf6qU
         Rr+w==
X-Forwarded-Encrypted: i=1; AHgh+Rp9IapcJbDn0hEFZCN+frXv4MB1hYQNSjpQmqJ6XddE4EY8ldUltydE/kfldZ/j2oyiLB8LtmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcL63xQeAC2g7NjR9bhqKWexIZkTEnaopmlXiTUSf5OVypEa+c
	PwKu931kNpDEz0pk2R/E7lBH3MfmHbPmEC1ybo1hHMwPvBfypXirtZ8P
X-Gm-Gg: AR+sD11G7x9UWdBxSZEz/pfLjhqfGCuvctp1zHAouaCgHZEudt5jeV+zPfONQdBxHgz
	T5+ihmaWOhOf7kMi5D6d1tYI3gVpvo8xdtNEu/DXC39GVPqZ2M1eaT3EkcPD9f7WBLAVopmG0+8
	FE8nS5jeQkJMFFMIBtmujh25v9/YhwTzzBB6JtY9G9EBhfPyjYH8ITeNb43D3w4jRT5ywrokMiw
	0EXfbhlfgOADKYtFXEmdq3KF7/6/utK95QwbwavtpUmCofqarxnVtZYwUb0BTRSzp9URSLaUYnf
	MjXM/0VdOv1O4eR+YaIBJpcY/b9cSzYS2FB6ftqVV/5jLidcQGhyh2d/K3Qd+dxRLXd56Fy1U9r
	ZPzR78mqsBRnpzQyOg68OKW/AZor+DBWQqUSOYDzFaw0M8UuC/EtRl1vRL3OGx7GMnpWTgBi7DS
	ZtIUvEPt0Zs8fcoxIYjJ0RQnr21LIRv/owYuCk3ZUq0Yb3VaR8yxgqPZJD/QIJnJveZw7a6OHdk
	Aq3+tjpWW9O/BjznRsxt1bXgc7K
X-Received: by 2002:a5d:5449:0:b0:47f:5369:bba with SMTP id ffacd0b85a97d-48160782d05mr38208457f8f.15.1786985261898;
        Mon, 17 Aug 2026 09:47:41 -0700 (PDT)
Received: from [192.168.88.241] (89-24-57-65.nat.epc.tmcz.cz. [89.24.57.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b81715sm5288916f8f.35.2026.08.17.09.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 09:47:41 -0700 (PDT)
Message-ID: <140da5e6-15eb-45be-813f-ee5629b64ba1@ovn.org>
Date: Mon, 17 Aug 2026 18:47:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 3/3] net: skbuff: don't touch shared zerocopy state
 in skb_tx_error()
To: Norbert Szetei <norbert@doyensec.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 linux-kernel@vger.kernel.org, dev@openvswitch.org, i.maximets@ovn.org
References: <AD1B7BEE-C04C-4A1B-982C-8385F1908911@doyensec.com>
 <F34B6E46-6B01-4106-A1DF-1BB9E29320BB@doyensec.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <F34B6E46-6B01-4106-A1DF-1BB9E29320BB@doyensec.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/16/26 8:57 AM, Norbert Szetei wrote:
> skb_tx_error() completes the zerocopy uarg and clears
> SKBFL_ALL_ZEROCOPY, and skb_zcopy_downgrade_managed() clears
> SKBFL_MANAGED_FRAG_REFS. Both live in skb_shinfo(), which every clone
> shares, while the caller only owns the reference it is about to drop.
> Through a clone it tells the producer its pages are free and drops
> SKBFL_SHARED_FRAG for an skb that is still in flight.
> 
> Open vSwitch reaches this with a non-last OVS_ACTION_ATTR_RECIRC:
> clone_execute() sends a skb_clone() into ovs_dp_process_packet() while
> do_execute_actions() keeps forwarding the original, and skb_clone()
> does not privatise the frags here -- skb_orphan_frags() returns early
> on SKBFL_DONT_ORPHAN. A flow miss on the clone then strips the marker
> from the packet still being forwarded, and a later local ESP delivery
> decrypts in place over frags it does not own privately.
> 
> Skip it for a cloned skb. Nothing is lost: skb_release_data() clears
> the zerocopy state once the last reference to the shared data goes.
> 
> Fixes: 36d5fe6a0007 ("core, nfqueue, openvswitch: Orphan frags in skb_zerocopy and handle errors")

I think, this should be 25121173f7b1 ("skb: api to report errors for zero
copy skbs") instead.

Otherwise, LGTM.

Also, please, add all maintainers as per get_maintainers script into CC
while sending patches (may drop Zoltan though, since his email bounced,
as well as Pravin).

Note: there is a conflict between this set and the
  https://lore.kernel.org/r/20260814191336.187243-1-almasrymina@google.com
But I think, it's better if we apply the tx_error fixes first, as they
need to be backported further.

Best regards, Ilya Maximets.

> Fixes: f4c50a4034e6 ("xfrm: esp: avoid in-place decrypt on shared skb frags")
> Cc: stable@vger.kernel.org
> Suggested-by: Ilya Maximets <i.maximets@ovn.org>
> Signed-off-by: Norbert Szetei <norbert@doyensec.com>
> ---
>  net/core/skbuff.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index db62ed6e04b9..04776a112334 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1417,10 +1417,13 @@ EXPORT_SYMBOL(skb_dump);
>   *
>   *	Report xmit error if a device callback is tracking this skb.
>   *	skb must be freed afterwards.
> + *
> + *	Does nothing for a cloned skb: the zerocopy state lives in
> + *	skb_shinfo(), which the clones share.
>   */
>  void skb_tx_error(struct sk_buff *skb)
>  {
> -	if (skb) {
> +	if (skb && !skb_cloned(skb)) {
>  		skb_zcopy_downgrade_managed(skb);
>  		skb_zcopy_clear(skb, true);
>  	}

