Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79037382F1E
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 09:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788688181; cv=pass; b=YY5Z4ZZlKennGyOaskScW3xdmBjVHNtR+FWO4bDauMn6W2G5SLYtkxg75tLNOiNqgaCCqZlHJLkm04UIOpOPJc1vqbtzaWfw+ZIINtL6Wa9oDwBF65YOKo3SyGKoL6Nyxw01UeCeBThgFKIRvSQ/skbfdAJh8tp3ywuyskrxXh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788688181; c=relaxed/simple;
	bh=uFo1S3usMCbLdEWy9LjKCdoBjHBFRVmushfAGQzmLtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PUMD3PZc3Up6aZ27EC8zzwqcXgbIeM87nsStykjsFo28pYwsiM6ozUzq1slFACicJb08ikV2DMwKTNfvZIFpWxhcNO/MaRqEG5JMw+mcbd5pCpHpgQYw7PpXW2uQshS7Bz60U/PfeKGh71W2QFItxl+cWA17ceaxUFgpWIgnrA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p7u/dEdE; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p7u/dEdE"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39931869b4aso127237a91.1
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 02:49:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788688179; cv=none;
        d=google.com; s=arc-20260327;
        b=Qk6X47MvDfSsUss1Vd2o+jjYmT8x0wTQCP+9d0uIZ+u0Ro86xX3JJbcdnGML14WTRd
         nBrjKeWHKoVPIHqtvSIPDVq8FRsWFZwYB9M9gBqTBouInivhW0K+uJLzZcQWDHxyDCy0
         UI8E5Drox56W+GvceB0VgxBzHan3Iv6VEthhyDwMgqcDfSTqDlppthwS9Q6v4LlntRGK
         7TSADy79s86/E+hpBr5DbVgzGT8UDQBnDf+upXXaOSM8NpZ6FdFyCh41dKeD8GdizGZN
         gXe84rXIPwHfPmPkLOTxdLivGefylmmB5Xpu5m2HgqjW7//bdLux8rckiIHW7MnhTP3q
         Js4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uFo1S3usMCbLdEWy9LjKCdoBjHBFRVmushfAGQzmLtQ=;
        fh=SvATA4IJjJ1XhnBPKb8Oh5u2CVRyMnv9iBj/dtlzaj8=;
        b=VerNI0ahIppCizx39KTSxjCGcX8w3qrIpbKprCitpvGhy/G54/Rx2xRsSTX3yvJwvm
         iVD37KcMQp9V0dgFQ0P9medWLWquxptlzDx0tY82+SzIQaBYqVgxExsHbp3ibzXpyGfW
         KVdZ5FyD2KXsZDrnX7L7O8SYHv+ueDhtur97A5pCML5JDcH30tPMftO6T7yAFyWiEINI
         wxfB5V2D+N1Vdjd2UJdXXGu5ORjUZWpMqhavejvL63yMuERox7J4EZTLCCKflkC8fk/O
         QG7D4Lngf4mwXMO0MojGaXlk2D7HXd1PNEjLca6ZipwkWGLwM7INkX1pZaeuDPeVr/rb
         ZoqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788688179; x=1789292979; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uFo1S3usMCbLdEWy9LjKCdoBjHBFRVmushfAGQzmLtQ=;
        b=p7u/dEdEUWtYxwBHACDb0DUPEiPf6Ws3Nae4hmhP/OwHgLd94oQKd4soQaRc3avfhz
         BHP0ilsivwepnwbrcFHwHVN6BxR7XJBqw79A/Fmlrf1k7gsk+dKiNuCrRqZnwSTRSUTX
         Z9u8aYpymZCACxrpSY/8QQZ31fUwiuSYiGLArjB1PwPcNDx2gFunNqnmkohnALi9RTgu
         +sGGZOru/AtNAjNc7VWrcLrqYNBUMrNMYTSXEFx24Q1vAl8r/zuEaF6hTVAHGpIKyjvE
         wGR4F2jL8fNx3ElMJ6KeKH4uNvVyZJF3FeC5Xb62Y/wNtECnwrKw/5yxpbyTdaBn2A6L
         Gpaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788688179; x=1789292979;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uFo1S3usMCbLdEWy9LjKCdoBjHBFRVmushfAGQzmLtQ=;
        b=eIjB3svz2ruODGQyj7PeV/r7YeS26Bb06dVm//ciTfrs92Zd13J3rBVMoJPGo0NlS6
         0a5vZwwcWkZWZ3kl4jymEMIqR0mXxvpiTXQQKkvDiHxiUT30jzDtPxE7L+7ocxWJi1TV
         CnjCEBZKbWGGTp0ykqn2f30wgeumWYNGtS5saXZGVKEi1oD12KMD45ZB84xJuFyFo7nV
         6mC4DrqRfOc+5WWdKY8VTIyvP34hRGvB5TQPE0sXQBUrzZ90njiSrlH70eKlh4jl/M+h
         V0KPWcr3mTj5yqDzPTgR9O+QOiz0DvtStAd2r/O523ztoTLlXNE7rSGmgGhfOSOlOVR7
         oTCQ==
X-Forwarded-Encrypted: i=1; AKwUvBxhHfCfAZ0gSAn5OAQ1/zcNbgqFRiz0NhlH0OeFLv3FcwY0cgEyQa2OhadseLIBbm+yKTF5khQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nrGvgOHo54BpDdZx0e27L8gpEcFs4pRrMkDG/4mVo/uXiazoEZ
	r+eOFm2+Tj84pfTCx91iIEPi2uo42v7uM862qKi/jsluxkSEm3fA/yj+ZDmmthLz3OI3eZ2bO4U
	Ze113/ROe+YEbxHg+QWge0HfyajBh5DU=
X-Gm-Gg: AYBFou3+Ijt6w/E51FAtV5VafiHILZXc2a6NlYfXT9o//yPYxwhgj+h29O1MMm7P0xs
	5KglkvXI4DfTxm9KjJEh7Y1FQZwHCdb2uxa5u6ZC5Hamd1j871ckaD3KDUvzmwQUU5hYkT2a7kN
	zmJa9MoKeCgXHzc0A/nBxKZTx+Yp5uURqb963BSbf9Wag/XqKp8RZ1VwzHqjbugb4eg9B++YAqe
	qfeG6w4hdZ2n4pJim/V6IWILU/Px9l3oQSg+bzXqYEIqck3tCgRrDntr23pLIhjW9Xdsm6j8LPl
	+ORs4i8hwTS6HNqWd4L4x9+tuMR3WI3vJM0iJlSWbNL/LJOPQjXyvPcYU8UY51ACxzBa6/0liFu
	KBQSeDvZuX4UmXuqyojZLve8TYrB4yQlQVEfXvabJDDgTS2Wy69y2VM5DT09+wmdClwt2Ko0=
X-Received: by 2002:a17:90b:578b:b0:39b:3510:4af7 with SMTP id
 98e67ed59e1d1-39b3d5ccb8fmr10221355a91.1.1788688178890; Sun, 06 Sep 2026
 02:49:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260906071635.160615-1-sagartaunk@proton.me> <20260906071635.160615-2-sagartaunk@proton.me>
In-Reply-To: <20260906071635.160615-2-sagartaunk@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 6 Sep 2026 11:49:25 +0200
X-Gm-Features: AcwNN1VXiJDpw7Yx5y7AHks6u9YshI7REEbxh0m-sHpFxLllVsN403pcWq9oNiw
Message-ID: <CANiq72kUVbdGGbMnWTQp6kAoq8pbddRVUOPzT=0RjWFf5dtQ4w@mail.gmail.com>
Subject: Re: [PATCH 1/3] rust: net: netlink: Migrate to zerocopy's `IntoBytes`
To: Sagar Taunk <sagartaunk@proton.me>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 9:17=E2=80=AFAM Sagar Taunk <sagartaunk@proton.me> w=
rote:
>
> Signed-Off-By : Sagar Taunk <sagartaunk@proton.me>
> Signed-off-by: Sagar Taunk <sagartaunk@proton.me>

It seems you wrote the first one by hand? There are two typos there.

Thanks!

Cheers,
Miguel
