Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792435155;
	b=ea7H6mNhjozJL7CePwWd0ykzY3zYIcJsPEMWyr9Lq4SWjKBHIWCe6mwVAHbfUIw8hNhC
	 i5mY4mC8xUh1o4bRg9gil4MtE0m63zxeXAy/Mw+ddSRA8Nu0pzkrRQDuzIotXutnnvKX+
	 YYpXy+lXuyR+FC5THLGlg2JIBOQbC14ZzqkGS55ywcXMXTPc85D08g9sUgQi6OXdhEYk+
	 RuL0/+u01YabiEVBPkHHYgl45YfQ6N81PUHWfq6ACv9y+qSa7mrXtDFS2LfGFbf5Egesv
	 gQd6rafMgJQYLAWhayJE+vrBhSvyAIqzETUlnzt+uyJYmT8Ku/1tT5ooXCuAIUMlRvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792435155;
	h=DMARC-Filter:From:To:Cc:Subject:In-Reply-To:References:Date:
	 X-Clacks-Overhead:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=d8JfaRPpsKe/wkP2ws3S5i8V/OOGlLqrqKmRARIuRek=;
	b=JNW1McVMwjzY0XQDqEFguyE53layCsU7OIYuW6xQ/VWOUC/OgVI7Re4wKuoNRUmM52B+
	 foYQrlUyHQaVoUnIDQnVK5roemJcDHbquG6q95AxJ2Er2vRnkMnGvz8ce2L79Z1KqXRRQ
	 44MCMEqeCkHnuyEhJr+qAGmUlmAi754dlgtU2jyTC+ha8i1MBc7Xvaa1cmOdWKdgf4215
	 souBIcnZZ512KtVEfILK18ifROZwdCyPTjw4FpGIE137br6+xveOZqnidF5F0jz2DDuaF
	 gs8zEv1axmctDdQkYfE8t+caHp2co5t0V0Dwl9JCG860StmVkBx0Ltx8MnS4MoIbmxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C7C606A322
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 18:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6C7C606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Jamal Hadi Salim <jhs@mojatatu.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, cake@lists.bufferbloat.net, Victor Nogueira
 <victor@mojatatu.com>, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH net-next v2 1/4] net/sched/sch_cake: serialize
 reconfiguration with the datapath
In-Reply-To: <CAM0EoMnToUnKv9gSm=fxTj=t3BMXzu3=NDDFY3OvysnbdjCubw@mail.gmail.com>
References: <QDISC-5RTM.v2.r0.20261015051735@mojatatu.com>
 <QDISC-5RTM.v2.r0.20261015051735-1@mojatatu.com>
 <87ld7t3kl3.fsf@all.your.base.are.belong.to.us>
 <CAM0EoMmL1Yjo67wOmOwWtfYLNrVFH7zSbgDtx2Rg+k3-Nu4QOQ@mail.gmail.com>
 <CAJ+HfNigAQTJ37tx_74jqPcCCwsk1XR5-reOo7i-u0xCKqF--Q@mail.gmail.com>
 <CAM0EoMnToUnKv9gSm=fxTj=t3BMXzu3=NDDFY3OvysnbdjCubw@mail.gmail.com>
Date: Mon, 19 Oct 2026 20:39:11 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87ld7twn5c.fsf@toke.dk>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jamal Hadi Salim <jhs@mojatatu.com> writes:

> On Mon, Oct 19, 2026 at 10:53=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@ker=
nel.org> wrote:
>>
>> Jamal!
>>
>> On Mon, 19 Oct 2026 at 15:47, Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>> >
>> > Hey Bj=C3=B6rn,
>> >
>> > On Mon, Oct 19, 2026 at 9:07=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@k=
ernel.org> wrote:
>> > >
>> > > Jamal Hadi Salim <jhs@mojatatu.com> writes:
>> > >
>> > > > This is a follow-up to commit 7cbfb180945c ("net/sched: sch_cake: =
fix
>> > > > autorate reconfiguration throttling").  That change only stored
>> > > > last_reconfig_time; it did not address the concurrency between the
>> > > > autorate rate update in cake_enqueue() and the netlink reconfigura=
tion
>> > > > path, which the original review flagged.
>> > > >
>> >
>> > You are reviewing a very old version - the last one was a v6[1], most
>> > of these fixes are in the "no good deed goes unpunished" from sashiko
>> > ;->
>> > I am about to post a v7. Maybe review that one?
>>
>> OMG... sorry for the noise.
>>
>
> Not noise at all - with all these AI dump it is overwhelming. Always
> great to have someone review. Sashiko will always find something to
> whine about - the bikeshedding it engages in is shameless sometimes;->
> I just sent an update.

Erm, I think you're confusing patch series? This one is not the one
you're at v7 on, Bj=C3=B6rn did review the latest version AFAICT (and I agr=
ee
with his comments FWIW) :)

-Toke
