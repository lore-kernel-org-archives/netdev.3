Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AAE33E348;
	Thu, 21 May 2026 02:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779329428; cv=none; b=iWRm3SyMfVEghh7S52Kgi9l2bN+MHRwlOHFNCGif9JuVcbq+Xa4Pe6eGaeFaCdWUgmBHd9vf2muS5qGNd5elwb6+M3HcXitBRS1S5N7NRdS8lgcm5e2nSJsmCY0R6fuNfXioPM7FZ+UuIaX09iP7+tFsyQ5sQH/FvJ4JRKVvIrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779329428; c=relaxed/simple;
	bh=JYWVZKsWEu4AOqw93qSduiZntYIYTahCBAm+Uk88Vsw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DUHgUW10VCBOQAUN+SEHFyIZGDfMG427lWuUoqUbPhLnrNNM1RPePMTCpBYEf+Bzjp8Uf8EkChNrXpUWI61aDvwu4ZGsyxXITlNgt4xcTSFQ7Ry/Ezjx9jENlo2l2JknbLExXO7JeOSWYStJEXkljqrHTD+uNEDmXBMSzCq7+6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cW7Dj58q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cW7Dj58q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9341F000E9;
	Thu, 21 May 2026 02:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779329427;
	bh=A2eiu4jRCST+cyQivatEZVXNGasrA0p8VcXeihk3UoI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cW7Dj58qRso34AMHS0cZKY/rEJ/Sjfws6DwohO/rWUXaLvqLc3lE6gTakCOZzVPNj
	 LFxd6sKFzHObi2KwKTm3zTb25kvL7KjL7OJ+T46JjJOXpjjyG0wKHpH43Qj4EU5zgi
	 mQwf7gVu7vezHO7044QKd4yJWtaP+X8Rf5Gf3uxXenAGXfBvIhstup4VMgfmJUtZOG
	 AaWkBJdm04ijTetNE8fAZVjr6XUHB4XkDT4/xabq1G0E6iq8IXqh2rECFNydy01ey5
	 KyxELdGN/VOuuu4NFkT5bj95V7zExcFsHNlAwe5HXoOSjHi3SzEsLLaUOouAvEkM9X
	 XHhTn57efA6yg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939873930C38;
	Thu, 21 May 2026 02:10:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] net: pse-pd: Use named initializers for
 arrays of
 i2c_device_data
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177932943713.3832404.16875991143751731467.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 02:10:37 +0000
References: <20260519140101.1584946-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20260519140101.1584946-2-u.kleine-koenig@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29_=3Cu=2Ekleine-koenig?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	=?utf-8?q?=40baylibre=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 May 2026 16:01:01 +0200 you wrote:
> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
> 
> The mentioned robustness is relevant for a planned change to struct
> i2c_device_id that replaces .driver_data by an anonymous union.
> 
> [...]

Here is the summary with links:
  - [net-next,v1] net: pse-pd: Use named initializers for arrays of i2c_device_data
    https://git.kernel.org/netdev/net-next/c/f186a3ae9061

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


