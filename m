Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB44832E121
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 23:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790639484; cv=none; b=OZrOT0IRLJyYYFMW6udvWCK//Y5+mSf7bV96JBYd0Kt11eChirA+1VDJioMqrWpNGlebrc673tna+ihNF9zNBIsR4+ERaegas3xHlu2dSRWvzC8X6/ddhFLSgGgkMEbtNFwFgNt1dZpKiUMHpmAc0EgFDZYGWJJ1Ft4/HXXtV60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790639484; c=relaxed/simple;
	bh=TdLQCP7SxBDqhCUXVE5pXEqf4c95P9KMT8BbuqecCYI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XvoXKglklIz7+wkvo7IUC+Yh1o5dHPP4LUlo8rnHsV/nd8qKsEOuJ89j/IdU63WESSd6+ZsaWnPKFERc8Tt91nu7TSVMan6mSB+4wTI156BzZLTbwFHAlZQ3KXMGbtNWUd9IoITpgDynQr8gXtyTRfsoaSkE7L/WC8sjGsrsvuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbMf6Ax+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbMf6Ax+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B361F000FF;
	Mon, 28 Sep 2026 23:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790639483;
	bh=ht3eolazAXRpJgIoM8sku4ZYh8UjG5oK1rj3oxKccuQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EbMf6Ax+qJbbW73K7c/s48yu+IEsorRDq0sgirheTYU+2GilgtM7mDOwUpFh9c7oK
	 EpoW7tAdqsbrmDfDmLg6X+OHt5Twnl5tvnx9yvqK2t+l4j2BuWHGt4AM14pw092B0b
	 t8YENS6m8dKf3H9jef4gZfvAPJZa5ogA5s3Kcz/3J5cMy3hi0dh9JxWHRMUu9OwjAL
	 6mlRu07p1FnZXpCH+QL/CbzebbHkhizuTX+nA+jb5WAH0UxvjRxm4k8hf6TZJpH0ag
	 2fbxWOSTeHM7WBogoW9TgXRSj6voasMHTeWFAZAfTmlQb1KI8NVEmI1tj3I4wgpH3o
	 RdM0TcFk8Y7pg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199523924FE4;
	Mon, 28 Sep 2026 23:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 net-next 0/8] vxlan: convert configuration to RCU and
 enable lockless dumps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179063940789.180557.14804652017550422979.git-patchwork-notify@kernel.org>
Date: Mon, 28 Sep 2026 23:50:07 +0000
References: <20260922181102.3989489-1-edumazet@google.com>
In-Reply-To: <20260922181102.3989489-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Sep 2026 18:10:54 +0000 you wrote:
> This patch series converts struct vxlan_config to RCU protection, eliminates
> redundant destination fields, and enables lockless RTNL-free link dumping
> in vxlan_fill_info().
> 
> Changes in v6:
> - In vxlan_multicast_leave_vnigrp(), skip entries matching the device-default
>   remote_ip and ignore -EADDRNOTAVAIL when multiple VNIs share a multicast
>   group, matching vxlan_multicast_join_vnigrp() (patches 1, 7).
> - In vxlan_changelink(), still attempt vxlan_multicast_join() after
>   vxlan_config_apply() even if vxlan_multicast_leave() returned an error
>   (patches 1, 6, 7).
> - In vxlan_vni_update_group(), set oldrip to the previous effective remote IP
>   when updating an existing VNI (!create) so replacing a VNI's group removes
>   the previous default FDB rdst instead of accumulating duplicates
>   (patches 1, 7).
> - In vxlan_update_default_fdb_entry(), still delete the newly added rdst on
>   rollback (extack == NULL) if re-adding the previous rdst fails (patch 1).
> - Link to v5: https://lore.kernel.org/netdev/20260921100139.508191-1-edumazet@google.com/
> 
> [...]

Here is the summary with links:
  - [v6,net-next,1/8] vxlan: update default fdb entries when the lower device changes
    https://git.kernel.org/netdev/net-next/c/b0e75977c688
  - [v6,net-next,2/8] vxlan: vnifilter: use list_for_each_entry_rcu() in vxlan_vnifilter_dump_dev()
    https://git.kernel.org/netdev/net-next/c/d10b7b93c5e7
  - [v6,net-next,3/8] vxlan: vnifilter: signal interrupted RTM_GETTUNNEL dumps
    https://git.kernel.org/netdev/net-next/c/0e75889596aa
  - [v6,net-next,4/8] vxlan: pass vxlan_config pointer to helper functions
    https://git.kernel.org/netdev/net-next/c/3ea463294b1b
  - [v6,net-next,5/8] vxlan: move VXLAN_F_MDB to struct vxlan_dev flags
    https://git.kernel.org/netdev/net-next/c/0259a5f1279f
  - [v6,net-next,6/8] vxlan: convert configuration to RCU protection
    https://git.kernel.org/netdev/net-next/c/0db0197ef9e1
  - [v6,net-next,7/8] vxlan: remove default_dst and use vxlan_config and lowerdev
    https://git.kernel.org/netdev/net-next/c/7e9e6844befc
  - [v6,net-next,8/8] vxlan: no longer rely on RTNL in vxlan_fill_info()
    https://git.kernel.org/netdev/net-next/c/4b74deb12948

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


