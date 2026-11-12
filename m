Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794448808;
	b=SY6sN0l6TyWkoKSWmNsTF4/W538Y8uyTbdv6EN3Aa3tGWpFCd7Xpy88hn9n/9iqUd7tM
	 9Dy0wPkG5joQMjcskop7s00VkgTWUBFWgjsP6lqADkdxW/Eo0SUYMUOH5d9ZOiCineuSe
	 4ee1Z6nXfN54tdBm3mpwf8tkl3J+DtUY0QEXPC2X+CHaUJywVgOp8LpfhkAqnrIBo6FYX
	 0QfYS8OIb8S6ehK0vkb0QiJAjtGw8RNrumWFVm8PP+7xVG2a0x7tiTDMzO+8Df8xIZtdA
	 H4n2f6tdlV/Tz+Enye636pJhIzQ0ji60H0SpvL1JYrCvQWmKiqq8kTBmG1HdoCZUMHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794448808;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=TCRfyxHtM7gWIieAFsQRUzzBSJgM17kQTHPB2Hu1iOs=;
	b=1D0TF4apCpnjJN7MeFfwN2Z0xiOzm3n82/fLG8lk2pCTG5bapCAXgmNmseaVVmh9mG/W
	 9Dz9IXTb+1QGx9z3saT5Lrze7zLrkI3juvkgBfRJ4tcmjM9kyADLHPbsGbs0dcgTHbGaZ
	 Ont3ACtGLR3uhZlXJF8SKrWA32SYc7Ue2aUk2iszzfqU9lRlN571eBJDX2NbBvOAKi29g
	 LximK58vFUZPpOsNMfW9mxu99O1h5/HhYtzO+A89huB63n7bcwOHTmizCs5ngu3EjTk5F
	 SsErH98tLO6p7fjm+LRqTz4mzo6l/pmDQKrevBE1xaMoA0PTIpBT3Uy0TUWeEWWQ0wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CQPzrCau;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688F3606A323;
	Thu, 12 Nov 2026 02:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CQPzrCau
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67C91F00A05;
	Thu, 12 Nov 2026 02:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794448808;
	bh=TCRfyxHtM7gWIieAFsQRUzzBSJgM17kQTHPB2Hu1iOs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CQPzrCauYk1gS86uv74QwbX+ugone0X6LWe7bEpPNMoRJeKKt3NhJUtZLLwOs+fN3
	 NdEuynPzBwssC17dv6rQpBaYyvxfL0MknHWoGmsZlbi1GILHtsiK9dsioXxUTzISQi
	 JQbgSPIK7pftO9sxaakiMITlhaqPpW4rxO/tm5HKgmPRlzW6tGPTHb2ciEURHPPODm
	 0Fwml7Ek/hCFcEub4NjxF8jea1V+WnEdyNnNPTg9Kd7uo+Ai7wvlzylFfb8JsKAHTA
	 bHnmjI5NJRvXW3kN902T9w0VMzZRIN6VhrLB5hzI+2SYo/a93UIz/Qfh9oUpSM4Icw
	 L2YF71zXcoOEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D81E1391AFD2;
	Thu, 12 Nov 2026 02:00:07 +0000 (UTC)
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
Subject: Re: [PATCH net-next] ptp: ocp: replace __get_free_page() with
 kmalloc()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179444880643.1768068.10714270723125429493.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 02:00:06 +0000
References: <20261108-b4-ptp-v1-1-71160700886f@kernel.org>
In-Reply-To: <20261108-b4-ptp-v1-1-71160700886f@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: vadim.fedorenko@linux.dev, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, david@kernel.org, vbabka@kernel.org,
 linux-mm@kvack.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 08 Nov 2026 10:40:36 +0200 you wrote:
> ptp_ocp_summary_show() allocates a temporary buffer for formatting
> PTP OCP device summary information.
> 
> This buffer can be allocated with kmalloc() as there's nothing special
> about it to go directly to the page allocator.
> 
> kmalloc() provides a better API that does not require ugly casts and
> kfree() does not need to know the size of the freed object.
> 
> [...]

Here is the summary with links:
  - [net-next] ptp: ocp: replace __get_free_page() with kmalloc()
    https://git.kernel.org/netdev/net-next/c/c88fd6989aea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


