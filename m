Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7786A3A5E8F
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 21:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780436717; cv=pass; b=SgiSHXi1rpUSGo4Lz0cqoZpwYW28b8Yk5IoKhE8px21vRk82IGga5CJBeylp2UMO978MPV7k9L6erZc5zYAH10ho6f5VIdhBFDaSqC1HCg8CBw67ir8A1tl7+pqd0oR4471ZUihi4BqOGAjmHgroq8+GiVLeWtF+KHL5BxU+3tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780436717; c=relaxed/simple;
	bh=KOQdHlqbjdmDreblqF6LDye84bMbw/y63M7JSnQjQwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pdVuif+qqL1GCRlXYTginD+g/+I2iMS5oOObZ1qaninLF1VGdtteTLSNlzuwlJWpPfXyYJrUeLDj/9x5cJ4InCTKONe7TQEmliiboPbidfAKSpMKKmq/xUt93DXEWuTfwfYq6D0cXW+tDVAeQqEbxKuU4lq3UqUhTTpLfth0lpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GVaOxf6I; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GVaOxf6I"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bf18c30bb2so38904625ad.0
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 14:45:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780436716; cv=none;
        d=google.com; s=arc-20240605;
        b=NzfBfow7nb3YVgy3CaBky2HdwCHPhBuLHD2GqXcj3474f8FDt3bLq0a+4+Qo8HhRVp
         W3kzn14ZV1wcgpslfpDr18PbbLg0sdjRvffDuPCrEHkFOYHuQZhF90c+w67lYkXvmr2w
         4tmRv7xVnnBEqCnbcMr22AkH3Qo/hTUr4Ci6Sy72vDhV7u8+OS6E4DXPr2kTjENwU6Xk
         8WCtIWdsSRN9ljkoM6xoYTmRcUDwyPD1qyO62Henr+5LUdq+gOa1WIZFWzmvGwCtQJDH
         BVywCtVekeZ6mmGOsT/L1RE0lRL4TfM5Yiv6VMT2NPNMmAD/adZ+eXjIDk/r0D135LE2
         dd8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KOQdHlqbjdmDreblqF6LDye84bMbw/y63M7JSnQjQwY=;
        fh=TKbzcgs/0nUHDX0NvhzO8rHIU7ELf1IfEkpFm7OwKhc=;
        b=Y8vdCXpoBcQPvZLmGqkAA0Nmucd71+vbrn7lzHefscdrDJa1R/0fhWouqJTgwEb++8
         OBYOF8rzb1HI7RzJ2lutFP2awuvTTY4JDWAVDPZjw1wSjdmQJ8AmgfzODq4TQVEktw/K
         c0v62oWvZKIRAsopk0MrBxMG/1SpB3o2fIbU7ZMqSawPgjz75JugP0nFn3/3l7hqKUru
         AgEmgYbz47bO8tVlK8nxNofbQF0GrErqp/rd1lO4C6tr5+55KgRHZ7+JZxwLdwGpogoE
         GVvaS7TDQKaC6M/g/Nn3hPvpkpPNn4TIsIlc1vCNdvfAb3C5Qj1d9Qn1G3X2e0rJAL5Y
         qYRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780436716; x=1781041516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOQdHlqbjdmDreblqF6LDye84bMbw/y63M7JSnQjQwY=;
        b=GVaOxf6IskshIWFXpyp00GpLCHlAzB56Wpwkv38VLkYLIxUN1669g/OKkBmG6Vt5je
         XOj71bi9TwMdNZw8tKxI1zvySYg+1HEj1Pobk9BlpGQu2dgBTRnzNMiYUk//SIb1n6rN
         viH9YJmI+utKN/8HMdNs6uZaqBrlDCrrMwQXwjDmGIZAZ4op+lGXdUH6amVXBRCT0A/D
         ufidmD3M+YZT147mJvpNI11PYvaCW4vLUZ4VJBGtIfkczCaytcgaimZs2Ph0EuaEStng
         EarIi/p6I3/hU8rgykTOwtkD2BSGLjDlRYn2apKdjgAaX9g+ML+kUD50pmPZDx/8gGZl
         7bQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780436716; x=1781041516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KOQdHlqbjdmDreblqF6LDye84bMbw/y63M7JSnQjQwY=;
        b=FP4keqaRAUTXrPV4OuWD14dA+Cw0y8k0u2KkpeIZE0dJVtKh7ZyetThzDEehFH6T0R
         cLk8WTDVEGZu33DGWJ9ahLLM1TGcA9M3C0twZxpY9mA33ueDZoUh017dp/eDdZe5u+4G
         F0C47ojD1Kfves/hoWa3hp6StMgjvc0TlHADcFzKCJ/AQhb5Ck0HdhZL88Tufj0UOIhG
         rEBv5t5gUJL74prWrcqXEReg4RSK6+AhPGneO7rYaPt0m91l+jocTNl/vYyVrmOZNs7N
         sgg9IjbmL0wgVsARwi/zfN/XM2NzmqzJ2MSB+oVZY3WO4Uz6Dw+VdDjUrVG7OQNrabUF
         4H3w==
X-Forwarded-Encrypted: i=1; AFNElJ8CGoySmCuV1rG3XWGl8+CgHOGOSLGFLaP76lADIc6E95XF5FRyvEf4V7Fd2nTEW9fow/9DzBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YypafRL9Hhc3OPtbgnkaMJvWHWz5UCCLM8x0yZ/7tcEbek9HrTC
	j3IvTGkdxof4keZr3HxjsHnB/OJzAomwrXquDrwMFXvWT2ukbpSv8A02GP2C6cOdjcCfOWua2G3
	TvZQR7UMrk1d7ageL+mWFg+jscF9+cTe+pSACd3Ku
X-Gm-Gg: Acq92OFtxuW+eADOdTVwMuGDEDu2zBKZfad991Qy+jzoYFTv6dCH/zQow2Zs4AI9Eom
	leHCre2U9bvqJZRWo67R5NVaQtSYudd1BzjNlwvWMogJtkF5e37nrwaLUaa2iSwSrqAOgwk0TWn
	GQVqCemqf0XxKeI472jFCgdOQgLJn2eVsxHp0E1zFMvROnHQJImtwkSx6d3C3NB2zHzHOmmlruR
	IkDtOgAKC0injl8EqzGW1UMxNWiasmTNF484MUZG1xzUQJ7GByGjHzNaVt72spXdOSoYfWw/py0
	pAMYQHYUgJI1zWwzQw==
X-Received: by 2002:a17:903:3903:b0:2c0:fa4e:91ed with SMTP id
 d9443c01a7336-2c163a59a86mr5095515ad.18.1780436715739; Tue, 02 Jun 2026
 14:45:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ah8BzqSmZO40xYhS@sirena.org.uk> <CAHC9VhRR4mmkOdWwUCLswmA+_KEjB8RCBBTJ2W4JGiLUWKzxyQ@mail.gmail.com>
 <CAHC9VhRPbkVYAMec0KG55er6GOPdKqMXKdpC8rrHgiAodSv-sw@mail.gmail.com> <9d34218f-abbf-4a23-8b35-b305873ffae3@sirena.org.uk>
In-Reply-To: <9d34218f-abbf-4a23-8b35-b305873ffae3@sirena.org.uk>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 2 Jun 2026 17:45:04 -0400
X-Gm-Features: AVHnY4K_GfYnJi1Ham2KVsQorfmtW0kY909SMhxY_6Zb2qHORdTKGwtbORTWZjc
Message-ID: <CAHC9VhQnBi55hjwTATA_tgKNZ=StFYTKu2Av5R8N4yDJwsFswQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the security tree
To: Mark Brown <broonie@kernel.org>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 3:16=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
> On Tue, Jun 02, 2026 at 02:40:12PM -0400, Paul Moore wrote:
> > On Tue, Jun 2, 2026 at 12:31=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
>
> > > Thanks Mark, we're taking a look at it now and should have a
> > > fix/answer later today.
>
> > Proposed update to Hornet, assuming this looks okay to Blaise I'll
> > merge it into the LSM tree (and either pull in Daniel's patch or base
> > off bpf-next so everything builds correctly).
>
> > https://lore.kernel.org/linux-security-module/20260602183658.161744-2-p=
aul@paul-moore.com/
>
> Can you ping me when that goes in (or things are otherwise resolved)
> please so I know to drop the revert from -next?

You shouldn't see a conflict with lsm/next now, but if you do let me know.

--=20
paul-moore.com
