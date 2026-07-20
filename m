Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFB144998D
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 17:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784568971; cv=none; b=pEP33gU5sxvrDBIjK+IhMwnTgf9Hm3PETXoEp/ccjK8URCOUqhrRrks2JdQvTT26lrpx5sfx2R56398vH64BbERhpvS8rD44WFiJKWx7LYvQCdD8VikurDwylU4pqWnZHgoptRWSuh26M4JZN/FLrNHzRY4A4jSOCswNm7AC0No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784568971; c=relaxed/simple;
	bh=XvqjxVEYFtZM7+F4QxlCcaHs2r/6NKpbeEIcUhrpD3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fs7lnZZ4HbWOAJuY3TJr79hLZs34TwXntYpo4TVTubTssbMOzBEzMSgIgExvT88xxn+nJCEe+DULHL+Oc/2uzkAss3KzuveQS+iSFjB+zQSYvqpoIHhkQijt1ODjWcZZBZGuybAMqXGGcKyhJdmOD5Rlkw5EsQEcNeL1GJS/iNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=VnlFzEbz; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="VnlFzEbz"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cad4170e8eso143798925ad.3
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 10:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1784568964; x=1785173764; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bgJoRNuplp6eZlFzlFIl9nminZilm44pZn8iwP92+o4=;
        b=VnlFzEbzskJ/bacskUnlb4FZGWRGaRAyDXCuagGpgBa+MLvoTuL9jss3gaEmi5DcMb
         JIzkhejZpYG831mrGzA69IF52gQpnjd2Ps/R+62k5bE/vn0vKJmurHENou+cWtLDS8tj
         WSpJ/Q7x5vwPs+U+Afg9hdzZ87uIt8ziSd4JwkBNlo/qLIHocclwTurWTd87fmQm82t3
         UBLTIC+ELc6MlE300S+sL2Dalhnq1Lj1pAsx09itLsM2fUqDC2Bbmk59tyecHWA6MnbF
         bhm2t5vScK+64uNVyGeUzsHCw4QxnWVWf17PB3wL/ooM0tEJJvZjCsElyg+kg9TA0jNV
         V3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784568964; x=1785173764;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bgJoRNuplp6eZlFzlFIl9nminZilm44pZn8iwP92+o4=;
        b=WfPK0n5IiSLABuclc8LHLjLW3Av46nD5/9h26aYgIsO9WPsx1mpotlc/BlYEI/BoVz
         B3IWuvZRtwFYfZ6Qwdwz744GZD2zq1/5seaUJ+piJOy2KxUMS/xk7CubuuEl/DFC1TyR
         kiQspyIqkKjf0Y9GxSaSf93xDc5CRopyBWQi260S3DlJNSZaiGGoxmOS/ZZ9TSW/zrs9
         anGWfH7+gGW1HkKnDxz5wEabZoUh2coIODDUOe6iyofJ2Nz1vJKs21eHaZijmvQ3vX/q
         AJWVIop8YZe6ZZT21vopAC5ReCSiPsZGIgFPLbRJvKM7M3pmT19m1EvYbUZ0wgyq1/aR
         H4Qg==
X-Forwarded-Encrypted: i=1; AHgh+RrOENAf9tEt0ntCEgyMguPMJQWcc4B0It0ItI7O/GbLiAbxoWBqekZX3vRwu8w5f1qGELBO8yI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXPXCkilj6UAOu3rZvnZBe63bsrf5jBjd9asFGplBM7+n+bPnl
	2SqEgOIU6d+sfku4mlkX/+XIE32RY74DKteVipue1rkW81a9sZl6Bg8w/+qcoQmMsreA+iTwX2T
	Ay28+NQuXyfAI
X-Gm-Gg: AR+sD11kAp0HFHT+UsLtjtGH541p6hEYj0kDmctOhA3EdAkQs8PJMQAe75+SLCsKOHX
	9w+gJAbbycnyoVx9ABMOQpBj9kn3gpMpVEFTAPkOySWqPx8BKiTkw2N1KAkgOobWUzab3x3hCoX
	1jZF+nIOJi6BbyDdZRkjs5KXHCfnc2bqwBeWYTQmcrMnI0b7BGLALQGoJB2xSjy31D20/kSJaWr
	OP2SjbocUbz8hIoGdaV/Sgyarym0+eafzag88t01xFlRr4pLeCaPtDCxnwYxL7EtSoK1MGULRRG
	nVNp1Ys+7Fs3kiwAQn+BgJ58NhkdZXo+kKHnNTyj4K/JcAkF6IC2G00E0CSyAD2TKDi8SAHPR7D
	kd05avNDppLzKzl2nl1x4RzSxAHqCWxf64NhjQMnDZnO7VVo6DWnwFI+Y2vg=
X-Received: by 2002:a17:903:986:b0:2ca:53e9:1277 with SMTP id d9443c01a7336-2cf348193e8mr159265115ad.1.1784568964287;
        Mon, 20 Jul 2026 10:36:04 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:53::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3476f70esm60110235ad.77.2026.07.20.10.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 10:36:03 -0700 (PDT)
Date: Mon, 20 Jul 2026 10:36:02 -0700
From: Joe Damato <joe@dama.to>
To: wei.fang@oss.nxp.com
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	wei.fang@nxp.com, chleroy@kernel.org, maxime.chevallier@bootlin.com,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RESEND v4 net-next 13/14] net: enetc: use
 alloc_etherdev_mqs() to create netdev for VF driver
Message-ID: <al5cgs6CqVKsy/gh@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, wei.fang@oss.nxp.com,
	claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux@armlinux.org.uk, wei.fang@nxp.com, chleroy@kernel.org,
	maxime.chevallier@bootlin.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
 <20260720014317.1059359-14-wei.fang@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720014317.1059359-14-wei.fang@oss.nxp.com>

On Mon, Jul 20, 2026 at 09:43:15AM +0800, wei.fang@oss.nxp.com wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> The VF driver uses alloc_etherdev_mq() with ENETC_MAX_NUM_TXQS as the
> queue count, which forces the TX and RX queue counts to be equal and
> uses a compile-time constant rather than the actual hardware capability.
> 
> After enetc_get_si_caps() is called, si->num_tx_rings and
> si->num_rx_rings reflect the actual number of rings assigned to the VF
> by the PF. For the ENETC VF on LS1028A and the upcoming i.MX95/94, their
> SoCs have no more than 6 CPUs, and the number of TX/RX rings allocated
> to the VF is less than 8.
> 
> Therefore, switch to alloc_etherdev_mqs() so that the TX and RX queue
> counts are set independently, each capped at ENETC_MAX_NUM_TXQS, based
> on the actual number of rings assigned to the VF by the PF.
> 
> Note that if future SoCs have more than 6 CPUs and more than 6 RX rings
> allocated to VFs, the size of the int_vector array in struct
> enetc_ndev_priv will need to be modified. Similarly, if more than 8 TX
> rings are allocated to each int_vector, ENETC_MAX_NUM_TXQS will also
> need to be modified.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc_vf.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> index 9cdb0a4d6baf..7dcb4a0246f5 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> @@ -317,7 +317,14 @@ static int enetc_vf_probe(struct pci_dev *pdev,
>  
>  	enetc_get_si_caps(si);
>  
> -	ndev = alloc_etherdev_mq(sizeof(*priv), ENETC_MAX_NUM_TXQS);
> +	/* Currently, the supported SoCs have a max of 6 CPUs and the VFs
> +	 * have less than 6 RX/TX rings. So no issues for these supported
> +	 * SoCs, but for future SoCs which have more CPUs or more TX/RX
> +	 * rings, all the related logic needs to be improved.
> +	 */
> +	ndev = alloc_etherdev_mqs(sizeof(*priv),
> +				  min(si->num_tx_rings, ENETC_MAX_NUM_TXQS),
> +				  min(si->num_rx_rings, ENETC_MAX_NUM_TXQS));

Code looks right, but looks almost like a typo. I guess it would read nicer if
ENETC_MAX_NUM_RXQS existed?

That said:

Reviewed-by: Joe Damato <joe@dama.to>
