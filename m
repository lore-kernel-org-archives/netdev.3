Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631FC397342;
	Wed, 13 May 2026 03:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778643998; cv=none; b=L/dheyUc8jBs6Z6h7a/IIajz8fQAID4qhiOZ9HuGv6exBNImJlt5jhQumEl3Q1nO4qt30EdZmrhBRFaDz3EO40IZNpYnz1UfF9gTV3yAfMt/MLqz5EGTNLgjxkQKEjFC5ZJwZbs/SiLfBRtlGRHvn4YhUA0AQ+FkQC6bIwUPUz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778643998; c=relaxed/simple;
	bh=5kBKh+efbz/R7U8lgQVz2iAarBxxhLdKzm+NAVy2U8M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kJSlua+QGSGaVZmjR+xMAfYqFN8qJi+7jABveXR3ut3UxlGAx9u/xWfIgdve7wcTUW8xKBWGE2qm5G4MSVpNRIARgqom8hzMi726AJolZ3iQdcAEmYg0nPq+isA3br8awrX8dANfSxx+GgADZM4wlEBbcYbg6xGxtwqkqrzliyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmlKm4b9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmlKm4b9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E84C2BCC7;
	Wed, 13 May 2026 03:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778643998;
	bh=5kBKh+efbz/R7U8lgQVz2iAarBxxhLdKzm+NAVy2U8M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TmlKm4b9abb6JKh4V8ph+BmXPZU9WXRblu4/uSfFmp4h7X4LWpFDr/6MTpM4tmSLb
	 wpTmkhDfLbdbGMV0g6emnjTMGq+i7KwpFlw3aVvHNPjDP5IyvmQ91LYpA5cc3JlmEj
	 xcpTKi13Ua1zGvcMOoyoYTZ8BpQmHaU3VVvw8MUGRVgW8D0oJx04klsqpeOJ5IH54E
	 40gNQxYDoGRbsvxuHxaCQsvDEb9xwqgrXUZjbIvuAEjeEDcbwjQBjcjdd0kuc63hFd
	 AV3r9krgU8bjn+i6WZcccstA3R+b6cQhecT28bS+PHd+j6E5F/8axVLa630ZWWcMzz
	 RndOENPZ9lS1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FCCD3822D60;
	Wed, 13 May 2026 03:45:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: intel-xway: fix typo in Kconfig
 description
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177864394404.3173643.13190738323269805779.git-patchwork-notify@kernel.org>
Date: Wed, 13 May 2026 03:45:44 +0000
References: <20260509210900.3968447-1-olek2@wp.pl>
In-Reply-To: <20260509210900.3968447-1-olek2@wp.pl>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, dumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  9 May 2026 23:07:22 +0200 you wrote:
> Replace "22E" with "22F" in the description.
> 
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> ---
>  drivers/net/phy/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: phy: intel-xway: fix typo in Kconfig description
    https://git.kernel.org/netdev/net-next/c/6c9d76eec482

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


