Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794546127;
	b=oCGS/VZTkbZwmx+D2TLq5dl5EGZkcZuYYbmsefU/7VW5OnzmUTKbL7hL4KyWjBPtz0/e
	 5wIHC2XrKzUs01K2Q/8GVTsB9qSr2ZU/ydxwxTKQl1YPNSO3xF0agQ4goLv+V+xLE4ip9
	 +qVtVLeijOhKNOCipFRWb4eiWOcueOgYFEy+M6VLbOx29GAcMiqDldyhTjMawgILgEstZ
	 45gOBLdc6ShQRh4Zsj0yi37vsi4afeNhU+tCi+o50yUfbz8O1GRu2xWy6qg4eRutucQLY
	 pyGpaLRMoulbUYln3PfxmAp+e9wViG+FMKVHOJZvmu34O1twzx47Af+FZe1rScux71w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794546127;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=hzkV5CuqcRmeRc5AbzVPlfYP5uf4EAd07rgYr3Hn0tg=;
	b=yZ4AirtyXidCNQKlfZQoItqeLOhQwowI05JF373uAt6Ebrq8dsRYo1Uc6l4oS7pzQOmA
	 mkUvhqIrupGuWXCkD7PrOb8aShopGRlxYzWwk2kJ/U3UQmVRF4Ck18kNRGvtiZmWyqelq
	 Ra8P4P7k6iPp8OftZRoY8nI0zjVpH0jTuVPcfxo5tS2HaWMhEijgAah4XqrntjTmbGt+I
	 wodIQAwetStAx8ebox9ObhNYg8nw1DaVfvUQDK8EmZ9X7gJ5C7NV7/DfV6jbgeVvzo8sW
	 uemF5aFKYmztnmnQ2Ls0FnLzuEUxBqn7CkI/X7iUzST5BS7Ci8g54UmyQuJ4Bq8LqKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NTlyKBfv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659BE606A33B;
	Fri, 13 Nov 2026 05:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NTlyKBfv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783F51F000C4;
	Fri, 13 Nov 2026 05:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794546127;
	bh=hzkV5CuqcRmeRc5AbzVPlfYP5uf4EAd07rgYr3Hn0tg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NTlyKBfvPom0QJTse7p07OR7rx836GJXfxfB9nGyz2fykRV88VC+X6u06ihnReqwb
	 d+dZfHF2ZKhlIKj0J+I1vsglpAlQEERG60DYffpqKuTd6vjh6PRaq4vJbIzO405ie9
	 EY5uMdNlM3TxP96u/lWqABRAGxXHyD0XceNRdu7SdkZi3MgyRJm4R6C6ZVP9Pqp5eA
	 338pzwp9Qa4xPx9OpkDtn6ZAmwMfRrI8amrxgpUK+NFrFCWKCGcHXU4BPqJgQjLn+R
	 GbkzFXgGpllm9XSRC0J0ctvgn1EZwMzA8cJZWOR9WLdphsCurRAkMwj5GkkRiLupxp
	 VaqFwszzSRbpg==
Subject: Re: [PATCH net-next 2/2] rust: net: phy: pass a MaybeLocked device to
 soft_reset and match_phy_device
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
Date: Fri, 13 Nov 2026 05:02:05 +0000
Message-ID: <179454612500.2199510.688554972467066283@kernel.org>
In-Reply-To: <20261110-exp-phy-rs-maybelocked-v1-2-3023cc9055e9@gmail.com>
References: <20261110-exp-phy-rs-maybelocked-v1-2-3023cc9055e9@gmail.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.
- [High] Safe Rust code in `Driver::match_phy_device` can now oops the
  kernel by calling `read_paged()`.
- [Low] The rewritten `MaybeLocked` doc says "PHYLIB calls these
  callbacks [Driver::soft_reset and Driver::match_phy_device] both with…

--

rust: net: phy: pass a MaybeLocked device to soft_reset and match_phy_device

This patch changes the Rust PHY abstraction so that the soft_reset and
match_phy_device callbacks receive a &Device<MaybeLocked> instead of a
Locked device. It also corrects the SAFETY comments that said PHYLIB holds
phy_device->lock for these callbacks. ax88796b_rust is updated to the new
signature.

> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> index 60c58bbc12d6d..c2dfc58dbe55f 100644
> --- a/rust/kernel/net/phy.rs
> +++ b/rust/kernel/net/phy.rs
> @@ -72,10 +72,10 @@ pub trait PhyContext: private::Sealed {}
>  /// other access to the `phy_device` made under `phy_device->lock`.
>  pub struct Locked;
>  
> -/// The [`Device`] context of callbacks that PHYLIB calls both with and without
> -/// `phy_device->lock` held.
> +/// The [`Device`] context of [`Driver::soft_reset`] and [`Driver::match_phy_device`].
>  ///
> -/// A callback in this context must not take `phy_device->lock`.
> +/// PHYLIB calls these callbacks both with and without `phy_device->lock` held. A callback in this
> +/// context must not take `phy_device->lock`.

[Severity: Low]
Is this accurate for match_phy_device? Its only caller is phy_bus_match(),
and that never holds phydev->lock:

drivers/net/phy/phy_device.c:phy_bus_match() {
    ...
	if (phydrv->match_phy_device)
		return phydrv->match_phy_device(phydev, phydrv);
    ...
}

The new SAFETY comment in match_phy_device_callback() further down in this
patch says "phy_bus_match() holds no PHY lock". So the type doc and the
callback's SAFETY comment describe the same callback differently.

Could the doc say that soft_reset is called both with and without the lock,
and match_phy_device always without it?

[ ... ]

> @@ -370,10 +386,9 @@ impl<T: Driver> Adapter<T> {
>      /// `phydev` must be passed by the corresponding callback in `phy_driver`.
>      unsafe extern "C" fn soft_reset_callback(phydev: *mut bindings::phy_device) -> c_int {
>          from_result(|| {
> -            // SAFETY: This callback is called only in contexts
> -            // where we hold `phy_device->lock`, so the accessors on
> -            // `Device` are okay to call.
> -            let dev = unsafe { Device::from_raw(phydev) };
> +            // SAFETY: `phydev` is valid for the callback. `phy_init_hw()` calls `soft_reset` both
> +            // with and without `phy_device->lock`, which is the `MaybeLocked` context.
> +            let dev = unsafe { Device::from_raw_maybe_locked(phydev) };
>              T::soft_reset(dev)?;
>              Ok(0)
>          })

[Severity: High]
Is this conversion complete? read_mmd_callback() and write_mmd_callback()
in rust/kernel/net/phy.rs still say "This callback is called only in
contexts where we hold phy_device->lock", and they still build a Locked
device:

rust/kernel/net/phy.rs:Adapter::read_mmd_callback() {
    ...
            let dev = unsafe { Device::from_raw(phydev) };
            // CAST: the C side verifies devnum < 32.
            let ret = T::read_mmd(dev, devnum as u8, regnum)?;
    ...
}

phy_read_mmd() and phy_write_mmd() take only the MDIO bus lock. Then
__phy_read_mmd() and __phy_write_mmd() dispatch to the driver:

drivers/net/phy/phy-core.c:__phy_read_mmd() {
    ...
	if (phydev->drv && phydev->drv->read_mmd)
		return phydev->drv->read_mmd(phydev, devad, regnum);
    ...
}

<C45 as Register>::read() and write() in rust/kernel/net/phy/reg.rs are
now generic over PhyContext. That means the new MaybeLocked soft_reset can
get back to a Locked device:

phy_attach_direct() or phy_mii_ioctl()   (no phydev->lock)
  phy_init_hw()
    drv->soft_reset()
      soft_reset_callback()
        T::soft_reset(&Device<MaybeLocked>)
          dev.read(C45::new(...))
            phy_read_mmd()               (MDIO bus lock only)
              __phy_read_mmd()
                read_mmd_callback()
                  T::read_mmd(&mut Device<Locked>)

>From there, T::read_mmd() can call start_aneg(), set_speed(),
set_duplex() and so on without phy_device->lock, racing with
phy_state_machine(). The commit message says a soft_reset can no longer
reach these Locked-only operations. This path also creates a &mut Device
that aliases the still-live &Device<MaybeLocked>.

The series also opens a second lock-less entry. Before the series,
match_phy_device got only &Device and could not call read() or write(),
which took &mut self. Now it can issue C45 reads. On an already-bound
device, those go to the bound Rust driver's read_mmd_callback() with no
lock held.

The Locked type doc says PHYLIB holds phy_device->lock for every callback
except probe, suspend, resume and the MaybeLocked ones. That would also be
wrong for read_mmd and write_mmd.

No in-tree Rust PHY driver implements read_mmd or write_mmd today, so
nothing triggers this yet.

Should read_mmd and write_mmd also move to a MaybeLocked-style context?

> @@ -471,10 +486,9 @@ impl<T: Driver> Adapter<T> {
>          phydev: *mut bindings::phy_device,
>          _phydrv: *const bindings::phy_driver,
>      ) -> c_int {
> -        // SAFETY: This callback is called only in contexts
> -        // where we hold `phy_device->lock`, so the accessors on
> -        // `Device` are okay to call.
> -        let dev = unsafe { Device::from_raw(phydev) };
> +        // SAFETY: `phydev` is valid for the callback. `phy_bus_match()` holds no PHY lock, which
> +        // is the `MaybeLocked` context.
> +        let dev = unsafe { Device::from_raw_maybe_locked(phydev) };
>          T::match_phy_device(dev).into()
>      }

[Severity: High]
Can safe code in a Rust match_phy_device dereference a NULL phydev->drv
here? Device::read_paged() is now a &self method for every context, so a
match_phy_device implementation can call it on &Device<MaybeLocked>:

Device::read_paged()
  phy_read_paged()
    phy_select_page()
      phy_save_page()
        phy_lock_mdio_bus()
        __phy_read_page()

drivers/net/phy/phy-core.c:__phy_read_page() {
	if (WARN_ONCE(!phydev->drv->read_page, "read_page callback not available, PHY driver not loaded?\n"))
    ...
}

match_phy_device runs from phy_bus_match() before phy_probe() sets
phydev->drv = phydrv. phydev is allocated zeroed, and phy_remove() resets
drv to NULL.

So for an unbound PHY, this would oops with the MDIO bus mdio_lock held.
Every other PHY on that bus would then hang.

This wasn't reachable before the series: read_paged() took &mut self, and
match_phy_device only got &Device. The previous patch, "rust: net: phy:
make Device generic over a lock context", made read_paged() a &self method
for all contexts, and this patch makes MaybeLocked the match_phy_device
context.

The read_paged() SAFETY comment ("just an FFI call") also does not cover
the requirement of phy_read_paged() that phydev->drv is non-NULL.

C drivers that need paged access during match open-code the page select
instead, for example rtlgen_supports_2_5gbps() in
drivers/net/phy/realtek/realtek_main.c.

Should read_paged() be limited to contexts where phydev->drv is known to
be set, or should match_phy_device get a narrower context?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110-exp-phy-rs-maybelocked-v1-0-3023cc9055e9%40gmail.com
