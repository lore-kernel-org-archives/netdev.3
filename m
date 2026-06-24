Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64BB350D74
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 19:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782330859; cv=none; b=R0gip1B+tr2yQay5HHY1mp9IDVpYIU5QIaH0Hj16W9934njnbgvnhWDm9ZwavfDh+lMHOfkwjTMwl8nIk7vUKK8/sKMzhpb6jAxmoqb4FK+nqgbrOsc2gWioMZfOMiRiz7uswvK9LTRecbry4dno+Cx6+qB0oURj1EE4oFT3V9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782330859; c=relaxed/simple;
	bh=7h5+VEro7G8okEq0uHPHqpm53HOl48eawseBPaMFH0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a0TE9raOKG4Vos8UwBzcjK5aGHqqzkjQ5XrlYfanoNBXcetCbea8ZHr9AeJC/X9WG7tdpekFDJJXO2HI7bJ4BQaIGo/pe3/bGOtklWwp/t1MZF0nhmsJAUuaaiHSDGhXr7bDbHwgBOcljryJayrhh2+Hex8cxg2Sv3FicCfLLGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZVsJXns8; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZVsJXns8"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5179D4E4080A;
	Wed, 24 Jun 2026 19:54:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1C0A0601C5;
	Wed, 24 Jun 2026 19:54:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B6338106C8193;
	Wed, 24 Jun 2026 21:54:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782330853; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=7eUr3GT5ghymbnln4VqdpvNiu90Hyp11G4R7f2aRLLM=;
	b=ZVsJXns8TfXgMGOK6zMp6NILPd+2bot0d+a+330BwgBqOgX4Y0k5J5UsuYsI82WnD9UUVM
	XJcDeB4owI5oYYjqG5YYZNC+/ar+GsJiKhlGa5m6E0KZCsYXTN6Xa3Ns6RVS+zgvXgVdNN
	G7TepgdRIBLsJfuQyBZrgfwpUqwWhWuYnyxv070htofGSBCokEjCUTP3C/FrCk0evR9iWb
	j0sEWsDHgrGYnvuHGCrTqbuMr4Ss3fL4NovpDuZ0txxw8rd18mZBJv7qKgiMgytnVkj5l3
	LWE9/Wpi0h8bktjDhhLZKOHWIsQANRSvRmIJ8rb00hz9RsZW7+gp0SP5UaA6KA==
Message-ID: <45cec67b-3a75-425a-87a6-018d8d0ab77c@bootlin.com>
Date: Wed, 24 Jun 2026 21:54:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: enetc: fix potential divide-by-zero when num_vsi
 is zero
To: wei.fang@oss.nxp.com, claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
 xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: Frank.Li@nxp.com, wei.fang@nxp.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260624072726.1238903-1-wei.fang@oss.nxp.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260624072726.1238903-1-wei.fang@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 6/24/26 09:27, wei.fang@oss.nxp.com wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> For i.MX94 series, all the standalone ENETCs do not support SR-IOV, so
> pf->caps.num_vsi is zero. This leads to a divide-by-zero in
> enetc4_default_rings_allocation() when distributing rings among PF and
> VFs.
> 
> Division by zero is undefined behavior in C. On ARM64, the UDIV/SDIV
> instructions silently return zero rather than raising an exception, so
> the issue does not cause a visible crash. However, relying on this
> behavior is incorrect and poses a cross-platform compatibility risk.
> 
> Add an explicit check for num_vsi == 0 and return early after the PF's
> rings have been configured.
> 
> Fixes: 2d673b0e2f8d ("net: enetc: add standalone ENETC support for i.MX94")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> index 4e771f852358..437a15bbb47b 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> @@ -322,6 +322,9 @@ static void enetc4_default_rings_allocation(struct enetc_pf *pf)
>  	val = enetc4_psicfgr0_val_construct(false, num_tx_bdr, num_rx_bdr);
>  	enetc_port_wr(hw, ENETC4_PSICFGR0(0), val);
>  
> +	if (!pf->caps.num_vsi)
> +		return;
> +
>  	num_rx_bdr = pf->caps.num_rx_bdr - num_rx_bdr;
>  	rx_rem = num_rx_bdr % pf->caps.num_vsi;
>  	num_rx_bdr = num_rx_bdr / pf->caps.num_vsi;

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime
