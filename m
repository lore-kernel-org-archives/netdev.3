Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794546125;
	b=cimmjaPVt9HydOZ4RTcXdQZLg6lH4nxN2r1iG5dWb+XpKE/NoUoy+E6ob5zJvBBT+t8d
	 Z+uzYc9oau4NvWQJziguRn3MUYVePEfofRZggb2kEa37D0jRxk6T1GUtt0yQTHoJJ4+v1
	 TpE9WPhuElL4ONaokwx1W785uxEpTmOANMiGEMflutziXXsj8wBaCQYlTjKt1jaMQ33yI
	 aONi/YtjZOyFOeMNYIfpqHq+0AO76QFFDaYNszlQ46cmTYAPbHUfCDu7AXxwb4LlBdWRG
	 XOPdbZlyYVp9lpatK8EOG9BYgKRdSeAO5VrFBXcUGnOvv/hciIRN5coTYZbUsSA79Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794546125;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=4Vw4lgRPCCAATIt+hxOa8/bRcLW2qv1GY0q9oLPU9Bo=;
	b=Xgft7isB544hbKbeAooG6F19j67+c8y3ZVspW3uyFxQdhlLlBmUt+WqzkriuKomrXYRh
	 GTsKMwR9hZwA9z0pjRR8NW7zg0wccTet2aDybH6WmQZmAmJ5yx/kTEJQ34HW/MhHy4Osx
	 AZMQL2TVBQ69B6AJsLzxrMgdKsdeB9fNTUOrmrvKL6AIQGMZhLx+Sumoo5A6BXRYJsBga
	 7JOsjhc3pYJ7m7h/FDkboznKLsiyU8v/OVgLY8GK3u/2w7BqTSz7kOjl+PpL9EbKT3uSu
	 5Bi2mWPoYL41Y31L03ppOBg1/MEEaANMX+2kS+0BcmbkY+bCtCBIGjuDLtE7VvBaTxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RafftHtQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFF1606A321;
	Fri, 13 Nov 2026 05:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RafftHtQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88CF21F000C4;
	Fri, 13 Nov 2026 05:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794546124;
	bh=4Vw4lgRPCCAATIt+hxOa8/bRcLW2qv1GY0q9oLPU9Bo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RafftHtQibeHtVwtgV0EHt9veuY3lUF9zAhnD9ff/fZpXUcdvRzQjyAo0wmcRRkYw
	 8anwo+AnwCpWpypc6K23VRbkTgsg8M9keRclxxjtONvUzMhwJjCs0kDfusST1/EpZg
	 waqEPFbFoWptiy0hmLtny+X+Ou4K6o2MsRWkwqGchIZFByFcgTWQ10zGaWWm05skjD
	 +uPWhuD1WG7ZRsUNZbJrrh0KTAjGmPaCEiq7rh81ijur4IwPBm5Ad93A8DGfc1tXeX
	 c9wcynE0wphpCyxO9SxhpPtqfqT3+roHI9ryt1VwXVAnjIWKt2Y/1uq8Gwj4vijAMQ
	 SAOFRWPA6xNKQ==
Subject: Re: [PATCH net-next 1/2] rust: net: phy: make Device generic over a
 lock context
From: netdev-bot+sashiko@kernel.org
To: engineer.jjhama@gmail.com
Cc: fujita.tomonori@gmail.com, tmgross@umich.edu, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, dakr@kernel.org, daniel.almeida@collabora.com,
 tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 13 Nov 2026 05:02:03 +0000
Message-ID: <179454612309.2199510.8826947622711200035@kernel.org>
In-Reply-To: <20261110-exp-phy-rs-maybelocked-v1-1-3023cc9055e9@gmail.com>
References: <20261110-exp-phy-rs-maybelocked-v1-1-3023cc9055e9@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch moves `genphy_soft_reset()` into `impl<Ctx:
  PhyContext> Device<Ctx>` (rust/kernel/net/phy.rs:317) and makes it a…
- [Medium] The new `Locked` documentation and `# Invariants`
  (rust/kernel/net/phy.rs:62-73) say that PHYLIB holds…
- [Medium] Before this patch, every Rust MDIO access needed `&mut
  Device`, which only Locked or exclusive callbacks hold.
- [Low] `Device::from_raw()` (rust/kernel/net/phy.rs:130) still returns
  `&'a mut Device<Locked>`.
- [Low] rust: net: phy: missing #[inline] on small Device and Register
  wrappers

--

rust: net: phy: make Device generic over a lock context

This commit makes the Rust phy Device generic over a lock context. Locked
is the default, and MaybeLocked is for callbacks that may run without
phy_device->lock. Device<Locked> derefs to Device<MaybeLocked>, and
phy_id(), register access, read_paged() and genphy_soft_reset() move to
both contexts and take &self instead of &mut self.

> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> index c4e7b1d6c6f4a..60c58bbc12d6d 100644
> --- a/rust/kernel/net/phy.rs
> +++ b/rust/kernel/net/phy.rs
> @@ -50,6 +50,48 @@ pub enum DuplexMode {
>      Unknown,
>  }
>  

[ ... ]

> +/// The [`Device`] context of every [`Driver`] callback that does not take a
> +/// [`Device<MaybeLocked>`].
> +///
> +/// PHYLIB holds `phy_device->lock` for these callbacks, except for [`Driver::probe`], which runs
> +/// before the device is published, and for [`Driver::suspend`] and [`Driver::resume`], which run
> +/// without concurrent access to the instance.
> +///
> +/// # Invariants
> +///
> +/// For the lifetime of a [`Device<Locked>`] reference, the holder is serialized against every
> +/// other access to the `phy_device` made under `phy_device->lock`.
> +pub struct Locked;

[Severity: Medium]
Is this invariant accurate for Driver::read_mmd and Driver::write_mmd?

read_mmd_callback() and write_mmd_callback() still build a
&mut Device<Locked> through Device::from_raw(). The C side calls them with
only the MDIO bus lock held:

drivers/net/phy/phy-core.c:phy_read_mmd() {
	phy_lock_mdio_bus(phydev);
	ret = __phy_read_mmd(phydev, devad, regnum);
	phy_unlock_mdio_bus(phydev);
}

drivers/net/phy/phy-core.c:__phy_read_mmd() {
	...
	if (phydev->drv && phydev->drv->read_mmd)
		return phydev->drv->read_mmd(phydev, devad, regnum);
	...
}

phy_probe() also calls get_features without phydev->lock, and
get_features is not in the exception list here either.

This patch also makes C45::read() and C45::write() in reg.rs generic over
PhyContext. A &Device<MaybeLocked> holder can now reach a bound Rust
driver's read_mmd_callback(). With the follow-up patch, the path would be:

match_phy_device (MaybeLocked, unlocked)
  dev.read(C45::new(..))
    phy_read_mmd()
      read_mmd_callback()
        Device::from_raw() -> &mut Device<Locked>

Could safe code in that read_mmd then call Locked-only mutators such as
set_speed() while the bound driver's read_status runs under
phydev->lock?

The follow-up patch "rust: net: phy: pass a MaybeLocked device to
soft_reset and match_phy_device" fixes how this commit classifies
match_phy_device and soft_reset. The read_mmd and write_mmd case is still
there after it.

> @@ -71,7 +115,7 @@ pub enum DuplexMode {
>  // [`Driver::resume`] and [`Driver::suspend`] also are called where only one thread can access
>  // to the instance.
>  #[repr(transparent)]
> -pub struct Device(Opaque<bindings::phy_device>);
> +pub struct Device<Ctx: PhyContext = Locked>(Opaque<bindings::phy_device>, PhantomData<Ctx>);
>  
>  impl Device {
>      /// Creates a new [`Device`] instance from a raw pointer.
> @@ -91,14 +135,6 @@ unsafe fn from_raw<'a>(ptr: *mut bindings::phy_device) -> &'a mut Self {
>          unsafe { &mut *ptr }
>      }

[Severity: Low]
Does the safety reasoning in from_raw() still hold? It still returns
&'a mut Device<Locked>, and its SAFETY comment still claims "we have
unique access for the duration of 'a".

The commit message says a MaybeLocked callback "may run concurrently with
a Locked one on the same device". With the follow-up patch, a
&Device<MaybeLocked> and a &mut Device<Locked> for the same phy_device can
be live at the same time on different threads.

For example, a newly registered driver's match_phy_device can run through
__driver_attach() while the bound driver's read_status holds the &mut.

Opaque prevents noalias here, so this may have no runtime effect. Should
the from_raw() safety comment be updated to explain why &mut is still
acceptable? The SAFETY comments in set_speed() and set_duplex() also still
say the field is accessed "without additional synchronization".

[ ... ]

> @@ -276,7 +283,61 @@ pub fn genphy_read_abilities(&mut self) -> Result {
>      }
>  }
>  
> -impl AsRef<kernel::device::Device> for Device {
> +impl<Ctx: PhyContext> Device<Ctx> {

[ ... ]

> +    /// Reads a PHY register.
> +    // This function reads a hardware register and updates the stats.
> +    pub fn read<R: reg::Register>(&self, reg: R) -> Result<u16> {
> +        reg.read(self)
> +    }
> +
> +    /// Writes a PHY register.
> +    pub fn write<R: reg::Register>(&self, reg: R, val: u16) -> Result {
> +        reg.write(self, val)
> +    }

[Severity: Medium]
Can MaybeLocked register writes interleave with a multi-access sequence in
a Locked callback on the same PHY?

Before this patch, every Rust MDIO access needed &mut Device. For Rust
drivers, phydev->lock therefore serialized multi-register sequences.
C22::write() and C45::write() hold bus->mdio_lock for only one
transaction.

The Rust Driver vtable has no read_page or write_page. Rust drivers have
to open-code page-select sequences (for example through
C22::vendor_specific::<0x1f>()) or indirect MMD sequences with write() and
read().

With the follow-up patch, match_phy_device is MaybeLocked. It runs from
__driver_attach()->phy_bus_match() on devices that are already bound.

Suppose it writes a page-select or indirect-address register while the
bound driver's read_status or config_aneg is partway through a paged
access. Would the Locked callback then access a register on the wrong
page?

A concurrent BMCR write could also break ordered sequences such as
asix_soft_reset(), which writes BMCR = 0 and then BMCR_RESET. Should the
MaybeLocked documentation at least say that register accesses in that
context must not change persistent paging or indirect state?

[ ... ]

> +    /// Executes software reset the PHY via `BMCR_RESET` bit.
> +    pub fn genphy_soft_reset(&self) -> Result {
> +        let phydev = self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
> +        // So it's just an FFI call.
> +        to_result(unsafe { bindings::genphy_soft_reset(phydev) })
> +    }

[Severity: Medium]
The commit message lists genphy_soft_reset among the "Methods that do not
need the lock". Does the C function really do only MDIO accesses?

drivers/net/phy/phy_device.c:genphy_soft_reset() {
	...
	if (phydev->autoneg == AUTONEG_ENABLE)
		res |= BMCR_ANRESTART;
	...
	phydev->suspended = 0;
	...
	if (phydev->autoneg == AUTONEG_DISABLE)
		ret = genphy_setup_forced(phydev);
	...
}

genphy_setup_forced() also writes phydev->pause and phydev->asym_pause. It
builds BMCR from phydev->speed and phydev->duplex.

In struct phy_device, suspended:1 is in the same run of bitfields as
autoneg, link, autoneg_complete, interrupts, irq_suspended and irq_rerun.
Setting suspended is a non-atomic read-modify-write of that shared storage.

With the follow-up patch, match_phy_device gets a &Device<MaybeLocked> and
can call dev.genphy_soft_reset() from safe code.

phy_bus_match() calls match_phy_device without any PHY lock.
__driver_attach() calls driver_match_device() for every device on the bus.
That includes devices already bound, where phy_state_machine() runs under
phydev->lock.

Could the suspended = 0 store then race with genphy_update_link() or
genphy_read_status() updating link, autoneg_complete, speed and duplex?
It could also race with the IRQ path updating irq_suspended and
irq_rerun.

Before this patch, the reset needed &mut Device and match_phy_device could
not call it. Nothing later in the series seems to change this.

The Rust abstraction already treats these fields as lock-protected:
set_speed() and set_duplex() are Locked-only. Should genphy_soft_reset()
also stay in the Locked-only impl?

[ ... ]

> @@ -91,14 +135,6 @@ unsafe fn from_raw<'a>(ptr: *mut bindings::phy_device) -> &'a mut Self {
>          unsafe { &mut *ptr }
>      }
>  
> -    /// Gets the id of the PHY.
> -    pub fn phy_id(&self) -> u32 {
> -        let phydev = self.0.get();
> -        // SAFETY: The struct invariant ensures that we may access
> -        // this field without additional synchronization.
> -        unsafe { (*phydev).phy_id }
> -    }
> -
>      /// Gets the state of PHY state machine states.
>      pub fn state(&self) -> DeviceState {
>          let phydev = self.0.get();

[Severity: Low]
This is a nit. These are kernel crate abstractions, and the Rust
guidelines ask for #[inline] on small functions and on thin wrappers
that only forward to a binding call. None of the functions this patch
touches have it:

- phy_id(), read(), write(), read_paged() and genphy_soft_reset() in
  the new impl<Ctx: PhyContext> Device<Ctx> block
- deref() in the new Deref impl for Device<Locked>
- as_ref() in the AsRef<kernel::device::Device> impl
- the C22 and C45 Register::read() and Register::write()
  implementations in reg.rs

Most of these are now generic over Ctx (or C). They get instantiated
in the driver crate anyway, so the practical effect is small.

deref() is the one that matters most. It is a non-generic pointer cast
that runs whenever a &Device<Locked> is coerced to
&Device<MaybeLocked>, and it should compile away entirely.

This patch already moves or rewrites all of these functions. Could
#[inline] be added to them while they are being touched?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110-exp-phy-rs-maybelocked-v1-0-3023cc9055e9%40gmail.com
