Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1DC3C417E
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781173634; cv=none; b=VOm1dg4JGTqcXTy/uBy7uFL2AW6KZqcPBgesap5DV3a0oEchlhf5+nOk5KvUW9Bx6AOEl+VsGFr2lovk2twllEqDZhhL/tka/8DrfMDsfMB29sMcM+vdx+BDixV3j0H6fKENHr4v7BE6WnfVF1kycuCaa2ZFjtUtKXa4UveUF5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781173634; c=relaxed/simple;
	bh=mGuWnBJ0YF4lIDVErJvA/dHQhHiT0U7xix/8Q58p0ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hpd5p4l6xZoXTaNdDvfcqyEGyE2FYTkjsHz3KaOI0Nu/EXhsngiVmQTmTJZnsuc5Y5li6grhnhx5Cl46LLfSMU2ZOIb5mcm/agOhNbJqU9h95tmjfqBu764n9ynqRuXHUYnoWhMUQ2WQUV/0zNxfoQno+KBrX7n3b7kqEruh9JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWPvu2My; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWPvu2My"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0361F00893;
	Thu, 11 Jun 2026 10:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781173633;
	bh=DzjtudXBoeDJMAmrpGr3WXAi/sP2pduwjgnBqvaHH8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eWPvu2MyRHUhkqDgQ7mrXD7ZjH8z2e1yojjtPmMT8cHxnucb6N5T3oMp7u9xEoN18
	 HBxqHLLmtDeiFHTOAWegGAsMc/K62I84EkY5Ki23cdjefDSo9EcTLtSrhfpfSzVDig
	 JdHYzz1fbRz7CVAFAXeFHC1LsoErs8iSApKdN+s3F6LyT7hPLA+WAhoqnqZaSDwCIY
	 g0MQk9+RPXm/ka5+RcjodUQbIWKHuomXjope1OOOuxV3Ql/bdpzx+pGAAWNZbNlERE
	 jxFh8+XrlDL2o9+/2pXbprwH5zyPG4RORbJ8ATa/ODcyXBVWrZo0spSr0RubLgEj5P
	 F2/sZjeHeqncw==
Date: Thu, 11 Jun 2026 11:27:08 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: move get_sport() callback at the
 beginning of airoha_enable_gdm2_loopback()
Message-ID: <20260611102708.GQ3920875@horms.kernel.org>
References: <20260608-airoha_enable_gdm2_loopback-minor-change-v1-1-1787a0f42b31@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608-airoha_enable_gdm2_loopback-minor-change-v1-1-1787a0f42b31@kernel.org>

On Mon, Jun 08, 2026 at 11:24:15PM +0200, Lorenzo Bianconi wrote:
> Move the get_sport() callback invocation at the beginning of
> airoha_enable_gdm2_loopback() routine in order to avoid leaving the
> hardware in a partially configured state if get_sport() fails.
> Previously, get_sport() was called after GDM2 forwarding, loopback,
> channel, length, VIP and IFC registers had already been programmed.
> A failure at that point would return an error leaving GDM2 with
> loopback enabled but WAN port, PPE CPU port and flow control mappings
> not configured.
> Performing the get_sport() lookup before any register write guarantees
> the routine either completes the full configuration sequence or exits
> with no side effects on the hardware.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

