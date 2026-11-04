Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793779208;
	b=1Fl+BIX4jokcUu5UN+tk5z7M0vVwuz3azfOIZ4wejcFsQS4U7nYC7M/jaG/qEyEq2dQL
	 2tsCS59j+bnBaSlcL00mhIIK0qzRbvEyENCJnClPWscfZUxV8w10hQKpjW1PkAt0vVmpC
	 5ttlEOhOJFm1SHPnUls9jicPctP/A1eaIGc2nugDpixKk4OSOdkr2c3krufax/EXfsHkG
	 SPazeIWqX33V53UGxpP5owrFZis8Z/nWrA2pMn+QEoMEteQgqXfzeTq/Apzc0KSrnQ7tf
	 Fx9OPy1J8rAeRy8nY/gy1wqY9bTdhjEod1U3v6Apq5rMcO4EJUXs0yrXfkVGalh8HTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793779208;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=ov31TOHTJC9Ye3ZwYo0lHAbWdIADrlpp/s139nEoKQY=;
	b=fz3cXybRn4UIy6OkT8HtyzwpD523oqWU7DPTZkE+VkkVNav/3vlMsjbnxnbMWZ+JuHcz
	 nZbunA4Y2gGQ6IAaD6pEUPnfhxTs+FnJQlRLIpYjrMiWFnZWTyrbIRTufDlGW+8aOX6Qr
	 4C5ijl5OmC1tfxVpaBnWJpvIwhsiSS8L5Rc8js1AkgwyhnK5vyUt5ElGnh/YvSbeWvj58
	 XBCCuPXL148JEe+ogEl5CqS7/0CvblpgL5ZLoUxXEfcV6JeRZ5eVMnfsi+8tvhsBSUZHJ
	 qERVkccDGuZd2OERBcQdVBxmYsF9igI5TdatSm6YuzjbocjU0cTzMSOLAmNIsXNdc9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bQy0Pg3W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F41606A31B;
	Wed,  4 Nov 2026 08:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bQy0Pg3W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F781F000C1;
	Wed,  4 Nov 2026 08:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793779207;
	bh=ov31TOHTJC9Ye3ZwYo0lHAbWdIADrlpp/s139nEoKQY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bQy0Pg3WClG9fXjdA5DUpx1F9Lc41NTKATRDn8Zk1QAYlVi0ZDx7HWmid33sleNXn
	 JIvdABj2JjtM8WzfkWOqWjyFiWEDtaYKpdLwF4Q5eZfCDk2K813/U7gFpbqnSVpcvZ
	 MuNiZqYGsv6kQ0JrHk5DuoZWDcwkA4EWTCRp/x7goHDp/OeJW5JpFXFX4vxo+Nh4RO
	 LTD33J2pQ1ZA+V7XGO5wzHVItUDZ/Xr1PHV2MyarX547yatvVNqm4DaqUn9QPqrixY
	 VtZRlYv65l6bzpsayuD3s03B2ciDcLMMQu4knc4WnNfopKulI0inGtMmEQOHK2e0f8
	 +7ukqqat3Y3Rw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA1F439D5FD9;
	Wed,  4 Nov 2026 08:00:07 +0000 (UTC)
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
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpts: adjust perout genf
 following ptp changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179377920629.2160646.14143136295576633589.git-patchwork-notify@kernel.org>
Date: Wed, 04 Nov 2026 08:00:06 +0000
References: <20261029135556.2508688-1-jjc@jclark.com>
In-Reply-To: <20261029135556.2508688-1-jjc@jclark.com>
To: James Clark <jjc@jclark.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 jacob.e.keller@intel.com, vadim.fedorenko@linux.dev,
 kory.maincent@bootlin.com, bigeasy@linutronix.de,
 martin.kaistra@linutronix.de, grygorii.strashko@ti.com, a-garg7@ti.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>:

On Thu, 29 Oct 2026 20:55:56 +0700 you wrote:
> A periodic output requested by PTP_PEROUT_REQUEST2 drifts away from
> the PHC as soon as the PHC frequency is adjusted, for example by ptp4l
> or ts2phc: at +10 ppm each edge is 10 us later than the one before.
> 
> The GenF that generates the output counts its period in ref_clk
> cycles, which the PPM correction of the CPTS clock does not reach;
> each GenF has its own PPM registers. am65_cpts_ptp_adjfine() programs
> them only for the GenF used for PPS, and am65_cpts_perout_enable_hw()
> starts every GenF with them cleared, so a GenF used for a periodic
> output is never corrected.
> 
> [...]

Here is the summary with links:
  - [net] net: ethernet: ti: am65-cpts: adjust perout genf following ptp changes
    https://git.kernel.org/netdev/net/c/3f1054a0cb09

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


