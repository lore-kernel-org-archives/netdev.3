Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3A449EC61
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 12:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788437815; cv=none; b=o3JuT9a1UPPIxrjhYFPNgOLcVy/aeusW0vK7yqoN/RvTVRIoIUsNQ1sekGpLSK92bgUbd2wFaQCdP2/Un5T6xjeQjPCKbwKMPomIgA7hhuLXoSfaB7UMhY74UP3AODW0yoMXy0i9F6HIgG0XC/f+IS57cST+MczqYYb1rhgl6ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788437815; c=relaxed/simple;
	bh=nNkicwNC6wvB/mONAXakrfnhE2JYMGQwTgh42CBx9q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9kcbswX1ZiEzkeRMl9hmAjHPtLUjHYCz5MsP8sII5sMpnbdjOxHHVpi9ezX10Xiitsxvtq4rorjRACfDO8hxylUsstatCqexz6UDBjrb/K+JjuOY1rlrp7Cx36ajqrfWfb+Wogz2E8Mdusaq78h/ZI3DACZv/VrvZmT33LtSzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9GQS6ZC; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9GQS6ZC"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-66cf1f9965dso1712002d50.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 05:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788437813; x=1789042613; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vbJAOVw8uKJwq4n1b45EMvb8ousiK+i/6Hz5ojzhM6E=;
        b=J9GQS6ZCVDRv99cbnUmTsvgeuObPNpTkVOogyq9jcRhWElPNxT50E8jHwSxknG2wff
         fTnsORUDUc9dWWE66FZNPl4G1fhzog/IhlrRGtMq4VH3QLn3AmvX+mZPWcHvMTbDXkCI
         eKySyk+7ZcmYjccfjP6FjyBjn6WPRCvFhIojGdVMQDwOu76hZlCq8fL3V2Yw25yMVnxr
         ZwmhA2sPbpLLCBwcqeyFEkaA6KF0bPcPhUnLUh7WIAo1V6JwrRNBwC7we8KJTdKQwoN2
         pyscE3IqMqNd00EwucXzf3UF6CtMOQVSOPA5rEcAylC1LIDQjo9bdc7W3hnAKnin/Ulr
         qIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788437813; x=1789042613;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vbJAOVw8uKJwq4n1b45EMvb8ousiK+i/6Hz5ojzhM6E=;
        b=qEApRZptgWKoS5Tg3oSYfXQxxkPjtvvHeEh/xeoJFK1eQZLqvH/ICum4t3FedAyINa
         T5pacDekeVdjk/Fd6z/wZJ8ydw+JctmzESwkoyJQPDjxfO0L1oWuQB1Jb+giqOXuqiku
         /FQTTwFKgKStNugbkYdBmVqYai3m8V9whbh2ZGQ53kpCUoDC6zlb9eUNex5NQgoajBTC
         zvqBCvVjjgdAOYjc68k4gyI0yIoQsOj+OXVPh9ox0eOmL7O8wm6ho19Ut4Fn9z+eocSG
         v455B2/bbr07Dw4b2zXFWOFMPWTzOmALb5U4nd8AotJgVoLLNJ4KP//quJqFg/URqyfT
         ogIA==
X-Forwarded-Encrypted: i=1; AKwUvBwqpNnBXDbPZRgBiYJZKs3/zqn1CRlJVknOXZPK9xqbQmdoOzCqNW1TEFwiVkQs35TWCTpx5MQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mRcV38rqTE5ZMg+romhCg++BGOT1uNODgWU8iGeBUkvOoh/S3W
	eLo2zGd8RBK1/S7edLL4C4hZTu06fooIO5jIW3mq5p5eCRHRyl0yJgj1
X-Gm-Gg: AYBFou3/1iXE+P+zXg5uOLVnsgy+D/gDbw/0QvqSTljh0oRoOFgAyk548DkIklq2HnA
	Oygh8ufgpkztWKnEKEf1uqQaHfzW339CXZOjrLOsV23rYhfqvEwz5PRlUGTt7flrjejym/YhOrJ
	KewRglbTqR0iefxrqvG0bkabeicbnxxaCHkTvH1eUbs0QiWmu+gmkNrQhmGRkDc7UUvFr6VGHjL
	YcfgwjjU/1uiH/8kADxknkT5oU6ZugS3x3pNpNxFMkMHY2bKNUC7RlCr9VDJ/t12cxCOYSnGOm8
	eoszA+3bD5iSAsaLHOT7hvlYbu0VyoRp93mHjCx6EPIuEuIvp9S4P5aXU65eYp50Sht57yFkCcw
	LpCBaivxPAmq45i+5RvJj7sJKeI4ISfDeGuK+Sk4uAD+qIW9SocWD8/+XOnDPAbUexJz08808uR
	fofeB4EFekfrdJn862Rrj/nnyEhk+HASXm+RtqPK43WUA23OHb9gKGCOaQnPr1kbAiEECUTPEOw
	7IeV2fpeNK9+BBvBRyfLQ==
X-Received: by 2002:a53:d005:0:b0:66f:8796:a553 with SMTP id 956f58d0204a3-66f9bb61924mr4641633d50.3.1788437812747;
        Thu, 03 Sep 2026 05:16:52 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:b12c:f7a8:92d:b215])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-86c18ac450csm38308717b3.40.2026.09.03.05.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 05:16:52 -0700 (PDT)
Date: Thu, 3 Sep 2026 08:16:51 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	bpf <bpf@vger.kernel.org>, lsm <linux-security-module@vger.kernel.org>, 
	netdev <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <matt@bobrowski.net>, 
	John Fastabend <john.fastabend@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH bpf-next 0/7] Add new way to add BPF LSM hooks
Message-ID: <apljnyb9nNRuN2xg@zenbox>
References: <20260831110934.241898-1-a.s.protopopov@gmail.com>
 <DL514LM5TA6V.IOW7P2WM70BE@gmail.com>
 <CAGn_itxwZcMLtass5fZQ5XqgUtwTaJHfUGxg_SK7h_vqEgpmeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGn_itxwZcMLtass5fZQ5XqgUtwTaJHfUGxg_SK7h_vqEgpmeA@mail.gmail.com>

On Wed, Sep 02, 2026 at 09:31:36PM +0200, Anton Protopopov wrote:
> On Wed, Sep 2, 2026 at 8:07 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Mon Aug 31, 2026 at 4:09 AM PDT, Anton Protopopov wrote:
> > > The BPF LSM programs are allowed to attach to LSM hooks. This enables
> > > operators to mitigate known bugs without a need to reboot or livepatch
> > > machines.  BPF has shown very useful to create such runtime policies.
> > > However, many APIs and parts of kernel aren't covered by existing LSM
> > > hooks and this would be beneficial to extend the coverage.
> > >
> > > To simplify the process of adding new hooks this patch series enables
> > > BPF to attach policy programs to hooks defined outside of the
> > > official LSM list.
> > >
> > > One of the reasons to add a new mechanism is that in order to add a
> > > new LSM hook an implementation, at least one in-kernel LSM must be
> > > added, such as SELinux or AppArmor, and BPF is specifically not
> > > considered as a reference implementation [1].  This is, however, not
> > > feasible for the use cases and capabilities covered by BPF LSMs,
> > > which are not directly comparable to those of traditional LSMs.
> >
> > This is no go.
> > bpf-lsm can attach to lsm hooks, but the machinery has nothing to
> > do with LSM. bpf-lsm is exactly the same as bpf-mod-ret.
> > So calling everything LSM is actively misleading and wrong.
> > Patch 1 starts this misleading naming convention
> > and then later patches add fake LSM hooks. Sorry, but no.
> 
> Got it, thank you.
>

Adding to this, there was the previously proposed "killswitch" mechanism
which may be closer to what you want. [1] Unsure of the current status of
this work, but it's a better idea than creating BPF-only LSM hooks... 

(like a bpf_override_return helper that doesn't care about
ALLOW_ERROR_INJECTION? unsure what would be best here)

Justin

[1] https://lore.kernel.org/all/20260508195749.1885522-1-sashal@kernel.org/


> >
> > pw-bot: cr
> 
