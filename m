Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793731742;
	b=V1utNa0oP9iMxGzvOB84WoddiUIO9Vu/mOq2JPl51ve1sglc/vafqSZHEeQH5lBX3bfa
	 3euETIAAg6O+20hEalgPGoJcIwFEd/NfiyHbEDobMNPXaYg4CP4SgKMgdYfv+Tn0Nt/N6
	 bY3gUIfsftikbDQ9CK6y/CdMjhyEktHitA9jf8EphHTBNYMnS73PeTE26GUwtIL3WbP1t
	 XxTIPnRPzxvKsTP34dNPe3RBYpqw3hVIrb6NU5dg+MxKmkvpGyK5E6EgRPYOYKK/L+JvF
	 UEsdoTADuf/qjmTt9suJwb7tKIr/ZTqztoAw3leHbh5bsFfvYVeWURFvss8lArbbcZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793731742;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gZOM3Lc0bVWMBjTHBnWLKucS3KUPQN4gjQNABudBe20=;
	b=DcK2EplyNJ02r9ARhCuQDIj7yzH6V/q5jTQzbiZKRymxDFiHvLSiedqES74bpszf/WF/
	 l7iKerjR00/3xP+i1CePtYk/n+g6u7CEheXhoQDuUndo8K2B8czwJ9YrOX85nV5jFGHFQ
	 sOK4sHrT13P4/tS0I4Ml/FhfliPqBwX65q/7nGKlzJ82x8taE9Yn4T9ngBPQ5FSHFN2Jp
	 dfTWy7lxEkNdreRt+9FYRk15Hq8FxAmFuzbThfFCD7uCcvdPZc1k1sHIEHtsGSyF1N3Ij
	 OwoxdV3IzH0HA/TfblKnVvdwVs6AqPSRlLSYp4P4M5BxS/JiD33vTmZIEVA62YgPSyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dama.to;
	spf=none smtp.mailfrom=dama.to;
	dkim=pass header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=l2wyXFYq;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644CF606A335
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 18:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 644CF606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=l2wyXFYq
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d577so3331293a91.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 10:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20260707.gappssmtp.com; s=20260707; t=1793731741; x=1794336541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gZOM3Lc0bVWMBjTHBnWLKucS3KUPQN4gjQNABudBe20=;
        b=l2wyXFYqZ38HdD8weK/KapS0MavCwUQNm5m8p8EfD+xcRcfXIyTrWWCNYRgp+/vQ0i
         ksJeEnZRdauMXUDBIZc/C71nEF+uDmJu0b2vpkgdxljq1Llv0dVefDe8tt/GoIUKxdDi
         3xRF0zFO9MWrdxdNUCyRSdqrWItJMZuhGMr20/CjBv3vMHjFjcO3YJ4KB2UcGkjbav0W
         m1relR/fPR+6ZF2d2H70rXUjyAYD34Uf84QZMC23/6a0tilojHf/umSUEE2/WXKUOb8Z
         NKpSimujPUoPOAcbNR09PhouGBvrnhvrxiWmGn8meE7bZMxPXPfKrnVl4uhWDJVGvnIm
         iNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793731741; x=1794336541;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gZOM3Lc0bVWMBjTHBnWLKucS3KUPQN4gjQNABudBe20=;
        b=X+z26rwx8IHVmXi0YLgI00Ll91jWCXMTWIwxhXKuZp2ktHA2YhcScfaCMSdxJdw267
         LazzhuXLIhqgshwCoCAU0niuxZTRIv/mHdpa1YKtKNCH31KuCLO/zxdtXcG8xPYW1R1n
         taP+wS1nSd30czj1TMqV/ceGGevwo3/GFDlC2Ih/WEWWkYZrri7gT5+WFvIJavL+nzII
         799hGTZsQ6bd2SkMfXkJWzTpj2dsNr04CmvTvM8G7JwEAXM/2EH6x5vWNFBAFj1XBC8l
         mboeoWuJh8HN6RyP7HbHFuYMUNm3QBqM7WYeqNSoY75GOheeFYN9Rbvbjf+iknZPojTl
         S3Ng==
X-Forwarded-Encrypted: i=1; AKwUvBzxZHyKCCTSoAc3PIlulOWRX61qSR4Y8mctIwdjxdPCDnBvfJN0JdwIkbpMz1k90sJP2eruhxk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+W6NRFrD9WubvNdQm0Y1SdGO1IEdf+04JbMWxkmNeq/ZoF5Kze
	EJNn+0PIPj0XZ4e6DrHWH3Veag4Mc7tCryFjcrQs1JouatRXTnEdwKpFASbFt4atU8M=
X-Gm-Gg: AYBFou2thATcm2/IPfZw6wsGZyhIWLdY2fm97XXIkjojWcXQsRFj4+iKEMrqL9SO5bo
	0rOcxo4mQPTR43/2K8BdP/felEndxHIjKMiE2G9E5nlXZM3eaxIS131SYKNWD5W33UL5JpU3SUR
	5Z8HK3W9d0LihR6yud84ws1hMvkzFEehNPtHQ0DXAQsmTRy1jyJQS9kHXdknHARbbkDDNiclsDC
	6ah4D2XZgbl7bxCRyHGXPHDpfS6VEX++/wZ0vzFw2XCQ12Cf1ZGEsKuE4CWJDiLpk+CxIGQ/EUC
	Zhf0Aw7OaCyeyn7nG7/O/TcQ6FHHmbRr4S4QVMwJJWz+xmJ9vZmhSEhLrDqQO1bVrQJ/PTDnY4d
	HrOKrX0yoDcyI6wx65STF0chO0TfZj9iwHW9qyiSj6RTR3JQZqbrwAjxGhmCmmKQHGg83eqJpHK
	5atMM0BtzXVv/l3VBLYmEgpnR0seXrLoxUJLxrSs3gZUAxbIRkbDQ/3VB/2n8exvvK7FBslxSVV
	jh54KxHQCiQMMzDQRJss+V5vJWBnJGjGv3z6PgGpV0nDGi0scBk0BCv1+UWiARPDHzQnnWF/LLm
	4yFasweHzm1szzSFg0kSEkMqHaMv1BchJgaujcEezg==
X-Received: by 2002:a17:90b:1d03:b0:3a8:49f2:8ddb with SMTP id 98e67ed59e1d1-3ae8984de33mr11985967a91.60.1793731740597;
        Tue, 03 Nov 2026 10:49:00 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:49::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0944bd88bsm210133a91.12.2026.11.03.10.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:49:00 -0800 (PST)
Date: Tue, 3 Nov 2026 10:48:59 -0800
From: Joe Damato <joe@dama.to>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Frank Li <Frank.Li@nxp.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Li Youhong <liyouhong@kylinos.cn>, Arnd Bergmann <arnd@arndb.de>,
	bui duc phuc <phucduc.bui@gmail.com>,
	Yicong Hui <yiconghui@gmail.com>, Simon Horman <horms@kernel.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	"moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>,
	"open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:ARM/QUALCOMM MAILING LIST" <linux-arm-msm@vger.kernel.org>,
	imx@lists.linux.dev, vkoul@kernel.org
Subject: Re: [PATCH] net: dma: use dmaengine_desc_set_callback()
Message-ID: <auosm8mCULyafyny@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, Frank Li <Frank.li@oss.nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Frank Li <Frank.Li@nxp.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Li Youhong <liyouhong@kylinos.cn>, Arnd Bergmann <arnd@arndb.de>,
	bui duc phuc <phucduc.bui@gmail.com>,
	Yicong Hui <yiconghui@gmail.com>, Simon Horman <horms@kernel.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	"moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>,
	"open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:ARM/QUALCOMM MAILING LIST" <linux-arm-msm@vger.kernel.org>,
	imx@lists.linux.dev, vkoul@kernel.org
References: <20261102191922.4044912-1-Frank.Li@oss.nxp.com>
 <aukcoWLVvSorX5a9@devvm20253.cco0.facebook.com>
 <aun4W3dvmfWRDFeQ@SMW015318>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aun4W3dvmfWRDFeQ@SMW015318>

On Tue, Nov 03, 2026 at 09:06:03AM -0600, Frank Li wrote:
> On Mon, Nov 02, 2026 at 03:28:33PM -0800, Joe Damato wrote:
> > On Mon, Nov 02, 2026 at 02:19:16PM -0500, Frank.Li@oss.nxp.com wrote:
> > > From: Frank Li <Frank.Li@nxp.com>
> > >
> > > Replace open-coded assignments to callback and callback_param fields
> > > of struct dma_async_tx_descriptor with calls to the
> > > dmaengine_desc_set_callback() helper across net drivers.
> > >
> > > No functional change intended. Prepare to make struct
> > > dma_async_tx_descriptor private to the DMA engine.
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  drivers/net/ethernet/allwinner/sun4i-emac.c       |  3 +--
> > >  drivers/net/ethernet/micrel/ks8842.c              |  6 ++----
> > >  drivers/net/ethernet/xilinx/xilinx_axienet_main.c |  6 ++----
> > >  drivers/net/wwan/qcom_bam_dmux.c                  | 10 ++++------
> > >  4 files changed, 9 insertions(+), 16 deletions(-)
> >
> > [...]
> >
> > > diff --git a/drivers/net/wwan/qcom_bam_dmux.c b/drivers/net/wwan/qcom_bam_dmux.c
> > > index cc6ace8d64371..1479f8362e04e 100644
> > > --- a/drivers/net/wwan/qcom_bam_dmux.c
> > > +++ b/drivers/net/wwan/qcom_bam_dmux.c
> > > @@ -195,9 +195,8 @@ static bool bam_dmux_skb_dma_submit_tx(struct bam_dmux_skb_dma *skb_dma)
> > >  		return false;
> > >  	}
> > >
> > > -	desc->callback = bam_dmux_tx_callback;
> > > -	desc->callback_param = skb_dma;
> > > -	desc->cookie = dmaengine_submit(desc);
> > > +	dmaengine_desc_set_callback(desc, bam_dmux_tx_callback, NULL, skb_dma);
> > > +	dmaengine_submit(desc);
> > >  	return true;
> > >  }
> > >
> > > @@ -477,9 +476,8 @@ static bool bam_dmux_skb_dma_submit_rx(struct bam_dmux_skb_dma *skb_dma)
> > >  		return false;
> > >  	}
> > >
> > > -	desc->callback = bam_dmux_rx_callback;
> > > -	desc->callback_param = skb_dma;
> > > -	desc->cookie = dmaengine_submit(desc);
> > > +	dmaengine_desc_set_callback(desc, bam_dmux_rx_callback, NULL, skb_dma);
> > > +	dmaengine_submit(desc);
> >
> > I noticed in the above that the return value of dmaengine_submit is discarded
> > instead of stored.
> >
> > Is that intentional? I suppose it might be because AFAICT cookie is never
> > used and the commit message says "no functional change intended".
> 
> dma_cookie_assign() already set desc->cookie in dmaengine_submit(). Of couse
> it is not obvious. Do you need me update commit message to descript it.

Ah, I see it now. In the tx_submit callback it looks like dma drivers set the
cookie.

So removing it here really is a no-op since it was getting set, as you said,
during submit.

My mistake. I don't think it's worth respinning just to fix the commit
message just because I didn't dig deep enough :)
