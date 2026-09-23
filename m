Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565A13A71A8;
	Wed, 23 Sep 2026 23:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790207481; cv=none; b=dyAIsw8HKdqgtLVLItxpcBO52I2tf7kScb554q0FJuTQ5XVbSLKVFcCO2WwBWnFY0PNmFRge3flF6QqJlnq8w0S9jxrQ7HteXZNJRlDQTyc60taSY2m9vyIBvgOWUu90cNEiP+88zbudBTMA4i9YYaTfd31nN99pKxvkVUwIwk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790207481; c=relaxed/simple;
	bh=1e9LQbt+X6yyOphfcnXgsEW45Y592U08huJX51Uzf3M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W3mgmelwnXFSQgzIR+P4mnlAZ6RUwhz3wJHmoQ7qunWHtBfbe4gT5e5yrPhFBPF0aJjElqKOEXlQEX1QlzV2v9OHP1S21eqmWoXqGddx+n9JkA0bYHNrDdU3oVwk0vljoYjYBilHdSvqL4W46R8Q6pMles+JdB2aC4nivYrvPA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E13OI+yG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E13OI+yG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E706D1F00893;
	Wed, 23 Sep 2026 23:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790207480;
	bh=mbCwRTgn9fV8AwDIlQlyn3JYMSLiwU3wb3k1ZoQIaaA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=E13OI+yGGfCKHoId8Otw2313St8xQBfbw6db25z0B1FvOLn7BUYOuTs7ubULB+oi3
	 tc2A1pHHWdJKo3ATDSv7a8wuogmIZMMgRNPhPfIVFVws/nn2JjdTYt6ThrLylbqYUi
	 Ndp8fJEdfbp7ui+8fYcpLBpalhYGVejMJCC8ZNnfN8gKa3gRLxcVzU4WCDXnbn3pzK
	 u7MWDW2Xgczxxl9t73hk2gJoQrAGzryyLYc6Rzp1zc0u3ZAJMaVptxtiZWpvOMBhhP
	 TtFzOD4uDC/dXwPcqUm7I7GTD4xwrjbKsN8qwmPEsiEPIgBIiGVkZMcucTkHL4ZJmO
	 wIEtRXqQh1csA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D092E39E9602;
	Wed, 23 Sep 2026 23:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ppp_synctty: remove redundant skb null check in
 ppp_sync_txmunge()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179020740939.999807.4999315153340387066.git-patchwork-notify@kernel.org>
Date: Wed, 23 Sep 2026 23:50:09 +0000
References: <20260920114945.2517-1-qingfang.deng@linux.dev>
In-Reply-To: <20260920114945.2517-1-qingfang.deng@linux.dev>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jirislaby@kernel.org,
 elfring@users.sourceforge.net, kees@kernel.org, linux-ppp@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, lkp@intel.com,
 error27@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 20 Sep 2026 19:49:43 +0800 you wrote:
> The skb is already dereferenced before the check. In addition, a TX skb
> passed from the generic layer can never be null.
> 
> Remove the redundant null check.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202609132245.txZXoUxc-lkp@intel.com/
> Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
> 
> [...]

Here is the summary with links:
  - [net] ppp_synctty: remove redundant skb null check in ppp_sync_txmunge()
    https://git.kernel.org/netdev/net-next/c/1196e46f6d42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


