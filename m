Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ECF48124C;
	Thu,  6 Aug 2026 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031486; cv=none; b=qvQPEombxDV1+o9XxPbdDfKvksB7NUONWSz+N+kGGI9sAhdXujI3iccc/JjMIbluDlf/VGQLezw3246LPdk8YLlrFA5VE3p3O13y7UW2dB5WLVaa9rM/c4AWaqc8Ub+WC/DJzPGQXp+PgPUbRzvCbjSxTBmrmuj06Z6aKq14v/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031486; c=relaxed/simple;
	bh=LTeBTJZVMNeLuKfnbWdRW00Q2nzUiS208s/hkkaQb7s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VOL8iCMyoi48ai35BpUwBIo9qmCSPW59m1lVd2qmJA1Ya/K8kNfzQT80aAjlfeDiHc++lPXyYj7yU2MhuRShSerkQ19IyuvyaLnQp5TImX3ng24al8bvrQRXmwuePqEp2z7kBN54j81mayvnV7+c2VnyF1UB43zLqvM1vMFYnvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDalHrCe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDalHrCe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF1A1F000E9;
	Thu,  6 Aug 2026 15:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786031472;
	bh=buIkHRqAeOLsU1/xJ1eTmlG4oKCdiatFh2CGh3O1NV0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VDalHrCe3X1jxn3bTy+3rWBR2sq8C6tsR+wISICkV8Owd1DO8SHqWgjer+Ec5M20V
	 0XtzU+WtuuVqyKy/ZQf2NKQb3qg0VtDKzDb772jcw/YwVt9xdpI7jsSFLdpzlyh4fX
	 bUJsCISCEcR38B5GPvjLFaanTTxbx3sUfpFUxDLo+gCmLojBMwykXU3fa7397Eupe8
	 i+YX6P1WhuIgbq1tiBoErNE65fRfe+aAUzsNWr+i1KUWJLeZ/xaIlbFUjiTtUkREug
	 Dp9gA9nvo0vL/sFjARMpZ++tfcrItzX1JoDCxrzp4jupvZ0wT3ObNY1YR/sxQnu8ub
	 dvzA/ogNeDLgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939AD380820D;
	Thu,  6 Aug 2026 15:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] usb: atm: cxacru: fix use-after-free in
 cxacru_poll_status
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178603143113.1348318.14998950498221674047.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 15:50:31 +0000
References: <20260803101716.2592486-1-khiemtranzo532001@gmail.com>
In-Reply-To: <20260803101716.2592486-1-khiemtranzo532001@gmail.com>
To: Nguyen Quang Le Kien <khiemtranzo532001@gmail.com>
Cc: 3chas3@gmail.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-atm-general@lists.sourceforge.net,
 accessrunner-general@lists.sourceforge.net,
 syzbot+24eb38c789655fc43663@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Aug 2026 18:17:16 +0800 you wrote:
> In cxacru_unbind(), cancel_delayed_work_sync() was conditionally skipped
> when poll_state was CXPOLL_STOPPED. However, a work item previously
> scheduled when poll_state was CXPOLL_POLLING may still be pending in the
> workqueue at the time poll_state transitions to CXPOLL_STOPPED. Skipping
> cancel_delayed_work_sync() in this case allows the work to fire after
> cxacru_data is freed, causing a use-after-free when cxacru_poll_status()
> attempts to acquire instance->poll_state_serialize.
> 
> [...]

Here is the summary with links:
  - usb: atm: cxacru: fix use-after-free in cxacru_poll_status
    https://git.kernel.org/netdev/net-next/c/b5b02ce65777

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


