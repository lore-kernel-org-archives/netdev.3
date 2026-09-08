Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8AD59B67B
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 18:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788892396; cv=pass; b=YdOpWRxVkCNhvRj1OTSlZ2RCH2suv4r6aNmgJH7SpIcWXze9o2+VyRBEnrxQChDENX7SWP+DO2Yhn5ldhTRQarw4t6ArtRngCK5IElgVOaMgcay4qs3XxDZ60jpf7WXH7W1WKet/1JwBooiyuNiO7ep6nT2+D30IdAe4e90yICc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788892396; c=relaxed/simple;
	bh=t5riILGg6B1U7srPeJ3Ugbb+D55flYIMDrLkCa3lvzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Es0NoH/SG/0eWSgkSnX2c1ZVqcOOMeZzRZxJsG/tk4Xnu6udMoLbrAtC8BrrFztAxxkkPXiTYu4fjcZ6vohw8t6QEP9Fi5gdy+u9u5skbBXhn+GaG+S12N6qbSD4Fz4bQWL+nVfXbpfVKe5Dq6J3upIHQqGtx9bPSOiqSrqT2HI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qrator.net; spf=pass smtp.mailfrom=qrator.net; dkim=pass (1024-bit key) header.d=qrator.net header.i=@qrator.net header.b=Sy5lwEEj; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qrator.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qrator.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qrator.net header.i=@qrator.net header.b="Sy5lwEEj"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso6305005a91.2
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 11:33:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788892393; cv=none;
        d=google.com; s=arc-20260327;
        b=Vw3nKLRTybXjjXDfBTK040Y6H+QFy59S73SqL4MTrmFn401qrN42cPBfNHl3AA0zfb
         11s6GjPDogMMRI6nPNq0ff3NbYTc6sN6h/1uPMEEkvyG8WAaormac4AHB/LlhW2L6Ofs
         yAXZbLztwNXz/Zqi880D8o1rG68m1d+SIC3VHIPq8C8RZAg5zaj2C/qHvtSV2cGE+jCm
         MU5cL3RbY+8SvbxqyUHEuzL3UZt/eD7NoRoeBQdSLmyorCkvvSIzs0tBcrWiNof99EKa
         9jlesNI+rNF3xCxF36TYriv6Od/5RXl/wKw9TxExyj1t7QGkFkwq9Wi3S6b7+s1Kjdgq
         rjoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gaWew67qhDdPze9MTbLjfTYADpT+ZhioR8f3g6lBHNY=;
        fh=SKDB+nVfiD1LFCeIJtruMWyWdrfFNu2iaAj5xF6OJNk=;
        b=ce0FCPu8nStmIeqaWr5N6H4EExDOcxms7FjUDKwpDVZzf4NC7Qm8W0imSIGjQNtBM0
         fI/ut+3TngqNRuzV4nGgFDPU3Wwt5g+MMOXRj3knvIEu7sNEPHqZ+i2XHqboIWvRdVZA
         fCpyXqxrNoSVD4c5OOZte/jv/AIGpv2H5N1teAFe/ZZIqbl/l4ODJipPfJZvH78WuqzP
         XviEp2Qoiz2yFMok73n9ytbZ30WP8TP6lxtC69zeDtlmogCgG3QJXY0ju5tCEs4Yy56l
         xAkz46FqIz59jO+cHJJi/X/mnDyG9ws2hiwJmiKPp7xbJIWxCJJmX7HRk1ASpolkmfuQ
         r3oQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qrator.net; s=google; t=1788892393; x=1789497193; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gaWew67qhDdPze9MTbLjfTYADpT+ZhioR8f3g6lBHNY=;
        b=Sy5lwEEj4B/r4dXiU4GxY9NBX1Vkq94742GDPVlioHaFSMTNrG6T9zQCPfKC0ExMie
         xdcUani05QMqQ+m4rrW12cccaESWPvcHXMby49pIEAreSK08WSWSjrK8wB5pLcR+XkB2
         tjuNEbrmwFfl1xZelInD6bMLLAFqa30lzU9Go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788892393; x=1789497193;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gaWew67qhDdPze9MTbLjfTYADpT+ZhioR8f3g6lBHNY=;
        b=dn5NO8xt5/dCO6hewG5zm8tzBREDjOoMWuVtI8ITe+Q+q9d0WsU3nPIEP7U0k9Gd8m
         GF76XIy/mnBdQ9U4+3+Jw1LOsSfOSH3RT0kQuBA83A6P9J7B4vVss0ekFPtiOlPAgkAb
         N0qN+Jkz0exAqvbR8k89jRjzFQRnr2dGLWnYHmLs97jV/anPeB3iKAsQAsy/zSlo7WtV
         toDoL3UhcUoOCfZEaEvlGuIho0QC1cIVp7GHLIHu4Zj7ZRfgckIxAm4heHo/fFE3A8GV
         oGeW4zUCtM9QvgU/nP2ZpxPCbazf5aH+zHrI+QuAeok8m+8K3PaeM6o9tbq0pN/1Mirv
         g8Zw==
X-Gm-Message-State: AFuF++n6j6JNkl7oaw+em4Q1a6+9jSZmGJTtaBrq+iCSOJ8zxkkPZrl6
	tIBh1QjQ5Q31YAquvPa044FPDX4F7Ah4Rlc33kCufFZ8RZ8Lyuk4IdkHQY6qivzF82fqMp4b5MB
	m3ZFD4CX/V7Com+PJIS5QhTfvwFqUSv8IgULxN4GKQA==
X-Gm-Gg: AYBFou2rLqOYw98cVrx3KnxaEjsQ8FOLbD+tSqZUcM+QAhJvOGezvIV9DvjZmWNx0mW
	v6qAExTmDyJqY6BmotXCSVZ5rdKJLM+Q8agvfUV0RBOddY4RHC6RP+Ok9UMtcallFG97HO6Dspg
	JQUoLbpv9cgG2a1FDw853Z4ZnL3WNdF61xmvUsj5gvSak86CYxGbQ6shRvr6EQNkuwpvrZKMeqy
	TnrLGY/St29W3vlUcbNqA82xswWyrKOCJGiOBmnfXGgvl2A8Qxvp9P54qCh9dG8IDp4OQlpvE/R
	tg+nuViWPgwvRtosENj4mBMRX6PPf0qvhUOWwXuTqJPbb9L7Nsh61/BtSGuq7SoTsxBs9UnO/F3
	ft5ENbWuGIvq0MQnuqfEFwhHWvOPULCZSmKz9ICXiwWldMTeTdrtgGOxlBNHkmXgF
X-Received: by 2002:a17:90a:e703:b0:398:d843:cad9 with SMTP id
 98e67ed59e1d1-39b26226de8mr47715731a91.19.1788892393022; Tue, 08 Sep 2026
 11:33:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830181949.1096-1-green@qrator.net> <20260830181949.1096-2-green@qrator.net>
 <87o6eh0zyq.fsf@pmachata.org> <CABr+u0YC2NVjQLM+fd0o0By0wAXXxQd-AAcRWj-skNDQrX_duw@mail.gmail.com>
In-Reply-To: <CABr+u0YC2NVjQLM+fd0o0By0wAXXxQd-AAcRWj-skNDQrX_duw@mail.gmail.com>
From: Alexander Zubkov <green@qrator.net>
Date: Tue, 8 Sep 2026 20:32:45 +0200
X-Gm-Features: AcwNN1Vpf8jZvWKsteTi6CeT7h_hVgqlcqEx3hMZEmFzWwOGte_vcHi5bT6_dv4
Message-ID: <CABr+u0YYuKgJTH0Ht5jRUiVNfYx6gEjWFFjpbZ-U5CUhyr8Ghg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ip: ipstats: Merge statistics split across several
 netlink messages
To: Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>, 
	Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello again,

I've finally completed the rework, and just sent the updated patches.
The cover letter is a bit verbose, but there are several assumptions
the patch is built on, so I believe they are worth mentioning. We've
remade the algorithm of the patch and I tried my best to make it clear
and concise.

Another question I had during my investigation of the problem. The
current merger approach is not aware of the structure of the
attributes. But the parsing functions in the printing part know what
they expect. And it is technically possible not to merge the messages
in the first place, but keep them together and send them further
togeter, where we can try to do the merge on the fly, having the
information from the parser. And we even do some prototype for that,
that doesn't look too intrusive. But on the other hand it seems that
the kernel doesn't do much splitting on the deeper levels and the
current merge approach might work well enough. And actually the kernel
should not do it, otherwise there can be some indistinguishable cases.
So my question is - is it worth further research and should I prepare
the patches for that, or it is not justified enough to do that?

Regards,
Alexander Zubkov

On Wed, Sep 2, 2026 at 9:20=E2=80=AFPM Alexander Zubkov <green@qrator.net> =
wrote:
>
> Hi guys,
>
> Thanks for the feedback. I wasn't sure how much explanation is ok
> here, that is why I passed it as is. I agree that AI agents are way
> too verbose. I'll try to get/make a more concise version. I'll need to
> post v2 patches here, right?
>
> On Tue, Sep 1, 2026 at 5:12=E2=80=AFPM Petr Machata <petrm@nvidia.com> wr=
ote:
> >
> > Alexander Zubkov <green@qrator.net> writes:
> >
> > > A netlink dump can split the statistics of a single interface across
> > > several messages. When an attribute does not fit into the current skb=
,
> > > rtnl_fill_statsinfo() keeps the partial message, records how far it g=
ot
> > > in idxattr/prividx, and the dump is resumed at the same ifindex, with
> > > the remaining attributes emitted in the next message.
> > >
> > > "ip stats show group offload subgroup l3_stats" requests both
> >
> > The reproducer I had to use was
> >
> >     ip stats show group offload | grep 'subgroup l3_stats' | less
> >
> > No amount of interfaces (tried up to 4K VLAN netdevices) triggered the
> > issue when I requested 'group offload subgroup l3_stats'.
> >
> > I guess I should have enabled some of those L3 counters :)
>
> Probably yes. Because I do not have a lot of interfaces, 119 to be
> precise, and first 90 of them do not have l3_stats enabled. And all of
> them fit into 2 netlink reads, problem interface is number 109. So I
> do not think much of them is required to hit the issue, but some bad
> luck so that one of them gets fragmented.
>
> >
> > > IFLA_OFFLOAD_XSTATS_HW_S_INFO and IFLA_OFFLOAD_XSTATS_L3_STATS, and
> > > rtnl_offload_xstats_fill() emits them one by one, so a dump over a
> > > sufficient number of netdevices regularly ends up cut in between the
> > > two. Each message is currently formatted on its own, which yields two
> > > bogus records instead of one, and, because ipstats_show_hw_stats() ba=
ils
> > > out when the HW_S_INFO attribute is missing, the counters carried by =
the
> > > second message are dropped:
> > >
> > >     109: vlan859: group offload subgroup l3_stats on used on
> > >
> > >     109: vlan859: group offload subgroup l3_stats
> > >
> > > Postpone formatting until the whole object has been received: keep th=
e
> > > message around, merge into it any immediately following message that
> > > carries the same ifindex, and format the result once a message for
> > > another ifindex arrives or the dump ends. At most one interface worth=
 of
> > > statistics is buffered at a time.
> > >
> > > Merging the two messages means merging the nests that were open when =
the
> > > first one was cut short and that got reopened in the second one. Netl=
ink
> > > does not mark nests reliably here -- nla_nest_start_noflag() is used =
--
> > > so they are recognized by the message layout instead: a reopened nest
> > > appears exactly once in either message, and at the outer level is kno=
wn
> > > to be a nest by ipstats_stat_ifla_max[]. That knowledge only reaches =
as
> > > deep as ipstats.c parses the message, so merging stops at the group
> > > nests and their contents are appended in the order they arrived, whic=
h
> > > is correct both for a deeper nest reopened between two of its childre=
n
> > > and for an array of same-type attributes, as bridge per-VLAN xstats a=
re.
> > >
> > > A layout that does not fit the above cannot be told apart from an arr=
ay
> > > of same-type attributes, and reassembling it would corrupt the result=
.
> > > Such a message pair is refused with -EOPNOTSUPP and the two halves ar=
e
> > > formatted separately, as before this patch. Failures to allocate or t=
o
> > > build the merged message are not papered over that way and terminate =
the
> > > dump.
> > >
> > > Fixes: 54d82b0699a0 ("ip: Add a new family of commands, "stats"")
> > > Assisted-by: Claude:claude-opus-5
> > > Signed-off-by: Alexander Zubkov <green@qrator.net>
> >
> > The patch looks broadly OK to me, including the commit message, which I
> > see Stephen isn't too fond of. I agree the comments are way too verbose=
.
> > Some more commentary below.
> >
> > > ---
> > >  ip/ipstats.c | 280 +++++++++++++++++++++++++++++++++++++++++++++++++=
+-
> > >  1 file changed, 276 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/ip/ipstats.c b/ip/ipstats.c
> > > index 8a2ac85e..c531885f 100644
> > > --- a/ip/ipstats.c
> > > +++ b/ip/ipstats.c
> > > @@ -850,12 +850,225 @@ ipstats_show_one(int ifindex, struct ipstats_s=
tat_enabled *enabled)
> > >       return err;
> > >  }
> > >
> > > -static int ipstats_dump_one(struct nlmsghdr *n, void *arg)
> >
> > So the following comment is super long and nobody will read it. You nee=
d
> > to look into the code to figure out what's what anyway, and the comment
> > does not really help with that. So I'd keep this:
> >
> > > +/* A netlink dump can split the statistics of one interface across s=
everal
> > > + * messages:
> >
> > and drop all this:
> >
> > >               when an attribute does not fit into the current skb, th=
e kernel
> > > + * ends the message and resumes the dump at the same ifindex, emitti=
ng the
> > > + * remaining attributes in the next message. See rtnl_fill_statsinfo=
() and
> > > + * rtnl_offload_xstats_fill() in the kernel.
> > > + *
> > > + * Reassembling the two messages means merging the nests that were o=
pen when
> > > + * the first message was cut short and got reopened in the second on=
e. Netlink
> > > + * does not mark nests reliably -- nla_nest_start_noflag() is used h=
ere -- so
> > > + * they are recognized by the message layout instead: a nest that wa=
s reopened
> > > + * appears exactly once in either message, and, at the outer level, =
is known to
> > > + * be a nest by ipstats_stat_ifla_max[].
> > > + *
> > > + * That knowledge only reaches as deep as ipstats.c parses the messa=
ge, so
> > > + * merging stops at the group nests, and their contents are appended=
 in the
> > > + * order they arrived. Appending is the right thing to do whether a =
deeper nest
> > > + * was reopened between two of its children or the children are just=
 an array
> > > + * of same-type attributes, as bridge per-VLAN xstats are. It does t=
he wrong
> > > + * thing only if a kernel splits a nest that ipstats.c does not know=
 how to
> > > + * show either, in which case the merge is not the first thing that =
needs
> > > + * updating.
> > > + */
> >
> > Writing is kinda Claude's thing, so it does it a lot, it comments
> > everything like crazy, inlines whole functions instead of reusing, etc.
> > I find myself having to moderate its code a lot because of this.
> >
> > > +
> > > +enum {
> > > +     /* Merge the outer level and the group nests, append below that=
. */
> > > +     IPSTATS_MERGE_MAX_DEPTH =3D 1,
> > > +};
> > > +
> > > +static struct rtattr *ipstats_rta_find(struct rtattr *rtas, int len,
> > > +                                    unsigned short type, unsigned in=
t *count)
> > > +{
> > > +     struct rtattr *found =3D NULL;
> > > +     struct rtattr *rta;
> > > +
> > > +     *count =3D 0;
> > > +     for (rta =3D rtas; RTA_OK(rta, len); rta =3D RTA_NEXT(rta, len)=
) {
> > > +             if (rta->rta_type !=3D type)
> > > +                     continue;
> > > +             if (found =3D=3D NULL)
> > > +                     found =3D rta;
> > > +             (*count)++;
> > > +     }
> > > +
> > > +     return found;
> > > +}
> > > +
> > > +/* Whether the two messages can be reassembled at this attribute, an=
d how.
> > > + * MERGE means RTA and OTHER are the two halves of one nest that the=
 first
> > > + * message left open. APPEND means the attribute belongs to one mess=
age only
> > > + * and is copied over as it is. REFUSE means the type is present in =
both
> > > + * messages in a layout that cannot be told apart from an array of s=
ame-type
> > > + * attributes, so reassembling it would corrupt the result.
> > > + */
> >
> > Drop the comment. It's clear from the code and the names what it does.
> >
> > > +enum ipstats_merge_action {
> > > +     IPSTATS_MERGE_APPEND,
> > > +     IPSTATS_MERGE_MERGE,
> > > +     IPSTATS_MERGE_REFUSE,
> > > +};
> > > +
> > > +static enum ipstats_merge_action
> > > +ipstats_merge_action(const struct rtattr *rta, unsigned int nrta,
> > > +                  const struct rtattr *other, unsigned int nother, i=
nt depth)
> > > +{
> > > +     if (rta =3D=3D NULL || other =3D=3D NULL)
> > > +             return IPSTATS_MERGE_APPEND;
> >
> > This is one useful tidbit from the wall of text above, and it should be
> > here, not there:
> >
> >         /* If we have >1 hit for an attribute, it's an array of
> >          * same-type attributes. Bail out. */
> > > +     if (nrta !=3D 1 || nother !=3D 1)
> > > +             return IPSTATS_MERGE_REFUSE;
> > > +
> > > +     if (depth =3D=3D 0) {
> >
> > Hmm, I suspect this depth =3D=3D 0 and the above IPSTATS_MERGE_MAX_DEPT=
H =3D=3D 1
> > are correlated? We can't validate attribute type in ipstats_merge_actio=
n
> > at depth > 0, so it's unnecessary to recurse into ipstats_merge_rtas()
> > beyond and and we can optimize this case by just copying all the
> > attributes right away through ipstats_copy_rtas.
> >
> > If this just returned an IPSTATS_MERGE_APPEND in an else branch, then w=
e
> > wouldn't need ipstats_copy_rtas(), IPSTATS_MERGE_MAX_DEPTH, and the
> > related special casing.
>
> I can only tell now, that it first was merging attributes the other
> way, than after some of my questions it found out that it would not
> work for bridge vlan attributes, because there are some other sort of
> merging is needed and produced this construction. But I do not
> understood it much. I would need to invest some time to understand
> those attributes and things. Probably it would be better anyway, I'll
> try to figure it out.
>
> >
> > > +             unsigned int type =3D rta->rta_type;
> > > +
> > > +             if (type >=3D ARRAY_SIZE(ipstats_stat_ifla_max) ||
> > > +                 ipstats_stat_ifla_max[type] =3D=3D 0)
> > > +                     return IPSTATS_MERGE_REFUSE;
> > > +     }
> > (         else {
> >                 return IPSTATS_MERGE_APPEND;
> >         })
> >
> > Maybe the branch needs to be elsewhere for actual array calls. I took a
> > code modified like this for a spin, and got the same output, but I
> > wasn't trying to cover all counter types, so I might be missing
> > something.
> >
> > Plus the optimized copy saves the find calls, which is not nothing.
> >
> > But in any case I don't like how we end up with this
> > IPSTATS_MERGE_MAX_DEPTH pretending to be all configurable when in fact
> > the only value that makes sense is 1.
> >
> > > +
> > > +     return IPSTATS_MERGE_MERGE;
> > > +}
> > > +
> > > +static int ipstats_copy_rtas(struct nlmsghdr *n, int maxlen,
> > > +                          struct rtattr *rtas, int len)
> > > +{
> > > +     struct rtattr *rta;
> > > +
> > > +     for (rta =3D rtas; RTA_OK(rta, len); rta =3D RTA_NEXT(rta, len)=
) {
> > > +             if (addattr_l(n, maxlen, rta->rta_type,
> > > +                           RTA_DATA(rta), RTA_PAYLOAD(rta)))
> > > +                     return -EMSGSIZE;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int ipstats_merge_rtas(struct nlmsghdr *n, int maxlen,
> > > +                           struct rtattr *a, int alen,
> > > +                           struct rtattr *b, int blen, int depth)
> > > +{
> > > +     struct rtattr *rta;
> > > +     int rem;
> > > +     int err;
> > > +
> > > +     for (rta =3D a, rem =3D alen; RTA_OK(rta, rem); rta =3D RTA_NEX=
T(rta, rem)) {
> > > +             unsigned int nrta, nother;
> > > +             struct rtattr *other;
> > > +             struct rtattr *nest;
> > > +
> > > +             other =3D ipstats_rta_find(b, blen, rta->rta_type, &not=
her);
> > > +             ipstats_rta_find(a, alen, rta->rta_type, &nrta);
> > > +
> > > +             switch (ipstats_merge_action(rta, nrta, other, nother, =
depth)) {
> > > +             case IPSTATS_MERGE_REFUSE:
> > > +                     return -EOPNOTSUPP;
> > > +             case IPSTATS_MERGE_APPEND:
> > > +                     if (addattr_l(n, maxlen, rta->rta_type,
> > > +                                   RTA_DATA(rta), RTA_PAYLOAD(rta)))
> > > +                             return -EMSGSIZE;
> > > +                     continue;
> > > +             case IPSTATS_MERGE_MERGE:
> > > +                     break;
> > > +             }
> > > +
> > > +             nest =3D addattr_nest(n, maxlen, rta->rta_type);
> > > +             if (nest =3D=3D NULL)
> > > +                     return -EMSGSIZE;
> > > +
> > > +             if (depth < IPSTATS_MERGE_MAX_DEPTH) {
> > > +                     err =3D ipstats_merge_rtas(n, maxlen,
> > > +                                              RTA_DATA(rta), RTA_PAY=
LOAD(rta),
> > > +                                              RTA_DATA(other),
> > > +                                              RTA_PAYLOAD(other), de=
pth + 1);
> > > +             } else {
> > > +                     err =3D ipstats_copy_rtas(n, maxlen, RTA_DATA(r=
ta),
> > > +                                             RTA_PAYLOAD(rta));
> > > +                     if (!err)
> > > +                             err =3D ipstats_copy_rtas(n, maxlen,
> > > +                                                     RTA_DATA(other)=
,
> > > +                                                     RTA_PAYLOAD(oth=
er));
> > > +             }
> > > +             if (err)
> > > +                     return err;
> > > +
> > > +             addattr_nest_end(n, nest);
> > > +     }
> > > +
> > > +     for (rta =3D b, rem =3D blen; RTA_OK(rta, rem); rta =3D RTA_NEX=
T(rta, rem)) {
> > > +             unsigned int nrta, nother;
> > > +             struct rtattr *other;
> > > +
> > > +             other =3D ipstats_rta_find(a, alen, rta->rta_type, &not=
her);
> > > +             ipstats_rta_find(b, blen, rta->rta_type, &nrta);
> > > +
> > > +             /* Whatever is present in both messages has been dealt =
with
> > > +              * in the loop above.
> > > +              */
> > > +             if (ipstats_merge_action(rta, nrta, other, nother,
> > > +                                      depth) !=3D IPSTATS_MERGE_APPE=
ND)
> > > +                     continue;
> > > +
> > > +             if (addattr_l(n, maxlen, rta->rta_type,
> > > +                           RTA_DATA(rta), RTA_PAYLOAD(rta)))
> > > +                     return -EMSGSIZE;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int ipstats_ifsm_len(const struct nlmsghdr *n)
> > > +{
> > > +     return n->nlmsg_len - NLMSG_LENGTH(sizeof(struct if_stats_msg))=
;
> > > +}
> > > +
> > > +static struct nlmsghdr *ipstats_msg_merge(const struct nlmsghdr *a,
> > > +                                       const struct nlmsghdr *b, int=
 *err)
> > > +{
> > > +     int hdrlen =3D NLMSG_LENGTH(sizeof(struct if_stats_msg));
> > > +     int maxlen =3D a->nlmsg_len + b->nlmsg_len;
> > > +     struct nlmsghdr *n;
> > > +
> > > +     n =3D calloc(1, maxlen);
> > > +     if (n =3D=3D NULL) {
> > > +             fprintf(stderr, "Error merging netlink answer: %s\n",
> > > +                     strerror(errno));
> > > +             *err =3D -errno;
> > > +             return NULL;
> > > +     }
> > > +
> > > +     memcpy(n, a, hdrlen);
> > > +     n->nlmsg_len =3D hdrlen;
> > > +
> > > +     *err =3D ipstats_merge_rtas(n, maxlen,
> > > +                               IFLA_STATS_RTA(NLMSG_DATA(a)),
> > > +                               ipstats_ifsm_len(a),
> > > +                               IFLA_STATS_RTA(NLMSG_DATA(b)),
> > > +                               ipstats_ifsm_len(b), 0);
> > > +     if (*err) {
> > > +             free(n);
> > > +             return NULL;
> > > +     }
> > > +
> > > +     return n;
> > > +}
> > > +
> > > +struct ipstats_dump_ctx {
> > > +     struct ipstats_stat_enabled *enabled;
> > > +     struct nlmsghdr *pending;
> > > +};
> > > +
> > > +static int ipstats_dump_pending(struct ipstats_dump_ctx *ctx)
> > >  {
> > > -     struct ipstats_stat_enabled *enabled =3D arg;
> > > +     struct nlmsghdr *n =3D ctx->pending;
> > >       int rc;
> > >
> > > -     rc =3D ipstats_process_ifsm(stdout, n, enabled);
> > > +     if (n =3D=3D NULL)
> > > +             return 0;
> > > +
> > > +     ctx->pending =3D NULL;
> > > +     rc =3D ipstats_process_ifsm(stdout, n, ctx->enabled);
> > > +     free(n);
> > >       if (rc)
> > >               return rc;
> > >
> > > @@ -863,8 +1076,63 @@ static int ipstats_dump_one(struct nlmsghdr *n,=
 void *arg)
> > >       return 0;
> > >  }
> > >
> > > +static int ipstats_dump_one(struct nlmsghdr *n, void *arg)
> > > +{
> > > +     struct ipstats_dump_ctx *ctx =3D arg;
> > > +     struct nlmsghdr *merged;
> > > +     struct nlmsghdr *copy;
> > > +     int rc;
> > > +
> > > +     if (ipstats_ifsm_len(n) < 0) {
> > > +             fprintf(stderr, "BUG: wrong nlmsg len %d\n", n->nlmsg_l=
en);
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     if (ctx->pending !=3D NULL) {
> > > +             const struct if_stats_msg *pending =3D NLMSG_DATA(ctx->=
pending);
> > > +             const struct if_stats_msg *ifsm =3D NLMSG_DATA(n);
> > > +
> > > +             if (pending->ifindex =3D=3D ifsm->ifindex) {
> > > +                     merged =3D ipstats_msg_merge(ctx->pending, n, &=
rc);
> > > +                     if (merged !=3D NULL) {
> > > +                             free(ctx->pending);
> > > +                             ctx->pending =3D merged;
> > > +                             return 0;
> > > +                     }
> > > +                     if (rc !=3D -EOPNOTSUPP)
> > > +                             return rc;
> > > +
> > > +                     /* An attribute layout that cannot be reassembl=
ed:
> > > +                      * show the two halves separately, like older
> > > +                      * versions did, rather than dropping either.
> > > +                      */
> > > +                     fprintf(stderr,
> > > +                             "Cannot merge statistics of ifindex %d =
split across messages\n",
> > > +                             ifsm->ifindex);
> > > +             }
> > > +
> > > +             rc =3D ipstats_dump_pending(ctx);
> > > +             if (rc)
> > > +                     return rc;
> > > +     }
> > > +
> > > +     copy =3D malloc(n->nlmsg_len);
> > > +     if (copy =3D=3D NULL) {
> > > +             fprintf(stderr, "Error saving netlink answer: %s\n",
> > > +                     strerror(errno));
> > > +             return -ENOMEM;
> > > +     }
> > > +
> > > +     memcpy(copy, n, n->nlmsg_len);
> > > +     ctx->pending =3D copy;
> > > +     return 0;
> > > +}
> > > +
> > >  static int ipstats_dump(struct ipstats_stat_enabled *enabled)
> > >  {
> > > +     struct ipstats_dump_ctx ctx =3D {
> > > +             .enabled =3D enabled,
> > > +     };
> > >       int rc =3D 0;
> > >
> > >       if (rtnl_statsdump_req_filter(&rth, PF_UNSPEC, 0,
> > > @@ -874,11 +1142,15 @@ static int ipstats_dump(struct ipstats_stat_en=
abled *enabled)
> > >               return -2;
> > >       }
> > >
> > > -     if (rtnl_dump_filter(&rth, ipstats_dump_one, enabled) < 0) {
> > > +     if (rtnl_dump_filter(&rth, ipstats_dump_one, &ctx) < 0) {
> > >               fprintf(stderr, "Dump terminated\n");
> > >               rc =3D -2;
> > >       }
> > >
> > > +     if (rc =3D=3D 0)
> > > +             rc =3D ipstats_dump_pending(&ctx);
> > > +
> > > +     free(ctx.pending);
> > >       return rc;
> > >  }
