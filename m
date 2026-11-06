Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793923840;
	b=TjdzEli2/cn+dkDXFPtnkKeGz/UpfZ/Gl5EK81aIMH0sJqTHHcqk7k+6Ev55YKO2kdDK
	 JrcNfQ70ZBEa2+Hq/aEgsxwkV6y7PW6aGL9VWp4IUH66lJBr8QWxHPpF7WfF7lc7M+gCX
	 bY5xbidGX+vS00OsSqXq//b2TJsHzqkORTINvgD67i+XERbNyAt2xdnWQlaVww7HH7cL9
	 XXG56K9PkO5RPPZ06SBtCoMzR1UaEZNmSYKVSvW5trhIVv+qU6UfcXL041uaT4fGpGs6o
	 pIE/XB7JSuKGhGxbzXPa4u79LCVt4A0W/iG67A8K/XZSpFcZzM1iZzNtFyb6ZjxogeA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793923840;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=P1bL50lNxWo1x/ueBX/G/p1juBW6wsfb8QdUKb7CUxE=;
	b=cDEtyItFnsD0OoR6du5kRr6XcVaB6ZZgdf5l7zgTdYWfCSUP2vLx1Sb4pRlrq8n1fFdN
	 BYK0kwW5oOcEAwSl0wAGUVkIWqJ36bkLthHH2nukyV4ube6z+VSQcDkyC06ieCnot8v6E
	 rAupPAkhw1DdDh4cqE8lRimxuKHDtuuKs+68V/Oh4GVy3Pl1DLPN379syXJs8cXgAHUDI
	 O4Bs4zKstOI7ecjl0GjaesS1dN5F0lrFvwpM6Qyovfd/5VgHUpwCXAi/cEbkEyEm+vGXI
	 AZfzJXaoXI2n+Zz9HHE3qxGHKci2Izjv9R53b/ihqQkKdA4fiaje01Uu8/FU1FstLNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=XfnqDibT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60529606A328
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 00:10:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60529606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=XfnqDibT
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b09a83d12aso67514a91.2
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 16:10:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793923840; cv=none;
        d=google.com; s=arc-20260327;
        b=Rmoeu7qirQLFgScKhd7/6nMEoaIOZddeqzUjcdge8aMgk/hI70lCofDpyHtih/ZtEd
         Cz1r6nhvhbPTGP3hOCo44S5CpbsEvJhzWcQUDIIUstw8eCzCIf7sd8duxy+U931ugsjJ
         l8d8R9BHlJoB63L5JBUtphwPNEl0Egsst4FLLvWDwgVJdU0uGXycj5QzplNTdofIRE1d
         xxyjtCCE1vGblCA8lm93QIxp09o9qM02peDxUrjHlrNmkQDUHQW2MmPJ9FA94u9TYhnY
         nrWluqkk8kJXhIZT7+/DOvSFbSXj2zsOcocFrd5JASa0KPlXmhJFDfvHhLzqBpM8i05p
         sJyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P1bL50lNxWo1x/ueBX/G/p1juBW6wsfb8QdUKb7CUxE=;
        fh=LV4aRW/v2+jPLqDzGoXSS2ZNis0zWZvJaswNj9Kho4o=;
        b=ssVCc3laCUa8m7FM4XBvOknwaOOwYzWFemLIRveBwD0Q6Xf/5rKPBxde7oypciNJva
         8pxJfOOGy+GQpA7vHjPPWdvJO3zItINgMCY8I8z7djYIFB31FZ+Sfi3MAzw8kK1wg6Zu
         quBT4GS6QS6ZerA1Ji4jJ8RigEdwMAj2Z667hds7sY+pzLJmSxOsWhA+2POQ38jPH8Z3
         5Yge7wJSQePm4eArWBpuvxB/bmKm1NC9uhuVxn5YAfOlWt5PNIgAEPXrVHT8D+9QpGJR
         vAG4hCJvPGgqxd8R304L0qlpkL0QR66XUPev7o4Ar4rcDP3fvgIZQaTPUDv+UY3VMS2N
         c2Jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793923840; x=1794528640; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P1bL50lNxWo1x/ueBX/G/p1juBW6wsfb8QdUKb7CUxE=;
        b=XfnqDibTtLU96TUbfYbxCvtzm/oJJIQCbBmI/LpLqEe8l1nznTGCGrGkUoIQLd4sIx
         DzKHVznBDwCoDSoyVF12mB5smbU6ZmV7hJs1ZLnGrFbLarghU/CsdREd3XsaB/pYbCYt
         Mr6vHapI3OUTIyTr5vIDXViLJhucujvdDx4mImAbqw5K9BirkbrzZbU+wiSW2x0jooqv
         T5LLy1UnFqfE3wolq8o+Ghnpr/3X55jfnyeC+y6S7TdfLw/bRMuqGhWk62OdnURqB7IQ
         xA4T8SzSu1L3RqXVw/bH/lT1hAaFe/C/Ie100FNLLwvVznwlfmekZEBKKHXOtbT3BBsi
         JiFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793923840; x=1794528640;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P1bL50lNxWo1x/ueBX/G/p1juBW6wsfb8QdUKb7CUxE=;
        b=V35oMhCV3fJ0OG9H826jooHvD66oh6XYRXQuVX4qDzCcTRMEuRAZDfx1CZLDC1pINo
         WD7SrfbpKasOL8lNbVnXL1SRC/bWJ3KQyalQsxk/IEnQtdgZee098uZdx2twMoqav6uf
         jQBzzhWf+OGHQVr8PXZP4d4z+mpkNlacz31BB6IM79WNTXTxd1fz4y3mEke2JoqYsQNi
         t5+JguFTiJkfSHqQwPXNh2abSt94y2z/fz/mltw8ZGZbNqd6VBHJWGdMrL4G9UW926nN
         wlbB7DPaJzV6CcOY/o5bbrLRX/wJ33tQxQ4yhwVSHZpXhwL+ZwJ63+a8z+Bb5bKVdquc
         CADw==
X-Forwarded-Encrypted: i=1; AKwUvBxszaVyo2Bc+HI+M/d5zrv+W+0bju17JZlD02NZ+yiLh49FzAitgGEfD2kkDQxFovnslGob2T4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8npd4FcQK6oK79O7eUww+FwYxSiouhGBItXKKcXqUNpdYi5T7g
	U5rs98i8NKhqNzhminpn1WrdZGSBD1m7BEpOpLtFRIqjoidHTP+0QdNXyD8l/cpXxOQ6vgK3807
	V5sa6ZlFJYWULR3c/vgrIWKIw8RPDWxsFkCAeAZfi
X-Gm-Gg: AYBFou1TKhNVfKQ9tN7CwnzlCqzNUzXvoecUL54Dpn5pDERxzLkjr6N+wAXmuXuQ5/8
	sVbf1o6aNrj8nW7MxSA9I9xR9gAVJJg6SBLEAFG/dacg04M5USJhOYuLqvXsYa8qoppIkIrHEOr
	j6NoYTUSWB6RiokKccZuopeezQvyqg93AsjkWm1KPO2fO1VLW69vNODMHfAg8R+lFLfa2mwVDK9
	QpRUszKfxrhHOZV+NhcPd9laEqXc0FQaxXrmnUH4IW+5j2keEygrquyReE1dpOrGXSj91/L23Pw
	Dvj2Ag6YPBem9Yo7A9HbV3bA3lQGD8rDUfTUSZoAn+V3sivFeCKxFY9qQWkFExVKf2Dij1ApWLX
	nOq75jJeWJ2btVveo/25NqXBchmqcDj0Clvo/vhn+hMWx5BjtF5ad8Q+iZkunBXQcY0sT
X-Received: by 2002:a17:90b:52cc:b0:3ac:ffb8:183b with SMTP id
 98e67ed59e1d1-3b0db6f90ddmr848021a91.51.1793923839712; Thu, 05 Nov 2026
 16:10:39 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104150318.1156620-1-edumazet@kernel.org>
In-Reply-To: <20261104150318.1156620-1-edumazet@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Nov 2026 19:10:27 -0500
X-Gm-Features: AclHuK98rYrPfudZFSat64ObHfvEPYyRkfAS3zcmw2zEmSVc-KwTmWjym9wDchw
Message-ID: <CAHC9VhTSCSV-Lic03yzqU=z6OgVZGKUfdUBfYAHnezkTLqOETg@mail.gmail.com>
Subject: Re: [PATCH net] calipso: do not charge request socket options to the listener
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 10:03=E2=80=AFAM Eric Dumazet <edumazet@kernel.org> =
wrote:
>
> calipso_req_setattr() and calipso_req_delattr() allocate ireq->ipv6_opt
> with ipv6_renew_options(), which charges the listener sk_omem_alloc
> through sock_kmalloc().
>
> tcp_v6_reqsk_destructor() frees ireq->ipv6_opt without uncharging it,
> so each request socket leaks its options size from the listener
> budget. Once sysctl_optmem_max is reached, sock_kmalloc() fails,
> calipso_req_setattr() returns -ENOBUFS, and tcp_v6_route_req() drops
> all subsequent SYN packets. __sk_destruct() also reports an optmem
> leakage when the listener is destroyed.
>
> Uncharging in tcp_v6_reqsk_destructor() would not be correct: after a
> migration, req->rsk_listener is no longer the socket that was charged.
>
> These options belong to the request socket, there is no reason to
> charge them to the listener. Change ipv6_renew_options() to use
> kmalloc() when its sk argument is NULL, and use this from
> calipso_req_setattr() and calipso_req_delattr(),
> like cipso_v4_req_setattr() which uses kzalloc().
>
> Note:
>
> After this patch, calipso_req_setattr() and calipso_req_delattr()
> no longer need the listener. Commit 10876da918fa ("calipso: Fix
> null-ptr-deref in calipso_req_{set,del}attr().") could be reverted
> in net-next (also removing the then unused sk variables), so that
> CALIPSO works with SYN cookies.

That would be great, are you planning to submit a follow-up patch for
that once this lands?  Or is that left for others?  Either answer is
fine, just trying to get ahead of any duplicated effort.

Otherwise, this looks good to me, thanks Eric.

Acked-by: Paul Moore <paul@paul-moore.com>

> Fixes: e1adea927080 ("calipso: Allow request sockets to be relabelled by =
the lsm.")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/netdev/179378292255.488856.69175774518130=
10963@kernel.org/
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: linux-security-module@vger.kernel.org
> ---
>  net/ipv6/calipso.c | 12 ++++--------
>  net/ipv6/exthdrs.c |  5 +++--
>  2 files changed, 7 insertions(+), 10 deletions(-)

--=20
paul-moore.com
