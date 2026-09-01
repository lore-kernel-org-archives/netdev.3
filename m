Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE35477E22
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 22:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788300966; cv=pass; b=cpRBHfv1n4My3WS11xsF12zfKYTzHkaqMi//ZaLPz2gjWJvhHuibqdFoy/2NoFEDqRsWOtx6tQGGED1X8+pAiv7r5iwwYceEONrqtjmauYqXCrnYqJRuA1ryYMSEApLVAXTWFNEVk1f2VB9DTTKjX3pTmi+UZ1JHBdv99tAN5WY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788300966; c=relaxed/simple;
	bh=mKdTmKx+z6mwUGqcorW8iH+bPrZTGVyvSXc8efMHImI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZMvLpGoAOqjlBNetcsIJkleFfmj9rltjgds6aGmpUGIwdk24i2uRjKTPSR/DOPPM9071ZySITUNpZGWR2tnd4pme5mg23WK2cS1pqH1YBTHhtpAzbN4AEkfJytqOkjpG1Rp5Y8fCZmMFiYoOzcu7Z9mEOn9vZ57Bkn+P0lmeMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=U/xYvDeG; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="U/xYvDeG"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ce98cb8165so3838285ad.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 15:16:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788300962; cv=none;
        d=google.com; s=arc-20260327;
        b=jfpMr3uG0Y3bOOK8YVARkEvPdBMq/eaQaQEcG6reXbPjFc1f025Cl3Kd36wFl74FD5
         0hs43bDWGynanWKBOV7gLGieAc1lC7V7qxsuT6k0wFdojYyCX3KRWzfvhskF3Ns+NSlA
         ePbuLN0sUXMfOC/Qn4VWns7SkHatuVtUTqRAojtWBycUzYCRzZPlJh9ckLwD6PBDZ5dV
         WYMfAp/8Qv7TvM6pho6Xep66kIS5LF7CKgIq0i5ZT9LVAkUzp5op2wMyvxeNBQBF/X/n
         nxlcaSpgO4xCAQ+/3R5aN+Mw4WztU4N66dsx01Qu7DztCrgxChZv6D4ttMHqf0cgWaeV
         DyhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1ATcm8apudD2vfrozzvIh0C6UKnA5qihRpZDqTJ19B8=;
        fh=mVYYtUxxFP/axHEWcXmraCzlAp0PweO100t5/CaZwOU=;
        b=oD8g/0I9AivBRBR4toHpVHm4JVNRnSFKnHBbMJgTZL4XLyQUbV5jWFHAJaRWk1FY3S
         ryyBOhVDLygthp2mROeoQOayJTJb8M6OHx7S7wSS+soYGV4DYxpGj1EksYGoGJjOUq4d
         3bkibiGsHtiMSuL6VJb474cifazBBVOpR6M9lrPSdJtnQnkG/9/Yp9j8hvNVWCNqICe4
         vOXLpNLw+sv3J5pHAXBxMlzKr8QbrnCx78sW0IjJgh2C/WPNZMs3zNSy0r1YQMTKSI+C
         HbWK95/FlT0QU20y2Rw3hgvc7zUOhlhOQUEONgiWMXyoPJKriFYE/Ec3z8Kg9OQEW7UM
         9ZHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788300961; x=1788905761; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1ATcm8apudD2vfrozzvIh0C6UKnA5qihRpZDqTJ19B8=;
        b=U/xYvDeGT6BOzcGUhRc2UUcirPbM8RPucIGKqZ3a/ZpqEZ1MKA3ovazMtVm3RwcB1b
         y8aFxmY9C/qgnbn/N+chRw17ewttaBcJ/loPXJfC1n17+z+VOszKANcPHrLUzSbqR1z/
         o45gnRFFAGOmrO+V03fQm5PwJ85b0pxG/4heY5jjtS+RwijyQ986sdWlaikFcVQhVPtn
         gDxnT6iqNAjZo5jMFqkRtTuSsLAOWHHsxd4tBVaKKqOtf8+Gj14ugSHemiWMqnvrPn0y
         Qk1Vs6BwlgviYEWzW/1entbhBh/9pFihvtcHoWa3G2XW4xskAjLM0lQGnRiXOO+SLD/U
         FUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788300962; x=1788905762;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1ATcm8apudD2vfrozzvIh0C6UKnA5qihRpZDqTJ19B8=;
        b=D4llwXZmjWmDcVvDy9rjHPdocc6m6QN2VwpKu4H2DuYHIGkSiLphQCIoJM8K8uf0OP
         x8xTUSuAXaS6YZczvuzYcD99y7Ad/0jFFCX9DZNC6iATFT+QrCR3joF0xnnFPwEgbHq7
         9Lx+XbSI1nuEtsX0pSI0gYJ+k8OEJdSNmulqtDOvNjsfp3aHhb8cj2liMqMvhtPJPKI8
         BIoKpjF8GP/j8OwtECsBkoYv5PxTeqASOBd8wFSMzbjePVN3n23jBlaT2/3erx6CsKp3
         fouFAT3LqnotM/tzcae+d2gJ0HiVI/D5utLPPq9shs+a/5wReYbFIOkC6w1VSmBzMsZJ
         Dt+Q==
X-Forwarded-Encrypted: i=1; AKwUvBx/a9LgZgp58z/rOZWS4HTxtdGlJmTncerA0Dk4ENgJeKqNTlj2GHZUxN5zqRtYP4K7p5o7z90=@vger.kernel.org
X-Gm-Message-State: AFuF++n2eaGO4edhnLvXTa6U05ZKpffos5u0Y6jVIlA+Vlsy/VH840TR
	M8+7aZgKGqoijQOrYP7+wrq72afZYsoUB0rsNCZkE6TB152KXFogaIyfFGQkUc4/D+yDIeauXLa
	DE7RRwl695z37bkZ2iOjlYWcmvnLThn/vdU0cKb4b
X-Gm-Gg: AYBFou0bKR3adRt8YJM/7VJ13NYwiBRzvtznRKZAJFkM1SfWCRNxrbJrYhgj009KHfl
	R4yvJwTv3mGCJIg1JbISqe41WrUicBQOO9xGrdMqpi1ProqaZhTD3kVp6qvLslx/q90HHP/3clH
	CtYkEUsIXpJ3+9ajU5SVpBPObSw0gHoyHHzcgdu3OcRP+rhSWsw0LhrEfguDViicw4rG64f3x8N
	XsXIMVwCvPW+vywLL+r4jlvSLvgIdU5nyhNPXFriDcjjToOMtAtfLDhTPU3Rq4qLFZQl+faOGD+
	Vnw4y+DZ1X97LmtRZrrWyCeeZVUoISX1+ElrnNW9K2Db
X-Received: by 2002:a17:903:2410:b0:2d9:2b1b:878a with SMTP id
 d9443c01a7336-2d9526c2cdfmr80572575ad.10.1788300961608; Tue, 01 Sep 2026
 15:16:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831110934.241898-1-a.s.protopopov@gmail.com>
 <20260831110934.241898-2-a.s.protopopov@gmail.com> <CAHC9VhT7=wMsB9mERWoiM6pF+_T1=2tyAsSrxMphhtdE2NPHMw@mail.gmail.com>
 <apbU8-fpioNIwUA8@mail.gmail.com>
In-Reply-To: <apbU8-fpioNIwUA8@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 1 Sep 2026 18:15:49 -0400
X-Gm-Features: AcwNN1W7aLRefGcheWJ-uymO40RrLBDpF_-JUw-mmYcnuhgB-KD2OI0728rejLU
Message-ID: <CAHC9VhQbWPqEz5g1rVcMyJgrzzd4cQuwi7cddgJQK1H3ugMz7A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/7] bpf: Allow BPF LSM programs to attach to
 more hooks
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, lsm <linux-security-module@vger.kernel.org>, 
	netdev <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <matt@bobrowski.net>, John Fastabend <john.fastabend@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 9:26=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
> On 26/08/31 06:42PM, Paul Moore wrote:
> > On Mon, Aug 31, 2026 at 6:59=E2=80=AFAM Anton Protopopov
> > <a.s.protopopov@gmail.com> wrote:
> > >
> > > The BPF LSM programs are allowed to attach to LSM hooks, all of which
> > > are defined in the <lsm_hook_defs.h> header file.  From BPF's point
> > > of view the set of attachment points is defined in the bpf_lsm_hooks
> > > BTF set. By analogy with existing code, add a new header file
> > > <bpf_lsm_hook_defs.h> which will also be included in the bpf_lsm_hook=
s
> > > BTF set.
> > >
> > > This change allows attaching BPF LSM programs to more functions.
> > > The actual hooks are added in subsequent commits.
> > >
> > > Each BPF hook calls a [__weak] noinline function each time a hook is
> > > reached. This may be too expensive for hot paths if a BPF program is
> > > not attached. A future commit will optimize this by adding a per-hook
> > > static key and inc/dec it on attach/detach. This way disabled hooks
> > > will be bypassed efficiently.
> > >
> > > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > > ---
> > >  MAINTAINERS                       |  1 +
> > >  include/linux/bpf_lsm.h           | 12 ++++++++++++
> > >  include/linux/bpf_lsm_hook_defs.h |  6 ++++++
> > >  kernel/bpf/bpf_lsm.c              |  2 ++
> > >  4 files changed, 21 insertions(+)
> > >  create mode 100644 include/linux/bpf_lsm_hook_defs.h
> >
> > Adding new BPF hooks in the kernel is one thing, but adding new BPF
> > LSM hooks outside of the LSM framework is likely to be problematic as
> > these new hooks operate disconnected from the LSM framework (callback
> > and LSM kernel object state management).  We've seen bugs in the past
> > caused by the BPF LSM trying to operate independently of the LSM
> > framework, something like this will only make that worse.
>
> Could you please point me to some of the bugs you mention, such that
> I understand exactly what you mean?

The latest that I'm aware of was a few months ago:

https://lore.kernel.org/bpf/20260628201103.3624525-1-mattbobrowski@google.c=
om

> I am not really seeing how the
> real LSM hooks differ from the ones added here (from BPF point of
> view, and the objects it can access via kfuncs/maps).

The existing LSM hooks, LSM security blobs (the 'void *security'
fields present in many kernel objects), and individual LSM callbacks
are managed by the LSM framework whereas the functions you are
proposing are not.  This is important because the LSM framework
enables/disables individual LSMs at boot time which impacts both the
executed LSM callbacks and the security blob allocations.
Implementing "hooks" that operate outside the LSM framework can cause
unexpected user behavior and potentially destabilize the kernel,
leading to a system crash.

We require all LSMs (Landlock, Smack, AppArmor, SELinux, etc.) to go
through the LSM framework, the BPF LSM is no exception to this rule.
If you want to add additional BPF program call sites beyond what the
LSM framework provides, please implement them outside of the BPF LSM;
there is plenty of precendence for that already.

> The main reason (for now) to specifically create a new list of BPF-only L=
SM
> hooks is (pcmoore/lsm.git/tree/README.md):
>
>   """New LSM hooks must demonstrate their usefulness by providing a meani=
ngful
>   implementation for at least one in-kernel LSM.  The goal is to demonstr=
ate the
>   purpose and expected semantics of the hooks.  Out of tree kernel code, =
and pass
>   through implementations, such as the BPF LSM, are not eligible for LSM =
hook
>   reference implementations."""
>
> And for the hooks added in this series
>
>   a) BPF satisfies our needs, as we can precisely analyse what the
>      calls are trying to do with good granularity
>
>   b) I am not sure how to actually express this in any in-tree LSMs
>
> Can't BPF be considered enough to demonstrate usefulness?

The core issue has little to do with BPF, it has everything to do with
in-tree vs out-of-tree code.  The BPF LSM is explicitly mentioned as a
"pass through" because some have argued that the BPF LSM is in-tree,
and while the basic BPF enablement is in-tree, the actual LSM code
that is executed has thus far always been out-of-tree.

--=20
paul-moore.com
