Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697394F6464;
	Thu,  3 Sep 2026 17:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788455114; cv=none; b=mL44+VG7e5ibupw3V/ITJaVf8ohZXov84m1iH0GzgES1KwHe211zhIgUkrQj6mauIiLv8Am3L9BjC1X1n0ElJcty6ijLoml+IpK3Ch4zHrLjvRmkVmqHXPXZ1+7BBResOyMe/wM1/nrVJKCxgCPIJop/Gjr2MYsoAoDErKhi6o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788455114; c=relaxed/simple;
	bh=Ph+9VEGprm8NQG1M6GgZRh6GQ9iNq4QZ5pzrsFkoX+M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YfTkHipBPqQGGDZTTJ4fzNINBFou4QuKnPAlPYkCH/2ebwVb365w+J0AIfd3CtkKeI6ZZ2+UyX9fX/JUdqY+5MtPt00VE4sAPeIk8nN88kQxcdnkAgnBYZsqlhndxa06KgBr+vO50XNB6zgmWzqnMYUgrq+0dsAGLQjQgqFZ6uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxISMyqa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxISMyqa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1541D1F000E9;
	Thu,  3 Sep 2026 17:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788455112;
	bh=+Dl5feE32R5YSmycpNB7tG4kFg0khyu/BjlzmNR2MYc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=IxISMyqa6Z8ZHxKuew18kV8M5NNd8ulFRT+m7YnpSgtr14GjWN/4S/FCcL44vxkyX
	 LwzUNohC53hI8u36l4uovyz1FloKZZy7u7QDJ0x3SJRfFnkAFvq8A30oZULKFtr2FP
	 rDb3Ke0ersoEH5/p2u5koqgkm9lUikSmKsbZ+l+Xt2iDnmXpvEt+cRqgl8DtWnKJT8
	 oSWUX8cZ1vZnxyR/1JRg8bOQVRH75nczJrVd5F73VcYp7aAUeEiEtxlcufGW+IQ/Is
	 jV58d/1ZX/NQetnwxHxrJbuPaNXJw6c3R24L8IXL4TO1ZKKqxRQKuG5enJ1cE+fnGM
	 Y0JW1wQxUXTGg==
From: Vinod Koul <vkoul@kernel.org>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, 
 Srinivas Neeli <srinivas.neeli@amd.com>
Cc: Frank Li <Frank.Li@kernel.org>, Michal Simek <michal.simek@amd.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Suraj Gupta <suraj.gupta2@amd.com>, 
 Marek Vasut <marex@nabladev.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Alex Bereza <alex@bereza.email>, 
 Folker Schwesinger <dev@folker-schwesinger.de>, dmaengine@vger.kernel.org, 
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, git@amd.com
In-Reply-To: <20260818174151.1608971-1-srinivas.neeli@amd.com>
References: <20260818174151.1608971-1-srinivas.neeli@amd.com>
Subject: Re: (subset) [PATCH V6 0/4] dmaengine: xilinx_dma: MCDMA
 descriptor and metadata handling improvements
Message-Id: <178845510663.1711546.3081841181501985033.b4-ty@kernel.org>
Date: Thu, 03 Sep 2026 22:35:06 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 18 Aug 2026 23:11:47 +0530, Srinivas Neeli wrote:
> This series improves the Xilinx AXI DMA and MCDMA driver's descriptor
> handling and metadata reporting. It fixes direction-specific descriptor
> field usage, ensures completion is based on the hardware completion bit
> (important with interrupt coalescing), and extends metadata handling to
> expose status and sideband fields alongside APP fields.
> 
> The axienet driver is updated to derive RX frame length from the standard
> dmaengine residue mechanism rather than descriptor APP fields, making it
> work on designs where the AXI4-Stream status/control interface is not
> present.
> 
> [...]

Applied, thanks!

[1/4] dmaengine: xilinx_dma: Fix MCDMA descriptor fields based on DMA direction
      commit: c791d22ddd7b4940fa3c211b5ee7c5d4ce2d1dc3
[2/4] dmaengine: xilinx_dma: Move descriptors to done list based on completion bit
      commit: 5af3ac5de34f9f7a4ae81c690d8dea5dcb523ab0
[4/4] dmaengine: xilinx_dma: Extend metadata handling for AXI DMA and MCDMA
      commit: 37c44606eaac6f600fe2c602372bb02ef5ec0c53

Best regards,
-- 
~Vinod


