Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9743101C0;
	Fri, 16 Oct 2026 01:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792113608; cv=none; b=Wp2StcEtZPXMKI42Sd0JAQ89puNZKu0UPeetXNgndyCcWOB61yrK97lK/kJe4ypWTARIQizzn2mwyfwEZ9IisHHk7X3MT+/F3OaKb5zZSijZqww81zXzd6CprqQebnsEpK2o5y0lYAEN4ecA1eezXzeAtvPZ7PMTyMuIsYAHSFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792113608; c=relaxed/simple;
	bh=APDGWn+ByprlShKmMz0tVQU0JSlRbD78BVMv9IxjRMs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OfhI8FMfNjHuxZHs+KkeNqnxTfO5mqH+HtlLC5ztgz+S4x4LodtjVCMxlAxG335ViHUnuaJzUgF7QgGdtNJ5WVRtfJUETeTd6eWJIGHuz9biS8kxCvo/Pu8IEBze0lOI5lrF1SjGc4EPVlC6XDzxlpKHGNmGVIFb3R7E8PpjPTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlR5qSLR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlR5qSLR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E841F000C4;
	Fri, 16 Oct 2026 01:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792113607;
	bh=E8GimDw3pvNuacG7CQlBRbD7/gWrwFoJLhgSzu5p3ps=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MlR5qSLRopPmGsRLxtfTAwDN11r3e5uC7WjYrPCalr+BtgHAGdSxbB5mwBIMw5Y92
	 qgS/924ULs1msrRLfPVWFCYIg5BNfbgvTDXqrzUbkdhGEVmOLJMiNaivIRJmg48M5M
	 BNxe91d3K2Axu7KyLn2l/M3lw3zyQBYxKWQrWagjtjkGRhGLuRv8Cw7Mwo/44SauYZ
	 EfjYTCFTChSkurMzXSh0Or9krcsoDmjGBEB8OhiZ4ZL/+9l7VDKctz1qM7UKeNjtZW
	 Gpw0sEZdXm1cNxMM/5jGy7CfNhwWz+1GBSK4VbWGAI+l78lUXKMSwmsHpA5emeYjx8
	 d5ZAfJU5s9LcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A4643808209;
	Fri, 16 Oct 2026 01:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: usb: lan78xx: reject invalid EEPROM write
 requests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179211360576.4193708.12708323152035415526.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 01:20:05 +0000
References: <20261010213248.15938-1-stefanomunari.sm@gmail.com>
In-Reply-To: <20261010213248.15938-1-stefanomunari.sm@gmail.com>
To: Stefano Munari <stefanomunari.sm@gmail.com>
Cc: netdev@vger.kernel.org, Thangaraj.S@microchip.com,
 UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 Nisar.Sayed@microchip.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 10 Oct 2026 23:32:48 +0200 you wrote:
> The runtime PM handling removed the -EINVAL return for invalid
> EEPROM/OTP write requests. These requests now return zero from a
> successful usb_autopm_get_interface() call, even though no data is
> written.
> 
> Set ret to -EINVAL for invalid requests while preserving the runtime
> PM reference release.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: usb: lan78xx: reject invalid EEPROM write requests
    https://git.kernel.org/netdev/net-next/c/9272297df141

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


