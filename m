Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC96379EE7;
	Thu, 25 Jun 2026 02:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782355233; cv=none; b=OZR1UFg89Ap2ZElCqW7w5+o2HK5kvdQgUnAJJgDOj7ChKO3QLVxmonwirCrfA1TyZnrSIgoYFom0pRVGmsriDT2GuAIj5jmYIJyygkW3/qgeXIyPHkBljXmqadNMcGbagw0hx6dt2gXKZlCnkf2tS28z4Ol2CswCKwQuHsWYhiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782355233; c=relaxed/simple;
	bh=uAQZzIfbwtFY5HNVfNjZueCqi/eEGnEJlGFf1d1vPhc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=naEl6xxQPcwAl0u6CoCp+Z0/NX1D1Vk650WLVXQcj1ruBqBZF6BkdM+w0bBTKG2ltqKRcDiedl4OkBu2V3TcrUWE9/tFcw2FHXlamKuuD0NhVkEQVn5pS1v+7EhFYYS3/sHOL1M0+tDtDC2zG/Q2jQvygH2i2nB/BhZcr7DP0ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fhh56fqT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fhh56fqT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D851F000E9;
	Thu, 25 Jun 2026 02:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782355232;
	bh=xyAPI4p0/MTTG/aGrzMpxqG01cR4hkSNRrdo/rcgw0k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Fhh56fqTKqidCRn6VypRYY7ASeRw1bn00oziepAsDsPYjoP1U1bUNogCxceT93+Gu
	 fSdPPT3ugovEM+OTuvIgwJU3P85hezj9YkYNjXN0P7uS7trovOdu4slUeKtA08rnfZ
	 nyKLSG1WBj44AvLvoS0sJHufJ5fsk00ogufZt6s9UHC9iKnEbPAyGX9HJUtXe7cLJm
	 bhiDfZsDUPf/20TFF0qGr7YXD8A66XTlNc3lutQa1dBNPD1nFWgrkwtF4e5Q2QCWtR
	 o5lxhdItAw2W0IU1UnLP+q/xZlbSo3QP+cvo4x1vEtUnvn3AplwHTR6s7+Uyje0SUi
	 h2N2bwEAf67xw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09993AAA6DE;
	Thu, 25 Jun 2026 02:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] net: ethernet: sunplus: spl2sw: fix of_node
 refcount leaks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178235522029.3091545.3009752981446571608.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jun 2026 02:40:20 +0000
References: <cover.1782195965.git.shitalkumar.gandhi@cambiumnetworks.com>
In-Reply-To: <cover.1782195965.git.shitalkumar.gandhi@cambiumnetworks.com>
To: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
Cc: wellslutw@gmail.com, kuba@kernel.org, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 shitalkumar.gandhi@cambiumnetworks.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Jun 2026 12:11:41 +0530 you wrote:
> This series fixes of_node refcount leaks in the Sunplus SP7021 ethernet
> driver, found by inspection. Compile-tested only; no SP7021 hardware
> available here.
> 
> Patch 1/2 fixes the phy_node leak in the remove path.
> Patch 2/2 fixes multiple leaks in the probe path and depends on the
> cleanup contract from patch 1/2.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] net: ethernet: sunplus: spl2sw: fix phy_node refcount leak in remove
    https://git.kernel.org/netdev/net/c/a9e29dcd8a84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


