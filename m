Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792490265;
	b=GFjZlFkZHuCBKbizELF0GUfxgx40Ddt3LaF7CIxRmwig3fdHRvStM3Hi7TKtnsUTsWny
	 P2uDOs+mwTPvh+3Nmvw2JHQGPMTT2IJo9k/+ZA9vdFaO2OuLMkfCSR3YZgAnkRdcxrBHC
	 TlRijCoC8cko2WxO/rFH/N+l81jZ5WVS9HvSGzUi5h3aFh+Za1zUkwUsvEQeAkR0Wzys2
	 ZaHmBfePIqUi+BdS278GiJnivlgT7R/lhEVEIF3r2fpOq0jNlH/DJXZ4kKN0969/y9FBN
	 l7ZPO5wSozOgO/SY9XiYd1BvSaGXUCSENmDtqij6IJYsfrLt87v6TtfUduK/b2OP+fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792490265;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=sk5zqDuO/886xKvBK0bOlHGOFGA2QdOAk3///v5lZEI=;
	b=jf5FMywI1X+zb981h8nMqYd4f3hjOPJCDJf9olJ7rLLBV5MPTc/Qm5sHzbtRrEpC6tv9
	 BxWSbXSD7VcYTAB51hgk0ztWV/tnJ1GYzynhXAtPDBd2rerzsT+/44DbEG8YXrw8obFKX
	 Ll8Qn7yiLra1fW9jTtp1ImLxUgr+BOAAp08lqtKiTc3dignXrqzqWHrDt2RDPbao9N5c4
	 9fGox+Ou7hzifcmfMAJUN8MNCcnm2fS003FmtG8vmy8ZdJW8WDDVEJhXCNpgzzZNc3BY8
	 ZrJ4o6e0doiVdJcBBgQwPTkfLqSsivGd7b4Dxj+RwwP9MmQ6h1Gq/H8G6/9leOS4HuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=queasysnail.net;
	spf=pass smtp.mailfrom=queasysnail.net;
	dkim=pass header.d=queasysnail.net header.i=@queasysnail.net header.a=rsa-sha256 header.s=fm3 header.b=hc+NYf11;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=OyahdoOh;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C79606A31D
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 09:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19C79606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=queasysnail.net header.i=@queasysnail.net header.a=rsa-sha256 header.s=fm3 header.b=hc+NYf11;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=OyahdoOh
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F19C0140009C
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 05:57:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 20 Oct 2026 05:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1792490262; x=
	1792576662; bh=sk5zqDuO/886xKvBK0bOlHGOFGA2QdOAk3///v5lZEI=; b=h
	c+NYf11KhFIpfF+mGajQBa3FhWo1fnmThAtXOXPhMxISMD5qaM1I4CGDkbSM+F/R
	vVRVjKc5WCSSTrcCXgbWWwW7H6WJ7Iow83/kTUcOsN8fvX3X0h2Vaij37g6pIOWi
	25vF5SRUJQbR+GSMHD34OaMFZkpNqOUwo8RFgpkXX+uNwImARv2HhGmupj/uWZ2D
	iSqsympkX1pmkYspLrzrt80+mHFY+XGbWAMrGZ5VSvtN3KvSK69cSVBmJpQYmLI5
	qsrhA8/4q3XKup8r3Ukuii5xCHtT8hKtOF3/La9J5MuldbZV4Zj01Y4vy+FhoP/P
	aNv2EwaBaf+k3te0e/YZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792490262; x=1792576662; bh=sk5zqDuO/886xKvBK0bOlHGOFGA2QdOAk3/
	//v5lZEI=; b=OyahdoOh361mUaZd+KmRNgKn3zebB/UyYuXNnxPg+/rwOKBv8Uq
	9aak+/5aze1hXgHmTAM03EM4Yq3ns7Rj8AK4Kcj5yhomVAuI/xi6UocTiXoP3/w5
	2uT8CDUom89gdosm5cg9xhLlsm//4yPv6PF8sa3B/e0zBPl8rgH9inEQM9cQUs+2
	AUxPIx3URc7ylMvEjAULsjaUUYyqIE9AQRkYVrdDUBlIty4ZI4aWog7CoSzobLth
	sAlVdTPfYfrVtM1cCEy+nm+loSpaWHbM2cCA6y4Bk44Cv+uhbNqd4SfQCspe8puU
	bM3LuGUKX2bROeWlmGnhlZnFYyEKIgvkBZA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=queasysnail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792490262; d=queasysnail.net;
	mf=PHNkQHF1ZWFzeXNuYWlsLm5ldD4=;
	rt=PG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:YbQOeBrfLuVzwwZn6J628xml5jcqchViq8Mz7VytfYZt1LC
	ORfcaxhx23JlA/lxzS4oqkrjkti8+FlMLBzXdIRQ54eFDkrzLjhguIfh5tueDfwv
	wXtn9DffSNfhSjepnnZeNYcdxlBWbtfec+ngnZRBvOhtaHbtMc12A3w+swpFAix2
	b0E3ZZejU/HLFNWhNXWgc9R5Qg1zUyH9RZsDE+mmysROTY9+PkGMSnkUT9v9OpfU
	afhBKM+o8FkE+22UwshNeXJ3rrISHmD64g4xzxH3u1g+5E4hXGwicwfy50XqjMK5
	Lm75xQUGgUjp6wM41o6xUF0VSCMcTeZUMaeUAiw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:wAccnLeUv/eLIzZZQ8ugHZD3f78GU5aMyodQh7op0Ww=:C4BX5qVjVg5d85mFp7lp0aa51VgILrK3fZke8IYEA+s=;
X-ME-Sender: <xms:FjvXaiJHeYk_DyO18OW6aLQA13qybfG0UaaLHljEuPXbnnizlnmjZw>
    <xme:FjvXahKWEvEf2K516VOiHvgkqPJqvv1dL4mZwAgZpmTKD0WmPg15IGujlPksqUY8I
    U8bbEvPxxYCFt26T8w8EsOriijPqkqVKD8UxWcYtKaKAC8yrUn-Gs29>
X-ME-Received: <xmr:FjvXansfQLpWJq2TXYqAsVhGzOb4ZEwYWMSzXG_C9LKTFm92YfIxAyuNSpc>
X-ME-Proxy-Cause: dmFkZTGMP3dhz09T1WT3NDN1WikVzTYcyqiiN8y2XMnVSoQG2EjIVUjlIHajZUbIeAiLM8
    uVKxYb5JAAW/TG8Q2u5B/IMfOznEmtdD4/S2eUatRE3WkFbSQv5O72JYWHHWADB6hIRiXX
    VEDh6oaxOYKVS4nLKBdcCK/HpMnPmrqPUi8Ip29Db5KfhQXmWKqbYcMFAJn8kGAsuR7F9c
    WVnAk/mzRafIcrAOjEGB4EbJKqlUjM+3aAbKcLZjlgnBKl0pCNjTNtCJOhfLlkt7RgUDnw
    j4PWWAfxELLUD2ToN/hY42+PTQedlW14eS6ngA0R2WS2c1bGJQAV0/WzoDT2//TJmGZZsG
    k7GkdPT/YMu4pFAW5FwS0DwoaUTLAInZbGe1OcuUyF/5yp8kBejm2UpwqihCC7afndgyto
    RrprDPm1yCli84LMDtixkdZgHkG5ZmLkFXkwz7ByoR9rfumvvXMsJDp4Efz/NfBJT8WfsR
    1fnEeSVibQZC0HpjSvfbXFqXlUc1u9LMmswBueXRNr2s48lA7Pnzn5vPHIfjldzvEDxRRc
    xIl0OcoeT+iB5VeX6aEIxoxEi3yGTX8T9avsB5HyHvrTr/cbFubCRrf1R7SfdDQl60bBGS
    ocClepBVESXOoVPqO5kDiRtSjVwz+dOWxRXNvZcMsmizPqTlOd4YSiHIrEyw
X-ME-Proxy: <xmx:FjvXamT3GXJv5O2mjpLN8GXkrdnGjw3HDrJFMuBYlx-7fce6epRJuQ>
    <xmx:FjvXalNjw16TYUaehPv1-nawBnCkTu4HRQOA32addwscnbm1ikNHZg>
    <xmx:FjvXajYqiL2xxmSpnCsZEHq7J7g83DttcQQsoD-0nzyFfowzCCr67w>
    <xmx:FjvXanyQmU4NmuiYfIYZVpApZ6C3L5la1nKPVFYPgSQiaeQ-eNqs_Q>
    <xmx:FjvXasXhDh8iL0teYqG7o66z0CjFI90pQfxrNTbkvhJbCSr1hLhvFKXo>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 05:57:42 -0400 (EDT)
Date: Tue, 20 Oct 2026 11:57:40 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net 1/2] tls: device: fix record start in the
 tls_device_decrypted tracepoint
Message-ID: <atc7FCQv84jn2CrZ@krikkit>
References: <20261015201135.2744031-1-rjethwani@purestorage.com>
 <20261015201135.2744031-2-rjethwani@purestorage.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261015201135.2744031-2-rjethwani@purestorage.com>

2026-10-15, 14:11:34 -0600, Rishikesh Jethwani wrote:
> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> index f11d0528fc43..33e6dc3d4164 100644
> --- a/net/tls/tls_device.c
> +++ b/net/tls/tls_device.c
> @@ -835,6 +835,21 @@ void tls_device_rx_resync_new_rec(struct sock *sk, u32 rcd_len, u32 seq)
>  	tls_device_resync_rx(tls_ctx, sk, seq, rcd_sn);
>  }
>  
> +/* TCP sequence of the first byte of the record the strparser holds. In
> + * normal mode the record stays in the TCP receive queue until
> + * tls_strp_msg_consume(), so copied_seq still points at its start. Copy
> + * mode saves the start before TCP reads advance copied_seq, possibly
> + * over a FIN that is not part of the record.
> + */
> +static u32 tls_device_rx_rec_start(struct sock *sk,
> +				   struct tls_sw_context_rx *sw_ctx)
> +{
> +	if (sw_ctx->strp.copy_mode)
> +		return sw_ctx->strp.copy_seq;
> +
> +	return tcp_sk(sk)->copied_seq;
> +}

nit: tls_strp implementation details should stay in tls_strp.c.

>  static void tls_device_core_ctrl_rx_resync(struct tls_context *tls_ctx,
>  					   struct tls_offload_context_rx *ctx,
>  					   struct sock *sk, struct sk_buff *skb)
> @@ -990,7 +1005,7 @@ int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx)
>  		is_encrypted = 0;
>  	}
>  
> -	trace_tls_device_decrypted(sk, tcp_sk(sk)->copied_seq - rxm->full_len,
> +	trace_tls_device_decrypted(sk, tls_device_rx_rec_start(sk, sw_ctx),
>  				   tls_ctx->rx.rec_seq, rxm->full_len,
>  				   is_encrypted, is_decrypted);
>  
> diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
> index 6cc222008d95..ad8b5150ac97 100644
> --- a/net/tls/tls_strp.c
> +++ b/net/tls/tls_strp.c
> @@ -132,6 +132,7 @@ int tls_strp_msg_cow(struct tls_sw_context_rx *ctx)
>  	tls_strp_anchor_free(strp);
>  	strp->anchor = skb;
>  
> +	strp->copy_seq = tcp_sk(strp->sk)->copied_seq;
>  	tcp_read_done(strp->sk, strp->stm.full_len);
>  	strp->copy_mode = 1;
>  
> @@ -418,6 +419,7 @@ static int tls_strp_read_copy(struct tls_strparser *strp, bool qshort)
>  
>  	shinfo->frag_list = NULL;
>  
> +	strp->copy_seq = tcp_sk(strp->sk)->copied_seq;

Why not set strp->copy_seq every time we start processing a new
record? Then we don't have to worry about whether it's set, handle it
in multiple places, and we don't have different cases in _rec_start().

>  	strp->copy_mode = 1;
>  	strp->stm.offset = 0;
>  
> -- 
> 2.50.1
> 

-- 
Sabrina
