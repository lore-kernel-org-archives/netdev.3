Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDD237DAD5
	for <netdev@vger.kernel.org>; Sun,  5 Jul 2026 12:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783254158; cv=pass; b=VruL4dJP0Yr62mXDl8nFTMRBzhMHxAukBgszOP2d/guoT0I5Ec+rW8Lrra+g0sSEE7qyZXOiR0g0CDhrV0RdDVy0ddVUxX6LkjiDtjeUPpi8eGoXQN2GIZCEM5la9xHmeaDrppF502sdEcbz8vS/fqD2O5iWHHuAysszGil7ozo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783254158; c=relaxed/simple;
	bh=cVZuwq26LJUbjnXW20W3nbICqbmkh5x02bCyytPFsmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=KknYbSY51wZQdYBoz0ypVhYTvphBiecfNn6xLWXeNrk2iauU3Z0kKAKDi4Etjua7lzzWk4kPrc6JM1awmxWpTj85E1nspo/1EoStJe72M/0yJ5pP+9UVF2nqrZ14+Y4QB+grKw7YQE7g13mpUkEccx5TCrlTF4/UmGvvwLzHGhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Srag6JtK; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Srag6JtK"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-384422b05b5so192163a91.2
        for <netdev@vger.kernel.org>; Sun, 05 Jul 2026 05:22:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783254157; cv=none;
        d=google.com; s=arc-20260327;
        b=JCEYc3ce/PIfG6m+nDCHgbmnMh2a9AcG862e80ToXZdzc4bVIlIGTDcpapwCYC0XUV
         DH1k8l/67tfhTTHNjhi8OYLKCJaCg0d4GGwIjkX2ZghL4VDC8Sx8NFn8pHjPO/aiWGWl
         x9XSE39Bjn+h2YyOtaYU1CxOjr6GUqIpm+if5ouj12BeIRlcrvmT2IZ0X0swcyBthWh/
         YtkLoG1gvABW16pr9oSXDcI1lMlmtVnFaaew27OmeLwLQkes2FXAdRbAq5/oJrrQ7yRf
         nKwaQTVkFQqsi0IyHmazF7bXZkQz1NyLORS3telsJViS1QC7lN1wf/hWBigDKlyP1+Fj
         ZwCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cVZuwq26LJUbjnXW20W3nbICqbmkh5x02bCyytPFsmg=;
        fh=jaswLwv0nGa7C5zix8ixl2Ro9+OIOss0sUOuGEeQQ4c=;
        b=IQ62OCDWtIFLtluY2wIshWeatacxxoXXTxXdsEUBmt/EmGgJMZzmMtbYvujVTzBynx
         3xMdQDr351IMV/SWHVtfOf63S1FR9japuseo5GKMZwCqi+XJix4DTzmJaMZ11jGVD+2H
         jS9a7beLHSoE2wAWEwn1KTeZGHydFAfpDY8iJqYxq/qJicphp11VWH19oQ1h4PtA3WXy
         lVqCDhf580P9p3FcaU/olygIiD2YjRzKW/zxSEFifi5MTInKOZTyq3P7xIdtbfKMoI6h
         YV14oxWWrnJq3to+xuV24L8uRZVNMUC8jIMnQn4t63rCQSv0VA5oMnL9pK/VoEV3a+Ox
         rrAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783254157; x=1783858957; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cVZuwq26LJUbjnXW20W3nbICqbmkh5x02bCyytPFsmg=;
        b=Srag6JtKCPM+t9r+ECgpexUbRNBShKVyZn0lOfixCWw1BxqWyZ5y9aa8mG8eQgdQMc
         hLz0KD1suEBLpAuqkZ/u1JMJkqBvw0DjcJkf57H4x6ODoNbeWRWtWLEDYZU3NxIYQCud
         Jz4ph+lFllFK3lxXOsgOMQeA5HLycp9KjaSEy/LmTGAS2/9JgrHMrkDDOOyMukrfOrvE
         3MemRYQ3l3R9T4O0r71iP5NO3VCHu/WG5FNRVKsfsmAXEG5BxstRhOUq25Ylp/VXVV5P
         +4VmCqRjOGwmHPLGo5zqaJwEyzFWw0VS4G/RdBCju+oTeKkYOhcq/4BgYAVOyfDQN+L4
         +L5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783254157; x=1783858957;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cVZuwq26LJUbjnXW20W3nbICqbmkh5x02bCyytPFsmg=;
        b=S42HsI0/ZmgxDJEpREc8bRbpqWvYRQjVfve3ueKhDnbXheaNLYNuofMEY2dkoAaie6
         tQvmGWHvk0/pM/+Qkpz7etkMkMwbbF+LX562IZ830++bWMfi5uEWtf+dPYEVwrASNN67
         5YUQZiOn6CB6mvZ/rYIQiP3i2H+gnccXNoX/TrbGlS7cRQFhGb4SbmJw9oY2f/3sskdF
         OyI894uxeVg+8b4zi/lBbDLu5XrJWBFpYpqae0C2Ii1CwAmnH7y+teNcEcTc24NR/91P
         F2+N8bgoQTDFwlMjiMGG4ci4k+HhO6QZZ1PQDPJH+LcJVaiUdv4cIv9Q4DVXJZZiR/Sl
         ra5A==
X-Forwarded-Encrypted: i=1; AHgh+RqkSAhXpeEtb+wqzfPNydR/wBipIiQ6rn2rvs33ZtVSolLPoYh8dCDDfcj0Poq8ArhMcBW8tPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP8Z6XqSfXSuk2G0yT/EWVUQx7HVpnuPe87ZctDKiSkLcDB+6+
	Hs48zmZaVa+kLhFmPZZ4V2A3CsVLrpPeo1+ERDF4QRcO9r7qqVDi27h4PwOPcYNG9+5lHebJzw+
	AEcZzvRG4opMUEY/cEXECR6Bhq2+faX0=
X-Gm-Gg: AfdE7ckixhMO7Bipqaw3R2CLMCGj9Zs4JaY05+kkY7V8509c5RxUKuD0y4CD2ZOrCKG
	8n6fuzneN3MBz/tSo5wA3LI10PSvTOPoypEd8RXAhTIIAY2BIuvrjb49gaaoTCOxph+lTa9992W
	QBvTE0LXJTy/JVzI9I1y9SgK9TNfe+cvI1YlHWoF1DheS0EauE+DTt5R7fOKc6iFj4+k5qrgZO8
	2RAOyCbRjFvH5DzaqpLECGrgLOA0ZW33Yhww0i0PVY02vlDIUlTeurID9+AZYZafHMMPWMxc7LG
	YvLbsQMi2n6/Oh92jTUwKOxGVlk6GrBcM2iURir6LfXuWrfV0qDmuyDDIzhMEtljVQTVb6tdFgj
	IFVLntDqmah1U
X-Received: by 2002:a17:90a:a416:b0:383:5a16:bd67 with SMTP id
 98e67ed59e1d1-3835a16bddcmr2702118a91.4.1783254156186; Sun, 05 Jul 2026
 05:22:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev>
 <c89a1bc8-6cc1-4e16-ac95-add389e45a2b@lunn.ch> <akmnh0AKFfu9-OYn@gurudas.dev>
In-Reply-To: <akmnh0AKFfu9-OYn@gurudas.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 5 Jul 2026 14:22:20 +0200
X-Gm-Features: AVVi8CdKZk1uQg3RyoO9gWWnGdg1D5rtqZ5BcTTqS2w4TtsLqn1TqMImL9QufHY
Message-ID: <CANiq72k0zokLC_L2wPJRDb_CyvnJznOSKUgTaiHo87GT6Pwyag@mail.gmail.com>
Subject: Re: [PATCH 0/7] rust: Use kernel style vertical imports in various drivers
To: Andrew Lunn <andrew@lunn.ch>, Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Robin Murphy <robin.murphy@arm.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Jens Axboe <axboe@kernel.dk>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, driver-core@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-block@vger.kernel.org, netdev@vger.kernel.org, 
	nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 5, 2026 at 2:38=E2=80=AFAM Guru Das Srinagesh <linux@gurudas.de=
v> wrote:
>
> Miguel, could you please indicate if you have a preference here?

Gary is right -- it depends.

Generally speaking, it is best to do changes through each tree;
especially so if it is the kind of thing that may be prone to
conflicts.

In certain cases, yes, I may take treewide changes, with Acked-by's
from maintainers (and very exceptionally I have done it without that
if e.g. it is trivial enough and enough time has passed -- trusting
that people trust me to do so).

It is part of why the Rust tree exists, i.e. as a fallback and also
for convenience in certain cases.

I hope that clarifies.

Cheers,
Miguel
