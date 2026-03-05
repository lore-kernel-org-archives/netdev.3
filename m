Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFEF7262B;
	Thu,  5 Mar 2026 03:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772679618; cv=none; b=EH8S60jwe5scVExL19lRHSq0RlFsBMTPF4joJmIPsbMYvc8TUnCqot83aoOIRqMoDLCeNgQwzu0PopprKUF6k8EUCdxhFOpOleExedeKYzGXrgdAlg5ca5t1CRN2yUqIaaf/C+B6FORa4hNxpGxXh41BoNJKxyJudM24Fteljs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772679618; c=relaxed/simple;
	bh=Bkpct6yR5Nu70vvQgvrn4i0t7yPP3oct2zteI0VdOsE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tJkfDOev4eDQ0zpANvHC090RGoB7ooa+FOEnCop+wqFUCcbpwoIIoC9RYeDGPeYeReCkiOtBhOd0VXhMJm7ZgTJRaUU5kJIeNwC1U6JpP9Go8kX0OSRnFYgCo29ZoUcEb440XnzGndoivp4HDj67hEvlaxyJmFMgoPPjbwQCY6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJDsHmhq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJDsHmhq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80C2C4CEF7;
	Thu,  5 Mar 2026 03:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772679617;
	bh=Bkpct6yR5Nu70vvQgvrn4i0t7yPP3oct2zteI0VdOsE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vJDsHmhqxjromjps4MR823tr5dZRp48M3iGSkFg/mD4+ox6gxt3mjHEBRywHYko7C
	 JH7WO2WB/gkqm64qyrUR5QAa4Ba2mUx6PpJ2IcnnrRVcul+0KNqhlCJMAli1HzeM46
	 msIaWcVRw6HC2XjWaai+tdQjsK2TBvin8RSRgsbzCX0Lnl/qaReIIChp/DO8c7c0WM
	 anjhVqasOo/cpZVnQaHv3AOjr16GKDXMNWAIWqOXqoPw4173Bku29WE9mKp+lxbKnn
	 UUE/uBdq+fdneJr61ZAnhguj7IzZA0MZqxIFg25ZQZl1e4v56NnwpTUhae8Uv4QZov
	 q+JwPRnQtJQgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEBF3808200;
	Thu,  5 Mar 2026 03:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] dibs: change dibs_class to a const struct
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177267961829.2494418.7813630752818606156.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 03:00:18 +0000
References: <20260303163104.3749311-1-jkoolstra@xs4all.nl>
In-Reply-To: <20260303163104.3749311-1-jkoolstra@xs4all.nl>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: wintera@linux.ibm.com, gregkh@linuxfoundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Mar 2026 17:31:04 +0100 you wrote:
> The class_create() call has been deprecated in favor of class_register()
> as the driver core now allows for a struct class to be in read-only
> memory. Change dibs_class to be a const struct class and drop the
> class_create() call.
> 
> Link: https://lore.kernel.org/all/2023040244-duffel-pushpin-f738@gregkh/
> 
> [...]

Here is the summary with links:
  - [v2] dibs: change dibs_class to a const struct
    https://git.kernel.org/netdev/net-next/c/ad3dfa80be76

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


