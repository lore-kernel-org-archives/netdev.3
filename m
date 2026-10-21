Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792612218;
	b=0+2egqBhRzE4AQull2egzczpUYKCW/PuMqNylsZF6SxOoymVE5woUdD52aFI7V6KqtZm
	 rXvpGQr7r9DJJuv3+/HWwbqxaLz+RPxVl36SO4T6NoLmTujpuH7LxMxzIGkRzOBL/cZse
	 BwFcd20UQMpPOd0JRSNBp88hrU8SdKFeKFDgtphISsBheEAjjG+Tfhcr9kBiAMa9j/hpj
	 nFqCNAwO3Cc3WmJICsn8ZI1kI3KQajgO8Ut+GEvlKLuHLG8og8VQATazgriWPDTKQXyvX
	 Vs+4UnMQ5SiEa8xLeL1mCkOdaUXmze1aDuYxVFjwS118bz3q5xg/6uqSuimUdBO+HFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792612218;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=rfoJ05UONkmwL2VwlQYGmz6+VLrAyTICL7RfJCuaVwE=;
	b=ErFO475ik/kekMU5nSI5gRYftOzf1pp7Y4aoW86HRc5e6cWG3X5hYBKTU+pjzZMULMIC
	 Tf1Lui09DCRfyAgZruLZcJmxKIbci0G1KwrmZxroPkjXS3VzWxvodJmjNmRRtJw04vFOQ
	 YmUZzwRviGgmYJjxgUEkx2vO9Ngwm/iueHS+ddco4aAnBtXr3YWna9KuJpwrr06MGKQJZ
	 4CNnMoLExWhVBHcZTUHFmamBGWyLYnlo/V/JCiKP9nzbKyAnpcDUEbgITTvOZ7PVLlf0j
	 lryu8jGTvU4AKHzqggqDBSWGCxQZPzigApir36RcWZKz+jHAmOnf+An2APtPOkYVCzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=goQQtm4q;
	arc=none smtp.remote-ip=74.125.224.136
Received: from mail-yx2-f8.google.com (mail-yx2-f8.google.com [74.125.224.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEF9606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 19:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BEF9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=goQQtm4q
Received: by mail-yx2-f8.google.com with SMTP id 00721157ae682-8b0c81dcf98so3464287b3.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 12:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792612217; x=1793217017; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rfoJ05UONkmwL2VwlQYGmz6+VLrAyTICL7RfJCuaVwE=;
        b=goQQtm4qVsIdcw0groGw6hqMcB3SQa/Z4bQ20PwJKf8Rv6WFQJgPFRiA1hteBDZCeS
         gsWC5P20bRBiDI/gBfL6YqjJ+W8ofEetzDpyLAp/8t7wBZVwciOw9iCtdxjzD23LcWXp
         VvL1kZqz9a6DKpffHdurAZtrtCSuKKTOtZurqYALIR/kRh53Vdu8lntJsJHylM8X5eFW
         eqYjppKuKAREzt/DyG8uBijR2qYrTQ5UoJuETr6C/2HEiTgy5jPsylbYHftKp/i+T+7q
         s/JCJ0it/OyzfY3dD+cJbXriL69Tkeu9rjVzMiWXfwQp4kraYGIvaXL/fCVtTC+xyxQf
         gDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792612217; x=1793217017;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rfoJ05UONkmwL2VwlQYGmz6+VLrAyTICL7RfJCuaVwE=;
        b=FB/YDvWOgjN6RWRR8XpL5zhLQuRoovuKOLfSWQsfPAQfg6snKgjrnHz3eSIQ7Gi+Ui
         c748crBTUlcfZxIOZqlmuj4HAtPmcdgxaEhq4OCR4RABD622dMY4/IaFCmkpdqoOOXKw
         fQb3RJGx7fI9s1viYCShcfl0Z9sXrQhvHt8sagg2g2AR65YIRVp1GM91jp5dGKFJNxEW
         y5sg/mkAecgkf27N5q9OtmN3Q8g8TWrOHK6wQxY3rtDrecSDVrFPnK6buZSu5acf2kr7
         NN2hVAAIHWpb+D4GvqE0RcT0/zTKHWX7L0HfJx+28pMO6RSGV9HWycBGVN7qIfopKy0p
         Xq0Q==
X-Forwarded-Encrypted: i=1; AKwUvBwYcprjgZdafwV2d01+j4qoGotPehpEpTLRTBkDEm+N4BSTdrydr/rZorq0O/V/N/0gqsEt5Pc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKDeO2JfPl6M4RitzqsAcvXGwN9lvdvC2/FBNUBriL0Y5dxWZUo
	4PAwVOSmgKs01kQJv6rgKlXYJ+9E9mAEuKoN0y8qTSkzcLhN911/KkSW
X-Gm-Gg: AYBFou0k3mHE4deve4cAqpsYsvDq2b/ANJAbp0F4PTp6JEt4NOGKZwivGUryqShFit3
	KViQKt0P2Y/SugYzbjHBS3qGzQYY9dNT+UKsvcD10X5OmMZlbNmsklEZUVQvGn8y+VkIbBcjXbx
	QefSdkwKoRKTLytaDXj1t9efiLy0upw8X2UES8l3vzlmvl0YI+V5qwyguAKWI0x+qmWvX3npXIw
	0ydb+IgE+nZRWKlfsCENhKk+tTv3oXWJYORMdmxiBpMiwr/En68Hi9QGhe8KASca2LhFj7YovbV
	aYlXPqlbVL/Qw08/QQ5SkcVlAIu1MFsAsZckG+oVvudhIA7kOIR/8v7jlziTCAdhMFHjIgJM4rS
	/HfjiBnOtRLPijk+3i7x6h79amlkMSRSAFd417alOPAmm8/7TKYp6+vmErR4HjCh5UGQrEe47Cn
	I6uS7d1MXrt/eZ/e0FMGqZTccQw74zY/CQMNNguS8L9mJAPLBgTk/q1lurhlGh8ydRw7GKcm6zW
	MLzGStDv2RfT7R65tu9kGWE537aF6QK4nprJ2dwdobrVL48RKW4ujKomRkK/VwmMcv7qpN1gIEb
	KAeVkd1ELGzk3z7vA7fgT22Xa6u727+D33mWD2yB0ilpfodnJj1F3U2kH2Xe6ns=
X-Received: by 2002:a05:690c:6d83:b0:8ac:6e11:3dee with SMTP id 00721157ae682-8b133c990ffmr18942997b3.10.1792612217411;
        Wed, 21 Oct 2026 12:50:17 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b130074aa6sm16117427b3.10.2026.10.21.12.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 12:50:16 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 21:50:15 +0200
Message-Id: <DMARZV0CMCU6.B7GRUVI8S0WT@gmail.com>
Cc: <bpf@vger.kernel.org>, <andrii@kernel.org>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <davem@davemloft.net>, <willemb@google.com>,
 <eddyz87@gmail.com>, <edumazet@google.com>, <john.fastabend@gmail.com>,
 <kuba@kernel.org>, <horms@kernel.org>, <liamwisehart@meta.com>,
 <martin.lau@linux.dev>, <pabeni@redhat.com>, <song@kernel.org>,
 <netdev@vger.kernel.org>, <sdf.kernel@gmail.com>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <kuniyu@google.com>,
 <emil@etsalapatis.com>, <almagui@kernel.org>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: add bpf_ksock_sendto() kfunc
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>, "Mahe Tardy"
 <mahe.tardy@gmail.com>
X-Mailer: aerc 0.22.0
References: <20261020155848.75711-1-mahe.tardy@gmail.com>
 <20261020155848.75711-2-mahe.tardy@gmail.com>
 <CAEf4BzapP4Hng7bO8crK4SLg_PMH33oKo8esFo1ur5-QewNfig@mail.gmail.com>
 <atkG-5eqB8LfVxSa@gmail.com>
 <CAEf4BzYA79tg5C+uzo3S5=MRgM_O7VMYtOwW59QMieJoFNOpVg@mail.gmail.com>
In-Reply-To: <CAEf4BzYA79tg5C+uzo3S5=MRgM_O7VMYtOwW59QMieJoFNOpVg@mail.gmail.com>

On Wed Oct 21, 2026 at 8:57 PM CEST, Andrii Nakryiko wrote:
> On Wed, Oct 21, 2026 at 11:39=E2=80=AFAM Mahe Tardy <mahe.tardy@gmail.com=
> wrote:
>>
>> On Wed, Oct 21, 2026 at 10:56:23AM -0700, Andrii Nakryiko wrote:
>> > On Tue, Oct 20, 2026 at 8:59=E2=80=AFAM Mahe Tardy <mahe.tardy@gmail.c=
om> wrote:
>> > >
>> > > The motivation is to plumb more of the socket API into ksock, thus
>> > > supporting sendto() in addition to send() which makes a lot of sense=
 in
>> > > the context of UDP sockets which are the only type currently support=
ed.
>> > > This is useful when ksock is used to reply to specific addresses or =
send
>> > > to multiple addresses.
>> > >
>> > > Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
>> > > ---
>> > >  net/core/bpf_ksock.c | 96 +++++++++++++++++++++++++++++++----------=
---
>> > >  1 file changed, 69 insertions(+), 27 deletions(-)
>> > >
>>
>> [...]
>>
>> > >
>> > > -       return ret;
>> > > +/**
>> > > + * bpf_ksock_sendto() - Send data through a BPF kernel socket to a =
remote address.
>> > > + * @ks:                The BPF kernel socket context. Must be an ac=
quired reference.
>> > > + * @data:      Pointer to the data to send.
>> > > + * @data__sz:  Size of the data to send.
>> > > + * @addr__nullable: Pointer to an IPv4 or IPv6 socket address, or N=
ULL to use
>> > > + *                the connected destination.
>> > > + * @addr__sz:  Size of the address union, ignored when the address =
is NULL.
>> > > + *
>> > > + * Sends data to the specified address, or to the connected destina=
tion when
>> > > + * the address is NULL, best-effort and nonblocking. This may sleep
>> > > + * (kernel_sendmsg), so it can only be called from sleepable BPF pr=
ograms.
>> > > + *
>> > > + * Return: Number of bytes sent on success, negative errno on error=
.
>> > > + */
>> > > +__bpf_kfunc int bpf_ksock_sendto(struct bpf_ksock *ks, const void *=
data, u32 data__sz,
>> >
>> > This would limit API to fixed-sized data only. Have you considered
>> > passing dynptr as a source of data, so you can send a wider variety of
>> > data? I don't have a strong opinion whether we should add a separate
>> > API or convert this one into dynptr, but I do think that having
>> > ability to work with variable-sized data is super useful and should be
>> > added early on.
>>
>> Oh wow this is really cool that you send this now. I was working this
>> afternoon on trying to see if a ksock sendmsg() would make sense, but
>> with these static buffer limitations as arguments, it actually didn't.
>> I'm not familiar with dynptr so I didn't think about it, but after a
>> quick check it looks like it would be a good match with the ksock API!
>>
>> As I understand, since bpf_ksock_send() is already part of 7.3, it's
>> best to not touch it, and having a simple send() available with a
>> fixed-size data might make sense.
>
> agreed
>
>>
>> But since bpf_ksock_sendto() was just merged, we could make it evolve to
>> use dynptr perhaps? How much time do we have for something which was
>> merged yesterday to be part of a release? Is it going to be send with
>> the 7.4 pull soon?
>>
>
> I'd send a follow up in the next few days, it can go in as a fix for
> kfunc in rc1 or something, unless others have differing opinions on
> this
>

Another option is to add dynptr variants of both, a pattern we have in othe=
r
APIs as well, so there would be no rush. We just have two more kfuncs:
bpf_ksock_send_dynptr() and bpf_ksock_sendto_dynptr().

>> >
>> > > +                                const union bpf_ksock_addr *addr__n=
ullable,
>> > > +                                u32 addr__sz)
>> > > +{
>> > > +       return ksock_sendto(ks, data, data__sz, addr__nullable, addr=
__sz);
>> > >  }
>> > >
>> > >  __bpf_kfunc_end_defs();
>> > > @@ -255,6 +296,7 @@ BTF_KFUNCS_START(ksock_kfunc_btf_ids)
>> > >  BTF_ID_FLAGS(func, bpf_ksock_release, KF_RELEASE)
>> > >  BTF_ID_FLAGS(func, bpf_ksock_acquire, KF_ACQUIRE | KF_RCU | KF_RET_=
NULL)
>> > >  BTF_ID_FLAGS(func, bpf_ksock_send, KF_SLEEPABLE)
>> > > +BTF_ID_FLAGS(func, bpf_ksock_sendto, KF_SLEEPABLE)
>> > >  BTF_KFUNCS_END(ksock_kfunc_btf_ids)
>> > >
>> > >  #ifdef CONFIG_BPF_LSM
>> > > --
>> > > 2.43.0
>> > >


