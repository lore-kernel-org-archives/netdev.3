Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8312528FD;
	Sat, 28 Feb 2026 01:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772242804; cv=none; b=ZR4GZzauWdhWX4u2/VQbNIzzwtx5mDtipif5aCgSnLWBH8hsZN9qY+ZweXCihkb600fLRYyEXPJKe0bdqzZkSjPGtqPg5YtQTGEiFpkhwIkxhHJ/oxOGuPWqkXA46/OqeLsa6HTw/SauPw56MRzrzYPS6aeoNAS2yn486L0pH2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772242804; c=relaxed/simple;
	bh=nIWEl4xTIzPO5EKLkqXZCOF7fLKLe75IsO4ppkTLvzk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F8/c6lEFez/b6SvIC4DGQ+X7+5CB4SBnIsM5pCd/6PGfBtNHKM3RdXdorL1LaRy3mCksvd2bum2Es2cV4/voFChF1EdF3vdN8TfzsIwWsXGFdDq+Kgmln0k5Ik4lBlX4cYoSWVkNzPgc5b3lDK7TbW3D7wkYu4uoHt6bQQC6IJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlqAQqvj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlqAQqvj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761D3C116C6;
	Sat, 28 Feb 2026 01:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772242804;
	bh=nIWEl4xTIzPO5EKLkqXZCOF7fLKLe75IsO4ppkTLvzk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MlqAQqvjOgXJtg+ghhS/4Z2vbmfAGmfRnCBoYqJISZI6HCAY0tJ1V+jLeYHjCgwiN
	 mUi9nbFN4jO1uchAy0W0lpyk4ShYJcCu/zTF8OOUk/6o3I5OESIAjj2wwq3kFHuzOK
	 LAPPRBjYS9zLPdwFDViMxOXvr4QQF8u3yc12GsF2s/0WMZ6RXN/IUojqSpulUfiwl2
	 K8zXYliuVZHU9M4CQY1wR8qWGc21cc6RI0JDobpbijzA1CzXOLCg7TMYzqgWPKrIrA
	 PC3eqMAuS8cx6YmdgptrZ9zYy02A1PApOUrryhYYy/+Tp144bH72t9SRoz8Ym+sb0/
	 vUyaS3WeyQKVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3AFDD39EF96A;
	Sat, 28 Feb 2026 01:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net/hsr: update outdated comments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177224280793.2834458.8244905103695838011.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 01:40:07 +0000
References: <20260225145159.2953-1-kexinsun@smail.nju.edu.cn>
In-Reply-To: <20260225145159.2953-1-kexinsun@smail.nju.edu.cn>
To: Kexin Sun <kexinsun@smail.nju.edu.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, julia.lawall@inria.fr, xutong.ma@inria.fr,
 yunbolyu@smu.edu.sg, ratnadiraw@smu.edu.sg

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Feb 2026 22:51:59 +0800 you wrote:
> The function hsr_rcv() was renamed hsr_handle_frame() and moved to
> net/hsr/hsr_slave.c by commit 81ba6afd6e64 ("net/hsr: Switch from
> dev_add_pack() to netdev_rx_handler_register()").
> 
> Update all remaining references in the comments accordingly.
> 
> Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net/hsr: update outdated comments
    https://git.kernel.org/netdev/net-next/c/b99ccb37eda8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


