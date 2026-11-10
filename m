Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794308438;
	b=tqiP+a2ZKAicPGf4W9qv9JFRwySX7gLmvYXGJY2v+AoBgUqOaPY1wWAWk3+2fgTkSWXe
	 ppG3k1mWMcomhJWYTUcnD4+Vkz0yy/f3gt9+9MntoHitOaAzCCaA8EMqJBPasY6EFxIRc
	 KFyc4+4OkVi7k/mOEyhEkdVPRfXZPnGg1mX+eBN+m2NJERjtw8DwTy6biTLD2qSXIiRSV
	 Xjp7VsGh4jaWPeCLMrE9XqDEbnUI/rydd1RAf44Iz6kFWwkRasy/6BWYGXwtmdY5Ntupz
	 PIQ3fUz9/5yYRaKeB1q2GMdzYcBiPn+OYccF9/yBH2w657U0/0SjidCI3UP3UsmKBkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308438;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=K10v5vnvxkJjsI7G5IeZLrlXvK0KiwHpcAB9TIGHcs0=;
	b=rXMdzBnypLoN1RB2lOUa2gY0cuxahwYKq5jWvo71uh/dcqVNWA5Jwu3eECn4qfqBZ3U9
	 6LSGE5DiQK+YoeV+Bs5Hizal5b5Z2ji6RWedkEfs3VuDVgqtK9jkQONrCcjEygXEvRBcm
	 R9HbVxOLQAWzQbQW+8s++JoWA+juI+pchGkw+EOPZXIIpb+xAXCBXqnSNImMC/LtUBvIA
	 9CWU2RZ8E1Lo+YkOfL9duye2PEwMCxcFsmoRudlh/orAAQBVi0ctJ/3rh5ftEBdLd6Ac0
	 85vVr0S+x2XPITbGEj31/EtyWoflUKTX6Lzb62ihygAGnsqXKgBCrQHbrVSV7X/caSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="vqFta6X/";
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B48760A261B
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 11:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B48760A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vqFta6X/
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8b3577deeb0so883168b3a.3
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 03:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794308436; x=1794913236; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K10v5vnvxkJjsI7G5IeZLrlXvK0KiwHpcAB9TIGHcs0=;
        b=vqFta6X/r5LS26yBm9gAjDv2NrQgK/wlH6ENp80rV48JVxxZlHIMf4l0Var7EUuZ+s
         0XBm8Vfnk8VbEaN2fWpDvNiFUaS7qUbYbMfM0g2HdXSu9Z0H+UiZt5MfOc9VI4JixQ1Z
         epZdNoALcpvyqbkULVYSF1kgRZFVvrcjZnJ/Xe5upVvG9USbrxi7AblO9+VJL2lzelM3
         BNxMUmxEKhf6dj2X0zGjQSdSLGnckhbn/gsSe/BhNb/y3ox9Ay6ZIRVvdsfqjT6IRMjd
         pu78lUL0QeYCJ5Ds9tORw98LPbwYoSfcrOlbgNYzvFNOl3tkgEETWU/thY5bhPYmS1pz
         Cs2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794308436; x=1794913236;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K10v5vnvxkJjsI7G5IeZLrlXvK0KiwHpcAB9TIGHcs0=;
        b=GrWzWpDeCh9FKRLyTdN8VbxEqhs8O7V5bonf7y4MEOMTqsNI185nfBpJDrGj2h7aPh
         6NsBHs/RW2dVI3K0+TRSAuAAKlTcSv/xAISGn5dbfBSUbYAqbj3h6jVC7EDzKvs2RTz/
         rK1mNOZkf02I0N8fIlZ+z+0WmI1RYBLAm0gDaHQhuHRxTYMeka7MMhgAIrGRw5n0F86i
         PEC9Ucgusy27qbS1VQpdmAflZmcfIehcSYmoWY6K84qgnMRjrwk4peixrIJs+9gL/tKQ
         3b7UqvkwGBVvXEK3gOIi54E4ydqzIrqzw7kLrF8kYaJf3LDcKdgExCf+o41SVP+BDXEF
         5cNg==
X-Gm-Message-State: APuU4Z804Eyye/YzkLrFjEiIgSlpuW1JSNKnMUSxo45ZPHPbqimVsuZA
	kGelCXTxLQz3e0JSJwiMA+qXBzY5latMYSA/af7XAUscQ+GOj2bPUjzAvgID7wzI
X-Gm-Gg: AYBFou3R/iNtaRq5qd3ViFEN97kzH4Fbp4/lvOU+t81/cb1+SdUL+gpHhQxLBBResWl
	TdlbmkbSILIh52JTgKrAAF7AnsqKLk6dj76ekZlqlmDvImvyNFnrW4XUvpSjAdZ4yoHgEa7TlAs
	7Bmf7liD1Yj+5bBV7TgdeHiXdJ53nzwQe2XSO17xPZgx+VAjy+DUL4cXUZQjCsec2CkunzpLSuB
	Ds3szVtRm8dHjur2G+qQx3J2SLVmwzUBPhG+I87a0nQCxV/8bfWbuJSJWFwKVMept9iAbScicKG
	+NYjxx+eIF0Bekl9QmLthQ/MiPCciNzKN5g+InTbq1iMtB2JKM5mueIao2oCf2oFB/EiWTjaAU5
	nTOjM2bhybW3+9zeZkoVr9UiwRBfLY951VeichMvHKIbxBbR1qArahpjy/OuhVPvadPYDA7kWx9
	UMfya2O3QtgraZ4bARDhwujjSnJJvnJsetDjpXaqWW+6sNtNGm2axHnrRAjBqQlQIfVojGqILtA
	UfULZSkr/nLX8KwJ/b22+Q7HdqLE1ngtLA84vbnaLyei4uV308Epg9NEgmCKLNEv/04fRKAXciM
	xQnS9yJwUgtIisBXnMCbT7ELCNCJfOVwDQzApph4c7w8wiSBRt/HsVmk0MpLPNv0nBk+g658y3l
	vM7gQUO6mHD7oMpdvbCQpZ56kcycZ2aa2EqrGhOz67QO7h1miye2xeImadQ==
X-Received: by 2002:a05:6a21:700a:b0:3de:5a00:e248 with SMTP id adf61e73a8af0-3f190991937mr2018801637.76.1794308436090;
        Tue, 10 Nov 2026 03:00:36 -0800 (PST)
Received: from [169.254.3.1] ([143.248.188.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa7de768fsm740596b3a.6.2026.11.10.03.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:00:35 -0800 (PST)
From: SeungJong Ha <engineer.jjhama@gmail.com>
Date: Tue, 10 Nov 2026 19:59:26 +0900
Subject: [PATCH net-next 1/2] rust: net: phy: make Device generic over a
 lock context
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-exp-phy-rs-maybelocked-v1-1-3023cc9055e9@gmail.com>
References: <20261110-exp-phy-rs-maybelocked-v1-0-3023cc9055e9@gmail.com>
In-Reply-To: <20261110-exp-phy-rs-maybelocked-v1-0-3023cc9055e9@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Trevor Gross <tmgross@umich.edu>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, SeungJong Ha <engineer.jjhama@gmail.com>
X-Mailer: b4 0.15.2

Make `Device` generic over a lock context, as `device::Device` is over
its device context: `Locked`, the default, for callbacks that run under
`phy_device->lock`, and `MaybeLocked` for callbacks that may run without
it. `Device<Locked>` derefs to `Device<MaybeLocked>`. The next patch
uses `MaybeLocked`.

Methods that do not need the lock (`phy_id`, register access,
`read_paged` and `genphy_soft_reset`) move to both contexts and take
`&self` instead of `&mut self`, since a `MaybeLocked` callback may run
concurrently with a `Locked` one on the same device. No functional
change.

Built with AX88796B_RUST_PHY=y and CLIPPY=1.

Signed-off-by: SeungJong Ha <engineer.jjhama@gmail.com>
---
 rust/kernel/net/phy.rs     | 145 ++++++++++++++++++++++++++++++++-------------
 rust/kernel/net/phy/reg.rs |  17 +++---
 2 files changed, 113 insertions(+), 49 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index c4e7b1d6c6f4..60c58bbc12d6 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -50,6 +50,48 @@ pub enum DuplexMode {
     Unknown,
 }
 
+/// A trait implemented by all contexts a [`Device`] can be used in.
+///
+/// - [`Locked`]: Serialized against every access made under `phy_device->lock`. The default
+///   context of [`Device`].
+/// - [`MaybeLocked`]: `phy_device->lock` may or may not be held.
+///
+/// [`Device<Locked>`] dereferences to [`Device<MaybeLocked>`].
+pub trait PhyContext: private::Sealed {}
+
+/// The [`Device`] context of every [`Driver`] callback that does not take a
+/// [`Device<MaybeLocked>`].
+///
+/// PHYLIB holds `phy_device->lock` for these callbacks, except for [`Driver::probe`], which runs
+/// before the device is published, and for [`Driver::suspend`] and [`Driver::resume`], which run
+/// without concurrent access to the instance.
+///
+/// # Invariants
+///
+/// For the lifetime of a [`Device<Locked>`] reference, the holder is serialized against every
+/// other access to the `phy_device` made under `phy_device->lock`.
+pub struct Locked;
+
+/// The [`Device`] context of callbacks that PHYLIB calls both with and without
+/// `phy_device->lock` held.
+///
+/// A callback in this context must not take `phy_device->lock`.
+///
+/// # Invariants
+///
+/// None beyond those of [`Device`].
+pub struct MaybeLocked;
+
+mod private {
+    pub trait Sealed {}
+
+    impl Sealed for super::Locked {}
+    impl Sealed for super::MaybeLocked {}
+}
+
+impl PhyContext for Locked {}
+impl PhyContext for MaybeLocked {}
+
 /// An instance of a PHY device.
 ///
 /// Wraps the kernel's [`struct phy_device`].
@@ -57,11 +99,13 @@ pub enum DuplexMode {
 /// A [`Device`] instance is created when a callback in [`Driver`] is executed. A PHY driver
 /// executes [`Driver`]'s methods during the callback.
 ///
+/// `Ctx` is the [`PhyContext`] of the callback. Methods that rely on `phy_device->lock` are
+/// implemented for [`Device<Locked>`] only.
+///
 /// # Invariants
 ///
-/// - Referencing a `phy_device` using this struct asserts that you are in
-///   a context where all methods defined on this struct are safe to call.
-/// - This struct always has a valid `self.0.mdio.dev`.
+/// - `self.0` is a valid `phy_device`, and `self.0.mdio.dev` is a valid `struct device`.
+/// - The invariants of `Ctx` hold for the lifetime of a reference to [`Device<Ctx>`].
 ///
 /// [`struct phy_device`]: srctree/include/linux/phy.h
 // During the calls to most functions in [`Driver`], the C side (`PHYLIB`) holds a lock that is
@@ -71,7 +115,7 @@ pub enum DuplexMode {
 // [`Driver::resume`] and [`Driver::suspend`] also are called where only one thread can access
 // to the instance.
 #[repr(transparent)]
-pub struct Device(Opaque<bindings::phy_device>);
+pub struct Device<Ctx: PhyContext = Locked>(Opaque<bindings::phy_device>, PhantomData<Ctx>);
 
 impl Device {
     /// Creates a new [`Device`] instance from a raw pointer.
@@ -91,14 +135,6 @@ unsafe fn from_raw<'a>(ptr: *mut bindings::phy_device) -> &'a mut Self {
         unsafe { &mut *ptr }
     }
 
-    /// Gets the id of the PHY.
-    pub fn phy_id(&self) -> u32 {
-        let phydev = self.0.get();
-        // SAFETY: The struct invariant ensures that we may access
-        // this field without additional synchronization.
-        unsafe { (*phydev).phy_id }
-    }
-
     /// Gets the state of PHY state machine states.
     pub fn state(&self) -> DeviceState {
         let phydev = self.0.get();
@@ -177,27 +213,6 @@ pub fn set_duplex(&mut self, mode: DuplexMode) {
         unsafe { (*phydev).duplex = v as c_int };
     }
 
-    /// Reads a PHY register.
-    // This function reads a hardware register and updates the stats so takes `&mut self`.
-    pub fn read<R: reg::Register>(&mut self, reg: R) -> Result<u16> {
-        reg.read(self)
-    }
-
-    /// Writes a PHY register.
-    pub fn write<R: reg::Register>(&mut self, reg: R, val: u16) -> Result {
-        reg.write(self, val)
-    }
-
-    /// Reads a paged register.
-    pub fn read_paged(&mut self, page: u16, regnum: u16) -> Result<u16> {
-        let phydev = self.0.get();
-        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
-        // So it's just an FFI call.
-        let ret = unsafe { bindings::phy_read_paged(phydev, page.into(), regnum.into()) };
-
-        to_result(ret).map(|()| ret as u16)
-    }
-
     /// Resolves the advertisements into PHY settings.
     pub fn resolve_aneg_linkmode(&mut self) {
         let phydev = self.0.get();
@@ -206,14 +221,6 @@ pub fn resolve_aneg_linkmode(&mut self) {
         unsafe { bindings::phy_resolve_aneg_linkmode(phydev) };
     }
 
-    /// Executes software reset the PHY via `BMCR_RESET` bit.
-    pub fn genphy_soft_reset(&mut self) -> Result {
-        let phydev = self.0.get();
-        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
-        // So it's just an FFI call.
-        to_result(unsafe { bindings::genphy_soft_reset(phydev) })
-    }
-
     /// Initializes the PHY.
     pub fn init_hw(&mut self) -> Result {
         let phydev = self.0.get();
@@ -276,7 +283,61 @@ pub fn genphy_read_abilities(&mut self) -> Result {
     }
 }
 
-impl AsRef<kernel::device::Device> for Device {
+impl<Ctx: PhyContext> Device<Ctx> {
+    /// Gets the id of the PHY.
+    pub fn phy_id(&self) -> u32 {
+        let phydev = self.0.get();
+        // SAFETY: `phydev` is valid by the type invariant of `Self`. `phy_id` is set by
+        // `phy_device_create()` and never written afterwards.
+        unsafe { (*phydev).phy_id }
+    }
+
+    /// Reads a PHY register.
+    // This function reads a hardware register and updates the stats.
+    pub fn read<R: reg::Register>(&self, reg: R) -> Result<u16> {
+        reg.read(self)
+    }
+
+    /// Writes a PHY register.
+    pub fn write<R: reg::Register>(&self, reg: R, val: u16) -> Result {
+        reg.write(self, val)
+    }
+
+    /// Reads a paged register.
+    pub fn read_paged(&self, page: u16, regnum: u16) -> Result<u16> {
+        let phydev = self.0.get();
+        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
+        // So it's just an FFI call.
+        let ret = unsafe { bindings::phy_read_paged(phydev, page.into(), regnum.into()) };
+
+        to_result(ret).map(|()| ret as u16)
+    }
+
+    /// Executes software reset the PHY via `BMCR_RESET` bit.
+    pub fn genphy_soft_reset(&self) -> Result {
+        let phydev = self.0.get();
+        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
+        // So it's just an FFI call.
+        to_result(unsafe { bindings::genphy_soft_reset(phydev) })
+    }
+}
+
+impl core::ops::Deref for Device<Locked> {
+    type Target = Device<MaybeLocked>;
+
+    fn deref(&self) -> &Self::Target {
+        let ptr: *const Self = self;
+
+        // CAST: `Device<Locked>` and `Device<MaybeLocked>` transparently wrap the same type.
+        let ptr = ptr.cast::<Self::Target>();
+
+        // SAFETY: `ptr` was derived from `&self`, and the invariants of `MaybeLocked` are
+        // implied by those of `Locked`.
+        unsafe { &*ptr }
+    }
+}
+
+impl<Ctx: PhyContext> AsRef<kernel::device::Device> for Device<Ctx> {
     fn as_ref(&self) -> &kernel::device::Device {
         let phydev = self.0.get();
         // SAFETY: The struct invariant ensures that `mdio.dev` is valid.
diff --git a/rust/kernel/net/phy/reg.rs b/rust/kernel/net/phy/reg.rs
index 80e22c264ea8..6d27a70d6180 100644
--- a/rust/kernel/net/phy/reg.rs
+++ b/rust/kernel/net/phy/reg.rs
@@ -8,7 +8,10 @@
 //! Ethernet management interface clauses 22 and 45 register namespaces, as
 //! defined in IEEE 802.3.
 
-use super::Device;
+use super::{
+    Device,
+    PhyContext, //
+};
 use crate::{
     build_assert::build_assert,
     error::*,
@@ -44,10 +47,10 @@ pub trait Sealed {}
 /// ```
 pub trait Register: private::Sealed {
     /// Reads a PHY register.
-    fn read(&self, dev: &mut Device) -> Result<u16>;
+    fn read<C: PhyContext>(&self, dev: &Device<C>) -> Result<u16>;
 
     /// Writes a PHY register.
-    fn write(&self, dev: &mut Device, val: u16) -> Result;
+    fn write<C: PhyContext>(&self, dev: &Device<C>, val: u16) -> Result;
 
     /// Checks the link status and updates current link state.
     fn read_status(dev: &mut Device) -> Result<u16>;
@@ -104,7 +107,7 @@ pub const fn vendor_specific<const N: u8>() -> Self {
 impl private::Sealed for C22 {}
 
 impl Register for C22 {
-    fn read(&self, dev: &mut Device) -> Result<u16> {
+    fn read<C: PhyContext>(&self, dev: &Device<C>) -> Result<u16> {
         let phydev = dev.0.get();
         // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Device`.
         // So it's just an FFI call, open code of `phy_read()` with a valid `phy_device` pointer
@@ -116,7 +119,7 @@ fn read(&self, dev: &mut Device) -> Result<u16> {
         Ok(ret as u16)
     }
 
-    fn write(&self, dev: &mut Device, val: u16) -> Result {
+    fn write<C: PhyContext>(&self, dev: &Device<C>, val: u16) -> Result {
         let phydev = dev.0.get();
         // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Device`.
         // So it's just an FFI call, open code of `phy_write()` with a valid `phy_device` pointer
@@ -196,7 +199,7 @@ pub fn new(devad: Mmd, regnum: u16) -> Self {
 impl private::Sealed for C45 {}
 
 impl Register for C45 {
-    fn read(&self, dev: &mut Device) -> Result<u16> {
+    fn read<C: PhyContext>(&self, dev: &Device<C>) -> Result<u16> {
         let phydev = dev.0.get();
         // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Device`.
         // So it's just an FFI call.
@@ -206,7 +209,7 @@ fn read(&self, dev: &mut Device) -> Result<u16> {
         Ok(ret as u16)
     }
 
-    fn write(&self, dev: &mut Device, val: u16) -> Result {
+    fn write<C: PhyContext>(&self, dev: &Device<C>, val: u16) -> Result {
         let phydev = dev.0.get();
         // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Device`.
         // So it's just an FFI call.

-- 
2.54.0

