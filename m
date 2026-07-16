Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D24438479
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 17:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784221732; cv=pass; b=U20HNkXkP2tRXkK5CXzJltPBGUDrGcQasM7YtwaVuSOJs8jqaPj65ipHaK+ZFtr7GMfvFDdpOsjM9CU8/vgl5W5Q+4dMJe3D2V9Oqc7Bqk3hJvgtxY1w20Ih9pWGAuON35v9VmUjS4myyR+AqPlckoSBQOBLzSeZZe04h4LukvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784221732; c=relaxed/simple;
	bh=O2w5UkPvNAwudgnIoMmIYhy33vrCxPueCpDD+0YRU2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N8NWNzbENIKUuihjupv1Ou/+WRBU+TdfhmNXhtVu3VM/twcqVVu03ZN1+t6Td3mqNxbBpqoLFEHOs/7ty6ehLfcxnJM2D3rWoh/vSnJEYgZra4UvnyYV55Tu3+IqEgbRIxqRbp4GVH5L3EhfQQ4v9il0C9DhTq4jW9Jhp8fwdu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m7iLpEFU; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m7iLpEFU"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cc73e322dbso84904865ad.1
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 10:08:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784221729; cv=none;
        d=google.com; s=arc-20260327;
        b=K+Zb8SRuWfeHhWEDx05QSWt6s+B8fzQFjXAg+JplOoj0+vbas3kz7N1uHLWb1dT9PN
         Ppwu3R6BV+emi2hJdqe8CJ2+QotL0Q2eZ0bQ7WrfJpot2BqcY7JM5AqjXsJy6Jt1MVc9
         1lGhJJhOr/nKSHfE+DSM99S3xIw9R+x/ePwH/0F7iZlHlb8vXGPFoN7tJ5BznW14h367
         eZUvdY4ZRjKRm0v+53dzBRLt0DPZk4JdACLzu9LZQKWZbSY9pHTTcatS7WBkPRJTSCTa
         OthQF7vu32iAGhVnre+mrVx/15PM7eV6EGu/HjajhUwqavTwAfAplx5Q9mNYLXBbuAWR
         cYvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0JVYK7Uys8SIjezmCtJEfuGNVaCi2+lkkN1RHhufwyA=;
        fh=5BJw023HBNV3v/+0428dBvelwvAbwj2X431i9aYbiJ4=;
        b=RJ/P/8O7BojcoaIm3iM7p1v7xH6c09+igeYqlELOsHmPcrEQCWU5jw4VQUCMr1CFVs
         FbinFA7+ZiSCkNxvCjAsoZWXXTRCHPGKlN2U1UDHv0CvBVvD6CKAwWwz/6XXXV0JiYvD
         ecnxlrePJNE5Zfxz5csR7icRGt+/4KhtGi4Ns1xq4c2WUQbGG+393UjJ4H44QWxguIPi
         Aq8b2x1qfxZAUd///z1Uiwflnf3z8cdqbLH0eRMtqAbtDy/Co8F6dkym9EaGnqq2SIzC
         Frv+CaEUKQxVkXqzoe93guyKKkPVAueqQ7kQXnsF1z+KnlYQvJ0nAPBy5GOCUVOefZc1
         E4cA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784221729; x=1784826529; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0JVYK7Uys8SIjezmCtJEfuGNVaCi2+lkkN1RHhufwyA=;
        b=m7iLpEFUoI5SqXh2sOIHyPjDN7+19o4vYpHgajTu4nOHzGY82qWd/tkICi3YWGEvnb
         otdHLSDVUokh575uAjylOf9ILW0iAk7lxWT+AaMasNE4Sud0GQzoy/Xh7Tmq3YrlBSPB
         Fthp7b1vGt2XzpA9XI8Qu43pyIllSU3amzLkb48tK3eAfxwbjJZ52e/tjphkcwV5sCPa
         IYLVdCeM1Q/vjGvZyz78YQImignNC0LsC2s4bVN97U3+22X7JpUeF6jnXANi7vy1t2g6
         /XrIoxQQjDXGC+f5IPyAzUGR8x4d4dOjBZTN6tbWjlHCnCFaJUOjaeRjF1n+qmRhWm1l
         fnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784221729; x=1784826529;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0JVYK7Uys8SIjezmCtJEfuGNVaCi2+lkkN1RHhufwyA=;
        b=Tfrh076vLJHM1XxT/KTTPPyLr1/6D0xtp3X8Ej4hXKvnWkiOFJRhf1yqRJBllDwdlS
         zqXgPrji9nQLgLqWiz+htwdXRmD81BBfOZYok3jhx/4dNhCMc7Wy2jc630bm5EgSRPot
         nFqBZ9Rki5l/3gr1PReLNIIwZBpdtPzk6gSWBXAQevOI1KBOT1wqZ7x6Qk7QT3kCBDS9
         roAKiG2wvxh52D/ewAcoi8oW2pZ/XAlndj4swLpoI/KsmsREp+4IpcCE7UrwpY+pYHN2
         SlJ5C8Ou/v9Yj6qKmlf2uRhlMyjTkCLOwZlZeAXUCeCG0locvN6x62NP2Cq8Eg+zYrH7
         8d7A==
X-Forwarded-Encrypted: i=1; AHgh+RpRtiUjTosDlCrPD8UpGH6FPN8FyJ7TVW0pCI4M+AJ2WAI0yE9wTxTkcBJO1oUX/HPKUnM10lk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0KvqzZ/gkbnpfDoRbadonN2RxVdyV+yhNmMnZIXfLCr1c3+Hy
	5jmxBleLMDKIqkM4d47Ag9Z5/0Xi2UuTSTnFywSj1XZCMqhLSawqm1CfC22tA8lv39duIngWumc
	BqxqvjJpDOBUo9E+pd56lcmn5dxOGpftsO1CCLFb9
X-Gm-Gg: AfdE7ckGjinZx8x8Emt/V2Pjz/juhsOjuhLEh5OJ5aPZ8GQh7epBgHoCS3j3yL8Nrqt
	LEgjRUhEcRH8bHSVhDuLpsTvHUR/yePgzFD2j+PWSHr/FMqGt9UvOoQQw+a+u9dJyr8zTYXW0Ty
	Os1iO4bRCYh7mzrXH1byuMDO3CGBI4GEg7CbcYkYjaxlzQIZaFxu3M128ZgnrkCVMY/iJla5Mju
	xACSFYwISWAC7H/JnQ4vQNzEZe2zsNKhajgLMfm1h1ng0t4cc90NqcazKjlzag6cl76JcygSHwe
	FMf/4UEXfJdfN5uYLgRKyz9kdqma6exh4MPw2agm2q5SKGwDLK8ZLkyfdQs/JdpHqCddv4A=
X-Received: by 2002:a17:902:d546:b0:2ce:b8c5:5de3 with SMTP id
 d9443c01a7336-2cf03dc8de2mr78977065ad.36.1784221728688; Thu, 16 Jul 2026
 10:08:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <036a0c95-f5d4-46ab-88e7-1eab567d7a84@uclouvain.be>
 <20260625155313.847098-1-kuniyu@google.com> <653ebbde-aebf-4526-9d55-63976a18372c@leemhuis.info>
In-Reply-To: <653ebbde-aebf-4526-9d55-63976a18372c@leemhuis.info>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 16 Jul 2026 19:08:36 +0200
X-Gm-Features: AUfX_mxX2b1Nfsc8Y8B0LjiuDepKqGH9_wudc9W3awstyI1EakmzGpjppqd_WTY
Message-ID: <CAAVpQUDVVv_8xPOAfFkKhzRYj+T5YX0hFsqAj5GVbxBE0mjWpw@mail.gmail.com>
Subject: Re: [Regression] Broken MPLS routes with multiple nexthops
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: anthony.doeraene@uclouvain.be, davem@davemloft.net, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 10:48=E2=80=AFAM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> On 6/25/26 17:51, Kuniyuki Iwashima wrote:
> > From: Anthony Doeraene <anthony.doeraene@uclouvain.be>
> > Date: Thu, 25 Jun 2026 17:07:41 +0200
> >>
> >> According to my experiments, it seems that ECMP with MPLS (i.e. an MPL=
S
> >> route with multiple
> >> nexthops) is broken on the master branch of the kernel.
> >>
> >> Indeed, whenever adding an MPLS route with multiple nexthops, ip route
> >> show the route as
> >> a dead route/link down, even if nexthops are reachable.
> >> [...]
> >>  From a git blame, it seems that commit
> >> f0914b8436c589b7ab32c614d8d7868eb4ebd5bf
> >> broke the core logic for building nexthops.
> >
> > Thanks for the report !
> >
> > It was to balance refcount with netdev_put() in mpls_rt_alloc().
> > I'll post the patch below.
> >
> > (Updating rt->rt_nhn is not strictlly needed for netdev_put()
> >  because it has NULL check and rt is allocated with kzalloc(),
> >  but it's a bit error prone, so I'll keep it)
>
> Kuniyuki Iwashima: was this regression ever resolved? This thread looks
> stalled, but I fear I might have missed something.

Sorry, this slipped my mind.  I just posted a fix here:
https://lore.kernel.org/netdev/20260716170609.804629-1-kuniyu@google.com/T/=
#u

Thanks
