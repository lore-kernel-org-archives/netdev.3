Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDD718D62A;
	Fri, 16 Oct 2026 01:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792114812; cv=none; b=Qh2owTqiGwBrM19tD9i26mb3GjIkppf036acsmar8qANELw3/wtm99U8xS/3a4B9mbPzm0UZhrcDLrye2/Ur5rqZ/jnhKhYDnbfJqzXi6qn6mtXUUWgAzEtIUE4v+ANdfTFeZy5IKYSsLBGkbc+/UggV0o0x/QcE65eBHdFiZiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792114812; c=relaxed/simple;
	bh=B05zGkxT2F04MFUko6OV76ZgMrM/C8aDKE9cAFo7Rwo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cNs8Xs6qm0RZWScmPAClvsoI8LmCNV9/cYNDX98FWN6SbZCHW62GlCVXfiu48jFi3hzmcgy9p0dAfT4DynOT2Bz7Nqxh4qwCa4mcUvEaa3luBduE//dJeAgaUVs05LLLkdYgew7v+pwF8IpL/NArN2C3C5EdAf0VfF/yhpoF5sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4Uej9u8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4Uej9u8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F62F1F000C4;
	Fri, 16 Oct 2026 01:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792114811;
	bh=/4GnRAQrchuORPtnOA13qaPA/NDJB6icroQbAclr5eg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=L4Uej9u80pXKeHyTP7giA8VnQgR0b9o2hTAnr/xEmjz1No/ADuc1uvSG6RjNRt+Ga
	 RYOVbkn8w2iHHxK0H+v/GV9uEfTvUZTHwVImxlkjSnUgXB4NUoASSapounn+LYRsx1
	 ghnpXRZ71gcW++YEErvFu91p2/3hHHXUaxdkWjeyXSPfoeUKbC73TmOccpCpJJIhll
	 HoUrDxAfcA9G4GSV7psR07Wq/w0s87V5mc1N51kP8PC9W+tHHPDN0faPcsZ6f4Qzw3
	 1uRjmD+Wohrp8LyIBn7VD3jamJKlOgratN8aeYD1VckXZYLfzQPIRCOendDjJ0Olbt
	 MJ91wkY/JJysg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7757D3808209;
	Fri, 16 Oct 2026 01:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: realtek: Remove unused buffer from
 struct
 realtek_priv
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179211481001.6630.10513322624420759763.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 01:40:10 +0000
References: <20261011131208.272131-3-blum@kernel.org>
In-Reply-To: <20261011131208.272131-3-blum@kernel.org>
To: Thorsten Blum <blum@kernel.org>
Cc: linusw@kernel.org, luizluca@gmail.com, alvin.sipraga@analog.com,
 andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 11 Oct 2026 15:12:10 +0200 you wrote:
> The buffer has never been used. Remove it.
> 
> Signed-off-by: Thorsten Blum <blum@kernel.org>
> ---
>  drivers/net/dsa/realtek/realtek.h | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] net: dsa: realtek: Remove unused buffer from struct realtek_priv
    https://git.kernel.org/netdev/net-next/c/207d1c23945a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


