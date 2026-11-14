Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794616341;
	b=jnTE2hxkBlA5ueqOVFE4dj+irjvM92cKKaBTrlXnOhuNDn5I1A6+XyJDudaVDOL+K7ON
	 Ou0n4f/sC/dCKuhbKQOeRheXHDMIpX2rX8G1/GmT0rFWvZ8RCwIphBM/xKHr2Xjfm4u4e
	 lkly66nv+EYS/I+2HXKVixbD+ILUf5qZFwFC1So9K65azRIKIt7EMh2oy5rLjxzmhsamJ
	 koEx0tK2zh233IvlST8QsKzBgIyx0tgZ0bDFaUzPF7iuY8cE7RdL2nhNk6hrSZuj2faIh
	 byCwPva7rZ3m5cfbj8sWBk5xCoAxVDWTg4ugFKOM7fD0IuFoc9nPWez6E3AaiAShXjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794616341;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=gkbU5EDdzYPCddiCey58CsoeSyTe1/vy92g3Bk6idAA=;
	b=Ur8Z8EwDZJaoik4V897cmLdeK3G+q2GVcfzUKGTtx6DhCobHc6H9Dg2QqCYQlrz3FTsD
	 Z9+PJ4fCtIiXgqrdaFeyGgUp8VlZq3m5UT2EsMwd/GM689I0mmpCcOpgc+CSdLonX0RyQ
	 502dFflzLi+SgJtBVzluLZqHvX6n3mfDrRiLHyp+0bXC+zFPrIU/vvmf+WDOP29Ragj+f
	 apeR1csWYk5pl3FjErHNRw5Lnl5pFGvy0ximG+WK1iySOzsuzRiY4I9lSaKD5qKpcHHEb
	 +4BpAbdn+0CPkAHvD0A6Zlv+HjHXP3p1KcUFEkUwqvUuY5SRYFGdgus6vwT6HeOKUFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gq6mhsjJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52387606A339;
	Sat, 14 Nov 2026 00:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gq6mhsjJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8221C1F000C5;
	Sat, 14 Nov 2026 00:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794616340;
	bh=gkbU5EDdzYPCddiCey58CsoeSyTe1/vy92g3Bk6idAA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gq6mhsjJMcUOVK+DkCQqf41KJbVhP3uZcvZWnSyromuysQREI5cerdRsohIeoKMDr
	 +46roK4SUABIWXZkBApNuPv7yps8t3/ruyCfc68/j3xnJqukgzYBA3kypmzxcc4UER
	 dlVqqU6v5wWN/iBAc/zUGTNcpJhGvcb83/fJ0X2nKFXnKtysGHs0dHu+//o0aNNKZl
	 W+NMcQUXyG4vB5bAPGQkI0P3g8KP0214C+/tg9e/U+hdNWpyP6INhLBpyOuFjqBEmc
	 y0l/FNcZkrpq/PUyub5ZR14ZlApiKYRhW4W7Q6ymX4D0hA398WrTcPElS/asmoFVR5
	 V08r9c+SDnG8A==
Date: Fri, 13 Nov 2026 16:32:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
Cc: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Woojung Huh <woojung.huh@microchip.com>,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Wei Jie Law <98lawweijie@gmail.com>
Subject: Re: [PATCH net-next v5 0/2] net: usb: lan78xx: do not use
 uninitialized data after short reads
Message-ID: <20261113163219.16603c83@kernel.org>
In-Reply-To: <20261111013454.34542-1-law.wei.jie@gt.tech.gov.sg>
References: <20261111013454.34542-1-law.wei.jie@gt.tech.gov.sg>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Nov 2026 09:34:52 +0800 Wei Jie Law wrote:
> Testing: the series builds without warnings (W=1) on net-next and passes
> checkpatch --strict. It applies unchanged to v6.12.105, where it was
> tested with a LAN7800 emulated by raw-gadget + dummy_hcd, booted with
> init_on_alloc=0:

Why are you testing this on 6.12 if you're just using a gadget and not
a real device?
