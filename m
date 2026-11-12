Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794506409;
	b=YicSpvofKx78pxkPzbasn8O8vL4G1E+j3tE8CBu5FCMqOvvenOajG+1NzZ5eWti+117Y
	 5hMRxvvdEc0I3YDCmkjfmvmTE7Zwhu4vysZCnz70kjnsiaXDeC4sN/jkSeEyhwhbgFeHn
	 k3PAJVh2Y7hHf9WwcA4CWFANijKTaf2Wv145sJWPNhSpUniu2EE7qKMUpTr8ETXiiCyWI
	 ZFVjYidkPZRfw7fDlpXgtaqu3GxOUpBtJAydxlAi664ZmuWVRWJLrAePeXKs3N1YoFCeI
	 dEpbD+HhPC3QB5O5aBR2RygkKxxBVkXETa0IShDJaF9PTvFoZH5cJ5ydgO2gdzKSE8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794506409;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=7YRNISiJxbIUTsLygKufgFidBAmVPMdjexsRlPS3F+o=;
	b=wWnffg1dPNyVEtt62G0bvwJ50Vm/9nDI6sZEERiiH7GDEZMDMIPmq9eRyrz1EgwO39ZS
	 xB4wM4ilVoNQSosN+aNkJjkU5aEGWVFjG2dFK3B+XukK2o9FcmkWaYfb+Gnsl819aqkTj
	 uJGIONGOZ//vEHoBS8BwIKgcPdbXloFopvNohoJDhj0d2zCLhGWrmhk7RsPRQPYA1ziB5
	 PETZ4OZUFCNvFLCao50njNExBtB6SMKIew6aaolkOFTpcxSnIlEF/Pj/dsFs2yAC5NSvh
	 eHPEOLFGFWOLPn9KLTYrQpB3urQZQ1uz3CHyOx8ZZEeaUZyqD/2XfsOg93iM1Lh1fWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I8VZoVXV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592BC606A880;
	Thu, 12 Nov 2026 18:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I8VZoVXV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D663B1F000C5;
	Thu, 12 Nov 2026 18:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794506408;
	bh=7YRNISiJxbIUTsLygKufgFidBAmVPMdjexsRlPS3F+o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=I8VZoVXVKR/KHWYA4AbPmug8HNRy6tbNVRdhAAEwFR3a66h2lckakXfARjRTNO/RL
	 VMhSA1QilwQ80v4Ahjx7tDyVET2DelGsLakOfjoDQjTviRt3Ue5FHxh/Yp1CU64ivT
	 XlmFaa9ay/sKZDjSZfkNKpdZdrYrMWjm4kKdyrcAF6Uz4gIiRlTw5FYrdeh6rINcx8
	 zaQ1DqtvR4dGIh0CebUMqG8H7SFFNbWHSaEJrFs47DcCRznHlKA/UWANxAdjwsNkdw
	 R2cL3wuFRrXn8/SERVHlNV+jpVrq26qHmkK17QWXkkaIkj+zYKXsad7y83nKOcaTGo
	 TdXyOf7DlWPyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4586380AA7D;
	Thu, 12 Nov 2026 18:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] ice: dpll: fix updates of the SyncE CGU registers
 on
 E825
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179450640727.567589.292897520370852621.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 18:00:07 +0000
References: <20261110094350.184185-1-ivecera@redhat.com>
In-Reply-To: <20261110094350.184185-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, arkadiusz.kubalewski@intel.com,
 grzegorz.nitka@intel.com, aleksandr.loktionov@intel.com, poros@redhat.com,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, mschmidt@redhat.com,
 jramaseu@redhat.com, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Nov 2026 10:43:48 +0100 you wrote:
> All E825C PFs share the CGU registers R10 and R11, which hold the mux and
> the divider of the two recovered clock outputs. Both patches fix how a link
> change updates them, both found in review:
> 
> - Patch 1 adds a lock shared by all PFs around the read-modify-write
>   sequences of these registers. A link change on one PF could undo an RCLK
>   pin change made by another PF.
> - Patch 2 lets a link change set the divider of an output only when its
>   port drives that output. Every port set it from its own link speed,
>   which is wrong when ports run at different speeds.
> 
> [...]

Here is the summary with links:
  - [net,1/2] ice: dpll: serialize changes of the SyncE CGU registers
    https://git.kernel.org/netdev/net/c/0afbc079d87e
  - [net,2/2] ice: dpll: set the SyncE divider only for the port driving the output
    https://git.kernel.org/netdev/net/c/164721e16b82

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


