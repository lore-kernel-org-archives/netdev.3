Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1698D289E06;
	Thu, 26 Mar 2026 22:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774564496; cv=none; b=VDsZYuGhn+GJrs0ulPd5eY8wi03iq5cJE4iRhlCGZ9Jy/bSAsYxB2i+qntzUSmvnPLDPX3pSXrEmXuQOOKgY1bnliCwotNkk4VZzkehdHgboLdBRy/i0DboYW64PoZKejrJ3MU3dOPaoTIPteb+cz00sCvvWobEzKf2ULhkQbbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774564496; c=relaxed/simple;
	bh=MxHDtTznA2L25ZOX4m9N69sWaylJb9vOoxvSdXFKUNU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WDAt2KCVs7LpbO19YUSaH5U22nc5wTdjzXX33ez8GG8GTutGAn2JapOKg8fI7cO7tH5pYtg0rVJAlHAD7FNyyhT5n7V/HGpKLRE6DmwCo7GA8NnXH88jvG1yPMT+/iO9j9OUR3UC921PJ3Zpy7gdsuL+HoOI6j2+2/Os2FHcmnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HabURJEM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HabURJEM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB24C116C6;
	Thu, 26 Mar 2026 22:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774564495;
	bh=MxHDtTznA2L25ZOX4m9N69sWaylJb9vOoxvSdXFKUNU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HabURJEMeTG2zVxpgmDhZORdjDRzsLAtVTZoFbiPKj/IVEZEE62eAmjWDTVxvhQmu
	 gHbXT5UIfUNow8/PbIO+io6V6G/s22lcFLC4FIr55Gjvingg2FjHfNXZs+q63/mH4m
	 UHwyTUJNp3ARd9OYLLnjMskBFKupLgMxULApTmubmHx66/MKwAkynWWZeEe0bSaZ2E
	 s+ZLXHsvpKCMiAjvDvGApSMq0WPGHRBLvVgsy5k+vxjlGp9T04/I7o0RGcSoEO0TUs
	 zWbuf8H2f3aTt8bMtxZNqyF8tu5slbhXtRiw3nbhw+tDTIIboUJNuBIm8lG+5/uXfj
	 dcCofUqeyJ3iQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 401ED39F280C;
	Thu, 26 Mar 2026 22:34:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/6] TLS read_sock performance scalability
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177456448204.3204879.2354320105926934951.git-patchwork-notify@kernel.org>
Date: Thu, 26 Mar 2026 22:34:42 +0000
References: <20260326-tls-read-sock-v6-0-fd887b9e7f06@oracle.com>
In-Reply-To: <20260326-tls-read-sock-v6-0-fd887b9e7f06@oracle.com>
To: Chuck Lever <cel@kernel.org>
Cc: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
 netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
 chuck.lever@oracle.com, hare@suse.de, alistair.francis@wdc.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 26 Mar 2026 09:50:45 -0400 you wrote:
> I'd like to encourage in-kernel kTLS consumers (i.e., NFS and
> NVMe/TCP) to coalesce on the use of read_sock. When I suggested
> this to Hannes, he reported a number of nagging performance
> scalability issues with read_sock. This series is an attempt to
> run these issues down and get them fixed before we convert the
> above sock_recvmsg consumers over to read_sock.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/6] tls: Purge async_hold in tls_decrypt_async_wait()
    https://git.kernel.org/netdev/net-next/c/84a8335d8300
  - [net-next,v6,2/6] tls: Abort the connection on decrypt failure
    (no matching commit)
  - [net-next,v6,3/6] tls: Fix dangling skb pointer in tls_sw_read_sock()
    (no matching commit)
  - [net-next,v6,4/6] tls: Factor tls_strp_msg_release() from tls_strp_msg_done()
    (no matching commit)
  - [net-next,v6,5/6] tls: Suppress spurious saved_data_ready on all receive paths
    (no matching commit)
  - [net-next,v6,6/6] tls: Flush backlog before waiting for a new record
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


