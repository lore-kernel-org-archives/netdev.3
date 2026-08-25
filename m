Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1234C3019D8
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 04:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787631066; cv=none; b=Q6rvddPTcGjKuie2vat2DaPFaXrBqcUG93nrLl1moPTknDuzAZjbej3457aEf/IaCucIrXvBrhCRiOPwongslFoY80J7mUPVKwjiL6GI+zHrjGQO9syfpOe+Uwk0/unkXJQu7pnsU0Bnt3yFeNJmDsgXLnDCKaucPJalgdnIBa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787631066; c=relaxed/simple;
	bh=q35pErOxK0MVS6Dackw5k1SJzK5ry6EhnMZkan8g2/4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QbOfluwmTwDehf+9Bxsxs/z/FTGKcFTL9abwjrBMQAPJSJmeOLjNbVVf8k1FYmCmyb9wy/7RrvH5fdplSg2ean6QiW81WEfD1n9tcPe3EU27vzIGLVHilO611pCQC8nrcmvE85mR2S3LoTZBYd496HGjmaPFHRBbd0zqs0DxXas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0D7k4Mb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0D7k4Mb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20641F000E9;
	Tue, 25 Aug 2026 04:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787631064;
	bh=IEV61i4Ku1sXZE5Ak7Nqt4+j+tHlIDz3oRfNDxdJ6i4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=A0D7k4MbNcq3P/SNRI2wvO+Zn8ww82cu2c8F6XsM1hnqysYt+1eI4lXeb5FOO97AI
	 6qlDdF7mAg/nvBiBZQ+JLCxJLmaScJWhhD1EzB9sRS1e9Con8L9fSOMYMepATYby3m
	 TP8oxRluADzZgFAcCriX/xitY9o7sUUpOYl0SP8MXP6Nr9GwgwPqeV427QzH/HJR1N
	 coS5jVh+SSbCPi0ieikVeWDHRMrggY3xxUs7LTVOYpA1LHY/0xHeVExI7dhi+xMXcO
	 DDck+Z8/IxAE9ytkdS6KLvypkWteJg5UK5R5dpSTCTsJcUa3AoL984YCIkvetLbCWu
	 TEXlFjZyARGgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199223924A47;
	Tue, 25 Aug 2026 04:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2 0/3] compiler warning fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178763101189.3232246.2785579847686978647.git-patchwork-notify@kernel.org>
Date: Tue, 25 Aug 2026 04:10:11 +0000
References: <20260823235220.79790-1-stephen@networkplumber.org>
In-Reply-To: <20260823235220.79790-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org

Hello:

This series was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Sun, 23 Aug 2026 16:51:30 -0700 you wrote:
> Three small patches that fix warnings when iproute2 is built with latest
> GCC-17 and/or Clang-21.
> 
> Stephen Hemminger (3):
>   json_print: fix Gcc-17 warnings
>   lib: fix warning from ll_addr_a2n
>   tc/f_u32: fix const strchr() warning
> 
> [...]

Here is the summary with links:
  - [iproute2,1/3] json_print: fix Gcc-17 warnings
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=9361f61abb6d
  - [iproute2,2/3] lib: fix warning from ll_addr_a2n
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=5faf18f672c1
  - [iproute2,3/3] tc/f_u32: fix const strchr() warning
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=21a61425cb9a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


