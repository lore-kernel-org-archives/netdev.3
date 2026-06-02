Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ECF1A9B58
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 20:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780431214; cv=pass; b=Dhk2KZkfZWD5cncnjerHcrO5SM8Szc2Y8Bg0ApQjKEq0NtyPn4P6e5fgB+2b6C9LqG1q2wlk/2SEm8IH7EruteaUtdHRPD+emTsRjpte06dbEUM3qj7NJ4K7eJknbNGI8aAX/ocAzZFTpj2ubLcNWjNyQJ2JEKCszM4/c97jL1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780431214; c=relaxed/simple;
	bh=pseZnC1BAHbaZcHMzdNx6tAqrCQgXMmpIht/MOPt0gA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bOxXYqhH5ReF6daFZbbNSmCz/LiWBOMN7MiQ4P/qRiUyefd32MG0NS53F4/CXL8FgOMXvF8MIycXRa5Xg69wzkNBXYSthuSNvlct9ToRj6zB5Wn+Nct2c8vVSBaG4GsFOsIgrDKbW9ns9sLPkW8N7kLclsScz3wZw+RxGKM04B4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fl3ZVujb; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fl3ZVujb"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf3781ca51so36733115ad.0
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 13:13:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780431212; cv=none;
        d=google.com; s=arc-20240605;
        b=aZ8wfPSoTXPeOVfTrgpZEt6NUawjzC0IqjWiWZUk4rQsxKJjRTqN3u7j9+uP5aASqX
         FVcolUHyWGFWnDNKeJfg9YnYlFRvzPJwRq2bphfWR+rbYPELftG7UtAARsF5lHqVIS91
         0s73GCsx416/6D3Z9yCzNtxlrd/z0Rgsvlla1frYJ5JsL6QNNrGjIWYD5mvpcGQshqgm
         MWJJXmlQev9GpJmswpE0MNwusmhzWNRitooifz06GFXsGETLDyASIuwYISIO66p+hmXb
         4PvfeZi1f23Qzp9fSQUNLrFUIbZH8S6Wl5kSguCWLAGCjkbgM75cXE5cATjyZY25wOzn
         Q9rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pseZnC1BAHbaZcHMzdNx6tAqrCQgXMmpIht/MOPt0gA=;
        fh=tZkqY/byY5nRdkxGN0BzUrUYTOSSexCc/ITocra2Sx0=;
        b=Ze9c0/WeHbZBrqUM1b/z6EJwtgahxpkuXOXBXpuSoLdEGFiR4Ky/PeW6f+RvPTEt5F
         xCu2oEhNc0c9JHIysUS9sn9+/Uo+LvldardLs/15ml+EyuivXo8h6KOP580jB9fpacrL
         OTJf2yt4zHGv0GoVy2yvlCAWpTDfl3GGiPXN2X8KywG2AWOdLLYryrPBmi1Ak3FyxnXE
         VFPB2UNRNzz4pcLrTo4hS3hjwSJmoAjlp0gYEQ2Ko1gXjKERvOG8K37iERoisd6VtxwC
         4VK5+c3ov9Yh7DqqvaKF4v8q2u50mMYe6akUejPQtSKi86/NR7kOvHjKoLb6USjlZKlg
         YU9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780431212; x=1781036012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pseZnC1BAHbaZcHMzdNx6tAqrCQgXMmpIht/MOPt0gA=;
        b=fl3ZVujb9HyNyZlscbOzAqgPIDbe03L42xZxJRK4g828hjkxr6tG40favXwn3F95yH
         NroOjT4q8bioNJtcxiOP4kBFdwhRy87YJmLQVpRCdGVpgd7LTOnXhkmhSBg4u823+ybQ
         erw/ABULTQ5kHSyjlCk+sT0GZw7iz67BFYr7h8N2/+NZiTa0k5yossWAMdPwLnl42HA2
         dj2SK9IxQRsOmjadDicnPx7uGyqz/F3i91dLmvguWULWXxkatm8B7kxrmL2C3DbLPG8Z
         7j0HY56CFEfD3Wq+ITZvnWFrmzQOtUo9PSHbiboAcM89pdcG6XSOLbYSZzm05/DW07VY
         BNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780431212; x=1781036012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pseZnC1BAHbaZcHMzdNx6tAqrCQgXMmpIht/MOPt0gA=;
        b=AwaY9wjHcYihOHDOu8Di7ipO7y2vBH7SuzE0B+CA0G5+9w+DJQDFEUsT7wFYi+ZERR
         PxP+pFm+PDL9Hw6OHhbqhsrwOotJ28PA4QFVuLzE58IGaHJlhI+rGDb9DU2xM3HbO0lI
         YA/ahvnMBjxfP6FgCEtzhWnWp53690uGySBl1Tf7Ylfro7Su89c6KjLs9JQkCjYicJ1v
         u8IzJfhpGYUsxX9lUc2F1JQD19WQzC+AYS89FqA1HAhtN/PEBUnnO3CZb9hX2L4RQOXT
         bJY6S6jgqCOrk4XdGnq9KljJyGxWHtpZ0ymxBba+VRLaLdnO3zUk4b78XZHVoRupmzXJ
         ZyPw==
X-Forwarded-Encrypted: i=1; AFNElJ9dRqcwWB1OtQ/7lJ2tAe/Jp7eh5QzZ9B6mILZF01+labDKv0xSmtSJiFoD+307FWDQI1i9aqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCSgCs0ID0D1CjvKaYs89Lx7U31+3Jd6awWTAr90HEArkpE4Gd
	OHnYroYXZ7cBxXO+Nls9DppY8BCUEl5ioAGkykCxhAcbYS3FbiapEAhhGmMNtxhhmd506CwGJtc
	IvRtFuiHEvc5ws67kL5EvDkDSNhlOgalKe3aIUqOK
X-Gm-Gg: Acq92OH95fKeDhE1RrknwMyodFsLtQZqppBJ26PZrgKy9l4RTxcXj1Iu9tnVN7wEoaM
	Y4O55OVvGPY7dY12JnE+Imvg9k0E8WtnCwjvbqMbXYBZN6uP64Ov8NrZ5UTdsKvpHBh8Vi595bP
	qOcExz0uk72X8/z9G9+U0sTyNYAg5Lv5um9LR/CqfxSKQP+oaD/lZ1gdGJnS0eX2gtyT2oj/oKR
	ZolxwGk8YEV51qt2BsAuPLFOEjw4dnI+OS+OCiN5CV8XfHbfHwPgrRA1BAmFMdSF2vLvPajzZdy
	7CTtNAIknOazW6gMtQ==
X-Received: by 2002:a17:902:f60b:b0:2bf:160f:7043 with SMTP id
 d9443c01a7336-2c1644b2994mr2445575ad.34.1780431212343; Tue, 02 Jun 2026
 13:13:32 -0700 (PDT)
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
Date: Tue, 2 Jun 2026 16:13:16 -0400
X-Gm-Features: AVHnY4KpKpO9DYaOTu4rfr4g8D4KZLclWt7FiawOozC45PMKWNUodtnlnRl25IU
Message-ID: <CAHC9VhRxeTVxCW+=1DR5qzopGyHBMOJuWmtBqT_T4r1LC1jfBA@mail.gmail.com>
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

Of course, no problem.

--=20
paul-moore.com
