Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793046699;
	b=MLDl6TYbogYBEqQP6+xueAIr+LF7dW1nK1yOB5S8+QN8VrWgFfLom5vuCwRkZHmOsr01
	 0fpeLDRJ5ZXsAOZeJZFP7/s4ai1guyhpZnpMzTNewn7zss4s0vCrXk3UPAi88UX/fhQN/
	 2v9Uk6koMuSuCLROjrSzFiHEvnrdHXvAMGPOCmJGvf7lQxRhMtz8mnBIrU4Zq1yElSGel
	 WQOF0bIgaxsglFGmbihpdXpmFIT1DTJmX1zcblTPkwJqEg794rresVjVrOx4Il3kBAdmN
	 TwLTN8q0ECh2Gol3HetgN7+SmRRWMci2mPW9ezhOovtpKhqFEwHBvqqWTN0rib3SbZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793046699;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oLlOcSCQ32pMuVJGiKdjmwfrqV55t/QVJ+mNxxfwt1w=;
	b=u+36vsxXdVGFfCdEAFeUVvTPWoMyRhzofN2pCu/g413C88HhWNprdRN1T6xr7+nvAnyw
	 Hp2kaIf2dE3UTb05725BWt/8HiPzuWIU1WtNRJGO86MLpQsoCM1jyQAavTy7wZfoIhWPW
	 QDK9XfHdwnIFUMCRLRHAeWx/tFcnEl9oqOagZucCIsRfdti73neu6V0lewYj74oPyEqcR
	 +X8/japWQ/DzstbS2JVmEaFeTLUnXVBXp74q5Tit/rRIRqypi/FXGuEiHGkTRjoqeKuc+
	 RTy4kvO4fNArCoDRvbF8HXSNRNbVyf868YcyYEyzc6Q3RmaqZZa1GDWqUYdyQJlwEyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=L+wootqW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BA6606A31F
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 20:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1BA6606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=L+wootqW
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e9d1114320so26208495ad.3
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 13:31:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793046698; cv=none;
        d=google.com; s=arc-20260327;
        b=QdBy4no6DiXsomag27c809JZBsoeyoboisdSD9ESbsDknNjLZSZ4zDT97bHKaFGv8H
         RDv6/Fuul/LXGmry5Mnilw4bOPjsjvqs2LERb3OKs0Iq3IzO+YArhecwpv6CL8ob36s8
         cZxqJnFN2YR3awdCzdkTF041RXmbVmogzfPMVrwvXli9GSqwmjNjK1WdhFwRukyeD3XP
         rLj/hqZMXTHmXZR7Y1cypiSrQSK9N2kfyhGGcp1KvUDp0mOqFMrD5ztvioNBkVDYSinI
         pYIYizOboPyMg6IFob1tuNFX4tUqBapvTccQm6AFeRyMaD5XomdqlUl39LolN2RGotRb
         rN9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oLlOcSCQ32pMuVJGiKdjmwfrqV55t/QVJ+mNxxfwt1w=;
        fh=/j6ENi5IKAzYGWWPsU8EgVyL0BnxBx5TYoY99tDfcag=;
        b=WZDeax8mGBoAZRv+EKDb08xqhq7KX57p4Z1YfoKu3lGACRAsV5Xw5Ax90kI5qWyIAg
         NsOtca2unzq29LUiksOBvAB7MLaGeJZ+fxdGi4jSUXpFTRjSAd+HmIp2CsjUE2ATTmKu
         xtLpJASKwLowzZ6s8O2Fbc28g6/Gga0UldereSA4Tpc2yAPJ8EEM7SEq7pjC0340Wtl/
         iS0I0KKqFUJw7t4fmW8VgI02w5hhqLgPuUWrxsIrrY8FBudcj961+XEP1LKLtdWq22Xo
         ZbUuvwsIXgNRTBD9pI4sPTO4APfOPoI9XtYpwKP6qVB0lfTR3YvQchPk5vcGsJ9TKJvn
         lPHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793046698; x=1793651498; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oLlOcSCQ32pMuVJGiKdjmwfrqV55t/QVJ+mNxxfwt1w=;
        b=L+wootqW5T77UGOryyw3TrOnPRmPjLL2i4uoI36Fb52hAChavbUjC2oAErcwcWcJq1
         gwgn++rWkrUiN4eZmtVkxuIBOAsAZefl8wqr6EQCDZZBTjk1hO2UkuEyI8i5m5RjX7DJ
         EK1ndGeANRMX4aTbpO+nvR7fIU63VxFQ9ffp4FXCojFjYD+fdWAL9RHBV9A1L4pnrwWe
         CwArxDWTNOmGZ0DS0oKM86YGqSE9zdjWjrY330iiwsDo23ENOID23IQ7tNUIGTMjbHgT
         BUbvwez+Hzl4lCCb8TSHKJZNqHNNnbu8YjtxV98iTts8xUYoVruc0kCp8wqVv0S6jf5w
         /EUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793046698; x=1793651498;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oLlOcSCQ32pMuVJGiKdjmwfrqV55t/QVJ+mNxxfwt1w=;
        b=AwRs6SP550C2f6q9KeNSkzJzfPppRDN9TY6Jh9+yhJt7G1V3IFfDDZ8CuCLmL6uBre
         5PZP+5OC48sii1nnJbX/KRGLqymnu704vMACAyOf1ROmty+p7tl+OYkqTzS4kANpln24
         HBmj1BOn7icEWpFhl7fgu++UocZ/bEfsayNEZlItwxpv+f1M12gLJF0aojydhvJJsmyv
         UJymLxvyz/r6F0dpPj4WYQQMlMF20cxjLAGkS/PlbnbC2kxNnPBiB59ZmQNpIL+Joekm
         UWtfjwc9BpSRLIKbXFgJibdHPxiSoWR0C7ubIO6kA742OxOpgTHBDnbhBt0KrS7ZHm6m
         2FaQ==
X-Forwarded-Encrypted: i=1; AKwUvBygntrKIiUjFqYia/TnMwLJVf8J+qARK6V0tn1EIxHikvGW5yD4iUmYJsZ95J0ypDEVCVejlkg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ23T4La6TICCPJ+bdRuU2kHWlgR0YtTWg6o7Vvfpp9Oxt30oUc
	Lrz0itlLPDplF1r5sgnHLU8b5MRSQi3LYtzV5GCCFPHcYzbhxbOuesWCwvdDwkUzMO59oOjANE1
	7C4HDjNxsZGHvYqJV9GMyB+I8w07Edrrvjq4skY9m
X-Gm-Gg: AYBFou1NyFjhRbmhCZwm1xA7rn8pc8hA7ZEvZbGNeKxAz3s5CvNwaI1Ya5/CBX/3aXZ
	B2tXlxgcpcivis6B9RBKhIKPkR3b3Ja2X0bD+9OCnKIWeVDYUd836Py7HWLdoDbevyMnoGbxSnx
	wKFLsG5wXrC71CckDfUw8O3veda3aCDuQ5fbNpEtkidENlgW7TrCece/6Jy5mq/YapUG2epthHS
	ASTIF1ldN4U2nsJH7038J6gvtljLmmTRdifMRRQvyUgZ7/yjOaY3aVyJGU56Mgd9FvJcNDagE1d
	n+CDPahvc/5VGgrndztJeH8oo7Pzi92gFha+LavWxbamWRsx605PHoohNeI1F+4oM2iZb6NFOE4
	QCA2LND1R/jDn/chOnvXQnQ4SR93UC9PROjw7Bps+c/LAQWoB9ogdndkgXv/jsJruHlJmUDhNsr
	ei8Qz7qzhbIXpmvw==
X-Received: by 2002:a17:902:ecd2:b0:2e8:30dd:523d with SMTP id
 d9443c01a7336-2ea9c620609mr71569325ad.13.1793046697876; Mon, 26 Oct 2026
 13:31:37 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
In-Reply-To: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 26 Oct 2026 16:31:25 -0400
X-Gm-Features: AclHuK_MBYtdpmV00LiIGiHwgdDyciJ8YZFfqnRLK0ynU1qoZWOLvejR9vdc3xM
Message-ID: <CAHC9VhR4rMydWiD-RFv-ABiYSG_txJuyrtdaowEXPY=CHEvFXA@mail.gmail.com>
Subject: Re: [PATCH 0/8] ns: fixes for the namespace LSM hooks
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 5:57=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> I tried to switch systemd-nsresourced over to the namespace_free LSM
> hook that went in this cycle. I explicitly developed it to work nicely
> with that. But the version that is merged is broken for that case.
>
> The namespace_free hook is never called. security_namespace_free() bails
> if ns->ns_security is NULL and that's only allocated if an LSM requests
> a namespace blob. Nobody does. Landlock doesn't care as it only uses
> namespace_init and namespace_install but a bpf program attached to
> namespace_free never runs. And it can't work around that either. We
> could make the bpf LSM request a blob but that would just be a way to
> make the hook fire. So call it unconditionally like we do for
> superblocks, files and bpf maps.
>
> The bpf LSM also marks the arguments of namespace_init and
> namespace_free as trusted. Curiously that patch was also dropped.
>
> namespace_init is called before the namespace is set up and if anything
> fails afterwards the namespace is freed without looking at its reference
> count. namespace_free is called on the way out. There's no kfunc that
> takes a namespace yet but once there is one a program could take a
> reference to a namespace that's about to be freed. So add both hooks to
> untrusted_lsm_hooks.
>
> The namespace_init hook also always sees a namespace id of zero because
> the id is only allocated after the hook has run. The id is the only
> identifier of a namespace that is never recycled. So it's what a bpf LSM
> wants to use to track a namespace from namespace_init until
> namespace_free.
>
> The inode number is recycled way too quickly for that. So allocate the
> id in __ns_common_init() before the hook is called. Then ns_tree_add()
> doesn't need to allocate ids anymore and ns_tree_add_raw() can go.
> Landlock keeps logging zero for denied namespace creation because that's
> what it documents.
>
> I'd want to get the first three patches into v7.4 since the hooks are
> new this cycle. The systemd change I have for this uses the
> namespace_free hook whenever the kernel has it. On a kernel with the
> hook but without the first fix it would never learn about dead user
> namespaces.

From what I'm reading the LSM framework patches don't meet the typical
LSM criteria for stable/RC fixes: there is no serious bug/panic, and
there is no functional regression from a previous release.  It also
appears that the existing Landlock namespace code still works as
expected.  This looks like one of those unfortunate circumstances
where a new use case wasn't tested thoroughly enough before the merge
window, so it can wait for the next one.  We've already identified
other LSM/namespace issues that are targeting Linux v7.5, the
security_namespace_free() change is one of those as far as I'm
concerned.

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> Christian Brauner (8):
>       lsm: always call the namespace_free hook
>       bpf: don't mark namespace_init and namespace_free arguments as trus=
ted
>       selftests/bpf: add verifier tests for the namespace LSM hooks
>       landlock: pass the namespace id to log to check_ns_type()
>       ns: allocate the namespace id before the namespace_init hook
>       nstree: drop ns_tree_add_raw()
>       lsm: fix the security_namespace_init() kernel-doc
>       selftests/bpf: add a lifecycle test for the namespace LSM hooks
>
>  fs/namespace.c                                     |   6 +-
>  include/linux/ns_common.h                          |  16 ++-
>  include/linux/nstree.h                             |  29 +----
>  ipc/namespace.c                                    |   3 +-
>  kernel/bpf/bpf_lsm.c                               |   2 +
>  kernel/nscommon.c                                  |   7 +-
>  kernel/nstree.c                                    |   2 +-
>  net/core/net_namespace.c                           |   4 +-
>  security/landlock/ns.c                             |  11 +-
>  security/security.c                                |   9 +-
>  .../selftests/bpf/prog_tests/ns_lifecycle.c        | 145 +++++++++++++++=
++++++
>  tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
>  .../selftests/bpf/progs/test_ns_lifecycle.c        |  88 +++++++++++++
>  .../selftests/bpf/progs/verifier_lsm_namespace.c   |  38 ++++++
>  .../testing/selftests/bpf/test_kmods/bpf_testmod.c |   5 +
>  .../selftests/bpf/test_kmods/bpf_testmod_kfunc.h   |   1 +
>  16 files changed, 314 insertions(+), 54 deletions(-)
> ---
> base-commit: 21a7f44fd0765fcc5194130b28767786eba1d1e7
> change-id: 20261026-work-security-namespace_free-7aaf89b5b00e

--=20
paul-moore.com
