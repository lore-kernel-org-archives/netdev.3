Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B429175A74
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 10:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787221317; cv=none; b=akA5YuHTP2lcuBFSa+P/yPIKPYKtf9mzlEuAyimP/r75FyepkSPPj2qOxlgM8+/JCljqwGC2HtxhR0NHVwrlpjyQ9tIDE4tNUW1clpPmrRSwaqioSAAiISXDN358G+szDO/kSQkoEBIMwpjs5g+9KaAu9qKRNrBF19cEFKwoGZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787221317; c=relaxed/simple;
	bh=dtyn2f9q1T02OJEVPhn7CJgfFYWg+JUYQ2izpiRepkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uwhfykexGhTJCEeNHdxIiLZgGktO33dR/kpQKZqztbjdw8ap+2AG3yfgpKdmYmmlQSJxrSBKShmileNMRRC0BYN2sG1VjYMO/igJ/XXGaQYy/Cbd0XTSEAOow3nTN48SUj4Hzag4hsj9kdEPOtkYuas3J6bGH9awMTWwKDPHXzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I9m9cNuV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=K6/q7oYO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I9m9cNuV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="K6/q7oYO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787221315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kLhRMr0ihKkmZGJvmMW+HBNQZqg+Qarr5omZgdvkv30=;
	b=I9m9cNuVhbrR6UcV16XGURS3mzhCvvW4KY1M3Mrpu2z6R3hnIY+EmKLcMiMH8K+D6tPMV6
	XkD0m7PxXpCq5e45jDegSlMXb5TH464tM2H91wMXT/f4IqoIhEEVgrMY4tCRq2BEnKXyVt
	UjOT8YL491mXiCZe4Dr5cTU3oEd/gew=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-UPlK0q48OZulxb_ds-C3aQ-1; Thu, 20 Aug 2026 06:21:53 -0400
X-MC-Unique: UPlK0q48OZulxb_ds-C3aQ-1
X-Mimecast-MFC-AGG-ID: UPlK0q48OZulxb_ds-C3aQ_1787221312
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49991beee7aso22160765e9.2
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 03:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787221312; x=1787826112; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kLhRMr0ihKkmZGJvmMW+HBNQZqg+Qarr5omZgdvkv30=;
        b=K6/q7oYOgZszAP5gCDXYCc2UAZnEw/kZ0ObgupjryKAVtQh9uIeeK+oZf5l7m0OZM/
         wnDiD3LevxtJ4Xr66wboJfHay0ghKbTZJR1h+3QDJuCqHsqAxrUz3lnEqBLTlCvnujtW
         bAcbQKheloWROFdEn6QXL8ldbG1mPvQdLjzLV5H2P2Mj2joYxetvvpmb451IEMIVdsyI
         jh3O439DWSEL+EDotvr5M68wrSS6hWUGb1F+7K4J/UbvGC/g2jyl7M7XtGt0Cmytzzoh
         +eXsfTm7uXPHqMSI3be67NkxN8vRovr31WYkYAQlNvcETTfPfNjXVSQZaxbrNjaBq/+l
         lR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787221312; x=1787826112;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kLhRMr0ihKkmZGJvmMW+HBNQZqg+Qarr5omZgdvkv30=;
        b=P4IzHSO+cIYZAR3lgr6hPb2huKEcics+aUCN5mlguxTKm67VtQid4rsastgtccoPU3
         FkuUcO/QwShyRY2IB/sQNAfX8m8z+MbSAbELW1ugtC3sjHwumLf+X2mEKB36Oa3VChNo
         RxMR5WKxFWN5lexEtdmiWO2yaY2SnXITXcSXer04/u8OUaifDtdR4tJfzrzL0SooClUp
         bv2ievng6j4z9fxCPzjDf5w50qMXccPyvP6J4cL0YNwKZOZZ2b5P1Zp1emxK0yCUo9Nv
         ii+dmbdmkV2CFjDeNl6YNILcvg1qUxJecWw1lNZFXKf4neYr/qFbdsXd/iWCYw57ezHW
         r/fw==
X-Forwarded-Encrypted: i=1; AHgh+RpwmdDJwl2MX4/Lx3OGKhkX3nzaTIedJ70bSDHglHBVSNvHzTosdZPcFizMZSNzbO12rrNytgc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9wMoJaz0trwzpqUOIC8h3Y7TPovD1xuT3F31uN8xSkzpjUSTz
	yx4bUSna3GAQFm+g37VrEVJd51gm2c0RLavPhaG9F0JTmBwOMGUixGbgRonf9WBIdSUBQsQrfJJ
	5Lr3jDLY6KMlfX4tceGjar6ZbjkxHlbq7gwP2sSywGJ014DWGZnhiV8Ta9Q==
X-Gm-Gg: AR+sD11BZ5UtJQPcamUrIGYBFS74W0D5QVt8ZAXr5AlNdgRw7C346O67p8z7ow5Bw6u
	AuCTGMonIrTWzCPPBCeUzm38fjVtxnBbDNzl3hFgkAa0WoycvRwdx+3L0YuAQM+eEBneJwZpnf+
	bwHUSikqSZbcB4UlW0gJJA7ZcdOu0OeDattLqOLfKvOETSThSG68WXGmdAAILu6D0EcppWGJ2D3
	F+23Fzpwjhvx7J2TTfW2FZuZQayRUVa7ew5RoZ4TqFeRcXr1caWzw96Zp8Qvqy5IiF10dIbAJRg
	JHgCRyjnBDqSZzM0NrDQkKrkcdro5lfHfZ31G3+L5Tbn1NSafWgMV8s/4lyg92u5++jlfFDMiD6
	CLPWc9ncZc5zio9wi/fslSqwbWeK1t01b5pbEWUxyqNAGjOO7ugM2pDuBeqEtQnEY/D+HozW32O
	A=
X-Received: by 2002:a05:600c:6749:b0:495:6274:56c2 with SMTP id 5b1f17b1804b1-499aa1896f1mr212174345e9.2.1787221312277;
        Thu, 20 Aug 2026 03:21:52 -0700 (PDT)
X-Received: by 2002:a05:600c:6749:b0:495:6274:56c2 with SMTP id 5b1f17b1804b1-499aa1896f1mr212173445e9.2.1787221311791;
        Thu, 20 Aug 2026 03:21:51 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b2269ba6sm30627135e9.1.2026.08.20.03.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 03:21:51 -0700 (PDT)
Message-ID: <9ab7df63-dcbd-496c-a997-4218e2ab272b@redhat.com>
Date: Thu, 20 Aug 2026 12:21:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 1/1] tcp: bound SYN-ACK timers to reqsk timeout
 range
To: Zhiling Zou <zhilinz@nebusec.ai>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 ncardwell@google.com, kuniyu@google.com, chia-yu.chang@nokia-bell-labs.com,
 ij@kernel.org, fmancera@suse.de, bronzed_45_vested@icloud.com,
 idosch@nvidia.com, yuuchihsu@gmail.com, vega@nebusec.ai
References: <cover.1786540242.git.zhilinz@nebusec.ai>
 <9ec8921d81d6218946e07e8542b1ac41b6e2d205.1786540242.git.zhilinz@nebusec.ai>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <9ec8921d81d6218946e07e8542b1ac41b6e2d205.1786540242.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/26 3:38 PM, Zhiling Zou wrote:
> request_sock::num_timeout is a 7-bit counter. Commit e6c022a4fa2d
> ("tcp: better retrans tracking for defer-accept") split this counter
> out of an 8-bit field, but tcp_synack_retries still accepts an 8-bit
> value and TCP_DEFER_ACCEPT can still derive a retry count up to 255.
> 
> If these settings exceed 127, the regular request timer cannot reach
> its expiration threshold and num_timeout wraps to zero. After the wrap,
> the request can keep timing out instead of expiring, and the next
> zero-to-one transition repeats the young-queue accounting decrement.
> 
> Both request timer paths can also shift req->timeout by 64 or more while
> calculating the next RTO. UBSAN reports that invalid shift, and systems
> with panic_on_warn=1 panic before the later cap can take effect.
> 
> Limit tcp_synack_retries and the TCP_DEFER_ACCEPT conversion to the
> range represented by num_timeout, preserving the same defer-accept value
> for its timer and bare-ACK consumers. Saturate RTO calculation before
> the shift, and cap the Fast Open extra retry to the same range.
> 
> Fixes: e6c022a4fa2d ("tcp: better retrans tracking for defer-accept")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> ---
> changes in v5:
> - Limit tcp_synack_retries and TCP_DEFER_ACCEPT at their configuration
>   paths, so all users of each value see the same 7-bit range.
> - Use 127, matching request_sock::num_timeout, instead of the previous
>   runtime limit of 63, and document the sysctl limit.
> - Spell out the 7-bit range mismatch, the repeated young-queue accounting,
>   and the UBSAN panic_on_warn failure mode in the commit message.
> - Keep the timeout calculation saturating before either SYN-ACK timer
>   shifts it.
> - Drop a no-op reqsk_timer_handler() formatting hunk.
> - Correct the Fixes tag and update the reporter and sign-off trailers.
> - v4 Link: https://lore.kernel.org/all/891a220c362e3266efdf6b1aa9dc3e52f6825c00.1784735392.git.zhilinz@nebusec.ai/
> 
> Changes in v4:
>   - Drop the tcp_synack_retries sysctl maximum to preserve existing
>     user-space behavior, and keep the runtime clamps at the timer usage
>     sites.
>   - v3 Link: https://lore.kernel.org/all/20260702095324.2995243-1-n05ec@lzu.edu.cn/
> 
> Changes in v3:
>   - Order local variables in tcp_reqsk_timeout_sk() by reverse Christmas
>     tree.
>   - v2 Link: https://lore.kernel.org/all/20260630035009.55201-1-n05ec@lzu.edu.cn/
> 
> Changes in v2:
>   - Keep the existing max_retries calculation in
>     tcp_fastopen_synack_timer() and only add the clamp, avoiding code
>     churn.
>   - v1 Link: https://lore.kernel.org/all/02e24eb83639e9d7ecc623f000c60254bb5c40a5.1782643946.git.roxy520tt@gmail.com/
> 
>  Documentation/networking/ip-sysctl.rst |  2 +-
>  include/net/tcp.h                      | 20 ++++++++++++++++----
>  net/ipv4/sysctl_net_ipv4.c             |  2 ++
>  net/ipv4/tcp.c                         |  2 +-
>  net/ipv4/tcp_timer.c                   |  6 ++++--
>  5 files changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
> index 208f46967ee59..fd5038b6cab9f 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -954,7 +954,7 @@ tcp_stdurg - BOOLEAN
>  
>  tcp_synack_retries - INTEGER
>  	Number of times SYNACKs for a passive TCP connection attempt will
> -	be retransmitted. Should not be higher than 255. Default value
> +	be retransmitted. Should not be higher than 127. Default value
>  	is 5, which corresponds to 31seconds till the last retransmission
>  	with the current initial RTO of 1second. With this the final timeout
>  	for a passive TCP connection will happen after 63seconds.
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 2c5b889530b55..8ab2fd368ed3b 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -183,6 +183,8 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
>  #define MAX_TCP_KEEPINTVL	32767
>  #define MAX_TCP_KEEPCNT		127
>  #define MAX_TCP_SYNCNT		127
> +/* request_sock::num_timeout is a 7-bit field. */
> +#define MAX_TCP_SYNACK_RETRIES	127
>  
>  /* Ensure that TCP PAWS checks are relaxed after ~2147 seconds
>   * to avoid overflows. This assumes a clock smaller than 1 Mhz.
> @@ -882,12 +884,22 @@ static inline u32 __tcp_set_rto(const struct tcp_sock *tp)
>  	return usecs_to_jiffies((tp->srtt_us >> 3) + tp->rttvar_us);
>  }
>  
> -static inline unsigned long tcp_reqsk_timeout(struct request_sock *req)
> +static inline unsigned long tcp_reqsk_timeout_sk(const struct sock *sk,
> +						 struct request_sock *req)
>  {
> -	u64 timeout = (u64)req->timeout << req->num_timeout;
> +	u32 rto_max = tcp_rto_max(sk);
> +	u64 timeout = req->timeout;
> +
> +	if (req->num_timeout >= BITS_PER_TYPE(timeout) ||
> +	    timeout > U64_MAX >> req->num_timeout)
> +		return rto_max;

Sashiko notes the above is racy, and basically makes this patch not
effective:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/9ec8921d81d6218946e07e8542b1ac41b6e2d205.1786540242.git.zhilinz%40nebusec.ai

note that the solution provided there does not even compile, you
will need something slightly different.

> @@ -1034,6 +1035,7 @@ static struct ctl_table ipv4_net_table[] = {
>  		.maxlen		= sizeof(u8),
>  		.mode		= 0644,
>  		.proc_handler	= proc_dou8vec_minmax,
> +		.extra2		= &tcp_synack_retries_max,

I explicitly asked to avoid this in v3. Sashiko suggested updating the
doc. Why do you add this back?

/P

