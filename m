Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793829303;
	b=dSmd0p7Pd/+JOYip4NSauyaTKdvOu2xgl9EZXe59BaFqqf+RuAuWjFBX9eHUhrbwqxGu
	 Orap5n/xsSt4GG+4MvrH2E5hGHONsZr5+ELBKWaIdPeKTn1dvS02F8YEf8wNXvEag3aJQ
	 NLYLX5+YecKgwnNmpX2fP50gH9lxNbG9GzZzkBP54J/0rmDX1Y0tjcWUe+q18O1LXY3Bv
	 J/CHzduIQD+ntgqH8yy/Etd3oG/MyotckU6HN7bXtRQwcEH6/0XhvzB5PRKzrtIyaeIQR
	 uaaVXxJXpu0RMp5GnEO484Zh5ATK8J5ANt+vWIp71GcFay4NjrYDXZjimOmhCwjnIJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793829303;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=OtqVTx74iD0Sp4Bbn7WEPLQlERnQa+4V0BtNpGWAxZ8=;
	b=j5mKDpGgRT/NGLJI+LdtjEOl6AG+CGE8lYnJWcmsZxbID8talU/H9MIkOzqODIy1+I2f
	 /jMuWx+iKbIALSZohhl3NeYMGNcE06JPnXBLeuAKQRaG0+4e3aFqB1z1SwRNesLvrTK9Q
	 54DW6uDeoY3grxL9YhKMUXmHrP9Apqrmff1P2NYjF3FEH0ROiGTBKqscIp3nckpyqV9pe
	 tGb81DmsdfKSyr0vCo/tgH6hzEr83bp5gKVtMakivJybCB8cqflUZUECjzOCVoG4zrSvb
	 v5RgINif7KZgAwev5WpaqShW7YhN2zCuXrG4N9TgeIzIn2dWCJJaXaZYx4xSogwe/fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zachschneider.com;
	spf=pass smtp.mailfrom=zachschneider.com;
	dkim=pass header.d=zachschneider.com header.i=@zachschneider.com header.a=rsa-sha256 header.s=protonmail header.b=XfalIpmk;
	arc=none smtp.remote-ip=109.224.244.20
Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch [109.224.244.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02A8608660A
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 21:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D02A8608660A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zachschneider.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zachschneider.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zachschneider.com header.i=@zachschneider.com header.a=rsa-sha256 header.s=protonmail header.b=XfalIpmk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zachschneider.com;
	s=protonmail; t=1793829299; x=1794088499;
	bh=OtqVTx74iD0Sp4Bbn7WEPLQlERnQa+4V0BtNpGWAxZ8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=XfalIpmkra+4G6TIfzXN3P07mvgy0mwhH72HWUfJuj7zXXsplVAPZS4M0gFdJGG+T
	 k3vkV3HUc7eCuOduENIEuooERSWOKNUQQz91nw3QvyrJ/HXPdkOyrX5VVqgdPypaJS
	 NuwreKd5e30vnYmwO0J9DJ5yJjHFK5RHhcWghkzncwyzOCqwIkokW9v/8RbJK2rH6D
	 VDTLfP2Kjmyd9+/aEl0/kLW7vrDJdAxmWSGXeAJuEr8TcKoy7yYiE7/j9ixv9wThYw
	 BrbN66lxSUc6vhFpvEFhVHPQM4Stx+D5lM6ba7JPXqMt4PmD5uf9mDYSxB+8HoqtUA
	 4gaKQMF/qLhag==
Date: Wed, 04 Nov 2026 21:54:56 +0000
To: Jakub Kicinski <kuba@kernel.org>
From: Zach Schneider <me@zachschneider.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, netdev@vger.kernel.org
Subject: Re: r8169: RTL8126A (XID 64a) TX packets lost with TSO enabled
Message-ID: <b0oeaAtAyqYEqeVhnKks-yIHdPaXsJ2jKv6mf1-dNKYO0PlLdLg8J3YuyGng35U-3XBenDAwohSYctK0pXjUMEwA4yyvfTM89zpa8MkTb_Y=@zachschneider.com>
In-Reply-To: <20261020172004.69c2d778@kernel.org>
References: <20261013230904.58717-1-me@zachschneider.com> <20261020172004.69c2d778@kernel.org>
Feedback-ID: 134141743:user:proton
X-Pm-Message-ID: d9031605c3d38825d29bfb6264c582af155113aa
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks for looking, and sorry for the slow reply.

I tested net/main at 6baae996ecf6 (includes c2124f80be4c "vlan: restore
HW VLAN tag insertion with reorder_hdr off"). The problem is still
there, same 100 MB HTTPS upload over enp14s0 as before:

  r8169, TSO on (default)   upload stalls, >120 s,  29.0% retransmitted
  r8169, TSO off            39.4 MB/s, 2.5 s,       0.0% retransmitted

For what it's worth, there is no VLAN device on this interface: the
test traffic is untagged on enp14s0 directly, which isn't enslaved to
any bridge. So I would not expect the in-band-tag path to be involved
here. The CONFIG_R8126_VLAN remark was only about why the vendor
driver ends up with TSO off, not about VLANs being in use.

Happy to run anything else.

Thanks,
Zach


On Tuesday, October 20th, 2026 at 7:20 PM, Jakub Kicinski <kuba@kernel.org>=
 wrote:

> On Tue, 13 Oct 2026 18:09:04 -0500 Zach Schneider wrote:
> > For comparison, Realtek's out-of-tree r8126 10.018.00 driver ends up
> > with TSO off by default on this setup: rtl8126_fix_features() clears
> > NETIF_F_ALL_CSUM unless built with CONFIG_R8126_VLAN, so TSO is dropped
> > too.
>=20
> If this is VLAN related it could be due to recent regression in VLAN
> handling.
>=20
> Could you please test commit c2124f80be4ceb6e from net/main ?
> 
