Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D2C3603C3;
	Sat, 12 Sep 2026 06:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789194364; cv=none; b=qdDOwBzo6tqxgoFZRntc9hJMnkfMECNKswMVTJW5lfrme8IuvdmVEBiJstBSJ68CwEyiyk3ARz8vBynWGGfxKQuiNuds7aPCJBc5QaJFFkNN2AsuqykE4hni+bay2VNjI50+SDRJDwAST+N3Stljrtf3HoPaDyZjUWVW+xZ7L38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789194364; c=relaxed/simple;
	bh=LXFB/ZwOqDYyjksqQ2b0dmXeG+8rjPHlC4T+NYMGW5I=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=IeCIhM55a3qrjHI47Nkg9ruxOD0uwG85GyOZcYI0AURFXDbTREr8vGWX+DZyI2RgaenzyfqdijRF62KInEcf+p7kCmLZXqmuGlJglGOqTIvei2MtyOF7bK27qTtryhUynm5Z4XuL48ki9+SoeKvNafsMHp3RDz5lbxABzogqxjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=CqvRM8QL; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="CqvRM8QL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=umyhfihd7raclp6qpvkn3iaxra.protonmail; t=1789194350; x=1789453550;
	bh=2Ln0c+cFT05cfCP/yMw4EfUk9itFzGT2tqOdce2BmS8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=CqvRM8QLQi+3tntgR/hLfo4OXkJKcnbL5ZpLS1ki62eT57pC5I55cv3vCIkOzM4lc
	 fwM5yKzqV+5QQVDE/be1XqQbelLrDzQ/gvWoU1IlyIMjIdnmfkLp2uZqZImqURn8RR
	 /vxAQBf83397UbEoDs9RuvRufnNI4OQrmUEXs4QfevzsMGyeELF1c+Ji0EuBcthomJ
	 zl5h5iFSetPJ5cm1tKFPGdY/KeyjbJts7B2yIbcXZtsttPcPAyvnZ4yxDE3nJNZRS9
	 t40JjuXDbKB2l5tPJ1M1YfBhIp5YTdUR0SiPFtXPbHAHJrhhnMZ6R0xWB9yMK0G/Hg
	 mwr9/nsSlXX7A==
Date: Sat, 12 Sep 2026 06:25:45 +0000
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
From: Sagar Taunk <sagartaunk@proton.me>
Cc: Sagar Taunk <sagartaunk@proton.me>
Subject: [PATCH] rust: net: netlink: Migrate to zerocopy's `IntoBytes`
Message-ID: <20260912062536.363720-1-sagartaunk@proton.me>
Feedback-ID: 130121444:user:proton
X-Pm-Message-ID: d76dbb697311a0626cdb87e99dc332e72c880d27
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Replace the kernel's own `transmute::FromBytes` and `AsBytes` traits
with their zerocopy equivalents. Specifically, this updates
`GenlMsg::put` to rely on `IntoBytes` for converting attributes into
byte slices.

Also, add `Immutable` trait bound on `GenlMsg::put` as zerocopy
splits the `no interior mutability` guarantee that `AsBytes` bundled
together.

Moreover, shashiko pointed out `put()` trusted an unchecked `as` cast
from `usize` to `c_int` for the attribute length. A length larger than
`i32::MAX` wraps to a negative value in that cast, which can pass
`nla_put()`'s own signed `skb_tailroom()` check and then be reinterpreted
as an enormous unsigned length via `__nla_reserve()`/`skb_put()`, leading
to a kernel panic via `skb_over_panic()`. Validate the length with
`c_int::try_from()` and reject it with `EMSGSIZE` instead.

Link: https://github.com/Rust-for-Linux/linux/issues/1241
Signed-off-by: Sagar Taunk <sagartaunk@proton.me>
---
 rust/kernel/net/netlink.rs | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/net/netlink.rs b/rust/kernel/net/netlink.rs
index 22ef3dde36fa..f929f63b32c1 100644
--- a/rust/kernel/net/netlink.rs
+++ b/rust/kernel/net/netlink.rs
@@ -12,11 +12,12 @@
     alloc::{self, AllocError},
     error::to_result,
     prelude::*,
-    transmute::AsBytes,
     types::Opaque,
     ThisModule,
 };
=20
+use zerocopy::{Immutable, IntoBytes};
+
 use core::{
     mem::ManuallyDrop,
     ptr::NonNull, //
@@ -84,14 +85,22 @@ impl GenlMsg {
     #[inline]
     fn put<T>(&mut self, attrtype: c_int, value: &T) -> Result
     where
-        T: ?Sized + AsBytes,
+        T: ?Sized + IntoBytes + Immutable,
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


