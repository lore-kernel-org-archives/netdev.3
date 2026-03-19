Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C7922AE65;
	Thu, 19 Mar 2026 00:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773881066; cv=none; b=qY5HrJ/aAOAFZeUmtFelrNUaJBVNyhHPlOiMysGr9Sl98LkA9ktDuoEAfK8wcKKKEi5Qjcj4ixe/53v23bBTJk86L5llry+XNo9tj+OodfBbiENpn8GWUYqJlvkBWu7dcw46GYh/5lD1e3MxalZSFh5sQU62LS3VCplMFNwBs9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773881066; c=relaxed/simple;
	bh=aCZdEo1KP2twXzLQmcGuFv5gVDmLw9VFA7BFLI9HnkQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PGT0vRc2HvOAljg/JQd8QOCuEFK7ZL1PikBuCEli9w/N9ZFrgHn7fNTKjcn5Rtjl57LDXQjfaYq4Q3STIyzRYzCCA9SIn0aInOpnB6q8xnSwD7vN7+mAzEkeSthz71BR7J/qhBsfU/SGAsLH5PEdrj1QZY/i7zJMpVMaL8KbK4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+Lx4o89; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+Lx4o89"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8071C19421;
	Thu, 19 Mar 2026 00:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773881065;
	bh=aCZdEo1KP2twXzLQmcGuFv5gVDmLw9VFA7BFLI9HnkQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B+Lx4o89GO0OCRRp6zoH7KfspyzyoBneD9gW50Pb0Aa8j6py6gKWUkI5hsXIiRB4f
	 wcd0f9R8FcORieji7oTinoMIB8+lIsBPaQeNjVKoUlxVU5q2RmQlFhd01n33nprV0X
	 apZmMgPHSTiXkKoCUpmOcsf1si2DaBo1PquXfzxFqwLHQTEqPT9YIqoLYwnI4l+daI
	 j8O8tu6Of3jc5ChmCvXLuCbNv+kHXTskAyIYH/10jSxbl/9AdLNwdeGCuUI9XxhcT8
	 u1Rc8+W70ic9Gs5YfDcVvDgNTgdXuvuL2lQPmOwmTfh7w/WvDk/2JQCaISFFG/HPYH
	 gtl+IBJuRHh+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D0163808200;
	Thu, 19 Mar 2026 00:44:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] ipv6: add NULL checks for idev in SRv6 paths
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177388105728.935482.13380611320476992951.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 00:44:17 +0000
References: <20260316073301.106643-1-heminhong@kylinos.cn>
In-Reply-To: <20260316073301.106643-1-heminhong@kylinos.cn>
To: Minhong He <heminhong@kylinos.cn>
Cc: horms@kernel.org, andrea.mayer@uniroma2.it, davem@davemloft.net,
 david.lebrun@uclouvain.be, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Mar 2026 15:33:01 +0800 you wrote:
> __in6_dev_get() can return NULL when the device has no IPv6 configuration
> (e.g. MTU < IPV6_MIN_MTU or after NETDEV_UNREGISTER).
> 
> Add NULL checks for idev returned by __in6_dev_get() in both
> seg6_hmac_validate_skb() and ipv6_srh_rcv() to prevent potential NULL
> pointer dereferences.
> 
> [...]

Here is the summary with links:
  - [net,v3] ipv6: add NULL checks for idev in SRv6 paths
    https://git.kernel.org/netdev/net/c/064137935262

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


