Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD538190462;
	Mon, 17 Aug 2026 20:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786999650; cv=none; b=nnAfeXbq9AGYUI978bxZM9AdnBCMwjS0izEZosNXq+/y9GABorBBrCtDF1m5ahTjvwZu+f2shhHcDlnEmx5rSW++1vtTAdGfvSYqprYhtaG0MYUEPhyiz+xsnNAi1zkc5Pfq6FFA9L5p1JiP4y8eU7z+mlloXDEwzClMHLf7xHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786999650; c=relaxed/simple;
	bh=wmSs3CCifD0QB0lPTo8IT3YQIqPTm8qL1DRJOY126R0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pZlKKVXF4vnHF/o8tNiLPHOblge6MhzYZJshdx8NXTN0YpPaCHS4mepbKB40k8u4tVMCwSgiwsoMFrlTNvH3BMbkoojgbKjqm3u8e+aiU467OiHbie8CRjA2QDlvq9ifNvhfn8pHvaRfr4j/8ADQvZ3hPRIXAh2RucVJRUoiuAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FL0z2pUn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FL0z2pUn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910901F000E9;
	Mon, 17 Aug 2026 20:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786999649;
	bh=111cZwE+fIsihcrOn87KAVC+gmNsgNFaiu9bx9gzA6c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FL0z2pUnciX4/Rv9iwWhFcb2vERfUR1zoJ8VQv1oWRemL7hekh9TWUinYS67I7TqN
	 RlQRH3t/1/0njxFN0sL0e0S56NAmnj6JwcipGbfE5sv9zWwxQyWA0SH/mEbb4fuqmh
	 7Xz1AHU6cYORwQULXlq+2x8bMt0eo3YqTDPn7I19Ajg+DgwB19B0L8E3TbP3m2szIH
	 1l7+129bQJNtPWJGJOUinh9MHY2jp0u6cX5f/wp2ubcd0jT63meYaz6iz/efakqDRU
	 +/Dxc38W25cd6Jy2JNSTQGv3kZbaXagWuC2ThDnwjwBBo7eDIrgdhs6+AFkrcsfBuj
	 7j7a6isGz0/0Q==
Date: Mon, 17 Aug 2026 13:47:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH v14 00/12] net: pcs: Introduce support for fwnode PCS
Message-ID: <20260817134727.1f76d6dd@kernel.org>
In-Reply-To: <20260813083536.970196-1-ansuelsmth@gmail.com>
References: <20260813083536.970196-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 10:35:05 +0200 Christian Marangi wrote:
> This series introduce a most awaited feature that is correctly
> provide PCS with fwnode without having to use specific export symbol
> and additional handling of PCS in phylink.
> 
> At times there were 2 different implementation (this and the one
> from Sean) but Sean agreed that this can be picked and used in favor
> of his implementation as long as his case with race condition is
> correctly handled.

Coccicheck says:

  drivers/net/phy/phylink.c:1039:31-34:
    ERROR: invalid reference to the index variable of the iterator on line 1028

  drivers/net/phy/phylink.c:1364:26-29:
    ERROR: invalid reference to the index variable of the iterator on line 1346

  drivers/net/phy/phylink.c:582:7-10:
    ERROR: invalid reference to the index variable of the iterator on line 569

I vaguely recall that you're supposed to make a copy of the pointer,
not just add a "found" boolean. Dunno if it ever happened but Linus
was trying to make the list iterators override the pointer on exit.
