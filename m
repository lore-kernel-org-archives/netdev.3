Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BC64756BB;
	Fri, 24 Jul 2026 23:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784935256; cv=none; b=TeQFEEo6h48iRFw0tphFXCoXs6fBffp1BTB34cct5n4eKtJFlOf8pqZFe0LcAswZkq3+Dj/SC/qVSM0jdsf5x3tfcOMhghqsR8m/S8Iqfi9MRyzJ50Uz4kuRdPxoIsC75ouvxu+kWq/ci6T1nBB9fSCa03w1l2MBNW3IoXlkI8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784935256; c=relaxed/simple;
	bh=SU8jlVx4qda+24K6KwptSgPK+RUuchqlpmW6UxtJbLQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Pn82NM7FLYlcCD9+7IWdQFy7MJDJn7eTgKVGCTGbR4gZxP85dPTu0m5iu/VgYUTN2Mp1/NB/BqH6TzNwPJy2AddpEyaHEtRqRVh3Hc9JbECfWbHns4BOLrGalNDX0qxycvBr+UsvFT66FesBOx2vGzynN6s8UD/SCTiJ+WDT+UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIVERTYk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIVERTYk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F731F000E9;
	Fri, 24 Jul 2026 23:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784935255;
	bh=yAz8YKBnlJrGWiGljqZran/RRxsIHrcwn00X483zaKY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VIVERTYkkG9Wpt06BtBpmj5e+tano2A63NFQ2GLLrBUVUxKQaRbHWvs2hu4QDAY7u
	 Xos2GBJd2owIcHEyfA5sgjsUyGXkcizARNXE7h7raRrOVbRb8bQix2qLEVvwmx5c6l
	 Uosff0+OnNVfIorN9RPSjaJVxG9rA4ELa/m8aHrMkngMkRz8dzLxdu3R5gzANjuhSV
	 GfBIQJciStUp1Xt1SNvvJB7Eef7z8Gc1nBD3dY6Z4ju/KlvN0D5kZub6Rnz1BQNFtL
	 S1gQPoLPc8Tqk8uKsp5Q2suHeHjZ9Cz47Ohth6iZClC4Jd6KqkZrLSMxYy4rv7ROIz
	 XzpeEeOL+vy4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5695938111D8;
	Fri, 24 Jul 2026 23:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] dpll: use pin owner's dpll ref for pin-level
 attribute
 reporting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178493522189.3348566.17337430102768275637.git-patchwork-notify@kernel.org>
Date: Fri, 24 Jul 2026 23:20:21 +0000
References: <20260714125945.1823269-1-ivecera@redhat.com>
In-Reply-To: <20260714125945.1823269-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 aleksandr.loktionov@intel.com, grzegorz.nitka@intel.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Jul 2026 14:59:44 +0200 you wrote:
> Commit c191b319f208 ("dpll: allow registering FW-identified pin with a
> different DPLL") relaxed dpll_pin_register() to let fwnode-identified pins
> register with DPLLs from a different driver. This allows, for example, the
> ICE driver to register a zl3073x-created pin with its TXC DPLL using
> ice_dpll_txclk_ops, which lack frequency_get and phase_adjust_get
> callbacks.
> 
> [...]

Here is the summary with links:
  - [net] dpll: use pin owner's dpll ref for pin-level attribute reporting
    https://git.kernel.org/netdev/net/c/2c1bd78dc8e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


