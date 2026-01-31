Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF52315785
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 19:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769887223; cv=none; b=co3Fpmoi2Vb3OfojmFmrBjQ1/73w75Qa86Fhb4hhKGs2lZ4W93gUlAXfrplRmK4CyDHir48cwbUEK/S/upuE6H28oZvDqBNGLL2AYGnp0RmT34+/Rowz3j9pfMUaMR9FQJCSTP0gMDRdFa0+QUqAjLyS0FeByK0+5/LmBKjufaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769887223; c=relaxed/simple;
	bh=TfrBPm38dNgfztAnr0E8WVDmNG9RwuIHECH7kGCP14U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bXewTbD1Urn8SkOmD5v0biZ9CT1LDaQ1JM+Jepa1BDq1tX507L3soRN2BPDjZjvyDwxIhtxXuvCU2dLOEHyejZJXmSChFopU2IZ7C5wgaRI6A76Om+RD4h4qfEoPtQCkIPmt7/fHaULTTi6m2KjLri3YTA8TK9WOl/7vTdFvwPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbIJ/Abn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbIJ/Abn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF91C4CEF1;
	Sat, 31 Jan 2026 19:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769887223;
	bh=TfrBPm38dNgfztAnr0E8WVDmNG9RwuIHECH7kGCP14U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RbIJ/AbnlMsf6D8f8OVuJtIJgfcqZtOdwanavkTHdNd7+k5bDLFIhOrO3YJvF3bMM
	 pvtlK3TCJ0vvP/VAn+K2whLkbdxBHl9qlkfNCidhfMZFRL85xEpiElcPtkdKav+7Iv
	 Us/GUx4OJU/oHef+lsOEzLHdWzBaZgIxn+Of4zYGecQn6bHEcn/1a5kiyUviul9uJV
	 4w+NeQBlSj7S2HPohofLPOOw6Pornc7QRSqQYKe/plPNelRuutoVi5xbVtyZZGR194
	 EMd0wIBmTsLiOINdV2TLbTgDwuK+3CePrDODxnuWpDv7VUOGglwQPbwWhzT43sTz3m
	 R/tAoecIG1F8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BC02380DBD3;
	Sat, 31 Jan 2026 19:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next 0/7] man page corrections 
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176988721535.4169653.15303349092721217252.git-patchwork-notify@kernel.org>
Date: Sat, 31 Jan 2026 19:20:15 +0000
References: <20260124195824.221305-1-stephen@networkplumber.org>
In-Reply-To: <20260124195824.221305-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Sat, 24 Jan 2026 11:49:24 -0800 you wrote:
> AI does a great job of finding and fixing manual pages.
> This patch series is the result of editorial review and correction of
> subsystem man pages, addressing grammatical errors, style inconsistencies, and
> clarity issues throughout the documentation.
> 
> The corrections cover the following subsystems:
>   - DCB (Data Center Bridging)
>   - devlink
>   - Statistics tools (lnstat, rtacct, nstat)
>   - netshaper
>   - TIPC
>   - vdpa
>   - RDMA
> 
> [...]

Here is the summary with links:
  - [iproute2-next,1/7] dcb: fix grammar and style issues in man pages
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=9be6919137c5
  - [iproute2-next,2/7] devlink: fix grammar and style issues in man pages
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=aea0ff56598c
  - [iproute2-next,3/7] fix grammar and style issues in man pages for stat related pages
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=7bfb82531d36
  - [iproute2-next,4/7] netshaper: fix grammar and style issues in man page
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=8a966d9025ed
  - [iproute2-next,5/7] tipc: fix grammar and style issues in man pages
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=df638236f887
  - [iproute2-next,6/7] vdpa: fix grammar, titles, and formatting in man pages
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=4706396c3179
  - [iproute2-next,7/7] rdma: fix grammar, formatting, and style in man pages
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=4d4e73273a45

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


