Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519973D8107
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 12:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788179857; cv=none; b=JGJrLDXy8jX82L15yD+Tx4XxVfxm0+Bsg+YwNskTB+ZqDzl0B0SOrdBXySHNcs/N6+XX6nBln+H5abnEKuT/KME1mnFBz0i26MR/H6BF0lJd1zxB/+/VXut1Ze7nWgl8z3DSr7sfnr36I3iGTLGx0ZoeHtRgxrw/0xoulDDkga8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788179857; c=relaxed/simple;
	bh=/CD1S0tF75VV8Pt22jOV3o6nDewczq6yzpsKNLL2F8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gaGw6jomr9Lm4EPuOMe3j7+FYkevtKv96sZmyNWXVdyQkDsb6yDsuWiKcLUaWp/ZCGVKhO2f4uMGOSBmRTvqaIyfcLSODTNGFZHgnArbFbIG7IOqoCOa3wcGYylKWGtbSWTaT6q6lFpmAFUYqrEz7WcA2oa6t7EFCOSUTlpPzqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObTTcWzK; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObTTcWzK"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso27672795e9.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 05:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788179853; x=1788784653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ldCU727hj6i4HvipMvvooQ4fYosNMSgvpRhElZfgoAI=;
        b=ObTTcWzKSGzrNSQmsqdyt4qJE9+FFa5SNljA1lzc6iInBJ89B8355lGqicWZXB/RuY
         XC/DUuZdIxrN0OUS/WxPlASfNzTB8hdorZe3MsG0lPyJyied2swxOr1NCbTbhBz1IuQV
         A9DdQUOM/p2hXrluHcd0RUjSQ+GeZ4dvEXKyBYGohBZc1RZmCkmOfOTjTOZkzujEXaHs
         eCMDVGP5lI9c/XBsvRYHp6EyPLQHfU64yufH3ef6HhxcOi29Y8cbdsGcX+bmHfTO4wfC
         IqN+qWUypkDAn2T41/x2GwNFfbGvLdmdZJ6jP80azpO74pdUYSzL22yLHvvlW55W5IEF
         qsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788179853; x=1788784653;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ldCU727hj6i4HvipMvvooQ4fYosNMSgvpRhElZfgoAI=;
        b=oh8APNuwVEoCePIxIbk8HdGJ/tJTU4rxM1gSYwfYRapoOmNH1RS0iMjfcHQRiO8k6Y
         ODMCI64YfgJRPnVUvItn7WlJoZ0koT8EhMzhz+eMHexBczPbdHiZTIuECPFqavNT4CVY
         j8aoMeu+yeuACGlaj4vFallun/81Rwyy5c1CdqbYGTvwgWVawmQHtxlbkNjd/VZIh1a+
         ZNzg+foiEhfLT8JqzcUneuUR8zkTaMCUYHs6sC5YjP5HNUNXmstapZstjJqUJwdpcPIb
         Dh6+8SVmrnziMSz348M90SgzAaTi6kGXeekKbDmDsFNppEYgLUODO+mar07k0wjTXFZu
         6Q2Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp2SQnKJ5GHf4og8njMLiviglpL/z2l2/cSEVFCU4BL9G6p9mYGpSG/kW32Ubk1X5lDLDdUeVk=@vger.kernel.org
X-Gm-Message-State: AFuF++m/hh1Y1Vb5bbEj3EevxBDibSL3oMmL9ogEeC8ed81SK3nPwsK8
	EWO9n1WZ2i558poZaMLPMKXP8d1hLJs3RRA82Iq+gQX9ZIlwwjHhvtBc
X-Gm-Gg: AR+sD12NWGBnDPzWWyNSrNT6LLslvIx9KU/AFHDx9cyuaIFE+jHI63pyk7I3axVzZGh
	CoscPRtPh70wx2IzTmKUi+276suJBJ9t/pQXUbeZvpWymOxjkXozhr7eHfJ7wNCngfJ5ezTQEZC
	58Zhhsbq6j2Vj8W0VbzkdfmputgwuKF1+Cn0DMXjYOUnlC3AAHvxsHWmnTCEHzjq///kpklwhvO
	Z9H8wRPQ1VXGlrYdtbqEAXngidsqfu79tMsNs5SVXkN5yPzvLmBv1ru+S5yzOzMd4n1FuALaDSg
	G0TiZKTU5677AofatVrb59YyPgU++ddhOlGPGAfVZRjvv7nocm2GnudrF+NzjCFO7JVa/NXJ8aW
	u/SeO2TQKYnTQhJxtmne6DDYhpR1x3QleFu16S1wutgoWumpb3O190dk6gS4zJBVqF4R1dRvt+V
	7llLQx4/5vED4iTn1AaK9oCdMbUsdTQCyb9NFZJxJ30V/HHpTPn4PRj18ZrEU4iJDXArcW
X-Received: by 2002:a05:600c:1d02:b0:49b:e22:4ee4 with SMTP id 5b1f17b1804b1-49cd538b513mr145172565e9.4.1788179853332;
        Mon, 31 Aug 2026 05:37:33 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b4942298fsm383050235e9.1.2026.08.31.05.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 05:37:32 -0700 (PDT)
Date: Mon, 31 Aug 2026 12:48:13 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
	kpsingh@kernel.org, matt@bobrowski.net, john.fastabend@gmail.com,
	brauner@kernel.org, paul@paul-moore.com,
	torvalds@linux-foundation.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, martin.lau@kernel.org, yonghong.song@linux.dev,
	mason@kernel.org, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next 1/7] bpf: Allow BPF LSM programs to attach to
 more hooks
Message-ID: <apV4DddDiWqLyldA@mail.gmail.com>
References: <20260831110934.241898-2-a.s.protopopov@gmail.com>
 <32309c5bdc0ed0566f6c7f8d133b4cbf781236c0d4fa76bdd43d0805224f89eb@mail.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32309c5bdc0ed0566f6c7f8d133b4cbf781236c0d4fa76bdd43d0805224f89eb@mail.kernel.org>

On 26/08/31 11:50AM, bot+bpf-ci@kernel.org wrote:
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 460cb72688450..d01dd1f096fc1 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5035,6 +5035,7 @@ L:	bpf@vger.kernel.org
> >  S:	Maintained
> >  F:	Documentation/bpf/prog_lsm.rst
> >  F:	include/linux/bpf_lsm.h
> > +F:	include/linux/bpf_lsm_hook_defs.h
> >  F:	kernel/bpf/bpf_lsm.c
> >  F:	kernel/bpf/bpf_lsm_proto.c
> >  F:	kernel/trace/bpf_trace.c
> 
> [ ... ]
> 
> > diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> > index dda272d78f013..1e54c7cca27ad 100644
> > --- a/include/linux/bpf_lsm.h
> > +++ b/include/linux/bpf_lsm.h
> > @@ -16,9 +16,19 @@
> >
> >  extern bool bpf_lsm_initialized __ro_after_init;
> >
> > +/*
> > + * Technically, checking bpf_lsm_initialized is not necessary.
> > + * But if it is off, then this means that all security_* calls
> > + * do not call BPF, and it doesn't look reasonable to enable
> > + * only "non-LSM" bpf hooks...
> > + */
> > +#define bpf_lsm_hook(NAME, ...) \
> > +	(bpf_lsm_initialized ? bpf_lsm_##NAME(__VA_ARGS__) : 0)
> 
> Does the new bpf_lsm_hook() macro constrain what hook declarations
> can appear in bpf_lsm_hook_defs.h? The macro hardcodes 0 as the return
> value in two places:
> 
> 1. When bpf_lsm_initialized is false, the ternary returns 0, but when
>    it is true with no program attached, the __weak nop returns the hook's
>    declared DEFAULT. This means LSM_HOOK(int, 0, ...) behaves consistently,
>    but LSM_HOOK(int, -EOPNOTSUPP, ...) would return different values
>    depending on whether 'bpf' appears in lsm= - 0 before initialization,
>    -EOPNOTSUPP after.
> 
> 2. Because of the ternary, LSM_HOOK(void, ...) cannot compile at call
>    sites, since the expression `cond ? void_expr : 0` is invalid.
> 
> 3. The CONFIG_BPF_LSM=n stub at line 128:
> 
>    #define bpf_lsm_hook(NAME, ...) 0
> 
>    discards its arguments entirely, so call-site argument checking only
>    happens on =y builds. Does this create a risk that =n configurations
>    would fail to catch type mismatches or side-effect issues?

Yes, it does (intentionally). For new hooks, which aim to be attach
points for BPF programs, there is no real reason to return anything,
but 0 or error. If they are called from a funciton returning a pointer,
the calling funciton should covert the return value appropriately.
(Also, new void hooks do not make sense.)

> >  #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
> >  	RET bpf_lsm_##NAME(__VA_ARGS__);
> >  #include <linux/lsm_hook_defs.h>
> > +#include <linux/bpf_lsm_hook_defs.h>
> >  #undef LSM_HOOK
> 
> [ ... ]
> 
> > diff --git a/include/linux/bpf_lsm_hook_defs.h b/include/linux/bpf_lsm_hook_defs.h
> > new file mode 100644
> > index 0000000000000..29bc0b514d168
> > --- /dev/null
> > +++ b/include/linux/bpf_lsm_hook_defs.h
> > @@ -0,0 +1,6 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +/*
> > + * This is a set of BPF LSM hooks, which are _not_ fully implemented
> > + * as LSM hooks. Thus, they only can be used by BPF LSM programs.
> > + */
> > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > index 82c5988417a0c..add344ea26914 100644
> > --- a/kernel/bpf/bpf_lsm.c
> > +++ b/kernel/bpf/bpf_lsm.c
> > @@ -28,11 +28,13 @@ __weak noinline RET bpf_lsm_##NAME(__VA_ARGS__)	\
> >  }
> >
> >  #include <linux/lsm_hook_defs.h>
> > +#include <linux/bpf_lsm_hook_defs.h>
> >  #undef LSM_HOOK
> >
> >  #define LSM_HOOK(RET, DEFAULT, NAME, ...) BTF_ID(func, bpf_lsm_##NAME)
> >  BTF_SET_START(bpf_lsm_hooks)
> >  #include <linux/lsm_hook_defs.h>
> > +#include <linux/bpf_lsm_hook_defs.h>
> >  #undef LSM_HOOK
> >  BTF_SET_END(bpf_lsm_hooks)
> 
> The patch adds bpf_lsm_hook_defs.h to three of the four BPF-owned
> LSM_HOOK expansion sites, but not the fourth. Does this need updating?
> 
> Updated:
>   include/linux/bpf_lsm.h (prototypes, lines 30-31)
>   kernel/bpf/bpf_lsm.c (__weak nop definitions, lines 30-31)
>   kernel/bpf/bpf_lsm.c (bpf_lsm_hooks BTF set, lines 36-37)
> 
> Not updated:
>   kernel/bpf/bpf_lsm.c (void_lsm_hooks BTF set, further down in the file)
> 
> The void_lsm_hooks set is consumed by bpf_lsm_hook_returns_errno() in
> bpf_lsm.c, which feeds cgroup_lsm_atype[i].returns_errno. If a hook
> declared as LSM_HOOK(void, ...) appeared in the new header, wouldn't it
> be omitted from void_lsm_hooks and incorrectly reported as errno-returning?
> 
> This is latent today because the four hooks added later in the series all
> return int, but is there a reason the fourth site shouldn't include the
> new header, or should the header document that it only supports int hooks?

Yes, there is no intent to add new void hooks.

> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33386073074

