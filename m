Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F315E3D3B3;
	Wed, 30 Sep 2026 00:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790727008; cv=none; b=e3WezkdMa5WPIApK9jIRhRgGzWcIEpVhJIdGz822H1D9V+/xa73mOUusE0KzSuT4GQCxsqvp5sOr0iAzlFqq4+bMbuwCVUCYeU9A0ioHX9+JixYZ4aRB9akeMMwPcM0NwaJhRxWtWAov2w+2jkJ8B+FmQZr6NLo7ySaeQI+tOvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790727008; c=relaxed/simple;
	bh=n4PTn31+8DVQZKywUlH11iDpBZnqL+EEY9aPNJ7iSGo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FwpjYj5+/C7ujPWg6E6Di6PcN+pPok+fdVuONRLQnUlmAoRBAOpOg7ROEoKq9m9QoJcydkz7CUNeJWRfh9PKoaepxzV8gpZsMWpjVrFJPsiU6An8ysSgYh4w5DzQqb6BRHqFTUV3NyRWfP6dPujGOnYxzjocPF1T1PfuzTJT0vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+XW6g7C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+XW6g7C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838491F00893;
	Wed, 30 Sep 2026 00:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790727006;
	bh=K2iyy0bndyVfIo/l5h1EmF5byJvdXSsULUMj/YdoEZU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=H+XW6g7Cp/FuHIuWcfQ25h+zkUZ4aDZaCyeTlgkFFwIaQCLYGipBFXR8Vwu2uhNFk
	 YlD7gvgY5tFPcYPL5rW/staR1j8mrsTrIXfpUpzrw6MVuSSc6RP7rjYBeTmccol+bX
	 y365kIcOe+CEEmwmw4WCRnlbz3+lhSII1Asd8T+Wjf5TztsB9SuDndQ2I65DbhJsx6
	 axWpS2PefEXlqEoYw1ZCrPhmVBuzJDPMWkPOxSk4AdYYPkBe8PQNdxkR7vzpWaxfxg
	 OqfOgI2q8bvxMb1HE3A8BrV8Oc9gtmFS6C/B3dmozFbvBnTSzdPg3Yv+CKAWhH/Cm5
	 dbpZQSMSypqkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7743B3808209;
	Wed, 30 Sep 2026 00:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dsa: use regmap_assign_bits() for conditional
 set/clear
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179072700504.1174822.271135710444572357.git-patchwork-notify@kernel.org>
Date: Wed, 30 Sep 2026 00:10:05 +0000
References: <20260924083538.461887-1-peng.fan@oss.nxp.com>
In-Reply-To: <20260924083538.461887-1-peng.fan@oss.nxp.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: hauke@hauke-m.de, andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 chester.a.unal@arinc9.com, daniel@makrotopia.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, ansuelsmth@gmail.com,
 linux-kernel@vger.kernel.org, peng.fan@nxp.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Sep 2026 16:35:37 +0800 you wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Replace if/else blocks using regmap_set_bits()/regmap_clear_bits() with
> the simpler regmap_assign_bits() calls in the lantiq gswip, mt7530 and
> qca8k drivers.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> 
> [...]

Here is the summary with links:
  - net: dsa: use regmap_assign_bits() for conditional set/clear
    https://git.kernel.org/netdev/net-next/c/679950fedec7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


