Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21D4490BE5
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 18:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786733339; cv=pass; b=pyAtxzWbzawy/yD+WOQzBNdKCkQihbzVAJa8qzfc5uvTt2IU7s8kFcH7KlNqhz8EMB6zRzKonuvgt06FyXtW9fiwFD6l5+TamUkFNDJwFxFyTeGcBgYI10KPzjeb12znjpOqU3HfKwAcxeqcluyuvjJeKKfV3eu7fzyt73MFL4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786733339; c=relaxed/simple;
	bh=I9s3q8ZXA82bPIvOhQtuHnVHQRr/m2TvRlTkB/2NnQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+D08/PeSofRxUGSYIBc2QK6+0kDZmMQ2EYM0KF7PbLZAHb+dVG609Mj4Sf6dAm4fq3FwkQk5qakrOj1MQsZx2pOj4k7M2eC8dOeTTjkLEBNkPZCzLJ9AgXKsaECy5kBj9UztFeZLKdfRBqtwLYa+kQ2LAl7GkMQPj8rdB6+YqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pqZP5Bpe; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pqZP5Bpe"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d3b440b97aso132225ad.1
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 11:48:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786733337; cv=none;
        d=google.com; s=arc-20260327;
        b=rZ1tAXZvzx1Is9UK5+ZV4sZpwQGuT2tzQCT2dUidFNFZ9uTzvZLJ9I9WgT1QmSq2Uz
         Chy4m81wJe7r+PAPLqg5zrxENNo92yAWF6zJGBzn8vibafJc2AmNKxjFSBQOnUD81EzE
         svXZ1CY10hb3zvbjAy4kAYVQ7z921BNoCaqewqwhZDRe9Pf0NgB9X3d/ElGW+DglHNV3
         TBE2D68qI5/2kzpuLktfxV0EYAkzDNUeCSY9GytK5HEWXKyCW2nZnrQyZcyp/Rg7XoHY
         KjykWguL3VBiiJcWbFM4S5ibR9vzx0ipObrb1LVoeZ4O8meQw2FIspnCQyQAC9ny73dr
         NnLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P9uPj607qSHxZyV6zyv+4Oi7eT0gOH456UWnfHJKdRU=;
        fh=RmPPmL5Sv+FF26oIjBYyWwb38FVvu0Hprmk0nDCLmU8=;
        b=HtYc3nt9Xhtzy5Gd3f9ckzEtzaeMqhXjO/KNuTMc8uwSlLmox5dou6JE7s3Jbjsst5
         mvOdAAkip15J0FsnPjVexNyGDOAS5rsFjFmO23uqGS8ytWMnvbcztwv0+tldfwkXDNsH
         ESLu5N1ogOfXPb8CCb39ITl0I/GYogLGWkjf8LLmkOH29fRZUgXjcNnNhk7neiTVaSqT
         nkUAVgzeByGpWWSYvoAwGUiPGdQXMOuWToMCUN9XrKgCFEOsIaOswCul0apjOOpHEGBp
         alDuQiTezxH2OfCLzMmuBPt/UOiJB97RkXgAyEF5EAEu68KnNBgSSpxr0VpiTUEQlRoH
         jRbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786733337; x=1787338137; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P9uPj607qSHxZyV6zyv+4Oi7eT0gOH456UWnfHJKdRU=;
        b=pqZP5BpeCGVh58kS9yWKxe6uDXUcr+gShwIH2Qb178UDj0/Ghflri6J5Tub4bxSQe4
         oJBsKiUCC4ZrFvd9s0ivFGuGgTRRH6xvy3cN/vgBNyv5w7YCKztRs26yZr0Pq7sS5wL6
         SBW4kefeXneETv//aRqf0kfIPZrucnnrBxhqPona/UAG8JJzNpoSkpVjxrPAiIovRIGi
         n8XAWTO6yY4oG6EXx+7BJrZvkj6GWOnJWPHbdmyjIuBtI10IwfDJonbIFWazy+4CU9JC
         VSHiVOBwKvEMer33re30g+2w7gKDG2+qMl/ns75YBlBbUmLNOqwnaYE4w+CjSztLwx18
         FtQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786733337; x=1787338137;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P9uPj607qSHxZyV6zyv+4Oi7eT0gOH456UWnfHJKdRU=;
        b=mpf62Ztv0Ft1AA4zf0mo9Lh7/jZ72auEiNpzoKcA/f4Jiiw6rqmFjj/UQXlNl85VAO
         boqu7JfEzlrgfXzeBmkAs/TQ7Ig3qWPaCdSmDGZR+2vKfc0CxHcOj8Aowrf0mrSahlZL
         oalr5DCOqFj6p0HLmbUABO9U+QcEoKmRAYWldEHdaV2pZj9jaSsnSWR8ZvY2NkqzMlZr
         b7auBRVTkNtaZSdWw0kykICDiKxDhX4qaHcosfjwmdFrZoCi2XwYuSRR6rJbt7e+m2B8
         OkxamHw6IFKJHY5wSFC/aJKjsfh3cEKmnJxKpHkFmvuhTlzx6pa4uHbyE0k4IApILcRY
         Kk6A==
X-Forwarded-Encrypted: i=1; AHgh+RoSr9QpODWTx9vNoEtn48MzVHkadO3O+Smc7JdvTUfNiMLit6wTBe7iSCWatlLYOb9HUHnD7v4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyve6FKPCbli4Crd+O+wbasKUM/lGEsPX5osBtVFu4m9ezwlw2R
	nq22xfgqmqND6qFCVTwhYjjq4psxmppcEtH1h9Al3sbh8FMPx/RAEG4ROleQFOHPEMQHxbQh2rN
	VypciyAIa/1FU3x4R8CsYmOmy5knvLNWv77DAZHNu
X-Gm-Gg: AR+sD13EaKXrLoQ9vdGoLT5Y1x1medem26oe2OvoN/i2+SBQPKKT52HxRym1NwsuwEc
	I02O80LarGQt/i48N1JWrJkSrzw/fK2Ah6JdQ6FLmxhMAGzyzaD03f10xdeGUFyAYvHnmUZa83P
	LTLeTISpyMWBTc+8n05IkkVn2e/kaL4xjNVaOskApXqgV/uwZYunxRgk23xVycj/KV3i2n+g8Lq
	DvnDnUNuCITUHiUrq6xPFaCrtnlfEr1lEUxBd6mrYQ1xrAFvTvXnSyJoZyvGJKmuKH2o4GbPO4A
	5E5mZUufxqBE3o0aRaVlk2CFN8BTgXqcQRJzwMI9tgWNkoAp4Bvgqf97MTHcDe01yFKo1jwhINq
	ab3qs
X-Received: by 2002:a17:902:ebc3:b0:2d1:1d3d:97c3 with SMTP id
 d9443c01a7336-2d3b49359e2mr9591625ad.13.1786733336588; Fri, 14 Aug 2026
 11:48:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811195405.3979177-1-almasrymina@google.com> <e532f313-447c-4ac5-806d-b686bc9181dd@ovn.org>
In-Reply-To: <e532f313-447c-4ac5-806d-b686bc9181dd@ovn.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 14 Aug 2026 11:48:44 -0700
X-Gm-Features: AUfX_mzw9woDuyub3mDJH61kxslF0GNOWCiAkqjRmWvanKLJf6ChQAcj6J_KWaA
Message-ID: <CAHS8izNahtYM3AFvbNa_coHMb9n_uOz7dJNUQ4LaLpRwmWQQkg@mail.gmail.com>
Subject: Re: [PATCH net v3 1/2] net: core: propagate unreadable flag in skb_zerocopy
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Eric Dumazet <edumazet@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dev@openvswitch.org, 
	"David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Bobby Eshleman <bobbyeshleman@gmail.com>, Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 8:52=E2=80=AFAM Ilya Maximets <i.maximets@ovn.org> =
wrote:
>
> On 8/11/26 9:53 PM, Mina Almasry wrote:
> > diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
> > index ae69b2cabab9e..482893a5f67dc 100644
> > --- a/net/openvswitch/datapath.c
> > +++ b/net/openvswitch/datapath.c
> > @@ -467,6 +467,9 @@ static int queue_userspace_packet(struct datapath *=
dp, struct sk_buff *skb,
> >       if (!dp_ifindex)
> >               return -ENODEV;
> >
> > +     if (!skb_frags_readable(skb))
> > +             return -EFAULT;
> > +
> >       if (skb_vlan_tag_present(skb)) {
> >               nskb =3D skb_clone(skb, GFP_ATOMIC);
> >               if (!nskb)
> FWIW, the devmem integration doesn't seem well-designed.

As is most of what I touch :P

>  I understand
> that it is for performance, but IMO there should be a way to copy the
> data on a slow path to avoid dropping the packets.  Clamping without
> notifying the users that the packet is truncated is not a good solution.
> Not for OVS, not for other parts of the kernel networking stack.  It's
> a uAPI breakage.
>

FWIW, it happens that the fallback-to-copy in the context of the
devmem TCP seems to be useless to the userspace. As a matter of fact
there is one current path where we fallback to copy/CPU memory
(SCM_DEVMEM_LINEAR), and my users decided to write userspace to
completely barf on that condition. We ended up rooting all the reasons
SCM_DEVMEM_LINEAR could happen and preventing that (mostly flow
steering failures in our case).

Broadcomm also added a devmem kselftest test case that fails on any
SCM_DEVMEM_LINEAR as well, so I think they may have independently
reached the same conclusion with their users.

> As it is, there is not much we can do here without extensive changes
> in userspace applications, so for this OVS block:
>

But, a future user could find such a fallback-to-cpu-mem useful. If
anyone is reading this wondering how to implement that, these are my
rough ideas:

+ some dmabufs will support the dma_buf_vmap op which will map the
dmabuf to the kernel space. if the dmabuf supports it, we could use
that op to map the dmabuf memory to the kernel space, then copy the
memory to a normal page allocated from a non-devmem page_pool, and
create a readable skb based on that.
+ If the dmabuf does not support dma_buf_vmap, then I don't think
there is any copy fallback we can do, sorry.
+ We'd need to design a uapi that tells the user that this particular
chunk is in cpu memory. My guess is that recvmsg() needs to return if
it notices a devmem/non-devmem skb boundary, and return early. Then
the non-devmem skb can be given to the userspace with
SCM_DEVMEM_LINEAR on the next recvmsg() call. Then the next recvmsg()
call gets the next devmem skb without SCM_DEVMEM_LINEAR, etc. I think
that would work.
+ We'd need the driver to maintain multiple page_pools per rx-queue
then, I guess. One for the devmem, and one for the possible non-devmem
fallback.

> Reviewed-by: Ilya Maximets <i.maximets@ovn.org>

Thank you! I'll submit another revision addressing the comments on the
other patch.

--=20
Thanks,
Mina
