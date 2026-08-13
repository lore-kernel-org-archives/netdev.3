Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6D83ED5C3
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 09:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613785; cv=pass; b=WXyhtwP4wuT2dX1CXCzstm+Z13aOv50aY1hDujF/rGD0rCY5+rAKM5Vi8hycz35mSN5sE3InbUVFDXuHpry6rsk8xuVLHDmdnlecUQ3W4XqL37on/IvpairA/IbRgA2Zav0C+8GGoOLFOll3FNQpusOONyf+nTG9f6BMej/d8qY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613785; c=relaxed/simple;
	bh=I9h0QULojzau7syX2ptB1YiILa8mj5wKL7cDn/JLX6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFDkdcO0FI+TFruvzGgt4gQ4XrCDRRJoHU2m/pL8uX9MGQJltImoW57VyObCXQVZAQNZcBaPWIjxvdrd/3ZO4KSNjp1WgLpyWy2Olo1FEutaZWKxSVHAgQRzFj25ySyFUTLDj2Qn96ay//rgVxA1/cP4+yHdxBcNlurk9SMjBkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLY20tq3; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLY20tq3"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cf110997efso5125415ad.2
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 02:36:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786613775; cv=none;
        d=google.com; s=arc-20260327;
        b=HfdmYwCRPzUgn3VIdKwoe+FLUIawQ98LdaPWkSis8iYFwsqAV/hYFfUvHubv65C75D
         8yWAkDBXZcASUVvaBu/NmMt2l3rPDkMZWXkGoMZtGwDsBqN3gLV3zPuMkX1KnHgHa8bW
         UTAxqXTSdwkNo5CWZshcveorwZI/zJGq9ofU/gUrNEYPY+X39m6GS+KZxCYt6JXmVoXL
         UKXplD7Kk22lxvpoLfpoqRNC5xHuGMVEawEmPPEFmPywIdFQST0ligKwylb94G7mVnAT
         c5/zjpgqwn1Oky5z5KP9HuZxCFIrAMbTEFfJ9c1Cj6nDFxYqEqBPVt78Hvu2kFYN/Uh0
         0/0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I9h0QULojzau7syX2ptB1YiILa8mj5wKL7cDn/JLX6g=;
        fh=5SMLTSJDXQ919/2zap4XkOpTN00SG5I7oaZVWfkWXKU=;
        b=lEhqp8blHrIK8xk6NimnsQY0wRV2Z2Pb23Ysv3k4xYPZenlgStYI3zAsaAS3JYxwDA
         YK9RTylZp4khlv+mNZ2xImxwWihrQQDUY8lUOJgcWXN03vKkrQS9QmmW3JsOHJR5nvpq
         p4RnnDSS3u1yKY4RO6QRaUUUrmasP3To+My6nlCPRuqCmWoZKkQ6EDN9gzYojq4Ioi+O
         UOVFf4JpymkOHNBjwOksp2j0un+Zzz+iwk7RKjqpbRF5uUoQUQ7I7hucHxSQN8jPDC5X
         PODC0BbbYZu2/ShpiXM3pXSaPVnpdfwza05AjfzioMI45kcZNVa9PQJSVjKuhN2WfDQT
         2fwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786613775; x=1787218575; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I9h0QULojzau7syX2ptB1YiILa8mj5wKL7cDn/JLX6g=;
        b=hLY20tq3DTzgOPpU2TWFvqupEvw6BZf9j3keoSE+Gba2EpwLBOoPs3SQcPLdhbHOQd
         av4LzjQ9lYk8iOzG7fbP90+/67JTKwJKjagYjTnyBsp7LINLmDMXAMkvWpmAAwVUvpVB
         WOEJ5hPHiPAW5JflzYC087QtbgUj9OaqQKBUyQviZTqRro+AWpjLp6W2TORQUC3zlftH
         x00J3FqT8MvEhq5XipmwYmYthJ2Z4yrlDkTn3YRtrL9UiuQjU016jZXv5tQqSGMfeB1W
         CUN6JmXZU6P23klRsBB+8cEq/q+V2fmSeWpK4LPNLpfnOwggw5yl0cHmhsqlOKZT9DAk
         1v2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786613775; x=1787218575;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I9h0QULojzau7syX2ptB1YiILa8mj5wKL7cDn/JLX6g=;
        b=AXsp0d4g60l5DSkLBBctenU8AyuNYdQUceJKQu3B+9QiGDjEImJCGULbjyffxi3SbI
         I1XKwx7ibx1BQMqAlRkQY+zPpI6m7kjSD3G/K1cF3yvZwlhrQwanbCUbSl8CKkkBA0L0
         iwgaWt+uzQtUzyBiz8sPxi035xrHyEYG2Bz2Qg8M3EIts55I9Icepyxhlqfk84Tyw9mJ
         NU7G6VoX7NC1pu6bIWGRSC8jqP7jaaiBLgpdiBnv9IAtTE6hxWObb6cJORfxipuHrbJR
         pl5/Rg/0hF8y5mGimzF6oWTUYN2h1I24nfDk840toS1sB1eCO4kZt2DSGo8hBp8rUTOB
         ThbA==
X-Forwarded-Encrypted: i=1; AHgh+RrRkzLM/nTt5T4Zp7q/7zEfslU6Sr2FTd+y7Cp8wi6/EBrrbirQAmwKACdilmPDF5MHF1un7JI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNhVHY4yBhbB74JaTjbDrCh8JJS5JTs/awD0h5DbzN2Lv5gGmD
	ZJBQ8OdOEvPxtJ2vS3SatXTB2dgzUQKl24hN8P6dbi55mUmB5+xL4jSlOTjS3wNoZOdsajl9SqF
	lU2WFF7CS+FN51OoQfh/Vv3zhTEcIZa0=
X-Gm-Gg: AR+sD12p6kQJnQKaHZcj84XTdZBO857v6tazMqhUenYfLaf9VP7IIMwNytzFWScDe2r
	qfibTFudkJf0yHNQZDyxqOuw70exb3qadnhb/jGWgIaz+a+N3TjF4lw+dK5iKk1F3C/0OyEtAlK
	kQKgWr0cdyS+EZNVZlLEw2P1965MvSMP/OmUEmmXYGTuKBMizekcH0lVkVCE6qZgLtmZIfYUGu9
	dNY/sbcOH/dXoQ8td+K0TjRvklPJmRyeIpp5tmkUmMh1SF8pvT1wXyVtg9koNRxSd+CqED1MFvW
	wxhIF/Gdb5LVaV673lNwJUuk7kTRIlFcnzSGdws/zmd+/7JgwT97G7z3X4c1xPCLV5a6juDbZIP
	xTBs8cqiG+PoEzt8an3AnLhi9P84Nsxo5wZkxlWSr5YPQPnZQ7sNCZuDqW9RnU2bB7xUo7Lo=
X-Received: by 2002:a17:902:ea0b:b0:2c9:fbde:ab68 with SMTP id
 d9443c01a7336-2d389b9107fmr28401875ad.3.1786613775343; Thu, 13 Aug 2026
 02:36:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811-fix-fops-owner-v10-0-7e71776f9dbe@linux.dev>
 <CANiq72=bhfofrbdf1qeA380-eWeKj5yXhC0NzaU_nbB9SpxYHA@mail.gmail.com> <DKNAS52KYWLD.M15VEC6U0F6R@kernel.org>
In-Reply-To: <DKNAS52KYWLD.M15VEC6U0F6R@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 13 Aug 2026 11:36:01 +0200
X-Gm-Features: AUfX_mydrO4nx0TADc_1KF-ELy8K1d4zi4yvOYINpS4bHvyjdnsvoZ1CepMueE4
Message-ID: <CANiq72nR3K9d0Y--FyUm1yAkww2LaAuYQZ3yHXjYxxfztgMMYw@mail.gmail.com>
Subject: Re: [PATCH v10 00/10] Fix missing fops.owner in Rust DRM/misc abstractions
To: Danilo Krummrich <dakr@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: Alvin Sun <alvin.sun@linux.dev>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
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

On Wed, Aug 12, 2026 at 11:53=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> This series has a semantic conflict with both the driver-core and the drm=
-rust
> tree:
>
> @Mark: When you merge driver-core-next after rust-next (which I think is =
the
> case) then you need to include the diff in [1] into the merge.

Mark: in case it helps to make it clearer and so you don't have to
read much, that [1] diff still needs to be included (i.e. the rest of
the discussion and the commit I added is independent).

Thanks!

Cheers,
Miguel
