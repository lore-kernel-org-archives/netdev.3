Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C276D341056
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770715809; cv=none; b=ETeAMuw1rj8jdVAFyORKybqwO+AeZx6/Hn5XXePWKtm59WD5sx6JgSTKQrmjE6fxDEiwTR3h9P3PMIeQ5uJbTNJN8eINjY8CylmEOOcLhpEPJvWShDOW42V3gZOIN06T+815C/cBMGMf62MVMOsGh4hpFzGSeLhCJd1fnaQAGtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770715809; c=relaxed/simple;
	bh=KBkiy9pU0Epkq3AqR1HhTW3h6QnIrae6vcw6VcFbCIM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dBuTeBZc3nR6IZgz5P8iTzDG+NTWA891xTzvMDgUIR+grDaHFAb5cZy46W5mrIB/Wv0969PI1AEbatypYt++5MlMEMLTZAzXRqKfb6QbnEpdQdVgH0J+q9dFiMYgb485CoCN26nwKfXcvUKPsVkPQZkhSmCvB59HA/YveeyHjSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kA0aLoLC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kA0aLoLC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58052C116C6;
	Tue, 10 Feb 2026 09:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770715809;
	bh=KBkiy9pU0Epkq3AqR1HhTW3h6QnIrae6vcw6VcFbCIM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kA0aLoLCxLS8NqatekPLEbaD2iMLLSvVJa2nviHr/YY1S7a+ecZigWOTwYJm7DfoP
	 CbLGO0kMis5PezlUhwOR3moUVdwRoQBKbSQO0OhLPSKwIcILVqDmTOrBunt7JJ6ofK
	 fOPKohUpSHVwLb7GDF9IpHuvTfXZAsv2ujoq5vgBYFMocimsw1fKxBE9D7TM2RGAPN
	 ifcfslcb5osu19b+XrwoFhQx3uE5sqRL+V0ZGrVAdurcy39UHAibaNl04ODQOxTZRP
	 EWRlzkUYlzbmUZLsKsXZ2R1la2v3th2e+th5BcCLK62wiyKmwdksm/CSSJFpTOOox2
	 LGMAJ7zfsfT7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0AFF0380AA5F;
	Tue, 10 Feb 2026 09:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: arcnet: com20020-pci: use module_pci_driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177071580483.3429746.3999061105039890779.git-patchwork-notify@kernel.org>
Date: Tue, 10 Feb 2026 09:30:04 +0000
References: <20260205070632.37516-1-enelsonmoore@gmail.com>
In-Reply-To: <20260205070632.37516-1-enelsonmoore@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, m.grzeschik@pengutronix.de, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  4 Feb 2026 23:06:31 -0800 you wrote:
> The only thing this driver's init/exit functions do is call
> pci_register/unregister_driver, and in the case of the init function,
> print an unnecessary message. Replace them with module_pci_driver to
> simplify the code.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: arcnet: com20020-pci: use module_pci_driver
    https://git.kernel.org/netdev/net-next/c/d82cb7b7ec42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


