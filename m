Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355211;
	b=pZBisLOGeIp+kj5ICZA26hHd1MZ/oqbgZBHkoUSjObebqKvvBYLJvy9zdsVTtcyrfi+e
	 iZ0iZwqMc1dVOPwHCnIdX/N3sAVSO7m3DHGafM8seZ3HNMD/Uklp2q+feGBluCI2iZXln
	 VftrAGfXYWjolskTZ0egkt30gvR33h2tLnQ/gvW+pRFoKFIRYDrp1olBEQj/3ycEYDd6h
	 zXOy2SL0Cdbu37kSu8IzJB0F14pEpHeJn4azs+t50KjYmiZyLxWkCLoFUo02Tg+ukJvrI
	 WpoUqhCCDUR9Mybu8lkyCkZf9Od3klXjTYEWVqQn1cfgxEcjC3Oxa4rvFsGEvXjCL3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355211;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=D93dTymtfvTjKhWorCFW+iO0oajya8EsjncYpv4pr9Y=;
	b=GG3FD85kP3TJlvKsKcGMbe11FdGlNG04BGFHngV5ZTNkzT6Fd4fNQ8ElibDx6lz9RaOw
	 6Etn1G8o8lLWDl81S/BJ35f5LCipauf1rvTtQXbbn1jqKKN6B/+ja2+0iGI44WrVlV59B
	 BvOauBnQiUUG79xCNt/mrhGfIjDiCG2tFGn6nN5fz5t/FLj0+OC8ssu/eWaVuol6j1/7j
	 ppnEHSoFtOv3HFixLeYNUE+b37VyjHcAzvmRZt18xHlp1Q+1wadyrS3syplxylWIiekTa
	 0RqFe1VKCjLj4nXGaBsDAy238vqA66rBvobmteDR7Mm79KIGCcYEg2iKiU2K9yEfQ6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IwEIMlIC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3407B606A327
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 00:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IwEIMlIC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54111F0093D;
	Wed, 11 Nov 2026 00:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794355210;
	bh=D93dTymtfvTjKhWorCFW+iO0oajya8EsjncYpv4pr9Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IwEIMlICj1sUmbCnCbZxa6HiYQaQ8QjO0E1k+dujBZcuXURUPmWihKQFOOf6Edrbh
	 BZHvkzADQ7kXLIDl4LonQsK7wbKvjYURdOvtcZWrOXXEqAI5TbBt3PTdxtTeqOUOw3
	 9Bmm9BRApbo2fJA7NwatYAIt1EBbHRJ+PVsCSEqg8c+CRLitzNQquCpSxWM84t7G0g
	 bwzytxrJUtr1UC000jOcBktgJSs/vlo0lqEWMM6oL8LkDS8RMQcqb07RTQ26vC4+Ip
	 IFGitXlhEvoCX+UGYUFbdjCX8WqpTj/4CUA+xOQ61NbZhJGU9YQxSl8sGHX1VFEhBj
	 4ek9FQ0idQy3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B16039E8A4C;
	Wed, 11 Nov 2026 00:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: Add the new IPsec list and patchwork
 instance
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179435520942.125436.12467186696022258506.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 00:00:09 +0000
References: <avGC7CrPVgMrBBtq@gauss4>
In-Reply-To: <avGC7CrPVgMrBBtq@gauss4>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 9 Nov 2026 09:23:08 +0100 you wrote:
> We now have a dedicated mailing list and patchwork instance for
> IPsec. Patches for the ipsec and ipsec-next tree should be
> submitted to netdev@vger.kernel.org and ipsec@lists.linux.dev,
> so that the new IPsec patchwork instance can track it.
> 
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: Add the new IPsec list and patchwork instance
    https://git.kernel.org/netdev/net/c/d2809ccf3cfc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


