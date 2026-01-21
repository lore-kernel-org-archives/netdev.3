Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3ED357729;
	Wed, 21 Jan 2026 19:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769025343; cv=none; b=BSIB4nCUL42tOP5FFyxLVyMZieKMOkI2+sGMOe9mheCfAbIgwa5aNeRbn6LJ8I5GoicRZOMjyAtumRrb+J20BxKVDkBwYHUPF4AexfNrZ2++J9gDWtHlCyjBBgYyiOh4x3tdlHKY37rU159osviOtj7E43vP8xg/k+Q37SNWPOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769025343; c=relaxed/simple;
	bh=8p5uyubsxxpFkaOAIvKe/2g67L691Fv8Sx46a8BUkoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=To9BNWyn8Fn+j++LNDDEh+pE0yEzURqlFb2xjKKd1f2jMKEiT0VTkrKVi+ezTPIBN7LyeItOL1hhIeIPCU+J3IMBxda/pkYhhn8TALkOMjbwWiIl2Pz1GUP+VN9HTU/3ewJ53/DmBXL8TNreE2FFqQE/ejELcq0AHHJYWb+GYKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LspJr7xB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LspJr7xB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF506C4CEF1;
	Wed, 21 Jan 2026 19:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769025342;
	bh=8p5uyubsxxpFkaOAIvKe/2g67L691Fv8Sx46a8BUkoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LspJr7xBizgVrkTbSS+i6MsCzkJgClWH9MlKsTQ7fRmeirau8M5HhROwYB9NrlDYn
	 saBejI1co0neKoSJEqCeoB9Jcpv0fBtvwTB4picPj+D0wQnB8lUNNhJfca9yfPwDv4
	 BtFjD1K0y6wwpJSSbK4XakEG0NbDcFBN+dXQNnN5hK/biWzkx4UH/E5mLPsuSqmy6K
	 GaS3a9+0veJkrTo8N4n77a2hVVd9IwY83ij5E6NBVAh37zTnM+QxlOasBWk6yqiUbr
	 7Ua2RjEHp5/gJCKFOfKU9tiwIMKyeMu7R4t7EzoAk2s+FGid8TIEKbM9UM3Z4SooxF
	 LfCPV43VvOfEw==
Date: Wed, 21 Jan 2026 19:55:38 +0000
From: Simon Horman <horms@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net/tcp_sigpool: Enable compile-testing
Message-ID: <aXEvOqjkMPXk28x2@horms.kernel.org>
References: <e4822cf4aa03fed067f5df7cd4f3496828abc638.1768487199.git.geert+renesas@glider.be>
 <20260117163304.20caae7c@kernel.org>
 <CAMuHMdX9J9QPp16aDD-_2Q-chWANWeTyS6Dw=xJdkm8r-sPyFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdX9J9QPp16aDD-_2Q-chWANWeTyS6Dw=xJdkm8r-sPyFw@mail.gmail.com>

On Mon, Jan 19, 2026 at 05:26:37PM +0100, Geert Uytterhoeven wrote:
> Hi Jakub,
> 
> On Sun, 18 Jan 2026 at 01:33, Jakub Kicinski <kuba@kernel.org> wrote:
> > On Thu, 15 Jan 2026 15:27:26 +0100 Geert Uytterhoeven wrote:
> > > Since commit 37a183d3b7cdb873 ("tcp: Convert tcp-md5 to use MD5 library
> > > instead of crypto_ahash"), TCP_SIGPOOL is only selected by TCP_AO.
> > > However, the latter depends on 64BIT, so tcp_sigpool can no longer be
> > > built on 32-bit platforms at all.
> > >
> > > Improve compile coverage on 32-bit by allowing the user to enable
> > > TCP_SIGPOOL when compile-testing.  Add a dependency on CRYPTO, which is
> > > always fulfilled when selected by TCP_AO.
> >
> > I don't see why we'd care. I understand COMPILE_TEST when the symbol
> > is narrowed down to a very unusual platform. But this is doing the
> > opposite, it's _adding_ a very unusual platform on which, as you say,
> 
> (I wouldn't claim it is a "very unusual platform". 32-bit won't be dead
>  for at least a decade ;-)
> 
> > this code cannot be used today. If this code regresses and someone
> > wants to start using it on 32b they'll have to fix it.
> >
> > Please LMK if I'm misunderstanding or there's another argument (not
> > mentioned in the commit message).
> 
> In general, we want to be able to test-compile as much code as possible
> on all platforms, but not bother everyone who configures and builds a
> kernel for his system.  Until commit 37a183d3b7cdb873, that included
> the tcp_sigpool code, and any build regressions would be caught soon,
> and fixed (presumably).  Of course that still doesn't guarantee the
> code would actually work on 32-bit, but successful compilation is a
> first step...
> 
> As the maintainer, the decision is yours, though.

Thanks Geert,

In my understanding COMPILE_TEST is about expanding compile-test coverage,
and that is what this patch does.

Reviewed-by: Simon Horman <horms@kernel.org>

I do notice this patch has been marked as Changes Requested in patchwork.
So maybe repost to re-activate it?
