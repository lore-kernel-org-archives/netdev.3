Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404753D4126
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 12:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786363883; cv=none; b=rfokRNaBTXhs+4U+t8LNrJii3tnDT9xOfu9EVtP+59nncYijy1bOjrX9i25CcCKOqkFhcOQYcp8fjW7q+FtQCMhIqtu2AtPZK3yHDiPfRthOJAKxThBtZ6OAiNKOMG1oTDl9ogkA+/J3qmxG3GXvrGojtvbioYcGnmkHO6eURow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786363883; c=relaxed/simple;
	bh=1f2i6W0vyHl79CUHTsi6bEFRN5mv8GDVDw+FXRd6Vv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rzbSDEeLZchwDJSyCaXclkQhED9MYL0cLyG6uITIK2xf1hpBFs5joDDWBTGep12OAKvsbDjjkcpGfPNZPaj3UfJejNjm2KbYKhUAke7kg7ETG2Pvvg4Tkmf7tyFk/oFbwpMiAMueMd0Qv641HiCFQuKX3tAeNdZHeLZqwCXQACw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwMbNZRE; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwMbNZRE"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c2022323c37so232368666b.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 05:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786363879; x=1786968679; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Dx+uV5z3Gz7QSpQU4UjHouuce9bSyjAkH9OsOZse78=;
        b=kwMbNZREL8O+pjH9b7f2RLTpoJrLyA42tSpfyMgxQawpr99IOBM4eSTN3SyS1zQJ0i
         tqEGc66XVoIS9zE9jYzn92m7KlqZ58eM5fanCNXWflKiAAt9OxWO+WOLFeauh0cHPYKg
         WgCP9ixc78iLwgsKt/HB7mUiplm/FhFFU7/8H+bP7m+fbIki0IAHl0jw0SJAQxATx4Ul
         tFHzuJ1d+/fpKn29EzZaihQ4OmBbsVYhK1d2FH9hvLEIdW7kmJhHfdUMnRiZRngxeJCb
         pHiedIQErVvCks27q6GrjJ85SXVvi7FmanR+bDsljjTc3QXdaO90bfS+dmUyEJ3EumXX
         Yqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786363879; x=1786968679;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Dx+uV5z3Gz7QSpQU4UjHouuce9bSyjAkH9OsOZse78=;
        b=VKKpOm5XadjfY0DutFm/UTGLeWS/YHQqsbg2hVEe8BdscDsS11p8omzYctrj/tYLrb
         Ko+KPMOYyzFsKVma4xtp7u5BeDriAtJgIpLTvgSslPZnHlEFr8r1KOT+zXKmQKh5pVaG
         0gukys/FuHrSoj27HRDj0dv2kaKpEPYqb4GckbX56PNgjJe3p/rzPFT7XjFHKh1YZbwa
         FQovEgLRLaKsJWf4ja/WLsTlLxBMxdmC7bZhlcG6X2qteXhhsZdX2DX8sx7G232/YqwS
         yUEJY5Mce9BD7Oeh6hagVQsKmiscJxN5aIp5C5LoOd1/1AS0LMGURmKcnEOMRItkrNHc
         IaHQ==
X-Forwarded-Encrypted: i=1; AHgh+RozZry1P4L3ooQQxzTr1I/WmnXXDtlbp7qJnT7/FaeXF2Cwn+oJmyTkcNquhEETYPDWLNFOnC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpFIwoGr09Hi6GtJaUrxm1rmZAwx8xQVYWGsHitbPdf+S2eEj5
	K61So0x0t6cH6+PaLaPXjKuCX2anERkC1t87R3E562ckSdj/XiqN06pJ
X-Gm-Gg: AR+sD10XgBnqxUWN0EXe3ZuA0+VrkzAsiqV3NaMsyJgfSps6nFYxj+d3AXEIRaGllWs
	y+KcWCxsdG06QwT6H7Lm5K7L3YbJPJBxivIjTiYwKIOJNJDRdtSIibbRheZhEn2pHABVW4SOC/6
	plek0wlauVNCX4O4FzfEjymY83xEUljqqmdQPEbnPmuBvMqavi7AYYEdALNNnOgpCQeT3sYSbtE
	wWKRWMCLeWKtTO/PXsZXPrN1k1270tc9CxELVc57ZQpaSiW+O0ABP5cgsFt97U1fHdQXNgQESgo
	lc6c+XyRSgN1FodXSfTADObwROZTn6VMCVZwnEYaGcPFdfH6sL4ElW8BTXJnBSm7dcDTzsFwGBu
	G21eMj9Pu6+8aQv3AB6bm7ezXl2EPRmpksV6NF8LfiwbWzzlQnyi5BhzdjSX4Mw3RkKlkxMtnfu
	BGJpQ6fAPNrs0T8qGjbHAUmuIQmciizfgsH7xUSwl7r6amaAecIXtKr2fmizs=
X-Received: by 2002:a17:907:3f96:b0:c1f:9cdb:9965 with SMTP id a640c23a62f3a-c20731a96c5mr1422487966b.2.1786363878945;
        Mon, 10 Aug 2026 05:11:18 -0700 (PDT)
Received: from localhost ([45.10.155.15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080c90eb4sm369219966b.35.2026.08.10.05.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 05:11:18 -0700 (PDT)
Message-ID: <9e741e85-76ff-4625-85b0-62ee679aa2b0@gmail.com>
Date: Mon, 10 Aug 2026 14:11:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH net-next] net: gro: coalesce padded small IPv4 TCP
 segments
To: Glenn Judd <gmj@meta.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Kees Cook <kees@kernel.org>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, linux-kernel@vger.kernel.org
References: <20260731185431.2777685-1-gmj@meta.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <20260731185431.2777685-1-gmj@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Glenn Judd wrote:
> Software GRO fails to coalesce small IPv4/TCP segment that was
> padded up to the 60-byte minimum Ethernet frame.
> 
> The selftest tools/testing/selftests/drivers/net/hw/gro.py subtest
> sw_ipv4_data_lrg_1byte sends {100, 1} expecting to receive {101}.
> In current code, it receives {100, 1} (no coalescing) instead.
> 
> Cause: inet_gro_receive() computes its flush term from
> tot_len ^ skb_gro_len() before skb_gro_pull(), while skb_gro_len()
> still includes trailing Ethernet padding. A small IPv4/TCP segment
> padded up to the 60-byte minimum frame has tot_len != skb_gro_len(),
> so flush is set and the runt never coalesces.
> 
> Assisted-by: Claude:claude-opus-4-8
> Assisted-by: Codex:gpt-5.6
> Assisted-by: Meta:internal-AI-tooling
> Signed-off-by: Glenn Judd <gmj@meta.com>
> ---
> 
> Notes:
>     RFC notes
>     ---------
>     Per Jakub Kicinski, the open question is fast-path cost: this adds two
>     operations to the common IPv4 GRO path for every packet -- reading
>     iph->tot_len and the skb_gro_len() comparison.  Everything expensive
>     (linear check, trim, pointer refresh, csum recompute) is behind unlikely()
>     on the slow path.  Is that per-packet cost worth the coalescing win for
>     padded runts?
>     
>     Testing: netdevsim cannot reproduce this -- it never pads short frames to
>     ETH_ZLEN -- so sw_ipv4_data_lrg_1byte passes trivially there.  Reproduced
>     and fixed on a real NIC (cx7): baseline FAIL -> patched PASS.  Also
>     validated locally under KASAN + CONFIG_FAIL_SKB_REALLOC (no UAF).
> 
>  net/ipv4/af_inet.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index 32d006c1a8ee..998ff77fd7b9 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -1470,6 +1470,7 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
>  	const struct net_offload *ops;
>  	struct sk_buff *pp = NULL;
>  	const struct iphdr *iph;
> +	unsigned int tot_len;
>  	struct sk_buff *p;
>  	unsigned int hlen;
>  	unsigned int off;
> @@ -1498,6 +1499,25 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
>  		goto out;
>  
>  	NAPI_GRO_CB(skb)->proto = proto;
> +
> +	tot_len = ntohs(iph->tot_len);
> +	if (unlikely(skb_gro_len(skb) > tot_len)) {
> +		if (!skb_is_nonlinear(skb)) {
> +			if (tot_len < sizeof(*iph) ||
> +			    pskb_trim_rcsum(skb, off + tot_len))
> +				goto out;
> +
> +			NAPI_GRO_CB(skb)->frag0 = skb->data;
> +			NAPI_GRO_CB(skb)->frag0_len = skb->len;
> +			iph = skb_gro_header(skb, hlen, off);
> +			if (unlikely(!iph))
> +				goto out;
> +			if (skb->ip_summed == CHECKSUM_COMPLETE)
> +				NAPI_GRO_CB(skb)->csum =
> +					skb_checksum(skb, off, tot_len, 0);
> +		}
> +	}
> +
>  	flush = (u16)((ntohl(*(__be32 *)iph) ^ skb_gro_len(skb)) | (ntohl(*(__be32 *)&iph->id) & ~IP_DF));
>  
>  	list_for_each_entry(p, head, list) {
> 
> base-commit: 2fbade66245059c78daeaccfce13ecf499fffb51

To address Jakub's question on the fast-path cost: I benchmarked GRO
forwarding with two-minute long iperf sessions using 1, 2 and 4 TCP streams
(17 runs per configuration) and CPU frequency scaling disabled. I also
disabled RSS during the benchmarks because it caused a lot of noise - up to
20% variance in the deltas.

| streams | baseline (Gbit/s)  | patched (Gbit/s)  | delta  |
|---------|--------------------|-------------------|--------|
|    1    | 14.083 ± 1.01      | 14.065 ± 0.67     | −0.13% |
|    2    | 13.891 ± 0.75      | 13.926 ± 0.78     | +0.25% |
|    4    | 13.008 ± 1.26      | 13.029 ± 0.97     | +0.16% |

The two added fast-path operations (iph->tot_len read + the skb_gro_len()
comparison on every IPv4 GRO packet) produce no measurable throughput
change. The deltas are all well under the 95% confidence interval and
indistinguishable from noise.
