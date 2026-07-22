Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E5A43B4A4;
	Wed, 22 Jul 2026 21:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784754649; cv=none; b=aafHINNWL7DLl0WJTJ2zqn+mC9AGPp1Nw+yqj+tCtNjS8xaDILfYn5UHN7aXkKHZNTsWpmVk/Iw8r+JEeYJISP2+RCdsXUJBGT1X6KUMMk3iEXcQvGOjzctwZUvHgU+e0KNrQDwGIRLRE22y7lwbVv3vYSqSATYjOsqNDTi6M6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784754649; c=relaxed/simple;
	bh=91QkwlH84kwOsivgexosS7JomgWKksFy1e0LnV/Rs60=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HnOMxc5wxWiM/jJiwbAePpzsDiVCSsaq27lT+We5Z5dYiZksAmMvn49gFqm2D+kIdAPhu8OlVRbnaWliHh1tkjUujD7mnwdcqlCQwQgha49sylkbyQOhOBzFo+JzvDPYtyY58l02GQNJBojXePfJxfwvoGN7ubDn4avKmN3dgtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mR2D/xcz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mR2D/xcz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92311F00A3D;
	Wed, 22 Jul 2026 21:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784754648;
	bh=oqwN6GnLhIgG98t5IE9dAVJBJGSQc58h99VPxss3bww=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mR2D/xczyCbI2UrfuFEHRadzyhx7smT0S+PGxmdlh/nq4DWmVLHfJ3GpGfaFRk10b
	 Cd2nU/Rkl9+Sgk1GPmQQiN2fLsQPnng/vk4/owsbLgaS9kEfxQOeRj9afwVozck1Au
	 /yDp/KrT3/2kmnpB3IKMyU84c/967Gs2QY6TDbVBTVWQcdQssoGrWTyu7Md59EQwXu
	 AmHRNQeJqmhdD/xjoJhyezYZH55vITmkKIHxFBEYTfEUdILOAQuKNUI7a7/C57XjI7
	 tUMo8qQ5rXoVhgdCBkcYWbcsFZWfus3iaKiijYw2TrbSRN7ocN6gneAPWylvrfxQEH
	 ucHf/mjJgDh9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0E15380CED5;
	Wed, 22 Jul 2026 21:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: dsa: mt7530: add EcoNet EN7528
 built-in
 switch support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178475461638.2026851.7452354596103866220.git-patchwork-notify@kernel.org>
Date: Wed, 22 Jul 2026 21:10:16 +0000
References: <cover.1783770059.git.naseefkm@gmail.com>
In-Reply-To: <cover.1783770059.git.naseefkm@gmail.com>
To: Ahmed Naseef <naseefkm@gmail.com>
Cc: netdev@vger.kernel.org, arinc.unal@arinc9.com, chester.a.unal@arinc9.com,
 davem@davemloft.net, andrew@lunn.ch, angelogioacchino.delregno@collabora.com,
 conor+dt@kernel.org, dqfext@gmail.com, daniel@makrotopia.org,
 edumazet@google.com, kuba@kernel.org, krzk+dt@kernel.org,
 Landen.Chao@mediatek.com, matthias.bgg@gmail.com, pabeni@redhat.com,
 robh@kernel.org, linux@armlinux.org.uk, sean.wang@mediatek.com,
 olteanv@gmail.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 11 Jul 2026 15:40:59 +0400 you wrote:
> The EcoNet EN7528 is a MIPS SoC whose platform support is already
> upstream. It integrates an MT7530 switch, memory-mapped like the built-in
> switches of the MediaTek MT7988 and Airoha EN7581/AN7583 SoCs, but with a
> true MT7530 core, four Gigabit PHYs on ports 1-4 and a CPU port at a fixed
> 1000 Mbps full duplex link.
> 
> Patch 1 documents the compatible, patch 2 adds the driver support.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] dt-bindings: net: dsa: mediatek,mt7530: add econet,en7528-switch
    https://git.kernel.org/netdev/net-next/c/886f928a7849
  - [net-next,v2,2/2] net: dsa: mt7530: add EN7528 support
    https://git.kernel.org/netdev/net-next/c/cf23fcc9437e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


