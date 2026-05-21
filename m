Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F2631F9B8;
	Thu, 21 May 2026 02:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779329422; cv=none; b=IpxjFtR4LNi4KNdKajGQPsSmvpSDIXm3pb+bvSmNGFJDBN+4eYI2+9xh21uTDjbquPxUzzHpxWBhoX6DwQObqwpr4BE4uXc3eLPuMYcZ21AJbY1xErvq99D2bh4w0w+t9/z6Pv97MLosXk9POswhmpSo/usO13kuSUA1o+P0iQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779329422; c=relaxed/simple;
	bh=nNG7FvlSZofv0jBxWzbD6B5dcnSZNq983U7xszCoToU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g/ZhpA9q+EHxORs1GrNYOxVJejoXGBjPouvVq/XnQRo6KKoFAGHi5skvGAhb3OccQ0YguTRAQygnJcx1LM3UHPnViqdtjORytOf7Kj10mVj4Z4IDecf1BEzqfNyaZHie6qm8Fsnfcq/6S3loxwB2YJ8gVA4cv+kfCWIWIT9aG0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=my+loL3A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="my+loL3A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6C81F000E9;
	Thu, 21 May 2026 02:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779329421;
	bh=shQgvvyx3QpHbVTH2NgRoKTY/AmWcqtdkBrg7aSZdn4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=my+loL3AAZo2Dm9XXToQDXgUxg+BHQQHkJBxyUlV9oNed+1ZJ5WEvVfv/tx9602Fo
	 FOStm8BDCBgenB0xP+TtdBraOev8EhAzE/+TUtsbelKnStwnQlj0d2Yqs2L8g1ap/5
	 UadnOV7lFBgF/H2bCE6HZ9vpD8aWWTIu+6fmpJVZN7cOjHSz2yhdQsx75zWRzAdalw
	 YXdwp8cg2m27IYiDCSThRg8gL963X5DVLIVV/SO590cA8qLpoXEgNRR84QHjaGYfej
	 DFYWQnTgovWlwqtJ+cQB+30x++78NO2gyh3Ay/9zbvJdxwKbTI/0zHuPQa5gWR/z7V
	 tdX5UT7Xpj3oA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A123930C38;
	Thu, 21 May 2026 02:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] net: dsa: Use named initializers for struct
 i2c_device_id
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177932943113.3832404.72207850404498274.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 02:10:31 +0000
References: <20260519145722.1590298-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20260519145722.1590298-2-u.kleine-koenig@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29_=3Cu=2Ekleine-koenig?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	=?utf-8?q?=40baylibre=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
 george.mccollister@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 May 2026 16:57:22 +0200 you wrote:
> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
> 
> This patch doesn't modify the compiled arrays, only their representation
> in source form benefits. The former was confirmed with x86 and arm64
> builds.
> 
> [...]

Here is the summary with links:
  - [v1,net-next] net: dsa: Use named initializers for struct i2c_device_id
    https://git.kernel.org/netdev/net-next/c/af998e3688b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


