Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793233808;
	b=RcEWPb8pGufNbHUe2taxTwA58VBxNf7oUF/J8uJpTWpgCi3afRGFaz/IJoHwLC8IBRlr
	 izN1qEFXwG7kUk63UJJjklMw9Egok6oJVkZP/BmxF2ED3WKLJtesq1T7IXYgR5PshV7Sw
	 2wUZfocLQPPnZVV+0LNA0ylN5c7YjnazrGaRdywTufWu9qghu+L2flRbpe/cI/B8sVuXj
	 nz73f4zTEtX77krCl8wmy2mJ6YqLBuq19w49U8wpJVb/hlp9+aWCaDe71xtmYiZvWYrJB
	 KBJlN1OIAC7O+LxXLqEDH7kai/eRoxREG1AbN+kohZudPJuTza/QQesdcIdRUpFXOow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793233808;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=oAFyZOwx7kvhTg5/hTfwP7/bDzhPp5MaNft1aGJPLvc=;
	b=kkhbYQ8WcDp2mzQyh20InG1goSHTEmbC2n27isr3Fvzom2+6Xj24ECgkLM6UFBwK7qhf
	 YqiGkPt0ArjKlHAg/JtsXFI2SLJae94H6+5tZH3Rdc9mzjyZJ6fCzKJAZ50hulJn9dFvs
	 vPJMs/27dmjHAUayAskQolIby75ujNfM03LrLuDaSQ5X2l+vBkSo7W4sf9XlY445cEfJY
	 eSeTLP688ko6/VMON3I6L3EGjWxxH9VXnrlKaBaw1ERVWRfQ5ZtKTq+3xwvqADE3BjCni
	 toRhe1543nKJYodlhY6qXeLZg9b/v5hEGbAPMVWbLYLbiIf3gN75ih+dida4GIx+DgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g3Q8Rl7N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA7B606A322;
	Thu, 29 Oct 2026 00:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g3Q8Rl7N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCE91F01825;
	Thu, 29 Oct 2026 00:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793233807;
	bh=oAFyZOwx7kvhTg5/hTfwP7/bDzhPp5MaNft1aGJPLvc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=g3Q8Rl7NfX79EN6CVcAdZJZsQOAxQlo++BpolGWmbTjam2/qWuY+cDisfypxSkdO0
	 XymPcQ+6SW+cDk8KpS7PFhvDSQt5/8HvPjINeOZM37F9D7tKqenIQRZHVz+S5TU3F5
	 d7MBU2K7XxfpE3L9Too7PKS34IV/odMZst8LsueptUcEoVygD7L6tY3LE81yUJbj+g
	 h6U0H3AyuCkBD71tdzC8DaH2zSdU2l7gA3jcwct+5AeKzKLml5lHOJYphHlWkNuSsk
	 +b1cIJMq2W36pqZEpsDEerVTXk383hlNyEZvPLVB1J++aRrOSB946dr1ls4uvWkWpw
	 Gy3+xbUgbGoLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 444CA3AAFC4C;
	Thu, 29 Oct 2026 00:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mctp: usblib: Fix broken assertion
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179323380581.1497553.17321944752133745060.git-patchwork-notify@kernel.org>
Date: Thu, 29 Oct 2026 00:30:05 +0000
References: 
 <20261026-dev-mctp-static-assert-fix-v1-1-ceef9913e891@codeconstruct.com.au>
In-Reply-To: 
 <20261026-dev-mctp-static-assert-fix-v1-1-ceef9913e891@codeconstruct.com.au>
To: James Lee <james@codeconstruct.com.au>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, geert@linux-m68k.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Oct 2026 11:32:32 +0800 you wrote:
> The expression in a static assertion in the kunit tests was not
> considered constant by gcc, causing an error. Replace the static assert
> with a runtime kunit equivalent.
> 
> Fixes: 1e12f734afc1 ("net: mctp: usblib: Add initial kunit tx tests")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Closes: https://lore.kernel.org/netdev/CAMuHMdXTGGdGWZ9sKz5_sQF1237gV844cEhkXr6v_TUHPOb78Q@mail.gmail.com/
> Signed-off-by: James Lee <james@codeconstruct.com.au>
> 
> [...]

Here is the summary with links:
  - [net] net: mctp: usblib: Fix broken assertion
    https://git.kernel.org/netdev/net/c/8146be04908d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


