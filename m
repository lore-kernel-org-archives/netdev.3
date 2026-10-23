Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792788007;
	b=VJVfCiq92ET4CMVkV/vAMyNlwTbWBg2X22TYjRPHloze8HdBhkk6/uCwkeoI7IUZjx5V
	 G3y2hJkwpeCmOu/hZsI5c0RswLok8GTCOBfyXi+Ou7VOk+gM3hRrVylPK5HcelZk6ix3O
	 XLt5PYK68rKOir3onQc2mT3v7MgNP1dB4ZR9XABONdWrqlaWFp50jGtB8iCx+ZcSBQ2DQ
	 Tpqjz/zjMq4QHO4oVQcY8fhU0RDqCrvNEpAWM1i87o+pG/ZzjI6iQXMLk1LSNrV5fsTiK
	 RoAWRvHNiKw8whnaiv2App5mfDU5N+E1y6G9t0DshDTarDwa3wvtf0SnDOuTJxO/t9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792788007;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=iuOOiEMLU+sLE33/Aq0p23G5ffPpUrNZ0w4solTSpMg=;
	b=vVjmkOvruO5Fpcox93W79/QyZoAgPXuBsQhh4TioxiqNn4JtyZsb0gzw8eftA21DIwcn
	 IpOcclnrw+Z5iw/3OPwWLsaAmZbHDc7K29pXzGdVbcgaDxVkvHXUHBQ7RSr+XP6tWE5PU
	 KuoC7Q/zziU2lOOFRkhhUmO6+fFjkWwaQ7VCmokcVh6y5ykFSTYTVxcJcPeEV/Nh73mgf
	 75KadN9FMTLdJf5a8VxzavmX7IWlLFF2WUbVA8ufWoEGon/ZHK5A8iitsn3QK/72NPhTr
	 8Uk1UfXF3aBZ9ASQ9rfMHWk5oaf5N5vq2TXA9cWzVsxoiP8UJ8tvz/SPVr80mnbaYwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RUFewcHB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893D4606A31A;
	Fri, 23 Oct 2026 20:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RUFewcHB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1032A1F01828;
	Fri, 23 Oct 2026 20:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792788007;
	bh=iuOOiEMLU+sLE33/Aq0p23G5ffPpUrNZ0w4solTSpMg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RUFewcHBfKrqiFKyvJLD6mmPtHdc1yS04w7BFsstiEzMeVTEbOYyXL4uxg2EgvZvE
	 CQECmsnq7GbtoMAd+qJDjCjfPFO1B1pZxBMH0fXquPUR3WHH6dc2T0P9ozzDUeyOc3
	 EZRaPY66f5IKt/9YiR5ryOji84IjHDReJVdU54FLg5ys+JJzwdPlwu1TcyudIMailc
	 h8DB1n09eQedr8SNHrcJMrPqhDvqn/DtglB5HKylE4NKqMFCtTq9gfseKUCQZTulMr
	 8GrTtlFUU/89U3RJoJa21UvyhEumIJJfFTfHMIqLxDId+s/WUWeazMxn/Lwrw1CqD9
	 n8uNenQUB0gkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 07336391B155;
	Fri, 23 Oct 2026 20:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpts: fix support for
 PTP_EXTTS_REQUEST2 ioctl
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179278800557.1260786.6898503366524339849.git-patchwork-notify@kernel.org>
Date: Fri, 23 Oct 2026 20:40:05 +0000
References: <20261020003525.1237742-1-jjc@jclark.com>
In-Reply-To: <20261020003525.1237742-1-jjc@jclark.com>
To: James Clark <jjc@jclark.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 jacob.e.keller@intel.com, kory.maincent@bootlin.com, s-vadapalli@ti.com,
 c-vankar@ti.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Oct 2026 07:35:25 +0700 you wrote:
> Commit 7c571ac57d9d ("net: ptp: introduce .supported_extts_flags to
> ptp_clock_info") modified the PTP core to validate the supported flags
> of external timestamp requests, rather than relying on each driver to
> check them.
> 
> am65_cpts_extts_enable() ignores the flags, and am65-cpts was not given
> any .supported_extts_flags. Since PTP_EXTTS_REQUEST2 always implies
> PTP_STRICT_FLAGS, the core now rejects every PTP_EXTTS_REQUEST2 for this
> driver with -EOPNOTSUPP, where before that commit the same requests
> succeeded. Only the PTP_EXTTS_REQUEST ioctl still works.
> 
> [...]

Here is the summary with links:
  - [net] net: ethernet: ti: am65-cpts: fix support for PTP_EXTTS_REQUEST2 ioctl
    https://git.kernel.org/netdev/net/c/e3aaeebbef56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


