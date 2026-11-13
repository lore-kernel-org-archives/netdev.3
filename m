Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.161.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794550216;
	b=ykbykLCz9EK7ibv4Jps/rM3adm87cXrj3jLdreOaNAbTRMJdAFiSjQEfZP1m45Qtkjly
	 +bFdjKGo7RfmP3AtdKRxTNGisk7sEIZeZBQxsRF3ixWV6yBqkdmDkQwPs5WXTBfjrC4IL
	 P0D0IEobPahQKK5Bl5eL+sH6utsytKEQALVQifOBp4dZ7bfJ1tO8vF3BK0MwebU8h8HO0
	 ZNBPfm1Mex4rJR3NQy/H0uPlyVqR7P4FAzK82h2nV8pVk196T8E/W679oYJJwlBNSS56l
	 m2eEQ0Iq9rQNBiNGkF4rDn/8K8q7JDuUS8qHnPEA2riqiv7wiZWCW3ASFKkbEWuZOLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794550216;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=3cQxNlYjkxquFu1pWFdcxgvYVr86+DzpHkUj/AQLnyU=;
	b=fuZUpXElHs+0L1545Ak1A71nohxxa0MZirz6JKClqL+OfpnBHqwPzh2CDm6WpGvoNUAV
	 xcucOWkdPIRFiVtoMYqmmWAr2BCKy+X0OvhIKFWTHgSFt2x4iE6vzjz9fmf/EWdjUHbAN
	 9brco43+yIGS9XPJSqIIhutA2ORiSMYsGhP9K4+vbpQ8NT8PhJ8hbVdmonDVQYgt3S17i
	 gX8qVp0+vngu7tiSiVflCtCu49jsNbLP7iNl0obmofZlYk4V5HBaDWMBh3Z4hD/a+/Epf
	 aaPZRsSALxmvHpPdskU33EdWkbcO5LXVF5b+iQ12EZ4Mi0RqChSrh43Ls3hg/nOoW2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="WA6G/ruV";
	arc=fail smtp.remote-ip=209.85.161.52
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B20606A321
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 06:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2B20606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WA6G/ruV
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-71ab5e64742so674527eaf.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 22:10:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794550215; cv=none;
        d=google.com; s=arc-20260327;
        b=NUj8ISdcxVdNBb//alaRZLtop6W9R08StIdA2yKafLQC9FYel4oF9RjYMNk2M5sFOK
         EVtE6lLHSq7aex7SPMF/VveLFe27pSHsx9YZosuHnHiZteCv58LzFHon0vUiMZPTymFr
         xclkPZp2B9Vtu3FNugw1WcN4+y29wSYA6K1gWlM3e5LM5mFL8aeR5Q/idhxs+22lMpix
         vf4z9cZ7WeKrj6iTpysDgXlMY0prmJ4m/AbNdu+YBotYEmm6qMwuqkbJb9ExlHBBQRZ4
         zGQ9WXIJfpq5qhzFSAp2G8OY5WomaaiHF8xDwU95ma2EAzyhp2bDebOMFmMPHioDucaM
         gFag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3cQxNlYjkxquFu1pWFdcxgvYVr86+DzpHkUj/AQLnyU=;
        fh=WWZFAsduFMbOcKhJipHNKh+jA1BiQOQMhASlWZ8XbXM=;
        b=m4tNIskGacmB3qBLHgMiOMXE6ZuL/QxTISZZIfsiflql/sL3VBH6WBO1Ovd5Efflyz
         GrstlMcPRu87abLlAecQrM/5pZIUqqtDeQDetUFVTWYzNkYprWeh+85iLStLjeOZFVxT
         GamKFYAL4sc5wVcR5sOcwbQvBfZNaCWO4V7w4GY+SAAt6Faec1CBs9Toh5YrJTIVZ1ee
         EKbWWIxvL5J0L8kypeVQaSljSiOiyhTbU6PTezgkAva1GSCe7Fn9LW2icD2O6pHEthbT
         DthqiqBmVTmq7e2K1oEDb2qk5SSsw1BwfajUd/mFSgfW2JopWr089lcYNEP5LFPy/xbp
         VcfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794550215; x=1795155015; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3cQxNlYjkxquFu1pWFdcxgvYVr86+DzpHkUj/AQLnyU=;
        b=WA6G/ruVj33Xcc8MAVixoMTzolifZQDlrHnLE0EvgGR+xSkc9Y8YbDgO0rKh1Fqh/a
         nQ26saUTpi3TU2Y+uu5kYKO6kqdni7y2mwPZQeCm68OzvoE3xZz4iJeHgyJMaUUnJtId
         mB6udLTCkyP9lpyoR+jXswiXRXEd9xptiTLbuIAKfrj0oFwcOoqbq2VsO6fNDnUOpid5
         jc8UAxFazsIf0JfbbGXGv+uvt67C3FoOZDsmnsPDBM8rUfaI+ju3pyweh39gzMt81fA5
         q01req8w+i/UdPTWOC9iqP/lhDcj+9Pn9ESfbzsb4tgq+m92A9qiv62eSd3TH1aj1+UC
         aOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794550215; x=1795155015;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3cQxNlYjkxquFu1pWFdcxgvYVr86+DzpHkUj/AQLnyU=;
        b=x50ntL2sG50vXKpAvYJVtWPnk2bHYPZVJ0mnKZxd+JKQccUAUJsuBjUygBCweaWsWh
         uB6ABSU/34dpwVbBvnT5r7oFVGk2jQ1xkZlSxjOqgsl/qjTPnuFjZwv4/WeyZJWKl4hN
         +FjS1puLWgt7X8ojh5jji+N2oNfhyaV8L7P9OutkzabTTtfZlSrWvzQVlK8iDqQOAU6Y
         nFyWeRPUBiOs7ZFymcPgQ0T49j1eT5fia0NfDWARHiACKMNRNwlRT4xb+DK+jKZHLpox
         93nc/v4lhZztAlHb1iqedooY/dtAejajCMzl40uoO9ZFAbfD9d5XxiVG7QaAd9k1z9ZA
         UAow==
X-Forwarded-Encrypted: i=1; AL+hErGJcxk2Iy2oP8KMBPpXFnZpuM4Tg+qqp219xZftuaQD3yUQTKAbf4pj3LbuT8SIf6BQQqndYSI=@vger.kernel.org
X-Gm-Message-State: APuU4Z91rR9yaytZ4YP7E3jQcXHcOmG4X+HzsuIjJv6JH2maT5P/L9Qe
	jNDul4fIceeCvO0e/jTp7b3JNHu/Yh1/b1k+L9Ex7FQmnit33WqrFyT8SYYDS8so+vWnta7S9pT
	tCEbOuukDyUlqVaBj26Fn/iyH+n7H8fI=
X-Gm-Gg: AYBFou2zddGC8gZ347wv39rLD3VB1/r2otxfnUN2hv8AivgPk8ROASPX5hn1fzZvKPJ
	DFMsR1kvslb6wCTEdY2/9c3t9RLLSooLExZZ3yRJ9u1m00nVYIOgNle7HPoKyPbPxKv80p4jnzP
	gIxs63ekaaxuus3644zJE5xn3l9o9WwPRjyrCoRYNgBsB4vjlOKo0MlNXXdtEbx+GuKO1u2LiCK
	5Uriv7mDrcdf+gMBjuLK9yNb7uK9JyVb2YTpAnPGN1TrbBKGzF3PRUaoZjx4aXz/KvvBzQxhsxL
	w4uMDLyQbw8RkMXv2oWn4YbnDxxnAVe5rLbeaGAv/1B2jC7DbHIti4G+pJ1SfSDHT9jK73im0sU
	7LTzpezvynQ8OE4zjWFO94dLFaC0hIIaph7U8DIWF1L6MBl+lwDAIB+zom0GCbIeajGlhBdeTgU
	T67X2QBpEU/py1aGESH4HMxiNfITtiAxGMmv3im56DEZS0kSF8hxO6RwVaGwevlhuWNJvwztWlf
	uO+YQ==
X-Received: by 2002:a05:6820:c0cf:20b0:6f6:1e3a:6fc with SMTP id
 006d021491bc7-71ab51a2d59mr713841eaf.79.1794550214796; Thu, 12 Nov 2026
 22:10:14 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110-exp-phy-rs-maybelocked-v1-2-3023cc9055e9@gmail.com> <179454612500.2199510.688554972467066283@kernel.org>
In-Reply-To: <179454612500.2199510.688554972467066283@kernel.org>
From: SeungJong Ha <engineer.jjhama@gmail.com>
Date: Fri, 13 Nov 2026 15:10:03 +0900
X-Gm-Features: AclHuK8K7LUv1bQRf5-U0TPkDoWKhawhWDsTrvclohqGU442XIPQ2sC58L1Zn6c
Message-ID: <CAGAB665d+tpGT34GPD6TAjc_Pn225afYw2ebLb12ZFnUXZoW6Q@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] rust: net: phy: pass a MaybeLocked device to
 soft_reset and match_phy_device
To: netdev-bot+sashiko@kernel.org
Cc: fujita.tomonori@gmail.com, tmgross@umich.edu, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, dakr@kernel.org, daniel.almeida@collabora.com, 
	tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev, andrew@lunn.ch, 
	hkallweit1@gmail.com, linux@armlinux.org.uk, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, Nov 13, 2026 at 2:02 PM <netdev-bot+sashiko@kernel.org> wrote:

> [Severity: High]
> Is this conversion complete? read_mmd_callback() and write_mmd_callback()
> in rust/kernel/net/phy.rs still say "This callback is called only in
> contexts where we hold phy_device->lock", and they still build a Locked
> device:

No. This series does not touch read_mmd_callback() and
write_mmd_callback(); their SAFETY claim predates it and is wrong in the
same way, since they run under the MDIO bus lock instead.

> No in-tree Rust PHY driver implements read_mmd or write_mmd today, so
> nothing triggers this yet.

Since nothing uses them and the abstraction cannot express the MDIO bus
lock yet, I would drop them from the Driver trait in v2.

> [Severity: High]
> Can safe code in a Rust match_phy_device dereference a NULL phydev->drv
> here? Device::read_paged() is now a &self method for every context, so a
> match_phy_device implementation can call it on &Device<MaybeLocked>:

> So for an unbound PHY, this would oops with the MDIO bus mdio_lock held.
> Every other PHY on that bus would then hang.
>
> This wasn't reachable before the series: read_paged() took &mut self, and
> match_phy_device only got &Device. The previous patch, "rust: net: phy:
> make Device generic over a lock context", made read_paged() a &self method
> for all contexts, and this patch makes MaybeLocked the match_phy_device
> context.

> Should read_paged() be limited to contexts where phydev->drv is known to
> be set, or should match_phy_device get a narrower context?

Neither. match_phy_device should not get the register accessors at all,
as before this series. The patch 1 findings about genphy_soft_reset() and
register writes from match_phy_device have the same root cause. Patch 1 makes
the register accessors &self, which hands them to match_phy_device even though
it can run on an unbound device or one bound to another driver. That was not
possible before, since they took &mut self.

For v2 I plan to keep &mut self on the moved methods, so match_phy_device
stays as it is, and give only soft_reset a &mut Device<MaybeLocked>.


match_phy_device is more about binding than locking. I think it belongs
with moving phy::Device onto device::DeviceContext, as pci::Device does,
rather than in this series.


Fujita, does that split make sense? And is this worth doing now, given
that no in-tree driver is affected, or would you rather wait for a real
user?

pw-bot: cr
