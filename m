Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348608;
	b=lsXQ4BuQwXC+/7rpk3bqEAeIgPC5MvolmGEbn4kc4hEvKIu0r11afwsl2zo0lCcf+exC
	 xYrzWipuMk7F9pwPC3I2L3N9G020GW0K8vLn8qKMsaN26Qu/8IjOt9MaOq19P5xNC+w/C
	 8WcHgryW2KoawW5TRvsaYM6aIf4udsvcQXcXovliPOb9klGXstyx7rxOOT4yNskbeQ6Tm
	 B5eXieUIVpNtpzR6AW0ziCsSJfR/9/87QEn99FwjzmVRnAod5NMiCRMVP+G5SOgkCerwM
	 sN40l93D9cVYZf2+cqD7JtSwLaCyCVrdNVS/kcaygCgmw35Oz+qLqksr9STLaw6GT9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348608;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=PRpI9LvDPOy84Bmmq13srMKGzadJXBZiW8HLELC9wWA=;
	b=crmn1SQd4xqEWgC/bcle+sTPgD7SKkVWWRC5Q/tHEcoqLqs/mxDuUv5/6B1o436rLBt+
	 dS2dQYHIuxo68UZXSvgpnlGuuq9vFDXWITNhIAFTcMD/3Fj6kR9nILko0rIHdu+7z7Jve
	 ZoMahg8ZgH27++Qq/5Ujo41Lf3PwSDRg1C1eQopL7ZT9qNy9CWf9Uv0EgCPyZFYhXLSFC
	 cfmX0nSUFXPRXDoCmET1RlRzcSwV8s9plQJOl7SLPQz28y0g0sTzhXmmQ/0C78Sr5qDLY
	 hMCnIKWQOXruqy7uzERLin3VBrRabOZ/XBlQ9dpVKpqhEzx7CBuPmK+aK0YULyUXqdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQzfrDey;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0D9606FFF9;
	Tue, 10 Nov 2026 22:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQzfrDey
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60EB1F00900;
	Tue, 10 Nov 2026 22:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348608;
	bh=PRpI9LvDPOy84Bmmq13srMKGzadJXBZiW8HLELC9wWA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EQzfrDey98O2SaUeRRxoz8UeQZ0wp+5pobxP5LlQrmF32tBqOcd2cmeuq4Fj5LriE
	 JsXOFCtkDWQDTGvAevqs8Hwxf2L/XfDUUCdQGTqlpdjRmUUslOnwHApfTg2jH8HY9Q
	 LMp/PHRzVhtid/1Oxew8yHYNdOAlJP3tazsRQY5tv8qf4xShA/3lFIad1AO41RJalw
	 2lQAQqtHunzmmHeNjmrP55oXap/6nrKmI1UMwKioekUvRdv9cIvwu27a8B8EtABAX2
	 8omIWsmLKnc8+FZQ5qZT5S4/JkbX/Z2C+Iwc/qXmmiOu/B5UlXdkbl2oQZ0JoISQyb
	 Ttp6HoaeNUxjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D81CC39E8A40;
	Tue, 10 Nov 2026 22:10:07 +0000 (UTC)
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
Subject: Re: [PATCH net 0/2] dpll: fix a false notification and report
 interrupted
 dumps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179434860642.85266.14474839732460083236.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 22:10:06 +0000
References: <20261105131145.1010406-1-ivecera@redhat.com>
In-Reply-To: <20261105131145.1010406-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, milena.olech@intel.com,
 przemyslaw.kitszel@intel.com, kuba@kernel.org, davem@davemloft.net,
 michal.michalik@intel.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Nov 2026 14:11:43 +0100 you wrote:
> Two small fixes for the DPLL core, both found by code review:
> 
> - Patch 1 stops sending a pin change notification when adding a reference
>   sync pair fails. Reproduced on a ZL30732A board.
> - Patch 2 sets NLM_F_DUMP_INTR on pin and device dumps that a registration
>   or unregistration interrupted. Such dumps can silently miss an object.
>   Reproduced with a test module.
> 
> [...]

Here is the summary with links:
  - [net,1/2] dpll: notify about a reference sync pair only if it was added
    https://git.kernel.org/netdev/net/c/7a3837929d04
  - [net,2/2] dpll: report dumps interrupted by topology changes
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


