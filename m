Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793784678;
	b=JlrpXaLvzlopQ2R4IkItoZ7zikYwgDH1VR2lXcvvw+Sp9mmkXO6BUSLH0go1cjtb4VaO
	 pZwoXgbr7kONOvfMwPs63ZJpvd4cHbM+PJU1IXKH5mrYziDMv5H1soA5EglYc5ouPPSID
	 PplYr2+VAHcnFV/cKU3GQak7UyV8qc+aK1Btmfro4c0dbtnmxu3PgzSusmYtEwRAzppvN
	 5e+IkHBJv2OPovZ8zxX1A9Uvq2vx0Klte5xhG6DIX1nM1Qyu9bVJL7GPh0N9GDlSr5h4I
	 Pn7CETcvtpjwI+pOrpkIVKPD/hM2Qnv5hFtRaqmN6/QtjDddtwLxs3dOscxrdJ2twKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784678;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Kt/OCYSnNdP98Gx/DZubNWnVkl+xmTpdHaipfeSy+9g=;
	b=B/hwSDobrFOMWNPvmKk1J2InxaIYRIb9zla0lnatRjlOmJkDfZWrn1yHnjRi6/1VnoYR
	 xTE1jlBttucpiifkeB6/hweShfH0W0SuMDUrpxPAZiJD7C9o7F+96qMMRQIN36zftpo2q
	 rEuyy0fm17HbDmetjTzKGBKo+Mk3L/KpRxAO8zDR5EE8hIYsx03T8+q1wMe1sAVb8onM8
	 ijHJIc3tr8WD/t6k1lgRtp1tc0fC0owSNIcCTGB+NS+TpAVDN5G1fWDluUvNtHEhl0e2g
	 GJ003N302N7q4zUq9apnTv8n6rm8Bg1+khuTa/dV9uMqtp7UsQbT835Wzut04WZ/I9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UoXcguUj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E5B606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UoXcguUj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581701F00919
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 09:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793784678;
	bh=Kt/OCYSnNdP98Gx/DZubNWnVkl+xmTpdHaipfeSy+9g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UoXcguUjYtoyeVxh6C0AzYCJWi9U6tgCOPoYgSGHRuBuAGOUFZx8jSWMxtsbX+zOg
	 aqhJPFtSjzWRXNOJuG9tDdTrCqwU9b1aOCkyxKRTH4zS81Z1Qq3vxDegLpTWLEwSJN
	 StJW/lmlhk0U3kaTTNucT7L+T4JOzVUP/Y2GuiY1YsBj7CzHErheC3AdNy8Ege2PtP
	 axLEe6nGg/TyN1t/jd+ztQU31VDvKIJSlj1r8ckrapwMSsfrsNzX3G0yl8Da0VT/bh
	 TJw1icfAV5Y0o0LjA84YqE9H2h8RkrQVSquBxSX1K4513B1XJVhGUlY47Ix4vI5Da4
	 vlP90yZUTkqZQ==
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-8253bc5a613so344786a34.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 01:31:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwCD9Q/7v8l5NVaFlwh2naNLcui9UhSgUYxdm37ceS0t4o/OVoVGA8HQPesAEZMUvuHPXrGbdY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+8l7txeyHhi0bsZoFQb0A2hxCTzPvDM0xjScQIccB26/v4oFaW
	7+Od6HfN0khuwB6GwhyGG0lutBuJ1skPoYbEn/7RDMwRkKqYjjMh2CEKBqoVFIFvnAjE9Zomkeu
	c+mVHJ5fs/vDDX0Xb38JRzkgdYENTJyM=
X-Received: by 2002:a05:6820:3382:10b0:716:c018:eda5 with SMTP id
 006d021491bc7-716c018f224mr843480eaf.77.1793784677722; Wed, 04 Nov 2026
 01:31:17 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104064409.281303-1-luyun_611@163.com>
In-Reply-To: <20261104064409.281303-1-luyun_611@163.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 4 Nov 2026 10:31:05 +0100
X-Gmail-Original-Message-ID: <CAL4Wiipu2VTRck9Es31krEKmYZuh9iCQu5fwqpOkWP6pQNqjvg@mail.gmail.com>
X-Gm-Features: AclHuK9q9WTjwXgacMRrYWdijThURDcukhnubuwopePaOdAzNw5yNJr5fBLac4Y
Message-ID: <CAL4Wiipu2VTRck9Es31krEKmYZuh9iCQu5fwqpOkWP6pQNqjvg@mail.gmail.com>
Subject: Re: [PATCH net v5] bonding: 3ad: update transmit arrays without
 waiting for RTNL
To: Yun Lu <luyun_611@163.com>
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	hangbin.liu@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 4 nov. 2026 =C3=A0 07:44, Yun Lu <luyun_611@163.com> a =C3=A9crit :
>
> From: Yun Lu <luyun@kylinos.cn>
>
> During 802.3ad bring-up, packets can be dropped despite carrier being up
> and LACP having enabled ports for distribution. This was observed on a
> machine in real use.
>
> The LACP worker enables ports before queuing slave_arr_work to rebuild
> usable_slaves. The transmit path keeps using that array, which can
> remain empty while the array worker retries rtnl_trylock(). Unrelated
> RTNL contention can therefore prolong the packet loss.
>
> Rebuild the arrays directly from the LACP worker after releasing
> mode_lock and RCU, and remove the retry worker's RTNL dependency. Retain
> delayed work to retry allocation failures.
>
> Use a per-bond mutex to serialize array allocation, filling and
> publication, and walk the lower list under RCU. Keep upper link/unlink
> notifications outside this mutex. Exclude new slaves from both arrays
> until all fallible setup, including XDP propagation, succeeds and
> commits array_ready under the same mutex. This keeps concurrently linked
> slaves from overrunning arrays sized from an earlier slave count.
> Release completes its final rebuild or allocation-failure skip under the
> mutex before waiting for RCU readers and freeing a slave.
>
> Retry failed final updates for running bonds. Also rebuild broadcast
> arrays on open and retry failed open updates. Protect the
> peer-notification array reader with RCU now that RTNL no longer excludes
> writers. Updating the shared arrays also covers XDP and lower-device
> queries without changing their selection rules.
>
> Tests used an RTNL holder, userspace LACP peers, slow notifiers and
> test-only allocation failures under KASAN and lockdep to check recovery,
> concurrent member changes and teardown. All 16 bonding selftests passed.
>
> Fixes: ee6377147409 ("bonding: Simplify the xmit function for modes that =
use xmit_hash")
> Signed-off-by: Yun Lu <luyun@kylinos.cn>
> ---

I think this should target net-next. The rtnl_trylock() retry
has been there since v3.18, and this patch adds a new locking scheme
across enslave, release, open, uninit and the 3ad worker. With the
Fixes: tag it would be backported to every stable tree, which seems
risky for an issue that only shows up under RTNL contention. Please
resend against net-next without the Fixes: tag, and keep the problem
description in the changelog.

pw-bot: cr
