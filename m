Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47683B0AED
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 15:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787068791; cv=none; b=Ej3W3Nb4NpG/cSpqy3gXCZe2a1d2bD/r9IFT1fYtUHYL7/F9B1CEvhIcx5ncetyVkN559GaPG2gdqsvZKAzOmLpkd+dJ1ostIUNPasMVDKdfeOZECZ4qYHUkMnS0HRls+MnyLy666BZR6Mm6uTZGqD0CBUIY5FP7W0mK6HRXcIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787068791; c=relaxed/simple;
	bh=hvuCW95s33siILs/CVN9p4627QXM9JmkttgCJM5H2NE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KVVGzP5P/7Kk0I8MNt62qrgswF6GEW64oLsJZX9+QWXOOur6IjeQzSiuIcrn6pjBBRke2EoZrsSkDD0OtoK7dP+YmGkPuZR19nXXkJczt0WUmFyTrRpoqe4T4sgRx1e+ncOQmZ5agigLgLXpg38NFYe7XTfe9qoQYDvtdyQ7/XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-49987f48039so19225e9.0
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 08:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787068788; x=1787673588;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EnTdzJJz2xsLCJb7P5F5dc7DwJ8XdTra2UxydiqtqvU=;
        b=KtZIk7ITcKhxYtENCEnnTk1yGZ4nwGDwjYqpP7kyecMuElh7OFA0CMLaIBxCJOwhm/
         wksGX4Gs5zIt4y5KgCoKaKQVeZm/KP5ORnh9YVkBC1/TmQoeOgLY4HY41UnuXrGKSDTl
         tfvhItQWLritIBgWHk8JiSxYJET33S7qDeZhTBdEgMQAM6jw/f75GBvkyr7LXjlXms5v
         kzmzB/Qq3aFAOluUf7xtyee4bFb7LGsOXVaJZQWOv4LG3xlvICz5Bk6ScjUh3zu8Sdvd
         kmvOBBFgmV1SgkQFRlqxUKDQ4TK4Q95whNdxZmfmgyUTJmjYcdsc3+BoLLTZ+Qm+n/L1
         w0fQ==
X-Forwarded-Encrypted: i=1; AHgh+Rom56vpUQMg1h5VlGbQX/KCUo0DZsHPPuDO3mDDOFLeS3hhkF9NoWfzlC0bJ5Fi6ZdI5/NbFxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlhB4wgUNRI4EcSmokP7Bxqj0QgGHDoZg/5iDfS2FmNCzkQaVa
	dSyVti5kzwWRscQC9M06bg1tFj1nJPgR5lGjKxKZMPLgC0cdGD2wMeeY
X-Gm-Gg: AR+sD12TFqDA49a6DnOQDfi1UkGmfOuJnKB34K8XigrGCDU9dnOTvjyb1B+ZqtoOmLd
	iQzk97QR9LXVfVA0xF0uEIq4fHB/yYgPnpVlzb5xKOj+uNe0j/8wIaFSo0JJ5W2qZDPlUfXrmRe
	2zBKTz5DScZApLOgZfVslSef3I2V6aqF3z0rVv9nEwy6QInq+JqhGbZZoroiPsr6FOaDeUEJf90
	VWvQoLrUtlIM90TxuNyfPir3GX3NPRe00RK39EJ9WzsW2c2/PDBfkOLwjYoU914Cz1Qom5NjStI
	1i3FcZO1QsxHcl1F0b0DEtAwJTtufk5N3rhwgELeCxA4XfIX7smyohnNyOjal0Rep6PHUwF06Pg
	qkpia/EXH8zUyGJhc45ql0BMOQ4wff/EuYhyKP8W33oQ4otf8OhSo81qs4YVQMkON3DUhqsslCk
	N9/URhc76K5gAqhBRWCv//7lyGTc0Eg6AzmjyWhyTAR2wy8xm++u98bYkbJLbroDA4dZiw7aDFA
	o7CIAXbTQpFL3Ix
X-Received: by 2002:a05:600c:5306:b0:498:952:e276 with SMTP id 5b1f17b1804b1-4999fafdb79mr194470395e9.8.1787068787650;
        Tue, 18 Aug 2026 08:59:47 -0700 (PDT)
Received: from [192.168.88.241] (89-24-57-65.nat.epc.tmcz.cz. [89.24.57.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b816c0sm13166269f8f.33.2026.08.18.08.59.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 08:59:44 -0700 (PDT)
Message-ID: <8f4f467c-3d4f-4dcc-aea7-0ae3cb13f592@ovn.org>
Date: Tue, 18 Aug 2026 17:59:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 3/3] net: skbuff: don't touch shared zerocopy state
 in skb_tx_error()
To: Norbert Szetei <norbert@doyensec.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Kuan-Ting Chen <h3xrabbit@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, dev@openvswitch.org,
 Jongmin Jang <payload.jang@gmail.com>
References: <F3B9E5BA-0AC1-4AD1-A7D9-F38033304270@doyensec.com>
 <45B00A1C-A331-4982-8317-592EEA59426A@doyensec.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <45B00A1C-A331-4982-8317-592EEA59426A@doyensec.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/26 10:47 AM, Norbert Szetei wrote:
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
> Fixes: 25121173f7b1 ("skb: api to report errors for zero copy skbs")
> Cc: stable@vger.kernel.org
> Suggested-by: Ilya Maximets <i.maximets@ovn.org>
> Signed-off-by: Norbert Szetei <norbert@doyensec.com>
> Tested-by: Jongmin Jang <payload.jang@gmail.com>
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

Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
