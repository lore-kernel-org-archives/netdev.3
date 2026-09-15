Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379F73CF1E6;
	Tue, 15 Sep 2026 02:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789438280; cv=none; b=EKz+8flhR9wuDmOstYXhz6jKyZcXvjg6AcqZ5/viVYGfcfEv17Z/Kb7cqMHoxxlMqxUmwUUJ1vW+/C+z1jRqKDBRuTdgGy22AWnB3f6D1oODAmJNCLMmqwh2ZYRKc++X0CzvMqNgZ+jC+SH0nzA2/kE3gBGyiqwcCQIh3worwKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789438280; c=relaxed/simple;
	bh=wnlfiXlpG8nCYaagEeYUHylRbs64dTvS5Qocf6a/mWY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BytMytFaXphiUMMoWzOBvlMjygPDufXW920h/xsbNNwr++0haz7VfusyjDEcjL/L20if1lAbYHFag2lB1/GNLlEwc1a0mN6ufqvNlQMOoVE/1Hv48AOSvX230XnANATaYqAJumA/gFIdZkX9RWRTXkq6CNxV2KWDRofnd70rv5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CH//NHTC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CH//NHTC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F6D1F00893;
	Tue, 15 Sep 2026 02:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789438278;
	bh=4S3VRquMpKlrPOR2TZexhm6DFlDuABWqBf6DlMNhpn8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CH//NHTCmn8x1gykEUMbofNjpPWh/gxQx5+irZwn75xmqYs+GdT6TDwTDj3QJGGVo
	 oAr2tVWgd9AEhC/pEdm71GjPAmiNqTu9IC3fWouXCstbJ0RuynpRhZnuqPDEPb2w87
	 m/E+Dri+eMbVLbFgFQYGBiMVgYBwPDPlR+Z1YZ4IIHArwXkv7Bf/9GyLaJX0Q7JaA8
	 4yffA5qyD8CP6TdPRi1iCepUlXwe+ZV1w627Td6hC0pJrYpHy4sMZh90HIogEncvhG
	 2JHnTC9iPMKKppPhVGabX7pnVxnOYO/lEzUcVrVwWlNq7solbT30hD1XFU/7KR/Ddp
	 jqFOPFtJ3xhEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A063924FFE;
	Tue, 15 Sep 2026 02:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: mediatek: do not report link and per-speed
 LED
 rules together
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178943821337.1315233.3755940967519255382.git-patchwork-notify@kernel.org>
Date: Tue, 15 Sep 2026 02:10:13 +0000
References: <20260912134306.3544329-1-naseefkm@gmail.com>
In-Reply-To: <20260912134306.3544329-1-naseefkm@gmail.com>
To: Ahmed Naseef <naseefkm@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, andrew@lunn.ch,
 angelogioacchino.delregno@collabora.com, daniel@makrotopia.org,
 edumazet@google.com, hkallweit1@gmail.com, kuba@kernel.org,
 matthias.bgg@gmail.com, pabeni@redhat.com, dqfext@gmail.com,
 linux@armlinux.org.uk, SkyLake.Huang@mediatek.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 12 Sep 2026 17:43:06 +0400 you wrote:
> mtk_phy_led_hw_ctrl_get() reports TRIGGER_NETDEV_LINK whenever any of the
> speed bits in on_set is on, and in addition reports every individual
> TRIGGER_NETDEV_LINK_* bit that is set. The netdev trigger refuses that
> combination: netdev_led_attr_store() rejects TRIGGER_NETDEV_LINK together
> with any per-speed rule, and it validates the whole resulting mode rather
> than just the bit being written. Once the hardware has any link bit
> programmed, every write to the trigger attributes of that LED therefore
> fails with -EINVAL and the LED can no longer be configured.
> 
> [...]

Here is the summary with links:
  - [net] net: phy: mediatek: do not report link and per-speed LED rules together
    https://git.kernel.org/netdev/net/c/bde5212360bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


