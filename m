Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71F72222AC;
	Wed,  7 Oct 2026 02:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791339007; cv=none; b=NcxJEZvtiFERozx7VX3iNyt647lF3c6FHoR8AbRwOEbPSafL2utaW9n1Aii99LL/v/sNuCNgnyj9Pre9kKMWEp6heVqDfTNSqckUuf+OtCjoEhTKQs1ezRkRBT7m6sMsGeUnTHxsjbpi20xaSdAy7WrBM0vioJmfTW7ZIWHv5rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791339007; c=relaxed/simple;
	bh=01ILqNT0sT/u1hrKWm16EDf/ab/LDiqU4djnsolc8MI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H8M232oFJdTTfPYsxKXED/ZdH4Qr7fsfmxEcvGjLyKDIdxWMz/NF4Cfc5LPG+PSVNkNwN6hv8rqNraKQUiPeeYOf2w20pMYDMof0Jk53rDtoUXrN9Jn0rzozp4K2+QYJQ4kBIuBVEe03GPwA02609B7SwCJhGs3Li4Yv7ZRDEAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Af3cOj9y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Af3cOj9y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FE11F0089B;
	Wed,  7 Oct 2026 02:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791339006;
	bh=BhmMP45S3KCZtwB6WYyXtZBJ1IFz7iVK8GaizKtkwMk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Af3cOj9yqbZh0+Ef2giyNFbpjnFcumNxniPfzBwuzka3CrPah6q6fGOY2T0cT5fZZ
	 dla+0khlPPZZQZuumQZyWF8Fcrv1iZTBAAadUxbdbfw6kZIZThiNMmn9xSPpZ60ULA
	 ePMoS0WvPRv99Sni83c1SjKx1GbisD5e+RD0f5s0yrrHKsLz7dW6Zt2t27qtUJw9Q+
	 qmUxq+nPIT6Ewmy1mNuaoJ+elGo7Oopno2/CDzv9yjqj8vK4OywINj7RmPJg1H43ZA
	 m84mUdwvSW+ZWVl37hZ94xdrDaUBaSMRjYqYPWQJ7v5x0RTqi70cLpLQSCHgKb4Yzl
	 FKlQKzzi7S7Uw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773F23806541;
	Wed,  7 Oct 2026 02:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v11 00/13] dpll: add SiTime SiT9531x DPLL clock
 driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179133900528.2873267.11554390181799157650.git-patchwork-notify@kernel.org>
Date: Wed, 07 Oct 2026 02:10:05 +0000
References: <20260930233714.87679-1-arouhi@sitime.com>
In-Reply-To: <20260930233714.87679-1-arouhi@sitime.com>
To: Ali Rouhi <arouhi@sitime.com>
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 cjubran@nvidia.com, Oleg.Zadorozhnyi@devoxsoftware.com,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Sep 2026 23:37:15 +0000 you wrote:
> This series adds a DPLL subsystem driver for the SiTime SiT95316 and
> SiT95317 I2C clock generators. Each device integrates four PLLs with
> automatic reference selection and on-chip TDC phase-offset measurement,
> and is used for synchronization in telecom, networking, and data-center
> timing.
> 
> The series contains the device-tree binding, the driver under
> drivers/dpll/sit9531x/, and the MAINTAINERS entry.
> 
> [...]

Here is the summary with links:
  - [net-next,v11,01/13] dt-bindings: dpll: allow hex unit addresses on output pins
    https://git.kernel.org/netdev/net-next/c/45ad84d2800e
  - [net-next,v11,02/13] dt-bindings: vendor-prefixes: add SiTime Corporation
    (no matching commit)
  - [net-next,v11,03/13] dt-bindings: dpll: add SiTime SiT95316 clock generator
    (no matching commit)
  - [net-next,v11,04/13] dpll: add basic SiTime SiT9531x support
    (no matching commit)
  - [net-next,v11,05/13] dpll: sit9531x: read DPLL types and pin properties from system firmware
    (no matching commit)
  - [net-next,v11,06/13] dpll: sit9531x: register DPLL devices and pins
    (no matching commit)
  - [net-next,v11,07/13] dpll: sit9531x: implement input pin state on a DPLL
    (no matching commit)
  - [net-next,v11,08/13] dpll: sit9531x: add support to get and set priority on input pins
    (no matching commit)
  - [net-next,v11,10/13] dpll: sit9531x: implement output pin state on a DPLL
    (no matching commit)
  - [net-next,v11,09/13] dpll: sit9531x: add support to get and set frequency on pins
    (no matching commit)
  - [net-next,v11,11/13] dpll: sit9531x: add support to adjust output phase
    (no matching commit)
  - [net-next,v11,12/13] dpll: sit9531x: add support to get phase offset on the connected input pin
    (no matching commit)
  - [net-next,v11,13/13] dpll: sit9531x: model the inter-PLL sync net as a pair of pins
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


