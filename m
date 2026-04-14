Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68192BEC2B
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 11:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776166234; cv=none; b=jzy/HYC7Ff2PLUUPUxS8hl/2g9YT3Rod+ODzh6yOQg2XJIFwo0sxAtlzgCmTN3T+qkEDNZe+G2pMc/qfnkpvt6Fy6zxhOzFu3e2XtsiTmrSIa3PRKHKg5gjsCT7amr7Xl2N9lc1GgnQRVLMeRn523SpqNhSV0HE7bTw/8cT3dRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776166234; c=relaxed/simple;
	bh=zg4s04vAqRJZL8+qesCOOJgplmyTcitRv8aarkt+4nk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Nu8W5tDtwqUQ9j9WQaKlkM50XCOaizZw3hxRzr/Osj42/RvnOB0hEJbkbLPxd5FPincMaWXBJXhC3xm60pMNHOtAKZ7A9ZkF/vHtuu/UD5/YaKBJ5d0m34CXXya9I4dhnkyeu2kQYQnh089T0S6FDxltfrvVdjvJcGf6XXINFG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQkf7R1d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQkf7R1d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C78C19425;
	Tue, 14 Apr 2026 11:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776166234;
	bh=zg4s04vAqRJZL8+qesCOOJgplmyTcitRv8aarkt+4nk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RQkf7R1dukJztDefpKtvkQpWTNDpwSASezgyqmdsCbAPdUBHBOIUviyP/0gWM2Ke7
	 drPFBMo+s/mNEPeslcQI+0awQxCZ5dBCW5bTSgvJFInORI1vBKJAFoLMWDupmeVGhB
	 iT9GViFA+Elj7Vb3MAEmS+Y+CeQNDwqrwyrHOIl84+JRwDDrL4nxQ87tIHCOsUTekw
	 naCe/exyTVA6e9Oug8iG88t34pcZFvbopiiw+SM4do1me/9UlB98JGND3TaEX+MnfD
	 0lJTjQvVlSpJEsstXP8cmGPSXTJZjo/6INYTIUCoKFsJOm4HxTA2P7ZeJdnHeJrslm
	 qmxSXfTM0T1yw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC5D3808205;
	Tue, 14 Apr 2026 11:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] net: caif: clear client service pointer on
 teardown
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177616620505.837808.3249262246874581583.git-patchwork-notify@kernel.org>
Date: Tue, 14 Apr 2026 11:30:05 +0000
References: 
 <9f3d37847c0037568aae698ca23cd47c6691acb0.1775897577.git.zcliangcn@gmail.com>
In-Reply-To: 
 <9f3d37847c0037568aae698ca23cd47c6691acb0.1775897577.git.zcliangcn@gmail.com>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 sjur.brandeland@stericsson.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
 yuantan098@gmail.com, bird@lzu.edu.cn, enjou1224z@gmail.com,
 zcliangcn@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 11 Apr 2026 23:10:26 +0800 you wrote:
> From: Zhengchuan Liang <zcliangcn@gmail.com>
> 
> `caif_connect()` can tear down an existing client after remote shutdown by
> calling `caif_disconnect_client()` followed by `caif_free_client()`.
> `caif_free_client()` releases the service layer referenced by
> `adap_layer->dn`, but leaves that pointer stale.
> 
> [...]

Here is the summary with links:
  - [net,1/1] net: caif: clear client service pointer on teardown
    https://git.kernel.org/netdev/net/c/f7cf8ece8cee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


