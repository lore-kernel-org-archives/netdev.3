Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963173A7835;
	Thu,  5 Feb 2026 10:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770287407; cv=none; b=EKD6tWqH94DY4l1r/E3+rizoLPZmEe0JbD5ThbIIj33fk9Q6wEYJtEOv6xZ3cey5s312HE613rREFWPdo8LNx4u/jdMVV25CVbroKQBC82sLCI26/h299b3pQ8qf6ZTu68sWVdVX24CPpJHugJA2Js+V6gbkIxYUmfXwU7ipahk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770287407; c=relaxed/simple;
	bh=K9VyTzx7Hr3MuJyRCphzhN1MshauDt3Xyk0BD7fEtLY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cM+o2gE3DQlPvCqRjBhKcin5t1y6Qp8AVC4GVEcEhx0SkArGvbU7UE1U3vsWsbsgf9anQjd5H0DkkK13Cn5KY4cIfizdUAJOCMhXB1V5F36nDVd2hsxla06NhriwF3y/4Ir4KfIJiQrGTyKDE25fFmO7MUExih1nxbsKAgfB598=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QeBlAI3H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeBlAI3H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1BCC4CEF7;
	Thu,  5 Feb 2026 10:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770287407;
	bh=K9VyTzx7Hr3MuJyRCphzhN1MshauDt3Xyk0BD7fEtLY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QeBlAI3HKaZWh9uqS+4mZD/nBz0IpDkXaZ23sb1S+YCHv8hy8/UPOLAjZqYzyIj1D
	 xdGDppc3bFiga3Vz3gOXapIAKbQDOhyW1NBRVBGZEJ1M2U/jSEyC2NPgIFH02qZNaC
	 e7TVujuw+pByCPS67n4mCXIu8M8UbquRKW3noFn6oFQRGlPOLBimGyE9cL2AaL3H9L
	 PAQ6xbM8uk4nS2Zbs0T1LE5+QyrYqJb0VZOqMC51taUU97J8w3hb4WxZw2DR4rJDi8
	 7xmLCPnm1/QQ5S6qZhQ3tEs327WYKfET+F2DPtmbXwgLj0rqZLtmpaIYjXPiVt69f0
	 yQOj+OJIxDy0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 481BF3808200;
	Thu,  5 Feb 2026 10:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Patch net] MAINTAINERS: Remove myself from TC maintainers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177028740508.262447.15247318751033830630.git-patchwork-notify@kernel.org>
Date: Thu, 05 Feb 2026 10:30:05 +0000
References: <20260130212021.46610-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20260130212021.46610-1-xiyou.wangcong@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@resnulli.us,
 kuba@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 30 Jan 2026 13:20:21 -0800 you wrote:
> Recently TC maintainer Jamal intentionally a broke reasonable
> use case:
> https://lore.kernel.org/netdev/aG10rqwjX6elG1Gx@pop-os.localdomain/
> 
> Although I tried my best to help by:
> 1) Strongly objecting this breakage from the very beginning
> 2) Reverting it and offering a much better solution
> 3) Offering Jamal for video chat on 8 Jul 2025 and 26 Nov 2025
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: Remove myself from TC maintainers
    https://git.kernel.org/netdev/net-next/c/0cbcc0fdce2b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


