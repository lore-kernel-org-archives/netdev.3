Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A377394EA7;
	Sun,  6 Sep 2026 10:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788690541; cv=none; b=LhogCN68IwQRSIFqY0GslIFHnsvYXmrxdtpkinNhpYxn5WHC+GiAxu41/1qIx86d4dPTOgAL1vElzfkpPR5y1ABd0oaUiyWqV7pTwbDHlNB7xyiT5gYm9Jjp84ht9DXZFdc2vq5vfUknd7yHkCILI5rJE8g3VpoXgV77I285ZBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788690541; c=relaxed/simple;
	bh=ynRHsB0rPgolb7fdfyRkCtQgSz+nlUJngxRzFWHzoKk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+T+RvUkGlSnsXnuw+Tftuk5O33t5V0onshHsBe5OcRtUQXHm4HnyVKKCMBD0AS01B/XmrusTTctgaX592ooWPC6BXvqRuL59teS66ZAJzy5MPY8b+rQJE4i+mRM1m1W9ad5FzTwymWOwlsBab3PEHKHDp0cPOye4AMUuWXMAMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=XBEc04Au; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="XBEc04Au"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1788690536; x=1788949736;
	bh=tP659RLA9s5qNftKGJLlD1bl1sHOz2kkTiGEXzdTQ5c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=XBEc04Au+VgILSvhkfcvwHnwdC2LDukix+pztumDnGJ308YOxZO5ZNNxl4KEOjfch
	 FI0dgnk0MEmJAPIqhXTyVNKFd24yLKjaPcJFGg3khvaOgdiUPvcxJQai1IoRq6sTIS
	 WHJ38aJvZAkRXhEHXWlkyYoNJKkKBG/VQaDpLY0ZkhAqqwaOy1AskDsS7PP7N2BYQu
	 WWgLJ6b1O1jWt3F2bqOBXysrGR+qdMHByVphYAZvBBHupqlAwVz+5aheSUCXDzJQ+L
	 y7Fcd4pWv5vGRCHTvFdZ9fE8p1KhMTfaGGCkhvH51pX0PoaVqWBeVqrO/owkOUENd6
	 iUe0A8vJd5vzg==
Date: Sun, 06 Sep 2026 10:28:47 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Danilo Krummrich <dakr@kernel.org>
From: Sagar Taunk <sagartaunk@proton.me>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Sagar Taunk <sagartaunk@proton.me>
Subject: [PATCH v2 1/3] rust: net: netlink: Migrate to zerocopy's `IntoBytes`
Message-ID: <20260906102826.202874-2-sagartaunk@proton.me>
In-Reply-To: <20260906102826.202874-1-sagartaunk@proton.me>
References: <20260906102826.202874-1-sagartaunk@proton.me>
Feedback-ID: 130121444:user:proton
X-Pm-Message-ID: 9e8ba046a928d64ad136061a529b4ed5de3c58b5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Replace remaining imports of kernel's own `transmute::FromBytes`/`AsBytes`
traits with their zerocopy equivalent. In this case, `IntoBytes` which is
already re-exported through kernel's prelude.

Link: https://github.com/Rust-for-Linux/linux/issues/1241
Signed-off-by: Sagar Taunk <sagartaunk@proton.me>
---
 rust/kernel/net/netlink.rs | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/rust/kernel/net/netlink.rs b/rust/kernel/net/netlink.rs
index 22ef3dde36fa..c3b50dd50a4c 100644
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
@@ -84,7 +83,7 @@ impl GenlMsg {
     #[inline]
     fn put<T>(&mut self, attrtype: c_int, value: &T) -> Result
     where
-        T: ?Sized + AsBytes,
+        T: ?Sized + IntoBytes,
     {
         let skb =3D self.skb.skb.as_ptr();
         let len =3D size_of_val(value);
--=20
2.55.0


