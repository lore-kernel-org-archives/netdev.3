Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794369268;
	b=dbme+PLib4LJqCCP2OLhcpGaau3gnWEU1OwVEd6ztTpLzg05ijJj6K7Jpuj+jcDPs/PZ
	 yWUiHhoT98eF9Gi4JivrtfdVSjTaf1Ndnb2JuZmQha4eEhZDyYek23wiww6/kdZntVylE
	 ix2XB8gFe8PZu0QPvA4vNirCpoH+PVSVnBsiMohpgowwPGWSTUVGmrnLdZs4ZqNdv8Sfp
	 Tbd/VpXcrGPiwAqAhN8guoQL8LTUUic4ZlB1Q5oeAthXxyYOONc5gJ6510Kty1wC/n33n
	 ZNGYfu21rxeDPaqYHoqR94DKh0WZP5csXAfVVpYN2rLItsoAhDkE3PzKDb3irNFT1JA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794369268;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Q40CG4k2plWZZZHeVxKy1553B7ISjHFgclJYmcBytJs=;
	b=qCpUeRSd4tUHM9+FPzDCOdxr7QuMfLjUKaQBSsptNQ4DZ547CB8fwbbHTxZ3KVtZ//Zg
	 WJtM+iV7SMaRIj23GuhsbUfSgVkcKTSQhJFaAgj7MOVwPza88omkLoltTmbARi07HwcWa
	 6nd8yUj7cDwlAyWAhjH7prAKS4TV/s5iFlFi5rbtD3mI/x85K2TjrnxS0DSKx0QFnEF49
	 IEYzDuSm18cLI6D8q8IHUSJ5e/LwIUv8jSzrEHmsKtCfVjPMR7y54ar2rHLaSVF41sNga
	 eGLosyKZnUwVpVUiZByPvTAzXwebqjL0uJJ6/1zXP+0QeyquBSLs+bMN31+nATCTt3g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QbLaQ78J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDC5606A320
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 03:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DDC5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QbLaQ78J
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1b0739d31b9so460c88.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 19:54:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794369266; cv=none;
        d=google.com; s=arc-20260327;
        b=WhkP1CjYbquaEQSuvTZ66LJcMFg7O6vHVLg9D2xyim4aRbXQOAXdBBApGsqgH8vurV
         uzf7ZBA3OsjxaX1V4mahm+y2avckhQ3CEgY18cOA7kIC4L2p6xlgoSe7Bvju3Jsp7Gwe
         H/hgaTy8Sb0cWVpryxZ3CjkfUJDioeY7tQnQ5Bp3LgV36mDkpemZOTdCyjpuQYzrSyIV
         edElHZoEa669NQd7vqaVyQ6U3ldURaujXPedUDVP5F4VBeFg4aoWLaVTmnTok3g67QCT
         E74iFW2Q4DL6xaw/gcpMU0Dk2cGJx2HbNc8gByVazIp+twmK7GIf8GuaucFy+0TYS6yb
         LruA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q40CG4k2plWZZZHeVxKy1553B7ISjHFgclJYmcBytJs=;
        fh=SFTcYCsCDlFlEGPRG+wa19FnQvWvjkx3i4Vm99u/2tQ=;
        b=Rkb0NszofRj1KHXRWN7bWgMjEIxnYkD/lOQ9bt3DB6oE0c8hlecmTPkud/y1Q/t/q4
         8y8F2bl8YXzTySblK/Kb2oJ5XTHc9Ht0OyzPwduM0Q3g/hHxjJZPa8MBVwSMxnIAFa6o
         LmUcoTuFXVeNmN7TeAcTLPWMepMFpwqXId/DHKmDFmX2Rv8avjs4wtGDiNIB6QW/Z31h
         M95aSnbTRmS2WCiA8jwF0zJrmOetYvje1qLTVyMmAFmhvPZUv+0vo1e/lMJe8Fy3YS2n
         9xMT194w7Z5jjOQTACHEQ75QSzknH8Hj2qxG1BwCWddynWabmH8nVoZvgNq6KSnPQmXZ
         UygQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794369266; x=1794974066; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q40CG4k2plWZZZHeVxKy1553B7ISjHFgclJYmcBytJs=;
        b=QbLaQ78J3j5IRaccLWErIYIP7lFdwJcEdAsaCKFo8ufMt0QKCdlz+FDOjBBiLoxpJI
         X9RjD2rUgotcKWWUSNrvElCmti/cazFK9MEPaOcWnxbNA+q2c0a6dqHd/KGAzMvJOxFN
         qO/P91o+WQBIVS/DKLdYHL1GbtRlCQAevdy003/9rH5ihAJbw8CcY4PuCHTJN5wQpc8y
         bfqFWAsLBZkmF7XV/hBzNO4xcbHr5e4kiSpeAhCkmzLtMGlEhGOTtNnseubVKSUGLZ60
         Eg2n9AxPO7Drz5B9+6+OOXY/Klx0DnCb4K9PW+XXLQq46K+26+yAm8hJWTbi39v0Aw9h
         uAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794369266; x=1794974066;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q40CG4k2plWZZZHeVxKy1553B7ISjHFgclJYmcBytJs=;
        b=ADNdy376tdzb4mEnNf4UkIh4O3PxidpkquX8U8n2v6LvmfajBBOpCZVwPWcwRco4S4
         96xoH+a43ym/+4F/SkEVl6CJ6FUC2x+zz8LOMnqv9RzqSey9d9jZ5PcJMIUn+ikj+t6x
         lRWJrEnJMcKs9o1t83MvueobAMq964a6KXBw1ri5b+lADyoHjNd9a+tZ5aOS0KudAHJe
         BE/YtjgdN0I8dFNeiq8Gzd7x8SRsybmGvJllW93L/xTpaDXyYABlKI2hgafCkOfM9dMC
         RuSAwi0wDZ/JUlk4rFNTnWJugr9s472qTDNEO+J2KCw/sLTu73SwrsDLbUVrRRiLryyp
         tEiA==
X-Gm-Message-State: APuU4Z9vuxj5w4DnSmgAt/Whoosv7N/W20vFsx9Sf/X0SQsAtKGHb3Dr
	YCD0J8iac+FotBljyJCk7jMumBjIBThU0kzDC79kmBP3KFDoB883vGmJfcudufMFPAorj9+TZK3
	7405mVK2FxL7No2bQkV8IeKAx6P18o4O7sda5ceGYVtLJTlqRsfoOb4ia
X-Gm-Gg: AYBFou3xHXZK49EgN5lSh70xYtQC0cDZD/fT5knQQeqoRcboLcHAXjlsLQoTnpBz0ps
	mEhhQMWTx0SJ4oOO289NNZ122kmxBf7UD+4ftEUNxUjYZ9Nmx/qy8+RUa4OljD68VNiT4J50jD6
	15AriTKkzITu0nUN0vqYg4SZJzcdM5NwjIK42CYm9a5VHOg1EL2XXNxzoHK0QzDG7KJjAKbb4Q4
	sJ6tgepyejPfd3Lp9OLoMXTiylOKf75QtERIeWWyBlvrbcT1CA370aaCNZQ7Sb5esOD20HIHmOO
	v7T7qZ5A4/wFPjiTe5hR+CZetrBb2vWeBiJr8CLbFBtgvHIG6jUgHUanKPUspGO/ZbctjYKHx/1
	+hPn0Ox9A2aLiLnSEKTeMoT3PL6zA8AsmlbpQk0Y9SVQSEUjxq2g6wIIy
X-Received: by 2002:a05:7022:287:10b0:184:da92:298d with SMTP id
 a92af1059eb24-1b3c02ec4eamr144581c88.14.1794369265615; Tue, 10 Nov 2026
 19:54:25 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108013838.1454450-1-almasrymina@google.com>
 <20261108013838.1454450-3-almasrymina@google.com> <avIRJ3vdIj6Jr9zJ@devvm16445.scu0.facebook.com>
In-Reply-To: <avIRJ3vdIj6Jr9zJ@devvm16445.scu0.facebook.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 10 Nov 2026 19:54:09 -0800
X-Gm-Features: AclHuK-JtIAVd6VP5d7vzEq2SapeoytwLPH4YiLGKJljtfdYyoUDCkIMXYehBVU
Message-ID: <CAHS8izOxvUxCND3R18_HfZhB=2RS4_RNfAmx7S=Ex6b5z_CQuA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] net: prevent mixing frags from different
 memory providers or bindings
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, linux-kernel@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 10:33=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -2692,8 +2692,9 @@ static int tcp_clone_payload(struct sock *sk, str=
uct sk_buff *to,
> >                                    probe_size - len);
> >                       len +=3D todo;
> >                       skb_shinfo(to)->flags |=3D skb_shinfo(skb)->flags=
 & SKBFL_SHARED_FRAG;
> > +                     to->unreadable |=3D skb->unreadable;
> >                       if (lastfrag &&
> > -                         skb_frag_page(fragfrom) =3D=3D skb_frag_page(=
lastfrag) &&
> > +                         skb_frag_netmem(fragfrom) =3D=3D skb_frag_net=
mem(lastfrag) &&
> >                           skb_frag_off(fragfrom) =3D=3D skb_frag_off(la=
stfrag) +
> >                                                     skb_frag_size(lastf=
rag)) {
> >                               skb_frag_size_add(lastfrag, todo);
>
> From [0]:
>
> Maybe easier to not merge niovs here? Add '&& !skb_frag_is_net_iov' to
> that 'if (lastfrag' check? (or your new skb_has_net_iovs)
>
> Looks like it is tcp_mtu_probe path, not sure we care about merging there=
?

I'm guessing this is not an issue with pages because they're
PAGE_SIZE? But, seems maybe a bit lazy to just hammer all possible
net-iov coalescing? Is there a slightly cleaner and more generic check
( && skb_frag_size < PAGE_SIZE or something) so that we don't add
net-iov tech debt? Technically this will be an issue for hugepages in
the tx path or large folios or something.

Also I think it belongs in your patch series maybe. That's the one
adding the large niovs :P

--=20
Thanks,
Mina
