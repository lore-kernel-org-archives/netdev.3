Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793347588;
	b=hbkNyWDat/Gr+cCt8770XmL9PK1HJ1zVCEYiKXqk5C8qD9Hz3UF5WgAGt01QFVGW9+oN
	 67koL0uFOkJFo7nd9jqMGmP5pd5ZjmjS1mTn1v2uNAPUQ6gNV27WLNZVftnnZDCWAfCyU
	 hdIJmDJJKmMMtJ49nL4prhF4XShMkA25igSvrfHHDYogTHamZWqHeiLcxftoIVZxyKV2d
	 OyvtQI7hSUtWjQ+fwLR6eyPog2frSrRZKbk1pZdAnHMSEPsBP9XPKlCeTSdKOb3RLz3Ay
	 QRFB+DswoubeSENzglLYTCpIF7Ww0nA8u7qA6UlRlzQAo6s8UvlplYaAAFYopaVQjjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793347588;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=C2ZirJKo0vypwPPLrNmCiJuDTnWo0nBD9fcFZAsttqI=;
	b=byP+DpExGu5yb2lk2LzZImu3zQ7ytBRjx5dzwVW1qFL8W0CcKY9B10tSAP0oyhqiEFo2
	 tZdHL2kPnhNut230oM8TrR32sEbSt4XXHcBVPNa/lVx6zEcQnQp7ab3A8MJlCckMnbJCG
	 ySlXA224qs0sHp3557E8vU91MrDOyrcpYfOlZQ5wDRLYO3LMEEibrivRE8Ay0nS64JVCo
	 CEHvmbWc7C2jKOqsQeYxX8WvBbGgOfKWDnrVr9Z2YOPsO+C2DgXX2b42PSnVvA0AjPRGh
	 sOEBrgfKu/DNl4xz97qGQIf14nnaZA/J1J9rkGzIc5wVw4tEMOr2l/ejwHSh3k7gSIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n6s7p5xB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7580606A31C
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 08:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n6s7p5xB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A24F1F00A17
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 08:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793347587;
	bh=C2ZirJKo0vypwPPLrNmCiJuDTnWo0nBD9fcFZAsttqI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=n6s7p5xBjOVGRmpnwfG72OJ0wLBDRXw2umZ1qOI8xmzj0xuBovVTUWEbSFN9oPcu1
	 n43di3H+dhghtblDmspmXjL9YdEFQBE2W37319IHlLS0T/a3ztIpKgkGIPH17tS/XB
	 9KCXss4Ry7Bn1JXUnUXx9fbatEUTa1kJS83ylxkd7KvZM9tstakVE74AbzPzSYSCPQ
	 hGTYjsierdY6dC1hnLohDTzGKAJVfFWs4yfchgriLW0U0NN2cc2UcdzmR86Dq8+zlY
	 F+6WEW0Sxrp6hN4lg393xIW0aOwD8CFMY4M6Qz0Je4zD+X4+Tv+MpNr5lDwkRklxi3
	 XGT2NWN8nZnZw==
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-8256106635eso235391a34.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 01:06:27 -0700 (PDT)
X-Gm-Message-State: AFq9FYLtJS2k27MpaUrYl/wdh7rpXw4QNw1swPkdHXHWJx7Wn2513Llo
	950YCckdN8VLBPZfLHGUoM+UgH0fR5pcw3b/UAu9KbwSQthhYHMvyFX53DPMecMIHCS+sB+E08w
	ZbDr2vUYFM5XU6psVA+T3xVRSvhViZMM=
X-Received: by 2002:a05:6808:11c7:b0:539:dfe8:9960 with SMTP id
 5614622812f47-5640de0f2bamr1134379b6e.56.1793347586555; Fri, 30 Oct 2026
 01:06:26 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028182934.2236310-1-edumazet@kernel.org> <20261029153539.1224463-1-wang.zhan@smartx.com>
In-Reply-To: <20261029153539.1224463-1-wang.zhan@smartx.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 30 Oct 2026 09:06:15 +0100
X-Gmail-Original-Message-ID: <CAL4Wiip-ejpT=8bswZBYM1DE32WhJ+cbhjP+N_EnbPtcFRnjFg@mail.gmail.com>
X-Gm-Features: AclHuK91IS9jZ21-erii4HBfZqZ3TIi3m-ItxwzPgKEm_mQVTWJaDnsYN2Q2QfY
Message-ID: <CAL4Wiip-ejpT=8bswZBYM1DE32WhJ+cbhjP+N_EnbPtcFRnjFg@mail.gmail.com>
Subject: Re: [PATCH net] inet: frags: limit the truesize of a reassembly queue
To: Wang Zhan <wang.zhan@smartx.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	stable@vger.kernel.org, Kyle Zeng <kylebot@openai.com>, 
	Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 29 oct. 2026 =C3=A0 16:37, Wang Zhan <wang.zhan@smartx.com> a =C3=
=A9crit :
>
> Hi,
>
> On Wed, 28 Oct 2026 19:29:34 +0100 Eric Dumazet wrote:
> > @@ -510,6 +513,7 @@ int inet_frag_queue_insert(struct inet_frag_queue *=
q, struct sk_buff *skb,
> >       if (offset)
> >               nf_reset_ct(skb);
> >
> > +     q->truesize +=3D skb->truesize;
>
> I am not sure whether q->truesize should be cleared in
> inet_frag_queue_flush(). Was this intentional or an oversight?
> Although this does not affect the fix, after reinit q->truesize includes
> fragments that have already been freed.
>
> The call path:
>   ip_frag_queue()
>     if (ip_frag_too_far())
>       ip_frag_reinit()
>         inet_frag_queue_flush()
>     inet_frag_queue_insert()

Good catch, thanks.

This was an oversight: inet_frag_queue_flush() should reset q->truesize.

It is harmless for the overflow itself (we only over-count), but a
queue repeatedly reinitialized by ip_frag_too_far() could eventually
hit IPFRAG_TOOBIG for no reason.
I will send a v2.

pw-bot: cr
