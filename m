Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B80238F255;
	Tue, 11 Aug 2026 01:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786411854; cv=none; b=mJLCnl8m0jSyUvSKrRFqyVIbvxLcy3Mjm8YcPWgJbJtoIJCeoKGGOdh9bQciTREhnOZfnWnakpuEhynZrPoxQuOEh2gDJjcHMU/deDyqMiVonG9993xLI5xZt7nsQCTL8qLvgao0v4wzFQI/IY+5F38RxWCUckuFwpkm0FWDrho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786411854; c=relaxed/simple;
	bh=2KpUJLnKgpQSWz5FRZ9/GwTEzmYO3oNJQl7xHVsoNgk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i94XSqLELuxsNsyYPj9PJcn5EaVU3WQ5r33A1On5dTGU1TXIY+PoYIPRlnacByNVgaW3rGU7kWTA5Eh/VYCmkRwi+8w/6s8jvTahAb+k94h1YjNsswFv7SKmC9V4ozb6AVDFWk1vAiJ0qParz0CXfOO/GEYZOW8Wc4HNQwYfxdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/LYcpnA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/LYcpnA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B101F000E9;
	Tue, 11 Aug 2026 01:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786411853;
	bh=vkUxybeNgVaNdP9yG3MEP4eE+cQrYhTl4tKUS/N+QOI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=n/LYcpnAn7Oq3GjB1piG5gSAOLYdA0BtVEpHc+quM8RC/qI5e1iSluzGAM8K+FTjJ
	 x/1xwSc5orTAZliPlDxcKgP52em0HS49Pe4VKRtuoJ89CSiL5zB1gvGyfmFl3YdT4H
	 3uuHoWCfcwUc6kIjtvhyMFu9Nlj4DDBxO/Nnh9bdvHbjvXjcWld5P36wc5Sl20/Z5c
	 u+MbyKHTcRQHl1ayTPCccNEu5nhi4r2I9IvJiijxQwpYYkFXW4WGyItE33J9E3bAnG
	 RAcAaVfm92CnFLHG3kK4dPy5tlAiqyuqjMuGKAGjsxRTTV+BoSfcaJ+sgcXiog6Fmn
	 2v6IWz8Gfwy6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AEB392626F;
	Tue, 11 Aug 2026 01:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/2] update NULL pointer handling in generated
 code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178641180939.287084.735844536020296651.git-patchwork-notify@kernel.org>
Date: Tue, 11 Aug 2026 01:30:09 +0000
References: <20260807171500.7188-1-thaisonphan@google.com>
In-Reply-To: <20260807171500.7188-1-thaisonphan@google.com>
To: Thaison Phan <thaisonphan@google.com>
Cc: kuba@kernel.org, donald.hunter@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 gfengyuan@google.com, stani@google.com, ast@fiberby.net, matttbe@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  7 Aug 2026 17:14:58 +0000 you wrote:
> This series fixes potential NULL pointer dereferences in YNL-generated C
> code during dump list freeing and memory allocation in parsing getters.
> 
> Changes in v2:
> 	- Moved null check in dump list free to be separate from while loop
> 	- Updated allocation checks to only be for getters as setters will
> 	  be handled in a separate patch.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/2] tools: ynl: check for null ptr on dump free
    https://git.kernel.org/netdev/net-next/c/7c62c481bb43
  - [v2,net-next,2/2] tools: ynl: check alloc fails in generated getter code
    https://git.kernel.org/netdev/net-next/c/153f709c8639

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


