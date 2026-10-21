Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792614661;
	b=z+FIjs4AtvU2TdrxxLJCk2LGDE1It9H8KUjk3v7ThdviBTg0VBVKz9BjcgUCZvQFrIEJ
	 2DZT2Da8IdXE0HcyWVZJZISzaGQ0pQgGRP8eD5IXmn4PBxSwjHf+DzLwMtIq4/nhCGmjK
	 rmO7mm8NfuAvEA6/lMNZwJyIqw/7+f5Fyb7rTgvzot4LyQmcoa0ATbjHxruwHLpWqRCkY
	 rcuHdFHWD8bc8BwRepyTKtxWwZzF/8tx42d9khvQ/TTTDwMFwnp0E9DrE+IRbeTlsP1hV
	 6h6TSU8QO+G91e1oHml65viQefYoYxtZl+gzkAfjDXD8IigT3x9zxAD7OSY2PwEFGyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792614661;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type;
	bh=ocx56fWt7XSCk9pq2eAJ2hR9rY2tffC+W+ABZ7B+YxM=;
	b=P46kbsklV2w0YDBQ8ZeMZq19mt6YfkgeWVDw+D2GXKCYzIi79K+WYz0PaLeA0WtuxnH7
	 slTMb6RR7eXkUofQJruPBkXgUg3E4e3J6geZ9KWXJLfR8FpMsS4zosWyyVK3g7f3uVwJM
	 gRkxetQVhUNZ8AkGGUx95cQXvfR1g9TV4/NsmNqxBKDhF1B64IQGdIjtmDlxtbn+hSxN2
	 +dlap6EAwsDPripEoX4XBDazvFhH7av6NHv0NDngenOwnd1VUhCSHA7+EOd7oQ/COPOou
	 fthJ92uQ/6efFQBtOoxdl1XVB59hOvKB06OKdAIT5P5LfPifONHhK6b2xPlcOkbLQ7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=XItN2WhY;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47BF606A31D
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 20:31:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C47BF606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=XItN2WhY
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4395d31228so164488166b.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 13:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1792614659; x=1793219459; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ocx56fWt7XSCk9pq2eAJ2hR9rY2tffC+W+ABZ7B+YxM=;
        b=XItN2WhYGidbybhgPjERNBnp/WvYFyIkhR1OCZdznUiDYu3ZbeejM/MLx8F42Eclmr
         ZElA8dOKn5vKCGwWtMyR6GSG2tqG6AZFeI8ohzNfWf78QVHRXDY+oo4Yx2W+x19HHkty
         TVoJ9QiYtKETrAH2kCdjRtYS3QeUxrZ5lfxhTMnlR+3xzv+wVzf9aRRw2A8APdl7yCAm
         yg73CowtrHcQKOVvUS3m3IcdvZuompVYnRNlGypxzdLvHP7P8eKD6ta6OAdmZCy8z4ij
         OQF5TjeGlXfK2mfOvxBF1TWvrO36UnbuHYD2P1HB2zWJBEOZOPOuRNPusLPhRA298LB1
         qTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792614659; x=1793219459;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ocx56fWt7XSCk9pq2eAJ2hR9rY2tffC+W+ABZ7B+YxM=;
        b=cE+EnlV+ZtMpDSoV6Ebnff5z16+b+uHjGz7QowF/kHzwOyvsIK7rmm/02yVStXrnck
         ujO85/UbiEygjUDqKdAf/ApaDvWkOG11/5NrENVUMJwUOyp4P8gLxLAjAyiN65880lEQ
         IbLsdoANm6SEz/icFoXGh5scodZ7wg7liPhWyYp2HQXxp6uOD1/hPh/pshzvk2zcD78H
         EWhZrkFSxFylDPsFBwl0hvAfiIa324ZQ3K9/PSw+Cyf7VRpR0NBkH30UJkDQ/7VUP2/L
         W3fXxuDzMyfZUFOh8h4YjQPQKMH2sLndRnSkk7q+AptTriavKE3VBa8O6wQWJ2PXmmdE
         UVug==
X-Forwarded-Encrypted: i=1; AKwUvBwwdGjS/nLJ9VFK/LWfTJDIhGxGZfuL/yfyFHVDerutgjGM3dXZxDQjveFx4KMLCHZrEop6CYA=@vger.kernel.org
X-Gm-Message-State: AFq9FYI1HOu/l/FHoQaViU0PC4jLj6YTweCjyetzXg2cxxJBFGiEEozT
	Y2dOySmiASHT4vBKw8MKZMVsTbqK65S2vENY3Oy2/ngN6MKCI9j24EVpydk2yTefKk8=
X-Gm-Gg: AYBFou0qqMxY1v8aXPIV9RVR/OMgClMO4y+dwOVFFrKvXWDdQEnuZMUMMzAyY7+fpfx
	Wfrl+VD0W15vwrMN/AK8i4Q0h9BjEpcM1E5DcYHLuzsdo4a3n1vwhCAoxOnNnbdyCfelcRsh+ug
	opmG8fHx2gYDiBF+aGDP6+rbmQQmF0/r12KjCwhqQBeLLb0pjyccnPvAdaGS6oELQSqJWPyLJKv
	AA/wJaGAjyhnFP8kltArktBHie0oWpLoOaB0HHYLmnE+F94r/lfn5sDnRl0ddROZn1nIYjoBMSd
	8xTRdqTy+jdKkP/vXOLM55Zc8ZxfKpo4I7fIc1vojJHmY3p14ifM4wv6c0d9pXEuh/YJGR0X6A/
	gHpHZPtSOj4O1ux01UENC5vQr21JAd4uClTYHyh8LGS8EPUusqcT/ohqq8R7tDnMid77+0ZQdu9
	3UTOwcsfFTA019I5V3EFvRtr0IkrjHDopFteAalBlGSXIK05Zvr8bS79DBElU1ePs1sXjsiIBd6
	iwKglM3Tjzf3EiFzDRnNuK7A4gtH7UcIeCBS6WAVUm9GdU=
X-Received: by 2002:a17:907:3e89:b0:c40:36ca:9d1b with SMTP id a640c23a62f3a-c46796eb68emr268122766b.40.1792614659124;
        Wed, 21 Oct 2026 13:30:59 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:5067:295f::41f:4a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c468a55ccabsm33788266b.33.2026.10.21.13.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 13:30:58 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Dudu Lu <phx0fer@gmail.com>
Cc: john.fastabend@gmail.com,  jiayuan.chen@linux.dev,
  netdev@vger.kernel.org,  bpf@vger.kernel.org
Subject: Re: [PATCH bpf] bpf, sockmap: use READ_ONCE/WRITE_ONCE for
 saved_data_ready in the verdict path
In-Reply-To: <20261021155629.68813-1-phx0fer@gmail.com> (Dudu Lu's message of
	"Wed, 21 Oct 2026 23:56:29 +0800")
References: <20261021155629.68813-1-phx0fer@gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Wed, 21 Oct 2026 22:30:57 +0200
Message-ID: <877bja7q4e.fsf@cloudflare.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 21, 2026 at 11:56 PM +08, Dudu Lu wrote:
> sk_psock_start_verdict() and sk_psock_stop_verdict() access
> psock->saved_data_ready with plain loads and stores, while the sibling
> sk_psock_stop_strp() uses WRITE_ONCE for the same field.  sock_map_link()
> / sock_map_unref() touch the same psock from another CPU without the
> lock, so KCSAN reports the race:
>
>   BUG: KCSAN: data-race in sock_map_link / sock_map_unref
>   BUG: KCSAN: data-race in sk_psock_start_verdict / sock_map_unref
>
> Use READ_ONCE() for the reads and WRITE_ONCE() for the writes, matching
> the strp sibling.
>
> Fixes: 2ef2b20cf4e0 ("net: annotate data-races around sk->sk_{data_ready,write_space}")
> Assisted-by: LLM
> Signed-off-by: Dudu Lu <phx0fer@gmail.com>
> ---
> Tested base
> -----------
> Detected on Linux 7.3-rc4 (commit 93f51579e7df), arm64 QEMU guest.
> Re-checked against mainline f47d223627f8 (v7.3-341): the affected code
> is unchanged between the two, so the bug is still present there.
> Checked against linux-next next-20261021 (commit 9a482184d910): the
> affected code is unchanged there as well, so the bug is still present in
> linux-next too.
>
> Reproducer status
> -----------------
> A reproducer was written and executed on an arm64 QEMU guest (KCSAN); it
> reported the race.  The reproducer source is not posted here per
> Documentation/process/security-bugs.rst; it is available on request.
>
> Triggering conditions
> ---------------------
> CAP_BPF / the ability to update sockmap and attach verdict programs.
>
> Notes
> -----
> Built and checkpatch-clean: this patch was applied on top of 7.3-rc4
> (commit 93f51579e7df) and a full arm64 kernel (defconfig) was built with
> it -- no new warnings or errors.  scripts/checkpatch.pl reports 0 errors,
> 0 warnings.
>
>  net/core/skmsg.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index df385a5a961e..0bfb8c4e7f36 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -1260,10 +1260,10 @@ static void sk_psock_verdict_data_ready(struct sock *sk)
>  
>  void sk_psock_start_verdict(struct sock *sk, struct sk_psock *psock)
>  {
> -	if (psock->saved_data_ready)
> +	if (READ_ONCE(psock->saved_data_ready))
>  		return;

Okay, but if we're going down that route, now sk_psock_stop_strp() is
missing a READ_ONCE around psock->saved_data_ready, or rather we should
do it once and use it through the whole function:

void sk_psock_stop_strp(struct sock *sk, struct sk_psock *psock)
{
	psock_set_prog(&psock->progs.stream_parser, NULL);

	if (!psock->saved_data_ready)
		return;

	WRITE_ONCE(sk->sk_data_ready, psock->saved_data_ready);
	WRITE_ONCE(psock->saved_data_ready, NULL);
	strp_stop(&psock->strp);
}

>  
> -	psock->saved_data_ready = sk->sk_data_ready;
> +	WRITE_ONCE(psock->saved_data_ready, sk->sk_data_ready);

I belive you also need to READ_ONCE(sk->sk_data_ready).

>  	WRITE_ONCE(sk->sk_data_ready, sk_psock_verdict_data_ready);
>  	WRITE_ONCE(sk->sk_write_space, sk_psock_write_space);
>  }
> @@ -1273,9 +1273,9 @@ void sk_psock_stop_verdict(struct sock *sk, struct sk_psock *psock)
>  	psock_set_prog(&psock->progs.stream_verdict, NULL);
>  	psock_set_prog(&psock->progs.skb_verdict, NULL);
>  
> -	if (!psock->saved_data_ready)
> +	if (!READ_ONCE(psock->saved_data_ready))
>  		return;
>  
>  	WRITE_ONCE(sk->sk_data_ready, psock->saved_data_ready);
> -	psock->saved_data_ready = NULL;
> +	WRITE_ONCE(psock->saved_data_ready, NULL);
>  }

