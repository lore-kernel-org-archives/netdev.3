Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624EA3FADFA
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 08:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787820403; cv=none; b=s10XVd/RcBj86dvMCeEMa9Acgp8DOTpfbG3+9sf6YPZfsCOJebmImlv+I9Qo3Nw2wSFN2RA0L8YWrE+LqCddf4OwfO1dPJOWUm+rakAsyudShs5JcXJ4teGajWDK97AXN7GrkAE1LThLrwijk4N+2SiFnaZdnkdQd8xZgsxF1eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787820403; c=relaxed/simple;
	bh=8ygZIPyqi2xZTWKQ5iqfRw4RZdkrrwtAfcDOoqwNYU0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IsW8VsFjmW4+9IM/bBRlR9e185BLcoXJn2lhY3gvbqbmFE0X9hBbHh2efZQ0KOJ17Q5YSkQiBrYr41uvMUBeL147XN3tavWV/p/Y5oqRb/B8Zo2UzCgbgEC7ZiBpUsbi9NGM9o23YaLM9un4hyiNAagJ6zXcIDj4l1cwufNnsc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=fxufw8H0; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="fxufw8H0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1787820387; x=1788079587;
	bh=lhxuzSSCiA9yo+vWB5G26kPpXv6+d3Y2XXAaEPMMCxs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=fxufw8H0rYVX0gljTC5cW7Dhns3IVfsPfCCEX1pNfUN5a1WWscThCRevNWLM+blBu
	 2Y7742Ge+XrsVrn+G1pej7VUnDqTSK1o2blfkGefEnFIzA2Fnfb+ggkxb6+ehs5rYm
	 b7FiXHXj3p25EI4kHmzNuuU2DnvhDH1K0zjzXSIPHuuHu72pgTaM5VSO45b40jwB+4
	 h6g6YaGVA9de+tlnbIHT1aLQSL4mwGLHJmJ9Dd/4iJoSFJME/mlioSrA71of3NfjOn
	 RGpvgf6aG+QUU4ZhreRtk6M+Ebdwlzo7icT6MsTj/gcSPtJEZWrNanj48OfaxFbEVJ
	 WPM/frx12sBuA==
X-Pm-Submission-Id: 4hVw9F285Pz1DFFg
From: Esben Haabendal <esben@geanix.com>
To: "Rosen Penev" <rosenp@gmail.com>
Cc: <netdev@vger.kernel.org>,  "Andrew Lunn" <andrew+netdev@lunn.ch>,
  "David S. Miller" <davem@davemloft.net>,  "Eric Dumazet"
 <edumazet@google.com>,  "Jakub Kicinski" <kuba@kernel.org>,  "Paolo Abeni"
 <pabeni@redhat.com>,  "Michal Simek" <michal.simek@amd.com>,
  <linux-arm-kernel@lists.infradead.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: ll_temac: Return actual error from
 of_get_mac_address()
In-Reply-To: <20260827012439.162651-1-rosenp@gmail.com> (Rosen Penev's message
	of "Wed, 26 Aug 2026 18:24:39 -0700")
References: <mWYTdXJIk1gD3_qHzfnWHAAyTs0Hh4I5P02_nisIqJdxRWM6DIMgOL9bIxaQqDTx37ldTpEm-0MsQQ3BWkTs9g==@protonmail.internalid>
	<20260827012439.162651-1-rosenp@gmail.com>
Date: Thu, 27 Aug 2026 10:46:24 +0200
Message-ID: <87ik4wymqn.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Rosen Penev" <rosenp@gmail.com> writes:

> When of_get_mac_address() fails, return the actual error code (rc)
> instead of the hardcoded -ENODEV. This preserves the original error
> information, which may be more specific (e.g., -EINVAL, -EPROBE_DEFER)
> and helps callers handle the failure appropriately.
>
> Fixes: 8425c41d1ef7 ("net: ll_temac: Extend support to non-device-tree platforms")
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/xilinx/ll_temac_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
> index 711ed9c2631b..81ec73e6e4c1 100644
> --- a/drivers/net/ethernet/xilinx/ll_temac_main.c
> +++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
> @@ -1581,7 +1581,7 @@ static int temac_probe(struct platform_device *pdev)
>  		rc = of_get_mac_address(temac_np, addr);
>  		if (rc) {
>  			dev_err(&pdev->dev, "could not find MAC address\n");
> -			return -ENODEV;
> +			return rc;
>  		}
>  		temac_init_mac_address(ndev, addr);
>  	} else if (pdata) {
> --
> 2.55.0

Acked-by: Esben Haabendal <esben@geanix.com>
