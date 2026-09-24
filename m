Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5673242BD;
	Thu, 24 Sep 2026 02:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790217079; cv=none; b=klVcYuPxwbmTXr5M1xWse1QuDmF0xKCJlD95epOESSklwswhMCflu8JwE9JrZogITlJzZBXsfQGLeAfkEO07f5kuqCDlobF6zfghxVUQXX5fm3qtl3vy09hK0s6eU9iEU7hqpxwAKudsJEbbTVlDr7Q2o3KWmrPw8AkrMk1Rpu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790217079; c=relaxed/simple;
	bh=3PXHpGjlcCc9HT82GGBNcKqXnSmwc21u2aGEHxpBSug=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ICdG6+ITfdKslBVHxzXhX1SQYxJwvIYiNKBj7k51/9I1T4jFFxmd0hIzi4JG6h6JsJxd7zDwYEu6ApG2+YSwMOWxRnYp0aNBgAyPA+aLeUY7qqBL8fH8DaClHaCxUVpoU/pVTALR7xYXWZNgCIxN2fuvIUAH7RTSlYEUfyZv6s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4QfCfKx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4QfCfKx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A2B1F000FF;
	Thu, 24 Sep 2026 02:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790217078;
	bh=c6w91TE6g30fr4eD22Lqsas8RnDaaSDIZzZBwhTM3Gg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=P4QfCfKxEMPUCQ0X39og61u3TI2CK6l96xZiz4lJ/A+4KgnyG6WlkHsw1cewBmvE2
	 cYRATICVhtUj0WDNskAR+orLQq+stwQlQH0P4m16vrm8mp1abv31R/+DzxFw2ZTHXx
	 e0KeLlV9DahFXjwmMJYSFwc/hfUb+W4ulXVJrkD1n8bc6Za7znETNzf3c2N40Keq06
	 fa/Ir3tvATOQQZI+HvYCc1RpE0ZbKHI3mMLuTH/HBV6Yy3rR/s08GVAU/G/aslyLoD
	 6GjvZfggel2lMlua0W5QI4OUY4dAHJn5BXq8v3IZgL93cK3tyEKdCffjcwUz9I5MYa
	 9AB8iGN+RTdCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AA839E9611;
	Thu, 24 Sep 2026 02:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: usb: qmi_wwan: add Quectel EG120K-EA
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179021700745.1285615.10846284405766094581.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 02:30:07 +0000
References: <20260921093426.2870266-1-gilbertorconde@gmail.com>
In-Reply-To: <20260921093426.2870266-1-gilbertorconde@gmail.com>
To: Gilberto Conde <gilbertorconde@gmail.com>
Cc: bjorn@mork.no, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Sep 2026 10:34:26 +0100 you wrote:
> Add support for the Quectel EG120K-EA LTE Cat.12 module (USB ID
> 2c7c:030b). Its QMI interface (interface 4) uses class/subclass/protocol
> ff/ff/ff like the other recent Quectel modules, so match it the same way.
> 
> The product ID is shared with the EM060K, which the option driver
> already knows and uses to claim the serial interfaces. Without a
> qmi_wwan entry the data interface is left unbound.
> 
> [...]

Here is the summary with links:
  - [net-next] net: usb: qmi_wwan: add Quectel EG120K-EA
    https://git.kernel.org/netdev/net/c/0f2fd31f63c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


