Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1FC3DDB00
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 09:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791537623; cv=pass; b=KzdnWjvUG+z+/e6OcO7pgwzM5fxbKUFslZYf2sKTmDJHvpdngIMvdWZHVnn/jlLRjgIem29+DH2dBSyeLfBpi6OvB8Ct7FqHgykmmQDcECQHcdCK5qrFtbT6VuAuCrrMwfiBI++ldSTPzWhkBSZiv1j/aQTIoUu5L6UKjluN3gI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791537623; c=relaxed/simple;
	bh=8T+bagEFNAv/OZqLOip7XkPhqwlIGOPZXUhaa6oDbGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZVhnicGTLJEyjYJFjO8+I1qOXSST0Cmpiw4Fg49B69UkyrPq6fVSgyf1zoV+DxhF+6LE2D8XkmYFMMh8mELRvyPnj2pC/pPatZg70v1Dp4zafEBCIpDORfv9jrQB9dD186BSID0qqZqut0AwpHpQFNQyh+wkTZfzxrxzilbyshI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=t68XhJ7p; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="t68XhJ7p"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-881269371acso786421b3a.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 02:20:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791537620; cv=none;
        d=google.com; s=arc-20260327;
        b=fS95JRFymJLbpGjIbrraM65+zSO1SRUDpWm8UjFsjy87ZzW9gZSE94sru5Sjy1M+pV
         wlopROSKTIBGZotPZ1Gg4bSoMtTx31LtSitTvdHSxmjm3H/S1uskwe7slEnSDjtg10Tl
         Bkevs4JpWvq2XKFzIvLMpfhDdZT7nQPuQ4yvhPj7bH8iDizvvpz/Ph1MntRSRI5czctF
         +bUBZNj+pwtLgr5N3A0nLuZnH+grQ2fRtb88DVxppXIORseA6WaqCpAFlLhjV9UQIXad
         U/IIMDFmM21arP2v4T/akbkA2cVI6n/nGREmI3pml3SZzQEPXKXjyt6IRl1XGu1FHuk2
         XMlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8T+bagEFNAv/OZqLOip7XkPhqwlIGOPZXUhaa6oDbGU=;
        fh=/KNHanBKvb0UpdGuR+44c0O9Rlfl/GH50TXZciVvwTQ=;
        b=eZzcxr9++svmW3gnuZG6Bfieh3BrY7JTvwmQMxVqWJWdmBQoW17oEHO655CcUmJCX5
         /pZCQ4/PO+GpOUTMKYBCHAlVhNMQdMWBEIaiyL5OVCELSCnA/lku/y5Bc4MO1PsZcDxC
         k/RrEQ7qTu1QfjO995wWqEvDJ4LmladBh8BKRA8IBnPhIBP5bUHf+ptd1j0DVvn67ZNl
         5xwW6tEPWQKEQZzZobsa5z5LKrVhAComp7DeRx3TR0KXLWl/NbZ/dnhcVe2jkHMUxaQ3
         zR2qCq9rwX0aiGTU3TkCFtVg5weSdgWLkZWQakK7TnZTXBU9djWf7IbzAuZfbRb3ffr1
         Ty9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791537620; x=1792142420; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8T+bagEFNAv/OZqLOip7XkPhqwlIGOPZXUhaa6oDbGU=;
        b=t68XhJ7pAPCuLCAKIjXDBPA0IyjBdTwjN4xmQAfvYn/H4QSvvuF0WUGRSTFsVkWMvi
         h7yatPDOy8v51Lby0I0Z93qOam5vvzeGKAsWPlD6A+YrXcYlmzHD/QmIgETui1uu5dZu
         IIhXVCM5xLNZjS1JeOoBBO+ys+XubKGz3VXlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791537620; x=1792142420;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8T+bagEFNAv/OZqLOip7XkPhqwlIGOPZXUhaa6oDbGU=;
        b=gKWsbfLEREZhrzQW6XC2qOUr1/W64Ng3y5YYrWaSSc4Hm5+a6ejxP+QmnCXzxvN5e/
         gItPC1SHZ8QVSA6ujU23SvNbJ7nwfBJZhrd28TWeFA2N96eh5yqFGGTSRYm/SbERQhNN
         t5/0JV4E2kKGmq7JIND0E7yi9zmuUOvhibKLVDslJuCX2P+6dOYztVdup0ZEboavs8bS
         xLSGIYsg6CZQg3IuXYEzHr3VcxRtd9ez1nOP3TMRie1kD5kX7aIsxbC+7m+4foMEm7NH
         2OAOwFoHgv8iBQq0hljQVMT6dP7zTSgMEDj0FSrO8qna2xgG/33VQsAmfrgjsZhZiiEQ
         HRog==
X-Gm-Message-State: AFq9FYJILvDL9gxzY6+GyLZBW4Brb6bFexVOKEoW7t/bhiYT5pePwRr7
	oZSWjDYXECTFgaFErxFL5AQfjjUriazDzxhnIxCYmQx2BBhWRPrFr4gUq3ZrLp9kvjqruXTYW8m
	7rnN9UiKmDbX8S2nV4Tfb2upcvc50c0YWu6aGusRl
X-Gm-Gg: AYBFou1wAgA0W6M71pvxhzEPAu9XwCWWOifL0aok0rO3xe46rpZQeT34FACJAcYWMDo
	6l98D3PVJ8ovCZjVPwhngPDqAXvQk887EU1GrbKcwLl1kXwPnGmIc0j/36CQ1YXqVCcCZcnajWW
	qZdzlCyAubbl8JiNPSIgUTqR/OXlRENkT5JXLDRpvBU8GIPQko/A29pFryAgwhRxLVsHyWtR2Lt
	PxSSZWfxuYVXO8BbdIi4jUeqPE18HcrHsnMNN/Py7ewMNX4B3QBwt+0jRQvq+b6aEebH54BacW4
	HMy38n46TaUD1BUqSK5HFnRScmSglo/q+l8Im0Hsxlo6hSNeAnpGY+R5ZUVEkrmsbssRSIaC6zE
	pstet5n1Zn0a2bvxNXiDLaUewg6MZgRk7uliZ6bAR9iex
X-Received: by 2002:a05:6a00:4c1b:b0:878:3705:5724 with SMTP id
 d2e1a72fcca58-896a4db0354mr1243619b3a.48.1791537620497; Fri, 09 Oct 2026
 02:20:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-BA27.v5.20261007171509@mojatatu.com> <87a4oottcj.fsf@toke.dk>
 <CAM0EoMmYEr4DLrjuM5hdPR5Lf1c=mU6WNpYydbzkGnWjqFxMrw@mail.gmail.com> <87pkxks68f.fsf@toke.dk>
In-Reply-To: <87pkxks68f.fsf@toke.dk>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 9 Oct 2026 05:20:09 -0400
X-Gm-Features: AclHuK9eYAfueee64evY9nqUNmiUsIv2Id4AfGG6z3lIOXpFCxFMLLRHDU4cOvQ
Message-ID: <CAM0EoM=QsM4EvWyPyAh5QzqDAo5g4kJF7v+=-00BJgi9OovFZQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5] net/sched: cap the accounted backlog before
 it can wrap
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Victor Nogueira <victor@mojatatu.com>, moeller0@gmx.de, cake@lists.bufferbloat.net, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 8:54=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@toke.dk> wrote:
>
> Jamal Hadi Salim <jhs@mojatatu.com> writes:
>
> > On Thu, Oct 8, 2026 at 6:29=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen=
 <toke@toke.dk> wrote:
> >>
> >> > This is a follow-up to an issue found by Sashiko (nipa) during revie=
w of
> >> > commit d9ebd8f9aa8b ("net/sched: fq_codel: clamp default quantum and
> >> > mtu"), part of the quantum/mtu overflow series merged as a687f2ae995=
f.
> >> > Clamping the per-flow quantum and the CoDel mtu does not bound the
> >> > accounted backlog, so the per-flow backlog wrap the review flagged
> >> > remained.
> >>
> >> This, and the rest of the commit message is obtuse LLM vomit, and clos=
e
> >> to unreadable. Please rewrite the commit message without the verbosity=
,
> >> so it's actually something a human reader can comprehend. For the cake
> >> bits in particular:
> >>
> >
> > Ok, but there is a dilemma: The verbosity is an attempt to appease the
> > sashikos. The other day it complained that i didnt have a space after
> > a semi colon.
>
> You know you can push back on Sashiko comments, right? :)
>

You can never if it listens to what you say ;-> See attached
screenshot on a small exchange where i pushed back. I did fix the
double space on the next one of course ;->



The human behind it is trying to teach it some bad habits ;->

> > The more stuff i add the less it slows me back. It picks on the
> > accuracy of the commit text _and changelogs_ and prescribes what i
> > said or should have said. I can understand a future AI review would
> > benefit from that; there are probably a few humans that read the
> > commit logs after the patch has gone in.
> > So:
> > I have been more targetting the AI more than humans in these comments.
>
> Writing to appease the bots at the expense of human readers is
> absolutely a mistake, IMO. Last time I checked, we are still a community
> of humans developing the kernel together, regardless of the fashionable
> assistance technology du jour. Having a comprehensive and understandable
> commit log is one of the kernel's greatest assets, and often one of the
> only things that makes complicated code understandable. We should not be
> sacrificing that in an attempt to make the work guess robot guess other
> words :/

I dont know ;-> Let's discuss in a year.

[..]

> > In plain english, it says three things (applies to :
> > 1) Splitting a GSO skb can account for more bytes than the original
> > packet, so we sum the whole segment list and test the total against
> > the ceiling before any segment is linked.
> > 2) If it is over, we drop the entire list, and because no flow state
> > (tags, hash indices, counters) has been resolved yet, the reject
> > leaves nothing behind.
> > 3) The fraglist sentence only picks which reference to drop for the
> > case skb_segment_list() returns the original skb, so the same skb is
> > not freed twice.
> >
> > This text also applies to the codel piece. Does re-writting as above
> > sound better?
>
> Yes, much better!
>


[..]

> > We have literally have about 100 followups to review from complaints
> > of "re-exsting issues" by sashikos and other ai officianados (there
> > are at least another 10 on cake) and the hard part is sifting through
> > and picking what is important enough to submit. And then deal with the
> > fallback from the sashikos turning transforming into bike-shedders.
> > I am trying to avoid sending many patches. But i could split this into:
> >
> > - 0001 (prep, no behavior change): extract cake_tcf_classify() and the
> > fq_codel_classify() rewrite.
> > - 0002 (prep, no behavior change): skb_list_walk_safe(segs, seg) rename=
.
> > - 0003 (fix): the enqueue ceiling guard across fq_codel / codel / pie
> > / fq_pie / dualpi2 / pfifo / RED / cake, plus the
> > qdisc_pkt_len_segs_init() producer clamp. pfifo stays here - RED reads
> > a grafted child's backlog, so it is the same overflow, not a separate
> > bug.
> > - 0004 (cake restructure): the cake_hash_keys() / cake_hash_resolve()
> > split and the split-GSO relocation.
> >
> > Would that work?
>
> Yeah, this seems roughly along the lines of what I was imagining :)
>

I will wait for sashiko to run - it does find good issues and will
resend with this and the one above in mind.

cheers,
jamal

> -Toke
