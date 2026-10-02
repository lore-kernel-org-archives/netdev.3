Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC834C7558
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 16:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790956811; cv=none; b=s1mywGPXIqZ0mB/mbzR8Rx6ilsRpmSy+eNpi9mjZIBMMvE5iaUli3rHwDSZtXQpKEMRkZjUFOVBCH5A1zaDeSBskhuZGdr+Grx9WlSjL3RNQNSmBg3ZTHYEkqyEQRSRH+SZOSxhPDDyVYW575A1On0Re9PSFnVixxXdt9227u5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790956811; c=relaxed/simple;
	bh=urTXYyJw1jSSvzaGb86AmnQhGp/u8HAnPmlDUdNDvds=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TZ+2V91piPbsY71H6JwiV5Kx4tm04OZ+Waf641pnopK2nEURxYVIU6aVwPAnmRYlSWdzjcchvK9Oha8CaNXuJ1PzZdCIrfvkaTRaphSRxn5zP7EX6KMArdA7gRqjpSsFzxhF3oW5qp/0ZX77AFUbkYuvjVWBN1rO1y2AUL7tJEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z48wiUk+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z48wiUk+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803C81F00893;
	Fri,  2 Oct 2026 16:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790956808;
	bh=/g3dsvI7lc5kvIar/ZrLFsqrFFO7KWfu/6UBIq53Ejc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Z48wiUk+1z7btq3jQfpDhQNqatLU9b8eKBqbriVuAOL7g82KrrixRvhVnuxNo2TV2
	 DUir5p2ExazJmKdv9WovI1PlvWWEBPh892poOHmoFMSjtsgj7aXD68I4HGoe+WkJSE
	 XXGx16E53B2vmAs9Y0Af6PIw1lWcZ38Oy9pCSeGuLAFSYjoKoEhv6YOGLojPF5PG76
	 NCFw9y5yWdZP8QgpAU8wiLv/4ta9UU4as04DLF8zznPdfoGgY7rcZyoeTmawqSURzh
	 EqWwqxCc5NpE4INbZd0toY9CTEX7iLK/BzZw3bRYcKwVsvmvr+EGskBcPus9N8DxbS
	 9x/Q6lzOp68qA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 772793811A64;
	Fri,  2 Oct 2026 16:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] ip: remove redundant human-readable option
 match
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179095680702.3481673.32263878775680752.git-patchwork-notify@kernel.org>
Date: Fri, 02 Oct 2026 16:00:07 +0000
References: <20260929235543.210365-1-ml.abusaleh.ml@gmail.com>
In-Reply-To: <20260929235543.210365-1-ml.abusaleh.ml@gmail.com>
To: Mohammad abu saleh <ml.abusaleh.ml@gmail.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Wed, 30 Sep 2026 01:55:43 +0200 you wrote:
> matches() checks whether its first argument is a prefix of its
> second argument. Therefore, matching "-human-readable" already
> covers "-human" and its abbreviations.
> 
> Remove the redundant condition.
> 
> Signed-off-by: Mohammad abu saleh <ml.abusaleh.ml@gmail.com>
> 
> [...]

Here is the summary with links:
  - [iproute2-next] ip: remove redundant human-readable option match
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=a954ab5afd8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


