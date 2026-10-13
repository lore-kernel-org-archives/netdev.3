Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D800251EE14
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 21:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791928219; cv=none; b=ebJLsq7vnBatkEahm2HDSmGkL7dsRpNeNfkXgxdrG4KdgMHhUKCKA1ZHCLQVS476KGr1Pnens3BxNZwsF5ztdR4clnmriuCdPRPUf/ypZ/Jl9UruWImVM6X1jmkS8XfUih+97TsA25nFy7AHfuyAUqE5jAievD0jUW+Muj/4+XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791928219; c=relaxed/simple;
	bh=4W8XYeV6wWHSI3ONLzPLBeMyG/3dGElS/TVuMLGb6vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrmMMeALfc1yijlvNb0PUBY2E0qLijHB6MQthVNpqDTFWCZJ6nSih2A+g2n4khAeDMi1qlwZmg3vC7MV54yx9ay5oJ1JNusIZEXSVlwLVS1cGbct+bSE9RMK2qSrPA2V3J5YqszT+82GsoNxPmBO5MF21Uq4JoHdgQpCeNo6iXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=TYNosL4k; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="TYNosL4k"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5337fb43c16so37478851cf.3
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 14:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1791928217; x=1792533017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=goavh/XGokBAgELvjlyLn5UbPVFLi7w6hR6sFpVVAsg=;
        b=TYNosL4kCdLGQi5TIFIIjTndQb8tLM5uYYzLySIpnVECaNeYfVkk0kc3ZVdxQKtJOO
         3Epf45zl4gqUnFmX5UffffyYb4KHeH4to2HT11syibrdl1q6RLz4niKR9LyLjFtLvd4H
         Jj16uDFBknX3+UPR7W2XbI2JVss+/kPAKxKqWmxn18hW3uKJue0TXpsP/hwtjL5DAq6B
         gQ3slojTxh9PID6acQH12UwbbyKaPFv77kkgBfuBlpIV/ZjVvvxFuL49OTvTvUnSS/G0
         dvw4V9bq4Uhpes6QuDZoaNJx0MxlyVTK6X4GZ9Byv+C1jd0UrYmkBegRXlZ66/Hd+ztx
         RFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791928217; x=1792533017;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=goavh/XGokBAgELvjlyLn5UbPVFLi7w6hR6sFpVVAsg=;
        b=WGyRhIkm32y7HaP2EBYiY1LXk7T9mdi/mCqZJZRI72n4dtdrofgL2LAoCEV6f0qX46
         ZqM8HsDvt4+pWd/2k4cLPe0NpDjxlqnMvbn5fCQwSaqwthtoOA8UPy7xpEqWJ6Mz8F38
         oWrg+/ON5MZhDhAeW93K7Y1TvF06mX/hYr07osxfLt2RQn1tRhV2DSU6FoZNVNODdi4X
         55mY29IrRLTve4yzpxM9RGPpWGkYpep8kAQXDRmzcl6zhsEHa2ThdFHa+AS86pt9FWaR
         r/GG1rTigdLKBd9rYsSG54wcljS+3ZsDKu8Fedyhvo2jTbWR+LM0ZuIhR8xKkcUlwI7a
         JE7Q==
X-Forwarded-Encrypted: i=1; AKwUvBzrDs11CXcwvWJyzuMhRlLKD2Q6StqmZ+L32qx8b/W0WdNvx2kcSh/uqeyE2jcg/nX8NlVS1+Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYLSRHhdMMH3VCuBXcACosqi4mX4piiVo6DIui02IY2QfO70seir
	1Dk/lOMvfwZCTTgSqnRq640dvGotEDzap4hPPBMjnuh2aQizC2DAdLQR7nLh2swtvk0=
X-Gm-Gg: AYBFou2aE5R2E4IbjAz+cMoXybetSt6goyoBU9CKbqUIHZ1PubWj4DmToZq6odA2KTx
	RbNSb3aQ2pifPmCYxsMCjwZj3dW2k34PacfQ95heg2NkmQ8pta1JRi/Pd1GcQQzuRXz0NclK2Fy
	AKR1v4Ww8p0hNL6QlZI0ASqDMSG85ju8G1/1KIlQzOsTabPa5dqjGaMHEmJtXnZLhjs6mYsi+DT
	MJjjTNNr7xk7n1zOuBHu4T2GYEvWknnokP9LqKBdWy8oOwguM+Lo9Ev+JMu1z5tFCIeskbg2zcx
	AdleTpgZxAZehhP0MpCX3gRtASX+/dG6qh+3iodaul8CMS5y+jraej/hbqlND+pGFCVyPUOCix6
	oXKo59euGQq7NBSRUawWLvinmjxM9EhiuZDH537Uw/vtoxXLAj/TBYNQRUVXnOibetRS3TD85sb
	npinVWHU4g2l9eaXU4uiTUaeQKZ+SKidiQXKyJ5WrYChXO1J/Vi5L8tFQntY3dtWcwLK/qH86KT
	fqx4YMLlv0WdgQr/X3KoDhyjbbBd8/h+u6of0OcaQ8ZrSt5oTIEFcY=
X-Received: by 2002:a05:622a:228a:b0:533:8f29:e5fd with SMTP id d75a77b69052e-5359fad06fbmr209862231cf.18.1791928216595;
        Tue, 13 Oct 2026 14:50:16 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-535ddeffadcsm44382451cf.31.2026.10.13.14.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 14:50:16 -0700 (PDT)
Date: Tue, 13 Oct 2026 17:50:13 -0400
From: Gregory Price <gourry@gourry.net>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net-next v3 7/7] bnxt_en: Fix ring accounting and
 validation when rings are constrained
Message-ID: <as6mq_WLUJ-SiXI7@gourry-fedora-PF4VCD3F>
References: <20261012220827.340998-1-michael.chan@broadcom.com>
 <20261012220827.340998-8-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012220827.340998-8-michael.chan@broadcom.com>

On Mon, Oct 12, 2026 at 03:08:27PM -0700, Michael Chan wrote:
> When __bnxt_reserve_rings() reserves fewer TX rings than requested,
> and an XDP program is attached, the driver used to blindly subtract
> bp->tx_nr_rings_xdp from bp->tx_nr_rings, potentially causing an integer
> underflow.
> 

This is outside my normal space, was reviewing this for testing and had
an agent spot what it thinks is a bug.  It seemed reasonable to me but
if you think this is wrong, please ignore.

> @@ -11602,25 +11673,23 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
>  		if (!rc)
>  			rc = bnxt_init_int_mode(bp);
>  		bnxt_ulp_irq_restart(bp, rc);
> -	} else if (irq_change && !rc) {
> -		if (bnxt_change_msix(bp, irqs_required) != irqs_required)
> -			rc = -ENOSPC;
> +	} else if (irq_re_init && BNXT_NEW_RM(bp) && !rc) {

should this be:

       } else if (irq_re_init && BNXT_NEW_RM(bp) && bp->irq_tbl && !rc) {

Note from the LLM was:

  Unlike irq_change, this no longer implies bp->irq_tbl != NULL.  After a
  FW/AER reset irq_tbl is gone but total_irqs is stale, so if the rings
  shrink we call bnxt_change_msix() with no table and fail with -ENOSPC.

  Should this also check bp->irq_tbl?

~Gregory
