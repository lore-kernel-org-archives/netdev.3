Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8957421234
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 08:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791363262; cv=none; b=SjSrAZpxD/KQ4r297ZpOO/Ghq+04JjzDukXefjkmeV79sVNou7GqHW/0d+EC30SSS3sdlCobkVeytnhCkJgdzgI3cS0ynhRjIWs1hzSM1wyLIK22Vjmbu+VG0oyE2kMO5y1i831pZ5rPNEb5+UBFVdWKyKtVtJ+cdqe+AKK2dS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791363262; c=relaxed/simple;
	bh=jvP2m86V8Ms+/XIQ0TGAxHznHjZQi/k3WTX2Zvv9c40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YnGg/umEJ8DV7M65MznnwVZz/yWSoWJLhZpsLShN0HT+lu1SUB/Pz41NWdqd/hYbV2XlOj5oChlMYTzGLAxVfKKmCrEFeNxLkDMMXP9yjbafxstCxJa+J1gsqjf7WwIig2mVgIO6ItMG1OCjHKtoTb8YuzC0cjTndsfBuIn4C94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBUZ2dU6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBUZ2dU6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC931F008A0
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 08:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791363261;
	bh=bo/OVrYg2qQT1iDucGnp3tANPYjn3p6qdDSUcFomjbc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IBUZ2dU6BUyVMrpjiCojr6AdMT5i+gsokjXiKHMBCd0qwhWBBtClDMiIcUTYlSfnj
	 du69Ub+hyYSuwPRuDy4S3Ey9ckMfdTD20JYH8T92wif4urrG8E0EBog4MhVQ3sXRdN
	 9hKUJSztQRviMrK9vok4svJ3UswOIt/p71UXb+UqlxoNMLyZ7ZVRWToOY2AfPxCSWE
	 KE6qp6M1oNlIkfPeq36GDBaRbLtytAZw4sQ58bERGanJqx6z0VkHT5lEcDUfwyaXfl
	 Cqn5z5fp0a6wM4qPLZH9L3z3PHk9j5ugRSEBRUXX0OO2J7MIMFGJ3OhyWs+Q+bNNxt
	 u6Ei8GQj2NyXA==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-49e20441e45so1228364fac.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 01:54:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx90HIQf7Sppouj9WZq0JmAHdemXOrsTPqqzOokmRyDN0rZt8tpUFscS4BJJ1IED/LqUn9M66g=@vger.kernel.org
X-Gm-Message-State: AFuF++mkZUjpJ1lu5ENjhVSms1ZucJNi/p6v7Qja4GQR9cp99mkxouBy
	xIgvqfvHac7SAHPBeg+H+1n1X5E/Y8PHoRjjHKDjO+Sshqt4YbAkpBvX3UDWhyRWx5gOL7bkAIf
	n7uJ7t41PL1rJq7Wm6dw9lqdCvDeHquY=
X-Received: by 2002:a05:6870:196:b0:49e:1e15:e4a with SMTP id
 586e51a60fabf-49f4ed21696mr3799705fac.12.1791363260860; Wed, 07 Oct 2026
 01:54:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006224118.50200-1-kylebot@openai.com> <20261007082500.GA918849@shredder>
In-Reply-To: <20261007082500.GA918849@shredder>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 7 Oct 2026 10:54:09 +0200
X-Gmail-Original-Message-ID: <CAL4Wiipq9-tOvYxXuhcrJeQFd+ZySeipm1XcZVKSjSL75z8-HA@mail.gmail.com>
X-Gm-Features: AclHuK9OQF83_b1FmCMK7oKfyWoYo1hH90vTYjzwFB5Xuxj_NJhofnmhfHrr6zA
Message-ID: <CAL4Wiipq9-tOvYxXuhcrJeQFd+ZySeipm1XcZVKSjSL75z8-HA@mail.gmail.com>
Subject: Re: [PATCH net] neighbour: stop using device addresses in hashes
To: Ido Schimmel <idosch@nvidia.com>
Cc: Kyle Zeng <kylebot@openai.com>, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dsahern@kernel.org, 
	outbounddisclosures@openai.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 7 oct. 2026 =C3=A0 10:25, Ido Schimmel <idosch@nvidia.com> a =C3=A9=
crit :
>
> On Tue, Oct 06, 2026 at 03:41:18PM -0700, Kyle Zeng wrote:
> > RTM_GETNEIGHTBL exposes the live hash multiplier and bucket mask. For
> > ARP, that multiplier is applied to the IPv4 key XOR hash32_ptr(dev).
> > Since hash32_ptr() merely folds the address, timing chosen-key misses
> > through the unprivileged SIOCGARP ioctl can reveal the folded address
> > of the loopback net_device. NDISC uses the same address-dependent
> > first hash term.
> >
> > Give each net_device an independent random neighbour hash discriminator
> > at allocation time and use it in both protocol hashes. Keep it immutabl=
e
> > so that lookups, insertion and rehashing agree even if the device's
> > ifindex or network namespace changes. This retains the cross-namespace
> > hash distribution that motivated using the device pointer, without
> > putting a kernel address into the observable hash. A dedicated value
> > also avoids making a salt used by unrelated network hashes observable.
> >
> > The existing NDTA_CONFIG fields and neighbour key comparisons can stay
> > unchanged. Update the net_device cacheline documentation and assertions
> > for the new read-mostly field.
> >
> > Fixes: b14f243a42c7 ("net: Dont use ifindices in hash fns")
> > Assisted-by: Codex:gpt-6-astra
> > Signed-off-by: Kyle Zeng <kylebot@openai.com>
> > ---
> >  Documentation/networking/net_cachelines/net_device.rst | 1 +
> >  include/linux/netdevice.h                              | 2 ++
> >  include/net/arp.h                                      | 3 +--
> >  include/net/ndisc.h                                    | 3 +--
> >  net/core/dev.c                                         | 4 +++-
> >  5 files changed, 8 insertions(+), 5 deletions(-)
>
> Eric,
>
> Given [1], do you think this should be targeted at net-next?
>
> In net-next the neighbour tables are per-netns, so we can return to
> hashing based on the device index instead of its pointer. Something like
> [2].

Definitely this can target net-next and avoid merge conflicts.
