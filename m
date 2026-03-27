Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9180636C0D3
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 03:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774582607; cv=none; b=pPBk95HJNVxm1PzMoldgSzMy2XfpXYqdRj7DbPma/v45beRRTLOQqI6vJWrxz6lZpRjsnwwd1Xtx2aGxpakncENuZ9fqyfOSf+akW6GbIYFj4TG/3fUDCCRHCZakM8oL4e3TEumJYtMQAWmEEIY1FJtXWEafwnt7n+SHVLXYgSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774582607; c=relaxed/simple;
	bh=aAgHj1tvkJKNntEu6NMqOmmnnuGuh8u9b+RVHiZYVCU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O0BNaPCw40ARPlzga+vecw2BtiV6UN1e+J3Itc073JC1pJdU+OWomy4icmEpaGGmLMFq/dVFnNAWWqevkYqCLv/v0cR9rzRRyPOEHL1zQCig07gIK/TdykACJibXRPNtJ2mZoL9yxceWr0Gm8gqGuWWi+hs3Dlq1iaPT5GIYDRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVHHapz0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVHHapz0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B82C19423;
	Fri, 27 Mar 2026 03:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774582607;
	bh=aAgHj1tvkJKNntEu6NMqOmmnnuGuh8u9b+RVHiZYVCU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CVHHapz0UqlgQ05CnZcML6HYfFEgmC/bpmV3fRfPM+/2dwBEYoaQ9ggRuhdNzVa8q
	 DWglJ1x869sctB7WH2H0FEUrGCTrtGKWUpRQBEj1CpjCZNhogtNheVA2buY1J2Zv4y
	 zaFbcr/r/3JMJ485NqaXyijsnbgOkGasT3ZPDYhFGt2RY4BkFXey6Ie8AAExgOWOeB
	 R8alnDCHgEKkw/rGz/HnQebQ9KmyVOjkxaYDUufZaULtrpw20f7yAeJ6jXwZVHJCyy
	 Aoc5BTKjvU9QpRmCb+YdtPgNvipFEnr4/NpTyTaxJaBZtTd2bMuX2yOT9MgI/BbTMK
	 UjQ1SQn2KSEaA==
Date: Thu, 26 Mar 2026 20:36:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nikolaos Gkarlis <nickgarlis@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] rtnetlink: add missing netlink_ns_capable() check for
 peer netns
Message-ID: <20260326203646.2da52419@kernel.org>
In-Reply-To: <20260324080730.4051666-1-nickgarlis@gmail.com>
References: <20260324080730.4051666-1-nickgarlis@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Mar 2026 09:07:30 +0100 Nikolaos Gkarlis wrote:
> rtnl_newlink() lacks a CAP_NET_ADMIN capability check on the peer
> network namespace when creating paired devices (veth, vxcan,
> netkit). This allows an unprivileged user with a user namespace
> to create interfaces in arbitrary network namespaces, including
> init_net.
> 
> Add a netlink_ns_capable() check for CAP_NET_ADMIN in the peer
> namespace before allowing device creation to proceed.
> 
> Fixes: 48327566769a ("rtnetlink: fix double call of rtnl_link_get_net_ifla()")

AI assistant here suggests this is not the valid Fixes tag,
which seems true on the surface. This commit was fixing
cleanup, IDK how it could break input validation?

> Reported-by: Nikolaos Gkarlis <nickgarlis@gmail.com>

Reported-by tags are only when the reporter is different than author
the Google's bounty program rules have been amended to make this
explicit, please let us know if other programs still mislead people

> Signed-off-by: Nikolaos Gkarlis <nickgarlis@gmail.com>
-- 
pw-bot: cr
