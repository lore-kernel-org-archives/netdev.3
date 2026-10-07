Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9951F34887B;
	Wed,  7 Oct 2026 02:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791338407; cv=none; b=Nr2D/L9V7y9+dE+hE/qbm06d7OerlltX+6pjlic7UW+pgQu70JL/nh55XG3efqrsdqyYnsWndWxGZgiCPOVjMKGS0Z5nl74PrmMr5VZnVbKRmCxTiOKfRVdelcmk10KONfh6O1wdIrVOhUaYjIYMXFNUHQBn+lCFiC1FlA+eA3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791338407; c=relaxed/simple;
	bh=+7GZyBwjjkp/XWYyQFUyf+F6zz1V8VBgMYQJYf1vQIU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UUCcNrK4kC1PBZ0axHptV28LfVsbgwSjh5vTEcy5mQ/5sR9osJtElBoxkTvEIzaphsrdMqrmv+TbAN2i+E+ZZakVSVseiMo+opEpVyebSdFqdYGS+yWCWtcZ4NIGaoAgOCvKZhnTDXSAbMkO/ezHolTIRDddqSiQ/XvhQofXjdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUPDZUfJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUPDZUfJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482341F0089D;
	Wed,  7 Oct 2026 02:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791338406;
	bh=ynfy+x7S7qe20n2+IN65ww5pUKi5Zp1qsbKofnBMBQY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FUPDZUfJDjg/gP7l+/q5FqITLxePXD76l7eacENUJRZ8O+h9PNOjvZTEHplp7PSZJ
	 dnK8vrtUHOOw2jybj6i5ZaS0pOsFaoC2hLq8MtIihH+t1xqN6WpxPswB1JIKX+TyRX
	 UyIpCRuJI6ixjmYEOd/symcHr8hk+Z+2hLliHDf2V/hpVTOhc2btiKLDCGLAzdjpu0
	 CbROxft4XVjHAoRDeAqAnIrQdrrAnFvKxHl2+KzTuU0XY6fXXMfv9ZcVlBUtXjVm2o
	 3H288q+WSJDGwsRFG2/51StWEVwtiZeRQE3keI2/gpzcjod3+nMeSYcRBOXiQa8AB9
	 xY0KfHYp8AoQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A26A3806541;
	Wed,  7 Oct 2026 02:00:06 +0000 (UTC)
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
 <179133840503.2870283.6220566218471653405.git-patchwork-notify@kernel.org>
Date: Wed, 07 Oct 2026 02:00:05 +0000
References: <20260930124818.114224-1-yanhaishuang@cmss.chinamobile.com>
In-Reply-To: <20260930124818.114224-1-yanhaishuang@cmss.chinamobile.com>
To: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 michal.swiatkowski@linux.intel.com, aleksander.lobakin@intel.com,
 marcin.szycik@linux.intel.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
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
    (no matching commit)
  - [net,2/2] pfcp: make sure the SEID is linear before reading it
    https://git.kernel.org/netdev/net/c/23609bce9e1d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


