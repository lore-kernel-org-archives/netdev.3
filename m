Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF88256C8B;
	Tue,  8 Sep 2026 01:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788829272; cv=none; b=erwXSd21EOFhfDIzuMI7XHhupC3iPWI4b8FNYxfGAy1rXYMr4jAtq79jw2W59CIBAGoGQrNVGdzvtW7iBc6BGcyQFZr1ajUy4s4N54D+35l3IcIf907Nyhm0Tx9iXveM0gpheHE+NNmSPC7LLS74jO5uPJRkjj/SVY6fa/Nbaus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788829272; c=relaxed/simple;
	bh=cgPPvtLaFibXx89VnRzZlIw34kcLOvCxqeYrB6L2xBE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dn/zVXFz/xN+RnhLh1NQCLx66EDFmtE4E0qcVhhI/OPDQdp31D2HWSv1XXl9MC45sBE3ONILvvCV7ydkCvKfjFhJxhgEXX097VfrBPPlGcfO/4b7YoTk7QrtZd/OlzbgU9+eEL5O5SxyJQqdN9795KX30hgyWmL/Qh7WWvaYUBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WN4HxH1A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WN4HxH1A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B63B1F00A3D;
	Tue,  8 Sep 2026 01:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788829271;
	bh=yCTva4xy8bthFe1zmKrYZgfNdANDWNxTPzCeVhN3udI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WN4HxH1AOaK7YK1di6kppedCsO2opg9/Qf9j3wfZBAvvWDH1fpQ3RbleuVLZiD33+
	 zNq2e03dP7OFGG9yPkt7LTg1obbe20Oi7998eBBbZDS6iatmQG0hHt+frdBLSvRQQ5
	 9BtVbaUIaL1b6xQfOe9LV2vla94LO77mZNP39t5esRgBKJ/3RupBx+Yb4rPZ/+kG8Z
	 SKBjDogvv4IjQ3PiAHQzt/1fQ1QSFNwHnZtX3y8o95Xo/kbMuHfP5fFWZ5bSpkXHmz
	 cezALnY6hYf36BB0l6dMohA9WhBj2GZHP4gUh6d64XBTUrvi50Klap/aWtiUycxUIg
	 pf/gA/HaIlwnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568F739E8A5D;
	Tue,  8 Sep 2026 01:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ipv6: fix typos in comments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178882920989.3227186.13681260759119540186.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 01:00:09 +0000
References: <20260904122157.29281-1-hemanth.selam@gmail.com>
In-Reply-To: <20260904122157.29281-1-hemanth.selam@gmail.com>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  4 Sep 2026 17:51:56 +0530 you wrote:
> Fix typos in comments, reported by scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Only touches comments, no code
> changes.
> 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> 
> [...]

Here is the summary with links:
  - net: ipv6: fix typos in comments
    https://git.kernel.org/netdev/net-next/c/39fdc543a05b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


