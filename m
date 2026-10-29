Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793308009;
	b=NdN0sKMAEwyE1Ef56aqwIeLvNjrjmZTW8UtJ4j6ZJf23NWlQZzbVrhVJmNxfM5ZL9s83
	 FOHFH1ivSKFxxeEX8SOFmdcRZ9pBQvTv7R0nOa/BYsX4lDmufVjaCvucbslycmlR5VcqA
	 mBzU+NSuuEFuplKNPX2DnphKQ0PeZAzBWatt/46NiYFQFj1bZKMruAAgsHpkYt4r9e3Yz
	 7ZpAkKlbi8+5t5E9cM+11EWs76rr5BnY+HklAqLpojXVDywRJdwaDaCwvGM4o1OOuYQzk
	 XJSz7g/6Oe9jTjllcpOESgom+MvlMudMbS9fxxeDnOzRkmlmoXHR2RiPe1F91MSDVbg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793308009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=RvNRAljflILBTk2xcHt7L4MtTrvHvbzoZJJKtwFYnHk=;
	b=B5wGGrQ4kZqS5mQ8I9bAavuHgMdzMmOVrJl/LZmobWx0CuXbXrLDHdEsdKExOjflWavi
	 k2Pki+yK/2FShjiHMB2dbRa54SYYeOdQQ9CCp3uCNoNUEyuuL50CBam4X5XgRtY3NSWav
	 4Fsps4IfJhiyTgTxoKQs4k8ptVDfPuYFcFrvwC8KoZr46R3TTym0tNVM18cVWOjyDxmm/
	 w2EgsACea7/R1nTUlhFU2SZ5V1vcaEkWm6ToabE0dZWC5XA7otx3fKri8BGZGd6u+DzKe
	 YWNXn8coY1EOgZIqhG6bh0/dbgLg7it04K3iaxrZ900j1Zbf+25JeerDBSvw1jm4qbQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=SUMWHyeo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972F5606A31D
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 21:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 972F5606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=SUMWHyeo
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a06b44bd01so1498341b3a.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 14:06:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793308003; cv=none;
        d=google.com; s=arc-20260327;
        b=EPbe+CK+m9DvBZWYHWeN+l7YpZ4xtj+GtDx6nmgMKbhCAwvHxdSX5rkBdypF0MaBlF
         A5TPnRe3dWQzVUBexVEN+bLzpzIyEmLslHlEPORGlN6JA3N+Hjz8CdrGPyvsiIqjG7pS
         cj+9yZ1UQOgOiVigjwyBpU3+VojA9CDh4ASxA8IdJygroRWzoPen1tqEdcHtrMdvWOW3
         IKI2XMx0VPXybUILmlR6JavrYB5f3Sbo1axU9lI79fk7baKasb9R46tgLcXFq6ekKijM
         mHCvylC+OJKpyt5bCC2PuiN4MyGhoZdQCOMHfZjO1NQVPw+wbuOE9ijS5v/KpmQpzkTT
         I5Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RvNRAljflILBTk2xcHt7L4MtTrvHvbzoZJJKtwFYnHk=;
        fh=Rm0MI9QIEuGkDHR4PO1iAf5k062FKhuiSdhnaBKStkg=;
        b=SHUewt24Ny8QYkA5scUPdHehVDRo+dXVwFEEPOalHYGpTtGtV6XALRkScV/SZY/dmk
         l2LOwfHyaBBu6K3goVsPHlMHY22febesba1Di/dSbbTn1STQahJHdVtoo4mnCNcY9JId
         I3wKK/UVl4BJp/YE2jNQkPhTvF+YptRAdlNMZwCkJ/I3JtmwSVKwvuAmIzw09ToEmhXU
         XqWGmDy3oh5X3pbo7QurvVqmOMklBzLrvAKejt3pcWL1nb3UzR4ChCiPgyjixQhI9RRy
         4ip+m+NvE/OqbBOGOrMgK5YP2MmOsFm7N++HqkCnDOe7UQv6YvJk6WwevJHS5sxLFPyG
         rFvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793308003; x=1793912803; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RvNRAljflILBTk2xcHt7L4MtTrvHvbzoZJJKtwFYnHk=;
        b=SUMWHyeoy05LlaPkkQo68Lctqx8jCJMBTP5h1s5JBg1inkctrhBizK7c4vICrVd4ST
         tFgaTBblbt25voa4mPfQrBUwVI2YrctmrtYJ63fqjqiCjZArQrKO4OKXUqCQLnZIerKB
         9+pJORukUAKGMBg8JR8BdJgf1joFHY09BQARFm1AoO9N4jDb/hxCp5cBEDF6KEs4eZLA
         s5zDXJAWJfqzLNKMabhR+qdErWq+anDkdWSt4GGzkvx7RJRsY7B9xG6OwOuuiyrfA07o
         SZGBXLg0jYjyyW/ttddurHjHLMVw89R1WFqxnex86aQjNutVESFg8w7ztk95DE/2a0uq
         MykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793308003; x=1793912803;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RvNRAljflILBTk2xcHt7L4MtTrvHvbzoZJJKtwFYnHk=;
        b=DoHpiPbOG2x6eRR6DEwgfmnXDJNSvX20mfq9Vx0Avybo8HrgHA9Ps6EMU7ovGsQusM
         HTgtdMDoAmpJPXTo/qlUc2Ok8ovEL8F0fg/8bioQvKQHkeZBlCDh87TyJKaqlR0BVulh
         iD3yT370O7ZWXOJgPsErkuLU99SWe4e/bSKyjW58HwrtrgkJXCj+nfvQYa4aQI2pimds
         OZ3DxSkOhpG+FvDxYdpuUCh89AwpGfQMQCkNYZiC54AqP0fxdr/r95s9Su4Mrg4bgV59
         Eblk2OZ8YBGqCe9Olv2vNDVDz7aCQBN/YDeK2MFbSoZohHo1YrptG1D3kXpYf6FxKBGe
         lgNQ==
X-Forwarded-Encrypted: i=1; AKwUvBzx7tD4FhEwlOOxugvR2aQu7KWS0fJND5jlKUZWTSD4U3MR7wbYAnURTy+3zds8frbnwKO0vvs=@vger.kernel.org
X-Gm-Message-State: AFq9FYL9PmZJbRy/zVYjj4yAUPQUoGInDMPbQt7xfdd6YH2phMlYsGJ3
	YLMIzwBwm9m4wsxhMDDbP2tf3D8hnN9HK2J+Wy8ooUHoX8hgjNYsJlHEmU7/5u3X/aEv0y+Txty
	SXkuzxTDEtH60rshzew16P38ZcHz7qxndDbxm/ulZ5U7V4vMGwFJ8pDoX
X-Gm-Gg: AYBFou2fp9LFz5mmkmZrKICXaM9/N0kCl9TenlNNovfrBUBnVBSU+bDsRiocxSyTpPH
	0120Gqqq9YktRStFDeFMVVpNmCakP1yoMHAX9qA9HrkF6XOvae8YkzlrlgRcDeKqgk4PHokZ5VJ
	OLmnt78S3c8VumsU9xHpsFbohdYR2g0mX3km7vLgBz2j1pwAr7oSAQi7H+n4I/FS7Atbdy2dQJx
	WAPidY5gdSBwRcEn2v+Sg0H4rsUmBlFcNc2GcDdqqst9WEI6snWlNU+y0rPBQgPtuL6iJU7IVmp
	KFpPNxUVif1VLNZpZkYXYyJcQ8JTcBaTzmNc84HS6Df7502jVKREVvLANs39Tbh2ZiRsXPtM5oz
	7PoDQFwJVxrPCGYxbbhIXKnbXmpiz5wthlU6btusX5nWHivfkhgIgzoL0ioTgQEEGOui/gs6GYX
	PyD99/bNSIQDZktw==
X-Received: by 2002:a05:6a00:1491:b0:8a0:5d6f:8a9d with SMTP id
 d2e1a72fcca58-8a9bcc0e982mr298168b3a.35.1793308002978; Thu, 29 Oct 2026
 14:06:42 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029-work-security-namespace_free-v2-0-65591dbba7b3@kernel.org>
In-Reply-To: <20261029-work-security-namespace_free-v2-0-65591dbba7b3@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 29 Oct 2026 17:06:30 -0400
X-Gm-Features: AclHuK_BZX5V0V1r5inK-ll44mPJ2Gl9ZXGK3V5AGh6lbgKe2qd3dfFfw4B3CLM
Message-ID: <CAHC9VhRwD1c1qKK4=Uc8cbMy27iF722C0DZeXy4WGtH-kOBOcQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] ns: fixes for the namespace LSM hooks
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, netdev@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 12:41=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
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
> Landlock now logs that id instead of zero when it denies the creation of
> a namespace.
>
> I'd want to get the whole series into v7.4 since the hooks are new this
> cycle. Otherwise v7.4 is the only release where namespace_init sees a
> zero id and where Landlock logs zero for a denied namespace creation.
> The systemd change I have for this uses the namespace_free hook whenever
> the kernel has it. On a kernel with the hook but without the first fix
> it would never learn about dead user namespaces.

I'm renewing my comments from the v1 patchset (see the link Christian
provided below) about the LSM framework changes being appropriate for
Linux v7.5, not Linux v7.4.  It is clear that the BPF LSM use case was
not tested prior to the merge window so BPF LSM support for these new
LSM hooks should be deferred to Linux v7.5, allowing for proper
testing.

Disabling the BPF LSM support for these new hooks can easily be done
by adding them to the bpf_lsm_disabled_hooks list in the BPF LSM for
Linux v7.4, and removed in Linux v7.5 when the LSM hooks have been
changed in a way that is deemed suitable for all LSMs.  The
bpf_lsm_disabled_hooks change would be substantially smaller than this
patchset and would be fully contained within the BPF LSM.

As a reminder, the LSM hooks and their callbacks are not part of the
kernel's stable API and are subject to change between kernel releases.
LSMs that wish to provide a stable API need to provide an abstraction
between the LSM hooks/callbacks and their API; the LSM framework is
not responsible for ensuring individual LSM API stability.

> - Link to v1: https://patch.msgid.link/20261026-work-security-namespace_f=
ree-v1-0-ffa3ebbf71bd@kernel.org

--=20
paul-moore.com
