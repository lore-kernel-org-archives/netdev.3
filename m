Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9486936CE06
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 09:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778749259; cv=pass; b=ElmXxVCmtfwb/P4TZamzw+X/P0w0iLssSU3JYRWOMOZBNr/RM1PHvaqwV9nPyD5EkYDFdj0p2PSRMAWpY+7uceGUP0y03iZaINEJwLDcNOIWT9dtowA/M1jblnc4q3PFmuNxekgZ2myJfGKw5UrlY7VZv/YKIoNFINKum9kWcvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778749259; c=relaxed/simple;
	bh=m7RtcNCvqTTTVbq1olYq5UQ2jWQ8DqMTKo7FEqsvrFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PW+uXF/fB8Y6XYqJ/qSNn5ayLsS4SyXceY43Y8eYm4T+f4YgfQhY0a1E8uL71lUMgHs7NcrxZ5nj2a2UtG8MX3NHqgO+CGoxficjZc6NsdhrvOvFNYa8ktQ1p5bwInbjUslfQ5coYHgOQXmTzcMTDChIFbHrd7r6YdDCexBbU8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rd5YIxja; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rd5YIxja"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8b4000e51fdso78462236d6.1
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 02:00:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778749256; cv=none;
        d=google.com; s=arc-20240605;
        b=k0NSBbf17g2tHHGcqqpWExUtRjippSh0XfANoP7sryqTemNnlP4HKbCeZJ2RdntxDc
         lIkpCg0bBtG+1WjF86RIpJGTSVXRFGyovKtXjnd6xvy76R+WD/BYDs4lbpSS8KQw3hcY
         JWi0psPNj3bzJx/hSFTpF83rk92myDZgAAptxedjPErX0O2n3weS7szGhXpYiXBBVe7T
         PCg5mOPa7cNVo8wKJ8DQeFUxz+yIhYOfgU3BfV6Azv7c9LjBZEVCS7MaKYi81Rucn4xj
         LsLPCL48KBDQ/cG3DMkymVsG5pP3w3VAb3KwazU2wZT8UYVeJPfUvivzk23nw33Hqer6
         wHwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G6SfA0ZbRxSpsTevybP6k7CoIEEjF5qSuiSOwzPk5nQ=;
        fh=wXZ97+qOKETjQJe3NqCD3XdSQiNtGXi8dIciDAgwCXE=;
        b=TfcKMYfoa9qZfkxulDlagfInVuX9WQive49N394VkDPQVYS+Evk+Rr6KFV8DY5Bldh
         uFlqrMI0dozUogQtUT6G157QkyM2B4IhzzMT0ySzCkQj1Yr+n5p87qP4YClovYDgSzrB
         PnhVY5gFPEV5lWUzOizJ0OrwILkp6KOijzecVPW6FPNCfwzKfT4hCtoKitx9roza/4UN
         GDpsHarJ64CGecAe5AXEvD1H9ukgAh8u6z4ajcgVi82P7ZEjK5jxbAiOuCHAwHXqHile
         0Py3OnYIJe2Um7Ru25rUlUjsYkb7PqtSlSH+jvKlobJWBs9DStZG262FVUaWfCBPGqCb
         ICOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778749256; x=1779354056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6SfA0ZbRxSpsTevybP6k7CoIEEjF5qSuiSOwzPk5nQ=;
        b=Rd5YIxjatRbbXMp1G4JCAxBq0zLibSL3h8faDt2MHhSjBf2P0iBhVhMbMIT8hkJUhp
         Ky9LVQiLW1p7zt9TQZTZDc0a2TEhAWLrPzdQmh1sCO4hBc38KYoel7mEsZmbGMmJx3w4
         /Wf/aS5JmpX2CU9zpd9wkMA6JK5McSeCyRLQenLPzxe7uzOHbtkpIzi4eGneaFGFQAr+
         KsXktLOBXEQ+h88E5vvOOgEE809Db/Fj/6qLe/hN1Wg6U2vvZtZVs2zW3h/kVjMSrHgV
         /aBvbzRmyvbeeBAaBQhIQvVmhrlN8GFTJB/urXyUK9K3bi0+ACsjtjlI1QyR59VBQ97P
         WksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778749256; x=1779354056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G6SfA0ZbRxSpsTevybP6k7CoIEEjF5qSuiSOwzPk5nQ=;
        b=nTLM4GIFOzcMUHBXNZJPiN6lqpEuu5aldg4NwsLjj99RjZ0HdKzXcmug3EJ5oDv6+H
         LsFCyk6QeJESEgF7w2h4Odh0dZKVvJdbcPsMm0GiwOCDry/jw0CFdRPkjfjbv2Me+Q8T
         S4rtryKIWmdAjIs2acmCT/XW+U482qdPItIfqoxNNTwQn2Dh01QgNYmsh8RqhbY7+lNb
         0DoolqB/IMRCUCyKZ5jWyTEjJMrwk/LxDLENvSN2B7RyAjYw7It/gS2YT+SWCbaotA38
         qFcZxKn7fXLgkN7h4xHaUZacrfX05XMDl6uItbxXjGaH8LBKaBdv/2WMedPnnBZfCXYb
         hMEg==
X-Forwarded-Encrypted: i=1; AFNElJ994nQp6xnDZOAbUdBuJH6uHlMDVs4QWU4vtXFeow4j3dH1bEBPQNxO8VezRbG+asgcM8nKFF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhL+haAjoOu2yX6KzNTDBNlzUDlvlix0CVQIqap/K9mk6lMQ+W
	V8A2MHA4jAFgN2G+gxhQ/yvsIf3kZnvmCKMBV0FaZ/KyWh6lFbBRRt7D2XELbMlqDjaJriWgDxh
	htBS0jUGtMU8co8UDmWM8ev+bqxnPTQJ8VTdLAM9etseA4A1QMQISHiD/8cg=
X-Gm-Gg: Acq92OHqJESt9iVyWod+0ew3KEu5089BrxVvN9XOz8WdUADaRUtNaidtlm5yXkGtvLO
	heNyspPRqP6jUWekn6oTmiDeyKVp/aNsSX+I9h+RhDi9XRmiQ8iZH/O1lLh/KQxsNeHmOewBoO/
	6g6OcOsneprjsty0MjQ8FNlR9VwTvvbxSvjRMNESIjBqpi5a8X/fMfWZ8u7LFZU2x9QLjkqMXhD
	nQdoxCg6p3GD9I8/170zk7eoh83HIF3ESj9kjZ2ElemUwaSoLDwlQchwAkZaoLDljeBztZm7ajJ
	Rd8/WiDTaF0zalM7t+CXCD4wZspbKmdcBBr15XK9aE/1WMvkd1LIclYJwuaAiIpeHs310PHBg+4
	/8l0To2IcZqCOuHjpoB3uMhXToVol
X-Received: by 2002:a05:6214:1d23:b0:8a6:d318:4909 with SMTP id
 6a1803df08f44-8c7b8cf5437mr99519516d6.2.1778749254087; Thu, 14 May 2026
 02:00:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512094859.3673997-1-edumazet@google.com> <20260512094859.3673997-3-edumazet@google.com>
 <ff0a041e-16c9-4e9c-b717-ff8a2bb85d84@redhat.com> <CANn89iJ=t=DPd5cw0YTdcj9dNv9BthW+=3jcHDXgtQYmp1nX1w@mail.gmail.com>
In-Reply-To: <CANn89iJ=t=DPd5cw0YTdcj9dNv9BthW+=3jcHDXgtQYmp1nX1w@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 14 May 2026 02:00:42 -0700
X-Gm-Features: AVHnY4JX08Z4zWalV2fPBft9iY8GzDHkDgfPHXEvk5l5GtYVr3XweV5JanSuIlc
Message-ID: <CANn89iKNrjWqQ+8XPQOTyTAciKk+rXS+=S45xoJ+3pSTOfiwBQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net/sched: fq_codel: local packets no longer
 count against memory limit
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Simon Horman <horms@kernel.org>, 
	Jiri Pirko <jiri@resnulli.us>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	"David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 1:49=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, May 14, 2026 at 1:24=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > On 5/12/26 11:48 AM, Eric Dumazet wrote:
> > > Commit 95b58430abe7 ("fq_codel: add memory limitation per queue")
> > > claimed that the 32Mb default was "reasonable even for heavy duty usa=
ges."
> > >
> > > In practice, this is not the case.
> > >
> > > Packets that are associated with local sockets sk_wmem_alloc
> > > do not really need additional memory control.
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > ---
> > >  net/sched/sch_fq_codel.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
> > > index 1b1de693d4c64a1f5f4e9e788371829dea91740e..71107dc52be799a14f370=
f2ad74d2eadd93992c1 100644
> > > --- a/net/sched/sch_fq_codel.c
> > > +++ b/net/sched/sch_fq_codel.c
> > > @@ -212,7 +212,7 @@ static int fq_codel_enqueue(struct sk_buff *skb, =
struct Qdisc *sch,
> > >               q->new_flow_count++;
> > >               WRITE_ONCE(flow->deficit, q->quantum);
> > >       }
> > > -     get_codel_cb(skb)->mem_usage =3D skb->truesize;
> > > +     get_codel_cb(skb)->mem_usage =3D is_skb_wmem(skb) ? 0 : skb->tr=
uesize;
> > >       q->memory_usage +=3D get_codel_cb(skb)->mem_usage;
> > >       memory_limited =3D q->memory_usage > q->memory_limit;
> > >       qdisc_qlen_inc(sch);
> >
> > I *think* this patch is causing TDC self-tests failures:
> >
> > # not ok 704 a4bb - Test FQ_CODEL with HTB parent - force packet drop w=
ith empty queue
> > # Could not match regex pattern. Verify command output:
> > # qdisc fq_codel 10: parent 1:10 limit 10240p flows 1 quantum 1514 targ=
et 99us interval 999us memory_limit 1b ecn drop_batch 64
> > #  Sent 490 bytes 5 pkt (dropped 0, overlimits 0 requeues 0)
> > #  backlog 0b 0p requeues 0
> > #   maxpacket 98 drop_overlimit 0 new_flow_count 1 ecn_mark 0
> > #   new_flows_len 1 old_flows_len 0
> >
> > whole log at:
> >
> > https://github.com/p4tc-dev/tc-executor/tree/storage/artifacts/645644/1=
-tdc-sh
> >
> > Looking at the test code, I think the patch broke it, but the failures
> > started a little afterward the patch merge, so I'm possibly
> > misunderstanding something here.
> >
> > Thanks,
> >
> > Paolo
> >
>
> It seems this test uses a memory limit of 1 byte.
>
> $TC qdisc add dev $DUMMY parent 1:10 handle 10: fq_codel memory_limit
> 1 flows 1 target 0.1ms interval 1ms
>
> This might be a typo, I think they expected a limit of 0 packet.
>
> commit cbe9588b12d058cbb16735fd468c82ec4b3d1256
> Author: Cong Wang <xiyou.wangcong@gmail.com>
> Date:   Thu Apr 3 14:16:32 2025 -0700
>
>     selftests/tc-testing: Add a test case for FQ_CODEL with HTB parent
>
>     Add a test case for FQ_CODEL with HTB parent to verify packet drop
>     behavior when the queue becomes empty. This helps ensure proper
>     notification mechanisms between qdiscs.
>
>     Note this is best-effort, it is hard to play with those parameters
>     perfectly to always trigger ->qlen_notify().
>
>     Cc: Pedro Tammela <pctammela@mojatatu.com>
>     Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
>     Reviewed-by: Victor Nogueira <victor@mojatatu.com>
>     Link: https://patch.msgid.link/20250403211636.166257-2-xiyou.wangcong=
@gmail.com
>     Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
>     Signed-off-by: Paolo Abeni <pabeni@redhat.com>

I do not think we care much about the precise
get_codel_cb(skb)->mem_usage value.

A value of 2 bytes would let the test pass.

diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 71107dc52be799a14f370f2ad74d2eadd93992c1..916f4d7756e0cb9ec6e81ba69cc=
e59910ee2545a
100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -212,7 +212,7 @@ static int fq_codel_enqueue(struct sk_buff *skb,
struct Qdisc *sch,
                q->new_flow_count++;
                WRITE_ONCE(flow->deficit, q->quantum);
        }
-       get_codel_cb(skb)->mem_usage =3D is_skb_wmem(skb) ? 0 : skb->truesi=
ze;
+       get_codel_cb(skb)->mem_usage =3D is_skb_wmem(skb) ? 2 : skb->truesi=
ze;
        q->memory_usage +=3D get_codel_cb(skb)->mem_usage;
        memory_limited =3D q->memory_usage > q->memory_limit;
        qdisc_qlen_inc(sch);
