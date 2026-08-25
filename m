Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90403F99E3
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787668067; cv=pass; b=UtfJSmKBU3hUoseHNQU0VCDlSV8Tm3oZdC9/NxYbkWNWlbzrHAM+ef1oSmj57/9XtUmY9262FErX9klMdJfNZckFFAbBN0wj0xi9ibfifHvmki3ClAXKp6eC/wd4K2U2Rh8CbygdnK4LHfOgg68ixt5juvDGSmzZ2HP+LqV1+zA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787668067; c=relaxed/simple;
	bh=pfGQonA8Xlu2hWaYqxwp5iCqdLgZ0GEbeZxNf02v6xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KkgHBscIeP/uzI4T1VDRKuP5stt3bYurk99W3+g5jWpzCHS43Q2aWAaUaaK4S1obZHYK40KXAokumg3iu/qPFzNAMt98Hugh/VBLVUMLobmXgueAoSUjRnM5NvEM+RupbpwiNw4DggcawNbOOeHyx8wE8KYU2qN9gaSe9HROsWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OlnGESer; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OlnGESer"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51bfa429aa6so5076811cf.0
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 07:27:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787668064; cv=none;
        d=google.com; s=arc-20260327;
        b=ic5touv79Y/0IRKdU4B1kbgcIBk/P1VamTuhMFU5g7OSTlM8QNl6FoU69qMXjRI6Xf
         8iwogUY7idlMpSlr72Nq8ZFLrE70qk1pQQDgJmBOjJtQq5tMD9qLDqG53Tf9XoaqiBb9
         GmHIgy/pIkJqk93GuXHImoq1zKyhV3gq/sTW6jIImhH/Q04kThCls712v3Dd0H+mVvji
         jkTYX/XGPaursFjsV3c4FQsbi8qUb/+jCd3RvRIsuzUVi50q0wNZHZjaErxtF1CujmXZ
         uYRjgDrLlfazq5Wi4Z88H9p3IUGkwNZrIS8SBD/UPxSenCOc/yJB2p8lcRuVni7msiOo
         8ikA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gR37KRf8VTKVtQ7Bz1R7hESTu1QlQxaVUX0WFTUDFLo=;
        fh=lN2UqSYl+D4NtqNpooOUqmaL1ku2qBQbfdAdVFB+Bys=;
        b=nKbrPeaFMpnu0fguYEtiVdq6Ty1rR36oWCoes9v9IxIF3ZuR+U5Sn/qwDk8T4iiZWV
         fh0fmiqFtfVsN5HPIh8CXqxS4lv3u4UovxFcfalwjyYQW4lVc7KZQL0yiArMAPJ2Q+1k
         p+LopSzJR+N6Pel3m9FXugr5qDB6Eq0ZdDl0buMLrUKW9XY/TtpitSVHhspkDTKSyV0S
         aoxi60D60Zq1zH2owoTrXdUmdX6kQ8SOICo3VUiunL6WEjrG3trbPJi39vkeWelz5cHq
         he5Y7a/RqSuhwF5/ucOfiGeMEQktlgFCMbx4867FHOdCx651hZAiIrO8ah+VCc+Uyl/0
         RYnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787668064; x=1788272864; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gR37KRf8VTKVtQ7Bz1R7hESTu1QlQxaVUX0WFTUDFLo=;
        b=OlnGESerguM5y2cguqUfvuqvngtoEOWzCOeUToIq500C36gezdKC1SMkJwH6LEEXMA
         Ww28NmzWcCc480X6GdsUgOkozaY/wEqhdnhsDcEMSq96ChirOawCuuwFnWwPzSzKZOhv
         45KrwBLbDCpFMwSnFABHiS2FNtbB35Ni2YhSWcQiOAjEgTw2dCTpQd+TIXc3WOIx2S+A
         9z31MeL9WxwpSLh1Re9NxXpya6QbJLKxV326wka6iXtFhW99pkMxshIwSKWJbpB9B8xA
         zCLTrz6J1Wqfr+IWR0T1ee/pV41gV6J7V96hlDi72zIW0T+zzmtEOLNcdweAQN++5GoI
         0L+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787668064; x=1788272864;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gR37KRf8VTKVtQ7Bz1R7hESTu1QlQxaVUX0WFTUDFLo=;
        b=XQ/uuP2uLlN2tGA2bYIS1AUaAJ5Ok50i6TAhgGNVgg2hXoiEGTrbFe5oZjkQxYDCtz
         3VdYMoHZ8qVgGCNsjsvN6bcaNo0Sk5DmfPegGKfILYPwcWy2n4Ad53x2O41aI6ru925e
         1U/0W6sgtzYBcKYDr6fszfqTPZauT9g4Uk9TiF41Vwp7CrF7aEK+amArYbkW/8s8zBa6
         Z9kt2fEv9bk0ubfHWiBirE72Ie3elM87HiHfCAQ3dOFD44XUZwm3bPsM4avO7lED7UfZ
         QkQo6pi8DDlZx52plXe1dEoQ2r7pPFTabHNLyqhyFH8xVR8YJcasNcGMkVTL08hFqhrp
         eeOg==
X-Forwarded-Encrypted: i=1; AHgh+Rp/qvicXENoHTNKyUfRbd+kaalFYHAs+vxHgdcdOpTFq5ZNt1JOoWcOi+TXJkomMoUFxy4QS24=@vger.kernel.org
X-Gm-Message-State: AFuF++lBKCCPmXd1Q1uzoHPiEGaAr0ZhF2VXoDbo355YW4X5qHN0IbE9
	TvIE/tZTXeJoJM5RLz8Zo9Njs81Zb7Hm5uawdbjGafM0tr7IpER83jfDU/enGtYkV2LCZdiGk71
	Dhi1GM3aKybuK4W5qL/AcVu0fQZ7iQ5HK4UNFKdJi
X-Gm-Gg: AR+sD10g9rwhTHIkoSVEawKPdJoM1VwEGJQNwg6o+viC6CQRsqqjwxS2KS8/JjuJf0r
	LThxpeOr5E+RBW6P8seVYCBuhPQXkFYF1oRY06QBMIsat+jnUP3grNjbElU5OA45EX7w6LaEYTz
	P/np9WnThXusdQ1qLb1n6NOUsWS8NitNapTPYJDUrVkkamyRLgzy+od+PouJVqswfjYW9wk4EBI
	nOaNT6qBe2Uh1HV5J5Npnu3haXMdFzrPlCqRGkrV7jNNMPplttlsQ84GG2LHeFKQUnWX38vfRjl
	axzv0QUlWCqtGTCAhcoyCYdB8y9sk9v82RQ38GWzy8uP+9iFVcAt0oH8bENUwfdslTwhW1pbL/D
	i9j3xKeY1cXFh3enfajjWpeZ8EuZd7XkLgZ4Gn/GkANOM95e49Y/0t1DE
X-Received: by 2002:ac8:59d1:0:b0:52e:125b:9444 with SMTP id
 d75a77b69052e-52e2ed0710dmr74880631cf.17.1787668063777; Tue, 25 Aug 2026
 07:27:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ao0mwtt8ePAINFni@shinhome> <20260825064507.1499-1-hdanton@sina.com>
 <ao2WptQpM2zSQHDt@shinhome> <CANn89i+-PHiqn+yKUi=PbwN+qCd6Lr8KY1T6tL7pKPRPmi_67g@mail.gmail.com>
In-Reply-To: <CANn89i+-PHiqn+yKUi=PbwN+qCd6Lr8KY1T6tL7pKPRPmi_67g@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Aug 2026 16:27:31 +0200
X-Gm-Features: AcwNN1XnyRDUUwWIUareJDImatiBxmlP9PBTZdCydv624zsReUmmo-Ty4jclMT4
Message-ID: <CANn89iKWpw1=z-pxfF89tN_AAMqG4+tu--zwy++W=bnHCKcLnQ@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING: locking bug in tcp_tsq_handler
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: Hillf Danton <hdanton@sina.com>, 
	syzbot <syzbot+2d770620059281e225a4@syzkaller.appspotmail.com>, 
	Nilay Shroff <nilay@linux.ibm.com>, Keith Busch <kbusch@kernel.org>, boqun@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 3:53=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Aug 25, 2026 at 3:26=E2=80=AFPM Shin'ichiro Kawasaki
> <shinichiro.kawasaki@wdc.com> wrote:
> >
> > On Aug 25, 2026 / 14:45, Hillf Danton wrote:
> > > On Tue, 25 Aug 2026 14:44:35 +0900 Shin'ichiro Kawasaki wrote:
> > > > On Aug 25, 2026 / 03:50, Eric Dumazet wrote:
> > > > >
> > > > > I think 19bdb70c77d3 should be reverted.
> > > >
> > > > Just reverting the commit will reintroduce the other lockdep WARN t=
hat the
> > > > commit addressed. I hope to have another fix to avoid the WARN.
> > > >
> > > I do not think you know the root cause of that lockdep warn, so rever=
ting
> > > 19bdb70c77d3 is the right thing to do because of [11, 12].
> > >
> > > [11] ffa1e7ada456 ("block: Make request_queue lockdep splats show up =
earlier")
> > > [12] Subject: Re: [PATCH] nbd: don't warn when reclassifying a busy s=
ocket lock
> > > https://lore.kernel.org/lkml/20260816014906.1149-1-hdanton@sina.com/
> >
> > I took a look in the commit [11] and the discussion [12], but couldn't =
follow
> > why the commit 19bdb70c77d3 should be reverted. Could you elaborate a b=
it more
> > about the reason you suggest the revert?
>
> I think you missed one problem in lib/once.c
>
> Revert commit e8eef69a99f1 (or restore once_disable_jump(once_key,
> mod) inside __do_once_sleepable_done())
> so static_branch_disable() is never called synchronously under caller loc=
ks.
>
> Previously, once_disable_jump() deferred static_branch_disable() to a
> worker thread via schedule_work().
>
> Commit e8eef69a99f1 made it run synchronously in the caller's context.
> Because __inet_hash_connect() is called under lock_sock(sk), calling
> static_branch_disable() directly inside DO_ONCE_SLEEPABLE() takes
> cpus_read_lock() (cpu_hotplug_lock) while holding lock_sock(sk).
>
> This created the bogus lock dependency sk_lock -> cpu_hotplug_lock.
>
> Every other storage/networking client (sunrpc, nbd, cifs, iscsi_tcp,
> rxe, siw) uses static lockdep keys (static struct lock_class_key
> ...[2]) without issue.

I  sent the revert request for review :
https://lore.kernel.org/lkml/20260825142515.1965654-1-edumazet@google.com/T=
/#u

>
> Use my pending TCP patch, which is a no brainer :
> https://lore.kernel.org/netdev/20260825023614.1228551-1-edumazet@google.c=
om/
>
> Revert 19bdb70c77d3 in drivers/nvme/host/tcp.c : Restore static
> lockdep keys nvme_tcp_sk_key[2] and nvme_tcp_slock_key[2].
>
> And we should be good.
>
> If you think each nvme-tcp socket MUST have its own LOCKDEP class,
> please elaborate, because I have no idea
> why this would be needed.
