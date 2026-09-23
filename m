Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AC621A459
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 08:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790150850; cv=none; b=Ufvp87gDYcOKXOClI4XOXi7aRZ1dt5AQiCac4C4Ng3rqqp1unikmLmB3x0JzWjzW58fH6UMpsnHWmFrkPGEaOgSFvkShLxV9OJL+gcGZS3KKexQNRFGZ7RyqykhQcsz0z8RY7ocbPoQY1et9Ic5A99YfxOF8Soj9531fL+6lKYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790150850; c=relaxed/simple;
	bh=l6dvS0wUgx3Im4ueFWM0xdoJnbgIScD4aughlsyleGw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FaoWTcJxBFLBdvFa9XwrjKhcCxEgOqxpomkU3445IrWJ+qJ1rEm4iQppnPr/kBjlue25ya+P5fdxi3X1hUZGS+bDT0iOcd8akD7oLhKt2KJDhHKdcvUrNvQNURbA43isfDYIbHJazCEnFCglm8jJ6uV4clzSWsAvjxz7O+7qcMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=LkOpiu+C; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="LkOpiu+C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1790150841; x=1790410041;
	bh=l6dvS0wUgx3Im4ueFWM0xdoJnbgIScD4aughlsyleGw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=LkOpiu+CPZrsXnbQj2ZwpdkwdRmNiIXqtwcdUOzJZiouJcX53YREOAVFpdXZUJ36m
	 DoQMNPwtqJChC0hNY2P8GFabeYEAVoo3kxqwMqOjnyTAa/jl31xFkszKJquG0xsK5S
	 dASfQHyu8Q6JWuLvv+PdhAaFzJPZ1rKFzroGmSC7rnxzG31UKGFcvIudsFz26zcBtJ
	 /M1UjpEKK9p0bQyCWgYN3TUuoXjgSnIFInKsBXBI40TriLbt5xVBhOZcq1yAY+kIsk
	 i3Z+rLLcfo0w3Z6JBx7XHt/edHDWQbrVi9VYEtM9tekTHdUHnzmwMuT/VsClcb79cz
	 z7W9084nIWA4A==
Date: Wed, 23 Sep 2026 08:07:14 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Sagar Taunk <sagartaunk@proton.me>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, Matthew Maurer <mmaurer@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] rust: net: netlink: validate attribute length before casting to `c_int`
Message-ID: <_OvWoTp4DaMWPlCDpP6QCis3vmI9jsT_GeJVq8e-7S_FvY5zurx-iRSvWy-rPwHnRGVixK2i7E_QybBBgX4YZVrXfsFbm6IwjmHpBvkoBuM=@proton.me>
In-Reply-To: <CAH5fLgjBC7o4wt0WPH6xEkQEkOvsjj0ymLq2xAGXoMwN-fZyBQ@mail.gmail.com>
References: <20260918100016.100988-1-sagartaunk@proton.me> <KZuCCqRjSSbylbLLVhoUD9-xyBpzD9jUB4vGC16N0_hIra8SNxFeh9lEJ6FIMYMgKqf41J_swYT_HVx3w13k0cSrYYkBljOF56suy3gpgAU=@proton.me> <164304b3-3324-45f1-8766-536767e7b9d7@redhat.com> <CAH5fLgjBC7o4wt0WPH6xEkQEkOvsjj0ymLq2xAGXoMwN-fZyBQ@mail.gmail.com>
Feedback-ID: 130121444:user:proton
X-Pm-Message-ID: 6e75dfacd04194a66bfbd7cb49cd6a1a1836049b
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Should I resend it after rebasing it or would this be fine as is ?


-------- Original Message --------
On Tuesday, 09/22/26 at 19:12 Alice Ryhl <aliceryhl@google.com> wrote:
On Tue, Sep 22, 2026 at 3:36=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 9/22/26 04:31, Sagar Taunk wrote:
> > Hello, are there any updates for this?
> >
> > Also, I wanted to ask is it fine if I keep fixing stuff pointed out by =
sashiko for now ? (I.e pre-existing issues pointed out by it in other's pat=
ches or should I ask the original authors of it first ?)
> Does not apply cleanly to net. Since a repost is needed, you must
> also avoid empty lines in the tag area (i.e. after the fixes tag).
>
> WRT sashiko-reported issues, beyond be aware of false-positives,
> generally speaking net-next is the preferred target tree (i.e. no
> or very limited impact, very old issue, etc...) with no fixes tag.
>
> Focusing on high stakes changes would be appreciated.

From my perspective there's no issue in landing this through net-next
instead of net, as it's not urgent.

Alice

