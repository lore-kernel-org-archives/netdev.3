Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF133D566F;
	Thu, 17 Sep 2026 13:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789652759; cv=none; b=dUoGMTeRTtEoBhGbScBy70L6aD5/qJ4IJOA6YQp4kR7DfHWSkWmPxB4WIFZXkvC5FCOLEFygrrf+VhBM0UYbVYJCSCJse2L/21A3shoFdjwfex7E4g/nk8yEbsbuL4lua88bedZUa2GxPn5qU3kMMpZOL4GKyQOAJdMhAF+Ck3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789652759; c=relaxed/simple;
	bh=0aBjkdR4UR77mZaQN03FPwAVBbGKW4UBYvZBXBGWdgo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kMkdBEAD0fHmdNePKtO0fl9AGTHCqDOeJPSIMSDJTqijpqLEvkrm1Ti+xDbKWgvX1aQZ4WYOi0JnKnNAs5QUFQFlnhBn+vi/f6Ggh9dVj9xQ9wJf3CfnmCkBvufu962KJcc8J+luEa4StI9mDGu+wfzQOEskgmweFAequuEChX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=HONMuTmU; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="HONMuTmU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1789652735; x=1789911935;
	bh=uY8GV1Tb1njnq5CRvS7gPHrkYnM3Z+LEuT/WlGlwG4I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=HONMuTmU0oltMLUvOPvveuEtkqEDI7P5ti4AxuTKYiQ18leknWf4oPaspdvTXX/1a
	 mFO2Vqtpp4h3bBUJkI1QUo+jjxIiY94HKj5kUrSvf1YigueqvB5C/N0XshsJwzHvgT
	 Os/onKGenaHHJR8v2oboQQPp/qQaWtq75ei1/QYCIu96dvfFYWeZ5KQ3TLtSN+l1sY
	 TzcQ3ThprVeBg5uWdu8Jm/t7twoCJTfYtUiWAhRqyJDyxe+ezAyPWoTZYoMREeLM2n
	 VhzFkLyJJ+r3xz2rF0+08Bj4qsm7UQXie5OuivwGt4dyqjCeesfOLBIgrD5uaPn2HH
	 faA47rfLwU1Uw==
Date: Thu, 17 Sep 2026 13:45:30 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Sagar Taunk <sagartaunk@proton.me>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: net: netlink: validate attribute length before casting to `c_int`
Message-ID: <OFpa5lCrCbU3qGep0CtUhaT89qRwVqHY_LWoHC27noLYmjqgp8kAvHrnng6MEzqlqF3zvapYJrpFBpfjf9XiNfxtR-GwhnFMeIj94mKfKCE=@proton.me>
In-Reply-To: <aqu0bzgMAUQe_LZ6@google.com>
References: <20260915164000.124340-1-sagartaunk@proton.me> <aqu0bzgMAUQe_LZ6@google.com>
Feedback-ID: 130121444:user:proton
X-Pm-Message-ID: b0745fc7f76395deb99f3859023ec5869fa0b10c
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks for the review. Also,I wanted to ask what do I put in the `Fixes` ta=
g?=20
Like the commit which introduces it or explain the problem there?

Thanks,=20
Sagar Taunk


On Thursday, September 17th, 2026 at 3:05 PM, Alice Ryhl <aliceryhl@google.=
com> wrote:

> On Tue, Sep 15, 2026 at 04:40:10PM +0000, Sagar Taunk wrote:
> > `put()` trusted an unchecked `as` cast from `usize` to `c_int`.
> > When the length exceeds `i32::MAX` that cast wraps around to a
> > negative value.
> >
> > This ultimately resulted in a kernel panic when the reinterpreted
> > value via `__nla_reserve()` and `skb_put()` became enormous.
> >
> > Validate payload and header both fit together in a `u16`, rejecting
> > any payload that wouldn't leave room for `NLA_HDRLEN`.
> >
> > Signed-off-by: Sagar Taunk <sagartaunk@proton.me>
>=20
> This should include a Fixes: tag if it leads to a kernel panic.
>=20
> Can you also update the subject to [PATCH net vX] according to the
> guidelines in: Documentation/process/maintainer-netdev.rst
>=20
> The patch itself LGTM.
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>=20
> Alice
> 
