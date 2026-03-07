Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D38F8F5B;
	Sat,  7 Mar 2026 00:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772844606; cv=none; b=F6peCUp/oOwpppRo5iRxnImHyq5kqshBaAyVae/KDOyY/OKbxgqyE+gBVLKE0RdEU43SrxAGamkJBrf8p04SNmtgB+fsZDv1wPGRftfONkKo0KN8FfVq15WMKy3RCzTHxyXDZ09++ap0Uk7z0PqzGK/GeZT+OYYWxOQ/wQBRUyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772844606; c=relaxed/simple;
	bh=VYNhHddUkadTBjPrn854/J4XbRiUp35JLJQ/ii80QJk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OA/CDpEtTMeRqPSNcZ44ViK2bjnd0vvdZDyHMS+yMeKeRde74iLVYqCjPiSSZKbLJp1NeDpNiMEJ5OetaV131kEQZnlQgVBX91BIpKpYYb5khFQMSAdElkmTHuweopwZhKYrXMvBB3F4W9O4HU7DredaW/eQNGS4bxOZMuzpmvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fELiJoDh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fELiJoDh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286E2C4CEF7;
	Sat,  7 Mar 2026 00:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772844606;
	bh=VYNhHddUkadTBjPrn854/J4XbRiUp35JLJQ/ii80QJk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fELiJoDhpVrvPe0sriinZZnGyPsvomN6FMPy4LWcofWD2975GI1aQ8HB3azBzQGIi
	 zZsl/2mFJwrNwDiJJ6OZx4q2UXhXqd8+8VTQzA5pnv0xIfYGJLgCv4xmDAVDSLOCcU
	 hEkrWQpQbrTQdFG4+jiqVUL4ndSKqXbvuypc/SA2WnobnBEmPdvIWWGA9jK515E1dp
	 pPSJktfo4qeWAle+OQThS+kzeS4I0a5L5A9Rdtac4zA+X9HThAiXSzsE3PCHnRKfbz
	 V8vz6I2KbJbpaO2I16JaPq2V6kyb5W7cchNyMYPJG0K7XKK8vcNJNv2T/KgXfVN4J7
	 a2CqrYIdwWRHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF593808200;
	Sat,  7 Mar 2026 00:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] qmi_wwan: allow max_mtu above hard_mtu to control
 rx_urb_size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177284460531.108926.2301984403623323782.git-patchwork-notify@kernel.org>
Date: Sat, 07 Mar 2026 00:50:05 +0000
References: <20260304134338.1785002-1-lvivier@redhat.com>
In-Reply-To: <20260304134338.1785002-1-lvivier@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: kuba@kernel.org, koen.vandeputte@citymesh.com, dnlplm@gmail.com,
 linux-kernel@vger.kernel.org, sbrivio@redhat.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Mar 2026 14:43:38 +0100 you wrote:
> Commit c7159e960f14 ("usbnet: limit max_mtu based on device's hard_mtu")
> capped net->max_mtu to the device's hard_mtu in usbnet_probe(). While
> this correctly prevents oversized packets on standard USB network
> devices, it breaks the qmi_wwan driver.
> 
> qmi_wwan relies on userspace (e.g. ModemManager) setting a large MTU on
> the wwan0 interface to configure rx_urb_size via usbnet_change_mtu().
> QMI modems negotiate USB transfer sizes of 16,383 or 32,767 bytes, and
> the USB receive buffers must be sized accordingly. With max_mtu capped
> to hard_mtu (~1500 bytes), userspace can no longer raise the MTU, the
> receive buffers remain small, and download speeds drop from >300 Mbps
> to ~0.8 Mbps.
> 
> [...]

Here is the summary with links:
  - [v2] qmi_wwan: allow max_mtu above hard_mtu to control rx_urb_size
    https://git.kernel.org/netdev/net/c/55f854dd5bdd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


