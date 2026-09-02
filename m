Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B2635F19A
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 19:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788376836; cv=pass; b=TW8g9RBWT59s9LP4mtcU1+1wI2I6jhvr6ORFPgfe8pto3SvTBt0Ith8ZXkUDHrxr5wDuthou2uP8mgyPe28U4rMKC8QM+tox8y0LKdWcRcsYgyvkHZ4MQK8kdz0gyfYgZVKRvdJNiCzUVuZfkDT+yoGkGr//4IeyJSNpszwifvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788376836; c=relaxed/simple;
	bh=9/Q69+bhGiocWjaH4kKXB51/SUG67celafWfmjXNMTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tf7DlGkGGm4rny45Ga4Qc3B741R/BKe/3kqgaShvHhzwTYKf4B23+jr3gMCoM1MFE+e6pARmOQ8IC/YBEbppBOEXzVQQnmdcwc4Di124H30wi3wfbQR0D7Q57mgnufmiFXtwBNUNEn5hjrJtHq7hUrKOuCeRRS1U0J9rvQWXlCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qrator.net; spf=pass smtp.mailfrom=qrator.net; dkim=pass (1024-bit key) header.d=qrator.net header.i=@qrator.net header.b=o+i9dklZ; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qrator.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qrator.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qrator.net header.i=@qrator.net header.b="o+i9dklZ"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c9e7391839cso1574652a12.0
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 12:20:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788376833; cv=none;
        d=google.com; s=arc-20260327;
        b=l0xrT+aZRB8COsn+rwEXwx3CAWMEuM6P3jNX+99APwTb4JfcaZi+T7N3YdCdcfMWt2
         3w+2I19ynBOjMCczhY/kw5nkwR4jLf8FPfJ8jlX1S0fSkcuG3DkM4cs7fBWjZP/ARp5B
         qh7te0QTZrxpgL++9x/d06feQfbgTuvVgcVdhYVB/nLBlrNik0vxO8wpee9NcvpT7Gcp
         0NaXXIUIUBeLfoIjP7e8LPmxZPdrTGhjfz7uqoydfYVMH6SalAjwgRrmdiywAmqAZ/MA
         Dix/nO+kUpUBz1jie40POvDxh8nnH6iwEtonp36ld3ZxSQeW5xeUJlXQZZ6oWqSJ2kW4
         OxGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tzw6LYqytzQPqHboZ6kQ6enoEQwvb88qRXGU8Bzd65E=;
        fh=SKDB+nVfiD1LFCeIJtruMWyWdrfFNu2iaAj5xF6OJNk=;
        b=Mm6z+jqPKuqS+AQlYe4H1jlwAp/v/wrB7lSERDgWPLK+dgFCK4WDHtsmKvkvqAnou3
         oD8hb23U+JazyoMPoPJBDFm+9paXmY8+W0ddy2IVAUTt65w38IW9AlOQdgpF/HL+Y1cg
         xcGNbYxOt8JRMSn9dM7/nqCZ2+aGbWB7NhranU64cZDDGNZMoyrn7BnW27yg5TdynSJf
         Mt9uqdXHXECIBo7m8R90qXZzr4ziljf5+88gYuBBioXMvNTWk3lqDB6iggb/ThzA+mrw
         yZqGvm7Y3Vj8EMuLiiTlfuH+uFdZF4YODMxG0ZnLQ7crx6ll9IeqitqAsEJ/is38zFqs
         QG/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qrator.net; s=google; t=1788376833; x=1788981633; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tzw6LYqytzQPqHboZ6kQ6enoEQwvb88qRXGU8Bzd65E=;
        b=o+i9dklZwsOz4iIaE1nHCjjm4ZccenpIo6AIQz2oDNGFfcUQDRxhmLMh2OAZmEjVb1
         JAYr0Qx7EsdjVVQVzxsjHvlQaCdjFFUsFiNarDETf85E05/S3kjuVUdVRS+p1HocO+Ao
         FN1GB8itzgW6pcf+KURQ318bY9V1yAEJ/Uztc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788376833; x=1788981633;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tzw6LYqytzQPqHboZ6kQ6enoEQwvb88qRXGU8Bzd65E=;
        b=G/UFOc1ZlQwWd/1Nes175vMqnw9AZPqljzY1+Hd/UgY6KXh/9eOwysviWgRQzY76rf
         vFW3pX4I2EN2Zz0IsERDgF8HdFCP+eD4+miNqbpFpQVS8nYtetUOCouWQZRWqjX2Rmjf
         9DapYhxFMhNJOix2I/zjJKBiOMqDRDTGqX6fTICKqhe22Y/JJSQYGkXRnaYn2tI1jQs4
         DrE4yRrcAMOmxdyZ06DwsfMZxM8JJXA0fjOPsgHc4qzouWkQR8Bsn/D2Ask+hoNjB5WG
         wTtmC7/TzH6WinTeY5txIqNoa/yS4URPkrIa65MWAWLR4RwTVNX6hJHCvhlBTyGWEQbA
         YOew==
X-Gm-Message-State: AFuF++ndC77P1T9SF/CdQ2khn/p8YqxzOpya8APwvyAe9Q9nm5LThKl9
	qkqgx/iE/nA8X8LUrN75OIJSCDIyobZIIp7td0h9u3kAFxVBcm73Dl7fQx5qXBUhxvgVmchf+W+
	TynVXEt0P4IKM3k14vi2P3aDMIQadEBnN1UE7nyj4Jw==
X-Gm-Gg: AYBFou2inTuJHYDx3ZyAoSlHWsS/SihVo23K63P9v1pKUkm43Zzsd+MY1tJemX9x5+a
	FeAv53pjEjuNF0lFDu60MCZ/fZOrFShfG2wy/FEqR0PPl7EX/BIOlTAw7C6DYj7wWE5oV6YCHfL
	plm0pBpfq+28EKwVsLbsLo4Jq9KQ7O8d1tDRRdYZzcPZkCbhUZCiD1sWo6sX5oo/YvCeiDbTCag
	vhx+E+kn+HpGg5wEO7mJnPrGzJJcAZRT7qKG0nK/y7FV6TQC13inLR9K4w6+kvPRR0Syy4MiRxI
	D2qsRNoqrA/NKNOAo8iUZC5Ry7d6qkQddaBeh/d0GLG+YkG7GjxzDvQKhehckUjlNizXpmfa5Ar
	sgg5/QOy1d4mENeALj0PEEj9f+h22O8IEQ4zV9PnO57dxak3/3XicgcWNWd6MI+Y=
X-Received: by 2002:a17:90a:d403:b0:396:4cbf:45a2 with SMTP id
 98e67ed59e1d1-39aee162852mr11674582a91.14.1788376833125; Wed, 02 Sep 2026
 12:20:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830181949.1096-1-green@qrator.net> <20260830181949.1096-2-green@qrator.net>
 <87o6eh0zyq.fsf@pmachata.org>
In-Reply-To: <87o6eh0zyq.fsf@pmachata.org>
From: Alexander Zubkov <green@qrator.net>
Date: Wed, 2 Sep 2026 21:20:06 +0200
X-Gm-Features: AcwNN1XIDUDov-SI7vDxrl-ciQZQwpJZPihPkaEdGZ_260wk_dHED2JmUgN_4Ko
Message-ID: <CABr+u0YC2NVjQLM+fd0o0By0wAXXxQd-AAcRWj-skNDQrX_duw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ip: ipstats: Merge statistics split across several
 netlink messages
To: Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>, 
	Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi guys,

Thanks for the feedback. I wasn't sure how much explanation is ok
here, that is why I passed it as is. I agree that AI agents are way
too verbose. I'll try to get/make a more concise version. I'll need to
post v2 patches here, right?

On Tue, Sep 1, 2026 at 5:12=E2=80=AFPM Petr Machata <petrm@nvidia.com> wrot=
e:
>
> Alexander Zubkov <green@qrator.net> writes:
>
> > A netlink dump can split the statistics of a single interface across
> > several messages. When an attribute does not fit into the current skb,
> > rtnl_fill_statsinfo() keeps the partial message, records how far it got
> > in idxattr/prividx, and the dump is resumed at the same ifindex, with
> > the remaining attributes emitted in the next message.
> >
> > "ip stats show group offload subgroup l3_stats" requests both
>
> The reproducer I had to use was
>
>     ip stats show group offload | grep 'subgroup l3_stats' | less
>
> No amount of interfaces (tried up to 4K VLAN netdevices) triggered the
> issue when I requested 'group offload subgroup l3_stats'.
>
> I guess I should have enabled some of those L3 counters :)

Probably yes. Because I do not have a lot of interfaces, 119 to be
precise, and first 90 of them do not have l3_stats enabled. And all of
them fit into 2 netlink reads, problem interface is number 109. So I
do not think much of them is required to hit the issue, but some bad
luck so that one of them gets fragmented.

>
> > IFLA_OFFLOAD_XSTATS_HW_S_INFO and IFLA_OFFLOAD_XSTATS_L3_STATS, and
> > rtnl_offload_xstats_fill() emits them one by one, so a dump over a
> > sufficient number of netdevices regularly ends up cut in between the
> > two. Each message is currently formatted on its own, which yields two
> > bogus records instead of one, and, because ipstats_show_hw_stats() bail=
s
> > out when the HW_S_INFO attribute is missing, the counters carried by th=
e
> > second message are dropped:
> >
> >     109: vlan859: group offload subgroup l3_stats on used on
> >
> >     109: vlan859: group offload subgroup l3_stats
> >
> > Postpone formatting until the whole object has been received: keep the
> > message around, merge into it any immediately following message that
> > carries the same ifindex, and format the result once a message for
> > another ifindex arrives or the dump ends. At most one interface worth o=
f
> > statistics is buffered at a time.
> >
> > Merging the two messages means merging the nests that were open when th=
e
> > first one was cut short and that got reopened in the second one. Netlin=
k
> > does not mark nests reliably here -- nla_nest_start_noflag() is used --
> > so they are recognized by the message layout instead: a reopened nest
> > appears exactly once in either message, and at the outer level is known
> > to be a nest by ipstats_stat_ifla_max[]. That knowledge only reaches as
> > deep as ipstats.c parses the message, so merging stops at the group
> > nests and their contents are appended in the order they arrived, which
> > is correct both for a deeper nest reopened between two of its children
> > and for an array of same-type attributes, as bridge per-VLAN xstats are=
.
> >
> > A layout that does not fit the above cannot be told apart from an array
> > of same-type attributes, and reassembling it would corrupt the result.
> > Such a message pair is refused with -EOPNOTSUPP and the two halves are
> > formatted separately, as before this patch. Failures to allocate or to
> > build the merged message are not papered over that way and terminate th=
e
> > dump.
> >
> > Fixes: 54d82b0699a0 ("ip: Add a new family of commands, "stats"")
> > Assisted-by: Claude:claude-opus-5
> > Signed-off-by: Alexander Zubkov <green@qrator.net>
>
> The patch looks broadly OK to me, including the commit message, which I
> see Stephen isn't too fond of. I agree the comments are way too verbose.
> Some more commentary below.
>
> > ---
> >  ip/ipstats.c | 280 ++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 276 insertions(+), 4 deletions(-)
> >
> > diff --git a/ip/ipstats.c b/ip/ipstats.c
> > index 8a2ac85e..c531885f 100644
> > --- a/ip/ipstats.c
> > +++ b/ip/ipstats.c
> > @@ -850,12 +850,225 @@ ipstats_show_one(int ifindex, struct ipstats_sta=
t_enabled *enabled)
> >       return err;
> >  }
> >
> > -static int ipstats_dump_one(struct nlmsghdr *n, void *arg)
>
> So the following comment is super long and nobody will read it. You need
> to look into the code to figure out what's what anyway, and the comment
> does not really help with that. So I'd keep this:
>
> > +/* A netlink dump can split the statistics of one interface across sev=
eral
> > + * messages:
>
> and drop all this:
>
> >               when an attribute does not fit into the current skb, the =
kernel
> > + * ends the message and resumes the dump at the same ifindex, emitting=
 the
> > + * remaining attributes in the next message. See rtnl_fill_statsinfo()=
 and
> > + * rtnl_offload_xstats_fill() in the kernel.
> > + *
> > + * Reassembling the two messages means merging the nests that were ope=
n when
> > + * the first message was cut short and got reopened in the second one.=
 Netlink
> > + * does not mark nests reliably -- nla_nest_start_noflag() is used her=
e -- so
> > + * they are recognized by the message layout instead: a nest that was =
reopened
> > + * appears exactly once in either message, and, at the outer level, is=
 known to
> > + * be a nest by ipstats_stat_ifla_max[].
> > + *
> > + * That knowledge only reaches as deep as ipstats.c parses the message=
, so
> > + * merging stops at the group nests, and their contents are appended i=
n the
> > + * order they arrived. Appending is the right thing to do whether a de=
eper nest
> > + * was reopened between two of its children or the children are just a=
n array
> > + * of same-type attributes, as bridge per-VLAN xstats are. It does the=
 wrong
> > + * thing only if a kernel splits a nest that ipstats.c does not know h=
ow to
> > + * show either, in which case the merge is not the first thing that ne=
eds
> > + * updating.
> > + */
>
> Writing is kinda Claude's thing, so it does it a lot, it comments
> everything like crazy, inlines whole functions instead of reusing, etc.
> I find myself having to moderate its code a lot because of this.
>
> > +
> > +enum {
> > +     /* Merge the outer level and the group nests, append below that. =
*/
> > +     IPSTATS_MERGE_MAX_DEPTH =3D 1,
> > +};
> > +
> > +static struct rtattr *ipstats_rta_find(struct rtattr *rtas, int len,
> > +                                    unsigned short type, unsigned int =
*count)
> > +{
> > +     struct rtattr *found =3D NULL;
> > +     struct rtattr *rta;
> > +
> > +     *count =3D 0;
> > +     for (rta =3D rtas; RTA_OK(rta, len); rta =3D RTA_NEXT(rta, len)) =
{
> > +             if (rta->rta_type !=3D type)
> > +                     continue;
> > +             if (found =3D=3D NULL)
> > +                     found =3D rta;
> > +             (*count)++;
> > +     }
> > +
> > +     return found;
> > +}
> > +
> > +/* Whether the two messages can be reassembled at this attribute, and =
how.
> > + * MERGE means RTA and OTHER are the two halves of one nest that the f=
irst
> > + * message left open. APPEND means the attribute belongs to one messag=
e only
> > + * and is copied over as it is. REFUSE means the type is present in bo=
th
> > + * messages in a layout that cannot be told apart from an array of sam=
e-type
> > + * attributes, so reassembling it would corrupt the result.
> > + */
>
> Drop the comment. It's clear from the code and the names what it does.
>
> > +enum ipstats_merge_action {
> > +     IPSTATS_MERGE_APPEND,
> > +     IPSTATS_MERGE_MERGE,
> > +     IPSTATS_MERGE_REFUSE,
> > +};
> > +
> > +static enum ipstats_merge_action
> > +ipstats_merge_action(const struct rtattr *rta, unsigned int nrta,
> > +                  const struct rtattr *other, unsigned int nother, int=
 depth)
> > +{
> > +     if (rta =3D=3D NULL || other =3D=3D NULL)
> > +             return IPSTATS_MERGE_APPEND;
>
> This is one useful tidbit from the wall of text above, and it should be
> here, not there:
>
>         /* If we have >1 hit for an attribute, it's an array of
>          * same-type attributes. Bail out. */
> > +     if (nrta !=3D 1 || nother !=3D 1)
> > +             return IPSTATS_MERGE_REFUSE;
> > +
> > +     if (depth =3D=3D 0) {
>
> Hmm, I suspect this depth =3D=3D 0 and the above IPSTATS_MERGE_MAX_DEPTH =
=3D=3D 1
> are correlated? We can't validate attribute type in ipstats_merge_action
> at depth > 0, so it's unnecessary to recurse into ipstats_merge_rtas()
> beyond and and we can optimize this case by just copying all the
> attributes right away through ipstats_copy_rtas.
>
> If this just returned an IPSTATS_MERGE_APPEND in an else branch, then we
> wouldn't need ipstats_copy_rtas(), IPSTATS_MERGE_MAX_DEPTH, and the
> related special casing.

I can only tell now, that it first was merging attributes the other
way, than after some of my questions it found out that it would not
work for bridge vlan attributes, because there are some other sort of
merging is needed and produced this construction. But I do not
understood it much. I would need to invest some time to understand
those attributes and things. Probably it would be better anyway, I'll
try to figure it out.

>
> > +             unsigned int type =3D rta->rta_type;
> > +
> > +             if (type >=3D ARRAY_SIZE(ipstats_stat_ifla_max) ||
> > +                 ipstats_stat_ifla_max[type] =3D=3D 0)
> > +                     return IPSTATS_MERGE_REFUSE;
> > +     }
> (         else {
>                 return IPSTATS_MERGE_APPEND;
>         })
>
> Maybe the branch needs to be elsewhere for actual array calls. I took a
> code modified like this for a spin, and got the same output, but I
> wasn't trying to cover all counter types, so I might be missing
> something.
>
> Plus the optimized copy saves the find calls, which is not nothing.
>
> But in any case I don't like how we end up with this
> IPSTATS_MERGE_MAX_DEPTH pretending to be all configurable when in fact
> the only value that makes sense is 1.
>
> > +
> > +     return IPSTATS_MERGE_MERGE;
> > +}
> > +
> > +static int ipstats_copy_rtas(struct nlmsghdr *n, int maxlen,
> > +                          struct rtattr *rtas, int len)
> > +{
> > +     struct rtattr *rta;
> > +
> > +     for (rta =3D rtas; RTA_OK(rta, len); rta =3D RTA_NEXT(rta, len)) =
{
> > +             if (addattr_l(n, maxlen, rta->rta_type,
> > +                           RTA_DATA(rta), RTA_PAYLOAD(rta)))
> > +                     return -EMSGSIZE;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int ipstats_merge_rtas(struct nlmsghdr *n, int maxlen,
> > +                           struct rtattr *a, int alen,
> > +                           struct rtattr *b, int blen, int depth)
> > +{
> > +     struct rtattr *rta;
> > +     int rem;
> > +     int err;
> > +
> > +     for (rta =3D a, rem =3D alen; RTA_OK(rta, rem); rta =3D RTA_NEXT(=
rta, rem)) {
> > +             unsigned int nrta, nother;
> > +             struct rtattr *other;
> > +             struct rtattr *nest;
> > +
> > +             other =3D ipstats_rta_find(b, blen, rta->rta_type, &nothe=
r);
> > +             ipstats_rta_find(a, alen, rta->rta_type, &nrta);
> > +
> > +             switch (ipstats_merge_action(rta, nrta, other, nother, de=
pth)) {
> > +             case IPSTATS_MERGE_REFUSE:
> > +                     return -EOPNOTSUPP;
> > +             case IPSTATS_MERGE_APPEND:
> > +                     if (addattr_l(n, maxlen, rta->rta_type,
> > +                                   RTA_DATA(rta), RTA_PAYLOAD(rta)))
> > +                             return -EMSGSIZE;
> > +                     continue;
> > +             case IPSTATS_MERGE_MERGE:
> > +                     break;
> > +             }
> > +
> > +             nest =3D addattr_nest(n, maxlen, rta->rta_type);
> > +             if (nest =3D=3D NULL)
> > +                     return -EMSGSIZE;
> > +
> > +             if (depth < IPSTATS_MERGE_MAX_DEPTH) {
> > +                     err =3D ipstats_merge_rtas(n, maxlen,
> > +                                              RTA_DATA(rta), RTA_PAYLO=
AD(rta),
> > +                                              RTA_DATA(other),
> > +                                              RTA_PAYLOAD(other), dept=
h + 1);
> > +             } else {
> > +                     err =3D ipstats_copy_rtas(n, maxlen, RTA_DATA(rta=
),
> > +                                             RTA_PAYLOAD(rta));
> > +                     if (!err)
> > +                             err =3D ipstats_copy_rtas(n, maxlen,
> > +                                                     RTA_DATA(other),
> > +                                                     RTA_PAYLOAD(other=
));
> > +             }
> > +             if (err)
> > +                     return err;
> > +
> > +             addattr_nest_end(n, nest);
> > +     }
> > +
> > +     for (rta =3D b, rem =3D blen; RTA_OK(rta, rem); rta =3D RTA_NEXT(=
rta, rem)) {
> > +             unsigned int nrta, nother;
> > +             struct rtattr *other;
> > +
> > +             other =3D ipstats_rta_find(a, alen, rta->rta_type, &nothe=
r);
> > +             ipstats_rta_find(b, blen, rta->rta_type, &nrta);
> > +
> > +             /* Whatever is present in both messages has been dealt wi=
th
> > +              * in the loop above.
> > +              */
> > +             if (ipstats_merge_action(rta, nrta, other, nother,
> > +                                      depth) !=3D IPSTATS_MERGE_APPEND=
)
> > +                     continue;
> > +
> > +             if (addattr_l(n, maxlen, rta->rta_type,
> > +                           RTA_DATA(rta), RTA_PAYLOAD(rta)))
> > +                     return -EMSGSIZE;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int ipstats_ifsm_len(const struct nlmsghdr *n)
> > +{
> > +     return n->nlmsg_len - NLMSG_LENGTH(sizeof(struct if_stats_msg));
> > +}
> > +
> > +static struct nlmsghdr *ipstats_msg_merge(const struct nlmsghdr *a,
> > +                                       const struct nlmsghdr *b, int *=
err)
> > +{
> > +     int hdrlen =3D NLMSG_LENGTH(sizeof(struct if_stats_msg));
> > +     int maxlen =3D a->nlmsg_len + b->nlmsg_len;
> > +     struct nlmsghdr *n;
> > +
> > +     n =3D calloc(1, maxlen);
> > +     if (n =3D=3D NULL) {
> > +             fprintf(stderr, "Error merging netlink answer: %s\n",
> > +                     strerror(errno));
> > +             *err =3D -errno;
> > +             return NULL;
> > +     }
> > +
> > +     memcpy(n, a, hdrlen);
> > +     n->nlmsg_len =3D hdrlen;
> > +
> > +     *err =3D ipstats_merge_rtas(n, maxlen,
> > +                               IFLA_STATS_RTA(NLMSG_DATA(a)),
> > +                               ipstats_ifsm_len(a),
> > +                               IFLA_STATS_RTA(NLMSG_DATA(b)),
> > +                               ipstats_ifsm_len(b), 0);
> > +     if (*err) {
> > +             free(n);
> > +             return NULL;
> > +     }
> > +
> > +     return n;
> > +}
> > +
> > +struct ipstats_dump_ctx {
> > +     struct ipstats_stat_enabled *enabled;
> > +     struct nlmsghdr *pending;
> > +};
> > +
> > +static int ipstats_dump_pending(struct ipstats_dump_ctx *ctx)
> >  {
> > -     struct ipstats_stat_enabled *enabled =3D arg;
> > +     struct nlmsghdr *n =3D ctx->pending;
> >       int rc;
> >
> > -     rc =3D ipstats_process_ifsm(stdout, n, enabled);
> > +     if (n =3D=3D NULL)
> > +             return 0;
> > +
> > +     ctx->pending =3D NULL;
> > +     rc =3D ipstats_process_ifsm(stdout, n, ctx->enabled);
> > +     free(n);
> >       if (rc)
> >               return rc;
> >
> > @@ -863,8 +1076,63 @@ static int ipstats_dump_one(struct nlmsghdr *n, v=
oid *arg)
> >       return 0;
> >  }
> >
> > +static int ipstats_dump_one(struct nlmsghdr *n, void *arg)
> > +{
> > +     struct ipstats_dump_ctx *ctx =3D arg;
> > +     struct nlmsghdr *merged;
> > +     struct nlmsghdr *copy;
> > +     int rc;
> > +
> > +     if (ipstats_ifsm_len(n) < 0) {
> > +             fprintf(stderr, "BUG: wrong nlmsg len %d\n", n->nlmsg_len=
);
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (ctx->pending !=3D NULL) {
> > +             const struct if_stats_msg *pending =3D NLMSG_DATA(ctx->pe=
nding);
> > +             const struct if_stats_msg *ifsm =3D NLMSG_DATA(n);
> > +
> > +             if (pending->ifindex =3D=3D ifsm->ifindex) {
> > +                     merged =3D ipstats_msg_merge(ctx->pending, n, &rc=
);
> > +                     if (merged !=3D NULL) {
> > +                             free(ctx->pending);
> > +                             ctx->pending =3D merged;
> > +                             return 0;
> > +                     }
> > +                     if (rc !=3D -EOPNOTSUPP)
> > +                             return rc;
> > +
> > +                     /* An attribute layout that cannot be reassembled=
:
> > +                      * show the two halves separately, like older
> > +                      * versions did, rather than dropping either.
> > +                      */
> > +                     fprintf(stderr,
> > +                             "Cannot merge statistics of ifindex %d sp=
lit across messages\n",
> > +                             ifsm->ifindex);
> > +             }
> > +
> > +             rc =3D ipstats_dump_pending(ctx);
> > +             if (rc)
> > +                     return rc;
> > +     }
> > +
> > +     copy =3D malloc(n->nlmsg_len);
> > +     if (copy =3D=3D NULL) {
> > +             fprintf(stderr, "Error saving netlink answer: %s\n",
> > +                     strerror(errno));
> > +             return -ENOMEM;
> > +     }
> > +
> > +     memcpy(copy, n, n->nlmsg_len);
> > +     ctx->pending =3D copy;
> > +     return 0;
> > +}
> > +
> >  static int ipstats_dump(struct ipstats_stat_enabled *enabled)
> >  {
> > +     struct ipstats_dump_ctx ctx =3D {
> > +             .enabled =3D enabled,
> > +     };
> >       int rc =3D 0;
> >
> >       if (rtnl_statsdump_req_filter(&rth, PF_UNSPEC, 0,
> > @@ -874,11 +1142,15 @@ static int ipstats_dump(struct ipstats_stat_enab=
led *enabled)
> >               return -2;
> >       }
> >
> > -     if (rtnl_dump_filter(&rth, ipstats_dump_one, enabled) < 0) {
> > +     if (rtnl_dump_filter(&rth, ipstats_dump_one, &ctx) < 0) {
> >               fprintf(stderr, "Dump terminated\n");
> >               rc =3D -2;
> >       }
> >
> > +     if (rc =3D=3D 0)
> > +             rc =3D ipstats_dump_pending(&ctx);
> > +
> > +     free(ctx.pending);
> >       return rc;
> >  }
