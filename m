Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D90D3403ED
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 01:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789781473; cv=none; b=FGGwr85mMRXG1yJ1kiEEfLmlAKQ8tWZ8V+pKSbArs2c9+HE4Grb/yOEzBSOdWmesrJnPN++KYVYPrMo2OlJYaWw13H3DsWIUSSdUibHGstWt717mS0I2FF+cR5SSCX6prdh0ZnCQiG50R36S8jv1hI6i9EuuIfI2u5OD4e7OlSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789781473; c=relaxed/simple;
	bh=wnN4nNLZVTrcHPU5TzQqnzJL+2Pbtpp9Tq0nQADxAB0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bVWBOyO5dYUNxhSROiAKO9cdgaRGkHzVFGhFzyS8FWRw68OhxTCRtiszvA/8qOuLs09cCo2QtglebPDGjgOG/xS+0SqN8Ft9aS/JkBO2SFPcL567IJdBx7T0/DD8gljO9+Filw7Uraly+yA9q4d9kW0WW96oDUhr3T1mw9jXCEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ks+cQVyf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ks+cQVyf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18B31F000FF;
	Sat, 19 Sep 2026 01:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789781471;
	bh=WvqENhTr6ei3NH6WRZk1GY1Q+N4+hxvVFnUkWdcg7ew=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ks+cQVyfX2vc/uhyKmaEFhaE8Fxt3IKF8quRd2eEq6LbzgICiKQC38D2JMidkwRa0
	 EjA6j4O3Wug/f/8rdW3xY8lh8sh+UkhbXNTXrNup/9Qm328adYbEChqWxJhY32aB7a
	 ot3UFNiOagSpHHZ1QJDIwSvJcCtiygKP5MfNvCrS7TLI/W1nRmMNfpGVey5xXnshiI
	 jjEdV2gcordwVYvmREMS0vxjtoaPAFQ30l0TEA46MtQe6yaK4lNV8gFeptgVa/EFd8
	 hFjZHtae4JZrq2Mi81IuTto+5caEEmmqCFntwZ8KK65mBHjT6jChLnDH8i2DRJsEl2
	 8CsyZ1uUSKH2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0960381197B;
	Sat, 19 Sep 2026 01:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: allow IFLA_INET_CONF messages when NLA_F_NESTED
 unset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178978140467.1221945.7177607279598181856.git-patchwork-notify@kernel.org>
Date: Sat, 19 Sep 2026 01:30:04 +0000
References: <20260915213320.1527029-2-quentin@armitage.org.uk>
In-Reply-To: <20260915213320.1527029-2-quentin@armitage.org.uk>
To: Quentin Armitage <quentin@armitage.org.uk>
Cc: dsahern@kernel.org, idosch@nvidia.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Sep 2026 22:33:21 +0100 you wrote:
> Commit fa8fca88714c ("ipv4: validate IPV4_DEVCONF attributes properly")
> added validation of IFLA_INET_CONF attributes, and in the process
> changed the call of nla_for_each_nested() to nla_parse_nested(). A
> side effect of this change is that the IFLA_INET_CONF option is now
> tested for NLA_F_NESTED being set, and fails if it is not. Prior to the
> commit there was no check of NLA_F_NESTED.
> 
> [...]

Here is the summary with links:
  - [v3] net: allow IFLA_INET_CONF messages when NLA_F_NESTED unset
    https://git.kernel.org/netdev/net/c/6c096bb08de9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


