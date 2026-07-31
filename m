Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E00734389B
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 06:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785480382; cv=pass; b=po+ZxYh2R0jijjK2a8I/azIzExZsmeOagjCiXYor/1Z6ucLzamdiNzRZMvqbTN4A5NF5/XnlxLXdyvtQRNKq4NE3ILgEMhDV9HzRMFajrQ7Rqa+2Bk9g3LdgjOGkJh8N+vBsfxsH/yypPUWi/qlDFvNJ23MPKhRQHtZR3GmHJEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785480382; c=relaxed/simple;
	bh=qSWRSbOj71BNGeOr+HBxtLFfbntXDiooltzuw+HXglM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hcg1xjDOhmkPt8msz+vLPOA4eeZugodliLLSInkMZke0ig42/j3lJ6CVqOrD7fPlcHGyb8hczWVxkrdbyFkL1bMbcp3vW42npoRu3IJwBmidz+BXakeScipaA+M4gZGXrndZPTfxGLnIT8vFZchJ6ur/KYvd+P2naYdDMKiR+zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHnR1d8I; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHnR1d8I"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84a3323d858so117738b3a.3
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 23:46:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785480380; cv=none;
        d=google.com; s=arc-20260327;
        b=QTvmEo0gnmyhTe++PiHxrQMM24Xrqx8ic/ETtL9CqZe5q6OjehOUoOWgTm9cZq9kuY
         CaCfGQsE09ZZYQGbCVET6VAcCzNh6r/ZNVzxyzSO+qfr/TUEWcRPwIzvA2BcHk3uTTwz
         3lOJl2PTayQ/UiaN/99y8vtn0WcFR5GBkUBRf50Mo6vhXxj6hp3z8XxL3DXwZLiUnIOX
         DvuorqRzIpmM3NSM9PaymCVmH6WY2CRz6ooE4J0+JQKt3y9eFDfh89XqzmYGSfS53CE1
         Q+4kQqIC5jb2/mVs5XN/PnKTlRapW3B6f7KzZhDlYY7j1X9LMlufFRYeGyR4uB7o01a5
         CP8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qSWRSbOj71BNGeOr+HBxtLFfbntXDiooltzuw+HXglM=;
        fh=GE6JYRhDYusauA0sjyod+LVxRmny94zEztpiS6A1UIA=;
        b=rRdbzfZtXiFYKT4W371q01tL5qblX9EP4dOM0mrJAG9s16aLuDJTCPHBT/lfp1swXZ
         1gjajyfrC4Mjzkh9vDIouT1hZLsUS8SjfJueGrYutYUhM8BDQZQ/vGoD5NnTZJcEDz+8
         IigrxuuED57W6mgGkHaL7IyIzGiVQ7NvhNzxFldYkA1vZFSwMUTpb8RmE0VTW+rskDM0
         WuzGG0a9st6v5222pb/siKmd7h817exevfmL0xyyP2mhQP9Jb+OFRy0+LBEeeNIvfA5/
         pbkdC3Qy6kxZQNIJZcy1vfTNOKnzawW1W0ZfCy0Ix3AU6XRDSC7adDICDmfdSRjjfiHt
         A7VA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785480380; x=1786085180; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qSWRSbOj71BNGeOr+HBxtLFfbntXDiooltzuw+HXglM=;
        b=QHnR1d8I/TMMKJbGJJ3aw8izZ7RG5URa+aA4KhAZbDqkJRLAM5u4XN+gTfEheCPRqB
         2KMZipuxAp4b/k4FTiHsqZKYgtPVQyY5mBzOSij4/2JFMQyMisjb8doiJWaGsIkBKgOu
         svJaHDM83vcM4tByZM0OZxbgwcmf1awtATooPE03M8/RPgJGUd4Lj2eT14WW2vHwl8uJ
         54X3B3SOEB9R7nncrk8sPxZC9BeDLB4h2nFts0jSJTlrjZa3D+Deu3V+97jE4J1CfZ/K
         YZFqt1ZbXILwW6MbA2Z2rvJxKWwpkWpyYduUHgls1FbIhiNDInIIo0WBGPyiY8nRozVO
         4VKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785480380; x=1786085180;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qSWRSbOj71BNGeOr+HBxtLFfbntXDiooltzuw+HXglM=;
        b=D4WCTspiMvE1TPinU3j6d2uZBPQcQM3WHg6d2YssOR465yT8LQvwX21VfM3COVDy9G
         oF5Zs2hPpg9IhFqjDl47lZG2+xO1WmxjfkSc9bLRNQAHISAHjrVkWQ+/tFevQw534LKl
         nF/E5AOPrIokwZlRaK81WSMNql7b0Qwe4HUFhCgzX7fblFT2h4HqnfBJnaLBia3NrRdt
         EUo7ybtoLUmKtfDhcFlywoxVBR9aPLRSJrzdFaUhn6jUy4U16baziFpuh2GpAC/BH4Ea
         St3mqeLrrB3x37y6lYcj29OhslehD7rG+kBkdiVTjj1BGky+iYJOKc2ENIDrZz0a+7Ty
         OMGQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro+8VJX6ZzeK9YKPvQvN3wA1c2D7hQAVcXAmziEGAiCX75ivlfyL8Dj5DXD14PBccS6Br7lj84=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTRz4ZTgfAJKvQyEkW20TAbbqtMCezq/EqqOkDt05zVLjBummr
	pweziYCxoWJFnD2lRxquX7wrFlMMBIF8BlpQTKZKgdGiLuZrjUrZhvKYA/2uijbL3bE7iZ52TFp
	WMfWUv2waEnrmyuhaVjgq2umKCK1lK10=
X-Gm-Gg: AR+sD12Hjqle6QGdi/jUPFLmClEd5c59uEHIE/iTRUfMkIB7lLKDKOnCFHLwy4slCcQ
	UaXCRtnkXVWYAawZwdKcmN3FyPvjtZKBwn/JE1v3AOtHxeo6l4Y44IU1xcn68GMl1tzmXr7wgbr
	4kB+gUO+53QO5miw/Rj0jEwTLLEnLcTINfBuCwoQ9fbMaFtz0F4mFfDRTqB0I2X0ccqqu7vkyfw
	bFvY7XupVpLdeAEUGHdIG3BtsEqhRqTZS/wscoY97JU/doSBqR26tpSCkMQgrx+FVy5N1gSNf8Y
	AwCWSqQgZNc3FXRcUMcQVOO0mVAu0QuBoOLrsgbNAIph1LFRy4p2O75vBK9aVGcGT8ZztNnEbHC
	TPeoEn/z+oXSich+EW61H+c27lDPtLTSUF2gMyi2W5DgnsU1sPWIwbVDWkBK3
X-Received: by 2002:a17:902:ce08:b0:2c9:b96a:2855 with SMTP id
 d9443c01a7336-2d046b459b3mr15748155ad.0.1785480380480; Thu, 30 Jul 2026
 23:46:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723-fix-fops-owner-v9-0-c1c3af7f7bcb@linux.dev>
In-Reply-To: <20260723-fix-fops-owner-v9-0-c1c3af7f7bcb@linux.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 31 Jul 2026 08:46:07 +0200
X-Gm-Features: AUfX_my5gmBTyBxP6uEcBbaVDtTCrtAGlQbEryzjfR6FoeX2UBUc_vHFPgNtGlo
Message-ID: <CANiq72m59O-ruHUvUcZC7yCvu0KV0w_m5vMO4e0rxyHdRmihJw@mail.gmail.com>
Subject: Re: [PATCH v9 00/10] Fix missing fops.owner in Rust DRM/misc abstractions
To: Alvin Sun <alvin.sun@linux.dev>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann <arnd@arndb.de>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
	Rae Moar <raemoar63@gmail.com>, Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
	Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Igor Korotin <igor.korotin@linux.dev>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org, 
	linux-modules@vger.kernel.org, driver-core@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 4:11=E2=80=AFAM Alvin Sun <alvin.sun@linux.dev> wro=
te:
>
> base-commit: b7e5ac83cb16f7ffd11dc23736f84276602100ed

Was this old tag used for some reason?

> prerequisite-change-id: 20260519-miscdev-use-format-9ab7e83b1c11:v3
> prerequisite-patch-id: 405b334ff0d48ad350014f05a2321bdbaa025400
> prerequisite-patch-id: 604b631c81d5423f4ebb2e12ba2d22e9ce371bfc
> prerequisite-patch-id: cb550d94cefe01920e0d3ced2b2bcbecd76f3907
> prerequisite-patch-id: 3bc830839742591460cb86d9472c04f4686dc600
> prerequisite-patch-id: 571058244bc8c7088638d2e3225713011246c7e9
> prerequisite-patch-id: 347c5a3c6dbef9832bfce8419fc23e6e08ba477f
> prerequisite-patch-id: 3e202d988b56b88446f7535e90d3f00cf5f15701

Are all these actually needed? Some seem unrelated (some were already
applied too). The only one that seems needed has Andreas' Acked-by, so
I guess it is fine.

(By the way, I will use this second message to take this chance to
move the modules maintainers in the To: in case it helps, since I
didn't do it in my previous message)

Thanks!

Cheers,
Miguel
