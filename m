Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5C83FFAB4
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 22:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772835008; cv=none; b=LmZ4cxeRx2fk19r6uC7so6B7tWj7mJaXC1MG5lJCpxu/fTgP8aobivzuglzdp2C2/rmlERkmNhCDPr+0SBgZzMrGMEbbsR4rUnTfLGXqyqexyOTq2DJ1uEobfDdnuKxeVT2EaI6+1gMIs+x/8N33MuTn97B1xjUGSHtnwRrp0NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772835008; c=relaxed/simple;
	bh=myFCBmCp8rc3NK49fqZqMVKU2I/M+tj2Kbqr8PdeqPo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iXdfX9wZ8RwT2w0eK4bd6iQFy+Ij/fVsdxtZw0PJ2++U7Ivlej1k/qherlz9KFKJ9g61zChSFOeSf2Z3Iv+dzuwXsmacbuLtWhS3/K6jl44cT8XLQFjv7qc56VxMzkwpFqBcWtpswMk7p2OEWQ2FrxIEnLg2p0lZ++KaiFzVZjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3iK7R3k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3iK7R3k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD1DC4CEF7;
	Fri,  6 Mar 2026 22:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772835007;
	bh=myFCBmCp8rc3NK49fqZqMVKU2I/M+tj2Kbqr8PdeqPo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A3iK7R3kpI6szjSIm/xUinGQatMvau/0OIcW+Ry8Ou7gq8UxiMfZwtYP8wdBqS15/
	 EU/VB8SzHjg2TiDu9THcqohASbNUgzu6yhFGRvWn81SPx3wKhfFsCqT4hCqWCwo9UA
	 XlyYMa335eX0lhc9BkYzRDk7fE28hHlI3XtmevHm0XkUOPquOrpx76XhmV23lVBpHd
	 Em4J3kT8cBwjr0zNjIvsGk+jjoH1QFjiV1w+A0EPKtkjKUKiYs4p+Gzudralm7Andg
	 yVwizbgAvrSX8SEXI1yc1xTQviUjLfrB5zPbN49yCCxmJjAh484gTv5FrZLNXkdFvk
	 NyU16NsYjoJlw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E163808200;
	Fri,  6 Mar 2026 22:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] remove leftover references to /usr/lib/route2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177283500680.70173.6809575605648805585.git-patchwork-notify@kernel.org>
Date: Fri, 06 Mar 2026 22:10:06 +0000
References: <20260302164026.112728-1-stephen@networkplumber.org>
In-Reply-To: <20260302164026.112728-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, yedaya.ka@gmail.com

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon,  2 Mar 2026 08:40:07 -0800 you wrote:
> Since commit 962692356a1c ("Makefile: use /usr/share/iproute2 for config
> files") the path was moved to /usr/share in Makefile; but there
> were leftover references.
> 
> Reported-by: Yedaya Katsman <yedaya.ka@gmail.com>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> 
> [...]

Here is the summary with links:
  - [iproute2] remove leftover references to /usr/lib/route2
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=bf0f8e79cd13

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


