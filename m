Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75D034DB4A;
	Tue, 21 Jul 2026 09:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784624455; cv=none; b=KT0IvQ5UwP0SJ2cKIO+bWMgV1h5XhgYtTzvR5NrSEwummTtRfCrm5PGfxSGTsHGdHme6aYvfTeaXyh+mWfFPBcxCMMud+Zm9PCkGHunifsImuTnhzaA60VkJ5u9SdSa9OFqdrIxe3xhNSR66YXvUTOgN89guGLk8c89e0hQRjUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784624455; c=relaxed/simple;
	bh=Ce3TgVnFtM9NuJ9xl91qVQ2BBavQQ218Ymd+/A6JliQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q4ZaSblRcXaoWel6+VU7yuUeqZobY8o/z7vaCSRY2OQ2mgzebBvGU/4GqaeRxUjWwC34wJ87H30aBLtfZFdQsLO/JPztVtJSZJNj22WHUFcFjgO+pkY7Mk2247GFlIX8TwJZiG2SmE0Woi1gHP7N80m/0YRS15CHDrbe/YBIdEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkdLiIqu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkdLiIqu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500DF1F00A3A;
	Tue, 21 Jul 2026 09:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784624454;
	bh=kT+Q8kRcBsmrQIxq+3cEUACSAv9IYbo+YgFCNmr8RMg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZkdLiIqueP2AZ/FKt7r4mv1kyFPSyDr2vcZc0iRJsNHKcN+jexQ9Jy0RR+KpPz7RW
	 lUb3LheAgAP6FFPydYQxdbZudvJdQY5PO37x1+2vE10+/LncOAtXc7Fr3xUficKAW2
	 nVbrRdU4gWBFTSykugHpLL0fVPdWP2bRr6nMdJBlGxBnpbsWbpHma7HyvkyWxsjOSq
	 1g50hYeFAB7LaSZDPleHPnDvZf4ITFwrpI8PYLUHF1UP6zFYtyw4+UgGout0t2D0QU
	 Ev7GGrkMm7H5LdH5VTblhXPhV6nuT6oHxdVhqJo5uJUGRc6zvu+a8IRK2Z+DzIvid4
	 3M4AxxM9AHdmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56BC73924A44;
	Tue, 21 Jul 2026 09:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 00/13] net: Add ADIN1140 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178462442388.169679.4872315897072342362.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 09:00:23 +0000
References: <20260708-adin1140-driver-v5-0-4aca7b51a58b@analog.com>
In-Reply-To: <20260708-adin1140-driver-v5-0-4aca7b51a58b@analog.com>
To: Ciprian Regus <ciprian.regus@analog.com>
Cc: parthiban.veerasooran@microchip.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, conor.dooley@microchip.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 08 Jul 2026 01:33:28 +0300 you wrote:
> This series introduces support for the ADIN1140 (also called AD3306)
> 10BASE-T1S single port MACPHY. The device integrates the MAC and PHY in
> the same package. The communication with the host CPU is done through an
> SPI interface, using the Open Alliance TC6 protocol for control and data
> transactions. As a result, the oa_tc6 framework is used to implement
> the communication with the device (register accesses and Ethernet frame
> RX/TX).
> 
> [...]

Here is the summary with links:
  - [net-next,v5,01/13] dt-bindings: net: Add ADIN1140
    https://git.kernel.org/netdev/net-next/c/2aa955bc52e9
  - [net-next,v5,02/13] net: ethernet: oa_tc6: Handle the OA TC6 SPI protected mode
    https://git.kernel.org/netdev/net-next/c/7d0e4c4b8c85
  - [net-next,v5,03/13] net: ethernet: oa_tc6: add OA_TC6_BROKEN_PHY quirk flag
    https://git.kernel.org/netdev/net-next/c/1d030cdd52ee
  - [net-next,v5,04/13] net: ethernet: oa_tc6: Export the C45 access functions
    https://git.kernel.org/netdev/net-next/c/87ac7ea2153c
  - [net-next,v5,05/13] net: ethernet: oa_tc6: Export standard defined registers
    https://git.kernel.org/netdev/net-next/c/9210d402bdf5
  - [net-next,v5,06/13] net: ethernet: oa_tc6: Add the OA_TC6_ prefix to standard registers
    https://git.kernel.org/netdev/net-next/c/31bc75f17c1f
  - [net-next,v5,07/13] net: ethernet: oa_tc6: Add read_mms/write_mms register access functions
    https://git.kernel.org/netdev/net-next/c/6ad250179486
  - [net-next,v5,08/13] net: ethernet: oa_tc6: Use the read_mms/write_mms functions for C45
    https://git.kernel.org/netdev/net-next/c/92ec8d69ddb0
  - [net-next,v5,09/13] net: ethernet: oa_tc6: Add new register address defines
    https://git.kernel.org/netdev/net-next/c/638b41f770ad
  - [net-next,v5,10/13] net: phy: add generic helpers for direct C45 MMD access
    https://git.kernel.org/netdev/net-next/c/aa63217916e1
  - [net-next,v5,11/13] net: phy: microchip-t1s: use generic C45 MMD access helpers
    https://git.kernel.org/netdev/net-next/c/85032df227f9
  - [net-next,v5,12/13] net: phy: Add support for the ADIN1140 PHY
    https://git.kernel.org/netdev/net-next/c/0feaf415b782
  - [net-next,v5,13/13] net: ethernet: adi: Add a driver for the ADIN1140 MACPHY
    https://git.kernel.org/netdev/net-next/c/20e69e671070

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


