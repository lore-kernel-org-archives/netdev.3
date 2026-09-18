Received: from mail-07.mail-europe.com (mail-07.mail-europe.com [37.187.220.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7979F347FC8;
	Fri, 18 Sep 2026 10:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.187.220.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725673; cv=none; b=YTl/BEQnr5BCkwZagh7RZlZqeQELhM3TqcyQVrbLYTfRs0hYXCXpOrZHuOqY2jGKLjcGwthepkGJ95acCI5+8mVaQhJ7cRWs4m3y5ShVyU4m2UR1g01K8CYwj5vFEoO2l9aHSqHvy/RlM6mu6RVp1yGeuy0tzZtIu66wKnShNAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725673; c=relaxed/simple;
	bh=SVQdR7Hvldsh04gyqvgaHic1uObbYkByaXRiswF6xC0=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=fIVUNhbDXpZb6GiStOx0iqemoWZ4OC0ANSNdIYwKaO5qBQxgkMcFnURFFog2q12s8D58wiwZt8LINdpph29NeOMPAQJqrt36jOIDk2d1sdUJyD+8JQjpQ42gY9FFskAogCn2e/xjmAn5VavDKqF5JUfrfpuRZ06MoBZppmp3Keo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=gvCakgPs; arc=none smtp.client-ip=37.187.220.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="gvCakgPs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=y2bsphlpqbgxvhk3iopnvqdqla.protonmail; t=1789725654; x=1789984854;
	bh=xH28231KbdWNCkYH6yBlfPMfsu3w/IVynwfui1wNcLk=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=gvCakgPsabxtPOc0Ay+gQcTEbW3mGScBGPjM30BoEBO1w6aZNJaa+ahMUceaYRL1K
	 pRjOgb/H0Pcm6M8zLXlYeOp5v3M6e89gz/h8EvVmjhZmfRwVdneawD7P0kJxlFMu8T
	 gcbXUMmtE2Xi52D4rf42iKsCSJNAVb8lM45yciLO8UhsNMsPzdv7Z39DKw4P5n31Vo
	 2tm5K9u2lgc91+TUTfgQdi1Ev2p/ynSFAamUQyGcDoOHlCY82RpAUN4izMwZ350k+v
	 4DgRrMvuxwUry4XjpSxfvjDOhSM0iw87LWGE2k42E+ROkU+cz78FbMOkp+pFvlGWl5
	 Xd7h8GC/gN2Mw==
Date: Fri, 18 Sep 2026 10:00:48 +0000
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, Matthew Maurer <mmaurer@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
From: Sagar Taunk <sagartaunk@proton.me>
Cc: Sagar Taunk <sagartaunk@proton.me>
Subject: [PATCH net v3] rust: net: netlink: validate attribute length before casting to `c_int`
Message-ID: <20260918100016.100988-1-sagartaunk@proton.me>
Feedback-ID: 130121444:user:proton
X-Pm-Message-ID: 43a591ac7a101a85c3cfbb87d160fce7aa31ad91
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

`put()` trusted an unchecked `as` cast from `usize` to `c_int`.
When the length exceeds `i32::MAX` that cast wraps around to a
negative value.

This ultimately resulted in a kernel panic when the reinterpreted
value via `__nla_reserve()` and `skb_put()` became enormous.

Validate payload and header both fit together in a `u16`, rejecting
any payload that wouldn't leave room for `NLA_HDRLEN`.

Fixes: 5eaa5fbb6e6c ("rust: netlink: add raw netlink abstraction")

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Sagar Taunk <sagartaunk@proton.me>
---
 rust/kernel/net/netlink.rs | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/rust/kernel/net/netlink.rs b/rust/kernel/net/netlink.rs
index a2f4bd171dcf..36f2e39c3ab7 100644
--- a/rust/kernel/net/netlink.rs
+++ b/rust/kernel/net/netlink.rs
@@ -11,6 +11,7 @@
 use kernel::{
     alloc::{self, AllocError},
     error::to_result,
+    num::casts::u16_as_usize,
     prelude::*,
     types::Opaque,
     ThisModule,
@@ -90,9 +91,17 @@ fn put<T>(&mut self, attrtype: c_int, value: &T) -> Resu=
lt
     where
         T: ?Sized + IntoBytes + Immutable,
     {
+        // `nla_len` is a 16-bit field that encodes the total attribute le=
ngth
+        // (header + payload). Subtracting the header size from `u16::MAX`=
 gives
+        // the largest payload that still fits within that field.
+        const MAX_PAYLOAD_LEN: usize =3D u16_as_usize(u16::MAX) - size_of:=
:<bindings::nlattr>();
+
         let skb =3D self.skb.skb.as_ptr();
         let len =3D size_of_val(value);
         let ptr =3D core::ptr::from_ref(value).cast::<c_void>();
+        if len > MAX_PAYLOAD_LEN {
+            return Err(EMSGSIZE);
+        }
         // SAFETY: `skb` is valid by `NetlinkSkBuff` type invariants, and =
the provided value is
         // readable and initialized for its `size_of` bytes.
         to_result(unsafe { bindings::nla_put(skb, attrtype, len as c_int, =
ptr) })
--=20
2.55.0


