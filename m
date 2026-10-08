Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17D53264E7
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 02:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791425128; cv=pass; b=WDImBrYkX1g0X51ihOGa0RY+j6YRxUdgstEzVlCCw2v7sBpC4kAcufB+/1HPryeihk20x+W0a2ellf2QyPFS53GsVUwTnoCzP9kmzro1CWAisB6Nv7lcYIYdXuw6vdMf//SW4fHhEOHRCz5dwf7ngGz3piGu1jhR5vMdVOio5CE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791425128; c=relaxed/simple;
	bh=Ni306d2UPLub9wUBwVghGvNx0tRdsbeFxp1OD2fB2cU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qriX0EbG362CptQvOFkQ2KklEsEien3o+EGyARB7fu95b8dHLgmk8ZweugDPHb8zbb+/FbTchUEU87JzoePMR8X1s4hpQYJC3Vfa0MtGMeD+WI02cc00iWbCC22DGEHSfhkVBuHb3ZZzrQpnuFm9a/1ipfHUDfQzkgoQIWPL7fM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rrnk92/m; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rrnk92/m"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1433e7b057fso3275389c88.1
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 19:05:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791425126; cv=none;
        d=google.com; s=arc-20260327;
        b=kKK41HjPdMtikgujc4DSX1nSQUIDxCfeeFloDh8I2yXOU4QDzIN4VbFGu1Vb4sWXyG
         MS2ytchBqYf5h5AQgyy+rHQs0Ko35cs8h53G1oiSLWed34t0VrknVuY6vk8pkds1wOHW
         FC8ZrYrpiKn2yJadDtumCE5QoQW2WYP+vKSJ5nGQ+mxCbfPaTmsUGt6oyB85+vR/S2+d
         BPD7oJBDaAFSC9z3H5BVv3V6EX4cMlIJR3M3oQX7PkEjWAQhGKwxogtHw7AAgIosMGGu
         P0VgVvrDXzJpIeeoNVp6HsxChfljv5j8E9Ol5fmrC1+N2XcKGIfu6r/HkTuA1Ql6ZJQU
         53uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L5+sxVMEc2cKh2K5I24giOZHwMBI7dDvEremqs2FRZM=;
        fh=zHUbvWfD09euOkg2UU8e21nYS9MBfkRH1SXQq46k60E=;
        b=OT7LeNmjHjNJ88V/hpz3YJ7pIoLMKyY/fCR/Arag1aG8Y0TEoVL+1HHibBXt8+u+Aa
         TmM/FaVQuqB/yLlTtk1xRMvxn5BLb1Ek8wZ4q6PtzBrVo5b1XWyDD04TF7/TwRlnK87W
         9VQUFjHgs+5p4WA8wleSM+yL6hvyajYQOnGHU2p2i7Cc7zHM4+5BuAYK/kRcFA84ueHC
         OfparBmaYsjLUPCEnEiLLuVs8bg2DMP4Oei9WqEuqaXrP8O0Ei1L5KHdaJI0uD/QjL54
         waYeLbPZkFWfi6/2eEysnrvviqUyKdJVsfsd9+hge2MeMPv/Eipp1dUVN9dqjO3+hmGB
         t4RA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791425126; x=1792029926; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L5+sxVMEc2cKh2K5I24giOZHwMBI7dDvEremqs2FRZM=;
        b=Rrnk92/md5QEsJLlRe69xESZbSbS3PNNCYJhYKf6mrsh3LOQ+XNtRwG5Qz8PHm7Vj0
         3C4SS3xTnqtfhfyKpB3T+fZS3bAF9rxdU9feDo2Tynn3uaeC1qh/qC333fWmZywuTLu0
         OOH4lflRkYzVwuCp6HvKs/xH/s4R1DQu28DoIZUNks0rTrS89TnJHLR27jHCSuUI8+nW
         +VEneJOuPQlKWBrpsDmamwLUVZI56x9HaupyIzXmsw0lBS6TqaXQTMFfl2XaW8d3Vufc
         4TggmoHlZb/F/ACt6bbkBRzteVpDn3q1r6XZKkTeqLsuszela06pfGXAX+cV8+09VNVo
         yiLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791425126; x=1792029926;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L5+sxVMEc2cKh2K5I24giOZHwMBI7dDvEremqs2FRZM=;
        b=pzpsH5KwkGZcbLElYOqQP6k7MGASHuQAS9gig6/pZB3Kx4/U8rfopTxKj4meunqmHQ
         c7psnOXQ63yR11QHJrnN1JbyUMRhjwJt0/PmMF3JtVFY8ds+IE4sr4tAf04quqfOaswD
         6MMubPFYsn91pARWcO3z2aMs4OrksHjquSZmk0iX1/gKx9Nj1yx4C4eIhGiTzsYg8bFY
         Yjif/cxQNi3r+COlUsMUNlvdGqAbwG9kOaGU+Gpk6UxTYO5gbvvb8B3dr6+GuNe6Sdjd
         A23HFAlZ06QjoLpY9P07PzZSdJtslkly0YgE2jo17TWXGAPEiF3OHPpaWu0Xyn1UgSEE
         S+BQ==
X-Forwarded-Encrypted: i=1; AKwUvByLwmh1nrQ7N2kfYa8ZXT7VcS7+n0Ethcwythq+ElZsaAZna+U7F8PphNd2VStTzJg7YTsUQWc=@vger.kernel.org
X-Gm-Message-State: AFuF++kcM9jMQKofV2c71A7+zp37SskTupaWnJx9UZLAJsNItM2jztg2
	KuRAXw1If4POyy9jDPFTjPNOlgfVQWyBlYXmuON1ADtgpghNh1EeuFTbnKUbCgfW3pedQ+EzdSw
	a6oLsCWLoE3eVnJj7vnCj1HlWPurCsN49E46q6VF9
X-Gm-Gg: AYBFou1XgjTGCrfszlRQKf8iVwFB3S6ROLmRhzYDpdCwyC5asCf8A/l5bydYC4ZSiy3
	DAMmLpYqBQt4voEa7uhB3tEIOHtunlPGl0I4JLJZmk6+k/XZJwQ9yxI2xDnM/u1rqQsCXw7iQ4C
	xpiwjRUogfJOjYo8bk5B1KrJ9g4Kdse6VZl14HRMalbDLAhnSXMcCKfx5jEQwPpULWxfP+mCDkc
	dGxi4nmEdJDkdCnILfoXRYdHGn+ZwlV3SfqVUdNz2Jpigp3v9idug1L9o1FnH+lRPmwy4WjTCoY
	b+juKH48KEN9J7vk0x/M0brYYmavrp4MzarCj0qFRGCcxjfxoC19U2MqO1FcCJ0c+9SUWDmC2B+
	TlBJ/PuFprLWqn8TC+V0JGhA53mhRRexTGaYirFUYzGWbb0OfMewvNx42e42WK5zSrpoQmqa3a0
	3MRWCC23BMii57mU9/Cc/EM3zN
X-Received: by 2002:a05:7022:f512:b0:148:4d6c:201e with SMTP id
 a92af1059eb24-16206660134mr4036329c88.23.1791425124444; Wed, 07 Oct 2026
 19:05:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007205827.467974-3-johannes@sipsolutions.net> <20261007163616.1088d364@kernel.org>
In-Reply-To: <20261007163616.1088d364@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 7 Oct 2026 19:05:13 -0700
X-Gm-Features: AclHuK8ZNy7OfoQWPMuSSktixGokC1G6AjDqLfquJpDruLGf4EocVEsfBjNcNRw
Message-ID: <CAAVpQUATko2Oig53r1+VHe+4Y3fFeX1xOw5RAnXtUAGwvQoB5A@mail.gmail.com>
Subject: Re: [GIT PULL] wireless-next-2026-10-07
To: Jakub Kicinski <kuba@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 4:36=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed,  7 Oct 2026 22:57:00 +0200 Johannes Berg wrote:
> > Nothing much going on in wireless-next. However, next time
> > I hope to land my RTNL-redux series which will (almost)
> > completely wean the wireless stack off the RTNL, except in
> > places where we need it for netdev register/unregister/etc.

That's great !

We saw a wifi driver holding RTNL long on Android.  Also,
I hope we could remove the long comment in __rtnl_unlock().

> >
> > I need to see what's going on with the per-netns mutex now,
> > can we already use that instead?

Do you mean moving net->rtnl_mutex out of Kconfig ?

Recently, I've been converting the first-class rtnetlink handlers
with dedicated locks, but others not worth the effort will simply
replace rtnl_lock() with rtnl_net_lock().

rtnl_net_lock() still acquires rtnl_lock(), but if we always compile
net->rtnl_mutex, using __rtnl_net_lock() for the latter should be
okay.


>
> That's a Kuniyuki question (cced). I've been trying to move
> HW drivers out of rtnl_lock and under netdev->lock.
> Most of the rtnl_lock contention I've seen in prod at Meta
> is in init_net

FWIW, I've still seen contention while creating/removing containers.
