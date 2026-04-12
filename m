Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CB51A681D;
	Sun, 12 Apr 2026 22:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776033640; cv=none; b=M7Dz3/VFpCO9Au8R6GUXUyBiVnMF9cvhxwVYuRfMqyWc2Op4o+pwCmc5nv9txSP8JEfSE7rcpt33JONdmhWTF9XdLCE+VNI6JiI/obTXpt8iS7j7OMTRMUYGyJbIfHqakJncfFDtWwHFs5TBfZiTxOmltcl4MmCfPdFEYHN7ORs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776033640; c=relaxed/simple;
	bh=f9+QkuOQSxfqFHi5THmDbOofB97kseZs53WdRc4K/3Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YAi9rvwu+rsT+yhSHCvqGjOiGhjJrSGAxyVOq1SAZElcU2XdbZabFEGpaL5SnZawllyaBGSMic4/uPBfnbkXMG6MKTtS1q5avTN/0y74E+OMtVX7O41Qc4gr/SdEaO3Gm+EbArS741kktnDY5ScunubqAkhf2o9gHcbeKR6yQ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDA7KYQ1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDA7KYQ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D25C19424;
	Sun, 12 Apr 2026 22:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776033639;
	bh=f9+QkuOQSxfqFHi5THmDbOofB97kseZs53WdRc4K/3Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oDA7KYQ1Oh4blR4MCycwS8BEji4z8JMJ5rVMJ/IOIzrLxu8tG42j0TK4I5rXCqJ2U
	 9TVYp6XqMeQUPRMRo0UPhiDZ3xQKbewWukhZU5oDl6YOwZeuq1B52LE8GR9JWuPvFe
	 g9EB00UktrO4hwZbFb2r7MQIVVbLz5gc83gfSN6qYeHhWKq6Y1hpwUw4vFzggGyIpR
	 szeUD+dbCHpW5bICEhkzEoj0N0nOEtpy2zzfMeTPkoW97hPTIO7Zbw2kQ9IOUOSAjy
	 uHuxncAcp01fgCjwtu3/EsBviitZ9BcmWuiDmAeX8Wj2rtPTdFk78NMre76xPAhnZe
	 58cCq5iRqKnWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC823809A8C;
	Sun, 12 Apr 2026 22:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] IPA v5.2 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177603361205.3843927.9903704326605588051.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 22:40:12 +0000
References: <20260410-ipa-v5-2-v2-0-778422a05060@fairphone.com>
In-Reply-To: <20260410-ipa-v5-2-v2-0-778422a05060@fairphone.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, elder@kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, krzysztof.kozlowski@oss.qualcomm.com,
 horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 Apr 2026 09:40:06 +0200 you wrote:
> Add support for IPA v5.2 which can be found in the Milos SoC.
> 
> Note: This series has been split up into two, one for net(-next), one
> for the qcom dts bits.
> 
> Changes in v2:
> - Split the series, drop applied IPA fixes, mark as net-next
> - Pick up tags
> - Link to v1: https://patch.msgid.link/20260403-milos-ipa-v1-0-01e9e4e03d3e@fairphone.com
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] dt-bindings: net: qcom,ipa: add Milos compatible
    https://git.kernel.org/netdev/net-next/c/d471d70cc964
  - [net-next,v2,2/2] net: ipa: add IPA v5.2 configuration data
    https://git.kernel.org/netdev/net-next/c/4bf38bac1b2e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


