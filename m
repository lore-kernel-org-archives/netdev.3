Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1E31F94F;
	Fri, 31 Jul 2026 00:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785456661; cv=none; b=PsiO4rdj+BQh9Zh6fia9TWFNMSBn9EyDKPKg9Kdevv9kv9amUUuxKvGG4xoBPbLGOLXj+HEH0kggQnSWVu3fYKunJrEeSljQT80PShzrgNj5AiWmJxBKckDNLMVS6RSw5cZr3DPA7nr5dXmS9C6q8PIFScNe9903zYLbVt4vUa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785456661; c=relaxed/simple;
	bh=/hHRkrolH7NR/UnTEWPTp77ACrE2b4EVpLAqqE3Qk6M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hf8psMkcLWj/PsFt8vXjx/r8tkTTMTjjHyhCB5VT6QKW+BKFlKiRoFk65AwI9j6/+dej9e/7GxUEZHlb1mnqlWUY2DZUHgaDSMIiOYbbnphP/JyobgnubdrxpwScF9/X3gev/IpgzeDccDInAs7eCgLtSbk1zZA0luUdBQzUOpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hokzcHBB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hokzcHBB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78701F000E9;
	Fri, 31 Jul 2026 00:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785456659;
	bh=b/gPFD4zLfqwpWnEZ/O6iu2gr5FMA5LCdr7EKi1mAlM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hokzcHBB5HbnjY5pmOvgrQ4Ybt/+Ro3Zd7GiyXxkcx8NOBmhjmKGlxT+RV4kBci2c
	 NsY/1pIzf0tYA0PB6fm5T05+AKyBngwyoGE7lNfQqFl76jqN7SK8xk1cuUgZF8BnIe
	 +R+KDY2n4wEJO2htPji/KRgQRI+seVQFfgb4zILGhTVFpMJlGyuVyJ3JNFWtbm4Icy
	 CVjDQgmJIuRwrTudWCiXtYiHTYYm46TTsuedFa4xQekLBXylozWGrs9fWpgInjTLiS
	 NYZUI4iz59v4FltCd6fDiClkmwCFKtGMlL+/XmEdfqjOpJRGT9iGI2bZ+I3e6bCyTA
	 zlbbk9XQP/TNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568F93924472;
	Fri, 31 Jul 2026 00:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 00/12] net: mctp: usb: Add support for
 MCTP-over-USB v1.1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178545662289.51892.16997798956064212480.git-patchwork-notify@kernel.org>
Date: Fri, 31 Jul 2026 00:10:22 +0000
References: <20260724-dev-mctp-usb-1-1-v5-0-e66bbba0dbdc@codeconstruct.com.au>
In-Reply-To: 
 <20260724-dev-mctp-usb-1-1-v5-0-e66bbba0dbdc@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: matt@codeconstruct.com.au, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 gregkh@linuxfoundation.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 24 Jul 2026 13:15:21 +0800 you wrote:
> Version 1.1.0 of DSP0283 (MCTP over USB transport binding) has been
> released, this patch series updates our current v1.0.1 support for the
> changes in v1.1.x.
> 
> The major change in v1.1 is the introduction of "packet spanning" mode,
> where a single MCTP packet may be split over multiple USB packets
> (themselves forming a single USB bulk transfer). This relaxes the
> requirement for USB high-speed mode, as we can now send MCTP packets
> contained over multiple 64-byte full-speed USB bulk transfers, and gives
> us an increase in the maximum MCTP packet size - we now have 13 bits of
> packet length (previously 8) in the transport header.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,01/12] net: mctp: usb: Include version indicator in max packet size defines
    https://git.kernel.org/netdev/net-next/c/2f2e974f8fbe
  - [net-next,v5,02/12] net: mctp: usb: Use packet-length max for maximum packet-size check
    https://git.kernel.org/netdev/net-next/c/05b1a3a5eeaa
  - [net-next,v5,03/12] net: mctp: usblib: Move RX transfer processing to a new mctp-usblib
    https://git.kernel.org/netdev/net-next/c/b8564b19c0ff
  - [net-next,v5,04/12] net: mctp: usb: Improve IN endpoint status handling
    https://git.kernel.org/netdev/net-next/c/9f66be014070
  - [net-next,v5,05/12] net: mctp: usblib: Move TX transfer processing to mctp-usblib
    https://git.kernel.org/netdev/net-next/c/aadf5ed03e85
  - [net-next,v5,06/12] net: mctp: usblib: Add support for multi-packet transmit
    https://git.kernel.org/netdev/net-next/c/76a58ffd7417
  - [net-next,v5,07/12] net: mctp: usb: Accommodate DSP0283 v1.1 header format
    https://git.kernel.org/netdev/net-next/c/f5bf226f3c7a
  - [net-next,v5,08/12] net: mctp: usblib: Implement receive-side packet spanning
    https://git.kernel.org/netdev/net-next/c/d52fc7f09a18
  - [net-next,v5,09/12] net: mctp: usblib: Implement transmit-side packet spanning
    https://git.kernel.org/netdev/net-next/c/081ac93ca99c
  - [net-next,v5,10/12] net: mctp: usblib: Add initial kunit tests
    https://git.kernel.org/netdev/net-next/c/e84c0edbc41a
  - [net-next,v5,11/12] net: mctp: usb: enable v1.1 packet spanning
    https://git.kernel.org/netdev/net-next/c/b4a27a474b51
  - [net-next,v5,12/12] net: mctp: usb: Allow multiple urbs in flight
    https://git.kernel.org/netdev/net-next/c/88dbfe0d9581

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


