Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E29B468C17
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 08:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791793334; cv=none; b=I+GNQR0CPaT4XAKVSKiRmGdGZ7hkllZjDmXLQby3H8bD+hVIR4Cj6LVhwQgnxbRAuuP8JwgjPAF/aPfyZ8Oc8wie8uWDG4csvhRINdgd8S4Q51LHYq8we2wuURsloQBn9T3PoU2krUH6n4ZznnKSUQl/dmPDPNufnIr8w6dnuEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791793334; c=relaxed/simple;
	bh=pxqj4vb26qRQbTwEtqKMpwTDAf2VJ1Jzrlr14ROJJwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O9mFhrOI/jgFh3TYofVzIPEDvSMmU2YERD/wZDXu7mWaMVMF6eiKi74EAr9yEAP0Rg8OgtiUoN9uSklZGpj5MPlnB792TA3JcknoBAPfj+gkJdAcKrqQQ/+pHQLseEXSSFLbxUhy2rfQweA/o25ZJAS3YnZ26xNutOXDEx4xZU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DgWUgJj8; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgWUgJj8"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc1cf287ef8so822378a12.3
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 01:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791793331; x=1792398131; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZeC1vCLAHQXkjdrTc1Ww/Oh06R8l8PMmIUf/8Ju6fGU=;
        b=DgWUgJj8il1chCRbWCs613rKAbc+Ll4O51VR8pYqLmHXfkwReZyH2fyjTihyBdtIhf
         dGGx9K5Oxfw9pf2jObvJ0htKdg/D3cbbuxv1KSxaa1W40KAhIarWjuYzta/LeWt8lxLn
         IgDdV+c81da/o2q/EI8KzqmuFMqBoHw1BKt1nG23rY7FjqtXpNAUju9eqkAs9cQXvOsn
         qkzOC4q5iOGFJ9b+K55xZGUHefPA7iBl0wUr4ecOfVzqYfBnBt6UNK3Lyu/hliopKRir
         7MrJpitkhg2NlLry2zZT46SSRv8dkKZ1Q4cgD3AZm7vQQFqji+FYi9o7NPzS9mcorbo4
         XTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791793331; x=1792398131;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZeC1vCLAHQXkjdrTc1Ww/Oh06R8l8PMmIUf/8Ju6fGU=;
        b=VOjGBHN+ym1qrxG0JLoTDL7mPFk+oGYTwt9vg7xtEYR/AZVOzFzY3P4Qms20B5ZSoZ
         3OxzbK9wI8mywQTwI4KNzDp/bDcGUcnK1oWl4qIM1O1QSq1UxSYCTA5fVl3Fob9qyuog
         xF6bt30S78o5saPjpILD3lCaozfYLGYa1VWc8uxQ7EoPy7b9wqfWhKhiU139noKnpTL1
         hM0Nd5BD9kRq29gBY9oC7l+fTe6Ts6v3bF6VZxAJaKUA/TWHgRf19Fx+9s36R/p13I7O
         KoRaicT37vnypB3jlfAb1J1td2QeaeIl1mKFzdAuJUo3awJ7jXlYREgIucK3ANRp8Ys3
         EZOw==
X-Forwarded-Encrypted: i=1; AKwUvBwpzpeEPuX839kbiLfoCMvT1isBNjaHCnQaMWo/EHjV6sWt9Y4ulilPu/7Nfc/Ot+mhpW/HbA8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ1k+zuxfCDbsw6sk68/vaVORerBD+G57apQL0aQPM5oa5RDXgr
	k4IE/WR2FwkEwG9GkqFUCqOfVoH7vrj4s4KfuXQiQ1t/njMWF4epqDzQ
X-Gm-Gg: AYBFou1UCGNJX4f11e9jIbca69BNWO79KyNpZZm6N/Z/qtBrWbG+Jz7F9MXDBFlzPOM
	yscd6iHYEnEEB32ksvvnFCymf1hjGsOld+vu7C5kZdM4+LApje6enkcLCPV3+3CSF8VZmzBWjZ6
	BJV63y1xohNNUnBMJdHkFlp0Ve4rBywnKf1cpcoyVd4jV3/uEbeX7hZE2CknZ243iTBdBIUEr4L
	XKPt6heC7giMV5AucbYahrPmgIiZb5JeGVnb0r/q0IJ8Lqlpe8Qp4r8Th+Gp92QHO2b++vrwhB9
	1gq7hcihbT435uimv3FWeFC9uaYHD0zvZBxZc1iRVH/z9FC9Mg18YtBKHwDujST9kwOl8qqc0aq
	8cBVlBhM4F11Hxm93QoljW53mh109qf5j2+jRYDxOoFX+kdU0s3o68Lpm1X+sHZrSuF0+oF64fq
	JswppxYmQt3gRHiB7tx2Lq6ytgdQZCkWVxqvuGFTaOGfxu3VVQ0lgCoPe6YA9FLneZ7BqgzDlAJ
	Nuqc4/KVXwpsRNMqzoNG4d4O9e4n4xY3bytq0LEHtI4gZY=
X-Received: by 2002:a17:90b:390a:b0:3a0:9aa4:f9bf with SMTP id 98e67ed59e1d1-3ab3a7369d6mr8456387a91.12.1791793330853;
        Mon, 12 Oct 2026 01:22:10 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21e8::1189? ([2620:10d:c090:400::5:b3cd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed040dsm19102948a91.6.2026.10.12.01.22.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 01:22:09 -0700 (PDT)
Message-ID: <36768a07-1dfd-4a80-9aa0-423a324b5839@gmail.com>
Date: Mon, 12 Oct 2026 01:22:07 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/5] eth: fbnic: validate the Rx completion offset
 and length
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
 Alexander Duyck <alexanderduyck@fb.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
Cc: kernel-team@meta.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Dimitri Daskalakis <daskald@meta.com>,
 Bobby Eshleman <bobbyeshleman@meta.com>,
 Daniel Zahka <daniel.zahka@gmail.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1791775409.git.yhlee@isslab.korea.ac.kr>
 <5b7c2618b56d35f50b6847d565a0050cf2a7f371.1791775409.git.yhlee@isslab.korea.ac.kr>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <5b7c2618b56d35f50b6847d565a0050cf2a7f371.1791775409.git.yhlee@isslab.korea.ac.kr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/11/26 9:15 PM, Yehyeong Lee wrote:
> fbnic_pkt_prepare() and fbnic_add_rx_frag() take the offset and length
> from the completion descriptor (FBNIC_RCD_AL_BUFF_OFF_MASK and _LEN_MASK)
> and use them to place data in the fragment page without checking them. A
> device that reports an offset below the reserved headroom, or a length
> that runs past the 4K fragment, produces a negative headroom and a frame
> that extends beyond the page, which is then read out past the page into
> adjacent memory.
> 
> Reject a header whose offset is below FBNIC_RX_HROOM or whose offset plus
> length exceeds the fragment, and a payload whose offset plus length
> exceeds the fragment, via the drop path. Clamp the derived frame end and
> truesize to the fragment so a FIN descriptor cannot push them past the
> page. A maximum-size header (offset 192, length 3584) stays inside the
> fragment and is still accepted.
> 
>    BUG: unable to handle page fault for address: ffffed1021a8ee10
>    #PF: supervisor read access in kernel mode
>    #PF: error_code(0x0000) - not-present page
>    Oops: Oops: 0000 [#1] SMP KASAN NOPTI
>    RIP: 0010:kasan_check_range+0x15e/0x1b0
>    Call Trace:
>     <TASK>
>     __asan_memset+0x23/0x50
>     __build_skb_around+0x222/0x320
>     napi_build_skb+0x50/0x1e0
>     xdp_build_skb_from_buff+0xda/0x8b0
>     fbnic_run_xdp+0x29a/0x1040 [fbnic]
> 
> An offset and length that keep the frame inside the page but past the
> valid data produce no splat: the read lands in adjacent page_pool memory,
> which carries no KASAN redzone, and is copied into the skb silently.
> 
> Fixes: a29b8eb6e533 ("eth: fbnic: Add basic Rx handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
> ---
>   drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 41 ++++++++++++++++++--
>   1 file changed, 38 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> index 305fe6d2f511f..7dda59bba14ee 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> @@ -1037,13 +1037,34 @@ static void fbnic_pkt_prepare(struct fbnic_napi_vector *nv, u64 rcd,
>   		return;
>   	}
>   
> -	page = fbnic_page_pool_get_head(qt, hdr_pg_idx);
> +	/* The completion describes one frame inside the one
> +	 * FBNIC_BD_FRAG_SIZE fragment it names.  fbnic_hdr_pg_start() takes
> +	 * the headroom back out of the offset, so an offset below the
> +	 * headroom underflows it, and the frame data runs to
> +	 * hdr_pg_off + len, which has to stay inside the fragment.
> +	 */
> +	if (unlikely(hdr_pg_off < FBNIC_RX_HROOM ||
> +		     hdr_pg_off + len > FBNIC_BD_FRAG_SIZE)) {
> +		pkt->add_frag_failed = true;
> +		return;
> +	}
>   
>   	/* Short-cut the end calculation if we know page is fully consumed */
>   	hdr_pg_end = FIELD_GET(FBNIC_RCD_AL_PAGE_FIN, rcd) ?
>   		     FBNIC_BD_FRAG_SIZE : fbnic_hdr_pg_end(hdr_pg_off, len);
>   	hdr_pg_start = fbnic_hdr_pg_start(hdr_pg_off);
>   
> +	/* fbnic_hdr_pg_end() rounds the frame up to where the next header
> +	 * would start, which can be past the end of the fragment when this
> +	 * frame is the last one in it.  napi_build_skb() puts the shared
> +	 * info at the end of the frame, so hold the frame inside the
> +	 * fragment, which is what the FBNIC_RCD_AL_PAGE_FIN case above
> +	 * already does.
> +	 */
> +	hdr_pg_end = min(hdr_pg_end, FBNIC_BD_FRAG_SIZE);
> +
> +	page = fbnic_page_pool_get_head(qt, hdr_pg_idx);
> +
>   	headroom = hdr_pg_off - hdr_pg_start + FBNIC_RX_PAD;
>   	frame_sz = hdr_pg_end - hdr_pg_start;
>   	xdp_init_buff(&pkt->buff, frame_sz, &qt->xdp_rxq);
> @@ -1091,11 +1112,25 @@ static void fbnic_add_rx_frag(struct fbnic_napi_vector *nv, u64 rcd,
>   		return;
>   	}
>   
> -	netmem = fbnic_page_pool_get_data(qt, pg_idx);
> -
>   	truesize = FIELD_GET(FBNIC_RCD_AL_PAGE_FIN, rcd) ?
>   		   FBNIC_BD_FRAG_SIZE - pg_off : ALIGN(len, 128);
>   
> +	/* The data has to stay inside the FBNIC_BD_FRAG_SIZE fragment the
> +	 * completion names.
> +	 */
> +	if (unlikely(pg_off + len > FBNIC_BD_FRAG_SIZE)) {
> +		pkt->add_frag_failed = true;
> +		return;
> +	}
> +
> +	/* ALIGN() can round the charged size past the end of the fragment
> +	 * when this is the last fragment in it, so hold it inside, which is
> +	 * what the FBNIC_RCD_AL_PAGE_FIN case above already does.
> +	 */
> +	truesize = min(truesize, FBNIC_BD_FRAG_SIZE - pg_off);
> +
> +	netmem = fbnic_page_pool_get_data(qt, pg_idx);
> +
>   	pg_off += (FBNIC_RCD_AL_BUFF_FRAG_MASK & rcd) *
>   		  FBNIC_BD_FRAG_SIZE;
>   

The offset field is 12 bits, but that alone does not bound offset + 
length. The relevant guarantee comes from the device’s placement 
behavior. The driver configures RX_HROOM, RX_TROOM, and the max header 
length, and the receive path expects the device to honor those 
constraints. This patch assumes that the device violates those 
programmed placement constraints. I doubt this can happen on real 
healthy HW.
