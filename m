Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794349990;
	b=kUp2X6uKSTfEJIYoh1vm6g6M1tAhPzkXzMFLVHQNOzcqWfA02O/hqINLW5OuiImewjkF
	 QuTtU0U4PWDBOd19xrzsC/3S6xRMnpVqXSv3JyHPHg/8hd+hoKyBOnx+bgvN7l/82HsQ5
	 lc6wnYk1V8dFTftdvhu0FGQ0pvWIV+yKQXD2aU+nUPWgcvZIP+7LWKOEqezl5+6ayu9wb
	 CnNefjHYtM6/lKfE5b1Qx0oojKGjBrzSuCgD1NiJ4X9DGkigfWI3GNfhWHnpmVZ/4lqHP
	 2WJB1o3dI8pJ146Yp3Nl6dcHtdYRShZPBY3uuVCzyCYw7eE9eVTZ4f2r9pzjRNFz+sA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349990;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=flsDl0AnNHUvCcoNHLrrBISfJL3XvqvIoHllO7zT8b4=;
	b=ijQs/FdSPKjlPyFwSgE33pXQoi/b65U1hucmmMHLK8tsCZhAMDYGHCY6LLwdv1mpz941
	 dXPbeHehytxfcb3huvA2HFunILvFV9BDbHSMSKcgK5krg0bM55b3uM2544q5cjUuo6THT
	 JhtGKpYIto1DBm0o8RwGFulWQcs9/1OXpkmDMHoUWExwO3nW0Rt3vIYHSlM2LpzRoooP9
	 XOb2qH2LYLIOn0vJs5LDZR9LoYuVFAki9I3KwTue3uh4trSWvQcNnv9pj6YcvPtxS15Rg
	 eJLWOQXXpxplRYs1JEPVd85E0eIVkLMXZF3UFvVrSWvSTGLf2nYPGUz2oFFdxHmSYMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=F08+EJEU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220D0606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 22:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 220D0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=F08+EJEU
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8b6399ebb41so2275284b3a.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:33:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794349989; cv=none;
        d=google.com; s=arc-20260327;
        b=LhWZsQE7ltsjsZjf1V6zd8/KI/E3RP1DKgwC2Z4KoxiRmPa2jvC3v/EpFtEV18mk0t
         gtWXgcBNAU9zSv+gUuEsmNZqHplejI3CK7zX2k1e3nsbIh5C+QA6171guST86CjBEQts
         EEQr7fj60BJf0M1ajRIh2Ng48qS4hh5VjaVlXY714Gm+ry/ewpRIyBEu84EEOg+hnzxN
         U1sP+mS9yeDPAPgkVHPaJzIdEIYKzE0BhNYIyzO0ZraoGQ4cszQ/n9nzRpDTgpqnCF9B
         0tph4XCY+NearkCXwxXqe+ymjduHHFZSITfKorw5gNOyqvFQHr4+dMwYOx/el3S7I35J
         A9wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=flsDl0AnNHUvCcoNHLrrBISfJL3XvqvIoHllO7zT8b4=;
        fh=dgMgm1FXvYzhY1YvXqN+AqIaKvT6t5/VoZaIiv+S5+M=;
        b=MrHTY0OqZL9YvwFQCwd7bOTVa3fyVaknHx2QBcDsCL8/+Vz5HYqI3kXeSFMdR0QCe0
         3ztOlTRYJfHlpqUvNQJi0wQJnMRjUzLRl881dQaF7E0DFS3n3M1Sjweb4l/5Srx41I7M
         gILeVQ6+FZI0dEQa/13AaTbtOfqfNhonWAI1m4Ueq310AnKp1xtVWUhJUErDpmuQBUgl
         itx2pCjrF7TM2EMyH0i+wkRX7D7riov8TS5ZdghQBlOmScJPjetagMmorMKErX9su0PH
         ufei6vVknJuGaUsvos0gWkt++9+hiembntSysYJjItJJlBAAFtW7VXQU3eHXqLqYRcLI
         rrHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794349989; x=1794954789; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=flsDl0AnNHUvCcoNHLrrBISfJL3XvqvIoHllO7zT8b4=;
        b=F08+EJEUK9fLW14ynykYrijoOtoZIm522aGAqISOKyP25nkzWgQnYh9gOgz67huMW5
         UWNiC1aylaXv0KQdyVnIi+Sz04RdFjtdPHsDlfjkplFHs1iojLDmTV7LwV+H3mKacDpT
         uxDeS/MVzItzzLdCBmiFghU8EyGWWUQwoUUqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794349989; x=1794954789;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=flsDl0AnNHUvCcoNHLrrBISfJL3XvqvIoHllO7zT8b4=;
        b=Ipni4bMetS6H2hhCoiqt6o0D9jMkHw3xajtag3E6tWdVjsou1le8CUCCSSBZL1AFhO
         PiAjCzKIg9puG8V6uQB67Q5C+LM1R+LhDJVVygaCleR4owEb3O3DsDcg3a1LzwUFn7Sq
         a5+vB0BMDeQOTx9/WufnsM3D6JvB92RsxV59M/iOMPWjCOJtbXT2QWa/HkvMcR89a5pc
         8zGByYc2vG97yt74nnotXYxmu0c29lnE8dLQ6MI+F3hado1shHB7aAjCGPq9m8a8qM2D
         hFb5ozraRbOcs+2QHrQRnaOrE2hUZEjadje5unU6FQR65ycuw/IbZ4u+wbUxvnUq4/2d
         HMSg==
X-Forwarded-Encrypted: i=1; AL+hErGMslXk/od2Q8YtdBWX7JRK4GKyvczRG/aaGk0Rp8YWwsozExPW6T+SjQ1Z7ZQ3H3snHifistE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9O3O5QCL1E5M300iT+0vLoqxSB3mgpJevNEEygU6BXTrsTDH4m
	QHI8RtmuDY2WgslmfumNnfI7l1ckfW8078r9j31q29jZqF2Ci/Yzkf77a131fw+aooiaTSdAiGB
	xH0iau5/bkj883+ogus9oWEzl+HshDWbiFL7he6UR
X-Gm-Gg: AYBFou1eP6NRNKQVbLKqzkc4YOwbXtiQqSIJYx2Gj/HTCYxhqvo+Vp7WHd7rPsMknej
	3sMKvc7oBh6I/mOmKiurC9+9Pb4f3cUkPX/172I7lvwnms7D+q7ABTKMruiAwfY+0xwny971aqQ
	zDfJiV4GjxRy5lTmrZzUZFuAAR5rQXp2RwyknrRO396DSkzaUoo9R8zqt6PcjW3jyhwN97Lq97h
	R/elaqK9xvhhIgK4lEJ3MbtewzxPJBVniUVBCX0eP4qvbQq16m6RWsIUQKdglnc56rO2XxewE3y
	FRQbiAGKdFlBXKMGQ3YqJ/jMmJKbTGwOwgd9AhDF6A2GHD+jfHRYju/ehO8SlxWxLwMaJZeOqnu
	d8TNWu2phTJoudE8nqMIeou2VrbXRpzKYm/MvhjLHYxMlllM1TC3VEwrgkxY5ujg6AJvvG2yf0L
	l1zfZDu3u/fpvMKKFaLcVE0ZQNZB6H/y9TmWuM
X-Received: by 2002:a05:6a00:2e12:b0:887:17f3:94f7 with SMTP id
 d2e1a72fcca58-8bc19503faamr552145b3a.1.1794349989347; Tue, 10 Nov 2026
 14:33:09 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-7SHE.v1.r0.20261016101330-1@mojatatu.com> <e0f4776a-0457-4069-9f79-3c97de2a54d0@redhat.com>
In-Reply-To: <e0f4776a-0457-4069-9f79-3c97de2a54d0@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 10 Nov 2026 17:32:57 -0500
X-Gm-Features: AclHuK-spBA862Eovuh6pnQugV-XHvQo1100LNnKmhxZjTsPAXGBi8ayTmt5Q2c
Message-ID: <CAM0EoMkX66gxD1Q+8eONLfDgSmrYwNnOxm6eaBkeAD9ZE4E6cw@mail.gmail.com>
Subject: Re: [PATCH net-next] net/sched: em_text: pad the text pattern in the
 ematch dump
To: Paolo Abeni <pabeni@redhat.com>
Cc: Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, jiri@resnulli.us, netdev@vger.kernel.org, horms@kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On Wed, Oct 21, 2026 at 9:42=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 10/16/26 17:01, Victor Nogueira wrote:
> > This is a follow-up to commit 9c572a83037a ("net/sched: fix potential
> > stack infoleak in em_text_dump()"), which zero-initialised the dump-sid=
e
> > struct.  Sashiko separately pointed at the unaligned pattern tail on th=
e
> > same dump path.
> >
> > em_text_dump() appends the text pattern with nla_append(), which is a b=
are
> > skb_put_data() and does not pad the attribute to a 4-byte boundary.  Wh=
en
> > pattern_len is not a multiple of four the skb tail is left unaligned.
> >
> > tcf_em_tree_dump() records the raw span as the ematch entry's nla_len a=
nd
> > then writes the next ematch's nlattr header at that unaligned tail.
> > Userspace walks the list with RTA_NEXT()/NLA_NEXT(), which rounds each
> > attribute length up to four bytes, so it looks for the next entry at an
> > aligned offset the kernel did not write.  The ematch list is therefore
> > misparsed as soon as a text ematch has a pattern length that is not a
> > multiple of four.
> >
> > Append the pattern with nla_put_nohdr(), which reserves NLA_ALIGN(attrl=
en)
> > bytes and zero-fills the padding, so the following ematch stays aligned=
.
> > The emitted ematch entry then carries the padding in its nla_len, which=
 is
> > what NLA_NEXT() already assumes.  em_text_change() only checks that len
> > covers the struct and the pattern, so a dump replayed as a request is s=
till
> > accepted.  This also removes the last variable-length nla_append() call=
er
> > (sch_gred's is a fixed-size, already aligned struct).
> >
> > Conditions to recreate the bug:
> > - CAP_NET_ADMIN on the target netns (namespace-local via unshare -Urn i=
s
> >    enough)
> > - add a basic filter with two text ematches whose pattern_len is not a
> >    multiple of 4 (e.g. 1 and 2), then dump it with RTM_GETTFILTER
> > - the first ematch entry comes back with an unaligned nla_len and the n=
ext
> >    entry's nlattr header is written at that raw offset, while RTA_NEXT(=
)
> >    reads an aligned offset three bytes later
> >
> > Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
> > Closes: https://sashiko.dev/#/patchset/20260918133953.12494-1-bernard.l=
adenthin%40gmail.com
> > Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> > ---
> >   net/sched/em_text.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/sched/em_text.c b/net/sched/em_text.c
> > index 4132f8c3c5fc..fbf78d61f109 100644
> > --- a/net/sched/em_text.c
> > +++ b/net/sched/em_text.c
> > @@ -125,8 +125,8 @@ static int em_text_dump(struct sk_buff *skb, struct=
 tcf_ematch *m)
> >
> >       if (nla_put_nohdr(skb, sizeof(conf), &conf) < 0)
> >               goto nla_put_failure;
> > -     if (nla_append(skb, conf.pattern_len,
> > -                    textsearch_get_pattern(tm->config)) < 0)
> > +     if (nla_put_nohdr(skb, conf.pattern_len,
> > +                       textsearch_get_pattern(tm->config)) < 0)
> >               goto nla_put_failure;
> >       return 0;
> Sashiko suspects this can introduce another issue:
>
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-7SHE.v1.r0.2026=
1016101330-1@mojatatu.com
>
> (the 2nd concern)
>
> I think it should be addressed in the same patch.

We looked closely at this, sashiko premise that pattern_len  65477
will cause the issue is false.
at most pattern_len =3D 65476, which yields TCA_OPTIONS =3D 65532 is
accepted. 65477 is already rejected with -EINVAL by the existing u16
wrap of the request attribute, before even tcf_em_tree_validate() runs
So that code is simply unreachable.

For that reason it doesnt make sense to send a v2.

cheers,
jamal
pattern_len =3D 65476, which yields TCA_OPTIONS =3D 65532; 65477 is
already rejected with -EINVAL
> /P
>
