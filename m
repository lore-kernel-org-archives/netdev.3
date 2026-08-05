Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B97348C6F
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785947460; cv=pass; b=FRJm3DyGfaFehTJV080ex8RgG57GIeKxF3/BxqZm0aFN7Q47A/xddF3WtjRL0MbiLGfBc9UnvP08/49ZU0elRvm34uGBDn+l7DkfiElhSLHwIhZdS627vLFKBXNTu8HLVSFrJlnoUAmmule2x2p+j5cnVRPK6d+mNA8n65bn+hA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785947460; c=relaxed/simple;
	bh=pbWb7kCGKCB6M1g0YMYf4YasStY1pf6Chkn/aqApuU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oSJyKdZ0xlkQsbhRFrtY/RESBQLIKdJ+CHYue3r1UfV8rKyYpHpW+6VpTXroyAshaiHuevOYr0tFgOpwCfnAWmIPcBQSKGuSx04TNe9n1u15rPUqHo5sEZ6YitprVIz699P93iH6o2zLtOvhjFw/NbzobwV9isggYnu1hXQUCjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dg1p2fSA; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dg1p2fSA"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso1221764a91.3
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 09:30:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785947458; cv=none;
        d=google.com; s=arc-20260327;
        b=ghwiZ3vqAGpUtb5xQW220X7Dtmp1MsGCy1wjV930AbDbVsB/Bi/x5Ywrcp/BPnv+UR
         ELZ8dagYyNlFkeNMz4HYMfrUs5AWANjgpTY7Ro3QCNUsqQKURZ58tS6MWgBZGpusEed4
         dOGGnQlgFvMiIMu46JftCVQQ8zPz5LRN1M6YU9gf7/JPjGpiYefQWqGRS83bhlE7G68v
         iMI9SzpaXDfC7tZNgTQswusfdcQgTnu0RjnrrjvLSUvejhVX8l1EpO0NZ2JV7vl047A7
         kRuUA/DyLy0B1nSQJWvgDM12DYeursBjfoeEckQgiYsZQD8UXah1zi4F+2+HB8lpT6GS
         nVTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=++RHzXeH+bbNTwrNL/8n2XihEQ5Pr9Fs69FtXIrvv4w=;
        fh=X8EchjYuzdCpd6nSKRnsW+T1p+HY6V4O7h3ecooZb7Y=;
        b=IMp6mNxqLreUWyAVcW0nLx+5/ldw1L3XoZs7k+xYdMmtE+/MA5Evje7Lqr6UcBUb2z
         EqVp4yIqUHdce3EVs7ewT0JdYxLGOafYXYTTaOP7wRvrDapisOz8hQej/+CSs6dUxbf7
         79kzgcPkpAv0QabCNIpnK9uaoN3U5qTCX/+J/W1LltUbpAMlnD4Hy48ABPb6B8XBpOlW
         mh6UFkoQFJBrZfSCjxvv9Nz6MbFFkcIrZ4plYZwsvXfm8+eKM0Uzu1sX9aETVDau0tQi
         20Nc76dTquSEn5Q+ghZhJM+mQ+MsWA020IE41ESRqVSM1AYogPCl76jOfjoj0T7NkaJN
         U9aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785947458; x=1786552258; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=++RHzXeH+bbNTwrNL/8n2XihEQ5Pr9Fs69FtXIrvv4w=;
        b=dg1p2fSAAYKPvAw0oWhqkmyIviIrebRwbBnt3kJxkDImLBxMVP7qwEz01MFblHf2ed
         n6Q+f4Bj5F5ziSzeqpEZuQnx22vzd7Zs8+9SrsXfBLdDOPysXKLe9GtVkOG156eFG/21
         +oMgmlzjFriZ5I7TskPTx6L9Pbb31rPm7y6ACjkgtPxsJIFGAUddwb6IzU0EX965eTmi
         T8lW0ZLxP54ezdec1myXAaFMJEZU+Gob2JASqMR2QUI4DQQFDcHKyOTR868Z8XLToH5U
         PpjDMc7ESgFOxHQXiIacTdFgmHOsfpzViK8GsYZ3AJU2/UjISmB+4zt7Qn6m+ugVk5kD
         jslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785947458; x=1786552258;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=++RHzXeH+bbNTwrNL/8n2XihEQ5Pr9Fs69FtXIrvv4w=;
        b=ZAn0XMehKVq3QyNLMnMNds2NZWoMdmiWJg8NdNtDwCFUotYzmXU2FucTOui5ldBbgo
         USZ8hVrHd8qb1RMZt0VfAKqKHenJ0GhKbfZ/rWSmnLFcL8SftPwzGfEWcIA/7idq/fXj
         ma6IiTHy6n+LOdEQmaJVE4S2kFJlu4O2RBO2xjx9oJYhaH6QalLkUgFQ5Ndmd8cqFtQp
         CXKBZkiPNKOv1ZgWNlKJ/fMtjVEMbAbaL7NvsnWoumWH0LoJ5INY7MI6VYvsoksJBaUc
         cvvEjsgImjqRRV/yUmQKezbD09FBuMhDrYllZKF3EiUx9uN5ZeskEH/TWYQLKOXC18Qn
         1B/w==
X-Forwarded-Encrypted: i=1; AHgh+RojBYLcj554amDvGGfaiOrDALyiPi2f0IONN2oWI4tXB3gDChQPF+r+I9WkqD62+l3FJjQBigk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9IV0JazuzCP/EmneJOF7yGwshsdtLYf5AKKK7YjarVf9XLbg7
	80NFeHDOxJbmIjsoXLLYbL4dbYlCwhQyLTBCt22UtkZneOpNMsDHK3G24715PAa+JgQd8wxR3gR
	bF7ehty963YvWyOF+ZopOothsPE447bcuynNcDLLU
X-Gm-Gg: AR+sD12rhdSw+mZRup5pda2kuXJ8/MF/1ASMDNHQbagJKY5PWTR75awYtOb+EgsCJ0R
	GnDzYzS5Ltu1CPIEXZ7qFcjsP7IhnG9uE2zjNcHw/LbkvAqrShH5sHSH3zya64L2vmlSCcErRdj
	LntdzrSkm4MpDv1JvFU0MU/RAdl4Nhg9MUrfTjDsNk5ZUlpPIbbEfWoUK4v6NsNko+gHF/OS260
	PFKs/HZN2sB69ZAmWnXf2Cbz1oTi/gHSqLDhMS71dN319Q5qve6n1n4gMekB4+dSofl/ov9+6GN
	gGMVmW0EBJg9Y5tZ5buwzGToWwTpB7oo0AEb9OG4pnLeJJe78YEcRmb9RMgyi7KrBlmpqc8olsr
	TCXs11/q0XwyP19NBLnAGIO3Jw/lMrsLft2kIL/l13E/fbtHrNf7r5nZ58EbrNsRik85MnLhEa5
	gx2n4H84auq8s=
X-Received: by 2002:a17:90a:d445:b0:37e:b6a:6cdf with SMTP id
 98e67ed59e1d1-3903c66ba04mr8802797a91.20.1785947457148; Wed, 05 Aug 2026
 09:30:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802151212.3294591-1-jkoolstra@xs4all.nl> <20260802151212.3294591-5-jkoolstra@xs4all.nl>
 <CAAVpQUC7O1yiKQ+3FcGWbDkmcd-LeFc5tCC0vF7QgioVOXvb5Q@mail.gmail.com> <1227047202.267333.1785925130131@kpc.webmail.kpnmail.nl>
In-Reply-To: <1227047202.267333.1785925130131@kpc.webmail.kpnmail.nl>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 5 Aug 2026 09:30:45 -0700
X-Gm-Features: AUfX_mypl_npb1SMGkF-ohFPbuchTwJgwJHTqOv00Xi3ZFFd6UCwRxnqVDvqioA
Message-ID: <CAAVpQUCW4B+9SHPE233TRdHHL0Xv7P0+mH91yEGeMret7vSONA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 4/4] selftest: Add tests for useful handling
 of LSM denials on SCM_RIGHTS
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: brauner@kernel.org, cyphar@cyphar.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 3:18=E2=80=AFAM Jori Koolstra <jkoolstra@xs4all.nl> =
wrote:
>
>
> > Op 04-08-2026 19:26 CEST schreef Kuniyuki Iwashima <kuniyu@google.com>:
> >
> > > +TEST_GEN_FILES :=3D scm_rights_denial_lsm.bpf.o
> > > +
> > >  include ../../lib.mk
> > > +include ../bpf.mk
> > > +
> > > +$(OUTPUT)/scm_rights_denial_lsm: $(BPFOBJ)
> > > +$(OUTPUT)/scm_rights_denial_lsm: CFLAGS +=3D -I$(SCRATCH_DIR)/includ=
e
> > > +$(OUTPUT)/scm_rights_denial_lsm: LDLIBS +=3D -lelf -lz
> > > diff --git a/tools/testing/selftests/net/af_unix/config b/tools/testi=
ng/selftests/net/af_unix/config
> > > index 41dbb03c747e..468f7a0bb64e 100644
> > > --- a/tools/testing/selftests/net/af_unix/config
> > > +++ b/tools/testing/selftests/net/af_unix/config
> > > @@ -2,3 +2,10 @@ CONFIG_AF_UNIX_OOB=3Dy
> > >  CONFIG_UNIX=3Dy
> > >  CONFIG_UNIX_DIAG=3Dm
> > >  CONFIG_USER_NS=3Dy
> > > +CONFIG_BPF=3Dy
> > > +CONFIG_BPF_SYSCALL=3Dy
> > > +CONFIG_BPF_EVENTS=3Dy
> > > +CONFIG_BPF_JIT=3Dy
> > > +CONFIG_SECURITY=3Dy
> > > +CONFIG_BPF_LSM=3Dy
> > > +CONFIG_DEBUG_INFO_BTF=3Dy
> >
> > Please sort configs as CI complains.
> > https://patchwork.kernel.org/project/netdevbpf/patch/20260802151212.329=
4591-5-jkoolstra@xs4all.nl/
> >
> >
>
> Oh that is pretty neat!
>
> I wasn't aware there was a canonical sorting for the config. This should =
fix it,
>
> LC_ALL=3DC sort -c tools/testing/selftests/net/af_unix/config
>
> correct?

Yes, assuming you meant without -c.

>
> If I fix these issues today, any chance we can still get this in before t=
he merge window
> starts again?

I think so.

From the Linus's email, it seems we still have next week for rc8.
https://lore.kernel.org/lkml/CAHk-=3Dwhoz5Uy-kmrdzjrpCJCVWW3fni31c-zsHcH7Tk=
OhRhfOA@mail.gmail.com/T/#u
