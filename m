Received: from mail-244116.protonmail.ch (mail-244116.protonmail.ch [109.224.244.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2DB392C21
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 10:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788690575; cv=none; b=hJvIThC48VdISJvjIymlKOV87J2YexWP+f9ih4dCegjLL4s9PudWdlLLNIK+pG7Fz9LHl8yYQim367WPJFcSWG4FxNqIW5oEYsZhHZcqSuYyO0JCCt2FOZw3Yg4Ii2JxWP5MDq2rYZUZo0p0dRPZ2C+/rd8KwnnR0uZHqFFybgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788690575; c=relaxed/simple;
	bh=rRCH8gt/5mOkrlJvq466GnwekETqDZn0YclcWLINKjM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R/36x/cZhs/jw6DWpHYO+SwHerXRm2iMgqwIMczkm1zhVtM30Z9Yjm6Hlcx4dnMvIZ+DAVYshMTXQ/+ybEs4ea636TRvTUAqp+wXl/kkhiFTRQQs7PAmcNLiUI44QhM2JnSxf+ZN0BqI6Pc7P23cIM/VhX/sZU8qQs9cHxaR9bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=XeFFx3iZ; arc=none smtp.client-ip=109.224.244.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="XeFFx3iZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1788690564; x=1788949764;
	bh=QcZeDQsDI8IiVvV9Mls8GpNfSv4icCfhUiY5ki37lz8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=XeFFx3iZOMlBRB0osVoQHp8FL6mr7gh/Aa7TIcVzsD9lYKVYE6e6hwQAM5TOzLMCT
	 G9G1/tjYA9hbhsLDAo5vLx5fcIrHTOMZAvpI/gIAayZnXyYVCMFd5ao78YZEK1WYte
	 X64zHT0wvJ3VnTm9sgt+38n1gziSKL4S0dK/N/L0kozGKGNLfPzWZIm2dYkeLWP30k
	 9XpPLIm5laksDHbAQLnn7d84sMQb5dOQ3V3nrnB7G4ZHzqjsE2wQR40zEjPNO1u63d
	 LkW83q4M0utek52d284QpzO5/deD3h0swI+sGR2SfnpLNWAj2GpS2s7kXXhcD6/Z3R
	 A2+74sjuNEx3w==
Date: Sun, 06 Sep 2026 10:29:18 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Danilo Krummrich <dakr@kernel.org>
From: Sagar Taunk <sagartaunk@proton.me>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Sagar Taunk <sagartaunk@proton.me>
Subject: [PATCH v2 3/3] rust: dma.rs: Migrate to zerocopy's `Frombytes/IntoBytes`
Message-ID: <20260906102826.202874-4-sagartaunk@proton.me>
In-Reply-To: <20260906102826.202874-1-sagartaunk@proton.me>
References: <20260906102826.202874-1-sagartaunk@proton.me>
Feedback-ID: 130121444:user:proton
X-Pm-Message-ID: 76b9c1b357a8041559dba81548bae2c6353a0efd
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Replace explicit imports of `transmute::FromBytes`/`AsBytes` with
zerocopy's equivalents.

Link: https://github.com/Rust-for-Linux/linux/issues/1241
Signed-off-by: Sagar Taunk <sagartaunk@proton.me>
---
 rust/kernel/dma.rs | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 2ce09f8e90c6..9bd47f20c784 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -25,10 +25,6 @@
     prelude::*,
     ptr::KnownSize,
     sync::aref::ARef,
-    transmute::{
-        AsBytes,
-        FromBytes, //
-    },
     uaccess::UserSliceWriter, //
 };
 use core::{
@@ -417,7 +413,7 @@ fn from(direction: DataDirection) -> Self {
 /// ```
 pub struct CoherentBox<T: KnownSize + ?Sized>(Coherent<T>);
=20
-impl<T: AsBytes + FromBytes> CoherentBox<[T]> {
+impl<T: IntoBytes + FromBytes> CoherentBox<[T]> {
     /// [`CoherentBox`] variant of [`Coherent::zeroed_slice_with_attrs`].
     #[inline]
     pub fn zeroed_slice_with_attrs(
@@ -454,7 +450,7 @@ pub fn init_at<E>(&mut self, i: usize, init: impl Init<=
T, E>) -> Result
=20
         // SAFETY:
         // - `ptr` is valid, properly aligned, and within this allocation.
-        // - `T: AsBytes + FromBytes` guarantees all bit patterns are vali=
d, so partial writes on
+        // - `T: IntoBytes + FromBytes` guarantees all bit patterns are va=
lid, so partial writes on
         //   error cannot leave the element in an invalid state.
         // - The DMA address has not been exposed yet, so there is no conc=
urrent device access.
         unsafe { pin_init::raw_try_init(ptr, init)? };
@@ -523,7 +519,7 @@ pub fn from_slice(
     }
 }
=20
-impl<T: AsBytes + FromBytes> CoherentBox<T> {
+impl<T: IntoBytes + FromBytes> CoherentBox<T> {
     /// Same as [`CoherentBox::zeroed_slice_with_attrs`], but for a single=
 element.
     #[inline]
     pub fn zeroed_with_attrs(
@@ -554,7 +550,7 @@ fn deref(&self) -> &Self::Target {
     }
 }
=20
-impl<T: AsBytes + FromBytes + KnownSize + ?Sized> DerefMut for CoherentBox=
<T> {
+impl<T: IntoBytes + FromBytes + KnownSize + ?Sized> DerefMut for CoherentB=
ox<T> {
     #[inline]
     fn deref_mut(&mut self) -> &mut Self::Target {
         // SAFETY:
@@ -565,7 +561,7 @@ fn deref_mut(&mut self) -> &mut Self::Target {
     }
 }
=20
-impl<T: AsBytes + FromBytes + KnownSize + ?Sized> From<CoherentBox<T>> for=
 Coherent<T> {
+impl<T: IntoBytes + FromBytes + KnownSize + ?Sized> From<CoherentBox<T>> f=
or Coherent<T> {
     #[inline]
     fn from(value: CoherentBox<T>) -> Self {
         value.0
@@ -663,7 +659,7 @@ pub unsafe fn as_mut(&self) -> &mut T {
     }
 }
=20
-impl<T: AsBytes + FromBytes> Coherent<T> {
+impl<T: IntoBytes + FromBytes> Coherent<T> {
     /// Allocates a region of `T` of coherent memory.
     fn alloc_with_attrs(
         dev: &device::Device<Bound>,
@@ -753,7 +749,7 @@ pub fn init_with_attrs<E>(
         // SAFETY:
         // - `ptr` is valid, properly aligned, and points to exclusively o=
wned memory.
         // - If `raw_try_init` fails, `self` is dropped, which safely free=
s the underlying
-        //   `Coherent`'s DMA memory. `T: AsBytes + FromBytes` ensures the=
re are no complex `Drop`
+        //   `Coherent`'s DMA memory. `T: IntoBytes + FromBytes` ensures t=
here are no complex `Drop`
         //   requirements we are bypassing.
         unsafe { pin_init::raw_try_init(ptr, init)? };
=20
@@ -948,9 +944,9 @@ unsafe impl<T: KnownSize + Send + ?Sized> Send for Cohe=
rent<T> {}
 // methods that access the buffer contents (`field_read`, `field_write`, `=
as_slice`,
 // `as_slice_mut`) are `unsafe`, and callers are responsible for ensuring =
no data races occur.
 // The safe methods only return metadata or raw pointers whose use require=
s `unsafe`.
-unsafe impl<T: KnownSize + ?Sized + AsBytes + FromBytes + Sync> Sync for C=
oherent<T> {}
+unsafe impl<T: KnownSize + ?Sized + IntoBytes + FromBytes + Sync> Sync for=
 Coherent<T> {}
=20
-impl<T: KnownSize + AsBytes + ?Sized> debugfs::BinaryWriter for Coherent<T=
> {
+impl<T: KnownSize + IntoBytes + ?Sized> debugfs::BinaryWriter for Coherent=
<T> {
     fn write_to_slice(
         &self,
         writer: &mut UserSliceWriter,
--=20
2.55.0


