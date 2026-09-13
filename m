Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4012333C188;
	Sun, 13 Sep 2026 02:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789265885; cv=none; b=EtuaOwc0ShwHwIidxrJ3oGCR7yLJnw2X58pkhtZdN9rjLmgVyRxSSZM6yvMs24/FnpQbppMSSWQwv/oQI4oe5Kuclwbl92cHKKYaQNU40CYylC/xrNBdp4RpEZqf7k2u2ssdJycXeAqoHb0Y7xTi+Is8GHfFqnHUZicFbo/ZMh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789265885; c=relaxed/simple;
	bh=ImET7BowbneY2SrCjl5Env75p1P2HuYBPRThbFYyeVQ=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=DcHInVmwqgneEwd070z5mqqmsjljp/4JgeIASOc9qoFmSpmDEMmJWrTViAyjptygUYLwoiIqwlEQsdXc6ruLdGwPN+cOGj25OhxW41ybByPmjR0LVyJ0tKXu/kNCFvGBgMSeWNarXGjycGWJ+Zc259vNYTMzj6S7iK1hyZbdiUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=PF4FrK+U; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="PF4FrK+U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=yethrllu5jcsrg6mxaeb5gnv2e.protonmail; t=1789265864; x=1789525064;
	bh=iw8oX8JtR6bTfziyCVzbNW2Gel2C1vbzYFNWTbj7CWM=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=PF4FrK+Uh6gvmU+6iUQaU9iwuxrUc92W5FJxa9l21DiSV+Uiad9kX20JAEzLGyeUN
	 wLvffnoTFXvNCjkeunuLDkG7CcfAVxbH8SK1/adgpRh9EFCuHDEJfHbvtlVSVYpB/9
	 IFaA0/qj42WiRmOBwO8vTkU0I8YUQSyreJ2IlhYenSoBK7PkzrkAN9LdBMKkH4rIiz
	 AAiMSd4wieXSDFsxwHeZNWr4Hr/L1TqZi20/k80HwPGFEuDEYI/Gg0cMn35oO0Fcue
	 dNQSSnO+5TbxuL0Esx2jXVX83hkV5qTGnTHAzB8ywPwPg+h/4FJXGptlofm1lGZuqR
	 3Ha+2qWCeE6yQ==
Date: Sun, 13 Sep 2026 02:17:38 +0000
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
From: Sagar Taunk <sagartaunk@proton.me>
Cc: Sagar Taunk <sagartaunk@proton.me>
Subject: [PATCH] rust: net: netlink: validate attribute length before casting to `c_int`
Message-ID: <20260913021730.18926-1-sagartaunk@proton.me>
Feedback-ID: 130121444:user:proton
X-Pm-Message-ID: a556036479531143b34d59edef58ea35b16a0f84
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

As pointed out by Sashiko, `put()` trusted an unchecked `as` cast from
`usize` to `c_int`. When the length exceeds `i32::MAX`, that cast
wraps around to a negative value.

`nla_put()`'s `skb_tailroom()` check treats the length as signed, so
the wrapped negative value slips past it. Further down, `__nla_reserve()`
and `skb_put` reinterpret the same value as unsigned, turning it into an
enormous length and triggering a kernel panic via `skb_over_panic()`.

So, validate the cast with `c_int::try_from()` instead, and return
`EMSGSIZE` when the length doesn't fit.

Signed-off-by: Sagar Taunk <sagartaunk@proton.me>
---
 rust/kernel/net/netlink.rs | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/net/netlink.rs b/rust/kernel/net/netlink.rs
index 3c2b142a7402..f929f63b32c1 100644
--- a/rust/kernel/net/netlink.rs
+++ b/rust/kernel/net/netlink.rs
@@ -88,11 +88,19 @@ fn put<T>(&mut self, attrtype: c_int, value: &T) -> Res=
ult
         T: ?Sized + IntoBytes + Immutable,
     {
         let skb =3D self.skb.skb.as_ptr();
-        let len =3D size_of_val(value);
-        let ptr =3D core::ptr::from_ref(value).cast::<c_void>();
-        // SAFETY: `skb` is valid by `NetlinkSkBuff` type invariants, and =
the provided value is
-        // readable and initialized for its `size_of` bytes.
-        to_result(unsafe { bindings::nla_put(skb, attrtype, len as c_int, =
ptr) })
+        let bytes =3D value.as_bytes();
+        // `nla_put()` takes attrlen as a plain `c_int`. If `bytes.len()`
+        // doesn't fit, an `as` cast would wrap around a negative value.
+        // Which then, would feed a huge unsigned length to `__nla_reserve=
()`
+        // and `skb_put()` causing it to panic via `skb_over_panic()`. So,
+        // the following check will reject it instead.
+        let len =3D c_int::try_from(bytes.len()).map_err(|_| EMSGSIZE)?;
+        let ptr =3D bytes.as_ptr().cast::<c_void>();
+        // SAFETY: `skb` is valid as per `NetlinkSkBuff` type invariants.
+        // `bytes` is a valid Rust slice, so `ptr` is readable for `len`
+        // bytes, and `T: Immutable` guarantees nothing can mutate `*value=
`
+        // while `nla_put()` copies it.
+        to_result(unsafe { bindings::nla_put(skb, attrtype, len, ptr) })
     }
=20
     /// Puts a `u32` attribute into the message.
--=20
2.55.0


