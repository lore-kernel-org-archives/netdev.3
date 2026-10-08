Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55C63BCD29
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 07:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791445912; cv=pass; b=ZHaAiFtUrZPjtz6mUFcpyW+T7WeS2N+Pt/Bi8CbCsCMKG/HCZfrxK/ju+NyljCdNVpoTKc0EopE4/KDgR44GoJ0fiSUJgH7cVTkdyiKsXp1lBcIYpxiXC6ewbi+5iHiLr+LQaihljm3KTpgwBwmMil4BwShw4ltnzkgPYHLYl9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791445912; c=relaxed/simple;
	bh=b6surxciHE6u0CSaA4hYtIYM/pkQPAm8xLVqO6OO0N4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QOgFL/owIN15rmyysuc7adZx6Pv+cZq6aUpLntQ6WOdmNvblqduw+L7JbIWPTt1FO0vSwPWCzdPcQDCb1M/QLqXLGCjEwqgrFCwt3xG6UCmih1Zti4sClnhO7ArC0qlAmaHD+jLD+dKbRs3LW88XbNfdkMQxzo9+G+ARp+K30kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=q4wp57Op; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="q4wp57Op"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8714288dd3bso1482543b3a.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 00:51:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791445910; cv=none;
        d=google.com; s=arc-20260327;
        b=QWeGC7QRYhrTA8a0WC6IwMUM7ym3I1XtjyfeOycX2q9+veHERC2NZ3WlSHS2OPA8iK
         xd8Tu/FvquZtT4AYXdf6MKYnW7vu3qkPX9hkWDAqOzZRVXasfVrD/tC9o+bv4p9LmG2E
         fPtvmYucEs4wWqmZMoZ61CDbzDXiTq2HGst06V12XE0y1Xd00m3NTiA1tSG92oFAxro5
         9aY15zd4nU6g0hWhTACfA9HouqLnBM7kJL831DWRlkMo5oG5JWjrit/aRDBKjn5hqKoc
         LPlcsWTwLlXYafzadO1K/E5mJ4arkXJbXGekT+iain+23QrMsvv08Mn8mNq+XfFTLz/o
         b9YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OO8fnahalw7T1L0IsFdBpBQ93DJo4pi27zMWxxAysQE=;
        fh=cNq1AnvjebSJS7aK6i3LW9EaWG5BXoQQzOL5yIItEJs=;
        b=DCGabzReDTtZK2ENUFqtLVAwIpfeV77y/iom73KpMPSX5MFkafDgIFr1n/C5FiHS76
         sg3hPTIVoowwtAng66ZL9Qq39jIQ7R/BWm9SfXNnT4dIAkwklvDlq4azAlyWhGBrXw+e
         vn7ycSAsHIX5AD6sQzsqcvnn/s8USerQsCgwBFq5cF4urrWgeVzXzA9Ubv8aljs8gJXQ
         33HwgIFMcecS8MGqmKkBKNxXVbMFmDuKC2SyMFzQgc4KmRwDBmM3Z3WtlZ0K4fr6G96n
         Z1QtZ+/9UVpnIdEnqrhwLH/P0dC+aaZTLxbY+MFdp7Y/nX+fADyWyj1A4C7pF8ZbaBOM
         UxoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791445910; x=1792050710; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OO8fnahalw7T1L0IsFdBpBQ93DJo4pi27zMWxxAysQE=;
        b=q4wp57OpqwscIqAiV6y/HT1EgBoj0ljJn8o6xHBugeDahDDMPxzKq5NEbmavzh6Vkx
         AXaxbNzp+1emO7r5LCbEADM2SGDlH/tQJKD6W/+VLxRvOnJpDpEEfoUpjhBfO2+h7UfI
         MiZt80WU8R6YxguC3CWaiOjqL1I201rD7x6jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791445910; x=1792050710;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OO8fnahalw7T1L0IsFdBpBQ93DJo4pi27zMWxxAysQE=;
        b=p5VxovvwsR0jlHTD5xnLryU5l3UMeJTScgvIWCkPIDA81WM8xYqs8gl54AwyWlMyyF
         /ItnbT5h/JFsJkvaMK7lkHTXlj/SlGb4mnIoGtN1BfNhYF5PbRxmWL492v6aG9N5Js2w
         ryTm++exG8C+FxUXOQthHBmD09RtU5G+iOAmZqhU7jZMEBy6YT2SMN+wWCLrrHJ/jdO6
         0+Ciy/E1dWD08qe7HhvNA6tGPGEyhfWEM1ZNg6Ozzx+3Hoe13Rd+Trf5SOfDnQ1skkLx
         BSafhUBWsVXRR+JPyqefXMB1ZeTMgGVdaKYmMIPctg8EoS63NUr6jopiE3zPIK6GYA3G
         lylg==
X-Gm-Message-State: AFuF++l1Xnv1IvMwY1ht4okNnzQEQjV3wj0lWS1mfbTf3TXYr+qzm3Cx
	sgGGesISNtmIRJR0Ybe79SEWymtsjPiz2IoB7ytxXH6KQ6K//xduiFFv90XzJkzEeq2HHzACVO/
	xoMAwCLCDSR+DS3lflHnctWm7Equ0ItNKDHhOq2eZ
X-Gm-Gg: AYBFou08r1V87XnvyIBcwr1VtBxt+MR0Rgho7447wCX79nR2kmgnI0XCLCklcTK0nmD
	Ta81dQUM+m6FciFazceOdzps1VhPvrreUmDrrnwB1deO2hlBt0uqz2rgszJ/qjnYJl3G/H/T15+
	uwqSErrYmQDmrgGLE1gMM13qhq27b+Cm1pl0AzdHDkqPnBgDuAAOeGoH7k0zAF2fiGI2vzeJBBp
	y2K+nvJXLAiHkkmcWF029MozBpUiM1baEZnfvODYgxYuEa1Vc/XrLomkHNAo2lMmDUhkmJZa8J+
	6o/pR9UcJEDHwo3Kb+5YBLICxfqEFzJKGmNoheasbqqrpqeDcOojT+jtWf85H+kfMPt3sf+Pl6D
	VhkMQ1uy1gmQ9ZMUiQ/3Dx0M4qRnl01R6G1gTvn4=
X-Received: by 2002:a05:6a00:22d2:b0:878:3538:8f7f with SMTP id
 d2e1a72fcca58-891b2166342mr4064444b3a.45.1791445909807; Thu, 08 Oct 2026
 00:51:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-H19Z.v2.20261007062551@mojatatu.com> <QDISC-H19Z.v2.20261007062551-3@mojatatu.com>
 <zR5nw2jDMQyPpLOwFEjqH163vEcob8SUKgVslSD8tVjZRwXoPHJlj-dC55-C5KVsAvHn5wh8GnilJVH1C7KedPw0dsy4oZlbOTew01T7qbo=@1g4.org>
In-Reply-To: <zR5nw2jDMQyPpLOwFEjqH163vEcob8SUKgVslSD8tVjZRwXoPHJlj-dC55-C5KVsAvHn5wh8GnilJVH1C7KedPw0dsy4oZlbOTew01T7qbo=@1g4.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 8 Oct 2026 03:51:37 -0400
X-Gm-Features: AclHuK9mxNYfX9YgA86HvXwDkNZzPrnF3afNDn08BmUaC3XwN-04cd078BXfBxM
Message-ID: <CAM0EoMmMhMJhzMb-VHon51tbLQ8qeJgU6KBMBVJ_K8oWHeOGkQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net/sched: act_gate: cap the number of
 scheduling entries
To: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Vladimir Oltean <olteanv@gmail.com>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, Edward Adam Davis <eadavis@qq.com>, 
	Davide Caratti <dcaratti@redhat.com>, dsahern@kernel.org, stephen@networkplumber.org, 
	sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 10:23=E2=80=AFAM Paul Moses <p@1g4.org> wrote:
>
> On Wednesday, October 7th, 2026 at 5:29 AM, Jamal Hadi Salim <jhs@mojatat=
u.com> wrote:
>
> > parse_gate_list() accepts _any number_ of TCA_GATE_ONE_ENTRY elements.
> > The only bound/cap is the enclosing nlattr u16 nla_len (~5460
> > minimal 12-byte entries). Each entry is a separate GFP_ATOMIC
> > allocation, and the dump of a large list grows one action's reply well
> > past NLMSG_GOODSIZE.
> >
> > The bugs:
> > 1. A single gate can make tcf_dump_walker() silently truncate
> > "tc actions ls"
> > 2. Lack of capping has been demonstrated to be exploitable to
> > create an OOM through amplification of RTM_GETACTION replies.
> >
> > So we need to provide an upper bound cap of TCA_GATE_ONE_ENTRY elements=
.
> >
> > Some context:
> > The gate action offloads through FLOW_ACTION_GATE. The offload
> > interface passes the priority, base time, cycle time, cycle-time
> > extension, the complete entry count and an array holding each entry's
> > gate state, interval, IPV and maximum-octet value. The in-tree SJA1105
> > DSA driver forwards that complete list to sja1105_vl_gate() without any
> > entry cap check, and composes every supplied entry into the hardware
> > schedule table.
> >
> > Act gate challenges:
> > SJA1105 and SJA1110 are two device families in the one sja1105 driver.
> > They expose different schedule-table capacities: SJA1105 provides up to
> > 1024 schedule entries and SJA1110 up to 4096. These are total table
> > capacities shared with other schedules, so they are upper bounds, not a
> > guaranteed per-action budget. Software gate actions with _a lot more_
> > entries install and serialize today, so a low cap would reject working
> > configurations and would look like a UAPI breakage; but an infinite siz=
e
> > of entries is a bogus choice; 65 entries is the boundary configuration
> > verified during this work.
> >
> > Netlink Challenges:
> > Netlink attributes record their total size, including the four-byte
> > header, in a 16-bit nla_len, so a nested attribute can describe at most
> > 65532 bytes. A minimal accepted input entry is 12 bytes, which puts the
> > max we can fit at roughly 5460 entries; a dumped entry occupies 36 byte=
s,
> > or 40 bytes when it carries the gate-open flag.
> > 1024 entries therefore serialize to 36868-40964 bytes, which fits
> > inside one nested attribute, while a 4096-entry schedule would need
> > roughly 144-160 KiB which _cannot fit_ at the moment due to the 16bit
> > length.
> >
> > Note, Note: This represents challenges primarily with netlink.
> >
> > The Cap:
> > Cap the list at 1024 entries. This value is based on the existing
> > SJA1105 schedule-table capacity and preserves the verified 65-entry
> > configuration while providing a substantial headroom, and keeps the
> > complete gate list inside the current 16-bit TLV format. It
> > deliberately declines to expose SJA1110's 1025-4096 range through
> > an interface that cannot serialize it, and deliberately rejects
> > software-only schedules above 1024.
> >
> > This is an operational cap on a configuration the uAPI accepted before,
> > so it is net-next hardening; if we made this a stable backport then
> > it would start rejecting gate configurations that install today (even
> > though those settings would be totally bogus).
> >
> > Caveat Emptor:
> > While this patch fixes the binding of per-action storage and the dump
> > amplification; it does not by itself fix tcf_dump_walker() truncation
> > whose skb is smaller than the reply for such an action (for example the
> > kernel clamps a dump skb via netlink_recvmsg()/netlink_dump() to
> > SKB_WITH_OVERHEAD(32768), so "tc actions ls" is already truncated below
> > the 1024 this cap admits, and you cannot dump the top of the range
> > without changing iproute2 code)
> > It also does not remove generic netlink receive-queue amplification.
> > A companion iproute2 change can enumerate actions with a terse dump and
> > then fetch each one with an indexed RTM_GETACTION.
> >
> > Conditions to recreate the bug:
> > Cap net admin with CONFIG_NET_ACT_GATE=3Dy. Install a gate
> > action with 1025 or more minimal TCA_GATE_ONE_ENTRY elements over a raw
> > netlink RTM_NEWACTION request. The cap rejects the list with -E2BIG and
> > an extack naming the limit; 1024 entries install and an indexed
> > RTM_GETACTION returns a well-formed reply.
> >
> > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > ---
> >  net/sched/act_gate.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
> > index 14801c604bd9..d8e8c2356bd5 100644
> > --- a/net/sched/act_gate.c
> > +++ b/net/sched/act_gate.c
> > @@ -18,6 +18,17 @@
> >
> >  static struct tc_action_ops act_gate_ops;
> >
> > +/* A netlink attribute records its total length, including the 4-byte
> > + * header, in a u16 nla_len, so one nested attribute can describe at m=
ost
> > + * 65532 bytes. tcf_gate_dump() emits each schedule entry as 36 bytes,=
 or
> > + * 40 with the gate-open flag, so 1024 entries serialize to 36868-4096=
4
> > + * bytes and still fit a single TCA_GATE_ENTRY_LIST nest, while 4096 w=
ould
> > + * need ~144-160 KiB and cannot be represented. 1024 is also the sched=
ule
> > + * table capacity of SJA1105 (SJA1110 provides 4096). Cap the entry li=
st
> > + * at 1024.
> > + */
> > +#define GATE_ENTRIES_MAX     1024
> > +
> >  static ktime_t gate_get_time(struct tcf_gate *gact)
> >  {
> >       ktime_t mono =3D ktime_get();
> > @@ -277,6 +288,14 @@ static int parse_gate_list(struct nlattr *list_att=
r,
> >                       continue;
> >               }
> >
> > +             if (i >=3D GATE_ENTRIES_MAX) {
> > +                     NL_SET_ERR_MSG_FMT(extack,
> > +                                        "Too many schedule entries, at=
 most %u are supported",
> > +                                        GATE_ENTRIES_MAX);
> > +                     err =3D -E2BIG;
> > +                     goto release_list;
> > +             }
> > +
> >               entry =3D kzalloc_obj(*entry, GFP_ATOMIC);
> >               if (!entry) {
> >                       NL_SET_ERR_MSG(extack, "Not enough memory for ent=
ry");
> > --
> > 2.43.0
> >
> >
>
> If I remember correctly, act_gate was/is not fully taking into account ho=
w much size it actually
> needs for dumps. Has this been fixed or worked around already? Sorry, I'd=
 been meaning to swing
> back to this. I'll try to get caught up today.
>
> https://lore.kernel.org/stable/20260130134220.305757-1-p@1g4.org/

Probably most of that is already in - re-run your tests on the current
kernel tree and if it still fails apply this patch on top and see if
it happens. We have quiet a few gate issues being reported and we are
systematically attacking them;  this and the ones Victor had already
sent are the highest prio. Others will follow later.

cheers,
jamal
>
> Thanks,
> Paul
