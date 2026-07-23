Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049524C9571;
	Thu, 23 Jul 2026 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815864; cv=none; b=o1VZuTkNhtQi2D5OG1D3c+fuZLn1mmV5+m0FasMBWhqGVS6SJ6rVxdYjA5+yhp4EDf8mqxnup+uGG6ZqsQeQItbdLPJ/a1qqp83vQgxAkNNUPke1fgyk3795DIdBpyDW/gS0wEveBMv8pZf8JscWpdo10Ekdryivip1/qsb1YyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815864; c=relaxed/simple;
	bh=3l8MXE+VnTvlhYbID0R55vedMeYCsGmrzi4NOmUGOTk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W7qPukvt5DOpOETSJXZhd6JXx+zsK7bhxgcnwt4mrfEfLJH1jyoF+m3LvathqKvNWskOZqlHaWgHxORD5s3gciAZ4mAQUl6p+80iSNc7OYLwcUM/oKDzLnEIW5T0RR8g2OE5i0UFz7oqrNFvwIYQlfRhjPJz2rcnCOgfYpcRjk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFg512lp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFg512lp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774AC1F000E9;
	Thu, 23 Jul 2026 14:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784815849;
	bh=EzIxeln/K3o/FEGzSuu10C2BJ5FqTOjtJuNcPDwX018=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EFg512lpa0xADYUuDWg5YGfUTOKtKCP8MUU1Fs2hg14aeIQiLEb7G7Yty7nfXjHc8
	 3ndK5ogMP46asJjP0cdN0y7MvIueQb1LaD9iHetXyrob9eLc/nCt7+tZDP3GmYbkf7
	 PpZRPxxQbtwyVI00UIq7gn2VA9/btY2AqEBUpJrXnPLoEDHmI+0SxcS98UKLRRdU8W
	 jbXoKPo/wPUlTNji1lFSgujpEeT3g889Rrtu+nXzS/LiaqWRy5U6WW10S6To0UW5BC
	 erm3K9h3kX/Jg7zwdV1kv/rFCnNhq4RlGseRgUzE30XPUkH4twLxNGsTqxMf2kX+9E
	 rcMr7m8fQMUnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B9E380CFD4;
	Thu, 23 Jul 2026 14:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] MAINTAINERS: remove Rengarajan Sundararajan from
 LAN78XX
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178481581765.2248593.858642503736967572.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 14:10:17 +0000
References: <20260722134143.4141579-1-nb@tipi-net.de>
In-Reply-To: <20260722134143.4141579-1-nb@tipi-net.de>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, Thangaraj.S@microchip.com,
 UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Jul 2026 15:41:43 +0200 you wrote:
> Rengarajan has left Microchip and mails to his address bounce. Remove
> him from the USB LAN78XX entry.
> 
> Link: https://lore.kernel.org/netdev/DSWPR11MB971547088066C2CA91638F3BECF42@DSWPR11MB9715.namprd11.prod.outlook.com/
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] MAINTAINERS: remove Rengarajan Sundararajan from LAN78XX
    https://git.kernel.org/netdev/net/c/249447ff8396

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


