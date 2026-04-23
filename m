Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5CE175A92;
	Thu, 23 Apr 2026 18:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776970252; cv=none; b=V0ICbC8K8G0BqbOqQiD/pE1nj+L8lq7/f4uhSWjE8OzlP0OUlZIctZHrhRq8dWkVTxBVpZHqqNXODiUkV5PSD/oNgtbzu/AZvUxpcNCIFSgg1yf6vBHUoqmIdcXd4QPbOKDeThvn4/p6xjUFG9jF0aXNyTX5KGJsTEVytm4C1E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776970252; c=relaxed/simple;
	bh=lr+4ASAZXyjQBVVm6bEjar/JZr31IsKklUwmRWHeGao=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kCAnSum6H+CsJN8O+0ytJ1YCzzKbrBTdimd0F+VPYwvVzRFPm+EQXWzZQ1MC5IyoKbxGd8E8IjFcrdreLmEwzRXmgf55ULr1VUPudRvA2yx5Kqegh7iAlbZYaAlgz5KoEBpfUC9jYP4IRzgWkGMG3axMHiT7ZPuSRawB0pzB9hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zg2V2m/D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zg2V2m/D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324BEC2BCAF;
	Thu, 23 Apr 2026 18:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776970252;
	bh=lr+4ASAZXyjQBVVm6bEjar/JZr31IsKklUwmRWHeGao=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Zg2V2m/DtoU7LdFsOwWYt5/RNag44GgcPLTi3UBYMqaWLqw2+OwAAS+MbUgadZJCU
	 QT9n7fAxDNWqCjy4Nhxkz6EOzk+gzm+BTlHBpOMkjdXmcikrvTwW/znVu/aMCdxFC2
	 19v3NKSEdDLhSheXKhyIU6VfZoVfsd4fnKh6AbpgsTyY9qSydh8MrFulqCzNfJI0Cd
	 JPUKGlJGIgVQjq/BdwiQjvFmc0G1lo0VyyeT4GwsrSKvwnu7YlRESsiu+HfWtcVxNE
	 WRDbTPx3mr2tJgNTrxL5qDKRElgxkoGwJEDytpnq6LTT+6HZS83wDGmfWQOLpWBtnT
	 FhxklQHX/934Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E5A3809A90;
	Thu, 23 Apr 2026 18:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] llc: Return -EINPROGRESS from llc_ui_connect()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177697021334.714464.11524632965300891660.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 18:50:13 +0000
References: <20260421060304.285419-1-ernestas.k@iconn-networks.com>
In-Reply-To: <20260421060304.285419-1-ernestas.k@iconn-networks.com>
To: Ernestas Kulik <ernestas.k@iconn-networks.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Apr 2026 09:02:26 +0300 you wrote:
> Given a zero sk_sndtimeo, llc_ui_connect() skips waiting for state
> change and returns 0, confusing userspace applications that will assume
> the socket is connected, making e.g. getpeername() calls error out.
> 
> More specifically, the issue was discovered in libcoap, where
> newly-added AF_LLC socket support was behaving differently from AF_INET
> connections due to EINPROGRESS handling being skipped.
> 
> [...]

Here is the summary with links:
  - [v3] llc: Return -EINPROGRESS from llc_ui_connect()
    https://git.kernel.org/netdev/net/c/864ba40c80ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


