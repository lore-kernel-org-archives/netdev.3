Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1162E3DD521;
	Mon, 10 Aug 2026 12:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786364159; cv=none; b=Uu6WebCJL0nrfWGkEQ3tu1POl76YdKesrxi176CREiYMZjXCUZ8QgCvYF5u517QPAV9uHrbhxUHMpgzNee0j25jAsYYysW3kH8kezdl5TrB8sj76fJfetSO+YHT5i3wJI2jB3kH9k8abPndNvlmYNTZ6IpoAMA+BPlC3X7FAD9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786364159; c=relaxed/simple;
	bh=NdCY1kg6TjXHzGlB7lroW9jsdt1+mSzUmlKxw7zzyV4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=l0KlP1z0oWmdheBIZYKeq93SF9DgATwlsvxKdDP+o0Nd1QmXUxYzfKiXvPkZd4YX9a0pqAp49yD6GH9FL9u+6BdoOiTWq2aVy68z40QnvwvUDI5vfVvTKdyDN43AySgYSpIqD73JcNcjDLgofk6xnjiamDX87ncxOohJOucpils=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=40GwL8PH; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="40GwL8PH"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 90F73A0298;
	Mon, 10 Aug 2026 14:15:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1786364153; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=tzKUSUn1eo6y2GFuYc9vg0FYFrYduOnEQTdAJdR1LQc=;
	b=40GwL8PHXWmDDjJ2ygFkzqvo9J73AfYfQ0de44QFCS09UgNZIfdOY7UWgBZZgBAZBMDN5g
	6e5G7y8GawkPU/wm5qCQWCnW2anGIQECZkUtrCoGxZUtnOmhrRIHfyCRhOTi8xHl/7pE0v
	OCCTYpHsAOks2b1kEkA8fmMeMQg8Mf7Baglrz6psocIwq/hdVpedW86F0NLFOqZCIoLtRZ
	OHP5ordl57Ax6HSo20XI/+G4pDDOoSOw+W9QdsFCK9Z24bSEVdT5l9ootj14eUB6wim7Kd
	BvfLICTr+7XXu21UmwYcoZslZ8lub0i1vsQ3SYirPCg2FY713UiNgDyAdsrRLg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 10 Aug 2026 14:15:49 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Sandeep Sondagar <sandeepsondagar@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King
 <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Gabor Juhos <j4g8y7@gmail.com>, Robert Marko
 <robert.marko@sartura.hr>
Subject: Re: [PATCH net v3] net: phylink: treat PSGMII as an inband capable
 interface
In-Reply-To: <20260809-phylink-psgmii-v3-1-908dcd3a9e3d@gmail.com>
References: <20260809-phylink-psgmii-v3-1-908dcd3a9e3d@gmail.com>
Message-ID: <75833aa7355f578a797d8dd4e75f3d1e@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Sandeep,

On 9.8.2026 18:01, Sandeep Sondagar wrote:
> PSGMII (the Qualcomm 5-port SGMII) conveys the link negotiation result
> from the PHY back to the MAC through per-channel in-band SGMII words,
> exactly like SGMII and QSGMII.
> 
> However, PHY_INTERFACE_MODE_PSGMII is missing from
> phylink_get_inband_type(), so phylink reports INBAND_NONE for it and
> phylink_pcs_neg_mode() falls back to PHYLINK_PCS_NEG_NONE. The PCS is
> then programmed in force mode and its control-register speed bits 
> (which
> default to 1000base) are used, so a slower copper link - e.g. 100base-T
> - is reported as 1Gbps and cannot pass traffic.

Out of curiosity: How has this been noticed (eg. which board / 
platform)?

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
