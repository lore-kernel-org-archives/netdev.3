Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810C4301717;
	Mon,  6 Apr 2026 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775489967; cv=none; b=li5N9P+oFBAeQ4uboKPLO3jLhmtNhFyjHBfa7stCG7mV9Gc2MLaF7TevPIp7/JnoZGo7PKZkbtA5fZ9YolmfEFBrknwCgvqW5avkomVbtQ/t27hCrwEo82OK+WpenuEwsbSYl5Yy8DqjSLfcEEw0a5v6SbQRzw9sIhQY+0H77v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775489967; c=relaxed/simple;
	bh=dBBOOPYccQdP+A1MwC4aCCDHzpoBm0wvT7ybVzIt/eA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jJw3BKWM39CGvX+Tu3stI5gOeY4mHEtn8PsRLl3HiHKUraaWQRvGSFwtwsrxFclciH7mc7S9fmkYGc8CST2mfTPByLBgmoTFveKmifMbdeb9WnBUV5wNviF+8MeXDLh98K3+PblRFqR6QEQYmbVjx3yPBfg79OaUDtagLEI0vn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OA5kMl0G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OA5kMl0G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5B0C4CEF7;
	Mon,  6 Apr 2026 15:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775489967;
	bh=dBBOOPYccQdP+A1MwC4aCCDHzpoBm0wvT7ybVzIt/eA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OA5kMl0Gi+T8g5RhjXEe9hvsyaDredPQ0qoKai/Yc2nG0IF2V9s10lPjTrGcgfHqD
	 /MOwP5I4JtbJx9Cft0D0SL4Gb3BxDzumow+6rjVi0BMtkEPjYmujEfQA2o9pgMGTIh
	 JKDJlwP27ryxpBgtjRqlaqNL5n/ALriHd/KvIoO9xLgUTUX0j6PSNbTaUNNw1OtCoo
	 RgjpXfMbWHNCqxfvUTwm8D3Nzy+qe4MDYEzh2uzUew0bv18KBjyT/eacUGgZ3vTjW3
	 fPodZeSM7qm2Wmg5LySWQZ2mRa3pBaCsvrmrOEghQjMH6cnhP/VYK++30tt5UjY2CP
	 N3ybr2jKzraEQ==
Date: Mon, 6 Apr 2026 08:39:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Julian Braha <julianbraha@gmail.com>, davem@davemloft.net,
 peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
 mcoquelin.stm32@gmail.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH v2] stmmac: cleanup dead dependencies on STMMAC_PLATFORM
 and STMMAC_ETH in Kconfig
Message-ID: <20260406083924.5711ecd9@kernel.org>
In-Reply-To: <CAMuHMdUfzVSQpadJYpEqPJ_UOBAgswnGzD_bp_U3U6jt2dy0dg@mail.gmail.com>
References: <20260402145858.240231-1-julianbraha@gmail.com>
	<CAMuHMdUfzVSQpadJYpEqPJ_UOBAgswnGzD_bp_U3U6jt2dy0dg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Apr 2026 10:23:46 +0200 Geert Uytterhoeven wrote:
> >  config STMMAC_PLATFORM
> >         tristate "STMMAC Platform bus support"
> > -       depends on STMMAC_ETH
> >         select MFD_SYSCON
> >         default y  
> 
> This now lets us have STMMAC_PLATFORM=y and STMMAC_ETH=m.
> Does that actually link?

Hm. Sashiko didn't complain when patch was posted.
Typical LLM indeterminism? 
