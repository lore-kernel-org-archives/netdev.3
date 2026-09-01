Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8612E2DDD
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 23:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788306602; cv=pass; b=E8xWYqn7ba88r48gkuD/7hH6RBP5IJKQ7YNSjESjRpEOy+Zak0jR4s2+bZT86wMGZ/IVz6Cqu9o8gAc317t71WkTyodNk/RBg1Ft2UjjCajlgjaleBHE3A6jnf+p5xzOqdfkqx94l3KK8/eiiJGw3xBLN2anx/ddlsHamI8ALos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788306602; c=relaxed/simple;
	bh=dPJzEanQqyrmBG/zbi+dCASFIgPH8fUESOEkGB/bC1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1MYzZYUpW4JtXk5ZPMTVpUw0jB+d2/CP3JAyWUtLyMHv+zn7I3afNVXevxcjuNVvdkHI5LQ2WvSg0z/U70IR8xWSkD6Kz+0LTm49sop/75B2RwvFSdzZQcLBSy1blteJF3+qhp1469dFTNBMKajqg7J+QqMydKUT4hGw85bBko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VdJcd5Tr; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VdJcd5Tr"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso655514a91.2
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 16:50:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788306600; cv=none;
        d=google.com; s=arc-20260327;
        b=syK5SR8bgdaia7JEsAj70Oc/BQR9AiLf3F04VM2HbPXDo/P+0Y8Jezu8QXlLdReDMw
         Zl9biIDBjjhQW6lD+qtVwRyKTfK2aMJhGD6rzhU1j8Izx7ey0jSvrhhnbFjN5C14us8u
         9giS1DFv4UYipv5Jt1if77YkHQpONlWIfMlRNAGugAKIJfycAMzHna/u20PAAJglNtBI
         Is3dbq0G2qYi2x4euUVmb1eaYtfzZ4iO/EEE7Gb9PfQXPSLmSb6LIC5kaLgTsp01+Y5h
         q6VE6F5HD7RwI3B0VIxJvbIMbE4MEqNSuYGPKx45YKWuuU3Ipo9rS3UnECSXZ0+VMp/c
         tmug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SGL0K+rHEhP7FLLFplrMez/ZNMi42ddY2XdwsA06r4Q=;
        fh=tGMglhGBgiAuHuWeRrqVzBXza+Q2qBB+1+64fiB/pAk=;
        b=I7V3JUFJgi2j4hSlRritz2+nn7rT6HelCQKuRclW861c8ZCa/4d8/HSyMuQH1PEqnN
         ep1X1d2oDH2UdCN62GASKiCjOg7QrIgzvGA1sv7JTyynXmYTSZ8u7YRseIgun5Ny8uS6
         sH3Gn/tdQSqrGhpqHj7hjciNsoKeSfeTWt/XuMB6uLfkrhdTuOr30I6syCoZzBGk9tZH
         cHFwojWacgmwNuNyDL/WrAnlLxk6oRadkjTDVu7YFPI2jVjz8LkS3T+IjfKTHR1VDYiz
         WkvLbs5g9D2pk3f7FR/xAe7x10DY8YRSHgROZpscKwjxpXYJedhzbze+iveMF0N3/L08
         TRCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788306600; x=1788911400; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SGL0K+rHEhP7FLLFplrMez/ZNMi42ddY2XdwsA06r4Q=;
        b=VdJcd5TrZGAPnJyASzEf3R5sdWIISI93ED2YhZ9SlvNGMpBkSX5/8fnaOaO9MnoP2F
         7Y5ZLalH8aeIpYIBd6s/RAiKA4SJaU5L5rlQkjh7anEQnZ/bKWYERvISx24rIez9bVPf
         KCJt8VBEVymR5C0sL+n2B76CB3tVGAzWfn8Dhwoy3h+2z11cREdwUj0gkTdddPZwRrMV
         yvHSNNuSjwONWGydkvmsEZJLpCX43VYrHNcs9Y22XmclVNPtkDoC9xVgrGhwNjvcMxze
         r9t2acamRQ3N/KbD112qW1Ejxiy25ETxIntlcoHPRlKR4UUxlLCs02D/DVBgRizIQKY8
         QIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788306600; x=1788911400;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SGL0K+rHEhP7FLLFplrMez/ZNMi42ddY2XdwsA06r4Q=;
        b=lp9hyFVj302DGdk3KoTfbhaI+nGHMLIHr18KnxrCEg5mc7RfGqUudDYUPD1PvDER1h
         N+Cvp3m5SdTcqEOwAX+LgM1YhBEzaQFv6cnXCmae9/9zjLFOYuCJJTxo3vh/AGlSjrd4
         nGrX2VEZs2w68XDZqRbqHY3aBQI9p81QvNUB4TsBZoN0EL83nEyh7Xhu3W4Ujv+6q511
         3HmOjo33t7osF0RA1WwTK6VuGA73sUAV/O3NdRsZYO4+CCBUGhj2TFNekCa2RQA0cQgn
         DRbQOYlV4wc0twRdu3B0BW/Ni0n3TaEB2uPNVk4E7ajqefgQ70zvm65TdA8GEvRv2wIi
         gDHA==
X-Forwarded-Encrypted: i=1; AKwUvBwQvkK12xCRAmesocqWV6FyNqwjqfsdAeD1PjvoWoy2P8ucjG5vS2zoM0j1wBUwqlsLihvRZKA=@vger.kernel.org
X-Gm-Message-State: AFuF++kOF6DKricguEpXf85+0HnLoHpLCnm8KjYm41KnqjOAOsQMfcMs
	XIvx79d+fLbkLVY/leksLWJgkutyvW/JcKPtGnVptyozHYfXZFaSGiULrVMlEorZyID3htiXTtO
	4jTPjyUxspWNF93hVLDRY+7iDzO35kJoqDxGbuELD
X-Gm-Gg: AYBFou2kUrKDJEEumEHa1B5iz/kLpAIRe/vRF8WdZexfixS4DdgyP1VjItIKf7mlkhj
	q5ih/pzGxqWZnE4078P02cC5SyQrxsVxAeFSyC8SqNAr2SAsoqbn1OHS3PrXop+amkbsuzJ2EZD
	xyq4JjtoUyGucTxqisPDFWz/Qsi4BliRrzBAWTLAIPTqSTkHR4gVk6QKPWb2SiKAvL9Ubg9wI2A
	P99a8keuL7f+lT0ZPI+NJlJraZKat9Vb8RAvgMkMrcDBhV/Xuln4j25mXmhETRSCotDqMwEkzZL
	dgFcOTA13GNDnmiEProR8nPpy7E3IaLoUB1TghLvFhKtuft4zaa7nUU8EH/kClsXfKRBs9+wxmS
	PaH8vw+XxPPXUI/SQjMK216Hrb++ECTpKDmT4j7QJc0mA5QUSpbI5j/qlNbcGIJlTuTYuyXEXqk
	dvxVdhXTkvgtJu9wv+CroM4Q==
X-Received: by 2002:a17:90a:d887:b0:398:e1f4:bda1 with SMTP id
 98e67ed59e1d1-39aee260bb4mr810754a91.21.1788306598706; Tue, 01 Sep 2026
 16:49:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901071353.3302900-1-nagachaithanya9911@gmail.com>
In-Reply-To: <20260901071353.3302900-1-nagachaithanya9911@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 1 Sep 2026 16:49:46 -0700
X-Gm-Features: AcwNN1V39DVBrPlGQ8m1cLB-dsHFTxG9CBDxkaJp2jJkfWx9OsqVRWRq9rtEpp8
Message-ID: <CAAVpQUDd-HeM4XTufJsBchZq_Lb0in188aawzZUYPjRAGEzZjQ@mail.gmail.com>
Subject: Re: [PATCH] selftests: net: ipmr: Avoid memcpy() from NULL in nl_add_rtattr()
To: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 12:14=E2=80=AFAM Chaithanya Lagisetty
<nagachaithanya9911@gmail.com> wrote:
>
> nl_add_rtattr() unconditionally does memcpy(RTA_DATA(rta), data, len).
> For zero-length attributes the callers pass data =3D=3D NULL and len =3D=
=3D 0,
> for example the RTA_PREFSRC attribute added for proxy MFC entries:
>
>         if (mfc_attr->proxy)
>                 rta =3D nl_add_rtattr(nlmsg, rta, RTA_PREFSRC, NULL, 0);
>
> Passing a NULL pointer to memcpy() is undefined behaviour even when the
> length is zero, because its source parameter is marked
> __attribute__((nonnull)); it is flagged by fortify/-Wnonnull.

It's not flagged since NULL is passed via nl_add_rtattr(), not directly
to memcpy().

Also, the behaviour will be well-defined with N3322 in C2y.

Given there is no real harm and we do not bother revisiting this,
there is no need to change that.
