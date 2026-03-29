Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0DD387359
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 18:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774810238; cv=none; b=PJrEaOQ4r2gFfKl6PdVUZJGxJPvrFDCTr6nkV6jJfe3p1CM5XdoDQMXPwUBSyM84uZVTiAYbyto+qn17jfqKb6R6J0zfXU5LnPURIJAA/RV5t5PVwDZ0FQMOJ11O8NGWB4xapBazDpl4rDyr8uZIh3GoTxJhBSdoy2wC9qx4DtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774810238; c=relaxed/simple;
	bh=uf7fQYd6S94+mu2FJETe1blUtKMVigAFbG9w7BpdWkE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NK6NCtcW9oikdlBza2axXT4mVzm+HPl5AKVdz+I9kc8f3RQH5EVzTFXVxYqP8yUvV/M1TZlKEgsU+vjyESAX1MxdZl4tdHGfnSHll6V6aaGvKwKCo6Qqdz3YQg6GDzb/UTtxj0wlcc1aThcf5YyaHpNgMFut8TZvcilGkTO7qak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TW+Kz/a1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TW+Kz/a1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D719BC116C6;
	Sun, 29 Mar 2026 18:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774810237;
	bh=uf7fQYd6S94+mu2FJETe1blUtKMVigAFbG9w7BpdWkE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TW+Kz/a1xbX3YP1w6WgB3vwuFmXaOtCFVMDbBXIW4MNqPOcpic9EAP0SUEENELuwX
	 +U0vF7cU4g9P6evAtV2UrDbdYKmddN+srRCerkPAk4Ds/YXWB1ueNsmaqUiaoWFZ6Z
	 5E+m49PqXHR/9Lxv/xl3JgkiKN+K+2CAQHRAnZo+jH4LF7WaEVOcX3j9Mbk8t5n4cd
	 RpCQ+jvkWNsRBEjqY1pdmZqTap9JkASlGMxRxbnkwJAWkV7GKI7z1G2uuoa/byV2ie
	 huwAnnwo832Bp3PgdGjcnT6oterSmap/lvWQvlZNQdc24yKj6L+z2dboxmX5FKTNaj
	 F4NyINCYrpwag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F673930012;
	Sun, 29 Mar 2026 18:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] tcp: use __jhash_final() in inet6_ehashfn()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177481022229.437043.148222339772066023.git-patchwork-notify@kernel.org>
Date: Sun, 29 Mar 2026 18:50:22 +0000
References: <20260327040646.3849503-1-edumazet@google.com>
In-Reply-To: <20260327040646.3849503-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Mar 2026 04:06:46 +0000 you wrote:
> I misread jhash2() implementation.
> 
> Last round should use __jhash_final() instead of __jhash_mix().
> 
> Using __jhash_mix() here leaves entropy distributed across a, b, and c,
> which might lead to incomplete diffusion of the faddr and fport bits
> into the bucket index. Replacing this last __jhash_mix() with
> __jhash_final() provides the correct avalanche properties
> for the returned value in c.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] tcp: use __jhash_final() in inet6_ehashfn()
    https://git.kernel.org/netdev/net-next/c/02d0e59e36e0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


