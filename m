Received: from mail-244121.protonmail.ch (mail-244121.protonmail.ch [109.224.244.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B474B66E6;
	Thu, 24 Sep 2026 18:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790276332; cv=none; b=srmbeH55XbdZ0f35pD5HrJ0Q49wNUsC33+mdY1qmMMIGkjJrd1YUl3KMFQRpe78lC+5Mv2g0h4wxt5THxcRrwMckkxKzC3Vln84OhnCA9zeLFiO1ftMI+e2bKGFGs/MB8m1LSWob+0xmVv3SpzAmvNW6vWPdd4yjLmkjjqo9iZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790276332; c=relaxed/simple;
	bh=LCjDkiCWzcUcSonItUlTQ32GHbVlb2rnRHmwduEfFbA=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=CnViCoTnIQIWSPyKr/uyThlkDAcir5k7SgyCmpAHaZa+cnTqdBWqO6cqZsWp7Gyt7Ht0y8Alkl4EwtoBce6/l73tKZXbap0IpNZhm41vKmckuCEUNWFQ3yAbs53XlpqR/TzMpfiXzu2TyU7DphTthRzqDUY5HsIDHM6iaV3syl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=lunzS5U7; arc=none smtp.client-ip=109.224.244.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="lunzS5U7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1790276312; x=1790535512;
	bh=MRl6B3uS4CzjJc4nJQyySJ6LpSJ3HzGC1fjJzNfOmq8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=lunzS5U75UnfPuH1CFlqPAQvn0+fOW400Zv/x65cyP//j2AS7rt1dur3whemXo6Cn
	 AOVdiXwxLPbCK5je7ObRTkd7EUFdizJrNeE1jwXoSk59UyTdH7uSBuS+YtgHu2VFwx
	 ZXiV+fmbZHXs2jPkSptDL3MtV5b2IfxMcstnNbUGXFuHxUvulbT1/qSYGj03f2FH9z
	 mI8Q9wrg4V5MGXVg4J+NbV/saHA/uqb/3e27ju77n1Plpp6RSFAJeqkhyIM1NWz6HF
	 GU+5bfnJtuPrGlGg5xrqR/bWEQKtJx/XsiXv0HPDovlRiarGS+2efVtNs3ZwlDgcd1
	 ZWzs7V7oZ79Eg==
Date: Thu, 24 Sep 2026 18:58:25 +0000
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, Matthew Maurer <mmaurer@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>
From: Sagar Taunk <sagartaunk@proton.me>
Cc: Sagar Taunk <sagartaunk@proton.me>, Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5] rust: net: netlink: validate attribute length before casting to `c_int`
Message-ID: <20260924185809.18216-1-sagartaunk@proton.me>
Feedback-ID: 130121444:user:proton
X-Pm-Message-ID: 8984ac35a21b4d282058f2286b17f967c45530e5
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
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Carlos Llamas <cmllamas@google.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Sagar Taunk <sagartaunk@proton.me>
---
Changes since v4:
Rebased on net-next no functional changes.

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


