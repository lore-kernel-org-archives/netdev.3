Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983B3370D5C;
	Wed,  7 Oct 2026 02:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791338416; cv=none; b=jSBAqCISn696daaSFGVqyKo2ad+9peNBFo5NmSPTyg99iamYNI8ViCGSDT6+aJPEnsYUS0b+QA6QJn3M3iZ/V958PEPSiDMyYp9THPizDrFWMKXVKkiBVei6DsnwCNyQAZrsWQ8ZL87QrGY2mdKemZ1/btlzIrhSRIQeu8LUBMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791338416; c=relaxed/simple;
	bh=RxepsJxIJWwTuTFbAclQd7kI5CyoAzjQhEqdfyNNiZI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rEaFanZwzIFQnK4O4ZqoqwcRCkwtbcU16thhtkbeT6IcgXN2i3xpZmh69Wmrrr12gvWMttegMapl/0iuQxRFl+4BgREW04EPQacZQh81t9fBYbhuuBI7IjGzFtuSn8AL2wSWrv8+0rLO3+hEJxITNygQkoSeioo5zi3o+k5pHp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKv2iQrd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKv2iQrd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417D81F0089B;
	Wed,  7 Oct 2026 02:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791338414;
	bh=0Xz3H5QEivSnJLWldQxKghW6TKfWxi0S9El9nsgr8sY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PKv2iQrdMIZT9P3wKu5evMjHOcd8fBc9XPQA7Ah3r98yTrDeKTdfbNaFA56tUyh7W
	 zXRwBMHBlIQ+51KmUbQn60iVeI3TbRub05wzXPj3fQDgMOPPU6IECk3Om0+Fb6P9it
	 BEF1HO+n7a07WM1CGAduoF3sHddkuAkJMDCxV8mTi0b1WV2/4eqlP1BeqhnavXTRSl
	 LtEA/qr0Bs9WDbR/JCa6WGkKwB7AqLD//PZu/TVeb7EqlHdNFaJgNPDjz9nOlB7Vp/
	 SXpF2IGo4BxBi7VgsMoU0Pz0MrHQlfM1Z2QHqxmjmCgkPCEBtDfmqAvg51mTMg4Qb1
	 OOYA+fu99Bz8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A1173806541;
	Wed,  7 Oct 2026 02:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] pfcp: fix two bugs in the receive path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179133841277.2870283.16508077163700208399.git-patchwork-notify@kernel.org>
Date: Wed, 07 Oct 2026 02:00:12 +0000
References: <20260930124818.114224-1-yanhaishuang@cmss.chinamobile.com>
In-Reply-To: <20260930124818.114224-1-yanhaishuang@cmss.chinamobile.com>
To: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 michal.swiatkowski@linux.intel.com, aleksander.lobakin@intel.com,
 marcin.szycik@linux.intel.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Sep 2026 20:48:16 +0800 you wrote:
> This series fixes two bugs in pfcp_encap_recv(), both introduced when
> the receive path started filling in PFCP tunnel metadata.
> 
> Patch 1 fixes a metadata_dst leak when iptunnel_pull_header() fails
> after tun_dst has been allocated.
> 
> Patch 2 makes sure the SEID is in the linear area before it is read, so
> that a short packet with the S flag set cannot make the driver read
> beyond the end of the packet data.
> 
> [...]

Here is the summary with links:
  - [net,1/2] pfcp: fix metadata_dst leak in pfcp_encap_recv()
    https://git.kernel.org/netdev/net-next/c/d065de29c919
  - [net,2/2] pfcp: make sure the SEID is linear before reading it
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


