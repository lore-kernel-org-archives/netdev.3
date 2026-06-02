Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA640392C56;
	Tue,  2 Jun 2026 18:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424977; cv=none; b=rkItlRUmUNZk6LIFJ/JVgmjE5XLhQqsUXDzJyMPYNM0jGtDGOBUGCB7JiRVeyhrMdlWri6R+X/tM/OXskybnDFmAyBFE6UgD4uZrHxE7bswQTBDl1kEWz7yn6YLTZOuASdAIlKv2KPk8IxYS1O0Nf3Cg+bYmqpjEqXAkRmdHU4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424977; c=relaxed/simple;
	bh=04qWF9Ae8K/4Xapo/ZPvyROw5z7IFlqOWDEYCmfHkZo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q/Crfllb0Kd1DaGQwLLQXa7VNc3g+BVqAq0kUEeLMl2BVyrnlaTKFO+7YUiPi1FtxqldwouiW64Aw+DbKVZzu+9LEAVKzaCqsYoUZtpQWKtSzCU7+2pl+4v2lsCv13h6qezQ9H+zydlOzF/c8e793+C6sqe8TyXmy34EnCMV3ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASG++oE8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASG++oE8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789FF1F00893;
	Tue,  2 Jun 2026 18:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780424976;
	bh=yfIQa9OoA2vvrqJOO4Ql7GOgQj5OEnL0IMlvo7n9zhg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ASG++oE8QgoaaG3PBRxRmQniR7xjK7CNwvh6HBSjwtcbzyQkHR9PQFiqnYtrerB2o
	 mZ775iaoHiRQhQhJlwZZX3NQ6btSSYy5M43L6fOsF5FNmNZMjJy4PARSC+PbWPxhrk
	 vV8P76OVY9ZDeq7GTvCtaA35H83Hh+VjzYPVStHLye0y3ELzHuaI9i+Z+Z3XSkMvxu
	 2CYvJ6CQtuF/IyxtUCPw+bLt0PD7Xis2j6hjY20S9xxi9xndEc/cCVhSIkyeSHzixH
	 wFjET+SBd3cjWAr8w07/tVqk6dC8qb3yUWZl4pgREMIo96eiPqO0/Ds+yrCyH/IeNv
	 UKAzzBVFBAP7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93ABC3811A6C;
	Tue,  2 Jun 2026 18:29:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] [v3] [net-next] net: dsa: b53: hide legacy gpiolib usage
 on
 non-mips
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178042497814.988310.3355358130551344893.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 18:29:38 +0000
References: <20260601165716.648230-1-arnd@kernel.org>
In-Reply-To: <20260601165716.648230-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: florian.fainelli@broadcom.com, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, arnd@arndb.de, linusw@kernel.org,
 bartosz.golaszewski@oss.qualcomm.com, brgl@kernel.org, noltari@gmail.com,
 kylehendrydev@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  1 Jun 2026 18:56:42 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The MIPS bcm53xx platform still uses the legacy gpiolib interfaces based
> on gpio numbers, but other platforms do not.
> 
> Hide these interfaces inside of the existing #ifdef block and use the
> modern interfaces in the common parts of the driver to allow building
> it when the gpio_set_value() is left out of the kernel.
> 
> [...]

Here is the summary with links:
  - [v3,net-next] net: dsa: b53: hide legacy gpiolib usage on non-mips
    https://git.kernel.org/netdev/net-next/c/c0b3005e32ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


