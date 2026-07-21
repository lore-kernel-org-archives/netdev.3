Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A25D449B12;
	Tue, 21 Jul 2026 00:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784593918; cv=none; b=H/hgQHDzpTLidmS27fq0x5kjH79hPMHJIaDvFnP99TJiNmapVXiavjpd0/J70qrnNET6VQu2dhB4J856PjNSvDSPSzpAVCcQF+pLb1PADRwahugatqPxgIKFev+4VCEB4gntV/UQYbMjfucAmoCH5ldystWMXZ44d7N5k52mxcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784593918; c=relaxed/simple;
	bh=Y2uwrnXD1yCuKAAXCSTvQKaF7FZv4+rBs6ZOI2GURBU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H3MHXGhSpHVQfLUy/Ot6hTbeWZJDSmTKCd94X/YR7o2QvNB/MqIv4bA2OqH6LAjMT/ske655qHEUY34/3V7JN7ZNbwGzSY5IpE5VotP5589uRRF3dQyvoy7gf1J1Bn9tmnSaCbImmVzzqR6CTqpkWypyhRfmrqn9I6Rszc27MWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nh4ithPb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nh4ithPb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903231F000E9;
	Tue, 21 Jul 2026 00:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784593916;
	bh=qkqUGbdOhkA/L26zEyrPqfNV8ihvBQGG9TisT7uTIGs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Nh4ithPbMdIfvRpnGLpAIdSpWdGhSt2PcjxyKicypM6PrSVhbw5RcTkEO7Ln4Z4q0
	 j2eL7qL9l4JAS6yqh331mHe9pZHSPE9GQ8No3JgtKTHoyczb4WXxL9bfwHI9xuYwbe
	 7pKztkEzHYoZlgzraOuijD9o4H7My9KLRVStVMG2kPEswBulqb6eehuNtM32thvtOd
	 jPj5fE2cUXCae8znZIVGQFlED12BxTqQehqaoDyPOR5Ruvnt5EHCgidspCZunRyrXq
	 wiI+gnC6dlzAShCL7oZsdJ7O6kNtnOorNBo4w7t8nKfGzNifwx/tS975arqdk4WYzf
	 Cl9Cep3dkEt0g==
Date: Mon, 20 Jul 2026 17:31:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Martino Dell'Ambrogio <tillo@tillo.ch>
Cc: netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Andrew
 Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] net: sfp: quirk support for XGS-PON ONT
 sticks with unclean EEPROMs
Message-ID: <20260720173156.41189431@kernel.org>
In-Reply-To: <20260705185440.136496-1-tillo@tillo.ch>
References: <20260705185440.136496-1-tillo@tillo.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun,  5 Jul 2026 20:54:37 +0200 Martino Dell'Ambrogio wrote:
> Some clone XGS-PON ONT sticks ship EEPROMs where the vendor PN field is
> filled with non-printable garbage past the legitimate string instead of
> the SFF-8472 mandated space padding. sfp_strlen() then can't trim the
> field, the exact-length check in sfp_match() rejects the quirk entry
> before the string comparison runs, and the quirk silently never applies
> =E2=80=94 so the kernel honors the module's spurious TX_FAULT and eventua=
lly
> disables it.

The netdev patch queue has overflown.
If these patches are still relevant you'll have to repost them.
