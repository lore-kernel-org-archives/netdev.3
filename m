Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE1727A476
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 01:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777510863; cv=none; b=OGyhNdJiCK15ANpEBQK2JJdJE5gihc8cGF9gQ2uRTHc/GHs9WxFd3iZad7XpoTXK3dEQyDkWF613G4Uf/MgAf98sSRYFeYEez49PrrEdQXBdBdRfEu97hFJm+z9HEifG0FBgMxPRfKrRb5JHCW9uhweBRA0ewqbDR3p8JOQCeU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777510863; c=relaxed/simple;
	bh=Kop4YNUipvs6vp1kt9DE1V8i3VRKn2Vpku3AP8lFstM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z7DgbVEsIi520uYc14n4l1kOWAyM8YqsIsh/JIpol1ZKqsovBqYOAH1h9XVqqea7/5OcuZwzBKKrGovluH2dcFV31gk5dCPFfPGdMp7oWF3V3vifTT7rwGqS1OSvFnEUkzgvLOE9RxTHpjVZ/CPmAr7+NhUMXE1lcZyWfJd4VTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QeZpOU2B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeZpOU2B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910EDC19425;
	Thu, 30 Apr 2026 01:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777510862;
	bh=Kop4YNUipvs6vp1kt9DE1V8i3VRKn2Vpku3AP8lFstM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QeZpOU2BZfJCl3y/7wzyVhwznzzTKL/dU7z5PLW13n2UBB6Rjcl3nZhhIZ0kxS+H0
	 N1rb6l8O0CX1Gf948BK1QrEa9/AnnBYo1s7r1fcTYgqYO/QDUkLI1S5mMrhP4hS6c/
	 7GOYwHtk7mNLWRe048uJ6j5eHrBXewisWeCxJIFKp//LU6IC9r41NH3Ke0SxP5BfXt
	 MjF7WK+MNbs2DRz5uMjHOqfpSe9VcjIUM/nKI1WAj/wV4aVepfDtfwO57Yy0DlYrrh
	 Yt+PolCIWslh7U0xqV0ZUf2GXUhg0+7AJdYGxGXNORo1d5akta14NuU0LfWAwq+06B
	 OGZKkXItouw6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C563809A33;
	Thu, 30 Apr 2026 01:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: airoha: Rename get_src_port_id callback in
 get_sport
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177751081754.2244169.1115345882578217600.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 01:00:17 +0000
References: 
 <20260428-airoha-get_src_port_id-callback-v1-1-3f765c91c1e8@kernel.org>
In-Reply-To: 
 <20260428-airoha-get_src_port_id-callback-v1-1-3f765c91c1e8@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Apr 2026 07:23:38 +0200 you wrote:
> For code consistency, rename get_src_port_id callback in get_sport.
> Please note this patch does not introduce any logical change and it is
> just a cosmetic patch.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 10 +++++-----
>  drivers/net/ethernet/airoha/airoha_eth.h |  2 +-
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> [...]

Here is the summary with links:
  - [net-next] net: airoha: Rename get_src_port_id callback in get_sport
    https://git.kernel.org/netdev/net-next/c/c06a2f2903f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


