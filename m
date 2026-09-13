Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69293451B3;
	Sun, 13 Sep 2026 02:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789265913; cv=none; b=tUT/dAP0lvcJ7HeAfTxCRg3q/1ID9ZzFQb1XNgO/gSTV+zrCYVKFFVZ34zoFFL3CmeL+LG0uUaXG0HIFKVNDnJ5v+prPqULtuWOS90BHkZqEgv3IksSkSuk5kVpSqkLoL8fOQLM4DkCE+LiULjih/GKQJIsTqHVCguU33ETW4ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789265913; c=relaxed/simple;
	bh=16oi9ly1u2ldB9w7kIk+fAa1tFvrCNW02ronDoL8CGw=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=oiX6qAymRwvl8NOfVcqXTRcaed82tLV/365sNTRtDZHIXazEqW6bV3jj3w8JA8P8DrHt60KJuRIpV9Ym/+nBQfMzq9Pst3WiQGqv+Y8NF1amaB+MGvhABBx1is5xKlVncn0BqJxiZereVOq8T33KMAAJ2jna0sxXBdmD7mpZ7Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=B4otVLyu; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="B4otVLyu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1789265903; x=1789525103;
	bh=oP+Fm5f7FOJsKi+1wYYcRlqrgXpreIiFFEpdGNZk4ZQ=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=B4otVLyu0ZCWyCLmQlGwTrNvov/HnGEypzQcbDtMiL1+EBQOIVaBm9AQsDjidwSIu
	 dJt6NfMuL52oyhmE4uBc2cSkzkMTPwLr8X4O7BHQn/IBJqwaqLWJhViPMe1em3Z0WW
	 I6yBLJ9ojLM9wF3O8cA2PL7ghAc1dp8Nv9zPUkxsst1Bj5J8W5mRdk97tFdGYJfLJr
	 eqoXsloeCwWAnY+Srikfh7gO/fXzqmOUfhlzd9FTEDAgtfJjd8DJNjqPB348zwz/wF
	 Y2t59XzR+RyUTM6Fed8HAGmrLrY5xEGN0VmIIklNE5DMRpVLIIT4TDhdAlAKA/s3DY
	 ekr1pfRKMUCYQ==
Date: Sun, 13 Sep 2026 02:18:15 +0000
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
From: Sagar Taunk <sagartaunk@proton.me>
Cc: Sagar Taunk <sagartaunk@proton.me>
Subject: [PATCH v2] rust: net: netlink: Migrate to zerocopy's IntoBytes
Message-ID: <20260913021805.19062-1-sagartaunk@proton.me>
Feedback-ID: 130121444:user:proton
X-Pm-Message-ID: 9c8dc56ef59e2931baae90e8a8d4c826a3937692
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

Link: https://github.com/Rust-for-Linux/linux/issues/1241
Signed-off-by: Sagar Taunk <sagartaunk@proton.me>
---
v2: Split into a separate patch per Shashiko's review; validates the
    attribute length with c_int::try_from() instead of casting with `as`.

 rust/kernel/net/netlink.rs | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/net/netlink.rs b/rust/kernel/net/netlink.rs
index 22ef3dde36fa..3c2b142a7402 100644
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
@@ -84,7 +85,7 @@ impl GenlMsg {
     #[inline]
     fn put<T>(&mut self, attrtype: c_int, value: &T) -> Result
     where
-        T: ?Sized + AsBytes,
+        T: ?Sized + IntoBytes + Immutable,
     {
         let skb =3D self.skb.skb.as_ptr();
         let len =3D size_of_val(value);
--=20
2.55.0


