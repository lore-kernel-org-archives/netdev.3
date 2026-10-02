Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBC42FE060;
	Fri,  2 Oct 2026 01:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790902809; cv=none; b=U0U7n2ziZb3PHmFadu5kWaaBzDsgwu+h1cw4jd0v7YMvf8+C6YvjTjpcsq6H9KvWRdvgE+jdLCtmSCYZTlpTdGqLLZVcDBjPW84O6+V+ova91zeQ2dfdkLV2C6EF+CXPJQdREXekDNEeAvCXgYwVZ+QrUfR8JNQmhnD+dp0mouo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790902809; c=relaxed/simple;
	bh=lEyx0kwiFwgyYo810DnJGuJBZvhi9Up84+v7pq5pfvA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Egt8fkK4EP9gcxXAhA4zoq0rIJNE7w2zFQQv6IPiq7wzNVvTFw2CTGqIWlg1am1LJNRx4J4qAmVSTZEvMhJa0pspD1o75twWP3vfbcNb50co35dSvox3lYTfsiC3vNBgPkTp30EXUkg4zuPBjK4laIBj53Nl/zaP/RaEBGDVDoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSoRVn29; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSoRVn29"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099C41F000FF;
	Fri,  2 Oct 2026 01:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790902807;
	bh=ZnXxGObpkvXlfwEbSPltHImHBXq+6ydBcb34kiXk3oI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SSoRVn29n6zBXcNp/xaGqHYDmExx1hbe+vA9XuNJjMgXdp57VHLBY3sXBAzb5t9uu
	 O1fqVIK/9Jyke7ZAk7ZA691AsYo+NdosvhtDj/hjtICxU4So4m6knUhnysOPCFE4O5
	 OBz8AX7gSxU4JZFwfvfMzevQ5wVg1yLov1wGh48/8bZDCzNmnQSxd2HoSkeHURlCH4
	 asN0WQ/Air0DDoXFo5azGgacM5dwHh24/aIeqvtAUc6QLP0936ih+CYjuX/AG/VTOi
	 qBmOIEzL72kYS5QWlrdVg84igjQm8J5Zzgp2/CECYgBEQBfMWOl6AYpPv6Eto13VQ/
	 SnFtdK4IIlOvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1557381197C;
	Fri,  2 Oct 2026 01:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: iterate online nodes in
 skb_defer_free_flush()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179090280553.3163959.12959222624674400533.git-patchwork-notify@kernel.org>
Date: Fri, 02 Oct 2026 01:00:05 +0000
References: <20260928014708.3903028-1-kris.pan@intel.com>
In-Reply-To: <20260928014708.3903028-1-kris.pan@intel.com>
To: Kris Pan <kris.pan@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, atomasov@redhat.com,
 oliver.sang@intel.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 28 Sep 2026 09:47:08 +0800 you wrote:
> skb_attempt_defer_free() only queues skbs on the current CPU's node
> (numa_node_id() of a running CPU), which is always online, so the
> flush loop never needs to visit nodes that are merely possible.
> 
> for_each_node() walks node_possible_map.  On machines where the
> possible map is much larger than the online map -- e.g. a POWER10
> LPAR with 32 possible but 1 online node -- the flush loop touches 31
> cold, always-empty per-node lists on every softirq pass.
> 
> [...]

Here is the summary with links:
  - [net-next] net: iterate online nodes in skb_defer_free_flush()
    https://git.kernel.org/netdev/net-next/c/56fbbb662795

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


