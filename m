Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923E51DA62E
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 01:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786584656; cv=none; b=AIzcBa3zlMXB6QcWK/xMnPnRLjasngkhbDOWbesScRLSrbQA2JC11mKTQpJ71W4Qcr80UQQXAnYFrlTSiZihpnI9z6SPyYQrHySMCt028VptQQezxtfhK8MZE9hZJcL7DQ6nxybJm9zF/5Cxhn9mnz+xGsYFbo5I478gjXwHfDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786584656; c=relaxed/simple;
	bh=exzGR7x1mFL4w9WrVvk3/DgWngw5Qtiz95m2+m3uu9A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hxoIhuJv2ZdNd5SN8rQ1zNYcJVLzpGBF3SQdC9aBc5/N3XfGykJSieLAM/4yA9X8RoHHL+J70Q3RpEx72Y4eo698UbESRDeJo10cHTuRU4lDbTtOw2dGdkBQ+cEoMqdrNo0L3Cfpye6J9RJLnfv6ddjqimxCDNT9RP6z6FPZSIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wb62EH3O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wb62EH3O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3862E1F000E9;
	Thu, 13 Aug 2026 01:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786584655;
	bh=ypxf94rVCDRcLC/lxsWKaOLKeILtO8GicodI3cXhQpM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Wb62EH3O0zlqw8QzSo6v1hKhtCJJ/OO5pye9rS45sa22X6I0I5N7DQ7s6N3SM1Pxe
	 7qDBsarzp0bnX3Wcd8HmB81/RHwyjWn0dZCtHaH7Bjew/KrPqduk7R3TRDxF+A2TU5
	 jCyreCJhjz7iQJ3y9Sd7y+iwG8Y1E5sUKXGSo4rKLH17Jmpl2GFF30hNYYbdSnyn0s
	 1KqqNEXpvLHxOEGt/W/721G4A18g18591wome4HCdfTLyVpibqscU7m9BwimTfocyp
	 lqTXIuQb0KMNjx3zsoerFWOPkaTeI5Pk2IQGOmsgy1GHXRw8hB1WWNVJiIFZHz1MFw
	 +xheGUEgfArcw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B8A380CED0;
	Thu, 13 Aug 2026 01:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/4] ovpn: fix NULL dereference when killing missing
 key
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178658461014.2179614.121337701902340719.git-patchwork-notify@kernel.org>
Date: Thu, 13 Aug 2026 01:30:10 +0000
References: <20260809212142.2249027-2-antonio@openvpn.net>
In-Reply-To: <20260809212142.2249027-2-antonio@openvpn.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, ralf@mandelbit.com, sd@queasysnail.net,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com

Hello:

This series was applied to netdev/net.git (main)
by Antonio Quartulli <antonio@openvpn.net>:

On Sun,  9 Aug 2026 23:21:26 +0200 you wrote:
> From: Ralf Lici <ralf@mandelbit.com>
> 
> ovpn_crypto_kill_key assumes both crypto slots are populated and
> dereferences each slot before checking it. That is not guaranteed: a
> peer can have only one installed key, and the kill path may be asked to
> remove a key that is not present.
> 
> [...]

Here is the summary with links:
  - [net,1/4] ovpn: fix NULL dereference when killing missing key
    https://git.kernel.org/netdev/net/c/41d44ac7a61e
  - [net,2/4] ovpn: finish crypto callback cleanup before peer release
    https://git.kernel.org/netdev/net/c/9e163917a86c
  - [net,3/4] ovpn: run deferred work on a module-owned workqueue
    https://git.kernel.org/netdev/net/c/e9714db80417
  - [net,4/4] ovpn: defer key slot crypto freeing to workqueue
    https://git.kernel.org/netdev/net/c/2da3dfa1ddfe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


