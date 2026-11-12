Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794463334;
	b=Ys3dFh+diZhnx28SQHoA5GlxlrT8m/gvNb+vh3bAnGWgmp9mPUepYtVy1j0m1MM9zly2
	 8FqHh1Ma/NPFTrRTGPc/2OfW4Nxd5ACU/YBwu7sDYaXE2LIgunrz2jdKChgScaf7ikVBW
	 9p6OJYv271+rXw668RDFRbo+shZ4zHRMJfhytG04HXhOu0QLRCapY4sU9grxvKrW1cTR9
	 GnzvgptEYwMZ6qiU9asHOO8c1ZbvV2P/P29rR1i1uG5UVKsDoM1yLkPcjz/KG4U0ofTUz
	 I/D59tKDE4gSgvmmAiKLhdzUqLEWlbGrG5xoH9fJ00UlbzfVUiMXxY67eSFwK/7cGkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794463334;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=khamYhZ2bRTaVNqE6uU/QWflcGzYX/UlvUz85mE72r4=;
	b=fgp7zLNXOZrNDjAkUM5i+4Qe3kO37M49vMgLK0Zz8Re1X1k3uGsZ+7EwwubfxpUUt1tE
	 6rPdsHHFz3jQ16u4XHr+t8PJLmI3b2XB5luFWWDhSluSZcuxtm/Ilk//xsS1DBnqyHQ9a
	 WfVG0SCGNrgPDnvoCe+zE6+moKJybRen5bILbTiiFShL2kYt/6K9zC5y7LurX06h1L1Gz
	 R6SEpCK3ZW9t2LQy4BqEeHnyR6HQ1OjFQbzpSOInTjeYq3hhEXVR2WFkFz7qc0NTr+2XR
	 f9B28GAKVO1KhajxF3509qUqfP2YXW6+gfiacjuQVMLIfJyKyQ3yHI+oGocCjo9darw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aGSMxE6y;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BCB606A321
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 06:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55BCB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aGSMxE6y
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b0afbf532eso3583571a91.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 22:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794463334; x=1795068134; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=khamYhZ2bRTaVNqE6uU/QWflcGzYX/UlvUz85mE72r4=;
        b=aGSMxE6yTfFst/VSbWVwB4YbgbVMo4QusRloLJnjBsj8sTv+tnC0p0NLrOmBjV881Q
         6v1KDVEM6WiHrfVA0z6KRALldRp+4/EtW7C4Nr0KZrf/+ZZnTtohDmeFNz5IJA+TfGaA
         iUtAqSc+CyPi7TjMv7VIIyFb2Vaf76t6wISI9JpZVfG6N5TPXM/CY7FMoulN9Ji6sA87
         XsTjwhLTaymRRtWSZPfeZHMxCNxYjUsALehgNxXr5HUcZYuUEHtmfXmqK0OKGzBZp+/2
         5jZ0meL3Y85w3gEZ4+Mba8anY/XFTXM2uz8/xVjFaLVeOmdJVlTw8c51hLQFm33Vi8B2
         MAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794463334; x=1795068134;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=khamYhZ2bRTaVNqE6uU/QWflcGzYX/UlvUz85mE72r4=;
        b=YkmZJZLumLei9crLG41xQFR8rjAjjxf1Hz5JAkDcvPnPMJIziyqGUfCdTbuUzKSROE
         eHHxbaUyb6vjSvFfsVQKp94mmWgev1gojT7F9BuvEA8ByHt0bq8pgY6j8JJ370i0yWsv
         Es9T3Ops3DzsTlI3RYQbqbCPQo6/fW80fqNo3QEvhTfP0aq8J+5feHaNUxe4FlgvS1Ws
         Hf+gGM5fK0Mg3tA8a7UA0VwpZXXwetRFkDo3IBw3PaPQLnXFxscP7qSkLk07rnDCG/S4
         +C23kGvYhT2dHxX1PHBUfZXI3PrYeDOCsy99OwtqVdvge0tWgAJhDsua6dbARJzInnFx
         imTA==
X-Gm-Message-State: APuU4Z/OH9y9nE85dIAExt7PM9YwY8AngbvdfjJH7bn3eEHtIPfgsreV
	orJUFsrJkEiiOaXP1dIblfuJtIyhJkq9g59FovbrefCfACVmbDXZvOBnV9pOQmdqBNjxh/e/Iux
	xmZmWMw==
X-Received: from pgby13-n1.prod.google.com ([2002:a05:6a02:650d:10b0:cda:df40:b50f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a87:b0:39d:f08e:e6e7
 with SMTP id 98e67ed59e1d1-3b182e10779mr4225406a91.9.1794463333517; Wed, 11
 Nov 2026 22:02:13 -0800 (PST)
Date: Thu, 12 Nov 2026 06:02:12 +0000
In-Reply-To: <20261110113306.3698438-1-antonio@mandelbit.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110113306.3698438-1-antonio@mandelbit.com>
Message-ID: <avVVzxL3pVZc6yQ5@google.com>
Subject: Re: [PATCH net] udp_tunnel: don't treat IPv4 sockets bound to an
 address as wildcard
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Antonio Quartulli <antonio@mandelbit.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Alice Mikityanska <alice.kernel@fastmail.im>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, 10 Nov 2026 12:33:06 +0100, Antonio Quartulli wrote:
> With IPv6 enabled, sk_saddr_any() checks sk_v6_rcv_saddr also for
> AF_INET sockets, where it is always zero. An IPv4 tunnel socket bound to
> a specific address (e.g. fou or geneve with "local") ends up in the GRO
> lookup fast path, although another socket may bind the same port on a
> different address: GRO then hands that socket's packets to the tunnel's
> gro_receive.
> 
> Check the IPv6 address only for AF_INET6 sockets.
> 
> Fixes: a36283e2b683 ("udp_tunnel: create a fastpath GRO lookup.")
> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
> ---
>  net/ipv4/udp_tunnel_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
> index a128fe85620d..29581c94fdcf 100644
> --- a/net/ipv4/udp_tunnel_core.c
> +++ b/net/ipv4/udp_tunnel_core.c
> @@ -62,10 +62,10 @@ EXPORT_SYMBOL(udp_sock_create4);
>  static bool sk_saddr_any(struct sock *sk)
>  {
>  #if IS_ENABLED(CONFIG_IPV6)
> -	return ipv6_addr_any(&sk->sk_v6_rcv_saddr);
> -#else
> -	return !sk->sk_rcv_saddr;
> +	if (sk->sk_family == AF_INET6)
> +		return ipv6_addr_any(&sk->sk_v6_rcv_saddr);
>  #endif
> +	return !sk->sk_rcv_saddr;

This is identical with inet_rcv_saddr_any().  As a follow-up
in net-next, please move sk_saddr_any() to include/net/sock.h
and use it everywhere.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
