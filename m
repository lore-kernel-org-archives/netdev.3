Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA974CB8C5
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 16:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790956809; cv=none; b=mRGdedMqJqDm3B9S3vaR9vJmMS8/H9nHmxyKmB3wvgBucSTfVDfbTjYKei8+Ho+OusGs+3KhUQ+mt7lqAgXdm02IPQdo2zzGS11K8GdGKVBTeyD5zoQS6v1APbClV3M9Whee7uRnT3zWEfka35gMGr1Q/cmt0/yGio+3w5T0uUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790956809; c=relaxed/simple;
	bh=YNNj2iSROYMoBL9ld/aKaROpcG6zw1kAKfQ4kk6k0PI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uuqosDb9ajQCqyDBgBbZJbjJnJPD4umw4vBEdy273y1GxyweouxGvhpGwFNZKbgHvhIyShac+yeRpzIwK7/CTvj0t6Pa7L9lUpE9/w0Ae5H6CFN/jRBD6COqUIQUm0EYBN+M/WpWAKXGnSvbfMUCi2Q0n1k01b2HnvIwMyPyre4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUKb6wlp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUKb6wlp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096F41F000FF;
	Fri,  2 Oct 2026 16:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790956807;
	bh=iUeRw0q0tfCa94ngJOJP7LIkhUdsPmjvchZ1zCnq660=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WUKb6wlpdjIrhJEJX/PR0FkmSA7eqQGCPaYcKaPqCKpbDShdKEtyJQiWA70qflqKU
	 JgM1psblYJ8Yr3/pzQ4kL9IwlFtGBVnCA6A4EBkZnQEIrKOj4m1Y6PqMCEYFXZjHSG
	 p45UdpOX+LcNw6lCcFCA1a1Q5b3/wD+4k7MFrNguyjwU72myFBXt47I1PoTYe9HTUT
	 NQ/jYTKtGxaTBiTbUVV6fK1vB+1TVTeKUOFX4MNKJx+aJuMqzpgEVD5ERESz6h2RW/
	 cI/lmnJJzKaJVrlDrCNLYOxY9UouxEoQm2jcrowW8/n1XR0Xeh5XNUysk0A3NCUePB
	 mJGRVpBNewAwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F13843811A64;
	Fri,  2 Oct 2026 16:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] lib: fix memory leak in getcmdline()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179095680565.3481673.2793297593244675536.git-patchwork-notify@kernel.org>
Date: Fri, 02 Oct 2026 16:00:05 +0000
References: <20261001023129.290059-1-ml.abusaleh.ml@gmail.com>
In-Reply-To: <20261001023129.290059-1-ml.abusaleh.ml@gmail.com>
To: Mohammad abu saleh <ml.abusaleh.ml@gmail.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Thu,  1 Oct 2026 04:31:29 +0200 you wrote:
> getline() may allocate line1 even when it returns -1, and the caller
> must free the buffer on the error path.
> 
> When batch input ends with a missing continuation line, getcmdline()
> returns without freeing line1. This can be reproduced with:
> 
> printf 'link show \\\n' | ./ip/ip -batch -
> 
> [...]

Here is the summary with links:
  - [iproute2] lib: fix memory leak in getcmdline()
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=fde561a2a135

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


