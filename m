Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856D536A361
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 14:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790344989; cv=none; b=Pc0oXqiLZcsp+86IToJhUYIWpq7FmCQxSkpqGyHfQnFgxPBTBISv99JHkn2F9xatBi39O/g6g4Rf+recscfGQo7+kFcPiNYT0u0LClHiyzA0uFiZEHlO6uvihNvTSluKuJ5wL144eCvChY25khGVXgbnKIVbS8Ekik1wnz6LI9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790344989; c=relaxed/simple;
	bh=3tzEYGhBT4TWC4TjTdZ4103JSDSTHUBdGjEaP0M/35c=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ORYcd0EOpd0pmRcBcoeDTkOd6k+GMlq+vyNcps4Rv4lxfCPHg/DF+J7Xumgu2+EHfPjAlnPG7VzGDMVKg6QKNvbEzqcjbfq/2+VZSpFoZfPCnDKqJT6f58QaTA+dx/50Et564c/Dx9BvWX+8sKKeKYZwEYwUioQPg2dcf6xEIQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=moeller0@gmx.de header.b=dPAHRuWQ; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=moeller0@gmx.de header.b="dPAHRuWQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790344983; x=1790949783; i=moeller0@gmx.de;
	bh=vpZb0bG7viHI4T2NX9PNE2UWQJKoTmRIhUmmOaip0lM=;
	h=X-UI-Sender-Class:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=dPAHRuWQD6MnPnHxxxmBSCiVC/kGqxRiByFCoQMEQ3fRXSP4XwyEL1neVQ51GI4X
	 y5qnqIjru4Tdahzipp4XhCEulnAKSA6nPsVWwy7gto+9f7EMxcY3gaokVpT8IEcDW
	 TTSQGIOvqrDB9gW0hABzqb37KTarSOMEt03LtlNI4EHu/JZX0gvXd45f35PU6ddjL
	 F/8839/TA0oVLcUziuv4IRph8XF4365DZrN69IiKsUktbTNcN2EUuT/lQvqtdbRgm
	 440K5EOGhLvsXVYURcjO/Q3qGrNs1aLfiK/OwmBFfuxdL+w3fdIKkM62DDtvcf5ot
	 AXx6c2Ktix6ig8dstA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWzfv-1xGqhb48hF-00V7Hg; Fri, 25
 Sep 2026 16:03:03 +0200
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
In-Reply-To: <CANn89iJtHuwybsSLy32GzH2c9cGmP1bL7ardxPjxPOj2xGLZPA@mail.gmail.com>
Date: Fri, 25 Sep 2026 16:02:50 +0200
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
Message-Id: <67EA1744-69D7-4A64-9117-D6A79A3A93E4@gmx.de>
References: <QDISC-BA27.v1.20260922092618@mojatatu.com>
 <CANn89iLfMJV7ancKH1Gjzzm7ZUG-gKcrczkJjJEWN5sCuWd-ug@mail.gmail.com>
 <CAM0EoMn8_MVUHa2Jym7wKvd6Oo-JvNJ7GPvRJi2DsJCnQFmW+w@mail.gmail.com>
 <CANn89iL3jBMczB4txC4oDusfpDoem-wdTOFVrujTbC0ArNhGqQ@mail.gmail.com>
 <68BE1514-828D-4184-84E4-90F2EB3F035D@gmx.de>
 <CANn89iJtHuwybsSLy32GzH2c9cGmP1bL7ardxPjxPOj2xGLZPA@mail.gmail.com>
To: Eric Dumazet <edumazet@google.com>
X-Mailer: Apple Mail (2.3864.700.51.1.3)
X-Provags-ID: V03:K1:TPNWxxqYuZ6UoA4G6VddTe35jFlzgXE0MhMA/R7I/v65eDI7btS
 gX0aZsGkCi04yj0hB1S69w4ekoOLPOOWIeAV8om2BLshl0drRKnan6NsBoNnfO7JXrrt6Cs
 jHPgK29Urr5RiBPGW6+02lJERWuLXq37fXEA5HAGkofGSaYluN+/gWdtwNjACvmNgYYpJP6
 aYIco7n+xic5SSJ/IgqfQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OLOrq8eWaDg=;1A66JA/jPQEGl/725FaSBzrAX9Y
 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

Hi Eric,


> On Sep 25, 2026, at 15:43, Eric Dumazet <edumazet@google.com> wrote:
>=20
> On Fri, Sep 25, 2026 at 3:30=E2=80=AFPM Sebastian Moeller =
<moeller0@gmx.de> wrote:
>>=20
>> Hi Eric,
>>=20
>>=20
>>> On Sep 25, 2026, at 15:03, Eric Dumazet via Cake =
<cake@lists.bufferbloat.net> wrote:
>>>=20
>>> On Fri, Sep 25, 2026 at 1:28=E2=80=AFPM Jamal Hadi Salim =
<jhs@mojatatu.com> wrote:
>>>>=20
>>>> On Fri, Sep 25, 2026 at 5:13=E2=80=AFAM Eric Dumazet =
<edumazet@google.com> wrote:
>>>>>=20
>>>>> On Fri, Sep 25, 2026 at 10:54=E2=80=AFAM Jamal Hadi Salim =
<jhs@mojatatu.com> wrote:
>>>>>>=20
>>>>>> This is a follow-up to commit 8f735d64382d ("net/sched: bound
>>>>>> qdisc_pkt_len to prevent qdisc soft lockup"), which capped
>>>>>> qdisc_pkt_len() at QDISC_PKT_LEN_MAX (1 MiB). That cap bounds the =
stab
>>>>>> amplifier but leaves the per-flow backlog counter u32:
>>>>>> fq_codel_enqueue() accumulates qdisc_pkt_len(skb) into =
q->backlogs[idx],
>>>>>> so a flow can still accumulate 4096 packets of 1 MiB each and =
wrap the
>>>>>> counter mod 2^32. After a wrap, fq_codel_drop() sees a tiny =
maxbacklog
>>>>>> and drops from an almost-empty flow, and the dequeue-side =
subtractions
>>>>>> corrupt the counter further.
>>>>>>=20
>>>>>> Widen the fq_codel backlogs table, the fat-flow scan =
(maxbacklog/len) and
>>>>>> the drop threshold to u64. fq_codel is not lockless: every writer =
runs
>>>>>> under the root qdisc lock, so plain u64 arithmetic keeps the =
WRITE_ONCE
>>>>>> publish / READ_ONCE-consume pattern. The dump path
>>>>>> (fq_codel_dump_class_stats) stays a lockless stat-only read.
>>>>>>=20
>>>>>> CAKE accumulates the same generic qdisc_pkt_len(skb) into its =
per-flow
>>>>>> b->backlogs[] and per-tin b->tin_backlog and consumes the values =
for
>>>>>> longest-flow pruning (cake_heapify/cake_heapify_up) and for the =
shaper
>>>>>> staleness check, so it shares the bug. Widen those counters and =
the heap
>>>>>> comparison locals to u64; the class/tin stats keep exporting the =
low 32
>>>>>> bits through the unchanged uAPI fields.
>>>>>>=20
>>>>>> Conditions to recreate the bug: CAP_NET_ADMIN in a user =
namespace;
>>>>>> CONFIG_NET_SCH_FQ_CODEL=3Dy.
>>>>>>=20
>>>>>> ip tuntap add tun0 mode tun
>>>>>> ip link set tun0 txqueuelen 32 up
>>>>>> ip addr add 10.99.0.1/24 dev tun0
>>>>>> tc qdisc add dev tun0 root handle 1: stab overhead 2000000000 \
>>>>>>     fq_codel flows 1 limit 4200 ecn drop_batch 4096
>>>>>> # hold the tun fd open without reading (IFF_BACKPRESSURE) so the =
qdisc
>>>>>> # backlog persists, then send at least 4300 packets (the wrap =
starts
>>>>>> # at 4096 resident; the over-limit drop that reads the wrapped
>>>>>> # threshold fires past the 4200 limit): backlogs[0] wraps at 4096 =
x
>>>>>> # 1 MiB and the fat-flow threshold reads the wrapped value.
>>>>>>=20
>>>>>> With a 1 MiB qdisc_pkt_len cap the counter wraps at 4096 resident
>>>>>> packets. At limit 4200 the first over-limit enqueue (the 4201st) =
sees a
>>>>>> wrapped 105 MiB (half-backlog threshold 52 MiB, a ~52 packet drop =
burst),
>>>>>> where the u64 counter sees 4201 MiB (threshold 2100 MiB, a ~2100 =
packet
>>>>>> drop burst).
>>>>>>=20
>>>>>> Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
>>>>>> Closes: =
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818101130.16203-1=
-jhs@mojatatu.com
>>>>>> Link: =
https://lore.kernel.org/netdev/20260818101130.16203-1-jhs@mojatatu.com/
>>>>>> Tested-by: hybris <hybris@mojatatu.ai>
>>>>>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>>>>>> ---
>>>>>=20
>>>>> This makes no sense.
>>>>>=20
>>>>=20
>>>> As absurd as it looks that code is reachable ;->
>>>>=20
>>>>> These qdisc have been developped to address bufferbloat issues.
>>>>>=20
>>>>> Storing 4GB in a qdisc is absolutely insane.
>>>>>=20
>>>>=20
>>>> The counter wrap is not because we stored 4GB, rather it is because
>>>> "tc .. stab overhead ..." inflates qdisc_pkt_len() for a 64B pkt to
>>>> 1MB. So ~4K packets (put in other words a few "real" KB) makes that
>>>> backlog[0] cross 2^32.
>>>=20
>>> Kill this stuff ? Who is still using this, for what reason ?
>>=20
>> tc-stab? Same as before, if you need want to model a remote =
bottleneck with a local traffic shaper tc-stab is the generic solution =
(off the top of my head I only can enumerate cake as having its own =
traffic shaper that handles overheads).
>> One could argue that the "virtual" length should be accounted against =
cake's memlimit or fq-codel's memory_limit somehow...
>> In sane?/typical configurations overhead is expected to stay =
relatively small, so this would not limit the actual queue size too =
much, while potentially silencing this issue.
>=20
> linux qdisc are in the fast path, for nearly all packets sent over =
this planet.

Tip of the head to the linux network experts that enabled that and that =
take care of it being efficient!

> They aleady consume GW of energy.
>=20
> Modeling / network emulation should incur zero cost on these
> production grade qdisc.

It is not modeling in a scientific sense (sorry I used inappropriate =
terminology here), but simply the fact that to shape traffic to avoid =
filling remote queues one needs to be able to take the properties of =
that remote queue/interface/link-layer into account.
And that can be surprisingly close by. Last time I looked the kernel on =
say eth0 added the 14 bytes of ethernet related overhead it handled =
itself to the packet size on top of the payload (no complaints that =
makes sense) but that is insufficient to properly traffic shape e.g. the =
same ethernet interface... (as the relevant ethernet L1-frame overhead =
contains more bytes, like the FCS, preamble and SFD). And that gets =
worse with stuff like DSL, cable or fibre modems that are connected via =
ethernet to a linux router.

>=20
> netem could be one answer, I do not know, or a special
> CONFIG_NET_SCHED_EXPENSIVE_EMULATION

Well, tc-stab (or cake's overhead accounting) is already optional, so =
only those incur the cost that actually use it (and only those users are =
affected by the reported issue, it took tc-stab to cause the problem and =
arguably in a configuration that is "insane").=20
I might be trying to explain the internet here to people that make the =
internet work, so apologies in advance but I want to make this as =
explicit as I can.
TTraffic shaping without proper overhead accounting will not work as =
expected (at least if the expectation is that the traffic shaper will =
honor the set gross shaper rate). For a fixed packet size the lack over =
overhead accounting can be papered over with reducing the shaper rate, =
but the amount of the required "over-shaping" depends on packet size =
(smaller packets require more over-shaping), so generally that is sub =
optimal, because either the shaper's guarantee is brittle or the =
over-shaping quite extreme (think the header to payload ration of =
minimally- and MTU-sized packets).

All I am saying is, we do still have use cases for tc-stab and proper =
overhead accounting, at least on the leafs of the network like home =
internet links.


>=20
>>=20
>> I might be off my rocker, in which has ignore (or preferably =
enlighten me).


