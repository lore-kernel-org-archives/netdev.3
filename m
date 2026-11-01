Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793547724;
	b=BhH4cJSMQ8Y8g+PLHU3tAvMWvVVJzudsqrZVFLpD6KUHdsOVecSydZW3eMvsjl0efapt
	 ox6NEW9pHoxpxxMaPPsYe7e8ax/F8GDCJdZuCeoAN6OsUxctA9KAk0CAkFZOmpNY3MlVy
	 ddjuD7hAFKohK5732/GFBjitcAM/pdfrFtU8761Njv3ueJ8eyZKeO3U5o3D1Mhc/YAzgA
	 Zi1m9TILFQlOYkP8o/CiDcYORL50zYyiJ68q7go4IZWRa/KYB2RsEqRYN17S22W4/eB+s
	 ri5mJ4OFytf8JySG80+OSQuAKfHpx0JQH8BXRBE8iCNrImyTPiFFqBGUEH6dhYaW77Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793547724;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=7D17qXi3Tw0c7OsVGynV0oeKo9zjydflACAeqDBE66Q=;
	b=fPFtI8VyP1FDKzNW9zYMCnNtnzoyQ5aQaaXJvDK0nHNFmxOnSf2dOsB/Z/91KLOvPgSy
	 fuC0YfxKeHGqHa1b5bFLSPn4tDvKZp4ELnzqTRyyzKmMbEzaBENL4ivFvzXc6/i0wgm3k
	 1NVO+v+gSLq+XmggsgGZn8ekZzy8kjdVxuT1XJDw7Qr0XaCXL7QYT2nIi3zWxQBTE0ift
	 CVEr8UjSIsGlTkcIffsKZFmKWuo7TmYEtwPTeeb0Nl6huLrFJsBoRRSOGd8fq2VOkFxO/
	 RKAwfr3tAin3mZ10TFOzVfEXIucSqFpkfRhGuxmsKbRfZSYInW6E4ZxL1dBOeZSk8rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PHMvp3ae;
	arc=none smtp.remote-ip=209.85.210.199
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B0D606A327
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 15:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41B0D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PHMvp3ae
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-89f84753b43so1434271b3a.1
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 07:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793547723; x=1794152523; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7D17qXi3Tw0c7OsVGynV0oeKo9zjydflACAeqDBE66Q=;
        b=PHMvp3ae3ljxZAel8iJvmJOkoaGczK6G+iEju6I1EU6Pmx50daS+OpBLU0YGWEgqHw
         AxnaKxN42E6RHfVIaFXsNYlqrBd0ZFJvc1HPnBfkKpMnc0KnFwWLDHREl8HDMjDN0vk9
         JIQm74pC15pIjEGsaOc9oilpQUBqojq5hWTB0Q88mtnz4bxhhH8ieCUXaq1Q99h/us45
         xrEHIBtFWr/+ZKVh0quRPaPYFtJiaLwuAUrQg5n2FES1TwzYk/+kz2H8HMOwMvLQVKMG
         +Gq7fIOOgbayoTCziG3R1YqXAmFRaA05ksbiU/zShCiwarLmQaLC/gHP06p+gUsXnOlq
         6QUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793547723; x=1794152523;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7D17qXi3Tw0c7OsVGynV0oeKo9zjydflACAeqDBE66Q=;
        b=DjHSPZEo38iNCcNd8/tu7N1fWr6FMR9B8jS8rnpunfaQYKIVHXeC5moOAmmhBrbag1
         lRlPVoMjaIH11yKqeiwKwCG277Fcnd/mrio8Xyk9JyjiuYI0NKqGQw5uXRtVKblCxroJ
         b1v2VzYSMzAqEYxqB7vdttnK8GB4tJun0VCTyuHrOyp5fWZHYJ9SBZqKbpZpe25DmO1i
         Ek9bSoR67MxEm2xaCTAmW2Gzt4qXWc2lG2PJg/61OX/Dkf0zJQDRrH9HQCgE39cJMfyc
         Roi1Co3nla93/RdWz2TJDA5y9HsRcVURzgQhghAB1sAQ4NX+SoKi1T0q2nwK3nAJhIp1
         W5FQ==
X-Gm-Message-State: AFq9FYJqm0H2dSxlxEG/TnImA88bFTktJwjsHbnIVHdgeT0tPrTn0wxQ
	H8ECyFW7RdO8aTIil1HnK5fs6BlRsE65YKVjbNZGyqJA5lnh4HGVMExtsbFJPA155JhEZM9mS/1
	BL2w7vw==
X-Received: from pfbeb25.prod.google.com ([2002:a05:6a00:4c99:b0:8a2:1bc3:8884])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4652:b0:880:f278:6af1
 with SMTP id d2e1a72fcca58-8a9b9a4ec9amr5296046b3a.7.1793547723237; Sun, 01
 Nov 2026 07:42:03 -0800 (PST)
Date: Sun, 1 Nov 2026 15:42:02 +0000
In-Reply-To: <edbdf4f4075565b1fb5925d7e311d6f315151a48.1793444262.git.thnkslprpt@gmail.com>
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
 <edbdf4f4075565b1fb5925d7e311d6f315151a48.1793444262.git.thnkslprpt@gmail.com>
Message-ID: <auddRPy5o927NtZH@google.com>
Subject: Re: [PATCH net 2/2] net: check the recvmsg LSM hook for every
 recvmmsg entry
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@kernel.org, pabeni@redhat.com, 
	willemb@google.com, davem@davemloft.net, kuba@kernel.org, horms@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sat, 31 Oct 2026 13:08:41 +0200, Avi Weiss wrote:
> do_recvmmsg() passes the number of received datagrams as the nosec
> argument to ___sys_recvmsg(). After the first datagram, this bypasses
> security_socket_recvmsg() even when a later entry requests a larger
> receive buffer that would be rejected by an LSM policy.

Same question, what is the real use case ?

> 
> Pass zero for both native and compat entries so each receive goes
> through the security check. Remove the first-datagram-only comment.
> 
> Fixes: a2e2725541fa ("net: Introduce recvmmsg socket syscall")

Remove this.


> Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
> ---
>  net/socket.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/net/socket.c b/net/socket.c
> index c2a85224ab55..fff80fbca1a8 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -3057,13 +3057,10 @@ static int do_recvmmsg(int fd, struct mmsghdr __user *mmsg,
>  	compat_entry = (struct compat_mmsghdr __user *)mmsg;
>  
>  	while (datagrams < vlen) {
> -		/*
> -		 * No need to ask LSM for more than the first datagram.
> -		 */
>  		if (MSG_CMSG_COMPAT & flags) {
>  			err = ___sys_recvmsg(sock, (struct user_msghdr __user *)compat_entry,
>  					     &msg_sys, flags & ~MSG_WAITFORONE,
> -					     datagrams);
> +					     0);
>  			if (err < 0)
>  				break;
>  			err = put_user(err, &compat_entry->msg_len);
> @@ -3072,7 +3069,7 @@ static int do_recvmmsg(int fd, struct mmsghdr __user *mmsg,
>  			err = ___sys_recvmsg(sock,
>  					     (struct user_msghdr __user *)entry,
>  					     &msg_sys, flags & ~MSG_WAITFORONE,
> -					     datagrams);
> +					     0);

This makes nosec dead in every path.

---
pw-bot: cr


>  			if (err < 0)
>  				break;
>  			err = put_user(err, &entry->msg_len);
> -- 
> 2.43.0
> 
