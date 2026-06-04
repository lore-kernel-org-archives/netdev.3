Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4E5340403;
	Thu,  4 Jun 2026 02:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780539627; cv=none; b=adlvmw4sdBTBq8zrWZDuyyUMybOxv7Fa17L+f4g8uTzOfu72lbBXgyARitUl8RijnkaG/kDfO856uMBDZSpg9kpGRaec4WMwiPWcpMNdAIMo0MrV9cf+8E1K1YdpeYrhF12lqiekzJba70jke+KG4ludQBSNFWLDjAvAz3v7efU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780539627; c=relaxed/simple;
	bh=BrhQ4zzSYteaEhdryH2jtQO/CNs/SF3YtlYjUHXvR+w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CvkUjYaFjdQp4WRnu6qhuO23GtLYEtAXmC8Q3bHK6y0vCYk6nW2T9LIPtFXfOVmatv/Pp23V55EjOw1YwLt9bSeIbEm2kg/54Tb7BCOzg4TPmFLkofZHQR2mWQq7DSXtprFYdm3/u/DUP5+2QOktIZB1UW02StoNTNQjwiiN2Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJQVc6QJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJQVc6QJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7022F1F00893;
	Thu,  4 Jun 2026 02:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780539624;
	bh=P5d3Eer+YEY0uHzVRb55+j5QfptcaIiirxQbjtmwGT0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RJQVc6QJNbjAQr8K1j3phO3EB0DPrcAWz1gmUyNLTcG21Hi2PR8tXs/Lqtf2OGUWM
	 bSz5kgueRMDHgH/ik3aOghy/RjMBJX12UUj41cmxll+BtKvFbQomTZmXVXxNZfSkDo
	 Am4/kgo7XGpnZRktiGGRypDVkYPzuItPmEGhxzzmnIlsY/hC8TFm6d1KG4c8UnnhL0
	 0Wf1P7CnQp6MCalimCPyxgLuvk6O/eFZ1CAh2vCO4SJ4J8c0dgvQ/i+SnWWP1522bR
	 JaPFXvRoWxjFjq3vUcwimaWlEGdzT5ERIW6O2+IcJV213Pq3yBZHQLzUO8LRZdEnsY
	 SGXJDYnMKj4QA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A8739308E1;
	Thu,  4 Jun 2026 02:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ibm: emac: fix unchecked platform_get_irq return
 value
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178053962538.2207566.17063343584858473413.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 02:20:25 +0000
References: <20260601040201.103481-1-rosenp@gmail.com>
In-Reply-To: <20260601040201.103481-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, sln@onemain.com,
 horms@kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 31 May 2026 21:02:00 -0700 you wrote:
> platform_get_irq() returns a negative errno on failure.
> Commit a598f66d9169 replaced irq_of_parse_and_map() (which returns 0
> on failure) with platform_get_irq() but dropped the error check.
> Without it, a negative IRQ number is passed to devm_request_irq(),
> which fails with -EINVAL instead of propagating the real error
> from platform_get_irq().
> 
> [...]

Here is the summary with links:
  - [net] net: ibm: emac: fix unchecked platform_get_irq return value
    https://git.kernel.org/netdev/net-next/c/1681cb1bde05

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


