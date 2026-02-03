Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4DE2F0C5B
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 02:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770084008; cv=none; b=MLX3tW3FQnic39DkgpZEEFlgOAQK8MG4vrLyAAuiigjEtETv2RqU31CKfo6b2e7c9R2J1bCxZ76TN57E4RHRGDSnTbbT/ZOLgv2q/rLZhkzKoDh2mdefgRKJSvK0tGk+wvlbwIjmqxocTj2TdxdO93fPkOVCV1us8N53tzrCxKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770084008; c=relaxed/simple;
	bh=VBBbJLbfXcu0yzjWHWMplaUuI1eF0C1P+i6/P4m3seo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YLO8Id5/KQ++ozFs/ECzoKH9twW8Yx4834bflJJDFNmHuYg7YKuOeVn07Lp1kToNo7dtuShT1T69a/fU1iPvs3tH8aiq0moiicscasJHZJPRZCVpJ/7hDpeErwcgg79lC0yebJjj1Qy92q3/9OFmzMAvlbmvqZUGEqB8y7zjSOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJssIDU2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJssIDU2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA90C116C6;
	Tue,  3 Feb 2026 02:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770084007;
	bh=VBBbJLbfXcu0yzjWHWMplaUuI1eF0C1P+i6/P4m3seo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pJssIDU2IeUaFK4lBIe+WxIA3WdAYPDIRz73M0z8jbhUzbgsmghBF2VnMiYD/Cyi4
	 zdDTE3eHxH5pEGLMyjeak7U18R+M+RW0DEC1Ewu22zRRhNdlq6INMQshc1H/kT5sTc
	 eTrW4hHsPbt3sZn5RbPCewj386YGd0UKMklhUmaNxrzwbHD7FVyIDAYW8r0lu4lTro
	 hP9nICGYf7bzsy0QdAbalBZHl5YZEgqnuEphGFH7edmUgripsQLZcnsBpceBpPPj8z
	 MXDLg88Hp5f9fYIPXzOJAMZIic52qss7FKtqSH4ZhRwyf9wvJwg8c5bthaMx5cX0Jw
	 ZY0za7JQjCB7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id CDF683808200;
	Tue,  3 Feb 2026 02:00:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND] tipc: use kfree_sensitive() for session key
 material
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177008400463.1271965.16783467877403840640.git-patchwork-notify@kernel.org>
Date: Tue, 03 Feb 2026 02:00:04 +0000
References: <20260131180114.2121438-1-hodgesd@meta.com>
In-Reply-To: <20260131180114.2121438-1-hodgesd@meta.com>
To: Daniel Hodges <hodgesd@meta.com>
Cc: jmaloy@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 tuong.t.lien@dektech.com.au, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 31 Jan 2026 10:01:14 -0800 you wrote:
> The rx->skey field contains a struct tipc_aead_key with GCM-AES
> encryption keys used for TIPC cluster communication. Using plain
> kfree() leaves this sensitive key material in freed memory pages
> where it could potentially be recovered.
> 
> Switch to kfree_sensitive() to ensure the key material is zeroed
> before the memory is freed.
> 
> [...]

Here is the summary with links:
  - [RESEND] tipc: use kfree_sensitive() for session key material
    https://git.kernel.org/netdev/net/c/74d9391e8849

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


