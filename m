Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189872FBE;
	Tue,  8 Sep 2026 00:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788828067; cv=none; b=f0DnYgKHNvwewAZuVTb77wHknNJ9pJ9HSIUBUb0PbJM291lTOIbvcGfUHpgcXyW1mD8qGygfxfjjuLCkMm/oqKIKe11zf9A2IuaWR2ssz93Lb3BFflT2xm+kiZ47864h/uhO2kLIhe/Rvq4B77MlUw1OjPZN+bi+JUPA1G326v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788828067; c=relaxed/simple;
	bh=b3RVDJC7srrTX4sriBrcL8CRle8vsAuxJlv56pL1ZAs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Vu2kZOa8ZYRrdORu8BSGhvU7iqAw5/Mj/ETxLRv0svCJPK4LnREF2DYSdixc+FefZfXutvnHSMwCNOg+o2OGOkG5hv1Qn8arEdtQQpJjB4YrxKJETTrxWhtf1/hTzMrV93XAKJoZ+Pk+0oQdO51fS3YphcWFMbN0gwplmdo7XU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btZfnSht; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btZfnSht"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F261F00A3A;
	Tue,  8 Sep 2026 00:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788828065;
	bh=dSIaduzKQogBS22bechJO6GVPJA5gPfCXCwx+67yAL0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=btZfnShtjjtJXGYF9hjVasfLCKZwlTHd/m5V0d+Uq34+XVEtbxstQS5FgDAIEpdfR
	 bowzFDytn45kRI0dTyAobDOOrYSNzZIWxvi5Rse8+iRpKVmZKGIDsxq4+t9gFLU1xA
	 ajykAsUuZRjemG38EnxFX4WovMZzlCI9wQp1giWmRmZzOVfOwVpz1q9kSQYVmpq62A
	 wlk95gXjNPr1VGeKRKGIuSEaYMdf56rOU8eL3LFYO2sgmHs9kSNdtvLANS5IS38u/D
	 0CWqi66DTulZdkWrG9HBPVD+vos3VmOwV2whiSp96p7EXXaITBXAiWCVyZLFxCQPYO
	 ryzL/mvn5qbiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09F139E8A5B;
	Tue,  8 Sep 2026 00:40:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: usb: qmi_wwan: add Quectel RG660QB
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178882800464.3222354.1014362285228755718.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 00:40:04 +0000
References: <20260903180044.6179-1-sebastian.sjoholm@gmail.com>
In-Reply-To: <20260903180044.6179-1-sebastian.sjoholm@gmail.com>
To: Sebastian Sjoholm <sebastian.sjoholm@gmail.com>
Cc: bjorn@mork.no, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Sep 2026 20:00:44 +0200 you wrote:
> Add support for the Quectel RG660QB 5G module (USB ID 2c7c:013d).
> Its QMI interface (interface 4) uses class/subclass/protocol ff/ff/ff
> like the other recent Quectel modules, so match it the same way.
> 
> The remaining interfaces are handled by the option driver.
> 
> Tested with an early sample of the module on a Quectel 5G EVB connected
> over USB 3 to a Raspberry Pi 5: qmicli talks to the module via
> /dev/cdc-wdm0.
> 
> [...]

Here is the summary with links:
  - [net] net: usb: qmi_wwan: add Quectel RG660QB
    https://git.kernel.org/netdev/net/c/4ff75f130d1b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


