Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352808;
	b=ozJuHHMEUCTmkMKp/MLr793B8ylY7fEwGs6YFK315cSCbW8dUJ8Uu+IgkUuyyDVm7CuV
	 5vbpMplYJtUZb6ZgxtFyYFOMXVZWuVOQLZzYn/ZE28GJUXsrPKap96ley2DRn/ZXIIVFY
	 X+JYYwOWLcztFnB96CQtOv+lvvyb3j3TAXzgMBYoeHpsTR6LdwdFnGIrhBZASt2mUL5EU
	 SZacs74ctdkNNYWTQ6oOHYJzw9NKy03Uxeu1mki6xyZOKQC8uymDuqH5q/Fdxl5Sb3Msg
	 WJbw5j3oQgNL/GfwMmSCjCA1hvycdUCAWwVj109tY4N+p2xoTfSNfDhYKC2nq4PJ0aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352808;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=XEP6ocZvL9ys5RIqSXCixODEf8oZBXKHCkfuVpPFBfg=;
	b=e5gQzJavI+AtWTsrnhhgGjRjBfBK7D/MPzhkDdWpsSibPpe8/3vQFRK2FEECIB+v7+zs
	 p2OY6mLqQw9wcXbekDKYJYiekGunqGpHoVxsWSu74oGeXRq8pJ8UD89mqSniezVFNqftv
	 8fR9zcKZoWCiBzp7GBUuxdeuHU85kMYJ53RG2+qpbv4aIhfWtdBZ+KWJh5stqy19m+wwr
	 q+3A2W5leafqB+63UG6a6zNv7HEIUF7klD4vFzg0DdoDJHtJZ92LbBxVy+Enr1vi5kiN6
	 /xZj446XGyGmf5idXhB+Fp6tk8UVU8CKqFYs2YYg63JfQdjAIjf/lGil/ZPmYQBBp4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SVEFk3xA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154E0606A330;
	Tue, 10 Nov 2026 23:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SVEFk3xA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24561F0093D;
	Tue, 10 Nov 2026 23:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794352807;
	bh=XEP6ocZvL9ys5RIqSXCixODEf8oZBXKHCkfuVpPFBfg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SVEFk3xA6q78Cx6OyUgnpm/1B8AeilaXOPf9WTbNpMlm3iHtmIPSlbDhrXRkyHWGA
	 B6ORQf2L9yQ/+Lkm7hRvoUMuYkAArMl/kxq0WteO6l72be6sOBmHCpMOPMGowQ7VJO
	 Daw31fVLvynYvUfVhLdvgd8psGVomCHiHUfC81Zco9W3sgMvVNtkVlb4jQsSx+rZjM
	 0ORPrq/fzSwRnIQ9SaesG36i/SrGRL4PWaBF6rUEPqDnZXK/HcdwCjDUB/YK7nqRkI
	 CQt9SmE1JdDNMR8YndkIoYnc5rgPTvwmlXkfHWkH1k9PHx0F6bkmNrLakkqa1xUHGO
	 WxmiN6gHW4u0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D819939E8A40;
	Tue, 10 Nov 2026 23:20:07 +0000 (UTC)
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
Subject: Re: [PATCH net-next v1] ptp: kvm: x86: Leak clock_pair page if
 changing
 its encryption fails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179435280642.110597.5760305396342479169.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 23:20:06 +0000
References: <20261105164324.23501-2-oss.patchbox@gmail.com>
In-Reply-To: <20261105164324.23501-2-oss.patchbox@gmail.com>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 jpiotrowski@linux.microsoft.com, netdev@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Nov 2026 11:43:08 -0500 you wrote:
> In a confidential guest, kvm_arch_ptp_init() shares the clock_pair page
> with the host using set_memory_decrypted(), and kvm_arch_ptp_exit()
> makes it private again with set_memory_encrypted() before freeing it.
> 
> The untrusted host can make either call fail and leave the page shared.
> Both paths still free the page: the init error path with __free_page(),
> and kvm_arch_ptp_exit() after only a WARN_ON(). The page allocator can
> then hand a page the host can still access to an unrelated user.
> 
> [...]

Here is the summary with links:
  - [net-next,v1] ptp: kvm: x86: Leak clock_pair page if changing its encryption fails
    https://git.kernel.org/netdev/net/c/6a01fb125ba6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


