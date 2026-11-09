Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794255251;
	b=oA8RP839OShUhuWV5djfTh12scp6tF7JVuQYiPJoP9oWel4CdpIILhnN+iSBKzDRZHBx
	 sr7tskCNjAQcj7BHlbYeOj3VhtbIEtDhx4aCaNYYSbNn1wNjpo39O+TENlxPs2nqs+kN9
	 Jwj9IJfgj1cf10BIzy7UzZtu4TiP6qQrN+XzoLWXmRAVipqLXeLs+BOsTwprwN+nFy7hQ
	 EJ+7GDLkm/6TUzB1f+N3bCyVBqi90DIypf0p4m/0hSez55dJ+UiXO+GkUiy9jp866JTcs
	 Pw26tQf97c40vtZqUjBiVDxkQAbnrBzjaUR3vTR9GEjiZu+/6aRadJnoKC5LOfoWIHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794255251;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=VXIL8vk5nLZY9woNoUytKHIxYR4kPI/WQboSs45p1R8=;
	b=Nc6Va9D6SF5mJq3+Q1zC13wxtcHx2KysMFSZ1MM/Y+0QVNv34lxOFVy2TkIgGFooT8c9
	 qxVAd0EiibZAitbhYnv405T1YnaJAl6a2nkdXB79DVtmtF5FvkLyvAO25EnMkI90PjirG
	 RL2KDiAeEHw6tpBMxvBvye/CnYoigedHRjIf8K8+4m0iiDrax3sCSQurXQ9SS0T+9yvWZ
	 X2PaK9ModJM8qcipU0RyfKuvhJVhTPESPyzAeNI/SbRogQB/LS4T7aJLCNKgyvqfRy8g1
	 7g2yZN5wjOmOAy00D7LMAFLJkGj+x3YNsvdJNnI3pBLQpc0V+sRhP2WNHPUJzIx/bzg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=bPMMvzll;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16030606A325
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 20:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16030606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=bPMMvzll
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so585978a12.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 12:14:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794255249; cv=none;
        d=google.com; s=arc-20260327;
        b=sKEZ6xJ6i/Dmy1wn3M4R+amW2aSqlGfu/0uv8JffCZHFw+u2zLeaB4ZTBJS2Agn9mT
         hgZCCIyfipTSx+lQM1e9GkypeGzMywOJiT73+dXf5LMzJWWQYCDh9pKM1EVoWQpkQ9t2
         +WzqBk9Lx5mT6g6n4Tau5XkQZpyDbhsD2KHkuoLjbFhWcB7QtvNe90QWe6gCSmYBgXU7
         eBzKPgESlhwa+TuoRNeJuj+MKqTjxbOiOWdDNJhuvzM+CvcRysinZFYJRebabszx2JaU
         TxVNAsKJLCDhr/hlQHDcyfgaJkorzS0iecSwp0v5ikI4YU6FrQ5CTb4+L6z7wz8TPLjI
         N+Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VXIL8vk5nLZY9woNoUytKHIxYR4kPI/WQboSs45p1R8=;
        fh=FZ49WT5qDCBwuB2I4/APkYNERGoSb4jP+m7cNa2IJjE=;
        b=pEk4bEYylzK+ffwKmXzcMBaNXHEHv3MHIVTRnb6BLDYezSzD7SnIsSJ77Vl+0y/C8C
         4MS/+nxH39n+B0oHFjtElhr0FYKXisqXpChTQaP2ZF8hAGyBRMNlb2S7asea4PckVG3H
         0rbVTKkuTBVr7kWu1I4jG5ZHyaec9nMLqVwvLixc0kwTtmnNKx1x0chudmcWR7qeqqTn
         m8baD+5EgVuF7PoY86xj1uAMZshwS8680Ea9Syu7bjT6ldxfQhlu/t5heXFjXhlyne+t
         hJwdhFFDk6sv+gRvGGVyOWEY/T4OA8cmEAOTqudwNj5b2YEdUj4uhtc4uqqkuN9EYnfs
         wQvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794255249; x=1794860049; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VXIL8vk5nLZY9woNoUytKHIxYR4kPI/WQboSs45p1R8=;
        b=bPMMvzllU0yTQQX3RK6h5UbI6bmYfHGmNNP5VaRJ5GDzkjEjLchbGFjBkHWEHWVEK2
         UVDCQ/Oq+cuY5K28yKE33O/gdrHWK2TsOlIpihV1+nrZJAk6wpYBe72IS4kJq9D9D7S/
         C+ATpmS4If8e9tGs/YMSBnDvsJXO5L48Wfr0GIxatVJTgOHI1eAkPn5yJpjzpyWSBJzH
         EE2xD9Du9nOx8VLIHcCMDu84GpRqn9QthLL6xH79XsJhVZoG7KLfwySEMsHLt4TvjAaa
         B7CkeP8mxW9zMB9eeQzgd+Hh+Tq11ml6UIUa7rXVebk4yGV1EII2xqGWl+Y5bJhJyz+N
         8V1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794255249; x=1794860049;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VXIL8vk5nLZY9woNoUytKHIxYR4kPI/WQboSs45p1R8=;
        b=1yqrskBiyZiqcE4FpnGsY9BT4O1P9FeFnX5vv0UwNZgXmOZC2P4RmhpOK90woQOd6/
         Bvmxh8pXzVA8R+gzbP+BlKvuUp14JGr/8FpXQtgCLA3zSIrRQbnICttrLFBv2oQjnewF
         mVtSVaJzgwhNy8ov/aB5ZOqeIvCaOzqyYUHv5i0+se8vf6GWRrdyqHWSmF050NufQHa1
         vFPck1N9jCKjMS8/4WUagqQA913rDowWgMyz3RLK5MtoxL7OfxV6TZBTaItLWYB0gfB4
         adfsd2gjj8DlyZSpbqcqxEPxbhJcCY/PRhNxwikoA0jQ67c6ZbYV6BJ0bOye4Es89clh
         2r0A==
X-Forwarded-Encrypted: i=1; AL+hErHIFJcXnAXswY0VyEg7Iabr045SdAYkNM5pdeDSaTjx4gj/cDHC/+Rb0otLOWSAsEEqhT5PV+M=@vger.kernel.org
X-Gm-Message-State: APuU4Z+7NEMWweeVnNTCveNLLu2OKEBJWbaMC0nKwZnKo67EJ3sU4lYy
	mHaJt6ZCY1MUQcz4elWrkGJuCKfuAH0Vqvm58rpZfHJvj3/yDfL1irVnVrUXFn7io4ekIsVu8fK
	4fvn7S2MeH4h31g7kc5sPUxINn3N5t7hHb40bibo/
X-Gm-Gg: AYBFou1INcaZ6sNy6sskPcd0jqSBdvcfTdP2yEXZ0JGX5G+ZLPt7pOvfzHbLPmo+Twn
	lZpvWwt9tRQqkX6K1Rp42FDp2xaRS5OImYovacYoONx40+ySePEK0drRhftkZwE7wxqnej6zYhg
	SqzESxKyXUi6Ou2pP5n06xoqUCYLncKPpBmUKSMteoCBxhP9gxekKA3M1Nes07a3RXptkGKGG96
	k+AID5NOTxwylpUsI1Zb/vRtgAPZLUBqkpnLsAkOQR6rRJwlpoqw5B0at7m43NkvE4shlGo2HgL
	Tpsjl4AnrZ/CVFRS7JSb0EVuXYxqJOABcsra9IaUNH7LmM9WvIYYejpJECKGhYoWlPnguJU6vXM
	C/sHkJywcxuObZbQaz/tdcnDIF6Da+UWaS8+0cQnDfsnKCx0GtZAPGBLHT9N6m9RC4ZyJ
X-Received: by 2002:a17:90b:4c49:b0:3ac:4e18:238c with SMTP id
 98e67ed59e1d1-3b166d1dfe4mr716868a91.49.1794255249343; Mon, 09 Nov 2026
 12:14:09 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106-cipso-rcuopts-v1-1-31ae931d7a0f@google.com>
In-Reply-To: <20261106-cipso-rcuopts-v1-1-31ae931d7a0f@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 9 Nov 2026 15:13:57 -0500
X-Gm-Features: AclHuK_EGvlYUSv_8gjZT2YZHLuHJRnj0DOmSE59Zf5Dm3hlbe4f7hFETs2MdEE
Message-ID: <CAHC9VhR+U3i8xNce8Ps8k76EZr_AeVf+fHET_Ncu1+yO1G2zSQ@mail.gmail.com>
Subject: Re: [PATCH net] cipso: stop modifying live ip_options_rcu
To: Jann Horn <jannh@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Simon Horman <horms@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	selinux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 4:40=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> cipso_v4_delopt() operates on the ip_options_rcu of a socket or a request
> socket, and tries to remove CIPSO options from the middle by moving all
> subsequent options.
> That's not allowed - ip_options_rcu can be read locklessly and must alway=
s
> be consistent. For example, ip_options_undo() reads trusted offsets and
> length values from the options buffer.
> Fix it by doing the modification in a copy.
>
> The core change is in cipso_v4_delopt(), the rest is ugly plumbing to
> propagate memory allocation failures.
>
> Triggering this bug requires that the system is configured to use CIPSO.
> (Setting up CIPSO requires privileges in init_user_ns.)
>
> Fixes: f6d8bd051c39 ("inet: add RCU protection to inet->opt")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> I've sent a separate mail with a reproducer to Paul Moore.
> ---
>  include/net/cipso_ipv4.h     | 11 ++++++-----
>  include/net/netlabel.h       | 11 ++++++-----
>  net/ipv4/cipso_ipv4.c        | 16 +++++++++++++---
>  net/netlabel/netlabel_kapi.c | 24 ++++++++++--------------
>  security/selinux/netlabel.c  |  5 +++--
>  security/smack/smack_lsm.c   | 14 +++++++++-----
>  6 files changed, 47 insertions(+), 34 deletions(-)

Thanks Jann, this looks good to me.  In a perfect world it would be
nice to get Casey's ACK on the Smack changes, but since they are very
minor and basically just pass the return code through I think it's
okay to merge this in another day or so if we don't hear from him.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
