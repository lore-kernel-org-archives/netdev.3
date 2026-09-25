Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB5A4825C4
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790327609; cv=none; b=oNzq50QPTrzvbQtWG00qTIFOws4FaVDvhOP+s2/30hS7zT2dM2TNWTusJz479aLV3mKhIghkzPvLgZwtqLvuKuJoNymiXGf3MC7FzhDWaGvDPOcUTfPc10Rvsn8qcP7QZonzg/Ri0bzc5qcbhKcWVc6zIA1Vocj1zHnZ8uSRKZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790327609; c=relaxed/simple;
	bh=zL6QUn1TpvWtmYgwxcSIkriDKPEG/scU+3oxMlrKFZE=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZvRr8ArqiEvI9SiNSTUXhjtzivaiMs9mL3JsyUBs7RxqQckdqkph4rjtdpTcjbE7SjWFk8x0LD0z+zNrCu9qgGFmK6ZdZ0mlBJhZHTWoIyr9idVkcDERzFc+ydotYbaSswBo/rT2A3zPaP9SR27uG5fpq6cUMgaKnchvrTPeSeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=SF9qMH9I; arc=none smtp.client-ip=185.70.43.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="SF9qMH9I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1790326509; x=1790585709;
	bh=zkohvUbYW8D1KYV9baP5FqoHLALhVh3cVlMGQa+d5Hw=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=SF9qMH9I82BQQ4bubbNt4y7V1oCvLulO2dx1qcoWcLRhVxeSNtW2CPxT4y/VZVbhg
	 CmyEgABO5bYHHB38MpGVKDXLoK++o19for5m3lKUgx8enCqp6LwipmbTVz4m44N/D9
	 LAdog5N38pa0qCHIf129o7rrsdONFqPjXzEFUSkaEP1Sm36HWq4rXtRcODwcDYgdLm
	 Qao+nJrBQx4jjCgVnCxQw2kv3lqAZgnF/IAYyHyv1Z6R7C47wPw9DbBzsgrhDnBYlS
	 pcO/f46yrU83MUvfX3vZXxX9l5AnuOdV+J8dqdWc2P4aF0wzF/tlmRVByn1vtdiYB/
	 XqOqJkWqrKeXw==
Date: Fri, 25 Sep 2026 08:55:04 +0000
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, Carlos Llamas <cmllamas@google.com>, Matthew Maurer <mmaurer@google.com>, Andrew Lunn <andrew@lunn.ch>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Sagar Taunk <sagartaunk@proton.me>
Cc: Sagar Taunk <sagartaunk@proton.me>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net v6] rust: net: netlink: validate attribute length before casting to `c_int`
Message-ID: <20260925085449.22553-1-sagartaunk@proton.me>
Feedback-ID: 130121444:user:proton
X-Pm-Message-ID: c5cf01b9f15066f4acb72ad7d1d2fa3474d02485
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
changes since v5:=20
Rebased on net/main

 rust/kernel/net/netlink.rs | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/rust/kernel/net/netlink.rs b/rust/kernel/net/netlink.rs
index 22ef3dde36fa..2f8733a694a9 100644
--- a/rust/kernel/net/netlink.rs
+++ b/rust/kernel/net/netlink.rs
@@ -11,6 +11,7 @@
 use kernel::{
     alloc::{self, AllocError},
     error::to_result,
+    num::casts::u16_as_usize,
     prelude::*,
     transmute::AsBytes,
     types::Opaque,
@@ -86,9 +87,17 @@ fn put<T>(&mut self, attrtype: c_int, value: &T) -> Resu=
lt
     where
         T: ?Sized + AsBytes,
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


