Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30EC3002A0;
	Sun, 12 Apr 2026 18:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776019835; cv=none; b=bLx1P8qNz/SSqZiUT2YE4b3++10brc3XFMtHN7hJ0W15rhfpByM+JBMhS5DvRBmrm8J4z1vD8xW7kU1jMettEs06177ziktQwhAWYPp61j8goHA0RQp0W7synmgIPzMpd9N5ynMSNoq6d9f3rs/UNvWQhNKuG+0O7j0J582mYKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776019835; c=relaxed/simple;
	bh=XZQSbBb5LbRcjoiNnudK08g6V4L7MM3ybDhs4WZKrmI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JlUb7BrwtjbRe/Rd/Sn5FqSl219+cA/PQKd+0njR83zAUiOKrnZayXiY+lUKjlq+Qyb4h19wTXLypxKtsj19K8flFz7CFWitsDh5dB7S6bhql1Xc4iXwwqmTaAaNecCaZK8d1vLRnrRV3Uc3fQ950M2Ky96aIzrjGY0p6+AjWXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jocta8b0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jocta8b0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C940C19425;
	Sun, 12 Apr 2026 18:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776019835;
	bh=XZQSbBb5LbRcjoiNnudK08g6V4L7MM3ybDhs4WZKrmI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Jocta8b0rmiZFq0OvxaIgEkbv4sSCD7VcUhi53tC1/+/LP/DSmRLpvn2JVW0semdg
	 cmGFiOG2fPeYSK8Oi9ugXX14v8Ymqn1tqGeA/Dse8Lv292VT1aRCM+px9YqqERzl90
	 C6rxeae5nquVGsOVj2fNVzMu3teo+rganhLFXGh1leZj5rdKEUhbJIOnryCp2bz7Zn
	 vOGAAs9nhz3ed8KKDpWlud0ZMKYAc5ffAjZZ/XNnHpjpq5vv1Kl/9u1bMugO7EIlrr
	 1r+g1qlhd0qPPzsENXdZfyRI0caWOTyExAqQqDR3W3nJUzKzAa4nlZADaK/ThZ4wzU
	 gRB+nuf7b5Mdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02BBE3809A8C;
	Sun, 12 Apr 2026 18:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] NFC: digital: Bounds check NFC-A cascade depth in
 SDD
 response handler
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177601980781.3374222.6057687328543830144.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 18:50:07 +0000
References: <2026040913-figure-seducing-bd3f@gregkh>
In-Reply-To: <2026040913-figure-seducing-bd3f@gregkh>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kees@kernel.org, thierry.escande@linux.intel.com, sameo@linux.intel.com,
 stable@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 Apr 2026 17:18:14 +0200 you wrote:
> The NFC-A anti-collision cascade in digital_in_recv_sdd_res() appends 3
> or 4 bytes to target->nfcid1 on each round, but the number of cascade
> rounds is controlled entirely by the peer device.  The peer sets the
> cascade tag in the SDD_RES (deciding 3 vs 4 bytes) and the
> cascade-incomplete bit in the SEL_RES (deciding whether another round
> follows).
> 
> [...]

Here is the summary with links:
  - [net,1/2] NFC: digital: Bounds check NFC-A cascade depth in SDD response handler
    https://git.kernel.org/netdev/net/c/46ce8be2ced3
  - [net,2/2] NFC: digital: Bounds check Felica response before sensf_res memcpy
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


