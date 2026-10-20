Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792486727;
	b=jcE6u0eRh1Jv7EYeOOYw59aLANUFgbhZfVSLzzQBkLmszDlyOD3Fu7EvSTohCIbDBNov
	 jou3k38CmU/IueaUfMA9YQNKad7C94EmDyJMMCNQEPYi2eCBjSCkRBBajLnmNqWM9u0Ay
	 wdqPAVMH+LDR4I7py/OSQZFFqCH5hT+59hkKVqSBLxjcgwg7qHiRbQLT6GfWQNrAy+iQf
	 Cjpyox/2xhpO+mK9GEK6gAH7kB0zvjWTw94uwaCO0uB4QN3SkAsUAFMrYm4kkIu6q8NB+
	 LlPc11AI4jvKky5B3+iZM2sQV9un4Kz5Y3VL/lbbLX+O8btKMllcnhlW2fqy1mydOnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792486727;
	h=DMARC-Filter:From:To:Cc:Subject:In-Reply-To:References:Date:
	 X-Clacks-Overhead:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3x+CrrG+dFZ8FFxmxaWMhT1Ugs0r6n9Y3T1yru5EyC4=;
	b=oQMyWWjoAs3etV7eUFwXeLgU+9niY5GTo2ERCF6vOezW0w3k+xJss8SyBNM23c3uH3da
	 us35YOpZUgz79FUw2v7ZVQGrHjj0KnYDm7VygN3isWFkmeXRd4BkHrLmrnlTxvXVeoxZl
	 cXR8gS2Tk1uAaDg90ilLj86r55f/N/ApuZG/SmVRk37haoSDTR/JYDispRB1xOVflM5/u
	 V5+NmbqourDXgst7Fn5/SQMyvNAAVOBHlixQIdZYDatws+OBHEEqroCMja427yUB5uYDN
	 dNg4akmwrswru9UCJwx6uSkZo6Lwkt8PMHkUIdnQjvHQ/1IRCuZpooqISSFuWlA9WyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB10606A31A
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 08:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DB10606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Victor Nogueira <victor@mojatatu.com>, =?utf-8?B?Qmo=?=
 =?utf-8?B?w7ZybiBUw7ZwZWw=?=
 <bjorn@kernel.org>, cake@lists.bufferbloat.net, Sashiko
 <sashiko-bot@kernel.org>
Subject: Re: [PATCH net-next v7 1/4] net/sched: cake, fq_codel: return the
 classifier result to the caller
In-Reply-To: <CAM0EoM=6joWtYQdkw0KheH0sEx0r1P7_+6aEt3235OQZSxD9Mg@mail.gmail.com>
References: <QDISC-BA27.v7.r0.20261019115505@mojatatu.com>
 <QDISC-BA27.v7.r0.20261019115505-1@mojatatu.com> <87wlrdwof7.fsf@toke.dk>
 <CAM0EoM=6joWtYQdkw0KheH0sEx0r1P7_+6aEt3235OQZSxD9Mg@mail.gmail.com>
Date: Tue, 20 Oct 2026 10:58:42 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <875wywvjct.fsf@toke.dk>
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

> On Mon, Oct 19, 2026 at 2:11=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@toke.dk> wrote:
>>
>> Jamal Hadi Salim <jhs@mojatatu.com> writes:
>>
>> > The Fix:
>> > cake and fq_codel run an optional external classifier from their enque=
ue
>> > path and then compute the flow hash inside the helper. Have the helper
>> > return the filter's overrides (cake) or a 1-based flow index or a requ=
est
>> > to hash (fq_codel) instead, so the caller owns the flow selection.
>> >
>> > This is preparation for the accounting changes that follow. Packet
>> > classification and flow selection are unchanged.
>>
>> It's not clear to me why this change is needed at all for fq_codel?
>> fq_codel_hash just does a reciprocal_scale() of the skb hash, it doesn't
>> mutate any qdisc state. So why can't fq_codel_classify not just stay as
>> it is?
>
> It is not functionaly needed for fq_codel, it is more because these
> two are cousins and simplifies subsequent patches.
> Note in patch 4 we force the same semantics on cake as in fq_codel
> (classifier decides the drop, the caller owns flow selection). Keeping
> fq_codel's classify the same makes patch 3 hunks in the two files
> similar. There is another reason: the old helper encoded "drop" as a
> magic return and carried the 1-based +1 arithmetic on every return
> path.

But you're not making the same change to fq_pie, although its classify
function is line-for-line the same as fq_codel. I think it's better to
keep those two the same; you can add the new check to fq_codel between
the 'idx--' and 'codel_set_enqueue_time()' lines just fine.

> In any case, unless you feel strongly i would rather keep it.

Well, see above :)

-Toke
