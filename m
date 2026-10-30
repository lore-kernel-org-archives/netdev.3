Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793348559;
	b=Rh/DzXJXd5sxLd4adxLSG2s/Pegu2nL97WQrcmojGHAvnUzGM2n3RAHSlnb3a+GLPKYY
	 xXJPxZuHrp0W6m31ZvmBNeM+Too+/Jw43EsiVcFWlz6hwnwM/CDqQdGTGrAc+K1ohK5uy
	 oN9FROvA4EHNrAE+ZYWdfaSG0SukaF6MCVkCPcN13nq0FHbOygLovVbkJUkXp9wYuRj2/
	 b0H1YBQLW+Fl8QIH1y+6pyg6IwRKPje034Jk62UzTlva9mcMRgCAdtEBsvDeVUXWc0AUT
	 acF/gF3+qiedYU4PWFcKzKk9Ej33GS90d7eQLT0DOFbTWqssobpOxhp0lgQ+UkpAFAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793348559;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=v92GAJjZbomnBYNnJfUXzhExe9lvts+O0oV7sTd25Fc=;
	b=l4QFxXbL4uvkawgiZ7AMLwDILQvDMpL6CQYizazVUH3xIOcoS5dfZctBQt0HqNUXDJ04
	 3Hs4glhRaderT0QLyQSxMVJtxngQiKekCdMaERIK0gdZhsRmtIid1vlEuK/J/MjheYCUR
	 OIFEHmiU4jdmMNGru5K1SxxGMLTzHdHfm2DF7Px9U1OHwEY7MI+zRMnY6NktpzjEPgVG4
	 qcL3UekyyRb5HVXpLYzCTNGsZM5Glm0k73epb85weDuFTpd62GDUwusQ7Qr74yzrHc26F
	 RgJj9lFc8MKpJ7NwTcJQZ3xbvJtpdBqYVzuw1Kew+jn/vDSLIHWKk71wg7Ck/jMkZsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=CqKLbhic;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBA5606A322
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 08:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEBA5606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=CqKLbhic
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48df8fe8513so376207f8f.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 01:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1793348557; x=1793953357; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v92GAJjZbomnBYNnJfUXzhExe9lvts+O0oV7sTd25Fc=;
        b=CqKLbhicYDHaXCZRwL3p04ldrDIvLGZvyz8To7GnYLehyD1KBe48fJ5J8okkQuweg1
         xq6TRrsSXnOkToaOr5M/TaxfEX52N3jFJ3/F9ZxsiwGFa3lASuQPS+RkOhOKneDtbaLE
         LCAkvHRIkB4QtWolLc2RuHzeTOc+2fvGdY3mrfGFhEjQ3PvmMhoer40y+zfWC69lKhpp
         y/uYCkyabqWd9k82czHpVqvtlMy8lG78ScTRmaSpBDtZ79Vmr4Jc1P53PCkHIQVOc5ZB
         OFP9CoSCDKu+fmTvDfDeGOopMl6suY9bl6LBfyMPRG4InFqp/qAuPqwsF0DSYjBINDUs
         KFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793348557; x=1793953357;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v92GAJjZbomnBYNnJfUXzhExe9lvts+O0oV7sTd25Fc=;
        b=KgjPcf/gyKDIIchXfGxZNaE6fqci5UwuDlKK/qKk+heL5iYD/avoRGraBGgZhPQc6x
         MjPpGrXnf7xyKVGzoUGDMD+q6m7aDrx6QnskvFzc4yInQdU2jVek/abdkch9KHHXvI9G
         7rax7hwmRk5Y4d9H/QBeUSaLBrk+EIDq079YMFeNL8Nfr+aeFssoIWWPQVwaFSTyidG9
         LR4wq+1iYBN8WZ+nqv7GfXk43/ZMcaDNsgX/8Pt7bAwbGXrNWdvDlxBaSR3MOJJKNeDg
         2Dff2rDulna51MrBUKwKyExqMNCFFnOpkY+VkAaCeX/EDsYViFzx46kZaWzFNW7jJgPA
         QOog==
X-Forwarded-Encrypted: i=1; AKwUvBwEd/n8Ect7ZMM9+fJuStkrGXBdU+BK34mtvTMdcRHKzzRAUB7KTFYOduBqoVRBIQ01rCNgWEI=@vger.kernel.org
X-Gm-Message-State: AFq9FYI1F9fwEwTzjjLPh74olXK8IdSOd4v+Ddd1YTKh/KsNI/pFL2ts
	fXQXSPIy0u1CYJ4BwwfVfBTqJHZSKrHtEoKPLWah7wYZ8E8cQ1wIl+bYnb+d0HcoSis=
X-Gm-Gg: AYBFou0a7dnxi8gNdKXnV4prgH2HegylEtGGEybvQzKdn4LtcM1AorCbH73fFDCala6
	DPDu459tjiLZ3gzpMURwdOkV4kZp30R9c4WCM57dVHbX0njF2eH7pIlKs3uctptYXCrWygl8371
	ZeDsD8fE0ja24aCtSaszepRbvXHaZdd2LER7ZPQdvwqRr3je+7G+85zrjST18fh1KyE00M2pR6o
	d2WG6TqwiDJJltdUSbtvW612ccgDMZWEhpVBOl75rr/RIER6Cf480MOZvPzShqbhNIoxMWWAd7Q
	sMAVtsNDZdAYAhgdUH4+67+8asw1LLrJddh3bNjqkasBaxZed2LpdomegRF5tf33KZ+1dNAKFqp
	ERF9bIB4zkX+Swi9fTWrYRC3ElbG1fr8cSpxTB0xqwOSPNy9E7pbVVLvMAbcSTXxGIil9NgUcXb
	ksVaUG19kf4RM/isbChQgeBUaoqdBG89m4LMSlP9LbP/tq/xBxCp18YTC0O9NGJ4zoMdXqscQx3
	2EppzcDP6CGF/pXYdA5nQ7y+M1JG6hgxGSrruMBz4hVsOtnSA7EUy33PVfgm1OtWaHld/K2Pwt8
	OtFal7dBjrW/6RarP+tCJXOD4TfNgBKkGS2Csd9JYgy6eG7hJZUlj5dI83E=
X-Received: by 2002:a5d:5d09:0:b0:48e:64e2:4883 with SMTP id ffacd0b85a97d-48e6e2dbb76mr3748074f8f.8.1793348556634;
        Fri, 30 Oct 2026 01:22:36 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b80306sm2116937f8f.33.2026.10.30.01.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 01:22:36 -0700 (PDT)
Message-ID: <788c84fa-12a4-4282-9afc-438d3206f21c@blackwall.org>
Date: Fri, 30 Oct 2026 10:22:35 +0200
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
Subject: Re: [PATCH net] net: bridge: mcast: release the EHT host budget for
 zero-address hosts
Content-Language: en-US, bg
To: Cheng Yongkang <teel4res@gmail.com>, Ido Schimmel <idosch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <179328314076.648427.17991367257682028617@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <179328314076.648427.17991367257682028617@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/10/2026 16:12, Cheng Yongkang wrote:
> __eht_del_set_entry() decrements eht_host->num_entries only when the set
> entry's host address is non-zero.  A report sent from the unspecified
> source address 0.0.0.0 (or in6addr_any for MLDv2) creates an EHT host
> with h_addr == 0, while the set entries created for its sources have
> non-zero source addresses and are counted against PG_SRC_ENT_LIMIT.
> Deleting those sources never releases the host's budget; after 32 counted
> sources the host stays at num_entries == 32 and every later counted set
> entry is refused.  The same sequence with a non-zero report source
> releases the budget normally:
> 
>    host 0.0.0.0:  IS_EXC/ALLOW1/BLOCK/ALLOW2 = 32/0/32/32
>    host 10.9.9.9: IS_EXC/ALLOW1/BLOCK/ALLOW2 = 32/0/32/0
> 
> Only set entries created for a non-zero source address are counted:
> br_multicast_create_eht_set_entry() rejects a zero source when
> allow_zero_src is false, and __eht_lookup_create_set_entry() increments
> num_entries only for those entries.  The auto-created wildcard entry for
> a zero host uses allow_zero_src == true and is not counted.  Release the
> budget based on eht_set->src_addr instead of h_addr, so counted entries
> decrement for zero-address hosts as well.  The uncounted wildcard entry
> no longer decrements the counter, which also removes the converse
> mismatch for non-zero hosts.
> 
> Fixes: baa74d39ca39 ("net: bridge: multicast: add EHT source set handling functions")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
> ---
>   net/bridge/br_multicast_eht.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_multicast_eht.c b/net/bridge/br_multicast_eht.c
> index 18eaf9c..548ad78 100644
> --- a/net/bridge/br_multicast_eht.c
> +++ b/net/bridge/br_multicast_eht.c
> @@ -167,7 +167,14 @@ static void __eht_del_set_entry(struct net_bridge_group_eht_set_entry *set_h)
>   	RB_CLEAR_NODE(&set_h->rb_node);
>   	hlist_del_init(&set_h->host_list);
>   	memset(&zero_addr, 0, sizeof(zero_addr));
> -	if (memcmp(&set_h->h_addr, &zero_addr, sizeof(zero_addr)))
> +	/* Only set entries created for a non-zero source address are counted
> +	 * towards the host's budget, the auto-created zero source entry is
> +	 * not (see __eht_lookup_create_set_entry()).  Check the set's source
> +	 * address and not the host address: the host address can be zero as
> +	 * well (IGMPv3/MLDv2 allow an unspecified report source address), but
> +	 * its real source entries are still counted.
> +	 */
> +	if (memcmp(&set_h->eht_set->src_addr, &zero_addr, sizeof(zero_addr)))
>   		eht_host->num_entries--;
>   	hlist_add_head(&set_h->mcast_gc.gc_node, &set_h->br->mcast_gc_list);
>   	queue_work(system_long_wq, &set_h->br->mcast_gc_work);

I don't think this is a -net fix, it can target net-next when it opens up.
You can also trim the comment, it is way too verbose for something so simple.

Thanks,
  Nik

