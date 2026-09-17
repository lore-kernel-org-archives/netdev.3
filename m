Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B2C5111B0
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 13:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789650093; cv=none; b=MlQIwRTW0f9hs5WHXVrCTwwl2LmmtLioaT+m+SYha8j2RdsIauoOTIWlCNiZcSbQWxNSwwBnQfs3B6e/xYe5K1YG+cG5LKdGNEQygf1hutwzkpaYi0gDlHaRZiFi0UEDMFERRf/vJJ1v1R9ViWo/Xwfgnxe6DpjovBk/NpsY7dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789650093; c=relaxed/simple;
	bh=u9ui+S/yspm4mSksIa/Ma37AYdYvk8UNZqBkcWyUvmc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VKcT5IONuWVTw5JP3QXssYGzuT8TXZ7AueDIOgooKOIfXEAu5UJTntp8x7U4kmvrzZZDFqra6R/b19hBV5+/LYUV5pBRdZ02Vw+InjghWXAnSGQe6Xk3qFDR8fCeK0flcBu2TQTZ+7cMVAYX39TS68eY9AIq3q7CZnRM4niZJs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJ7slrUo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJ7slrUo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D441F000FF;
	Thu, 17 Sep 2026 13:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789650071;
	bh=RHTObpu2Kg/i2kid2eL+FNirvr/8Hj3PqA1t8QEDqKs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bJ7slrUoBdH6l6D1Yk0YUJmlreLfgXnq2R1G4K/017iz0nVOz4Sb8YmCMsgAiWzY0
	 8PjjzmTekrOwYyWxGHimg3iLzAu64CLGFURKh6lFDSUCl988U9uq75E/f6m0p0Wr3y
	 cwEZ+RHCkDlgBE0CJsL0gz63cWC+a/mYjHz0t67biG8EZ31In2gZw4c3LYrf+Y/R0E
	 QbJkhB0UjKtCoK4fesRN8DHMsTznKftQlbHIoIl/7JX1jNBJCS7T21/+CmapB9GxLU
	 m6F3OyS3Rx7cKbQerSidLdydalW3TjAMpr+y2j8Wf7UGJhRo8TenI9ah1GLq1M0Vfs
	 TyHhdjxwuAf+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D093438111DD;
	Thu, 17 Sep 2026 13:00:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] dpll: reject a reference sync pin which is not on the
 pin's dpll
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178965000438.3631422.9846681217780704336.git-patchwork-notify@kernel.org>
Date: Thu, 17 Sep 2026 13:00:04 +0000
References: <20260915213047.1352286-1-kuba@kernel.org>
In-Reply-To: <20260915213047.1352286-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 ivecera@redhat.com, milena.olech@intel.com, przemyslaw.kitszel@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 15 Sep 2026 14:30:47 -0700 you wrote:
> dpll_pin_ref_sync_state_set() resolves the partner's driver private data
> with dpll_pin_on_dpll_priv() and passes the result to ref_sync_get() and
> ref_sync_set() without looking at it. The helper returns NULL when the
> partner holds no ref on that dpll. Of the two drivers implementing the
> feature only zl3073x dereferences the pointer (sync_pin->id); ice ignores
> it, so ice cannot fault here.
> 
> [...]

Here is the summary with links:
  - [net] dpll: reject a reference sync pin which is not on the pin's dpll
    https://git.kernel.org/netdev/net/c/d798162eb364

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


