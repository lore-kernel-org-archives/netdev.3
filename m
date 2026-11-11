Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794403594;
	b=s8FovR52xOdHmI6VxolVSygUwNJ3CenRJd0nrwoW/4HHrTOm/YQdmTO88mABInFiekku
	 ev4DCo0DqswN0ww6G73BklE8Xxh42LNsBid+X7f4smFySj1Cn6ezA7ddYRvg/jQWd4dOf
	 63A4GLorLJ0hqieKoLRz2M8a5FTFeYuv/PrLfs2tQHjlAMLfAdugLKuM08kfHyye6kS0C
	 zr9recEjyEL6llySBNfrezRPBpX8CavGWxAJRtsdWJmIf1dofB7Dr2M3GGKL3xxjliKa5
	 YpCftBxqUhAjGMV6nRBg0f7d0EMySALHFH6+DuhT2hsYGPRMVa1j6ybCAQpJPTCjS1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403594;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=7t36e6QBLwY9yhsOj7Wj1izTOO4kbfw46M5uSBDE9Cw=;
	b=UJhf9EM6xiZXSEoQsHaI9Fi7T2Jiwa6t+WDno5FXqeTqu9oQpYdBZ9+yU8dVDugekNSL
	 lftsd7DLdmLEbx/4sMi6uvp9Jvb6BFa6Nq9aHpK3ZxjCKMfk7wiM1PdyhlCZ6krvqnYUo
	 CpZfNSg50nlxt/Aau1qCef6reS2jUIM24ZC1BVvr6ZNVjcBuTBKhVQIyaWYUB+JKE2+XM
	 opIDU3JJjPJgsPUweXD0zfJp/hpjBYdaaEPGh8k3cA/VpBE7Tlf1qscrFj9tANPN2XH4D
	 +O7Pz904UAxqAt+JBabvZSsfpWUGOdZJ83Y3grRNHeI0LjIi3X6mqa833iiH1279tMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Su5Y+wzd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163D7606A885
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 13:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 163D7606A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Su5Y+wzd
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-702fd86d674so1576960eaf.2
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 05:26:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794403593; cv=none;
        d=google.com; s=arc-20260327;
        b=QjE0sdY3DVicSQK72Ou0io52yClSrHSDtlvuVyn9ZL1xTnZa9rEV28TCrV9UQI17dn
         4sEqGtxYhnOXzcF7j5I3NeMygGE8dYx6YtJ7oK3bETw5JsF5gdbZYKjl4eoq3BeauGC0
         Wlo0Icb+W2MRTpwb/L9Ah5m3JVrrTb6/RV7Itn3kRHBUln04HRSkVLofAlr8r+mfs8pl
         vjVQiGyLVNCcrY4axHT1cVUG/6qX2LYchGKC5KSG5ogOT70ZfvvWd9v4S85UslYmoBE7
         z0x7R4fAX9Sa2CMCMNppp2lY79Y5wi5TWWS6I2hwtE0S2pVJ7P5V85myAwyHfm8amyHd
         42pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7t36e6QBLwY9yhsOj7Wj1izTOO4kbfw46M5uSBDE9Cw=;
        fh=KcodZMkMe/b9ErhgRsFsATQa+Lv8G0ybAPHNjhgdq4s=;
        b=Uj2AVOy8TTXNwhY92EWIBDyCwsvaQQ8LFZ+tWRhtyNMy7/BjGPaKCjK+uVWjfS+u+p
         ogcg8bnjEWW8cvcy0kJoZtil3ZpjMh54st7izKrKX81HL2MUEhImwpmJEDjyHAXpYFdE
         iNwfxWUEbLfdkPnjMnyXpji80oEY61Ah5Vw+Bi2eg0IrMwkoYtzThm4AO+sRZ+bVQUgt
         7IOLwQE4Yftw+OfJZ09WZPWnbkDhl4A8RSZj1laK3ZK54wQlYSnVyoSiCoRUCBNlSRgt
         qqQqBA+M9lHKfnlWJFPnmppZWNOpvBjzg+ZT/fUBItLcK4K1R0hNqmTyv5yZWvaSQMvt
         wLvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794403593; x=1795008393; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7t36e6QBLwY9yhsOj7Wj1izTOO4kbfw46M5uSBDE9Cw=;
        b=Su5Y+wzdrajhWHpsp8lsLS6kgIP9jb6d4JEsolWbZEfXXXDJDonn9FQhQvSteuOTd3
         emd6FBt7OxbKfHbhGOeiBAF1Q4qdj18i4cYytXy7xZyXXr5uIpMz38lVlQYlT01xbM1Z
         kt1ziXRe4sg4H8l+vJYjTyM6BVb6D+kN8J1cg5ArZS6ZdHejBK2Ziq1pmT5dCgrTSa4a
         t1wsGTDmcAy5+IamctHLmWYy+pxY3JF06MztC4gvSCvwZbZVFhoKonKdmnWXY9jlphzB
         aiZkWrnPwD+YjwYZttZrdoCV0lsi/w91+sTvZHsxhcwJCQtYQ2G84Ggp/ZhHG4eVRHGm
         ZqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794403593; x=1795008393;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7t36e6QBLwY9yhsOj7Wj1izTOO4kbfw46M5uSBDE9Cw=;
        b=w3ABdi6UL1oggCTGhFv1jS+NRaCLmuF5rD6HKL28a81kq0IQaADdUCydQm7VsLxHtt
         xSdUTV36WzIfYQDFcVy8rIOGkGn8uS5STu3tXeeP/JFUvkdDpwgbUCm2WssCCG2w525P
         NfC1Ck2//ILWDxA3kCe/07DZwjfFA0ikz77EeXuhAkETDKlZpzRh4RZal/F4vSqSLULh
         rt4dm5waRwaTPGeLLPSfCdXr/m1GGagdpZIwzYtAJvvSiBzAlaFZBf5YgIiNb55DV6us
         EO1Tj3cOw4T1E7PEPzpWILNSZRjBeVMcjiv3N5z4iIH+cITCzTSw+rkIn1zN5Yr54IX2
         f1uQ==
X-Gm-Message-State: APuU4Z9BD0ONL6r3sDOHo8JZFU5st1nvwy4LjK/PhRD/KP1xb8i6VI4f
	j6nln5hoWg5guRiFZmBFug/ixO8RCX4yxXyOGHPkJ+NsEnDehyhAyllyIlwMRRUbv2meSqZaZG5
	xSlYMmrlcrimxAGdAeiGxUB7SzIPDPDQ=
X-Gm-Gg: AYBFou1FfEpeJWc1qqYPL0ozqkdhrnmKG8DxVCs5N2qtG5276vUV666koHZ26BRI5sy
	rYPMLs7O0kX0CL+uKsavn5cRiBC1n7G9UwAIcqXKc3W+ZYK3BT3+Wu0OP7w+WPgTCV9nlD0NPOM
	WK++740jgyeqE88OxzqlxpDKbkGY3QnbSa5tC7OXgemqMRdDWWj58DoJZAAItNgbqX5scaANVJy
	Ya3x1yQpBwtKGX9O8BcqtzsMWG3PLLgjA/w0lN0PSSeWFoGybmiSsP0Rhl7g8vfN+dAVgRXX+pv
	ZAMkCmY/uEG0Xqt0yVJDcvvGh7rPwzJM67Q56tEroJnsGDOA0Am+QlZ8R6GrHpavc7bquIY58Zg
	v/yDbFIhDbhf/3lSWIMhuGBzRUVxA8FDjyCK1oBAXtNlHGPqmhn3Qw27roGbPTyeCdv8kWUptIg
	QthETUl03RHyACntbsyh9fi8jDq3w4fMA8Jhld4SyAIDi/Zm7U4ZIFlYtv
X-Received: by 2002:a05:6820:4281:b0:6d8:462d:2756 with SMTP id
 006d021491bc7-71917839b13mr1289008eaf.43.1794403592871; Wed, 11 Nov 2026
 05:26:32 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110-exp-phy-rs-maybelocked-v1-0-3023cc9055e9@gmail.com> <20261110-exp-phy-rs-maybelocked-v1-2-3023cc9055e9@gmail.com>
In-Reply-To: <20261110-exp-phy-rs-maybelocked-v1-2-3023cc9055e9@gmail.com>
From: =?UTF-8?B?7ZWY7Iq57KKF?= <engineer.jjhama@gmail.com>
Date: Wed, 11 Nov 2026 22:26:21 +0900
X-Gm-Features: AclHuK_MX_7J4oHyB1e41Soi9c57YJbU8UeuGhhMvYz7AfKvCMuNHXwvqXPBaQA
Message-ID: <CAGAB665uVX9fMtMB47=OQFG76Af=H1tHiRA=m2Db8xpPBqyXVw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] rust: net: phy: pass a MaybeLocked device to
 soft_reset and match_phy_device
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, Trevor Gross <tmgross@umich.edu>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sashiko's review of this patch was also sent off-list [1].

> Can Adapter::read_mmd_callback() and Adapter::write_mmd_callback() also b=
e
> entered without phy_device->lock held, while still constructing a &mut
> Device<Locked> via Device::from_raw()?

Yes, and that predates this series. read_mmd and write_mmd run under the
MDIO bus lock rather than phydev->lock, e.g. rtl822x_hwmon_read() ->
phy_read_mmd().

They need their own context for the MDIO bus lock. This series only
separates callbacks by `phydev->lock` and no in-tree Rust driver implements
`read_mmd` or `write_mmd`, so I will handle them in a follow-up.

[1] https://sashiko.dev/#/patchset/20261110-exp-phy-rs-maybelocked-v1-0-302=
3cc9055e9@gmail.com?part=3D2

2026=EB=85=84 11=EC=9B=94 10=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 8:00, =
SeungJong Ha <engineer.jjhama@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
> The SAFETY comments of `soft_reset_callback` and
> `match_phy_device_callback` state that PHYLIB holds `phy_device->lock`
> when it calls them. It does on some paths but not on others:
> phy_init_hw() calls `soft_reset` both with and without the lock (e.g.
> from phy_attach_direct() and phy_mii_ioctl()), and phy_bus_match() calls
> `match_phy_device` without it.
>
> Hand both callbacks a `&Device<MaybeLocked>` so that the type matches
> what PHYLIB provides, and correct the SAFETY comments. Update
> ax88796b_rust, the only Rust implementation, to the new signature; it
> only does register writes and genphy_soft_reset(), so its behaviour does
> not change.
>
> This was found while auditing SAFETY comments of Rust abstractions
> against their C callers, and confirmed with Clang's context analysis:
> annotating the two `phy_driver` slots with `__must_hold(&phydev->lock)`
> flags exactly the lock-less paths above. It was not triggered at runtime.
>
> Built with AX88796B_RUST_PHY=3Dy and CLIPPY=3D1; a `soft_reset` that call=
s
> `start_aneg()` or `set_speed()` no longer compiles. Not tested on
> hardware.
>
> Signed-off-by: SeungJong Ha <engineer.jjhama@gmail.com>
> ---
>  drivers/net/phy/ax88796b_rust.rs |  8 ++++----
>  rust/kernel/net/phy.rs           | 44 ++++++++++++++++++++++++++++------=
------
>  2 files changed, 35 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/net/phy/ax88796b_rust.rs b/drivers/net/phy/ax88796b_=
rust.rs
> index 2d24628a4e58..bde801df305c 100644
> --- a/drivers/net/phy/ax88796b_rust.rs
> +++ b/drivers/net/phy/ax88796b_rust.rs
> @@ -30,7 +30,7 @@
>  // BMCR_RESET bit and poll for the reset bit to be cleared.
>  // Toggle BMCR_RESET bit off to accommodate broken AX8796B PHY implement=
ation
>  // such as used on the Individual Computers' X-Surf 100 Zorro card.
> -fn asix_soft_reset(dev: &mut phy::Device) -> Result {
> +fn asix_soft_reset(dev: &phy::Device<phy::MaybeLocked>) -> Result {
>      dev.write(C22::BMCR, 0)?;
>      dev.genphy_soft_reset()
>  }
> @@ -85,7 +85,7 @@ fn resume(dev: &mut phy::Device) -> Result {
>          dev.genphy_resume()
>      }
>
> -    fn soft_reset(dev: &mut phy::Device) -> Result {
> +    fn soft_reset(dev: &phy::Device<phy::MaybeLocked>) -> Result {
>          asix_soft_reset(dev)
>      }
>
> @@ -115,7 +115,7 @@ fn resume(dev: &mut phy::Device) -> Result {
>          dev.genphy_resume()
>      }
>
> -    fn soft_reset(dev: &mut phy::Device) -> Result {
> +    fn soft_reset(dev: &phy::Device<phy::MaybeLocked>) -> Result {
>          asix_soft_reset(dev)
>      }
>  }
> @@ -127,7 +127,7 @@ impl Driver for PhyAX88796B {
>      const NAME: &'static CStr =3D c"Asix Electronics AX88796B";
>      const PHY_DEVICE_ID: DeviceId =3D DeviceId::new_with_model_mask(0x00=
3b1841);
>
> -    fn soft_reset(dev: &mut phy::Device) -> Result {
> +    fn soft_reset(dev: &phy::Device<phy::MaybeLocked>) -> Result {
>          asix_soft_reset(dev)
>      }
>  }
> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> index 60c58bbc12d6..c2dfc58dbe55 100644
> --- a/rust/kernel/net/phy.rs
> +++ b/rust/kernel/net/phy.rs
> @@ -72,10 +72,10 @@ pub trait PhyContext: private::Sealed {}
>  /// other access to the `phy_device` made under `phy_device->lock`.
>  pub struct Locked;
>
> -/// The [`Device`] context of callbacks that PHYLIB calls both with and =
without
> -/// `phy_device->lock` held.
> +/// The [`Device`] context of [`Driver::soft_reset`] and [`Driver::match=
_phy_device`].
>  ///
> -/// A callback in this context must not take `phy_device->lock`.
> +/// PHYLIB calls these callbacks both with and without `phy_device->lock=
` held. A callback in this
> +/// context must not take `phy_device->lock`.
>  ///
>  /// # Invariants
>  ///
> @@ -322,6 +322,22 @@ pub fn genphy_soft_reset(&self) -> Result {
>      }
>  }
>
> +impl Device<MaybeLocked> {
> +    /// Creates a new [`Device`] reference in the [`MaybeLocked`] contex=
t from a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// For the duration of `'a`, the pointer must point at a valid `phy=
_device` whose
> +    /// `mdio.dev` is valid.
> +    unsafe fn from_raw_maybe_locked<'a>(ptr: *mut bindings::phy_device) =
-> &'a Self {
> +        // CAST: `Self` is a `repr(transparent)` wrapper around `binding=
s::phy_device`.
> +        let ptr =3D ptr.cast::<Self>();
> +        // SAFETY: The pointer is valid for `'a`. A shared reference doe=
s not assert exclusive
> +        // access, and `Opaque` permits concurrent mutation by the C sid=
e.
> +        unsafe { &*ptr }
> +    }
> +}
> +
>  impl core::ops::Deref for Device<Locked> {
>      type Target =3D Device<MaybeLocked>;
>
> @@ -370,10 +386,9 @@ impl<T: Driver> Adapter<T> {
>      /// `phydev` must be passed by the corresponding callback in `phy_dr=
iver`.
>      unsafe extern "C" fn soft_reset_callback(phydev: *mut bindings::phy_=
device) -> c_int {
>          from_result(|| {
> -            // SAFETY: This callback is called only in contexts
> -            // where we hold `phy_device->lock`, so the accessors on
> -            // `Device` are okay to call.
> -            let dev =3D unsafe { Device::from_raw(phydev) };
> +            // SAFETY: `phydev` is valid for the callback. `phy_init_hw(=
)` calls `soft_reset` both
> +            // with and without `phy_device->lock`, which is the `MaybeL=
ocked` context.
> +            let dev =3D unsafe { Device::from_raw_maybe_locked(phydev) }=
;
>              T::soft_reset(dev)?;
>              Ok(0)
>          })
> @@ -471,10 +486,9 @@ impl<T: Driver> Adapter<T> {
>          phydev: *mut bindings::phy_device,
>          _phydrv: *const bindings::phy_driver,
>      ) -> c_int {
> -        // SAFETY: This callback is called only in contexts
> -        // where we hold `phy_device->lock`, so the accessors on
> -        // `Device` are okay to call.
> -        let dev =3D unsafe { Device::from_raw(phydev) };
> +        // SAFETY: `phydev` is valid for the callback. `phy_bus_match()`=
 holds no PHY lock, which
> +        // is the `MaybeLocked` context.
> +        let dev =3D unsafe { Device::from_raw_maybe_locked(phydev) };
>          T::match_phy_device(dev).into()
>      }
>
> @@ -635,7 +649,9 @@ pub trait Driver {
>      const PHY_DEVICE_ID: DeviceId =3D DeviceId::new_with_custom_mask(0, =
0);
>
>      /// Issues a PHY software reset.
> -    fn soft_reset(_dev: &mut Device) -> Result {
> +    ///
> +    /// Called in the [`MaybeLocked`] context.
> +    fn soft_reset(_dev: &Device<MaybeLocked>) -> Result {
>          build_error!(VTABLE_DEFAULT_ERROR)
>      }
>
> @@ -651,7 +667,9 @@ fn get_features(_dev: &mut Device) -> Result {
>
>      /// Returns true if this is a suitable driver for the given phydev.
>      /// If not implemented, matching is based on [`Driver::PHY_DEVICE_ID=
`].
> -    fn match_phy_device(_dev: &Device) -> bool {
> +    ///
> +    /// Called in the [`MaybeLocked`] context.
> +    fn match_phy_device(_dev: &Device<MaybeLocked>) -> bool {
>          false
>      }
>
>
> --
> 2.54.0
>
