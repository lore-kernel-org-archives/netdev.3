Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D030D3C0619
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 20:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786738254; cv=none; b=Whu/bePFdpOroXtHPhjz8TdVCbztAVf7g5SwvuMrZKsnfOnZGwN0De3AGbZVyp7v+fPLq6MXO1PxTfw1PtOv40+YS5AocjK3n3ZxVhpUnjjUmvF384I1vqS9r8jjOHYzS3jVbUzdx56sRYq5tZE9JCWUHqL5xADYqJaDdSNsqO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786738254; c=relaxed/simple;
	bh=1bzxb9qJHFKKK9er7USAB95hrkuB2XjthksqqBONPjM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j36N/6UPGzx1HBhEMU/T2ZwC/GDRvGicft3RbwSVKw6wPNcjyePzJ4cemEqKozbbV7DlDwAOCI9sL0W2HM7ws8VTmIXo6NuOFrifhol7S/xm/hrHmPetf6YivbellEpBMPx4yZobK8BzzFhJYI/CqThO9uJjYd0sDKqq9j8J5Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5LT7/FZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5LT7/FZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC3E1F000E9;
	Fri, 14 Aug 2026 20:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786738251;
	bh=u5JsqoFJbnJQCq+WE1mKAHT/3lMeKVwXtya7ujYh3yw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=W5LT7/FZ6lZ07/N/REReDDfvxfv8iGEArK8jBQHW6Fw13X2Nh63Tb9w9eO6H23oUL
	 YdeFPCIGST+f0byZ/Y96gRFWa94pXtsceRTCV47kgt76vwfiKT1V2LvtwNmONJvrzl
	 5Rw1FLo0RswVbs2sTcunUbT4sDFZqXMMRj6rqvVgqBMe1hUcm4hstmzcYxl+DusSLl
	 FnHtqG8SMfm7063Hp4foYAe4PIRUEKTyV/EyqrLchnWOssWpnnBtzZ+N0LeQ9QH9uy
	 5NNoAkCs47MzXSK7hwWDxsltARhk0pCzgLxHFeKwoLIU48KfWj9oekdCt4mbmrwq8W
	 +yBi3o4W92s4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09BD392445C;
	Fri, 14 Aug 2026 20:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net-next] gre: fix ERSPAN o_flags race/corruption in
 xmit
 and fill_info
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178673820545.3942175.10731267597939666545.git-patchwork-notify@kernel.org>
Date: Fri, 14 Aug 2026 20:10:05 +0000
References: <20260812142257.21283-1-edumazet@google.com>
In-Reply-To: <20260812142257.21283-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 idosch@nvidia.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Aug 2026 14:22:57 +0000 you wrote:
> For IPv4 ERSPAN:
> In erspan_xmit(), the driver clears IP_TUNNEL_SEQ_BIT (for version 0)
> and IP_TUNNEL_KEY_BIT directly in the shared tunnel->parms.o_flags
> structure. Since transmit paths can run locklessly and concurrently,
> this leads to a data race.
> 
> Furthermore, modifying tunnel->parms.o_flags permanently alters the
> tunnel configuration. To work around this, erspan_fill_info() (which
> reports config to userspace) was setting IP_TUNNEL_KEY_BIT back. If
> erspan_fill_info (running under RTNL) and erspan_xmit (running locklessly)
> race, erspan_xmit might see IP_TUNNEL_KEY_BIT set when it shouldn't,
> leading to GRE header corruption (injecting a key field into the ERSPAN
> GRE header).
> 
> [...]

Here is the summary with links:
  - [v4,net-next] gre: fix ERSPAN o_flags race/corruption in xmit and fill_info
    https://git.kernel.org/netdev/net-next/c/9958e69b9893

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


