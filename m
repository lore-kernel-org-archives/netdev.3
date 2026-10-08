Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4665A4963B6
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 12:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791464054; cv=none; b=UddR+S8hzyBpxFlPf90aHDcZmCJUI/eEGosvxgy+CCsndIq//pSjD5ZHrIZaSQ16OnC+yJUt9fi4FWjqWzCJbVfkS1mVuZPRsIsq5Fqsfyv0ve8jfoOXQ2Oz1DuRs4JnBVlldnxVVExuRNIaDYruwn+amCGMTmonpT/VsFta3is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791464054; c=relaxed/simple;
	bh=ouQeW907eH71q+GEFDuLH92W2aYW3RILt+rTW8FYBpM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CLiUrcnI5KYkTmyR3KLuEczZsSuP6ZiphpLPSKvROEIzor1sBFBs3hOj4N4n4v7TKZI5B1ZD1Enb1mc8sXqSuFmLdQyuQ+nwwEBoWj+3yILkaD3y6OTpaOh+AK//R5wsvXUX4S9CLINoNKK44VAURgAUDbQWtNc/43EPSnJowaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Victor Nogueira <victor@mojatatu.com>,
 moeller0@gmx.de, cake@lists.bufferbloat.net, Sashiko
 <sashiko-bot@kernel.org>
Subject: Re: [PATCH net-next v5] net/sched: cap the accounted backlog before
 it can wrap
In-Reply-To: <CAM0EoMmYEr4DLrjuM5hdPR5Lf1c=mU6WNpYydbzkGnWjqFxMrw@mail.gmail.com>
References: <QDISC-BA27.v5.20261007171509@mojatatu.com>
 <87a4oottcj.fsf@toke.dk>
 <CAM0EoMmYEr4DLrjuM5hdPR5Lf1c=mU6WNpYydbzkGnWjqFxMrw@mail.gmail.com>
Date: Thu, 08 Oct 2026 14:54:08 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87pkxks68f.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jamal Hadi Salim <jhs@mojatatu.com> writes:

> On Thu, Oct 8, 2026 at 6:29=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@toke.dk> wrote:
>>
>> > This is a follow-up to an issue found by Sashiko (nipa) during review =
of
>> > commit d9ebd8f9aa8b ("net/sched: fq_codel: clamp default quantum and
>> > mtu"), part of the quantum/mtu overflow series merged as a687f2ae995f.
>> > Clamping the per-flow quantum and the CoDel mtu does not bound the
>> > accounted backlog, so the per-flow backlog wrap the review flagged
>> > remained.
>>
>> This, and the rest of the commit message is obtuse LLM vomit, and close
>> to unreadable. Please rewrite the commit message without the verbosity,
>> so it's actually something a human reader can comprehend. For the cake
>> bits in particular:
>>
>
> Ok, but there is a dilemma: The verbosity is an attempt to appease the
> sashikos. The other day it complained that i didnt have a space after
> a semi colon.

You know you can push back on Sashiko comments, right? :)

> The more stuff i add the less it slows me back. It picks on the
> accuracy of the commit text _and changelogs_ and prescribes what i
> said or should have said. I can understand a future AI review would
> benefit from that; there are probably a few humans that read the
> commit logs after the patch has gone in.
> So:
> I have been more targetting the AI more than humans in these comments.

Writing to appease the bots at the expense of human readers is
absolutely a mistake, IMO. Last time I checked, we are still a community
of humans developing the kernel together, regardless of the fashionable
assistance technology du jour. Having a comprehensive and understandable
commit log is one of the kernel's greatest assets, and often one of the
only things that makes complicated code understandable. We should not be
sacrificing that in an attempt to make the work guess robot guess other
words :/

>
>> [..]
>>
>> > CAKE's SPLIT_GSO path accounts the sum of the segment lengths, which a
>> > stab recomputes from skb->len and can exceed the pre-split
>> > qdisc_pkt_len(). The list is summed before any segment is linked and
>> > rejected as a whole before any flow state is resolved: the flow/host k=
eys
>> > are computed from the unsegmented packet, but the set-associative
>> > resolution that commits q->tags[], the flow host indices, the way
>> > counters and the host bulk-flow counts runs only after the whole
>> > segment-sum admission test passes. A packet rejected by that test
>> > therefore leaves no persistent state behind. The whole list is dropped
>> > via to_free so the tail segment's sock_wfree() never runs under the qd=
isc
>> > lock. A fraglist GSO is the exception: skb_segment_list() returns the
>> > original skb as the list head carrying an extra reference, so segs =3D=
=3D
>> > skb; dropping the caller's reference and queueing the list once avoids
>> > self-linking *to_free, which would otherwise free the same skb repeate=
dly
>> > in the deferred teardown.
>>
>> I read this paragraph multiple times, and it's still not clear to me
>> what it's trying to say.
>>
>
> In plain english, it says three things (applies to :
> 1) Splitting a GSO skb can account for more bytes than the original
> packet, so we sum the whole segment list and test the total against
> the ceiling before any segment is linked.
> 2) If it is over, we drop the entire list, and because no flow state
> (tags, hash indices, counters) has been resolved yet, the reject
> leaves nothing behind.
> 3) The fraglist sentence only picks which reference to drop for the
> case skb_segment_list() returns the original skb, so the same skb is
> not freed twice.
>
> This text also applies to the codel piece. Does re-writting as above
> sound better?

Yes, much better!

> I may please you but then sashiko would ask me to change something in
> the wording ;->

Well, see above :)

>> Also:
>>
>> >  net/sched/sch_cake.c      | 198 ++++++++++++++++++++++++++++----------
>>
>> You're changing hundreds of lines of code which is partly a refactor,
>> partly a fix for the actual overflow issue, and partly unrelated
>> changes. Please split them into separate patches.
>>
>> [..]
>>
>> > +/* Compute the flow/host hash keys from the packet as received. Must =
run
>> > + * before skb_gso_segment(), which rewrites an encapsulated GSO packe=
t's
>> > + * headers to the inner ones and would change the keys. Reads only th=
e skb
>> > + * and commits no qdisc state, so it may run before admission is know=
n.
>> > + */
>>
>> And drop the weird LLM comments, please. If you split the series
>> properly they are not needed.
>>
>
> Like I said, it's a dilemma.

See above.

>> [..]
>> > -             skb_list_walk_safe(segs, segs, nskb) {
>> > -                     skb_mark_not_on_list(segs);
>> > -                     qdisc_skb_cb(segs)->pkt_len =3D segs->len;
>> > -                     qdisc_skb_cb(segs)->pkt_segs =3D 1;
>> > -                     cobalt_set_enqueue_time(segs, now);
>> > -                     get_cobalt_cb(segs)->adjusted_len =3D cake_overh=
ead(q,
>> > -                                                                     =
  segs);
>> > -                     flow_queue_add(flow, segs);
>> > +             skb_list_walk_safe(segs, seg, nskb) {
>>
>> The skb_list_walk_safe(segs, segs) thing is admittedly a bit weird, and
>> fixing it is fine. But that's the "separate fix" I was referring to
>> above, so split it out; it's just making the actual fix harder to
>> comprehend here.
>
>
> We have literally have about 100 followups to review from complaints
> of "re-exsting issues" by sashikos and other ai officianados (there
> are at least another 10 on cake) and the hard part is sifting through
> and picking what is important enough to submit. And then deal with the
> fallback from the sashikos turning transforming into bike-shedders.
> I am trying to avoid sending many patches. But i could split this into:
>
> - 0001 (prep, no behavior change): extract cake_tcf_classify() and the
> fq_codel_classify() rewrite.
> - 0002 (prep, no behavior change): skb_list_walk_safe(segs, seg) rename.
> - 0003 (fix): the enqueue ceiling guard across fq_codel / codel / pie
> / fq_pie / dualpi2 / pfifo / RED / cake, plus the
> qdisc_pkt_len_segs_init() producer clamp. pfifo stays here - RED reads
> a grafted child's backlog, so it is the same overflow, not a separate
> bug.
> - 0004 (cake restructure): the cake_hash_keys() / cake_hash_resolve()
> split and the split-GSO relocation.
>
> Would that work?

Yeah, this seems roughly along the lines of what I was imagining :)

-Toke
