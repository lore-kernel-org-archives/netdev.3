Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B621A521238;
	Tue, 22 Sep 2026 08:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066440; cv=none; b=ECkIbNryYYNknkQXb4vQPtPAm+m+n1Cs5ngGmZ/fs4TSuhpNkIIu5vPd9J+dGA6Jz4fJn0g0QEWH89W4Au9rxP4fK9s0c5TRADdJXmDTBK5CjuoRDJyIrkVKlPB5OjBQKNusDWpeEUe40UaCp20dqm3krA5NpnIgnIKaHaouc6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066440; c=relaxed/simple;
	bh=j+KwcXqBNYVOd8F1jgNTEgAGvrfQKSmMZwv3O6JX/Ls=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=uesinMEvJ8XSUas5LKC12QNei+baxB4B8BV8M0tNIkTMUY9uqjFZHuFVsNVHcXSXVonhPu5U7ewQ6VJDJg+Z83Fq1/6IfuPYMCpHMhNOS279/zxLrbo+KsUdiEdcxrRrWYRYikwAdPTMuTDR/R3zug2VmUgjwh2Ib7oqCZJj4bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=5EKzP+vE; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="5EKzP+vE"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 66DDBA48A8;
	Tue, 22 Sep 2026 10:40:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790066436; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Lpn4802mDFN1oIHUdnnPfgkOobcpbPp+Oe/46qmE5cM=;
	b=5EKzP+vERDMQYwJtyinfH7H9vqufUCqTS+djSOzpf5DVnICFdCFWxVCvetSMwzmTUNUnDh
	62rUH5FGivaniw7HdVbEA/qZXZpGXZk+GrSulR3SJ/aQR5IDkYHAe3XOStcdDtA9liRQPr
	XAT15ZwqNE1dPDhMEbf5bE3e3M2b2G7u/dRUuafxzM96qJA/gT2FNl1d7bAVTfm2DbmMmh
	ye/O+fWv+rfUlkqWGlvfsd5+lApPw+H0WvaQpAgYaB5B5eI3dsSPs2VP+Vp1msqvWxYH3M
	Mv6l/wSW/zeLiklRU78ICQqQBQnJpHQl+YQAfPgcqHlwTYGTx/+tiEX90vWSaQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Sep 2026 10:40:36 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Zak Kemble <zakkemble@gmail.com>, Simon Horman
 <horms@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 06/12] net: systemport: Fix RUNT MIB counter register
 offset calculation
In-Reply-To: <20260921231305.394773-7-florian.fainelli@broadcom.com>
References: <20260921231305.394773-1-florian.fainelli@broadcom.com>
 <20260921231305.394773-7-florian.fainelli@broadcom.com>
Message-ID: <e21638baa23c4dab20eeee9638cd19de@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 22.9.2026 01:12, Florian Fainelli wrote:
> In UniMAC hardware, there is a 0xC byte gap between the RX MIB counters
> and the TX MIB counters, and a second 0xC byte gap between the TX MIB
> counters and the RX RUNT MIB counters.
> 
> In bcm_sysport_update_mib_counters(), 'offset' was only set to
> UMAC_MIB_STAT_OFFSET (0xC) for all non-RX counters, omitting the second
> 0xC gap for BCM_SYSPORT_STAT_RUNT counters. As a result, all 4 RUNT MIB
> counters were read from unmapped gap register space.
> 
> Fix this by setting offset to 2 * UMAC_MIB_STAT_OFFSET (0x18) when
> reading BCM_SYSPORT_STAT_RUNT counters.
> 
> Fixes: 80105befdb4b ("net: systemport: add Broadcom SYSTEMPORT Ethernet 
> MAC driver")
> Assisted-by: LLM
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bcmsysport.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c 
> b/drivers/net/ethernet/broadcom/bcmsysport.c
> index 7f2e5e4efb8d..b69833d34bd5 100644
> --- a/drivers/net/ethernet/broadcom/bcmsysport.c
> +++ b/drivers/net/ethernet/broadcom/bcmsysport.c
> @@ -391,8 +391,10 @@ static void bcm_sysport_update_mib_counters(struct 
> bcm_sysport_priv *priv)
>  			if (priv->is_lite)
>  				continue;
> 
> -			if (s->type != BCM_SYSPORT_STAT_MIB_RX)
> +			if (s->type == BCM_SYSPORT_STAT_MIB_TX)
>  				offset = UMAC_MIB_STAT_OFFSET;
> +			else if (s->type == BCM_SYSPORT_STAT_RUNT)
> +				offset = 2 * UMAC_MIB_STAT_OFFSET;
>  			val = umac_readl(priv, UMAC_MIB_START + j + offset);
>  			break;
>  		case BCM_SYSPORT_STAT_RXCHK

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
