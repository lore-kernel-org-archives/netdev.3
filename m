Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793910708;
	b=pXmGbAQ7kTdkf/ItWWWg6Nppogt1MjUyT5GW/ZxG21Uly2fKZJXdLRD6IGvvpEBsRARJ
	 u6v9mgLOupyqGm8xj2xU93KXu3DPhfqDW7Koer7AIuNp64wJxRcQ4SKx3AZ0ktEtIW0iQ
	 5brYtB/Gr5DP5M/XjUfomZbI/T8SEwfVfoJ2n6M3wO/fswSwith8WmfvrDgeIhdY6ECNr
	 Vln3ZJfsjugZyxpGWsTivQZkuKSsVwOJV/f9NcrjU3f96p3JUtn1y8oxHZ67tLksecVlC
	 VGOxNGSZZ6BM2scanvd3VhbJ4Ni6qOcQbuj5G3qo5zdBki6FwR2ghC8tcmaOlnzyFDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793910708;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=4dzFrdPbxMFX/FpSKxrPziIdauwmua6timzs12L5qQQ=;
	b=QSLUx4wK5arbmb+VpPgB3vhAodcZ/boerlwLCHvuDlUJiEj5S/l+819eQSImXVM+ki4o
	 dZaJ38JJUAmDDH3DMITU3OCZlguMD2DuVrR1T5PUk5tkeoyuBAqAqbWVgMUx6g7khBxQR
	 S0E/nnYf82I3GLgftUOoOEhwMQhx1P48C+MNheVAUDqnO39/XfouSx41RkjOJiEUIZSr+
	 ARTpbTqFptAbe3uogGt2MwUm4xgYmEJGFbpVC0m6vYWQnWjNI3gSU1Ud4x0jkvtMLqPgB
	 k+gaqLYLEDtjwU7njzLOw3gsqUMprVdr4THWi5dGXB5plaIn4lL/vO2DX+D/vUpI1iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="V8lm/aBn";
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78370606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 20:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78370606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=V8lm/aBn
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3acc98e3b3cso2003958a91.3
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 12:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793910708; x=1794515508; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4dzFrdPbxMFX/FpSKxrPziIdauwmua6timzs12L5qQQ=;
        b=V8lm/aBn6lW8dKuC7KKnmRR/gIrC9qkTNpaGByjQPeeERLkxG3Saxf2KmXNkaCBMvK
         wpShXwBBFRGvP5PexVhBDz5/F8fuZ3E8Qaj7W5lQ0gYd2mFBcAmvLUPMrsK/axPvg6Bl
         jjqpTkbeprRBR4T/l549P4JlvZlPwJE8JEOkvARpXR2HXcHt0hcKP5baC8hxxF7ETVP/
         JOB16JybefDcf39kygrLgCRzXTLJlktks942rXGDtCA1xSpWDQrwBEzYzaW+unQl1HKm
         NtArIfXG7lYE4BDeR70RApIPuyFhY8b06BJLdNbCepWeXFkMdVobCic8aJAafqAeMikn
         pUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793910708; x=1794515508;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4dzFrdPbxMFX/FpSKxrPziIdauwmua6timzs12L5qQQ=;
        b=lxVAHHB8u+JGP344yVnZCPIJCbENRC8cqh7SBvHAA46dLIGUeV1+UUGsEzIDhinVLU
         yuJlxo37TvfP8wOAqlVtc4oR6eLM2qvj0WpfQT+86rUdoxOMuffEZkexADelkyXTindz
         41nFay/JmQRl1nPuJXQuTVujgJTA+kWOxCOJ9fsyKeHX5l2MbIiflvA9L3mTNGqU86fH
         AtXhZwnnMwFXrxGQRseyNv4+iXfMAWdCNK3J9PJUWQtBlfPrjWlS59I7Q5hOXPRu8p8U
         db/zD72s+LlBactjcgF0j4S4+xkwQI6X878xqTNyF0At57jsmw86bWQXZA+5ZJlm17x3
         79ig==
X-Forwarded-Encrypted: i=1; AKwUvBwtiz10bSIpqcOyAqL66lScXqKFOBv+nV470mlH5co3pxR7a0TT9mA6KK7UA5pTEF6FryMum/0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8XhdQLrlTjHmu5yxdyDtCVY2lzwtsOYr9PjR4tuaXRI8IQHXEF
	WbDBkqvLplSgTNxOIOhubZciNGKD8YeWnidTNqZK70iKZWzy3ZJ53G/H+rtSp2Fnm57wrFW1uwk
	oujpc1Q==
X-Received: from pgmr36.prod.google.com ([2002:a63:2064:0:b0:cd8:c6e9:7c0a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:da8e:b0:3a7:da33:ff2d
 with SMTP id 98e67ed59e1d1-3b0db70848amr156284a91.48.1793910707578; Thu, 05
 Nov 2026 12:31:47 -0800 (PST)
Date: Thu, 5 Nov 2026 20:31:47 +0000
In-Reply-To: <20261104132900.1071940-1-edumazet@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261104132900.1071940-1-edumazet@kernel.org>
Message-ID: <auznnQkMoeG7alUM@google.com>
Subject: Re: [PATCH net] net: require a full socket in sock_confirm_neigh()
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, Kyle Zeng <kylebot@openai.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, 04 Nov 2026 14:29:00 +0100, Eric Dumazet wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> An skb can retain dst_pending_confirm after its original output and
> socket owner have changed. For example, a raw MSG_CONFIRM packet can
> cross veth, have a TCP request socket assigned by TPROXY, and be bridged
> into gretap. Neighbor output for the outer packet then calls
> sock_confirm_neigh() with the request socket in skb->sk.
> 
> The helper unconditionally treats a non-NULL skb->sk as a full socket
> when accessing sk_dst_pending_confirm. TCP request and TIME_WAIT sockets
> do not contain that field. This produces an out-of-bounds four-byte read
> and, if the word is nonzero, an out-of-bounds four-byte zero write. A
> KASAN-enabled kernel reports:
> 
>   BUG: KASAN: slab-out-of-bounds in ip_finish_output2+0xc9f/0xd60
>   Read of size 4 at addr ffff8880bdc3d880 by task tproxy_dst_conf/1771
> 
> Require sk_fullsock() before accessing the socket field, moving the
> existing helper earlier in the header to make it available here. Keep
> neigh_confirm() independent of the socket type so the skb's neighbor
> confirmation still works, including for socketless packets. This also
> covers the IPv6, VRF, and BPF neighbor-output callers.
> 
> Fixes: 4ff0620354f2 ("net: add dst_pending_confirm flag to skbuff")
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
