Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A70F4AC156
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 13:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441188; cv=none; b=SqlTqrrMYg7eyLfIPeG58HUZVxtPpBgUN7/En42vg5YJtKlKOTakG6f1E/MXfJhSF6slcHxEZSorEuUPtuKDflEEEkWzFxPYLQc48zV0NkJbtrvEL/KYAxLD7nf8o6cbWFHx3cxc6mpv7hb3gf9eb4r+BJMpUe5OYya2IOUMmGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441188; c=relaxed/simple;
	bh=YfhrJ/RsU4qXyUHZUbgKLATh3vnW+x8pyI+69lFyI1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UudMp4XCE1ce1ZgeGdLK97e+LSx6+UqzskSU9/dunqpVH16ZAx1mPEu9i0oOC65NdRJe+jD/hqBLHXEaYFmt4VaSCc/FcyvjoXnPxHYsHy0YPI4el66IcZ78oHRFYHj4OnsyYdu/NZTiOslp0jr5i9W2tiL2AENkIblZpryvEQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQ/9Nbbl; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQ/9Nbbl"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c160420289bso298851766b.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 06:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788441179; x=1789045979; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F7q5cK/wUKU6kkZjsGx0QcDU5b5co3Eimifh5j77YDE=;
        b=nQ/9Nbbl8weE1toKLcVNPmybDARfVabaN+NcqykJwLqGLsZum0rdVcib+YNZZqYxa4
         AZDA3QjSNCGKqbjse/w82dkwZLVY4Kk6KDihgBhllIQJHSoW0vYYQI0bTz2M/XEtKtii
         tZr8Ldw1WxRtUJmNSK/SEjBXZlj4cIdTvxZkNma1KD8CxZXK7lRQBGP2bV0d80H11pW8
         jhFGpzubdRHAuw6n2mi5YkKXxkg1Yo7kBknUe5LEREFqHbNz3uFmQ5I9EpNmfycsXSaZ
         xECJnAjE5RQShw4ZABqWHaJHdfHqI1ZWAw1NDdbAldl+U0km0N/hYEbpQ27MbPVQIFfv
         NMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788441179; x=1789045979;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=F7q5cK/wUKU6kkZjsGx0QcDU5b5co3Eimifh5j77YDE=;
        b=hyQR+kLK6iHUK1gMBMElpqcQRUrOS/FmCscIPPu0MGH44agA4WK1JMfvxWPHJHB3by
         dN34Ux2KxqlIOkVJbAD3UiVoD+3J/o2lW4g95pfexAtKzOp9duwm5Y5VFetnGvPCHolJ
         TIiAS9uaFmluig3BBno02OxeQOne12qkCuJHm69L48ag0nw10rQdiHNVFTa6+NE8ZXwx
         f1Y5TEoJZ1N+GiqMpYPTY9GfTykql7o70Yng92KqbqFAKfqXK/n1K35wkH6wB3HmUNe2
         USqF7l10cP9WuPhf9+JcT5GoOXOHcRdlu4UxeohIFtMqt0M4M05glsXqoN0uOJLh33Jg
         yeag==
X-Forwarded-Encrypted: i=1; AKwUvBzqXFpIIXI1iPNlbAmz4wO1QLgYQk8gaUJ4Ibg97u9pDiDszcgnaRXKiSjAZgfXFG21HOw/sFs=@vger.kernel.org
X-Gm-Message-State: AFuF++lXVEtJYMOwVwssbYcfApL3rOPe+92DC723P6dV6o994t9ieu3t
	DN2BK2yIKMEFx68O3/6tUT2EbxZYthwQia8keOTGEo0w0x/EndNUxOJj
X-Gm-Gg: AYBFou3iGDt1DD70Ys15MLM1gMXrLwnmc/QDLQrpzT7xD7DlHnx7zztwhqN/oJrjVy3
	TK7J61bBusIG9r1RbwrlQveApecK4FHSC86QWELDfSUXfXqN8LIwd5HWhy44J5Dj7UG9u32Q58D
	Ko3H5wZc5axKVrt9I7ZTFIvogIDklWvIaowAQWBKvFpMxKNTNgr9+mM00T1JgJEB6AMn6lkXzpt
	G8wOyJIjEBrAGJOOfhFwaEisJ/UJUr6EcRM11CLLbXUp2EFsb/oLXrJ86M8ffX8aERUrTLuedqK
	aLrLOipEPDvbizcJ5dZ3VsNSHPHwrW2+ElW92KvjJfHWDNqxv/dO+POxV5/QiyRgqLSrMPNVMeQ
	Vn1U8KIVWRUZkleuvuu218WGwIXmbCCIJRRXzEaCST9337p7bFz9VxgRL/7uuOqNfY8Lgi3rK3K
	2ho1vlgdtHJTD0e0QqXvXcAFIPgf8YAmQq7PRxGARO2gGPczxTj+BS4ylih38/aflO66eH
X-Received: by 2002:a17:907:3d49:b0:c25:c7a9:7b8a with SMTP id a640c23a62f3a-c25d54b6d03mr830373566b.12.1788441179056;
        Thu, 03 Sep 2026 06:12:59 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25f419d91bsm96400266b.23.2026.09.03.06.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 06:12:58 -0700 (PDT)
Date: Thu, 3 Sep 2026 13:23:31 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Justin Suess <utilityemal77@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf <bpf@vger.kernel.org>,
	lsm <linux-security-module@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <matt@bobrowski.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH bpf-next 0/7] Add new way to add BPF LSM hooks
Message-ID: <apl005R08S6jdbWg@mail.gmail.com>
References: <20260831110934.241898-1-a.s.protopopov@gmail.com>
 <DL514LM5TA6V.IOW7P2WM70BE@gmail.com>
 <CAGn_itxwZcMLtass5fZQ5XqgUtwTaJHfUGxg_SK7h_vqEgpmeA@mail.gmail.com>
 <apljnyb9nNRuN2xg@zenbox>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <apljnyb9nNRuN2xg@zenbox>

On 26/09/03 08:16AM, Justin Suess wrote:
> On Wed, Sep 02, 2026 at 09:31:36PM +0200, Anton Protopopov wrote:
> > On Wed, Sep 2, 2026 at 8:07 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > > On Mon Aug 31, 2026 at 4:09 AM PDT, Anton Protopopov wrote:
> > > > The BPF LSM programs are allowed to attach to LSM hooks. This enables
> > > > operators to mitigate known bugs without a need to reboot or livepatch
> > > > machines.  BPF has shown very useful to create such runtime policies.
> > > > However, many APIs and parts of kernel aren't covered by existing LSM
> > > > hooks and this would be beneficial to extend the coverage.
> > > >
> > > > To simplify the process of adding new hooks this patch series enables
> > > > BPF to attach policy programs to hooks defined outside of the
> > > > official LSM list.
> > > >
> > > > One of the reasons to add a new mechanism is that in order to add a
> > > > new LSM hook an implementation, at least one in-kernel LSM must be
> > > > added, such as SELinux or AppArmor, and BPF is specifically not
> > > > considered as a reference implementation [1].  This is, however, not
> > > > feasible for the use cases and capabilities covered by BPF LSMs,
> > > > which are not directly comparable to those of traditional LSMs.
> > >
> > > This is no go.
> > > bpf-lsm can attach to lsm hooks, but the machinery has nothing to
> > > do with LSM. bpf-lsm is exactly the same as bpf-mod-ret.
> > > So calling everything LSM is actively misleading and wrong.
> > > Patch 1 starts this misleading naming convention
> > > and then later patches add fake LSM hooks. Sorry, but no.
> > 
> > Got it, thank you.
> >
> 
> Adding to this, there was the previously proposed "killswitch" mechanism
> which may be closer to what you want. [1] Unsure of the current status of
> this work, but it's a better idea than creating BPF-only LSM hooks... 

Yes, thanks, I've seen it. In the proposed form it is not realistic.
I was going to discuss in my slot at lpc how we possibly can 
approach this in a more safe way, powered by BPF.

> (like a bpf_override_return helper that doesn't care about
> ALLOW_ERROR_INJECTION? unsure what would be best here)
>
> Justin
> 
> [1] https://lore.kernel.org/all/20260508195749.1885522-1-sashal@kernel.org/
> 
> 
> > >
> > > pw-bot: cr
> > 
