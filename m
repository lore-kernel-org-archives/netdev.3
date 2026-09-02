Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EC4387364
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 18:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788372463; cv=none; b=nplq5nlOi/GDT+XcL/hrT+ZIc8DKTHyNiTKVsQXZAFrc3rkk3/PLSf15/6JVc8ZorD2DRkoVJGU1lPDQJid79VvHG+WqOl44I6lqqjAjO3FurlgxgcgDwutN9BSeI+qle+itNMizA2EobBc8SRWfgsfmNQMmRcGwlaCZEOcCq74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788372463; c=relaxed/simple;
	bh=fYkBum/oFlVqn/hZb0UPx1Qfhv79hOnpYMYi9KuYIrE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=VahL7Ik8Mj4Yi0NpJgzvvZ3Q0blGCMV7KQLFXH0kRLKVm6GmEdF8m4h/sVunAVElJtg6WW2gJA3Dpde/q0ekidCT8+jO8WImou/gkuZjplV3uiM7mQHSf2K2RJW8F+SC6wIq0vjZ8JZQXzqSLlXxZ6qsvTlFkUXN9U3fVlbK/4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBKx4elA; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBKx4elA"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7f64ea07036so1114061a34.0
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 11:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788372460; x=1788977260; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bd4kBVS357wZ2scT6vts92XJDYgbdkTu0arT3q8gBpc=;
        b=cBKx4elA6JllGDpaFfErYG/KUrv6Osoc06SpxI6OmUxs6fGl/D/mCoBBpu/YBGCsnt
         oQT8dljeNk/lvMaG2mlkGedSlyW5gdkQbKoxGBJ7ZwIJonYt0TqkD3mzTU5nA9qqTeXo
         dkTqBnuWAIZIMzfK9jozXN3UhiDzV5//atP7dWoRuxEgt17luLmyyXlnnnSiQ/0cPMWf
         y5Jfv7lh72jruSYOS3Wv9WeMygB8cZXEYk7OSiWcR1CUTntmAt8Ngw8mgaUMSwX/JQiY
         LvO8CG8buWqbCinCxXn56CeDdFiGzEymqsB+UIaV4QTRZi9eRYPn9IpZpNpMJocQGMLs
         nDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788372460; x=1788977260;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bd4kBVS357wZ2scT6vts92XJDYgbdkTu0arT3q8gBpc=;
        b=Xi5yCMXdXZ6jo7OMQ4teYaXiDH9KvyeA0gmT4UdBOGe/8ku7KUMqpYehHtwRfvkbey
         ictGUi0faPcVeBcaQnjauEAJINTlF1BIDFJ//reYGMcXO8fIALizF+msGUbuU/y4DBAR
         6m0GJgEmUHW1eXiKNIcnwQN2NmeOBQ6JF0bqQ4nMwth4HAnTxo18EcG/J3RjUJjpk9Ko
         ntps7uZ+EG42StqcuEVXjEjWEkJ6muolr2h21hy66ZYbchqaBoxcPybxY7nSdz++0Gjs
         ywNJJjjCpanIuzwcSjH8+fhExLi3GhYRQpaRnEasR2zPnM4BGMRuVUzNzE/9SkUZIR41
         2hgw==
X-Forwarded-Encrypted: i=1; AHgh+RoA7rt7AOYlt7B6anfrol6hRvgxuoAm5JDL0N/BznNfDxZQjVKxsxqRBv+9gl801x52ngfUKnk=@vger.kernel.org
X-Gm-Message-State: AFuF++m/a+ouM6POypIdPv6kZ/3NF2tCzrLHBn+rMD9O6AvDxu+NS+6l
	Uh0h7clJu3zLDE9xbb7PdW3oInWSln0u/DdVzSp1Bb5mM5NZji4jiTBy
X-Gm-Gg: AR+sD1170SqawxnDBixCVt8aq3F5l9vp/7XyTK/QVM9Ikoj5202fxI7Mu+MjXTpPOIg
	eUT/0HnNG34g5fN8kt2XQFICvFTRlLc02dHRDx/K7WBqbTh+S9P4CQLgQqpNRW+AJInll9+gjM1
	3AW8oCbymRFtAbIOTruwle9vkaGgyXqF3yJvg+h7XHeQ9cEzMU0WnieAHIbAp3wbBXqA349zOw2
	1g0XaXRgEyV7NreifyQJObYwylUlfK/YPGD9KR4wBhzZJS5EhISiW602IqQe4H/uAeY58+6ZxwV
	IHAnxG/9fdtHs5BMVLpa9mynhR/rvXNRZDxNWvvCDBE4DRYBzP6lVUwS4ENHzIOePw7Frc7/Zac
	lV5+gEnJDZHY4qYbDGhq7VOR5deRfTd+w51hQ1Xsap6jsBxOoyvbq0KgNPsIfSCgnUuAag7r06h
	sR0GxfGSCFxvMD3GqqiO1uKvkbIbCyBIuL6tdYBP8XoqVqTUL+AlTyB62ERvC7xOgHlFEpRy6Zj
	q2QqOIgRLZNtv+SboaznC6WxYMwLPgJkKpAOAGyUirZGS6yHFkKe9g=
X-Received: by 2002:a05:6830:368b:b0:7e9:ea28:4c1f with SMTP id 46e09a7af769-7f780315ffemr7238971a34.8.1788372460202;
        Wed, 02 Sep 2026 11:07:40 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:51::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f74f8f3c6fsm2908587a34.20.2026.09.02.11.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 11:07:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 02 Sep 2026 11:07:38 -0700
Message-Id: <DL514LM5TA6V.IOW7P2WM70BE@gmail.com>
Subject: Re: [PATCH bpf-next 0/7] Add new way to add BPF LSM hooks
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Anton Protopopov" <a.s.protopopov@gmail.com>, "bpf"
 <bpf@vger.kernel.org>, "lsm" <linux-security-module@vger.kernel.org>,
 "netdev" <netdev@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "KP Singh" <kpsingh@kernel.org>,
 "Matt Bobrowski" <matt@bobrowski.net>, "John Fastabend"
 <john.fastabend@gmail.com>, "Christian Brauner" <brauner@kernel.org>, "Paul
 Moore" <paul@paul-moore.com>, "Linus Torvalds"
 <torvalds@linux-foundation.org>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>
X-Mailer: aerc
References: <20260831110934.241898-1-a.s.protopopov@gmail.com>
In-Reply-To: <20260831110934.241898-1-a.s.protopopov@gmail.com>

On Mon Aug 31, 2026 at 4:09 AM PDT, Anton Protopopov wrote:
> The BPF LSM programs are allowed to attach to LSM hooks. This enables
> operators to mitigate known bugs without a need to reboot or livepatch
> machines.  BPF has shown very useful to create such runtime policies.
> However, many APIs and parts of kernel aren't covered by existing LSM
> hooks and this would be beneficial to extend the coverage.
>
> To simplify the process of adding new hooks this patch series enables
> BPF to attach policy programs to hooks defined outside of the
> official LSM list.
>
> One of the reasons to add a new mechanism is that in order to add a
> new LSM hook an implementation, at least one in-kernel LSM must be
> added, such as SELinux or AppArmor, and BPF is specifically not
> considered as a reference implementation [1].  This is, however, not
> feasible for the use cases and capabilities covered by BPF LSMs,
> which are not directly comparable to those of traditional LSMs.

This is no go.
bpf-lsm can attach to lsm hooks, but the machinery has nothing to
do with LSM. bpf-lsm is exactly the same as bpf-mod-ret.
So calling everything LSM is actively misleading and wrong.
Patch 1 starts this misleading naming convention
and then later patches add fake LSM hooks. Sorry, but no.

pw-bot: cr
