Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794402137;
	b=fqGzsjlqPKPIE13bkCWRjTwAy7lHJX6mooCGmCfXJvKYMBQUNHDMXdc9IJyiXxjp4tm3
	 C8JevHoR0hJnWdtk4XJTjJlPLIhRH4sPlQIGMDvwf/GcfLVUaq2hWspDV3ya4qJZcvBh3
	 Fu9G6ClbguxZu9WzVYkpa6S2qTqUyqaR6hfmV/2s67a3GE2JJS0wPG9jfOKLNyuK/BHBf
	 fTl6qF8GEklB6YYSzMcWKamRXk67dEV+Z1ZEDjr0uynSHhl0uBGsFh8l3/5CTIpXgH0U7
	 CZcmo0fRAEZLwjue2oqLf31yeNvUG86UDKwgrbzhjB1KeeJYS+DiOpMsqJ6Ko5aAXyw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402137;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=nX7qc9rNmcYIZ7uf5CPDonzii/Z2ibr+PLktCg4La0o=;
	b=WInGiy99JsQWUVDHgSlXiPn/PhuBDFaR67GBPtC2bFwD33UFNAyIBboAsbeWZKdam1f1
	 DijnSCFciAqe18aC6VuXMJE02eXd56UmcpFXDhpvus5CWhpi51HK1nPQBQMEc8dck4a0h
	 gE+vehUoFVEgu5lh20V++Q92PjvNk3TCw2oJ8oddpmNCoTOq9p3Hn1bOen/jolBHaepEx
	 U9v4L7rTnAhtOHPm3DEi9FFFbZWk+bkgUlH/eHGWlsGOS08HyAA2Ws+n+rnZ2K7G6QwWA
	 Nzbb1WXHIqNCN9TrU+t82jaY+WnkizzMNOzmHDN1jlfzQ0Z1KEx8N0k0sHAT6vDkFmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XU2lr0rW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.53
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A7E606A332
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 13:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82A7E606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XU2lr0rW
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-4adae3eb4d3so1291205fac.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 05:02:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794402136; cv=none;
        d=google.com; s=arc-20260327;
        b=Lujq4BPhuo+IZPGFXC1n+rmR8KGlqrIC1gq7vr1fIVuJiuiYAf77y3MaOlAN6UGvhk
         6IKWb6O4br1s0cGy+KOSiNoPs6LeUS5UheMIl4xrkE28WYet1TOrMoqckKQh7SLkYBId
         02BHH0DkgXA1B/zG6j1+1NKXuAecDKGvCS9PY2mr2LS0XQtTCErICjHv70bj7aLx4FcF
         PQ7kOXzVtWo1RQ0A9lnzhFL5RG/Pz4mVeyVoXSOpWoulkLejuKCJ1V1g5msZtQtz0312
         2RNc1et0osPfRhjDDcmClTEgYbJ0ITPZP6tf1hBai35sHiW80F6X0508MbiwQiqu7gfc
         uczQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=nX7qc9rNmcYIZ7uf5CPDonzii/Z2ibr+PLktCg4La0o=;
        fh=KcodZMkMe/b9ErhgRsFsATQa+Lv8G0ybAPHNjhgdq4s=;
        b=ekE44NwewaZM2Yz5F8m7m5mvuZrST+kA45Eze0Og2R3tS3xUzNJ2G06RSW3tVLsDCX
         Xu4s5O1Ma73Rbo2vZoxkB2rqI18SBE+k5HUy9aXiy2ki8Tu5zYm5DM3z4CapEuDUt7U9
         nHl3rvscmpJp2+lHCoxWboWKZJPTf/M9lJ9lIeR2nPnKmySAOS3AOVzHMQhD1gzWZlTE
         H4r4Zk/js0I2C4sbHXadNypA8cPTyiwyJ5Nw7Rfe7yMmaVoKhxlXeQyIhtRMxJSX6wn8
         O9YprFGQvhjNSABB+p/Ue1yGJc9z1KxBCGMjakMY4zw5eqJMt1hYNrQe9J/ZIYV4KGvc
         dQeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794402136; x=1795006936; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nX7qc9rNmcYIZ7uf5CPDonzii/Z2ibr+PLktCg4La0o=;
        b=XU2lr0rWzFRjJIIJUzN04OUmRen1C1VcmIGzUXnaQVk6tg/62Lmfbbgx7t4GTgDNRE
         rb8rVDc5VFFcOor9LRkTxhNbJAVq6m18xv+Vfr1d1On6AY2mjaLNmQYu6CTwa1xYSt4L
         FdcQy6fo3o3MHaZjyAWtWH3UyQq5fQdTN1ZjSNCc+C7xds80ukr7KE4LZx1A6eb0H69x
         w0PJC9RgsAlctoChVykksVv6uZRisbfaKmLxMtJJDHEdBpwrHzKpBUkTtCH/Kye8LOOb
         FS/xLl4/LzHiiApjZTMiL9S7dJA0bEx9mAOmzipxWcVMd/cZcuXOvlupPj0I++EMCqHo
         cRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794402136; x=1795006936;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nX7qc9rNmcYIZ7uf5CPDonzii/Z2ibr+PLktCg4La0o=;
        b=HDDqKY/b5lhJ0aXxe1r4eRPqTDKzGawvR27XlAOfBc64wssFRmolGUFXUkoAyRo3dn
         c1s7WhQoPpIwGGAO02t636308pgilCJQwmdAKmkh8lRXzu1nXnLZPIqEwMZJulIzL87k
         +Oa+966qxvOkYpxclJZugl4J7inbmF7ZE7S8drKzLQqAZRKX1VGpD8JW7VnRDUdWwxIq
         v97wF5tB3XYl+hvlUEcbF0KLu9vH1pchRCwfHXo1nH8+KNVccB1Lwn5PB7su/+0etMUv
         CobL3TquE7bo1f/VtnWPUkapeGse5j2yRudib/jAM/JKKv7iY4sfAwVdf1VmOKgF2w9R
         VISQ==
X-Gm-Message-State: APuU4Z9RH01AR1q8K7uQlxMvVDfQpMowwUVmAOylg0XHrypdSxN7YYqL
	WjKPsfRBs0+6C63G0i7KtuNZYEs5Dkvy623rPJF1AmH7aUAEOMAw7GYV4O4pSWv82vwVPDyiNAc
	0vfsaaNeiBHxyKMYAWPCnybyENgiDOq4=
X-Gm-Gg: AYBFou0IivIZHZwlwXxo4bZ44QnInjKIvZ0Rn6i2li7ZK1975kbBxKprc+/2TaCHmMO
	NJYaFlYjUJYO7BuDhdx6lWZ5YyelW5puQt+hO0buamQ+8tLGCDpePqRIprNQkG5A9NcHNXLlmf+
	td6FJO1SfT4r2a7hwjnPvnMiQRmL9r1YhiqbrvTI4SaCV7c1ggx5k9np1CKmyH6knlFPBwSGePB
	CpuMrVAjrJkw5XNzmvBVBxtyRbDGrxiDWYjOBnrrbXQ2ohAm6DRzN+IG2lAefPesIlG1tNnAsYd
	toR/xxxRkTP3wBWfswp5xBSI5X8cnTRsosTlqZ2y8zw6AZ5azdJdiGquMZfL0hvwlHIeyyvsnGd
	3MJ+0/1IcYcNrRCthsHnO6nUalKFKWlsD+H0y+Xa7J5aXb1BD3Rxy2djZiDCNpGewHW06rFnm8j
	/uHkNQm6YAHohQIbQDg0BYJrX9rgu9dIi4SZ8Mz8s02AjbcXcER98IxpfT
X-Received: by 2002:a05:6870:ac8d:b0:4ad:8667:442f with SMTP id
 586e51a60fabf-4ae46b1d1aamr2290030fac.25.1794402136269; Wed, 11 Nov 2026
 05:02:16 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110-exp-phy-rs-maybelocked-v1-0-3023cc9055e9@gmail.com> <20261110-exp-phy-rs-maybelocked-v1-1-3023cc9055e9@gmail.com>
In-Reply-To: <20261110-exp-phy-rs-maybelocked-v1-1-3023cc9055e9@gmail.com>
From: =?UTF-8?B?7ZWY7Iq57KKF?= <engineer.jjhama@gmail.com>
Date: Wed, 11 Nov 2026 22:02:04 +0900
X-Gm-Features: AclHuK-SC0uSru3uT5u5C9HU1bsCE1Mn6-6Bwp33kN4egHoHVGBL0SbyXWSBoQA
Message-ID: <CAGAB664Z1avii3rw6pSu4wT9eCmwYJ4R08ix2Z_YNm9KeEs-EQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] rust: net: phy: make Device generic over a
 lock context
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

Sashiko's review of this patch was sent off-list [1], so I am replying
here.

> Can calling genphy_soft_reset() on a Device<MaybeLocked> cause a data race
> on struct phy_device fields and bitfields when a Device<Locked> callback
> runs concurrently?

The race comes from the caller, not from this series. PHYLIB calls
soft_reset without `phydev->lock` on some paths, and on those paths
`genphy_soft_reset()` and `phy_init_hw()` itself touch these fields the same
way for every C driver. This series does not change what runs there; it
makes the Rust interface match that contract, so a soft_reset
implementation no longer gets a `&mut Device<Locked>` and cannot call the
methods that rely on the lock. Before it, the callback could do strictly
more on the same path.

> Should the methods in impl<Ctx: PhyContext> Device<Ctx>, Deref::deref(),
> AsRef::as_ref(), and the Register::read() and Register::write()
> implementations [...] have #[inline] annotations?

The moved methods did not have `#[inline]` before. This patch only moves them.
I can add it in v2 if that is preferred.

[1] https://sashiko.dev/#/patchset/20261110-exp-phy-rs-maybelocked-v1-0-3023cc9055e9@gmail.com?part=1
