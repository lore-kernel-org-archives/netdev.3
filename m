Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E77A364EB0
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 20:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782849804; cv=pass; b=iAPtJdsq1IE+H1eGU5In0gZFf4FHSHpKEYa4RitMVtgWwilTqfAPfapKKdsOLIxpwoQphD/03kRluvYzHRg8Cv5j2eA9GKTyw4aayk9XaD7X2WKLvvtrrEwBhYrNkSE98pmnGa5HX0Q762qy3kAkOP2BNJhJV9rb4vyHlxm4aes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782849804; c=relaxed/simple;
	bh=6pZkn8yd0tBw8pUiMXIn3KvoMZ8dCgnbtEbHZJLb0y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j1UmARmu0wMMu79I+jeQNkF9OOarQscmdDVXOU+d2b3xrStUKivXpd3BNaSppnBRIMfqxK6mMQ8xc04TUYLF0Ridz5+4iQreUle4kyESnuMfelF/mlBGXKoYAtfYohqyEI2VJaSXDai7NpxFpvuf3fbOsSr3h8E4W91paMk3/dA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbFdP2Tz; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbFdP2Tz"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6978f1eeb87so8961889a12.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 13:03:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782849802; cv=none;
        d=google.com; s=arc-20260327;
        b=kbwgxoDRgnxk7qrEssnjylMWNR3JLUuJR9bxHlaqfKftDv886kiRj6TEesk234bG/n
         8KY6ahb3hl5QqIF9F2AyxvHngpl+3wRcZc9u2aOrytxobkdVfhH9GowbZQCc5+IaYIed
         g/VcIlC+M69oQzTjdOHbZTsVI/3C4grkzK9IGXDnAR+mpxhDGh6P7tA0FuaVFWVa5w27
         lFeRmHt1f30rQAepYB9NzFc5cOzYoszHzQEU8F78dQIgyuuQBGut186UxYMjCDoBPnzJ
         dqd//DnMeDIZiv8CpAwWE705K9zZt8h6LwwJkR8A7UNMcmzNPty+mzChl1wzah9JPwR0
         YKyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6pZkn8yd0tBw8pUiMXIn3KvoMZ8dCgnbtEbHZJLb0y4=;
        fh=7ocABgLa7Ui6ORHmvlh+T4/RzM7Yuw1ALSj9zqzP/Ps=;
        b=SJ+bRtthX/2dPvgvYJfEM/SUMZf6R5OZPXohliX3Jw8k+MWE1fqFc7tfMuZHlY06pO
         y+aI47KnwbRO/0mx4nnGOQzSw8U5jNjpSsY1pSNo+S81r1/vbBiu7ecCKcbrgofVbtnq
         PbjpeY3NfDGIpI4CTqv51JymwxLX0WZrIJ3HN4+s4/VkIWOolWnNKV+qEU0nnhQvR/Fj
         zbFXsuEq3QzUOTAkp4i1S2H1enO/70Di3JdpJsEiltoX+qnzDsr5yz0JS0c+bXxjjlll
         spN/TI73fgxsfYT5DOO+6mVWrVyZYWUkaFVRzG16Ak5IxkK8SjKaKducoD3wiMVQEvjG
         XrjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782849802; x=1783454602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pZkn8yd0tBw8pUiMXIn3KvoMZ8dCgnbtEbHZJLb0y4=;
        b=AbFdP2TzeJDu6cHqaS9LfUCIwUEOUv3qAoQthciUEyzNb8YVH6B3NR1rGiq8FMsNtn
         OBEBbjLRZ6imyi3BHK+fIHFY+M2epyNLx7p37C2CrqETNpVwxcyWuz9y8AOsV1cLAJic
         pf/ctRjvC3FkKF1BTYxVSAvdhrc0VlGK2pU6BYkTzMvgLwfFXPEVhSRN7wcU9ORNvy5z
         /fnIqzDTrbKYSCfeXhcuIVX0UshrNwefvBu/pje6wRplZP7ChF+Aai11zfxvhy0on2Kn
         9DoC22i+hu7JPnOWrs7JndHP3T847qdjRoHFKFEg3LHKOUFAYUPsfl8Q2SqDmaGbIfvo
         Tl8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782849802; x=1783454602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6pZkn8yd0tBw8pUiMXIn3KvoMZ8dCgnbtEbHZJLb0y4=;
        b=RFAae6l+Hj91w6a6kbzRlWuj0TBiMPU0NoyXur81E49jkmuz9KwLK2aqzzHZ35GrAp
         SP89C7kOj8P/GkqQDVgXU3ZHyrsY/3bFFSson6ZpyWT0TMQOsTQ7JJm5MG/Gip6RQl+u
         pno5B+76VrWdVP5KkLnxpjFxq0I3kmWVs6P++xYrtnRsyy81WLhlr0oDpb688csPuaeL
         S5pXJT3pSucNpWhC7g1J+kJqPUua1URuYtZ0AHlUOFJdpWTbGRxBbsHx6lZ38M8vyF2g
         OWyYwpCWbg7DyWWjBmKjJNNy4rITOlLp2/j+zV8pnvntMvn4mCPqTdckt+eYi2U2v+Nv
         5Iww==
X-Forwarded-Encrypted: i=1; AHgh+RpI5hn50qALiW3Xmck5UPj5DOSOroTMSuuwzPTONHwBX43OIfBPZiJNJLS+3c4fYLvo72ePBdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbtUL7KD55+8d04PDBodkxyLqAl6DEFVoIFvSJLUq/RzlMmUcU
	DKxBz1GpyBgOQuUSN1w65BeQkPzSVkBpOi0xouAPhRv86jl2yj1T8ApVS770rWSUm3PBJgxpVTa
	6r5TW6yUVsC182oEsIz33MDpfkHX9sFk=
X-Gm-Gg: AfdE7cmfvPzMyIFLWGh3nN8mN8IykcUl+Usl72jDzwjOYB0Mzqp9TPt2uNOhNVKyxoI
	WypUX04irg7WTMexY4hO7ygkCqBCWbYZl7IKWLxo6l6kkLTB35UpJJ2UQ3xHyQgs4GnNcG+D83F
	hfZmcwQpVJHGq1v6FnxjKvtFtTcFTs7tPb4evM2O5hoc9Tj+7XsPkGWNAbWwOMDwFwNzfJ1/4yo
	IckKm6PS9ixWnulohvKDS9sCsUAAZzt0inffhly6rN+4wyxQgsROtAYMK/26qU8jAK9HDg=
X-Received: by 2002:a17:907:720f:b0:c12:3219:ba1e with SMTP id
 a640c23a62f3a-c1297f04180mr105626766b.42.1782849801564; Tue, 30 Jun 2026
 13:03:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE2MWknz4X_gcNo6jkR87Lg8F0zfubkOc4Ujr57CS3aBMWrjEA@mail.gmail.com>
 <20260625054005.0016.bridge-mcast@kernel.org> <CAE2MWkn=azz3gUKGBYc1jjvVnLxDHuHk9M7wAJHdAW8v=dP5GA@mail.gmail.com>
In-Reply-To: <CAE2MWkn=azz3gUKGBYc1jjvVnLxDHuHk9M7wAJHdAW8v=dP5GA@mail.gmail.com>
From: Ujjal Roy <royujjal@gmail.com>
Date: Wed, 1 Jul 2026 01:33:07 +0530
X-Gm-Features: AVVi8CfDECdiCgzhQlx3_wZFTGHCy6ydmcO-9SWK6-jb6Fc7WwdQO42bD5DVouM
Message-ID: <CAE2MWkkON7HuB+Szc1VhaPL8ZTYMAyfzmPM_7FkXvOPnjnF5rQ@mail.gmail.com>
Subject: Re: Please backport bridge multicast exponential field encoding fix
 series to stable kernels
To: Sasha Levin <sashal@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>, 
	Yong Wang <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>, stable@vger.kernel.org, 
	Greg KH <greg@kroah.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Ujjal Roy <ujjal@alumnux.com>, bridge@lists.linux.dev, Kernel <netdev@vger.kernel.org>, 
	Kernel <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 8:20=E2=80=AFPM Ujjal Roy <royujjal@gmail.com> wrot=
e:
>
> On Thu, Jun 25, 2026 at 4:12=E2=80=AFPM Sasha Levin <sashal@kernel.org> w=
rote:
> >
> > > Please backport the 5-patch bridge multicast exponential field
> > > encoding series (726fa7da2d8c, 12cfb4ecc471, 95bfd196f0dc,
> > > e51560f4220a, 529dbe762de0) to the stable kernels.
> >
> > I tried, but it doesn't apply to 7.1. Could you provide a backport plea=
se?
> >
> > --
> > Thanks,
> > Sasha
>
> I will create patches on top of 7.1. But tell me what about all other
> stable releases? I have to create patches to all stables and how to
> share the patches to you? Via this email or any other process? I am a
> fresh on backporting my changes to all stables.

I have prepared the patches for stable releases mentioned in kernel.org.

And I am waiting for your response so that I can send you the patchset.
