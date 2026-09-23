Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BB4408626;
	Wed, 23 Sep 2026 22:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790203762; cv=none; b=kh/al7/IfwwykZxVIRTOGmrhwOyHxnWHFSPStjT9KG/oDeUM2z+HGPh2YW41w+rLGJPvIwh51B8Y7Z7gUNvox4rfSU2h+fFprS12sNWQExkCsBgt4/6s5SZqozj80D5W5X94kMai8XMGL3fL98wzs+QeGq+L5ano4xUUYvrLKmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790203762; c=relaxed/simple;
	bh=mkzGYuT6ylnxihsZut8fAYz9U/x/x50/sKPJVuRvxVo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J8LMpo37+hKIzrkC0xnN91uGt3SOnXOcIcAD51BXgKHKlkigrW9CPVLBCc5gBZKXcE6XScNHrmn58SpZSPB9AMpPtkRpPbsoaT1fKMMTu5yd0WowGiYa9QZGg5BzW1/XI1SDvTh9i2b6TRmLoJd8NBQQ9Q+nlxRd41t3ug915sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SERLnCPA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SERLnCPA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403A51F00893;
	Wed, 23 Sep 2026 22:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790203760;
	bh=HC8VbvOSIKaqyHmIyF7SUUi2UNRhEpY8FwJ4bl0y2Cc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SERLnCPApAGnok1T5LPMo3KsD4xA9m4p3jiA1Ueuf2Z+doplz6X5eYQhaj2A5pFNZ
	 +5pwlvAr3HTPYDeB9V1SzZHNc0eRw5G4x3qcSILItxoF/o7CZxZRJut8E7jtW7pE7f
	 BO1MMqz1ADGaWcvdnMecajuqmY9j8sqXa5oaub25Z0aXvRAdtuCrH9N81pQCO0iC6w
	 IfefcYTnGt0tBvPWg8HzN12nVw6hCdtgqT0j08HeDaz7ZPtYXA5K1hNbgTfmPc51tE
	 nVHtJ/XKayQcEWru/M4wig/gINa9DGdzR0L8woWQ1FEpNsY/YGw5H/PfRtjdjYAHmT
	 RNNXu87JKdy/Q==
Subject: Re: [PATCH] net: qrtr: fix kernel stack infoleak in qrtr_getname()
 and qrtr_ioctl()
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: mani@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-arm-msm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 23 Sep 2026 22:49:19 +0000
Message-ID: <179020375975.2160803.687922264808260369@kernel.org>
In-Reply-To: <20260919212849.3240271-1-benquike@gmail.com>
References: <20260919212849.3240271-1-benquike@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Commit message factually misdescribes the bug being fixed in
  `qrtr_ioctl()` (SIOCGIFADDR) and mislabels the memory class of the…

--

net: qrtr: fix kernel stack infoleak in qrtr_getname() and qrtr_ioctl()

This zero-initializes the on-stack sockaddr_qrtr in qrtr_getname() and
clears ifr.ifr_addr in the SIOCGIFADDR path of qrtr_ioctl(), then copies
the individual struct members instead of doing aggregate struct
assignments, so the 2-byte padding hole in struct sockaddr_qrtr is no
longer copied out to userspace.

> diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
> index 78347c937af7..ee3cc2c32b73 100644
> --- a/net/qrtr/af_qrtr.c
> +++ b/net/qrtr/af_qrtr.c

[ ... ]

> @@ -1233,8 +1235,11 @@ static int qrtr_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
>  			break;
>  		}
>  
> +		memset(&ifr.ifr_addr, 0, sizeof(ifr.ifr_addr));
>  		sq = (struct sockaddr_qrtr *)&ifr.ifr_addr;
> -		*sq = ipc->us;
> +		sq->sq_family = ipc->us.sq_family;
> +		sq->sq_node = ipc->us.sq_node;
> +		sq->sq_port = ipc->us.sq_port;
>  		if (put_user_ifreq(&ifr, argp)) {
>  			rc = -EFAULT;
>  			break;

[Severity: Medium]
Is the description of the qrtr_ioctl() part of this fix accurate?  The
changelog says:

    Similarly, in qrtr_ioctl() (`SIOCGIFADDR`), writing the 12-byte
    `struct sockaddr_qrtr` into the 16-byte `ifr.ifr_addr` without
    clearing `ifr.ifr_addr` leaves both the 2-byte padding hole and the
    trailing 4 bytes of `ifr.ifr_addr` uninitialized before
    `put_user_ifreq()`.

The SIOCGIFADDR case reaches the address store only after a successful
get_user_ifreq(&ifr, NULL, argp), and that helper initializes the whole
on-stack struct ifreq on both paths:

net/socket.c:get_user_ifreq() {
	if (in_compat_syscall()) {
		struct compat_ifreq *ifr32 = (struct compat_ifreq *)ifr;

		memset(ifr, 0, sizeof(*ifr));
		if (copy_from_user(ifr32, arg, sizeof(*ifr32)))
			return -EFAULT;
	...
	if (copy_from_user(ifr, arg, sizeof(*ifr)))
		return -EFAULT;
	...
}

So wouldn't the trailing 4 bytes of ifr_addr hold the caller's own data
in the native case and zeros in the compat case, rather than
uninitialized kernel data?  In that reading the new memset() makes the
returned tail deterministic but does not close a disclosure there.

Along the same lines, does the subject's "kernel stack infoleak" match
the ioctl path?  The only bytes with kernel-side content there are the
two padding bytes that the old aggregate copy *sq = ipc->us propagated,
and ipc->us lives in the qrtr_sock allocated by sk_alloc()/
sk_prot_alloc(), which does not zero the private area unless
want_init_on_alloc() is true:

net/core/sock.c:sk_prot_alloc() {
	...
		sk = kmem_cache_alloc(slab, priority & ~__GFP_ZERO);
		if (!sk)
			return sk;
		if (want_init_on_alloc(priority))
			sk_prot_clear_nulls(sk, prot->obj_size);
	...
}

ipc->us is only ever assigned member-wise, in qrtr_create():

	ipc->us.sq_family = AF_QIPCRTR;
	ipc->us.sq_node = qrtr_local_nid;
	ipc->us.sq_port = 0;

and in __qrtr_bind(), so the padding hole carries stale slab bytes, not
stack bytes.

Could the subject and body be narrowed to say that the getname() change
fixes the stack padding disclosure, and that the ioctl change sanitizes
a 2-byte slab-sourced padding hole in the SIOCGIFADDR output?  As
written, the stable backport rationale rests on claims that the cited
code does not support.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919212849.3240271-1-benquike%40gmail.com
