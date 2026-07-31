Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EA232ED55
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 06:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785479406; cv=pass; b=JAAe5JyxdNkzFVyQyybDFsbUTwH6OQRv07nQLJtoALdrX9Hp+RhyDxEa54vOQ/8Dr2ekA8ea1SboGLWd9JU2tlMU5aFKU8UdOoPipd2ejqgsUz3KDwKT2fonAG8U4rfR8YCI0kEQEHpmzj00GwjSEqZNtUOZWY/tAhoaIE0y+6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785479406; c=relaxed/simple;
	bh=plYqvJikpm2phA6sJTWH2hDra12ZFHqZ7KqSsbbbx3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NT3iAbAH5uq4oKhYEg7SlokxEBLyryrnvFOrNvlb2xHJhwrubme8tW2oEB7TBrdYWTjPq+BurHJqyTthsfdsFI4Tao1eCFYKRKddn+Cl+aISEnB88WZl0q2ffklV1YV5RmUhcgf5oNbZFuMCUYVaYvRL7+DQOrJ5dJ3mlWFsRN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWCaNt6d; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWCaNt6d"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d027b7c8easo1114145ad.3
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 23:30:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785479403; cv=none;
        d=google.com; s=arc-20260327;
        b=HsB85POKs+jyGCPq7rpp29J7a/et8CgNA1iB5hYOXS/u11cHCd413bQhbmxqA5wIcx
         CqVsgR9zHQbOBbdOm/4FDVQ+t+DFiPVHM/jHxd4tLzoKzV9F9dZuNETK9GtSZxk5hMqr
         t7jL78grvA6/+55QPXuKcgPLhdBnOzaImY0tDSVf2ouQu9XvB22UC/ZPZGbLg6r3VUfA
         5odXoEgFAQtGdkOK8ur35elsL+M4b3Iu1Ki8iaZ68n+Byv5/bkUmR1LqCQvP3EZk4SR+
         48tupMiYqeypAl3eBRNlK/cE2nMqEgGJUiu7sdR4pKIeTDBmeoR3O0XO4M9RBpjZxLUi
         KwwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=plYqvJikpm2phA6sJTWH2hDra12ZFHqZ7KqSsbbbx3E=;
        fh=P2roAmmFK9OQpNg3yQgds3DEVQmVO88F48wU7W6Raw0=;
        b=qdXJYyiQe8/7zVyWUCQhQkZ7XEAEdWYF5uIhUl1sKeDf9QSEeKJaJBmZUiMLmTLwF5
         4YhVSs49Zl5YYNFs/CEktcRpZlOoNC3hV7ZIpzh6/yCc/Z0h3XntvbscB5al3DOEqJpq
         gW5xO8FW471gbnTcYgRmnnUHVIn0rcYV72cpNFVDS2g+y/NDzZ7V753yIGDkVw0pLseY
         gxp7SPlzH4VU9WfWyJnz244Z180rjSqMW1k1edCRPmOURB6W5vDLzmJyfHZFRPHxlJ1v
         dyucEUu3sGd9pxh0b8dRdKk4cdta+Xh9wOu2t9E7eXtkVXgpCFTeFCf81gwL3K/UMoYv
         w/0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785479403; x=1786084203; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=plYqvJikpm2phA6sJTWH2hDra12ZFHqZ7KqSsbbbx3E=;
        b=NWCaNt6dNgAGARtRG0i87Zg/4MX5m8mmYfHmRZodmPVVojtjaNus2ym6gJYtL1Pd/L
         AOv8wQRegNwG+GTWDMU06KuMRMWo9BXgtNKT0WdD02cXI6YUfx3v6sR0VOs9hagIJ4w4
         vnKyIIdeB+5YOvum8D393ArHcLC4LBT79fBcIgbLi5vihAt4TNMsu4hXeFugfhN4ySHC
         W5nQEtPsoLJ884H3F4mK4Qtrrd1jUgKr9KCr4ehF1xIV8/txfgWipTUtPYDapxLJ/34I
         F6/4LcrSYzE7iSczVrekyvtA/Ww6xZ6wYo3NFEDB9G7amXtbcR2IB4gYc02nSfWbY2eZ
         DKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785479403; x=1786084203;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=plYqvJikpm2phA6sJTWH2hDra12ZFHqZ7KqSsbbbx3E=;
        b=BIy9NBWSzdgTdMZ/HOwZYjdt+1un/s3VN9KqVjUYxzT78B06taTKRVnYrqjujXdMhq
         scabUF/ODLlhG8NOEwJqMcAHxc+YorBD9sfSTpPIXlUlKOAjoLrKexNaH0VOxkLyz8Zu
         q8xenkUCKB4QmH/YAkWO+u20PXtTFxCIo+aCCRshJ+Wa86mNc2mgVLwBhgiKK0RVwFU+
         ZlMCdZ0q78Ei13vrAC7/OrNpwMsHYefTAmNEuVTBo7RegrN36QkCUs2VVneuYmam169z
         THZyQXMRMBiX2Ha33RB56R6SnHfs35YvBIVTMLKe2jhSU3W44E1sgVpX24yQ29pOyo4O
         2ngw==
X-Forwarded-Encrypted: i=1; AHgh+RpiYI2z2Y19oWpzqLo+7BoZvjcl3gnDQwl8WdcD7ZhtZpQhNslMV1/GkS5pw1C2GDr5718DAWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRyogBvlDQF+WmCG6wOVoJjOj16p4Ht8WVfZZfsVK4kzCskOKz
	M8mCAnvhcjaW81mpS2qE4msVZ8cKLZhl6jTNbEFcs8RX2ad0rYm89DBVAnNOX4e+ezB58hvWlDR
	1hUR5vhYuTsVh3wkVG0Q6THzSY5o8jJU=
X-Gm-Gg: AR+sD13EXw+DVIIH6OHy6SEHm8NFclVeXk25lxec//5mN7LDUu3ZFBEVEK9MB+zqZPY
	Q/Yr86uHek3xmyDTKcGMtdfU+V3bcA7QTDP44cyM3jkgsR6CEmyEhllAKLl+bDk+pBjx9ATNxO4
	6A/FEX+61Vtisi7Wtyf5kJH5vsmmDnvM3wUpGwcKtuN4W9y3Z889+kcs3PCoENn606HPfcsgw3Z
	Ruhg1GAGQCqbDB0/gd0B/Q3ys6Tuv9CBNShBW7wGum2HwlQNpcwt7QdttJoM7uEDPMEKuYUQmZ6
	focQWTQqLjzkeaKB8bLdySjHKyoAQH0+1VOlBZXqvGldBNOs++Mi6EbiI1/wa6TLPti8tjOwR4f
	p/AgcOE8ISjczJGT6ZgC58GiMJa5RQOAfoen+H+rhAp5I05cy8oy432RM2Sc7
X-Received: by 2002:a17:902:ceca:b0:2c4:397:dd7a with SMTP id
 d9443c01a7336-2d046ef0048mr13066585ad.4.1785479403240; Thu, 30 Jul 2026
 23:30:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723-fix-fops-owner-v9-0-c1c3af7f7bcb@linux.dev> <a9dde63a-5f2d-494b-95dd-7567879de38d@linux.dev>
In-Reply-To: <a9dde63a-5f2d-494b-95dd-7567879de38d@linux.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 31 Jul 2026 08:29:50 +0200
X-Gm-Features: AUfX_mxTwoRg7YuTGPUdUHKCs3gSMN4l-jXSn1vTLDoexparxESqmVPaSYuvKs8
Message-ID: <CANiq72kkuKsRAF-r+2OyZbjjgvC+jvqMSXR=LgmqTNRaWQZ-nw@mail.gmail.com>
Subject: Re: [PATCH v9 00/10] Fix missing fops.owner in Rust DRM/misc abstractions
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-modules@vger.kernel.org, driver-core@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
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
	Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 10:39=E2=80=AFAM Alvin Sun <alvin.sun@linux.dev> wr=
ote:
>
> Back in v3, Gary suggested this series go via the rust tree.
> Would you be happy with that, or would you prefer a different
> path? If so, is there anything else needed from my side?

That is fine with me, but let's see what the modules maintainers think...

Luis, Petr, Daniel, Sami: what would you like to do? This touches your
entry, so it would be nice to know what your thoughts are /
Acked-by's.

Thanks!

Cheers,
Miguel
