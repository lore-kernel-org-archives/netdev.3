Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90213009DA
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 16:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468413; cv=none; b=k2G12gQCRAY5IibLR7TTK24zW+vRkJJc4YE9G+8R3VUhMb8n5mQKLRWWB8iuhtCvKxfP5RgqgL/ps74/Bg/Myd6hWdNpgqhHLNm9tVBI9Sact+qmzxyg2wluizcMtgIkTfnLk99PcXCKr2Re8d5mFZs5Kz648CAXZgmtkxn0TCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468413; c=relaxed/simple;
	bh=ZqcPKYmNn7w9MoOYdpAZbldHeEDNA9ie7Uk/ya6gwZg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DDiHcSlhRbOnsxe69lTbVx0htoecXCMAqIz3yVIrDENZoHusuV0n5t9/wKu3LJAqhSsxaPKPVNIweCCsEr9VcXBC5STP1xxSzLSlAe5cUaJgf+A6zoEmHNnzsuJzFrGeFlqobkntid4MR5DVVr7tjDVxmD4FTssBtztCiglHWes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3f1v6g6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3f1v6g6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CC8C19423;
	Mon,  2 Mar 2026 16:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772468413;
	bh=ZqcPKYmNn7w9MoOYdpAZbldHeEDNA9ie7Uk/ya6gwZg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p3f1v6g6FJUlXyJa1/zjPhurdZ/PsyjnPLvj3koZN9ttUusOEN3DxKknsmcDUk7QN
	 P3MJtq3zVXECJZEjWQuIZWdChrKpDt004Z7/4qkl6iKseANyZqCbdpQz4PRjGwtIBx
	 P+JduVWpLohJuPXt7EIVoZ5DZyyDr+leh9QLcwNox6zuBIzDWUydiZ8r6DMq6kUs10
	 I8APj5mMZEVHLb5RneIIuAG4aDnkXf+JUnLrvw1+VBMxzjW3JfEjETEetB6zHFPZ0R
	 BsSSo9a0YVUSsh3/Y9gOPO9xqg9EUNh91AiceHRdixTfBze1hnura+YnMl3lQUbq1o
	 nOVKP+EjJT3lQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEF9393089A;
	Mon,  2 Mar 2026 16:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next 0/4] dpll: add client-side filtering
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177246841529.386537.4187689212377491244.git-patchwork-notify@kernel.org>
Date: Mon, 02 Mar 2026 16:20:15 +0000
References: <20260224091243.58501-1-poros@redhat.com>
In-Reply-To: <20260224091243.58501-1-poros@redhat.com>
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, stephen@networkplumber.org

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Tue, 24 Feb 2026 10:12:39 +0100 you wrote:
> This series fixes a parsing bug in dpll pin id-get and adds
> client-side filtering support for dpll device show and pin show
> commands.
> 
> Patch 1 fixes a bug where "dpll pin id-get type gnss" would read
> the keyword "type" as the enum value instead of the actual type.
> 
> [...]

Here is the summary with links:
  - [iproute2-next,1/4] dpll: fix pin id-get type filter parsing
    (no matching commit)
  - [iproute2-next,2/4] dpll: add client-side filtering for device show
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=4c4dfe5b4a38
  - [iproute2-next,3/4] dpll: add client-side filtering for pin show
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=0a0fe9c8390d
  - [iproute2-next,4/4] dpll: add pin filtering by parent-device and parent-pin
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=5d9d0ae4d7e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


