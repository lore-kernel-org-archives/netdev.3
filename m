Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6000D324716;
	Thu,  3 Sep 2026 01:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788399709; cv=none; b=G4RXUD5SwgfwcBd8+zYagCXJGeEYUoR1qpQ7A1tx2AUZ2Kq1CKUk5IbE9fW+tMibMwYmeuK1YpOFN3aMOpOvA7v0eaGeBRTpqo9NDMEDE9YDgWhOQhkXkgSdKdKMQSoDVmAm+37PEyMYALpqjNGQxOpCw0gT/eOR60hJV7jf2Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788399709; c=relaxed/simple;
	bh=Sbvjv7Y6GwEd0iYJ28BsZkNJzmiU80Akl/jhaRvLXG4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TzPlwe3liEBOhz0o7IvGY+pQnOiOfraTj95PwF/VHEc+cs6JBDI9qH0EKAJe2i3k9lD84iQnhCqTtoqtr3ToflMLvLGlhUclFTxlxHEpc+PgYC9eixFkK+i8Tpu26NGwPNZBajsDTJrStBQRoFR4+tfi0Xljo7IEbJUImHxStzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKkX/l7z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKkX/l7z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0B31F000E9;
	Thu,  3 Sep 2026 01:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788399708;
	bh=TebVvdRULCEq/DWVRWCFxnOtGNcebBk8gV/PkJsvqfc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EKkX/l7zqF4BPAQc4do8sa7nGCCpieET9FkHLwI1y+TpSTsK8NF8zb3ba7tR88OU6
	 ddyiX82v7Lx2iXMivS3vrOpcaL82G142QnZH5gUfLJ7sXW8T8w7GUMsNHFZtcjvb8U
	 jdtQ6KHjVQJlkP6uKbejhA2aLqGmWMWLcYVcrV+G5wKX1tjSVZ0A+GLhnEbggLtiX0
	 h/kzzMVpVC0z6RyfYVjynWIEQ2D2v9aqs/TpcLGDcNB6TA+oI/RuPWb934yxT0N9Sm
	 JMhi0voTD02A497qZYMcFfuc6L8/rVl2zKyiOK0C1beqBbdYF6W+HFC80W4dcAAr+w
	 njuPJilp8VwBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AA73927054;
	Thu,  3 Sep 2026 01:40:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dt-bindings: net: fsl,fman-dtsec: Drop redundant
 pcs-handle-names dependency
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178839964939.3035212.8947771195506296370.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 01:40:49 +0000
References: <20260901061255.25734-2-krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260901061255.25734-2-krzysztof.kozlowski@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: madalin.bucur@nxp.com, sean.anderson@linux.dev, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  1 Sep 2026 08:12:56 +0200 you wrote:
> The binding references ethernet-controller.yaml schema, which already
> defines a dependency of pcs-handle-names on pcs-handle, thus duplicating
> it here is redundant.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/net/fsl,fman-dtsec.yaml | 4 ----
>  1 file changed, 4 deletions(-)

Here is the summary with links:
  - [net-next] dt-bindings: net: fsl,fman-dtsec: Drop redundant pcs-handle-names dependency
    https://git.kernel.org/netdev/net-next/c/577b53589d42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


