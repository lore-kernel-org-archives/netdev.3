Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C8C231829;
	Tue,  6 Oct 2026 00:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791246009; cv=none; b=TQ58GGOtyidohAE1vcpY7s1q80zo7/huQQiYJ5CGIK1Vu6yFPKTowNCBZG67BB/z6DpHEIK+l4DMqeTU6iXm750q+T1d6bmInNMnv0Dg8diKh1XsE2vVQh38EV8mE7Q1nYD37OfF0Qn89s1Z7ocuWPS9tVhn8yi6a6Ura4WYO/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791246009; c=relaxed/simple;
	bh=y4kHHK1yxWlizCDTbxxd1ARc6S9HF0bz/jv2qe+Jwpw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WkxByBfz7nki7/QWAef6RLh2dPEhn3mzBy/0neUPNwvMzy7xMvpfmQoQ4JgnZrGNmWDre5F585pjrH6aeALnQKWTVGci6YhUm2CnkAF1CxAdKab4zTUcGd0nlIwjgh1APUaPkH4vFSQ9yTYue9W52S+SQqhoIiqENdoF6XR8+oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LR/S+TmV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LR/S+TmV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465891F00893;
	Tue,  6 Oct 2026 00:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791246008;
	bh=rHsVkmklYJOV6LS7zrwbh4yqxLmqrIB4fLwFQVZebVE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LR/S+TmV7Yt9IK6q/zj2+F82U3yZDER6zRd8t50pZ/fKADJA3+vpn4prenSY6pA90
	 pwvBF/h7sF8njwm/EiCi0lK+DH6IUbVjxTjL/gmHuYyqPdie15nz0RcEkcEUduo/un
	 NbztcvOQgi3M5PeQCHtXx25X1RqFVUS33hCELZwk1F2gxW580L4IdQp6T22n5as/dO
	 6ekW8fovzqn0v1lPYersOcuWXSlzA3N3l0XEmlCy3YuGds+jImjE67bJ2ELxzHgdah
	 /dBT83B2ymqM3f2QvHKAlMi3OAtVdnmdp4eJxH2k8ob7IZZq3qSFr5TnESKzZUDRTZ
	 7TsvThYKagMSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A5B9392667F;
	Tue,  6 Oct 2026 00:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: realtek: rtl8365mb: define masks using
 BIT() and GENMASK()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179124600677.1950904.12532291720164086271.git-patchwork-notify@kernel.org>
Date: Tue, 06 Oct 2026 00:20:06 +0000
References: <20261002-realtek_bit-v1-1-771fb0e39083@gmail.com>
In-Reply-To: <20261002-realtek_bit-v1-1-771fb0e39083@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: linusw@kernel.org, alvin.sipraga@analog.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 02 Oct 2026 11:14:57 -0300 you wrote:
> Refactor register bitmask definitions to use the standard BIT() and
> GENMASK() macros instead of hardcoded hexadecimal values. This improves
> code readability, reducing the chance of errors such as unintentional
> gaps or overlaps.
> 
> Introduce RTL8365MB_PORT_MASK as an alias for GENMASK(10, 0) to replace
> the repetitive 0x07FF values used across various port-related bitfields.
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: realtek: rtl8365mb: define masks using BIT() and GENMASK()
    https://git.kernel.org/netdev/net-next/c/9b84b36a527c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


