Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0468D394798
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 19:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788377522; cv=pass; b=d8qVWRLLMqg+r9X3kiHhUNvRByDQ91LXVyb3Xb38a3BHzgVAS2r/jENnpZK7rUvQtR0Taz8HWret2Bi7iWFj4d20RodHTlEx0TCI1z2h1T0/JvevFHt2tuviQgIw7hQ3V0s0HuBx1rYhPEn0cLu1Od1BVgzavhTfAtdZ3hYJxIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788377522; c=relaxed/simple;
	bh=zzjKGij2xv9IwtzyPmqyOdFHZLosR5uzYe7NgB5WR5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hnh1qQGM/VtNMvc5a9qvePEDsGv2Dp6Y6UvCKS2+8YlDi29aCh9g+j+kYWqJ/RDLmlGJrAEieKEm9/RDfIyEK1L4xnqoAwqT7dXzL1m0PgK784nYgufUvZ/r+rZF6eFIzH7ahb3TUZU52VuXI+DdhIJehqQGoQBE0VOxhuoTUAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DcO2qkaa; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcO2qkaa"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-865bdc6ed72so27027297b3.2
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 12:31:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788377509; cv=none;
        d=google.com; s=arc-20260327;
        b=V4YmjbaZx94qo9s/GqJfskO3BFrO7DnywK/oHgf+RxDkjs5koj0p0k6ED0tJIpicH2
         Jcgw5dyCv5FkC3wzwaj1j2np6IHMDBRWD06d7lHHxRzm687a9TT/HAkGA/JG4FPRftX/
         sTLXSscyiFCepFNwzJcX5CRNJ0vpjT9PT68xObeMybs8CQE3Ll5YpqN2xwlEdwDQkny5
         5YAwDPsKt6d7SDt1C9TPfbQg/i+ovRMLf/W/PbQpXhSpWsdGoUYd6zn2tdOqpstDU+qC
         ZVUVAxwj8dv2Nf6XIQRvOugtfMloHgtJCrFaigzA/hpOqExGVBAhA50l0j+14f4QMcoe
         0oOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4xB9mu0NfOZSjIYdWgzuHULYbUQ75NlZHyzkoQqQjp0=;
        fh=8tm3KgvhXbPlTEXUCaGweCk6OfqVy4M8uHtGtmRdGgY=;
        b=k3tDcIjeJuubSCMopIoBASa1dhrldlyKcBdRZEplKOUJtrLMr8ikOoPZYfVvDVaBCd
         9PyQPThBaIqOSrXu5PPzPd1KkTXlPYmn1USXSj6UawQQDpoDdzZDee/Om7GyHqmHFTR/
         PXqSIELapRoMo82cDz8Djrr1unM/k6jyJPA5rfFBSQpzFzfm9VyZJlzBM+2k3YvFm6s7
         tkTX3bJ30HZFUjfIeU+xGjI0JtYMnfndEKL/qo1jXxZlYCnLlbwQK3mBpLdLi912JNhX
         Gw8v1QmU5VY+6cLXAR8xeOr7lacR/W3kQbS7CcP52cytFRaYfSNvQQIgRX87KJch/B0i
         wYew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788377509; x=1788982309; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4xB9mu0NfOZSjIYdWgzuHULYbUQ75NlZHyzkoQqQjp0=;
        b=DcO2qkaaBXedEGfgIDl640T7TUGQpfBI0bwk3Wm3h1pK95XzF8ohcf5fi8xyh8vU51
         R/pNmsRDVBG1rN/OjgqkN9qQgzUFV+QU+Qa/t0++RD/wEHji62+/3GoAfWXzw0gV6WuM
         Xpvn2U8BVF/xK/94xntkvljMd6fpWBCcxeG1xnkmq6Q7ElqHfgq46f5czvPzFSwKheit
         VXYCneDkWeZORbud5Wjr9p1r0dqh7nIFO809NCVxh+SOHMKZlE77dVd/4HbMO0ue1FBe
         0sGFD5v6qvpxde73ixUPI9R1lPUy/myC13Moruz5OHXUcHxOg2fRZjWsD1/BLkKqa4rj
         9keg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788377509; x=1788982309;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4xB9mu0NfOZSjIYdWgzuHULYbUQ75NlZHyzkoQqQjp0=;
        b=f2t5XlC0DTPDmgnBOX39yOhHTWVLABW/81a5JIqOYAqwQ0L5s4NEUehDI4Aexzb40/
         sCt1cnsxv8xNumFs44BcAq7Doh/L3mmI2i3E+EFIoU4AMKF1yMwlLnWye1JSExfqLTGD
         ZI2PDGOEdcmR53fyaUswlyaenz3LFzP5CRLMlCNhxerOsp0meiO8/gWCJnhkFWH126S8
         +tH+C6ukSfTRQUWlOgOEKP3lChdD0CZsp7aA2CtyeOGE27DiazU1v9v4FIKiSZ+BqUgF
         b1REAV767NF3fh0isXE6hFgp6T4NOiNtSEAm09fg23sN00PFiPQMitLpXh9PN3yKGbb5
         SIPA==
X-Forwarded-Encrypted: i=1; AKwUvBzjQSSu6keSkUesJ7ybqlgBQlAhq9rtCyyM9SuO2Qc4aLQmo8vo70qaXX97W9sV7jk64evgCqg=@vger.kernel.org
X-Gm-Message-State: AFuF++lTHWUEU9zJc0aA8fSrQhMA1wsdiSPMl7LGL0+dRLEyn6eqHPDd
	sLtEueHyMR8k1fVQ7afsfLDKJOmAZywOlPg3AqxnsPczBlLjRlHxHG9aE937eaklwudn54Cr72l
	PHjNpUVOWEtOKzB/St5ij2mPy5iZqG4M=
X-Gm-Gg: AYBFou31GbdeRYU6XmL+X9iRFzMdPA74CLbB9e4x+NLA9VWN84FxKiklJpFdOKDlG8N
	cwQqyI6Jx1FMDqWzQGLJ+lB3U/miFkrkpsSJqYvSTlIEkc+jjhsjWd02f1D8pFHqGiB2dVD5jBJ
	x/8U6EMhMwv4jfOLjBtH/Izvnon3O7pB2o3Zo/j/clZZEXP4iCLiNkO5B/e6ACBY0BkoLarPTiY
	GSvTq6rbDewBtSCgQameL2uuzwQftSOCfNw8Hj2zEl/TDHYM9bvRbDhQjwtkIReP9AT2j/leakX
	LAQ/1whvcT5ecngQf8zmVnUAnlVsRCDPmBzpNGdA1z+RAyK1DPMjcmsjzliA+nb740Cr11HgUQ=
	=
X-Received: by 2002:a05:690c:c512:b0:864:6fab:adff with SMTP id
 00721157ae682-86c509d9cd2mr39132517b3.14.1788377508601; Wed, 02 Sep 2026
 12:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831110934.241898-1-a.s.protopopov@gmail.com> <DL514LM5TA6V.IOW7P2WM70BE@gmail.com>
In-Reply-To: <DL514LM5TA6V.IOW7P2WM70BE@gmail.com>
From: Anton Protopopov <a.s.protopopov@gmail.com>
Date: Wed, 2 Sep 2026 21:31:36 +0200
X-Gm-Features: AcwNN1V2Rt775pi-2pC2GM4FeyRGEHYTzRhtRvIQQntbTC-IwI8Yk3niV4K0Pwc
Message-ID: <CAGn_itxwZcMLtass5fZQ5XqgUtwTaJHfUGxg_SK7h_vqEgpmeA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/7] Add new way to add BPF LSM hooks
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, lsm <linux-security-module@vger.kernel.org>, 
	netdev <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <matt@bobrowski.net>, John Fastabend <john.fastabend@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 8:07=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Mon Aug 31, 2026 at 4:09 AM PDT, Anton Protopopov wrote:
> > The BPF LSM programs are allowed to attach to LSM hooks. This enables
> > operators to mitigate known bugs without a need to reboot or livepatch
> > machines.  BPF has shown very useful to create such runtime policies.
> > However, many APIs and parts of kernel aren't covered by existing LSM
> > hooks and this would be beneficial to extend the coverage.
> >
> > To simplify the process of adding new hooks this patch series enables
> > BPF to attach policy programs to hooks defined outside of the
> > official LSM list.
> >
> > One of the reasons to add a new mechanism is that in order to add a
> > new LSM hook an implementation, at least one in-kernel LSM must be
> > added, such as SELinux or AppArmor, and BPF is specifically not
> > considered as a reference implementation [1].  This is, however, not
> > feasible for the use cases and capabilities covered by BPF LSMs,
> > which are not directly comparable to those of traditional LSMs.
>
> This is no go.
> bpf-lsm can attach to lsm hooks, but the machinery has nothing to
> do with LSM. bpf-lsm is exactly the same as bpf-mod-ret.
> So calling everything LSM is actively misleading and wrong.
> Patch 1 starts this misleading naming convention
> and then later patches add fake LSM hooks. Sorry, but no.

Got it, thank you.

>
> pw-bot: cr
