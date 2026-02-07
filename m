Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1EF2DAFA2;
	Sat,  7 Feb 2026 05:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770441635; cv=none; b=rR1nTbdIaRnqeH7zUH54/TiEniVoV0xICdWtlap3aUtlxlNInVvtz3Z0OX9ZNC8nrUIdv1iPQkb9Rbc5Iw7W4FAYREXbsEkOOCgFao6BS7bqARKeUmeQZyr3D7RJ1xzP/C1Gx4yZNWlkkau8Mma+Mdt1ICz/tiQIrJLGFPYmViw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770441635; c=relaxed/simple;
	bh=dClnbGWysKQKxfuDfXRQuU+sMDnIjxiSLL/pofkK/mg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MbxwDTT6HQYLtMsyLV9GgkFcQKjykI0ijeta/EgeFoU7V9D7ToXkhAr84eaxpRmMB8urosR/kLEKFwxxZNIVNr9PUNl//nXyB9LBDgb1d7OrDNbW1P/EjAygn8riJYPF1MY1F47t/0+/d3KEDk7LqBrAyoODS86EYSDLnSqvt5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIqqZ0QB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIqqZ0QB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73B3C116D0;
	Sat,  7 Feb 2026 05:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770441634;
	bh=dClnbGWysKQKxfuDfXRQuU+sMDnIjxiSLL/pofkK/mg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CIqqZ0QBjD1Pkhn+G2+PVyLzqyEjiQtDv0L27zR20bmfSXe0X/+ByuoI34/U+aUmQ
	 07mfJmJpI9A+ZxYq5O01T9CprCK/Sl+PdHFRmAJjIUwfTvOmwnDzPq+NcjkS62Jany
	 bYx7TdisSilrfkcPZqQImQK/WXAplD9QLOhdoly+TuZSTKQpyE/7HLl9cNSuB2IfTh
	 EJEiOVrZwEtCWdzO9u3gtge0fSXWb1dEUEIQAixsBm/O1/oTtFNcNb6z4hthb9B8NI
	 NBJdUM8muGy2Wo329rUSt/9JjkDqLiAPtuh4aJZN/fsm4/iW3FCUWPbR36Jp8cAqZv
	 s/BkpIw5w2aSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B1743809A1A;
	Sat,  7 Feb 2026 05:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] nfc: nxp-nci: remove interrupt trigger type
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177044163182.1196512.6638628570884022821.git-patchwork-notify@kernel.org>
Date: Sat, 07 Feb 2026 05:20:31 +0000
References: 
 <20260205-fc-nxp-nci-remove-interrupt-trigger-type-v2-1-79d2ed4a7e42@amd.com>
In-Reply-To: 
 <20260205-fc-nxp-nci-remove-interrupt-trigger-type-v2-1-79d2ed4a7e42@amd.com>
To: Carl Lee <carl.lee@amd.com>
Cc: krzk@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 peter.shen@amd.com, colin.huang2@amd.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 05 Feb 2026 19:11:39 +0800 you wrote:
> From: Carl Lee <carl.lee@amd.com>
> 
> For NXP NCI devices (e.g. PN7150), the interrupt is level-triggered and
> active high, not edge-triggered.
> 
> Using IRQF_TRIGGER_RISING in the driver can cause interrupts to fail
> to trigger correctly.
> 
> [...]

Here is the summary with links:
  - [v2] nfc: nxp-nci: remove interrupt trigger type
    https://git.kernel.org/netdev/net-next/c/57be33f85e36

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


