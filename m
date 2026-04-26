Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181E81F91D6
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777221129; cv=none; b=sPzGNbun2+cQXqHm+80HjVSYjPG1KWWGWJTfPmzxZLos0GIh1DU0Hh8O8Mcs0L/9I4Ios3+X2TvwK991HJFQ7p4PxRK4bXGLWbRdY+ge9+skdxs6zNWz6waIXGcf8yFfIBI1wIGSv/OAjoZyY++bob0rv9eQpfsRmOumF9usSDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777221129; c=relaxed/simple;
	bh=Eqd928PgLYkLsn5gsuqq5VK6ve1vB3BYX2oMNfsm/s0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JrNhaUr8FMBbBG12ACCwXzQm/DyuULhTmh81SI135hY+sQHWvPwxqvwMNC6CwRwuWixF/u2LF3QnfNZmujl0HcWLKGgQb04YccgCPC7Vck25njGwdvPpb90lALWCg58MQWhc6w1h30TUGHz7XBT6673EHyB41bzUkP8mFOkOoVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aO++4mo5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aO++4mo5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30942C2BCAF;
	Sun, 26 Apr 2026 16:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777221128;
	bh=Eqd928PgLYkLsn5gsuqq5VK6ve1vB3BYX2oMNfsm/s0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aO++4mo5gebvQTZ/Mk/o87+hK3X8vQ74hMDvNGE6y4ubj+YPzOCjlmN9O/swg6Y/I
	 jBhEq9Prb+Ji5rd5rjzwqJK2LuoUe/f1brWTZTPp+M9b2vSH0nRiNW69SQOMvBM1TM
	 zY6LrOFnjlk0vfhv1z3bPn3WrmfVYgHEVerptl1eHGcZ/cfPqJ89+oew/aZFS8E25/
	 Zz6qTCLmNXSlQyQkuAK5u9lkhS1vYgOyxTTg6GZOUI+YeOwzq2Tw/V6ravnH0pldf0
	 bwJ83aJRCFQ3eeYTsujYX3ohbMJ5OBFq+pTa9m2NrEbU5r5BI9i/BgzXvzN7Gj4zQv
	 KygtQM6EGzlyg==
Message-ID: <be39d955-5a66-4c84-aa4d-0b5244268287@kernel.org>
Date: Sun, 26 Apr 2026 10:32:07 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vrf: Fix a potential NPD when removing a port from a
 VRF
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, jiri@resnulli.us, andrew+netdev@lunn.ch,
 royenheart@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
 yuantan098@gmail.com
References: <20260423063607.1208202-1-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260423063607.1208202-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/23/26 12:36 AM, Ido Schimmel wrote:
> RCU readers that identified a net device as a VRF port using
> netif_is_l3_slave() assume that a subsequent call to
> netdev_master_upper_dev_get_rcu() will return a VRF device. They then
> continue to dereference its l3mdev operations.
> 
> This assumption is not always correct and can result in a NPD [1]. There
> is no RCU synchronization when removing a port from a VRF, so it is
> possible for an RCU reader to see a new master device (e.g., a bridge)
> that does not have l3mdev operations.
> 
> Fix by adding RCU synchronization after clearing the IFF_L3MDEV_SLAVE
> flag. Skip this synchronization when a net device is removed from a VRF
> as part of its deletion and when the VRF device itself is deleted. In
> the latter case an RCU grace period will pass by the time RTNL is
> released.
> 
> [1]
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> [...]
> RIP: 0010:l3mdev_fib_table_rcu (net/l3mdev/l3mdev.c:181)
> [...]
> Call Trace:
> <TASK>
> l3mdev_fib_table_by_index (net/l3mdev/l3mdev.c:201 net/l3mdev/l3mdev.c:189)
> __inet_bind (net/ipv4/af_inet.c:499 (discriminator 3))
> inet_bind_sk (net/ipv4/af_inet.c:469)
> __sys_bind (./include/linux/file.h:62 (discriminator 1) ./include/linux/file.h:83 (discriminator 1) net/socket.c:1951 (discriminator 1))
> __x64_sys_bind (net/socket.c:1969 (discriminator 1) net/socket.c:1967 (discriminator 1) net/socket.c:1967 (discriminator 1))
> do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
> entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> 
> Fixes: fdeea7be88b1 ("net: vrf: Set slave's private flag before linking")
> Reported-by: Haoze Xie <royenheart@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Closes: https://lore.kernel.org/netdev/20260419145332.3988923-1-n05ec@lzu.edu.cn/
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  drivers/net/vrf.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>

