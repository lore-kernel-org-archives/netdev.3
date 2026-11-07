Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794080230;
	b=W1q9vt6tOEagOkBm+iIkXPqUr2mnuaWBNqj4DHFPcd1ivCaqqwkcGwnhPA3ufF2xadwy
	 GxkfFTghcdczx7Qa0vIIvPt1U/JgrtkLwAlahYkjsIjU8QbOI3cRDQjwLVYfwInmQiGGF
	 NM9Y95yAfaeDvvBRdR0cxpnxv4fFmAztlgw5wXhaaA2c4VKLG1nSs0rkaB3mW9VL2Ct7t
	 J6wDNQvoMUMMGg8h5ORQBN9q3xDC7F2s/soKnhaRfKJWllAn8XoLvLt815BYIz9qSt/Eh
	 kZCDNAlbgH7tQXlXKd3tj+jsVxezopv9xtU+eeG6wDOLLeoOlBsNVsXfjNO35uuVrQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794080230;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Ba/8if6tQUDjhYKFvTmEGvpv0JRQFM7xPWSrhR1kNZg=;
	b=RvZnRser+WKOyGIpStJDqfbLgkh6HkytEvRJMOe4GVxemWUBS5XYq3UImD3NwlwC2LpZ
	 9Qk+SfK6tgXHkYrZPcPqJCX3asQYAyseYWhqITUS08VagxQsNzGzIDECAf3vabptOS6Qr
	 3oBtzWwHk+P6qBaG7bv2mwGc3DyMhdDNCEpsLQJ49xmrg8GQqt1vGpPxBKZ562lraHzap
	 /wCvygGtRJrlz4qHaWqcbc12pWLQ8xGwCOpwNBJ3Kq0Z6cCRls0ICScbCFD5/N+m5s5lA
	 5GndxQON8knO0voBjpb9SokH6eE2Is9aJp/q9TpbNIk6fKqTKjWMMFqdXGYd6BN/qSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ByK4imwF;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E353606A32F
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 19:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E353606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ByK4imwF
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ed276af91dso26710515ad.3
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 11:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794080229; x=1794685029; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ba/8if6tQUDjhYKFvTmEGvpv0JRQFM7xPWSrhR1kNZg=;
        b=ByK4imwFna3/KYzQ0O+TZzdsIb/Erf6wIjoJkQv3G1x+2xnq3FcmalVU2H4oKf/VcI
         +GiTWuh+io7HiYBKomc1DVtSVUnJet7Vg5U75IK9f8HwenUPB0xaTFj+q3eVrjLNEdgj
         Z00Toc9xErF5tCpwYm9epPKIJMKEJIbtCJ/USGq90Un4ETrkMRsClobiPlIUp7IpAfxW
         yWIGT1pyCRVXeeR41RACstB1ag4SXd0Px6tOfZM8TtyWWY0Pg/8pazvIS7yXOqtdDlxK
         HQdIlRdf1aDvpGT4joMQxsBhz6eTsObYcqJxW95PNPAQrNOp8UAKUhfzoOMUHf41t02i
         dlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794080229; x=1794685029;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ba/8if6tQUDjhYKFvTmEGvpv0JRQFM7xPWSrhR1kNZg=;
        b=OXviWG7Fi9H+4KpMWIiJmhpP9aqtVTMpbWEWiQ8oLZSQXof6Bus9fEyxROkk/vQQ2k
         +KtG5D3P3Mpe79xoEeUK+v8EaHwkrPSXq6JqM95HSZV5to/dPABmXFPQYvagbLim1Bh8
         d9hZaD5A7ceE+HNi/yripgdV2GK/YP73bAAJkG9YxYV/H3H1oX424wOrMyXIwbBd8/cZ
         vWVX7Aoppk5s8JX23X3BzGJuD/4EhUCSWbhl69by8jYXvfN4B8SRVKCgzEJettN4vU+f
         u/ELVIz417wOVUGTOfZQALCNHKdEETZZXClcx1R+Q/FDWeltW3I+ruzdYe3jyTxEWXjK
         VKCA==
X-Forwarded-Encrypted: i=1; AL+hErHVtD7Y07hKXykIWeerFb0FTEoTWLFfqpRsFdxzKHQlyQvaffyllGch8r0XZnrHc2oLJ+G+Qa0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9WOTC/ccZ7D83t/bL4I+7v9iB2DqSsWt2srarzpqE7Vqmm0sIv
	dLzapKuzSVlVhpQPiPUaBf7zozrx/YF0cKOWH159LCxlSLI6ehMHbq9FA3snOuMVr/kgRDrwdSi
	sYh5SMg==
X-Received: from plmm4.prod.google.com ([2002:a17:902:c444:b0:2ed:5073:70bd])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ec86:b0:2ed:1cf0:4cda
 with SMTP id d9443c01a7336-2ed412fc4eamr68907245ad.8.1794080228818; Sat, 07
 Nov 2026 11:37:08 -0800 (PST)
Date: Sat, 7 Nov 2026 19:37:08 +0000
In-Reply-To: <20261106135841.418-1-ljp1205831794@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106135841.418-1-ljp1205831794@gmail.com>
Message-ID: <au99hnLthtlu0Mln@google.com>
Subject: Re: [PATCH net] net: reuseport: avoid duplicate closed socket insertion
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Lin Jiapeng <ljp1205831794@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Martin KaFai Lau <kafai@fb.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	TencentOS Corvus AI <corvus@tencent.com>, stable@vger.kernel.org, 
	Lin Jiapeng <jiapenglin@tencent.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, 06 Nov 2026 21:58:38 +0800, Lin Jiapeng wrote:
> Clearing SO_REUSEPORT on a TCP listener clears sk_reuseport but leaves
> sk_reuseport_cb attached to its reuseport group. A subsequent listen()
> does not put the socket back into the listening section because
> inet_hash() checks sk_reuseport. However, inet_unhash() checks
> sk_reuseport_cb and calls reuseport_stop_listen_sock().
> 
> With request migration enabled, reuseport_stop_listen_sock() ignores
> whether __reuseport_detach_sock() actually removed the socket from the
> listening section and unconditionally appends it to the closed section.
> Repeated connect(AF_UNSPEC)/listen() cycles therefore insert the same
> socket until num_closed_socks exceeds max_socks. The next insertion
> writes before socks[], overlapping prog on x86-64 and leading to type
> confusion when a reuseport program is attached or detached.
> 
> Only insert the socket into the closed section when it was actually
> removed from the listening section. A socket that was not rehashed as a
> listener is already represented in the closed section, so leaving it
> there preserves request migration semantics and prevents duplicate
> entries and the resulting negative array indices.
> 
> Fixes: 333bb73f620e1 ("tcp: Keep TCP_CLOSE sockets in the reuseport group.")
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Lin Jiapeng <jiapenglin@tencent.com>

The right fix is to disallow changing SO_REUSEPORT once
the socket is bind()ed.

I was sidetacked while preparing fixes, so let me post them.

https://lore.kernel.org/netdev/20260928174546.4022833-1-kuniyu@google.com/

pw-bot: rejected

> ---
>  net/core/sock_reuseport.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/sock_reuseport.c b/net/core/sock_reuseport.c
> index fccbdd0430b0..775f446516c3 100644
> --- a/net/core/sock_reuseport.c
> +++ b/net/core/sock_reuseport.c
> @@ -480,8 +480,8 @@ void reuseport_stop_listen_sock(struct sock *sk)
>  			 */
>  			bpf_sk_reuseport_detach(sk);
>  
> -			__reuseport_detach_sock(sk, reuse);
> -			__reuseport_add_closed_sock(sk, reuse);
> +			if (__reuseport_detach_sock(sk, reuse))
> +				__reuseport_add_closed_sock(sk, reuse);
>  
>  			spin_unlock_bh(&reuseport_lock);
>  			return;
> -- 
> 2.55.0
> 
