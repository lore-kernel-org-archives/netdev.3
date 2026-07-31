Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3893030C60F
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 13:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785505785; cv=pass; b=QWoxtLM++EqzInQ5KuBzbDZjk2yZkZ99pyityRR8fXx8t9reuxJ/WoWcSfjQZmdB6N1n3M+flkc3IihzMOsjoTCjCETLCjWQ9LDHYbZjMuWkhvGzUcm9NW8OR5e+oEvJ7ukuJ1hEsiFvu9Y9kj+74T+oGvwP2tvUDyGEorbuZQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785505785; c=relaxed/simple;
	bh=YZ9CkSlTlrJLbh1WOVmHl9IAHWd1C2X3EZjHD0e7Bls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UQVQzo6oacdEP3EAxEgyADAKeZHbUVMA2qzhBpU919blAkoUhLeM7takf9L05Vlw7WqS7DgMnHtYVtf+AFhg9jSXg91ILoloDxrEP8eP9lqe1NWgM0DJ/PsOgymvyAJI0pjgBpy7ZuaJHWfpKMi1mKx44HZ5AJgfRZCUWwUwcGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qg2MeH0a; arc=pass smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qg2MeH0a"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4ab47c40e7eso406075b6e.3
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 06:49:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785505779; cv=none;
        d=google.com; s=arc-20260327;
        b=WQiVOKJHGrPI44baxXAxgwAPUOVPwU5/PUlMqQYg+r+6SQLEUM20qeoS5yE7CYlSB1
         YhfIw+QDiOoTdZ0bzjiL0NwXy2kusfyRDyI92WzqNOyeHWzWWGZOzCP9L0HHT0OzQYHI
         6g7DJ+uD0uaCBshsGUSA71q6R5Ot6OTOvR+a6tRRD/Oh+k1UW/oL/icSzdtzTDLTHx94
         3rm9DfPdJUVSKJMJOg+tVW+hDzhxFpmnP0tFPxz+0huqBKr/9ZNYDReU/xrMrrsoKB8T
         s20xY5Q3xKHkpNnL2kH6MVjp1UbimrXd/Tn7B3msWSuSuZ2SInipZW9mjzVk3KgpEtoV
         sEgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sCROSErOvst+rw5J7GR2giK0/Qqz2Z7mQAMi+70946Y=;
        fh=sB2nt6D219ubEkZ6UHorFi8YGC2jjW9Uv9lyWG/hwO0=;
        b=FvOu87ISr7fvs5VppfsGoZoclOhES15HUbGo9TB0k2dIsijJL7NkGFeUdNRMTEx2/X
         n7bNJxHOaX8klVvfYDDG731dYR0kkkQOl2V2RW3ss2wtsF3GSeIl9h8Pnsl05lN5QVaJ
         MfTiL0u/fztEO3wqU1h0ThYPxQRQNHM16opZaDuApK8SahmuiidVrjsT80UpvAB5XG8/
         utHs7M67/3cgdqeBvgUAqQekpWPv4NwUfCQ93XNrQQp2adaz9MUKc5cywBzS/wOzAbzV
         GcWvGL8doo4YQ2OcTX7vmv7nPnBzpJrbw6RbfeJZAvempaR25GRIVUuzZu9ORLw7fg8J
         vU8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785505779; x=1786110579; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sCROSErOvst+rw5J7GR2giK0/Qqz2Z7mQAMi+70946Y=;
        b=Qg2MeH0ar3dUWrbDhSdYL1mOObW9k9LRK0A3OVYEpDmZ9FnXWsT7igVPlFGgqvvulC
         SEU4FNfXsgm/aXDMO9ovfvPlpzJRkcy9/o815pDSQCXZqDkJV0FN4O2IUBHMohHcQA+b
         uXfK7p+v7QG/SLw8/VpRTna5SbfT1DUP3s23k37LnJ80wOdbyXF9Z9zkabP5oA6hvra9
         QXKfbbu22Vml+oBs0T7o7oSwMO1pU5vw4uLUarpDlH2PUqyWgUASyo4FI/x3MXLKlRun
         6ccLa0rUo9ig8Yz5+DSB/CIOkfgXgMtsJ5FAfWI+aO35Z1BRDxGqSMnzJ+wQNLJsvyh4
         zryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785505779; x=1786110579;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sCROSErOvst+rw5J7GR2giK0/Qqz2Z7mQAMi+70946Y=;
        b=eSeoLG6aaPmqo3S/g2u3CSqsgdXlvXxqnucesfD3szeGuPtJ/bvadaoZ/8IwExMbtb
         7bQVkJLYELaFwOdSTn2qJy4kKJgUdK8FUZtv708aGFSDR9zBqdpP7BnbeecZNlErbpJT
         2uc1jAuzHAVTztMOLbBL67TX6djtfsx0r+EWyKwAZzyzGear8UpSFAook0BaN6wrf1vg
         SNh5uHeK3eFE9VvYxxSSCMxtPw4gG2m9bljhiXapsa9bn8Y8CHBpK6BBeXlZfCAmlu0n
         8yMGkVhRr5zbFjdcUqo0Db+ufn3lADZ5hNCJcflhCRvntemDiwo4dbb0iMGhk88V1Ozn
         +Ewg==
X-Forwarded-Encrypted: i=1; AHgh+RqE4z7cKohtQkgSnKWxBqoXsPgwjqqPVP2jOZNPYkVgKwWQNb+TZpZ9UOoO2NiNn/YXO9KPrRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLfyoGTwS9mWlEXFsSDYk3ktSJ7/P6XB/SxnZhSA8ghscB7LIc
	b76tiUNlEFscgScmVI2TFhrWruYNhss/XicUKueOmp5fW8O6vxQPRI6K4FaMhb83dbj/9ZslB4I
	tSZpRN9UwbEJD/FygmDZIz9bpp49CFek=
X-Gm-Gg: AR+sD13hqjS07Gj3RjpERFt1P74eMhom0iVwbKcaDChgynP2FU8IMXRvkZa4NF3qlil
	r/wfxblamfUl1cmrDUTfwKEIPYw1E6jW4QdwVOTyri0tC0LMOvQelFxLIMywu+WftgfF8fn/ymY
	v/4RVlR8KlC9LLCwuSA56Z4ooT5JsPVsok9w0iEVNVGna0V00YNWDK9R1fuk9ZVGQW7OZRS/A2G
	pcFIBagbaMSCiWsDgp8t2P4YxC7rv9ZnBsk6e6GkRvhTtNy5BL9dyIzDojS+s4ioU6ub9cqB1es
	vtY/0zgWnFOq8wclcxHaRamyuhqfTxbtslCgMGaeajU07qsgHxPBxOAIhkpqEytQDQYSHLVWWRG
	m
X-Received: by 2002:a05:6808:344c:b0:4ab:2abe:f031 with SMTP id
 5614622812f47-4ae4c42b8a4mr2564917b6e.6.1785505779353; Fri, 31 Jul 2026
 06:49:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730100006.3547944-1-reshmaisat@gmail.com>
 <20260730100006.3547944-2-reshmaisat@gmail.com> <CANn89iLqLYAE_ZbK8F1HNop7nVPAR8AaMD2ojk+XuCNomJPEUg@mail.gmail.com>
In-Reply-To: <CANn89iLqLYAE_ZbK8F1HNop7nVPAR8AaMD2ojk+XuCNomJPEUg@mail.gmail.com>
From: Reshma Sreekumar <reshmaisat@gmail.com>
Date: Fri, 31 Jul 2026 15:49:28 +0200
X-Gm-Features: AUfX_myxRyw9a1CIwOvJkIMGVH30iSlpFvC5hopR2ZmA55gPHYfsi0yrgbcYxtc
Message-ID: <CAGwYyQmtvyKd-NiA0-3fgB0FAjnExF+svd5CRaNzUvvMLemzfw@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/sched: flag inconsistent qdisc dumps
To: Eric Dumazet <edumazet@google.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 1:24 PM Eric Dumazet <edumazet@google.com> wrote:
  > I dislike this patch; it will force dump operations to restart on
busy netns.
  >
  > Most devices are created with a new ifindex (dev_index_reserve() is
  > called with ifindex =3D=3D 0)
  >
  > Forcing a given ifindex is rather unusual.

  Agreed.

  For context on why I went looking: we hit this on production hosts runnin=
g
  kernels predating 748bbef5fc6a. An agent that reconciles tc configuration
  against a qdisc dump saw qdiscs that did exist as absent, tried to create=
 them
  again (-EEXIST), and tore down configuration it believed had gone stale.
  Because nothing sets cb->seq there, a truncated reply is indistinguishabl=
e
  from a complete one, so there was no way to detect it and retry.

  748bbef5fc6a makes that far less likely, and I have not been able to repr=
oduce
  the missing-qdisc case on 7.2-rc5. One case does remain, which this patch
  would not have fixed either: ctx->q_idx is a position within the per-devi=
ce
  qdisc_hash walk, so a qdisc added or removed on the device at a batch bou=
ndary
  misaligns the skip count.

  Is that worth reporting to userspace, and how would you want it detected?


On Thu, Jul 30, 2026 at 12:25=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Thu, Jul 30, 2026 at 12:00=E2=80=AFPM Reshma Sreekumar <reshmaisat@gma=
il.com> wrote:
> >
> > tc_dump_qdisc() walks every netdev in the netns and can span many netli=
nk
> > batches.  RTNL is only held while a single batch is filled, so devices =
can
> > be registered or unregistered in between.  Since 748bbef5fc6a ("net/sch=
ed:
> > switch tc_dump_qdisc() to for_each_netdev_dump()") the walk resumes on =
an
> > ifindex rather than a list position, but ifindexes are reused: a device
> > created between two batches can be given an ifindex the dump has alread=
y
> > walked past, and is then missed entirely.  Before that commit the resum=
e
> > used a position in the device list, so any unregister shifted every lat=
er
> > device and silently dropped a run of qdiscs from the reply.
>
> I dislike this patch; it will force dump operations to restart on busy ne=
tns.
>
> Most devices are created with a new ifindex (dev_index_reserve() is
> called with ifindex =3D=3D 0)
>
> Forcing a given ifindex is rather unusual.
>
> I suggest detecting this specific use case instead of slowing down everyt=
hing.
