Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F4C30C144
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784640040; cv=none; b=D1CnUsjnsXP4vFvs7boVN2OA1NoX5tFnGO0SXImT/luz/UvyhyUMg20F1JdBbfGy1Z2ogbZPuQz2c64feT31ouaycD1Vk2YI+03HkRKt2rXcqpVXffrRhHCEi2Lx5H6vxfY6ZANbHUorUOL/sD/3eGstmv2yjlLkWiEqnExhypg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784640040; c=relaxed/simple;
	bh=telyvhsxZgH3kJd/7tS9veaJzbWRABa6C38tOiVp/kk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BMwJFpw5W0ksgtd0fsLGR+J3va2K5EyFCirGx+Ax2MrJ49ygp1zOmUgF59kTUSQx5U2NhDGWGNOJ98QOPoN3jB975CTw4D7njWrKgnrTefya/WU2zGF704gcINiIGIfZcm+VQBEpUmgEtXybdihP0DImrs4OmvtEmwJNIqwuxpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQdf/jm4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQdf/jm4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75E41F000E9;
	Tue, 21 Jul 2026 13:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784640038;
	bh=eyNq4JZWJyKQpnEEe9UgVMHmM3AtfPTqsy0xxEBYfaA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WQdf/jm4+/emceMU9HLVUuwJxTtyfmJvpXNIhRmKpu9EMINiiKzViZPFXAAjVUlTa
	 ZG4ho2ApW+r8OwP9kBV0U3+M1bYwKnjANvMA3sDD80zEg4fExBZ96u5sGdiXYZUyDl
	 +wjJFlITAAnPJ+PqLddCxG/ow0QrGelRbB/4lhPQcgSpMgMuEQ2/DylGL805o5zMH9
	 klnWyMK32m1bGpKF9Ghc6FpJvobwNZigXks6XjqBliC0YLa0G/Pvm7ST0LKv2NhbDv
	 ZYQTgqTgNPau5keKZBJ438n51s9TF9OARPfQcCQphVuzYLPtVUQLebCZW8kkbBOqL+
	 cUQFfNnyQoIWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09733924FDF;
	Tue, 21 Jul 2026 13:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] pds_core: reject component parameter in legacy
 firmware
 update
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178464000839.281806.4250842208013027704.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 13:20:08 +0000
References: <20260708163649.128620-1-nikhil.rao@amd.com>
In-Reply-To: <20260708163649.128620-1-nikhil.rao@amd.com>
To: Nikhil P. Rao <nikhil.rao@amd.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, brett.creeley@amd.com,
 eric.joyner@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 8 Jul 2026 16:36:49 +0000 you wrote:
> The legacy firmware update path does not support per-component updates.
> If a user specifies a component parameter with devlink flash, reject
> the request with -EOPNOTSUPP rather than silently ignoring the component
> parameter and flashing the entire firmware image.
> 
> Fixes: 49ce92fbee0b ("pds_core: add FW update feature to devlink")
> Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
> 
> [...]

Here is the summary with links:
  - [net] pds_core: reject component parameter in legacy firmware update
    https://git.kernel.org/netdev/net/c/7be2552e601c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


