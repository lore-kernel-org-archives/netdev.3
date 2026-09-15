Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E943A7D82;
	Tue, 15 Sep 2026 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789483377; cv=none; b=YSuy4zEyhF5yF5PYlt5QV7HoNmCzA41z0wKeuhW8g1mTGlNpLBi/wzk8WYVIhgiD2gA/r23cwkd4wC8S9iUB4drVZHmsDnCRGaFtHImoGV9hnNSIo7a86Qe7O5CueFjER3K9jksEXeHdgH9Jaftwlvs0TMsuHt8SDfOedIxXQt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789483377; c=relaxed/simple;
	bh=uqyxUbuFwn0w2qmd7JxPK3AxYfVfFejjie7DAbPSOeI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=tArm3TC69AFhPDl0ztxYToOyym8zx1iQfVg+hFPa+9b7FplHNY49K4t9Y1zFvaEZNqk6HoFNgX1QGCtZE63r5WTRstNuERLSRKreDlzv+25s4ZJsHQ5PQoZI6fYD3n30dsi1RZv3NNbm8S+E6/w7BgY0J1OkiYAuHNBNX21F9dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=cIAwMP7g; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="cIAwMP7g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1789483370; x=1789742570;
	bh=RTlHcToK2mFD9e+cRKukCJbYOXYr3KFuX1ExzHA1mMQ=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=cIAwMP7gFG4GJMmJZv0tK9N9Y1TtfDaIamDeRZpRMo5f2HkBDNHhHH/Il2cNVXKgJ
	 AvApC6AzolIb8yNiomx2ypiNxeVT5giigMeyJ2HUC1RItY9tJnVyKn9JfmZSfW3YHA
	 6PWemMNB+4XPPMDcc0aI+f/Z7/9kAlkUyI0Bwba/KFBmFtrs2G6KgURM02VQ1DPjuf
	 Z46b1IO8K4gZpmZp0o2QXZlMdV+HQ+C2uRdIE2zaBW6HFTLaldBDBYUgQ73734GUCU
	 JchsSL7X4kohOXikItw+7sxoT2fShyVlF90ZlTF79rInuuQKiwEFa5h+gDK3F45NvO
	 JqqK0VwDKA8Lw==
Date: Tue, 15 Sep 2026 14:42:44 +0000
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
From: Sagar Taunk <sagartaunk@proton.me>
Cc: Sagar Taunk <sagartaunk@proton.me>
Subject: [PATCH v3] rust: net: netlink: Migrate to zerocopy's IntoBytes
Message-ID: <20260915144231.31932-1-sagartaunk@proton.me>
Feedback-ID: 130121444:user:proton
X-Pm-Message-ID: c3c111c2728c0801e02fc529e68195861deddbfa
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
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
---
Changes Since V2: Follow vertical import style as told by Alexandre Courbot=
.=20
No functional changes.

 rust/kernel/net/netlink.rs | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/net/netlink.rs b/rust/kernel/net/netlink.rs
index 22ef3dde36fa..a2f4bd171dcf 100644
--- a/rust/kernel/net/netlink.rs
+++ b/rust/kernel/net/netlink.rs
@@ -12,7 +12,6 @@
     alloc::{self, AllocError},
     error::to_result,
     prelude::*,
-    transmute::AsBytes,
     types::Opaque,
     ThisModule,
 };
@@ -22,6 +21,11 @@
     ptr::NonNull, //
 };
=20
+use zerocopy::{
+    Immutable,
+    IntoBytes, //
+};
+
 /// The default netlink message size.
 pub const GENLMSG_DEFAULT_SIZE: usize =3D bindings::GENLMSG_DEFAULT_SIZE;
=20
@@ -84,7 +88,7 @@ impl GenlMsg {
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


