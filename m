Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EEF40D595
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 07:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782373022; cv=none; b=uwCEUUCHykeRobxFLHbjO7UZjmCrRWKdLHy+ZUBpc3j9cTI0hwhhHEJXzv03Og8KjwUC65DNRupWncZVwfPb6YP/hjWxlsGZxV+nnL3bCRCpQDMa1NpSjFTcBqtZcTcOhuVeTZPa6ESFFpvuL+wYDhuRu69GRTTrac1TwFP9+9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782373022; c=relaxed/simple;
	bh=K+xei74GjQBfLgo9TrmbCdxyVBk3k9EcuNOxbDd+f78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rTsDzanqPmpH4wVsiTFjT5HcmljYOmLQAhulRs/y+ovoA/j+sZuii//YpBFhYxxSu8u3khZMNsQXrBT8oL3uwIanxJSnVooh9f2NdPsLfGTccMGBgDGHWPS0/kBMr1XGswiSEMT7Jm6lawOoldjGOa+aeotFnGdVMOK6wSfnH+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=G+Lrnyun; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="G+Lrnyun"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0977A1A08FC;
	Thu, 25 Jun 2026 07:36:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D08315FF03;
	Thu, 25 Jun 2026 07:36:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E9019106C8442;
	Thu, 25 Jun 2026 09:36:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782373018; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=CQKNNE+ysP6hZ4N3+rq7u/CP8moMd0AcqYlMGT2Ifxs=;
	b=G+LrnyunLLl7KMAc8zgTIEX3UeqNUnJuWBNHjsDyj/b5sTzk7kReVzHgrm929nNwTLVZpq
	c8FzpuAVBG253rVzwbUiQeVvG4Xcd5008C6h6/tUie2kRIcXYEp7NhN+jcu2pxb5DN55lV
	V2NaJt8GsuTvOdFcpRohyXObzsV3AS3m545DhOBMxXaZxacHI22tDI48wYSGcaX4eGdQjT
	C/VpvXT1BRK2F+rf2vOSJyKBn0Aw2gzmVRBV2xAA6+xdTe8sNvvjSsISOKcDVcwBYjQUxF
	WRMS7k8cj50Fy6EVhRcuWRjk9PSusrrxuNzgz+KrGl7sHrHAHAHowJBd7RtNiA==
Message-ID: <d24cd9a3-7825-4739-a5e7-8d3a8345451e@bootlin.com>
Date: Thu, 25 Jun 2026 09:36:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: pch_gbe: return errors from MIIM accesses
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260625030503.93588-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260625030503.93588-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 6/25/26 05:05, Pengpeng Hou wrote:
> pch_gbe_mac_ctrl_miim() polls for the MIIM controller to become ready,
> but returns zero on the initial ready timeout and ignores the completion
> timeout after issuing the operation. MDIO and PHY helpers can then report
> success with zero or stale data.
> 
> Make the MIIM helper return an errno and pass read data through an output
> parameter. Propagate the error through the MDIO read path, the probe-time
> PHY discovery path, and the internal PHY register helpers that already
> return an error status.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  .../net/ethernet/oki-semi/pch_gbe/pch_gbe.h   |  4 +-
>  .../ethernet/oki-semi/pch_gbe/pch_gbe_main.c  | 54 ++++++++++++++-----
>  .../ethernet/oki-semi/pch_gbe/pch_gbe_phy.c   | 22 +++++---
>  3 files changed, 57 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h
> index 108f312bc542..4bdf0afca462 100644
> --- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h
> +++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h
> @@ -619,6 +619,6 @@ void pch_gbe_set_ethtool_ops(struct net_device *netdev);
>  
>  /* pch_gbe_mac.c */
>  s32 pch_gbe_mac_force_mac_fc(struct pch_gbe_hw *hw);
> -u16 pch_gbe_mac_ctrl_miim(struct pch_gbe_hw *hw, u32 addr, u32 dir, u32 reg,
> -			  u16 data);
> +int pch_gbe_mac_ctrl_miim(struct pch_gbe_hw *hw, u32 addr, u32 dir, u32 reg,
> +			  u16 data, u16 *read_data);

You should look and replicate what other mdio accessors do, that is return a
negative value on error, and the actual value otherwise.

Maxime
