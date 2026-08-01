Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F8E39448F
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 16:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785601778; cv=none; b=cSzSMQPxhsMv031ECmCwnym6ptKB/+JVA4kTTKGQM+C33cAa8Ye6lYMrZQTgbD9etpzVir96aa6UUUINTReKpkbPgRKk7WYI53tEE1I7uj8/gyiauJcKwkyOvcp1IkOGev0uH9rUgOv6DGx03Z6YFv5qnWX1XylfL0YrbxCuY1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785601778; c=relaxed/simple;
	bh=GsaH64zwrQdKJ5gPv+eZ5EA1gUTGduKA+kjlJCpWnLM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=X2LJVRY/ReZL0izuEM6U5pgWO53RF9RlTWRj8NpQBIn/Ytrs0bqobR5O7oyL1v8d2SSTZBu0A0QM0WKw2dPyvAmuT4w7KJdA8zQaVmJw4onk2y6P+XIvMaHhoQYTStNn8xcixgXe8tjpPcIk79fzLNQ93nzCPrr84blS3uUqy08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUFxAt5C; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUFxAt5C"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-47f4c92d1b3so542342f8f.0
        for <netdev@vger.kernel.org>; Sat, 01 Aug 2026 09:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785601775; x=1786206575; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GsaH64zwrQdKJ5gPv+eZ5EA1gUTGduKA+kjlJCpWnLM=;
        b=NUFxAt5C9fg0ZRuuR72ZO+PNH242D3Mzy/OAUSqS4xo3p0I94udWuFccSt0FFLnxMg
         +eurv7zCpBsEaz+kdRfNwygvFmLzZkTujFs5bClwCov9cdfgLTxTp5RGzm8p1MJg+6w4
         q6zbduE2Ht79x4yHM+47pJeTac6ICkmT07FBjj4Mq4A+Qjzx0GkF6SWT7rwItug2PRCp
         HOVTpsvh1H71kI57POLaYxu9cMWsg0z5vyRUwzTEUCGX0Ovjc8FH4kLyTeD9j2gsiwmF
         3v6xZzLvOHB3pSirgMg0AcFe7MRswMsBovInsTqHYkeFV/xHYWf/oVwXUngwjgTmO3cB
         l4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785601775; x=1786206575;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GsaH64zwrQdKJ5gPv+eZ5EA1gUTGduKA+kjlJCpWnLM=;
        b=e8P/ojPVxhrAOXtQkewRska4UDTwgdit6oVV4Bbj+AnolhSV3Z7mGevLngQ/q2nyt0
         GyvGNjACzeGBY8yhYZWsKxHZIyvXxQL7VYJOYZRQc/MxpXcW3PbMsDVpKajAz6cwHRtg
         X5KWt/ny/py4lv84JFOEyRtv+CZL8ImJ7OzloL6rX6Y1tSY1WQKb557hKEAX7FUMzLiO
         Mn20spe5c5i+idCJDcTJe3LOiJvULHyCau1Ig8mnrBAutmj2YAq3OaLCCdTDVL+Yh7DG
         HFe4WLyXXpfKIycTy2IKLfRKJ/+vHs0ZDw4fX2tFnDNYNdgqFJ4Fu5Q3qXbjok9Cn7XP
         d/VQ==
X-Gm-Message-State: AOJu0YwCQfZf61igmJYXtgWZeOXJ5vlSuJtVj6Kj2Phjr7y8wfqIzVkB
	2yulpHC3aWpo664LcjIYkp2JRq5eqliskWVzTOWUNL2QoQsmSerZQfi7
X-Gm-Gg: AR+sD13t7yny+NNyH/RuXmvfy00tinZLKubC/JdhoGHQ/6s48n1jfkqJPy7U+jgz77e
	Taz2O/AJhOMbTvYm+ghTrj3rizaGKTQhfmZGg7+/KfmsqzMgAyo/MhQO7M69FvKqaRili3qa4S+
	aQcpwM5KD9LKG6k9m5Cfy5snqoJsUntWAXC4xXJttEIfQ5IiIzSMyNQ2w7ueH+jp9AuPJ3YEmIk
	auUYSmcfGxcdlFMkxWErzg4lf2jS6+4SZ09sKbfmah5GrPJOjykkXz/X1FQshmytENpFYATSaG8
	RfnZMFZnPEi/zfervjvkoQjuNCq47vd/dq1HGSq+ybW032SdigQL5bRNCbRsen+NVAYXzgcyrhx
	uumvK/PQFGfgsjmFYyPI/jmY7XjDM7e/9n0pqkidsDEz7WZcvY5yOSM7ddSCXCUFQaHsBtB8KBF
	CxbhFGI8bMiHqt/jCzAJ9fMB0v7u9sB+OxyKzWkCvToi9YcI1y/Wcb8I2nYEQuVSX+E6Tm/3bEp
	F+Kjl5Qttj0vWQxR/+n579v5lr45Qbv24/fJg4qmiQb/mCYmloW7WbYqWfFb9IaB+ORArd3pQvE
	EwWZEiMnbT5a6wR1EGP3osQ8MXXknvq5SBl6LQ==
X-Received: by 2002:a5d:6347:0:b0:47f:7b75:9dfe with SMTP id ffacd0b85a97d-47fd72ba981mr7747375f8f.8.1785601775189;
        Sat, 01 Aug 2026 09:29:35 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41e296csm15589245f8f.12.2026.08.01.09.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 09:29:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 01 Aug 2026 18:29:34 +0200
Message-Id: <DKDR02T36EVT.ODA2A3LW6MC2@gmail.com>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Sashiko" <sashiko-bot@kernel.org>
Subject: Re: [PATCH bpf 3/3] bpf: Unconditionally take socket references in
 lookup helpers
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Michal Luczaj" <mhal@rbox.co>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "Eric Dumazet" <edumazet@google.com>, "Kuniyuki
 Iwashima" <kuniyu@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Willem
 de Bruijn" <willemb@google.com>, "John Fastabend"
 <john.fastabend@gmail.com>, "Jakub Sitnicki" <jakub@cloudflare.com>,
 "Jiayuan Chen" <jiayuan.chen@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>, "Simon Horman"
 <horms@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Stanislav
 Fomichev" <sdf@fomichev.me>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Joe Stringer" <joe@wand.net.nz>
X-Mailer: aerc 0.21.0
References: <20260723-sockmap-lookup-tcp-leak-v1-0-1bbdc58ce514@rbox.co>
 <20260723-sockmap-lookup-tcp-leak-v1-3-1bbdc58ce514@rbox.co>
 <DKBCACHGQHYB.194JPC04N9WT0@etsalapatis.com>
 <591fd57e-d006-4e51-af5c-fea65a071819@rbox.co>
In-Reply-To: <591fd57e-d006-4e51-af5c-fea65a071819@rbox.co>

On Thu Jul 30, 2026 at 1:55 PM CEST, Michal Luczaj wrote:
> On 7/29/26 22:32, Emil Tsalapatis wrote:
>> On Thu Jul 23, 2026 at 7:33 AM EDT, Michal Luczaj wrote:
>>> Lookup helpers gate whether to acquire a socket reference on
>>> sk_is_refcounted(), a check re-evaluated at release. An established soc=
ket
>>> refcounted at acquire time can gain SOCK_RCU_FREE via
>>> connect(AF_UNSPEC)+listen() before release runs; the release-side re-ch=
eck
>>> then reads sk_is_refcounted() =3D=3D false and skips the put. The refer=
ence
>>> leaks.
>>>
>>> Make acquire and release unconditional and symmetric: always take a
>>> reference, always put it. Adapt sk_select_reuseport().
>>
>> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>
> Thanks!
>
>> The bot's concern about the comment style is obviously invalid here.
>
> Are the prompts incorrect?
> https://github.com/masoncl/review-prompts/blob/59469708305eca305cbd9eb94e=
5aa0ee3627529c/kernel/subsystem/bpf.md#bpf-comment-style
>

The prompt is correct, but we don't bother for existing comments, if you ad=
d a
new one, you can use the new style.

Overall, looks like the set is pretty close. You can respin targeting bpf-n=
ext
as John suggested (and we can wait for his ack before landing) so it can go
through CI again.

pw-bot: cr

> Michal

