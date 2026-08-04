Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3168946A60C;
	Tue,  4 Aug 2026 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852053; cv=none; b=qV2wqQeKk+fefS2cBobWzXerVkHGR0lUG+lNJMH20DDgpaR6bmPqtofVr//JrOfKwCb3P/H4XXxKFKPcoslYVgkso4bOvFGAu/UQaAEwQ/gTRWXigkYGJbs+Eh/9ZK7VlAt2z0uFBuWPxLBiYOShZjtfzQMAJ5IRFSa3gWZW/tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852053; c=relaxed/simple;
	bh=uM/UdUi8q3sC15aMJedNdNGZ/OGqixdV7byD6nqWDH4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qNDiQQZHUaO93tIRJCaBKrNXL9O7kXl+l+Kz2yWp0RJGVPxTQgsu1SwIeKM8XqmwiL/wC36zopjELkNZEVI7M4pgyyuuXGr7ZYigZYrdS1TkAO3tCenuMnF1yUca1IfLedhIdFs9OdQdmgVsxIgL/Nr1e2mdHR+Cb89PQ4i426A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sx+ViW51; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sx+ViW51"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA771F000E9;
	Tue,  4 Aug 2026 14:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785852051;
	bh=mpyTqBdevw99iwwMtLPxyoNC08nRFEMHQTer9pjaR+0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Sx+ViW51f7Y1cfpviGJ1Vy53xrX4yX8YHp6Wrp2FczgCJaeVr5OnKbstW4lZc5es9
	 RfKTV7vlriQYcCi32RvpfUArRXV7SHIG+PF56R0MSsigwyDo2CsvS2X4bfyExN2415
	 KkKqnyj2mKqDHNYKJl8w7M8ur7KIZyjjr+s8+dL6KmXxyZaMjn1b8wpZBHBfbgvcK5
	 JtwUkZ2Iuc03EdHkpYZd0xez2udCza/wh9FJBNR7mTmRkMj7FK67RUnjpAEFisfzJz
	 jk0u70rhivNHGB3cTxIkcSfc8516wGaBgYET839orkeWeDW0VNxsr90dU5m7iz4gdT
	 PMf5RuqfoARvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93ABE39253CB;
	Tue,  4 Aug 2026 14:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dt-bindings: net: Correct white-space style
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178585201216.3168424.15227977507793041541.git-patchwork-notify@kernel.org>
Date: Tue, 04 Aug 2026 14:00:12 +0000
References: <20260801195505.235099-2-krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260801195505.235099-2-krzysztof.kozlowski@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, Steen.Hegelund@microchip.com,
 daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
 prabhakar.mahadev-lad.rj@bp.renesas.com, richardcochran@gmail.com,
 geert+renesas@glider.be, magnus.damm@gmail.com, j.ne@posteo.net,
 horatiu.vultur@microchip.com, lars.povlsen@microchip.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat,  1 Aug 2026 21:55:06 +0200 you wrote:
> Correct a few white-space issues, like double space after '=' or before
> bracket '{' characters, which will be flagged by dt-check-style.  No
> functional changes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/net/fsl,gianfar.yaml    | 2 +-
>  .../devicetree/bindings/net/microchip,lan966x-switch.yaml | 4 ++--
>  .../devicetree/bindings/net/microchip,sparx5-switch.yaml  | 6 +++---
>  .../devicetree/bindings/net/renesas,rzv2h-gbeth.yaml      | 8 ++++----
>  4 files changed, 10 insertions(+), 10 deletions(-)

Here is the summary with links:
  - [net-next] dt-bindings: net: Correct white-space style
    https://git.kernel.org/netdev/net-next/c/828c4a5a9518

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


