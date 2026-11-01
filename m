Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793547527;
	b=A7APktLz23RQJ+iCKKmpAQGzHgMYOghEABtVcYTO27T9TqoNEElHEb1wHUt0kNZZaoSt
	 o93NXY7E5p8Kk44QUHYF4RXiWcDlgH8G0Z+eyYGT0Y/Lt4gJKEwe+PQyQ9If8k7O9nLgg
	 SuDn3mdue/KHoaC1k5Kc7znF3hho+TPSZDOeMA/qgcbsmqN5KuhRx+JENIc7acPmcgoOQ
	 lKkC8k6fkBJrwCggJwfZqhduoylRjTkPXNF371EttrT89cDTd3+BhqMJej2t5YNOaAgxd
	 otyIy5h3VkgFEkV0EwJLAs4vmay5Ev4gHd8OU1t4lbMGoBdrc9zqkDd6vhZqbyHI36w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793547527;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=y4TC5oAYHs7m0oof9CZGtZfqTYpKndLI+6fmGJ2s+hM=;
	b=IJE3RrcrkF6oDukzGzLqVElAo6ux299E3ht8T3fpx9WPj2HVBASbEd4nZl24O1niGb5n
	 2ZfGieTyhj67XIEYdL1EMyt88BsH3Kj/AcsVPL60AVcz+jgThj070nMeiWJgA3rMy/2gW
	 fO2bRb1NSVKl2yt9xxXNOj3if3Ibva52rRg7kNycAVBjEgwlnZCZU6+bJmowJ17C+vPh4
	 NHsjeE/9l1Zqtl+/4XR/H4fjzigqSzfYYwRnV45EaP8T2Flt5d4o2KiYCPiK5CpYC49rT
	 sj20z6BIpJ8nVN1ajJO6YnAFb3w4Mba9eMWQjd+WDS7pFn7n39VJim/FbCsuaa3C/XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=duekyhoy;
	arc=none smtp.remote-ip=209.85.210.200
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616B3606A325
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 15:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 616B3606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=duekyhoy
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8862ed0539dso2204774b3a.0
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 07:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793547527; x=1794152327; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y4TC5oAYHs7m0oof9CZGtZfqTYpKndLI+6fmGJ2s+hM=;
        b=duekyhoy7Vhf8xqa7pYzIF4iK0x271tu0dCpLxDc8oke8pCsPK20Blmvadt57/BX2N
         9yUZd/oTflx6mxGLa+Cbn+CnEQCnhVz7/TWBiaJIqML9YGkB83a2ig2tc1wrjkUj7EMh
         hDlXg3u9xO9x0o2mjWXKRWXhaG/JO5ThfmLim06wob5PgFxY3Fp2WvESYRpEnOBOV8q6
         J7jRzWI8nCxSnc7ly/wdQhHHB2MP1x6cPbEs79mYq7ZWDNB+4hRbNLhtQW7dsen+ukFG
         1Gxayjqm8DGnrAKNDQ765j2nw24zdLzeShqdSlOOUkp5jlREwLtf7Rl3s2V8YQnqWJCD
         GBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793547527; x=1794152327;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y4TC5oAYHs7m0oof9CZGtZfqTYpKndLI+6fmGJ2s+hM=;
        b=Mg40/zoxLyDd7G/C0tK8H41TDClqdJLEOR5O3E8Bh9jGYmuCae8f7yMhqNB7Caw3Pe
         xTON1+4qbloWF25d7MbH2d5ptLJrmDQku1NBi+tsTQQcXTNXsj527o2SaNdmNvtCbg3p
         +KhzlPsXzKapmqPOwZsV913NmQrXTh+brOmu4NSHw1ixBp4TgPX5zJUbhck9p49G84jw
         JBu/5rp1cFErNHmlnQpAEGB2s/3oofFA5rqhS8ao+kz5qGlmif45ecKHOMpe5nsBjr7S
         JcRqtXl7E8zr7oyv5mhKHSc4DtjAvYkwkX6FSyTv2U0mWT/Oyev7E3DXIZwWCxSwDXnZ
         vntQ==
X-Gm-Message-State: AFq9FYIffNGmRJ457iRD6rgP3H6hxkqTcO/mkbMrOvj7LdbqpPeZ/tTg
	8rRvFKJQ+7Izu0Hmsnfgzg9JLlUcvkfhCpqfdiXv6d9FWTJvROPGdmEUA4VJIStAB0zksJYuDCv
	npBbXcg==
X-Received: from pfnj8.prod.google.com ([2002:aa7:83c8:0:b0:8a6:c8f0:ec6d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e8f:b0:8a0:1c79:b442
 with SMTP id d2e1a72fcca58-8a9b69872fbmr7076112b3a.0.1793547526202; Sun, 01
 Nov 2026 07:38:46 -0800 (PST)
Date: Sun, 1 Nov 2026 15:38:45 +0000
In-Reply-To: <0b1a91e7fa0de128c6e2bd3ae2f5c960a5c0f883.1793444262.git.thnkslprpt@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <0b1a91e7fa0de128c6e2bd3ae2f5c960a5c0f883.1793444262.git.thnkslprpt@gmail.com>
Message-ID: <audZ1egS6dmi9ZfE@google.com>
Subject: Re: [PATCH net 1/2] net: check the sendmsg LSM hook for every batched message
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@kernel.org, pabeni@redhat.com, 
	willemb@google.com, davem@davemloft.net, kuba@kernel.org, horms@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sat, 31 Oct 2026 13:08:40 +0200, Avi Weiss wrote:
> sendmmsg() skips security_socket_sendmsg() when two consecutive
> messages have the same explicit destination address. The comparison
> does not account for the message size, so a BPF LSM policy that denies
> large sends can be bypassed by placing an allowed message first.

What is the real use case ?

or is this something just flagged by AI ?


> 
> Use __sock_sendmsg() for the cached-destination case as well, so that
> every message undergoes the LSM check. Keep the remainder of the
> address-caching logic unchanged in this minimal correction.
> 
> Fixes: 228e548e6020 ("net: Add sendmmsg socket system call")

This is net-next material.


> Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
> ---
>  net/socket.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/socket.c b/net/socket.c
> index 2e3b5737c481..c2a85224ab55 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -2709,7 +2709,7 @@ static int ____sys_sendmsg(struct socket *sock, struct msghdr *msg_sys,

 	/*
 	 * If this is sendmmsg() and current destination address is same as
 	 * previously succeeded address, omit asking LSM's decision.
 	 * used_address->name_len is initialized to UINT_MAX so that the first
 	 * destination address never matches.
 	 */

The comment here is stale.

 	if (used_address && msg_sys->msg_name &&

>  	    used_address->name_len == msg_sys->msg_namelen &&
>  	    !memcmp(&used_address->name, msg_sys->msg_name,
>  		    used_address->name_len)) {

Also, used_address, etc is no longer needed.


> -		err = sock_sendmsg_nosec(sock, msg_sys);
> +		err = __sock_sendmsg(sock, msg_sys);
>  		goto out_freectl;
>  	}
>  	err = __sock_sendmsg(sock, msg_sys);
> -- 
> 2.43.0
> 
