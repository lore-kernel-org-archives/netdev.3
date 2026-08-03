Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A66D23BD02;
	Mon,  3 Aug 2026 23:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785799848; cv=none; b=saZ2DrPPHra/FOLN7OLoBvu/PgBUXh98UOUOdLy+RRIGiFC2m/JOfFg4UeswEOVY97oVO6N1M86oFrym3HrYC5qwF2zgx25XH9wXBZP7jAHAcaaX2EzuVKN3tBNjr0baaBi7ug/rXDnectjCcH//jy43SmRnNEyXM0q6BqEpSoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785799848; c=relaxed/simple;
	bh=bjyBdecz9YdVVRbRQTp1D6nCji1NVDhda3j6k5f7YXo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TGWyuwHgtGE/waOOT0fJfDUTkcgX9iPZR2ypyPXYevq4lq4GA4sPw+i+hxxG8qUoZ/dFrG2l8bQXP3JbdZn6jO1uCA3YvZj1nJQ6GPuyONT4c7AAajuZUvkfT3D67LupHg9Shn0WqHSQTzwS4claVia8wjGy+6vCPcDGiLa9k44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2bqVx5v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2bqVx5v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A421F000E9;
	Mon,  3 Aug 2026 23:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785799846;
	bh=nWC4AZQ4y8BuIFWDhXe3fayvRK4+C/tdrgkOogiwCHs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=W2bqVx5v5rzBGeViSUAn+Uau1/3k16P81PEk3tiBcTROuATl53k85Xrjijg15x+fR
	 cVFyslonD8Dad6G/EbIAlUXkezC4CYz1Of4SLEu3j3bqDGMZDjYh6h1uLnixbKghLG
	 wWveUo8WigAkReVtOFmb2t4L9e0ebmQ645Cwkc4wrLQGaWO968X8WEPsFGoen3EjqL
	 dFDv5FMXxNXV4Mg0NA16UVOVqICwp0lVj8fa2ReHnm0hmlWCbOfZxV4iG//tktCJK8
	 lZVdHDr+4UTDRx2+uROsVUwthldatYvrkq0JBAtHqBRRo3o5vD6icxx7nhJ7lxFYl3
	 WnIslKdJMwhWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A3A3924467;
	Mon,  3 Aug 2026 23:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ppp: use netdev_from_priv()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178579980765.2876283.456166789581333707.git-patchwork-notify@kernel.org>
Date: Mon, 03 Aug 2026 23:30:07 +0000
References: <20260730100654.745-1-qingfang.deng@linux.dev>
In-Reply-To: <20260730100654.745-1-qingfang.deng@linux.dev>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, leitao@debian.org, hataegu0826@gmail.com,
 kees@kernel.org, linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Jul 2026 18:06:51 +0800 you wrote:
> Use the new netdev_from_priv() helper to access the net device from
> struct ppp.
> 
> Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
> ---
>  drivers/net/ppp/ppp_generic.c | 137 ++++++++++++++++++----------------
>  1 file changed, 72 insertions(+), 65 deletions(-)

Here is the summary with links:
  - [net-next] ppp: use netdev_from_priv()
    https://git.kernel.org/netdev/net-next/c/5aed8f404401

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


