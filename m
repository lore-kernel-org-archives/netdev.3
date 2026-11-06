Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793984542;
	b=YXjt8+L4v9yM+ZyNXKLJqt59aDNklWw4H0x6iu7dvFhhtY7JV0ukttR9ckqzvefWT+Wo
	 /14qSKP/tEEePCWaHtXvySnoTdKo5ezVrvc3oAmCJd70Cddu9DsIBLDhR9EnbjNo1ixiR
	 /Ipna2IVZ621Fivmrd2vibM06LFK5J2CuIK95rCb//n+1dTZ4XmOxiXbEcnnNkumw2UmL
	 8NQpIf1Tyyi36jP1vir+RgEM/KwdgeNU4oRji44K0uTD+1WJHzRGZQibfe9vmDKyESXWj
	 Zo9xbAUuNFSDBX9Zb2Pccw1rJE0R9IF0zkIoQ702tAKykNKtAu+UxD98+dOJZEgLhKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984542;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=eHK4hWpHMNmpbnMXcx4g83y3Zu1DC11rUWMGmL5dIvM=;
	b=daByHMeq8ff/Um58wTaLlKAZpuwOWOPEuyvl5Cs4Z4zReJT9gwySbocAL2x5F8LfNHfv
	 jRA9Q5KJZtDR5M7lOnZfFNH4tiAfaupXJUAjn4KZOnRJ7iyG2WALglEr6u9xcY9wlBgm7
	 gEQrPIKr0o+wYKPojPCdzM50E5ljgSTTCF5wKXZvc0Xa+gSOPo2tpYf7PEGy5ISFmsmTo
	 hOjU105EFeErmRdtylcGJW8eLj3nR5oF5yLeFneZx+0xmjU9S7tRbPtxtGkeVW02MhNe9
	 rXWY4BQibl+8A0BWapsCe7jWIWyrW9rETri/mX4S0prto3apsCjLJvj+axHg2MklcoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ldvbk1zj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC418606A32E
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 17:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ldvbk1zj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613CD1F008A2
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 17:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793984541;
	bh=eHK4hWpHMNmpbnMXcx4g83y3Zu1DC11rUWMGmL5dIvM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Ldvbk1zjfsO1lVp/rq0sjI0AF7rGAmfTkJyi72imVoiNtzqCpy+y/DmvayW+t6TiA
	 GJggPnw/j+50ryzIW3nEHy6OvAbi4NpHwWfIwU5H3G3ZgQ15Aak/KMmk8ILCefpJyW
	 nxK4oxeQ4WVfW+5Q+7aMSmAx5xKDe3Lbyw1uunI8hcNvTTYLA1nVWtzXLVC7NlE04k
	 ugBJ5Xjlm9GKc8itLW/R2YTND+ia3UnHCVoOI5G+dXDf+7XV7P6ZG9HCbE7YCJKVdk
	 H5l2Zv4VItWYQJSuVkZskUkfknExGKJRG1D2/3dEbm/ylL65hKYGLidAgWvtv31+RV
	 u+E+ydF8NeU4w==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4adba7b3399so81177fac.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 09:02:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHWrJbjDbmExAX1f99A56s3H3acUFx+0Be3ArnHnoCCx3kSQLrBdwmhQFDd0z6BQ8ek4hvKGFY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9nKqe1eGGnzt0zxe+jw3ttjZiRkjKA3RpwXj5hyp9BgpY7A0vl
	N9qx/4p3ssFM3aOS1Jwehnmu/ZjqroHsNueXguByDRYpjPkE2BH0bHEm+6r9qjDCvo2sSh4YZOs
	QQPTTwU868imNRW4iX1F5JigPap8KKjU=
X-Received: by 2002:a05:6870:c093:b0:4ad:5b29:c628 with SMTP id
 586e51a60fabf-4ad98c167e0mr2033816fac.23.1793984540715; Fri, 06 Nov 2026
 09:02:20 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106161455.2412769-1-edumazet@kernel.org>
In-Reply-To: <20261106161455.2412769-1-edumazet@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 6 Nov 2026 18:02:09 +0100
X-Gmail-Original-Message-ID: <CAL4WiipZr9QRQ=E5GpY6FcrRqscRPz2y-jLdmX_GpkWAmw0Z2g@mail.gmail.com>
X-Gm-Features: AclHuK8wtLmcy5h83KanZUR2fhPO82XMZjPX1My6JRw_QBYpPbY1EU9JocE88Ls
Message-ID: <CAL4WiipZr9QRQ=E5GpY6FcrRqscRPz2y-jLdmX_GpkWAmw0Z2g@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: hold the tree lock while resetting a qdisc
 being destroyed
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 6 nov. 2026 =C3=A0 17:15, Eric Dumazet <edumazet@kernel.org> a =C3=
=A9crit :
>
> Since commit 47e8dbb6e763 ("net/sched: do not reset queues in graft
> operations"), qdisc_graft() and mq_graft() no longer reset the qdisc
> they remove, so it can still hold packets when qdisc_put() destroys it.
>
> __qdisc_destroy() then calls qdisc_reset() without any lock, while
> qdisc timers keep running until ops->destroy() stops them.
> For instance sfq_perturbation() can rehash the SFQ queues under the
> sleeping root lock, while sfq_reset() dequeues and frees the same
> packets, corrupting skb lists.
>
> __qdisc_destroy() has called qdisc_reset() without the lock its comment
> requires since commit 4909daba3784 ("net_sched: use qdisc_reset() in
> qdisc_destroy()"), relying on dev_deactivate() having already purged
> the queue under the lock. Commit 47e8dbb6e763 ("net/sched: do not
> reset queues in graft operations") removed that purge for graft
> operations.
>
> Take sch_tree_lock() around qdisc_reset() in __qdisc_destroy().
> This is the lock these timers take, and the lock every other
> qdisc_reset() caller holds. __qdisc_destroy() runs under RTNL and in
> process context, since ops->destroy() can sleep.
>
> Also update the qdisc_reset() comment, which named qdisc_lock(qdisc)
> while most callers hold the root lock.
>
> Fixes: 47e8dbb6e763 ("net/sched: do not reset queues in graft operations"=
)
> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> Cc: Jiri Pirko <jiri@resnulli.us>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> ---

Do not spend time on this patch, I sent it too early.

It should be part of a series, with a 2nd patch from Kyle Zeng.

pw-bot: cr
