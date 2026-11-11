Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794405013;
	b=MgC0P7Ek87KR9u+T6QvJprZGy2VOnUilr1rnEQORyTXvzNU0ekI7jo4DoxGHDgPV6Und
	 9seolcu6RkHvVx9xnoiprjVkeRTF6vEd4jXSDC6zJKqNxa7VI3W3iARGDdp0ChOYaKKqR
	 ZdE9DiRUxFQuVPSCkPYbaJDpYqwMk2hFLY075rQZN8k1gCJb2HJYPcGgj4QWlct/NsYrA
	 yDUBSCrLK99n2yb8QooO1w9IR6JtSFzMqWzWr1A3e0kwritflE1EhFTGSEfWO2QbpUzvD
	 gUbs1n4j06xxn6maCo4vXZQXH8buo00XTqL47uT4cuhnHU7OR2inLluMYnWY+3o4kjw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405013;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=LAzqXJmmTPUQnE1+GTZ/b0TQ8axo5J+C46CaOWTj6Ko=;
	b=dTCtr9ID3FlyG2iUXAbhjiRQAU0F8PIv3TP+ivmlYImiIqBE9fHXJEqxA9raGBQWWwGU
	 xYbkBw2jiyT/gNxPfQOKKSLvNiiZ1yZ4yP1Q8qQwEItQuU66u/UuPPGj3PernOcMcySrM
	 hqbw4+epsD30ecUkUJFNwTrWkQtuO1BMZn4PSSSKGUtnOKgbAwKbo6V+LDR+FwDhc1VbY
	 QhisZ4CxZ8Sg3LVXUVtbkZbuvGzs0sZzFaspPqJOgEgmWx19IRsJj5Gyd+iVNIRe8bpha
	 wLXrTR33oHqW1e0um2HQI8ux6L//ImFYzb/sALd8iHKAlKghu1givHkrg1mceP+OEgw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=I6FLAu8h;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35714606A327
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 13:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35714606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=I6FLAu8h
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-150ef97e790so5226c88.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 05:50:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794405012; cv=none;
        d=google.com; s=arc-20260327;
        b=itgoqGn5ROKke36klX1ITFulFJb+q+mDVwY1zF5bdUxkGLPF9+S/ZqcKJapV2pEsH/
         q5Qjjbz7P6jEmES6YB3x0Z0lopzczR3uLAwqj700+RSFszHysfnGl7o1KbU4QW56bUni
         tuuStT5yxOjqa6a4AchOz35YM5AGa/B3GuViIC9za8HNVPjHhszyWEcqfIip0KRgJMPE
         FQKKuRniYGRJP8h0Kujj1Zw9wS4ck2i7pFHoRw2AtODQy8CCAJ4RJBnkvNWKDVGmImbh
         NgXC1LrEGi/DJmTl2w9Z0pFIC8JO/ZX0YOtTeD4jObYBBb04lQEcEo923xE20CQ3IgGN
         xyiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LAzqXJmmTPUQnE1+GTZ/b0TQ8axo5J+C46CaOWTj6Ko=;
        fh=SFTcYCsCDlFlEGPRG+wa19FnQvWvjkx3i4Vm99u/2tQ=;
        b=sdp0VksYrrJRe3g8dOebliBF/5N+4bqpe9iM20f7jLaHBXnBnQfS9B83BvK4AVxH06
         qx6aoE6G5w360/zjff9H/q98hybN1OPiqtNvrY32jeeeczZOTVMDIBrOMt9UVJbQFuEu
         qHM+arR/I/hN9XFTT66o/Cyc+8815AnUjTHJW/c9c9gUFWmPguTlcbvTjLCDmLyAlzMv
         qrd+67OVnZs/o4nEcm9hec6n9RY5m1nm4CQVYNpkg6EFuh7kdy/JaVQVXXY4iK1PXTPZ
         ZumsTva7f4TR0IIA4r3/q4bpfZBfuYyMtA3Hf33tGviPS5v3g3aeNqjxi8hjBya9OgvV
         0zLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794405012; x=1795009812; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LAzqXJmmTPUQnE1+GTZ/b0TQ8axo5J+C46CaOWTj6Ko=;
        b=I6FLAu8h7YdzrfpPOgrUpuCwg/xsc5G2CgfRQ4L8NyYL1YhpiEHmNY/9JlUXimo54g
         VmX88jGl45coA5jluySUPCTsqQ3jWuCnnEGibRLCX+vHSc/o4unFIuWDh2rjSO0MTIQT
         ozz7HZdlWBQv+vgaXsgjhS9UeVpZ98dTkYt+s0mUWdVeUcboaVKp+gSLRxInxacKeZYT
         U28qUkYArAXgOST9LWgmTU3na2Z/0hMHIBK9YMXCHBheyArTEyNDAgYim0n5jUKzKyD7
         M+jK3XdShevjNP6GGoNTpcyUElLGTh7xl+DD9IXuBdgwb61x6kGUgzDPs6pLBVR6h/pp
         otBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794405012; x=1795009812;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LAzqXJmmTPUQnE1+GTZ/b0TQ8axo5J+C46CaOWTj6Ko=;
        b=lPtWScQo5GyE4GZiFrmwqyojEOQH7eKBMcHaPsH26FjGa5AyptSapYsh3ezQwaPRrZ
         l6EOB/qP+owr1I48TRJqD4NLUorjY8Qu+Lp51AhbG9gCy8ae68/12HVMUxttNDInwmo0
         upLazO6ZI/d9RMAhN/Ur3UCSZHgjy9yELEDQGuhsVd7BdCTZumGpp70vCLZYTVk0tZiu
         37BZvszUKifkWHneI1VyNBDvWxo1vhVw+Hz+pqJ5+nrNxwCuH8KfNZXJz+87EcFg/bwz
         1Pgb1MPZNeKZPxG6Q6fjySFfgNu9SMC7iXobtMAQ67Bmw/mAybeYh15q0QxTr6dDiYQF
         dF8Q==
X-Gm-Message-State: APuU4Z8+AWq53TX0UpCsuxHR8enLRW7PNwlInb1qiRDNMOoVsNxYM4fu
	1VOR7h1/RMuzglHJvXU4Ykeqd2OWG311Ic7phE2NJpeIrqkHW9k8pFdJ4HPde6+3J3cWEfn+dI8
	Fo9R7japNZtZM0Wy6oyV2dGS/uF+BPSsbvIYj2Htr
X-Gm-Gg: AYBFou30Y+cShhqdu46Rum42m6X3sz1D4R7WEt1PJ9WQzVV8/LnyOFSGQUgBb8jF8D1
	xwPORXpXQA4NKt8aMNQV5GjX08ZUa/bqL6sGHjyCHpgB+GkAHsG6rY6zAXsDsMKN9k9ce7xYd+0
	D9UKy336peGwqT0tgjeP+Y6Xr3l8syzWFs0sDGrjJ1x80XGTchGdX5a/JUbpPzqpy0soHHCaBKb
	t+yeC/HtLahzvnvrYVhz9gFBW9d7beZutfhIt3fUokKx2F71IDO17DmC28oynKvLflq1+aoqaga
	HqooioEDv6y/4h6iGv7FrjGRmXl5eLdp7wxPMLduVF9iUPJ42DxldPtUlDdnLFv0rsJWOCP9L3u
	1zKOf81GhA+cqDJwxfbkgNa2WdiRVA8wC27bncfZmUxMkqWxqgRvJh53yPBMtsp1a5uI=
X-Received: by 2002:a05:701b:420d:10b0:155:1a18:e9fb with SMTP id
 a92af1059eb24-1b3c03072demr318941c88.17.1794405011103; Wed, 11 Nov 2026
 05:50:11 -0800 (PST)
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
 <CAHS8izOxvUxCND3R18_HfZhB=2RS4_RNfAmx7S=Ex6b5z_CQuA@mail.gmail.com>
In-Reply-To: <CAHS8izOxvUxCND3R18_HfZhB=2RS4_RNfAmx7S=Ex6b5z_CQuA@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 11 Nov 2026 05:49:55 -0800
X-Gm-Features: AclHuK--VoyZ9R5ERWwbbW8Q5Z3TjeeQ1Z3vaLOtqtyXf-txWLqBbnB8sJo4YqU
Message-ID: <CAHS8izNodRM1Bx+FT7okpdeDfCeyJVP5QoyxhSMJWXpGuwyL4A@mail.gmail.com>
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

On Tue, Nov 10, 2026 at 7:54=E2=80=AFPM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> On Mon, Nov 9, 2026 at 10:33=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gm=
ail.com> wrote:
> > > --- a/net/ipv4/tcp_output.c
> > > +++ b/net/ipv4/tcp_output.c
> > > @@ -2692,8 +2692,9 @@ static int tcp_clone_payload(struct sock *sk, s=
truct sk_buff *to,
> > >                                    probe_size - len);
> > >                       len +=3D todo;
> > >                       skb_shinfo(to)->flags |=3D skb_shinfo(skb)->fla=
gs & SKBFL_SHARED_FRAG;
> > > +                     to->unreadable |=3D skb->unreadable;
> > >                       if (lastfrag &&
> > > -                         skb_frag_page(fragfrom) =3D=3D skb_frag_pag=
e(lastfrag) &&
> > > +                         skb_frag_netmem(fragfrom) =3D=3D skb_frag_n=
etmem(lastfrag) &&
> > >                           skb_frag_off(fragfrom) =3D=3D skb_frag_off(=
lastfrag) +
> > >                                                     skb_frag_size(las=
tfrag)) {
> > >                               skb_frag_size_add(lastfrag, todo);
> >
> > From [0]:
> >
> > Maybe easier to not merge niovs here? Add '&& !skb_frag_is_net_iov' to
> > that 'if (lastfrag' check? (or your new skb_has_net_iovs)
> >
> > Looks like it is tcp_mtu_probe path, not sure we care about merging the=
re?
>
> I'm guessing this is not an issue with pages because they're
> PAGE_SIZE? But, seems maybe a bit lazy to just hammer all possible
> net-iov coalescing? Is there a slightly cleaner and more generic check
> ( && skb_frag_size < PAGE_SIZE or something) so that we don't add
> net-iov tech debt? Technically this will be an issue for hugepages in
> the tx path or large folios or something.
>
> Also I think it belongs in your patch series maybe. That's the one
> adding the large niovs :P
>

Actually, this comment made me realize: is the optimization that you
did with net-iovs here (that's showing so much better cpu) also
already implemented for pages? If not, is it possible? I don't see in
theory why the userpsace can't pass in a contingious 2MB page to
sendmsg() and the stack could keep it intact in 1 frag up to what the
driver tx supports, no? Is it worth it making your feature generic and
apply to pages too?


--=20
Thanks,
Mina
