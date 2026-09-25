Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0DC49E5D5
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 13:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790343050; cv=none; b=XCyvk/Q3YEdBhkLMgis/FJxhZaRmKusxTVjGHDL9I2QfcYE154iUVzJzsIL0mlCjqZIk7JmCO2SJ9w0hZY5BGKGfAAkqi1bBNoKLrZg4q+ld/zteuGCQ1h5sp2sLJC7JsGYvyZ/C7Zq5F0bkXOHhdAGkKlGZlK+YOppY2bfEXK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790343050; c=relaxed/simple;
	bh=sewSjsOYKkJcL/QPjZ7SLyeaADa9y+AGTIkwad9PCsI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=e4EkYdnNIJf/d3x8uc6Gc70N0uYsTHT41WrwQOJzXOD1Lt5/eYLX3eQvprDdc40uFDCYHz/2a8Co2I8gUBaRxSM+JGPJyUJi4seqxH2YHji8flYyETCm/v5kGJ5F7s2Op9XdxJb5Y0M0GVNigX7VFmDOoZEEsz6w6vKVdRifVeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=moeller0@gmx.de header.b=q4q59Dos; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=moeller0@gmx.de header.b="q4q59Dos"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790343037; x=1790947837; i=moeller0@gmx.de;
	bh=ro0Q6e3SywZ9QcLtuNN1OVhJlu6uLxo8O4dTo0G8Fws=;
	h=X-UI-Sender-Class:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=q4q59Dosuze+HpbmKuCHLYdsOIlPBcC1c2PL5pOY9oWVY56pWbou65Y45P1w6dJh
	 qpqzM9kaFJVUAh8mM6s5EAhRglT84WgJEAYkmKWB2Ui9MB6oi4de9/yWb9Zlo1UvF
	 ZhgzSARdf+PIR+oSb4+HaLhyAYBgNukKTXl8mcu0Rdb8n/3v/rfNQQnV+2fqCcoqC
	 RpqcThxr9ldawWk6BP971Jn9SYCD/viM7K7PkriL1hztqNJFFjm/Ll9CMywpkTDLM
	 WQjawFhnpBfE7LiD7B86McORQdL3ruXBd70yBxQSSYWbN5SU6g5Xz//Qr1J2xOqqQ
	 5RMshGNG7XIXHuWpUg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MjjCF-1wU8H81svD-00nWez; Fri, 25
 Sep 2026 15:30:37 +0200
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.3\))
Subject: Re: [Cake] [PATCH net-next] net/sched: fq_codel, cake: widen backlogs
 to u64
From: Sebastian Moeller <moeller0@gmx.de>
In-Reply-To: <CANn89iL3jBMczB4txC4oDusfpDoem-wdTOFVrujTbC0ArNhGqQ@mail.gmail.com>
Date: Fri, 25 Sep 2026 15:30:24 +0200
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
 netdev@vger.kernel.org,
 =?utf-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 cake@lists.bufferbloat.net,
 Jiri Pirko <jiri@resnulli.us>,
 "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Victor Nogueira <victor@mojatatu.com>,
 hybris <hybris@mojatatu.ai>,
 Sashiko <sashiko-bot@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <68BE1514-828D-4184-84E4-90F2EB3F035D@gmx.de>
References: <QDISC-BA27.v1.20260922092618@mojatatu.com>
 <CANn89iLfMJV7ancKH1Gjzzm7ZUG-gKcrczkJjJEWN5sCuWd-ug@mail.gmail.com>
 <CAM0EoMn8_MVUHa2Jym7wKvd6Oo-JvNJ7GPvRJi2DsJCnQFmW+w@mail.gmail.com>
 <CANn89iL3jBMczB4txC4oDusfpDoem-wdTOFVrujTbC0ArNhGqQ@mail.gmail.com>
To: Eric Dumazet <edumazet@google.com>
X-Mailer: Apple Mail (2.3864.700.51.1.3)
X-Provags-ID: V03:K1:U4lxXNmA3+BOkGyVGQhGYaqCDRtwTGXkRU3F8vjjee1qSgeoB1X
 1NoQluyYUjs0mHvr+Wh/vy+zDeTo7al5+H5E64bpDi+ONwfK18IdM+sZ6Ct46oQVfbyJOou
 m/qG7xACvbuUR5xiZcabtJOKK4Q1MKK+uSoVNuVPvMpBUv6VCODEKyYxnn/tkBAAW3RlrEV
 MY4WEXzyxgGVS4wn8ibdw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wk82LTCDWvQ=;+YejWUQOMz1wxMQNZHWcCS3K8IL
 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
 0LKuzreALUCrGm7DLpsJr8p9aknz+Dx2RAmEyM=

Hi Eric,


> On Sep 25, 2026, at 15:03, Eric Dumazet via Cake =
<cake@lists.bufferbloat.net> wrote:
>=20
> On Fri, Sep 25, 2026 at 1:28=E2=80=AFPM Jamal Hadi Salim =
<jhs@mojatatu.com> wrote:
>>=20
>> On Fri, Sep 25, 2026 at 5:13=E2=80=AFAM Eric Dumazet =
<edumazet@google.com> wrote:
>>>=20
>>> On Fri, Sep 25, 2026 at 10:54=E2=80=AFAM Jamal Hadi Salim =
<jhs@mojatatu.com> wrote:
>>>>=20
>>>> This is a follow-up to commit 8f735d64382d ("net/sched: bound
>>>> qdisc_pkt_len to prevent qdisc soft lockup"), which capped
>>>> qdisc_pkt_len() at QDISC_PKT_LEN_MAX (1 MiB). That cap bounds the =
stab
>>>> amplifier but leaves the per-flow backlog counter u32:
>>>> fq_codel_enqueue() accumulates qdisc_pkt_len(skb) into =
q->backlogs[idx],
>>>> so a flow can still accumulate 4096 packets of 1 MiB each and wrap =
the
>>>> counter mod 2^32. After a wrap, fq_codel_drop() sees a tiny =
maxbacklog
>>>> and drops from an almost-empty flow, and the dequeue-side =
subtractions
>>>> corrupt the counter further.
>>>>=20
>>>> Widen the fq_codel backlogs table, the fat-flow scan =
(maxbacklog/len) and
>>>> the drop threshold to u64. fq_codel is not lockless: every writer =
runs
>>>> under the root qdisc lock, so plain u64 arithmetic keeps the =
WRITE_ONCE
>>>> publish / READ_ONCE-consume pattern. The dump path
>>>> (fq_codel_dump_class_stats) stays a lockless stat-only read.
>>>>=20
>>>> CAKE accumulates the same generic qdisc_pkt_len(skb) into its =
per-flow
>>>> b->backlogs[] and per-tin b->tin_backlog and consumes the values =
for
>>>> longest-flow pruning (cake_heapify/cake_heapify_up) and for the =
shaper
>>>> staleness check, so it shares the bug. Widen those counters and the =
heap
>>>> comparison locals to u64; the class/tin stats keep exporting the =
low 32
>>>> bits through the unchanged uAPI fields.
>>>>=20
>>>> Conditions to recreate the bug: CAP_NET_ADMIN in a user namespace;
>>>> CONFIG_NET_SCH_FQ_CODEL=3Dy.
>>>>=20
>>>>  ip tuntap add tun0 mode tun
>>>>  ip link set tun0 txqueuelen 32 up
>>>>  ip addr add 10.99.0.1/24 dev tun0
>>>>  tc qdisc add dev tun0 root handle 1: stab overhead 2000000000 \
>>>>      fq_codel flows 1 limit 4200 ecn drop_batch 4096
>>>>  # hold the tun fd open without reading (IFF_BACKPRESSURE) so the =
qdisc
>>>>  # backlog persists, then send at least 4300 packets (the wrap =
starts
>>>>  # at 4096 resident; the over-limit drop that reads the wrapped
>>>>  # threshold fires past the 4200 limit): backlogs[0] wraps at 4096 =
x
>>>>  # 1 MiB and the fat-flow threshold reads the wrapped value.
>>>>=20
>>>> With a 1 MiB qdisc_pkt_len cap the counter wraps at 4096 resident
>>>> packets. At limit 4200 the first over-limit enqueue (the 4201st) =
sees a
>>>> wrapped 105 MiB (half-backlog threshold 52 MiB, a ~52 packet drop =
burst),
>>>> where the u64 counter sees 4201 MiB (threshold 2100 MiB, a ~2100 =
packet
>>>> drop burst).
>>>>=20
>>>> Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
>>>> Closes: =
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818101130.16203-1=
-jhs@mojatatu.com
>>>> Link: =
https://lore.kernel.org/netdev/20260818101130.16203-1-jhs@mojatatu.com/
>>>> Tested-by: hybris <hybris@mojatatu.ai>
>>>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>>>> ---
>>>=20
>>> This makes no sense.
>>>=20
>>=20
>> As absurd as it looks that code is reachable ;->
>>=20
>>> These qdisc have been developped to address bufferbloat issues.
>>>=20
>>> Storing 4GB in a qdisc is absolutely insane.
>>>=20
>>=20
>> The counter wrap is not because we stored 4GB, rather it is because
>> "tc .. stab overhead ..." inflates qdisc_pkt_len() for a 64B pkt to
>> 1MB. So ~4K packets (put in other words a few "real" KB) makes that
>> backlog[0] cross 2^32.
>=20
> Kill this stuff ? Who is still using this, for what reason ?

tc-stab? Same as before, if you need want to model a remote bottleneck =
with a local traffic shaper tc-stab is the generic solution (off the top =
of my head I only can enumerate cake as having its own traffic shaper =
that handles overheads).
One could argue that the "virtual" length should be accounted against =
cake's memlimit or fq-codel's memory_limit somehow...
In sane?/typical configurations overhead is expected to stay relatively =
small, so this would not limit the actual queue size too much, while =
potentially silencing this issue.

I might be off my rocker, in which has ignore (or preferably enlighten =
me).

Regards
	Sebastian

>=20
> Really, it is time we stop adding code only for fuzzers.
>=20
>> Result is pruning the wrong flow..
>>=20
>>> Let's drop at enqueue if the current backlog is approaching 4GB =
(this
>>> can later be a new config/attribute in net-next)
>>=20
>> Note, this is net-next already. Enqueue is fast path - are you ok =
with that?
>>=20
>> cheers,
>> jamal
> _______________________________________________
> Cake mailing list -- cake@lists.bufferbloat.net
> To unsubscribe send an email to cake-leave@lists.bufferbloat.net


