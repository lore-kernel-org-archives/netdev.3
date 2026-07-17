Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AB0384242;
	Fri, 17 Jul 2026 10:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784283034; cv=none; b=A8+neSHG2mUtYNBl/GsQstwDTdBveHbD6RAomrzfdAOeUyH5t0114+Ut5cS7LI7ggCOI2aSDyGKYpbderu0jeYhgBx1S/v+RjV79OQdRW5BNkFzPL3oNDMJX1FeYG+8QUHKSLnSbwtbTitx9E1+DQI+CXLtr9/Ha1dnJCYLoT3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784283034; c=relaxed/simple;
	bh=8Wp0CYZiB2FAmeT8YPH90YFSg4NL37DLNKouBV8O8eE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZTva5v1Yd0m0n1OwtPiy1AJxypaOW4Amy2B8f6mVB3Hgjbp/k9L27yl8E/+pvGMYLRQYhutsskOY715kqJ+OTPnHmbTU7/mVv5kFkLS47R+jYpma3kZGcF2h3yvDZzu1s6ALbuZqSran+eEM4lPsWkAwz0nRuHx1MWzkgajplT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6xWCdbf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6xWCdbf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5269B1F000E9;
	Fri, 17 Jul 2026 10:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784283033;
	bh=hmTOGqHIzerCTbmkHCTGd2OWMYhxk/9wpEaoEu1xzLo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Z6xWCdbfKrqMCkbgTGPrNHsHt1BNJ7gGSSIlqne+TuyBu51ZoVsYDTEGuXSIGih6p
	 uMiznNMYAw3lbgEHLidBrQxTb/gTDlcqHSNsYXpn2/p3E4ss4F1JTq3C/wyrf+B2+j
	 SY8IxFzbnE9Bw7QngwBxPOYgYLAzlsgMIHIPxQanDUUHsHm/6C9qrOYLM6xsHVquUh
	 aiwXmwMjSihAotc4r5ZTYlMc4r7AgLQW2kMabIG7Gewh13xXiAly5GuK50iKAUHR7B
	 9Tlm4dxQEr3v0GFroV6/AuyitZc7qykmCoNpGvUjckARD97tyx4OejgthwQaxkj/4S
	 Yv6gu4WfgMd6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19852380CED1;
	Fri, 17 Jul 2026 10:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] dpll: fix NULL pointer dereference in
 dpll_msg_add_pin_ref_sync()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178428300580.1646936.7009191466298129305.git-patchwork-notify@kernel.org>
Date: Fri, 17 Jul 2026 10:10:05 +0000
References: <20260710193625.1378822-1-ivecera@redhat.com>
In-Reply-To: <20260710193625.1378822-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 przemyslaw.kitszel@intel.com, milena.olech@intel.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 10 Jul 2026 21:36:25 +0200 you wrote:
> When a dpll_pin is shared across multiple dpll_device instances and
> those devices are being unregistered (e.g. during driver module removal),
> a NULL pointer dereference can occur in dpll_msg_add_pin_ref_sync().
> 
> This happens under the following conditions:
>  - A pin is registered with two or more dpll devices (dpll_A, dpll_B)
>  - The pin has ref_sync pairs with other pins
>  - During unregistration of dpll_A's pins, a ref_sync partner pin is
>    unregistered first, removing it from dpll_A->pin_refs
>  - But since the partner pin is still registered with dpll_B, its
>    dpll_refs is not empty, so dpll_pin_ref_sync_pair_del() does NOT
>    run and the partner stays in the pin's ref_sync_pins xarray
>  - When the pin itself is then unregistered from dpll_A, the delete
>    notification calls dpll_msg_add_pin_ref_sync() which finds the
>    partner in ref_sync_pins, passes dpll_pin_available() (partner is
>    still registered with dpll_B), but dpll_pin_on_dpll_priv(dpll_A,
>    partner) returns NULL because partner was already removed from
>    dpll_A->pin_refs
>  - The NULL priv pointer is passed to the driver's ref_sync_get
>    callback, which dereferences it
> 
> [...]

Here is the summary with links:
  - [net] dpll: fix NULL pointer dereference in dpll_msg_add_pin_ref_sync()
    https://git.kernel.org/netdev/net/c/d2e914a4a0d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


