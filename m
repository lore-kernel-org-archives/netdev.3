Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A38F19DF6A
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 17:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496048; cv=pass; b=kHqk49getXsZ8FbyOVaQkmSNS5bF8RMP2SvFGRAAGUa7ZsckpNYDrFyDu75QGKb3Iqc8ayNWpgkdoZ5GnwMCBlaoF/sVWnjTFMygaA/31eUl1Qzr580Ule1zYKvlIso/e+uW+LOCBJzYXFtEEsNLdJbDKC6pOSEijG66U86q8C4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496048; c=relaxed/simple;
	bh=PuSJI3OyyRfbgtvsmwL7L4C4IypFpmXaiu8KzwyrNAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qxhiOlZMCVPz1PpIfCvzaCLyhij4dWc7PKY85K29WJFV466ucDd3+fIa4XXiKXX9Hb9XAnGviojFtIONybXHsSKR25+g8pi8qQSXN2U4qKzGC/kVJNPXaADdKV1NQPc7zyvAopTdCqBvyCkcOiSkzJeAARoaVyOm9qpSK/K9/Y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=I0mnwtcc; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="I0mnwtcc"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-845537740ddso758197b3a.0
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 10:47:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782496047; cv=none;
        d=google.com; s=arc-20260327;
        b=XiQESQ+adczpf3vuCJU5FrsYbKKx8J4tLtnz2XXJrW98C0ngbt2ZTRQnSIQpI6qGlq
         JgKLi3QoBb1GZlaa1vd4eTNYV6uwyOhZgg2Ewrbut/r19Ijlu7o3yYduvuqfUw6IllH9
         Pjwro6EUz6xlBFB37o67v5UZYMGa3qjfAAl6Rw93F/oFvTNhnCM5jBLs/813ARUtcSyW
         3JefvTW3fRn6ac32JZzS85j5/HCmKc7QNia2/3oRMWHV19z18Ds+vgkpOhAwOHV+UYMh
         I7Ld+tZLWE677MKcTle1uXjp4te59bItTZ1WpUTNTdlnbjFDS8EduuzNoSyNQ3AS/4pa
         3iiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PuSJI3OyyRfbgtvsmwL7L4C4IypFpmXaiu8KzwyrNAI=;
        fh=KYQsX2wxKO0gG8Dl0hw2iAbRN48Tt768zvIa+ZPGggw=;
        b=VwaclS/9c4Y/Gh+wwL1BTk4JGaAnKMKGvIT7BcMCtKQbGba6gv1MLbk7nk2S3XWaNH
         ZgJGMdKOWv492CKibTqmOddGZ9f9RQRS30Y5ocj7+6dyEfNAYSSE7FZW/KecqECvc6T2
         ayp8b2SdlXLgivETvViTP3CDtbfLOw0fWFsh/3ashx1KxH2YuXOpbvWImHUms9NiSrEh
         EvDmPjz/S7s/r22om2PHXVa6lGYfMSuWx/1KxEcfAFcEViOeg4RyQVO0cita3yJybllo
         CFvbopYT1WFpbDryH+cUayReVGwyuB+3WDilc9n5FADgaOmaGPZxUnuycrR0TOwnqe9n
         75yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782496047; x=1783100847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuSJI3OyyRfbgtvsmwL7L4C4IypFpmXaiu8KzwyrNAI=;
        b=I0mnwtccTf6DVTi8nskfeh0+j/YdDxVlfaj+WH5gJ/7yKze1Tg0W2KPczVmuYqt/jW
         Zx1glQKcnXk0WQDwiLKr8HsI3Ja+JiNtP8Owa/ih7LzCWi7yEf51WhedttZYYw7SCf3L
         AYWxCPTShTwdqCsrJp6rT/CRJwlYMVshlYEps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782496047; x=1783100847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PuSJI3OyyRfbgtvsmwL7L4C4IypFpmXaiu8KzwyrNAI=;
        b=bUS9GvXSvetApx2kGEbrkaXEbd7fowUOnLm9dNOI5XYBZtQ0KNOwh1y9wVKLcC8fU0
         WyhEos6p6MR+fiWkSO903QfTRPW0NN4FmBYhoLNovik/pGEyGOQYON/zO6iKM4jlLk8+
         hu+UBXpZBEyoK7qCx+JVAmXF1tE8fA0GQtg7PV4I2JgN1VKbNMIJ4GhYSw64UkaLQxLB
         xAZmaUSZKX55B1R0RVVzRpTvcOQTfv/svaz+dUKPhGnPTuENg4SKKu7S+xX0smCqcvxj
         YrS71hzv3u9MgaqTOCe8TZK0wJmS54cGLiw92PzrZYHQ8ol2aZviTjY04DwDEzRuXk9F
         Ncsg==
X-Forwarded-Encrypted: i=1; AHgh+Rr02Hj0lHI6xfTcwRtLJHJQoN59U4quUYYpfKEWbjjJ/TEOWmisSmRuOSKgw4OI4LsWDwaXL8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZLuu1fBEA9ufPWBGo9w4ltzNsWoud33A8ngIg1mabIqHYLuPC
	C3AoFS2+I1olLk7esypeyIKk0DnEaPMCuAyNEPcl7fs++jQTche1HLddWKwSz2AxAl7Na0MhBqw
	vDHuHwGaVI9qTKou4ZCkcOFCQu0Wxz20QbeXt/sxw
X-Gm-Gg: AfdE7clqKuuc5R5Y7z2UeLZmNyu9HB9w8Rb2VteLHINGTgYUPLSv/CHULDtE6Zpt7pz
	qK7C7sIs5vBnXvVBWZKNUetHV4gKfI5XaNRmapGb/RmJuQUESIkQ6ledSn/5pDE26pnerJgTzMH
	2dqSqAgdcCZdnD9sBVtYTamNkmXOAW243OL/rsJ11eV6tmxGkKviqHklMEp+5Cunsc85KEz0DME
	dNFzkJSluLZWNf18YmRE81vTlKJnj4XDeyq4lEqeIdwFAhUgXr5H5p6PsBgHaRRC+Bsjw==
X-Received: by 2002:a05:6a00:914b:b0:845:ba6b:78ce with SMTP id
 d2e1a72fcca58-845ba6b7a3emr6025987b3a.19.1782496046830; Fri, 26 Jun 2026
 10:47:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625-b4-disp-31bcb279-v1-0-85c40b83c529@proton.me>
 <20260625-b4-disp-31bcb279-v1-2-85c40b83c529@proton.me> <fc1b9963-2f69-4e47-bf59-6b668faedc0e@mojatatu.com>
In-Reply-To: <fc1b9963-2f69-4e47-bf59-6b668faedc0e@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 26 Jun 2026 13:47:15 -0400
X-Gm-Features: AVVi8CcVMyHMAJ-kaq_UC8PRA0bEi6kprXcXg4qIYYHS-l3dWoBPyXH4CtQX1E4
Message-ID: <CAM0EoM=K5rvf5NHdmR2cXAt9drFkrfOi5TWj7dFqYN5pm82D4g@mail.gmail.com>
Subject: Re: [PATCH 2/2] net/sched: sch_multiq: Replace direct dequeue call
 with peek and qdisc_dequeue_peeked
To: Victor Nogueira <victor@mojatatu.com>
Cc: hexlabsecurity@proton.me, Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Jarek Poplawski <jarkao2@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 1:18=E2=80=AFPM Victor Nogueira <victor@mojatatu.co=
m> wrote:
>
> On 25/06/2026 06:51, Bryam Vargas via B4 Relay wrote:
> > From: Bryam Vargas <hexlabsecurity@proton.me>
> >
> > multiq_dequeue() takes a packet from a band's child with a direct
> > ->dequeue() call after multiq_peek() peeked it. When the child is
> > non-work-conserving the peek stashes the skb in the child's gso_skb, so
> > the direct dequeue returns a different skb and orphans the stash,
> > desyncing the child's qlen/backlog. With a qfq child reached through a
> > peeking parent (e.g. tbf) this re-enters the child on an emptied list a=
nd
> > dereferences NULL, panicking the kernel from softirq on ordinary egress=
.
> >
> > Take the packet through qdisc_dequeue_peeked(), as sch_prio already doe=
s
> > and as sch_red and sch_sfb were just fixed to do. The helper is a no-op
> > when the child has no stash, so a work-conserving child is unaffected.
> >
> > Fixes: 77be155cba4e ("pkt_sched: Add peek emulation for non-work-conser=
ving qdiscs.")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
>
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
