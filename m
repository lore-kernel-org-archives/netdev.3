Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E924B3AA1A1
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 23:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781391614; cv=none; b=ERTmnmagzoPxUk4Y2Fqte9Bhs/EfYYZBydUFVQZttdA0Bt5bLV7cdFtCOjhr5LNEdwxcjvNjZ0eYjU/Qbgr2OK948NruYPxQPUmvIHjpIizLYjgUUFqDA/XAABOvSry0WYsFJXObpbEx30yZYG1IR36JcmVyNpYt6mf8f+AbEow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781391614; c=relaxed/simple;
	bh=1funcmtdqQkZPKZLwq4VrBQMVroqqT+hCe+kzS+tGa0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=itmgwiCqvfPDT+KXFf4iqrHL4JqmS2MNeVj7gfzrrk2NfYirLQYwyU+9R7ZWnhJcNiDRBwhYflC7HHw3ZyQhvqAxt1v5ZQoLikI7Zw49LTLMutENiD+03MasXVLxg98gzzdNgkKICNAjZ6Nu9vQLO9QfEvJcgkynygYq91Ph7Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLDiCic8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLDiCic8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828A91F00A3A;
	Sat, 13 Jun 2026 23:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781391612;
	bh=OL0xJg9TGrHcjEJfmk3cEN8r9HyvxoLtpxe2HvO86kA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nLDiCic8tXhbtDHtLCwUYQiIve22BfmTErq50vy3chAmEm9dP/uwQT6gcNLWEd5YI
	 veLro4/RlOLvBP4hnkQtj8F5siX4sXi71vW0h1L7Z3xTPsWdT5hYM0wEL4sNV+SlsQ
	 wmrYKGsPdSVO6vutfzncLNK+UPmDdYAtsgzJcnfqpeNZYng0GnIJKYzkAUbwI6g+Ko
	 GIIs6jlcaRSTPjQNT6KZLrL8WbgflorWzjMCRAKT5YELdT1IuC8j7nT3AhDWif+Mfr
	 TIUhAfvV5fSMtHakzxadwd3pMttoy80RCCx+xFMfGWGqwlj99hz9P9OQDV8XxVaPZv
	 JNKOpPmHTccJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09283A54A32;
	Sat, 13 Jun 2026 23:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: airoha: Fix debugfs new-tuple display for IPv4
 ROUTE
 entries
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178139160838.1619194.4028591531296512566.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 23:00:08 +0000
References: <6a2be54b.ef98c1b2.3c3224.2ed8@mx.google.com>
In-Reply-To: <6a2be54b.ef98c1b2.3c3224.2ed8@mx.google.com>
To: Wayen.Yan <win847@gmail.com>
Cc: netdev@vger.kernel.org, lorenzo@kernel.org, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com,
 matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Jun 2026 07:09:56 +0800 you wrote:
> In airoha_ppe_debugfs_foe_show(), the second switch statement falls
> through from PPE_PKT_TYPE_IPV4_HNAPT/DSLITE to PPE_PKT_TYPE_IPV4_ROUTE,
> accessing hwe->ipv4.new_tuple for all three types. However, IPv4 ROUTE
> (3-tuple) entries do not contain a valid new_tuple — this field is only
> meaningful for NATted flows (HNAPT/DSLITE). For ROUTE entries, the
> memory at the new_tuple offset holds routing information, not NAT data,
> so displaying "new=" produces garbage output.
> 
> [...]

Here is the summary with links:
  - [v2] net: airoha: Fix debugfs new-tuple display for IPv4 ROUTE entries
    https://git.kernel.org/netdev/net/c/1c3a77471afb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


