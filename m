Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D7D472774
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 12:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790338941; cv=pass; b=JZaWWCtzrqOYQWyWfO5frYehfaNn2dBfb1fOsVaVBd98c3/D/7o5HsQNArkWchCaHPk165LYOR9umn7NXt4YK5zQeJrdy+3+VP6BHciy6gCgiiJCkuu8JaO1iNOoMqEfVRh3DetdQtr/r8l7wgZSjUWkrPVJCQKMLkolGZzFSoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790338941; c=relaxed/simple;
	bh=TveiWI59qu8W+0sHD/ntdqYsoBGEXuB2CLYzL18jCQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZKNLz7id3kWHLSLGbwis2cshElh+oBbs8yLdEeftg0MeaG1FedfVTBfWcXc0LrbdGZi7Rpi94ji7HFrEmD+i9DLq4wItSclbT9whvesr+CFgi+gtFmoMbNcYrOayzahjMio3jAxsk6fWWWvGxW+OrvGPPbNCecJAv11akzRk8/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=nB7BfTKM; arc=pass smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="nB7BfTKM"
Received: by mail-pz2-f40.google.com with SMTP id d2e1a72fcca58-8804c1728f9so420806b3a.3
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 05:22:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790338938; cv=none;
        d=google.com; s=arc-20260327;
        b=Ke0PLam/z0Y/2tUKbzai5vxfpBbW5oehHM/GT8t0D7pabKaVrCeom8Cv/GvGJzoKtZ
         tMT+JeIeCyEr4JDxF/UJgTxMJsdSidaQ+o5s9oJ8C2PEvydISnJ0ix9OHmWiQpLWirwq
         V7H5X9H40XWvbprAZBLRz1MAwQH3AHCQjKTiwZE9nk5nAAt9DT7TZFgmz8M1+kCRkSuR
         pgafePT2NnA1/XuV/+ldflsVYhYahX7yNXA1NKbL0fEwOHhVAgte/NtJ/kaE3mJ7uVvh
         qup0wH70GVJ024D99oNf8j/b9age62aGrU2F/d/rwkOTb/4Nd7SwT2rZUDXiMZg7Y8Do
         W/Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=av3YcvyNJcPOj3HXoPA437Oi1Cgz5fyF7LSLQvx62Xw=;
        fh=N8FEvgZUXrM4i6N9UahrhVhhFuscG60fHp5lmZoFZRI=;
        b=UqxX79H+SceAoJrNCww0cr9eXe8YB3xSzfmGkvE3MAWXWxzG+15TNUNIWBCpsbc8Dm
         DMafe+yFCV+1QEwAFnzG3LdWPo4wM8rn2iCXBZnsEXPjkm1NE9vw+skDhZqOa4E5v8o8
         sk1AH2JnTW2PZ/M7pK3vEHPegnpASxXAntfv5uZshnZv/DLwzAal8pizelFNmdwwiOd/
         H6jEWQukzBknrJmtZUQNqNAZcr7F8HDSEr3g/HArPhE1KpsLyNzPNs0ulxgj9WDOvI6g
         YoDB3L0cQi1RjY4itqoZH03ffvYeOdd0pGrBotcdnK/e79j8bmpJ8TViRwa+T0+liu8q
         LcJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790338938; x=1790943738; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=av3YcvyNJcPOj3HXoPA437Oi1Cgz5fyF7LSLQvx62Xw=;
        b=nB7BfTKM4IO5Lr5Bpy0gZhS4VVAjwl4Rrtrl1dnNTWLLp8m99vUuwva379geKdDjHR
         y9BajeVXY04oPBgl3NQnFaC7tr8cdbTzCRV6ug6Pcs6o0LUKPcAStjGG5e3RYSr35Dxl
         iQ/KB0QA4RiNDxi6pJF3ajgV1anRPhQ1dnjVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790338938; x=1790943738;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=av3YcvyNJcPOj3HXoPA437Oi1Cgz5fyF7LSLQvx62Xw=;
        b=h5dUh4Uz6hT/PCFjzYJG8+VX7pwufe1AF9CTnWtbkoGaoAR/domCyxEtd1cuUSAz6C
         oo52bUV1coNMSJ++Uo7gy8QyJiEPAZgeWhRwPI32OZqtNn0A76uBNyvW0Jj8J2vZ4SGd
         lKo84tsNEH6ZUoK5qhpUi1tlPmga0haRTQ669UprsU8HM7zPtSUQgmFU3PdplkfqYA/o
         D2YYrmN/PzwZWWqHLGJGKc3XHp3c2XgiNGHUIUJ2MS/YORTO5AEUDEN1yjsk4eTHloG7
         jpmxxh0/vYtAX2OhUbuvJFHCxeBrmQ6jW4cY0n3mcSnYNzgrgPQ3i9CPpnFOO9JZdQOI
         T6kQ==
X-Gm-Message-State: AFuF++mWAyIOgjw5luoKu3wVtFVU8yXXY+lglt1c+4QJERqw1nR9nNZ/
	sLsfek3fGn13wuiOVV+AkTLhuo6OtPebafRgzF9AaWr62pXnuP74caQ3U3ag4c5geH6UajbXNl4
	6KaTvWLt2f+uL4Kh+Q6voTGxS2dNDxLg8j2OYa+8f
X-Gm-Gg: AYBFou3mrZ3Ki5O83bf4lYXpGB1+GwNLcK+vi4/5tDTIFD6an/2c9S4cNt0pZ7pNtI8
	vq2RcDbYvSlLBrtxtrnZp/El+e68hbQUXV5WopuVuyuWEHovTuyeHGZ6iModcdQjr46uupo2hOy
	P4nPNmtgxe7Qu5goEo34MhxZqU5GMYNPBlqjLERiN3cPDBniPZc6OAEY6lwAVFZ1Fr+njbNuHB6
	ycX/VDjHR235X2zQAlvXAS+CVQMgccyR+xcmmiu2AuMx/4B11Pt1lK1jJkAaEE8p3lHAlslGEuO
	o4GU7ZNw0bJxbBseeKpgtV/MFBjILhTgU9buF/re5oX3zP3i4lBjvsEvgg3Ldt4iGzag8C6XaNR
	/lzAuSpAJf8UzvU5VRhBgsm2Bm+d489uhKw==
X-Received: by 2002:a05:6a00:846:b0:876:194e:b8fe with SMTP id
 d2e1a72fcca58-87e99e414abmr4655720b3a.26.1790338933543; Fri, 25 Sep 2026
 05:22:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-BA27.v1.20260922092618@mojatatu.com> <CANn89iLfMJV7ancKH1Gjzzm7ZUG-gKcrczkJjJEWN5sCuWd-ug@mail.gmail.com>
 <CAM0EoMn8_MVUHa2Jym7wKvd6Oo-JvNJ7GPvRJi2DsJCnQFmW+w@mail.gmail.com>
In-Reply-To: <CAM0EoMn8_MVUHa2Jym7wKvd6Oo-JvNJ7GPvRJi2DsJCnQFmW+w@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 25 Sep 2026 08:22:01 -0400
X-Gm-Features: AclHuK-yqNP1EVXBLDZ7JgFMQzMafEP-WU_RswudZME8QasuHgalM9IFLi0jTOc
Message-ID: <CAM0EoMkNG19AZuqQKZLrHMr=yaFc-8sRQaWQxN0EvJTqvHuzNw@mail.gmail.com>
Subject: Re: [PATCH net-next] net/sched: fq_codel, cake: widen backlogs to u64
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	cake@lists.bufferbloat.net, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Victor Nogueira <victor@mojatatu.com>, hybris <hybris@mojatatu.ai>, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: multipart/mixed; boundary="000000000000297fd9065c4dc44c"

--000000000000297fd9065c4dc44c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 7:27=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Fri, Sep 25, 2026 at 5:13=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Fri, Sep 25, 2026 at 10:54=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu=
.com> wrote:
> > >
> > > This is a follow-up to commit 8f735d64382d ("net/sched: bound
> > > qdisc_pkt_len to prevent qdisc soft lockup"), which capped
> > > qdisc_pkt_len() at QDISC_PKT_LEN_MAX (1 MiB). That cap bounds the sta=
b
> > > amplifier but leaves the per-flow backlog counter u32:
> > > fq_codel_enqueue() accumulates qdisc_pkt_len(skb) into q->backlogs[id=
x],
> > > so a flow can still accumulate 4096 packets of 1 MiB each and wrap th=
e
> > > counter mod 2^32. After a wrap, fq_codel_drop() sees a tiny maxbacklo=
g
> > > and drops from an almost-empty flow, and the dequeue-side subtraction=
s
> > > corrupt the counter further.
> > >
> > > Widen the fq_codel backlogs table, the fat-flow scan (maxbacklog/len)=
 and
> > > the drop threshold to u64. fq_codel is not lockless: every writer run=
s
> > > under the root qdisc lock, so plain u64 arithmetic keeps the WRITE_ON=
CE
> > > publish / READ_ONCE-consume pattern. The dump path
> > > (fq_codel_dump_class_stats) stays a lockless stat-only read.
> > >
> > > CAKE accumulates the same generic qdisc_pkt_len(skb) into its per-flo=
w
> > > b->backlogs[] and per-tin b->tin_backlog and consumes the values for
> > > longest-flow pruning (cake_heapify/cake_heapify_up) and for the shape=
r
> > > staleness check, so it shares the bug. Widen those counters and the h=
eap
> > > comparison locals to u64; the class/tin stats keep exporting the low =
32
> > > bits through the unchanged uAPI fields.
> > >
> > > Conditions to recreate the bug: CAP_NET_ADMIN in a user namespace;
> > > CONFIG_NET_SCH_FQ_CODEL=3Dy.
> > >
> > >   ip tuntap add tun0 mode tun
> > >   ip link set tun0 txqueuelen 32 up
> > >   ip addr add 10.99.0.1/24 dev tun0
> > >   tc qdisc add dev tun0 root handle 1: stab overhead 2000000000 \
> > >       fq_codel flows 1 limit 4200 ecn drop_batch 4096
> > >   # hold the tun fd open without reading (IFF_BACKPRESSURE) so the qd=
isc
> > >   # backlog persists, then send at least 4300 packets (the wrap start=
s
> > >   # at 4096 resident; the over-limit drop that reads the wrapped
> > >   # threshold fires past the 4200 limit): backlogs[0] wraps at 4096 x
> > >   # 1 MiB and the fat-flow threshold reads the wrapped value.
> > >
> > > With a 1 MiB qdisc_pkt_len cap the counter wraps at 4096 resident
> > > packets. At limit 4200 the first over-limit enqueue (the 4201st) sees=
 a
> > > wrapped 105 MiB (half-backlog threshold 52 MiB, a ~52 packet drop bur=
st),
> > > where the u64 counter sees 4201 MiB (threshold 2100 MiB, a ~2100 pack=
et
> > > drop burst).
> > >
> > > Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
> > > Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/202608181=
01130.16203-1-jhs@mojatatu.com
> > > Link: https://lore.kernel.org/netdev/20260818101130.16203-1-jhs@mojat=
atu.com/
> > > Tested-by: hybris <hybris@mojatatu.ai>
> > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > ---
> >
> > This makes no sense.
> >
>
> As absurd as it looks that code is reachable ;->
>
> > These qdisc have been developped to address bufferbloat issues.
> >
> > Storing 4GB in a qdisc is absolutely insane.
> >
>
> The counter wrap is not because we stored 4GB, rather it is because
> "tc .. stab overhead ..." inflates qdisc_pkt_len() for a 64B pkt to
> 1MB. So ~4K packets (put in other words a few "real" KB) makes that
> backlog[0] cross 2^32.
> Result is pruning the wrong flow..
>
> > Let's drop at enqueue if the current backlog is approaching 4GB (this
> > can later be a new config/attribute in net-next)
>
> Note, this is net-next already. Enqueue is fast path - are you ok with th=
at?
>

And the least ugly approach (not tested) is attached.

cheers,
jamal

> cheers,
> jamal

--000000000000297fd9065c4dc44c
Content-Type: application/octet-stream; name=patchlet-eric-enq
Content-Disposition: attachment; filename=patchlet-eric-enq
Content-Transfer-Encoding: base64
Content-ID: <f_mugxjz3d0>
X-Attachment-Id: f_mugxjz3d0

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbmV0L3BrdF9zY2hlZC5oIGIvaW5jbHVkZS9uZXQvcGt0X3Nj
aGVkLmgKaW5kZXggOTBkM2U3OTQzYjE5Li45NDlmNDU4YjE3ZDEgMTAwNjQ0Ci0tLSBhL2luY2x1
ZGUvbmV0L3BrdF9zY2hlZC5oCisrKyBiL2luY2x1ZGUvbmV0L3BrdF9zY2hlZC5oCkBAIC0xMyw2
ICsxMyw3IEBACiAjZGVmaW5lIERFRkFVTFRfVFhfUVVFVUVfTEVOCTEwMDAKICNkZWZpbmUgU1RB
Ql9TSVpFX0xPR19NQVgJMzAKICNkZWZpbmUgUURJU0NfUEtUX0xFTl9NQVgJKDEgPDwgMjApCS8q
IDEgTWlCICovCisjZGVmaW5lIFFESVNDX01BWF9CQUNLTE9HCShVMzJfTUFYIC0gUURJU0NfUEtU
X0xFTl9NQVgpCiAKIHN0cnVjdCBxZGlzY193YWxrZXIgewogCWludAlzdG9wOwpkaWZmIC0tZ2l0
IGEvbmV0L3NjaGVkL3NjaF9jYWtlLmMgYi9uZXQvc2NoZWQvc2NoX2Nha2UuYwppbmRleCBkYzkz
MjY3MDI5ZTcuLjhmZDE1MGNiNWI3NCAxMDA2NDQKLS0tIGEvbmV0L3NjaGVkL3NjaF9jYWtlLmMK
KysrIGIvbmV0L3NjaGVkL3NjaF9jYWtlLmMKQEAgLTE3NzYsNiArMTc3NiwxNCBAQCBzdGF0aWMg
czMyIGNha2VfZW5xdWV1ZShzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgUWRpc2MgKnNjaCwK
IAlpZHgtLTsKIAlmbG93ID0gJmItPmZsb3dzW2lkeF07CiAKKwlpZiAodW5saWtlbHkoKHU2NClz
Y2gtPnFzdGF0cy5iYWNrbG9nICsgbGVuID4gUURJU0NfTUFYX0JBQ0tMT0cpKSB7CisJCVdSSVRF
X09OQ0UoZmxvdy0+ZHJvcHBlZCwgZmxvdy0+ZHJvcHBlZCArIDEpOworCQlXUklURV9PTkNFKGIt
PnRpbl9kcm9wcGVkLCBiLT50aW5fZHJvcHBlZCArIDEpOworCQlxZGlzY19xc3RhdHNfb3Zlcmxp
bWl0KHNjaCk7CisJCXJldHVybiBxZGlzY19kcm9wX3JlYXNvbihza2IsIHNjaCwgdG9fZnJlZSwK
KwkJCQkJIFFESVNDX0RST1BfT1ZFUkxJTUlUKTsKKwl9CisKIAkvKiBlbnN1cmUgc2hhcGVyIHN0
YXRlIGlzbid0IHN0YWxlICovCiAJaWYgKCFiLT50aW5fYmFja2xvZykgewogCQlpZiAoa3RpbWVf
YmVmb3JlKGItPnRpbWVfbmV4dF9wYWNrZXQsIG5vdykpCmRpZmYgLS1naXQgYS9uZXQvc2NoZWQv
c2NoX2ZxX2NvZGVsLmMgYi9uZXQvc2NoZWQvc2NoX2ZxX2NvZGVsLmMKaW5kZXggOTY5YjI1MTBi
MGI4Li5lOThiYWZhNDdkYTMgMTAwNjQ0Ci0tLSBhL25ldC9zY2hlZC9zY2hfZnFfY29kZWwuYwor
KysgYi9uZXQvc2NoZWQvc2NoX2ZxX2NvZGVsLmMKQEAgLTIwMSw2ICsyMDEsMTMgQEAgc3RhdGlj
IGludCBmcV9jb2RlbF9lbnF1ZXVlKHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBRZGlzYyAq
c2NoLAogCX0KIAlpZHgtLTsKIAorCWlmICh1bmxpa2VseSgodTY0KXNjaC0+cXN0YXRzLmJhY2ts
b2cgKyBxZGlzY19wa3RfbGVuKHNrYikgPgorCQkgICAgIFFESVNDX01BWF9CQUNLTE9HKSkgewor
CQlxLT5kcm9wX292ZXJsaW1pdCsrOworCQlyZXR1cm4gcWRpc2NfZHJvcF9yZWFzb24oc2tiLCBz
Y2gsIHRvX2ZyZWUsCisJCQkJCSBRRElTQ19EUk9QX09WRVJMSU1JVCk7CisJfQorCiAJY29kZWxf
c2V0X2VucXVldWVfdGltZShza2IpOwogCWZsb3cgPSAmcS0+Zmxvd3NbaWR4XTsKIAlmbG93X3F1
ZXVlX2FkZChmbG93LCBza2IpOwo=
--000000000000297fd9065c4dc44c--
