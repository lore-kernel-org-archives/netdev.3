Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6805E16DEB1
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 15:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377400; cv=none; b=B0Cev/FVsnjCZPT1NXenXmicwJgYTarORC4o9Jv1Yxc7PtMT1tSZZ4urM/Hwa48s1Wszjb82xkQyNx9kfVSxcgru8VP8QlW18KOLIMwzApKU9FNNH4A3QIlBdxkqcKlZ5pRufxc2uRn+c3BvOoBE7ApfUzoxnSIdidLAYxI6mrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377400; c=relaxed/simple;
	bh=+bZ/mB9+62BxTwp+WJFeolV3QaTYzJFdQ3qs1nJINUs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fLKdXWzR0tvzotOzEELX9Eu76ENhckKVjV2VhNiV2YTqosn+q0yy/jrIm3PiNqojN3v2lscHDUYIKVWFdZLYFEhpt8Jh2nB8u5FyLKQ+q1KMS8cNa4A/I3TUKdvFJQGm/UgEhDuOqoUZLr62PF3MJCg8fkCLjtSAZ/mX/Ns1zXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+ELi5Yz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+ELi5Yz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A3D1F000E9;
	Thu, 21 May 2026 15:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779377399;
	bh=6o1IkY/F+HH2uY+8ham+unzEexE5zCoe5urJsKJFQzU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=b+ELi5YzjEwTFaCG3+Sbvfo+Eum0r+TXOJkb2mcYat056UGfa4JfGgy64KhBOdGm9
	 XDTo6gL0VhrRUD3tgPMvKCEhB1NKZi+qihEGcUe28/AAiyDECIDO/gfyAp2sCYSTf3
	 pvDnJaUTLsmifBBRHmpGiTGVp8FUTn0mcw+Et0CFIFOKU14zMPksIfAXNvEyyfRrmj
	 gL5pRqsXGsc6mZpg2CY0yKhGCNXWdAcchkEXKn4i3/pyOOkqdRtf33pkAa8lo4c0K8
	 2GYiOJO98508+5TD36WSn4Q9qr+OYEcYb2zGVIoCbAyamViQCCpotORJ95uR/opd/D
	 R6DBOhfCN9NRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197F13930E02;
	Thu, 21 May 2026 15:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: airoha: Disable GDM2 forwarding before
 configuring GDM2 loopback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177937740865.384060.9848188889062709318.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 15:30:08 +0000
References: <20260520-airoha-disable-gdm2-fwd-v1-1-1eeea5dffc2f@kernel.org>
In-Reply-To: <20260520-airoha-disable-gdm2-fwd-v1-1-1eeea5dffc2f@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 madhur.agrawal@airoha.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 20 May 2026 15:12:02 +0200 you wrote:
> Hw design requires to disable GDM2 forwarding before configuring GDM2
> loopback in airoha_set_gdm2_loopback routine.
> 
> Fixes: 9cd451d414f6e ("net: airoha: Add loopback support for GDM2")
> Tested-by: Madhur Agrawal <madhur.agrawal@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] net: airoha: Disable GDM2 forwarding before configuring GDM2 loopback
    https://git.kernel.org/netdev/net/c/985d4a55e64e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


