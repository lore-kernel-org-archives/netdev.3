Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.245.243.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336165;
	b=ZZj7k1XhE0+ouIAJO5Y3AAE8OZznFR8hjOhzacVLiKeMlF1hObiQfvcimeRgQTIscTBG
	 DpEACyZ0r0oSJOO8HjnVsF4Gxv78fqO6RSVsTUN7vseB8XCXMA8LU0v+OW6Y4IKLAzR67
	 5rSufVEQ+RCuyi5U2aCRPCHnmV1wmCD24H+lrW99r4zaXb38ujjy3cQUBRbylPFoUz2A7
	 j2A+8dkR25j0OuCWaCjdhSjCUFeRaE+ejw5urF0ZxqloFeSleDkvtC3TLuZKz9mXZnsFF
	 GtZBD6m3goXH/+tpWMmzKlBdToOTSBjvViaYCNro0ylfS+rBRFM6Sc3NPfSi3mqPugw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336165;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 CC:In-Reply-To:References:Date:Message-ID:X-Mailer:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=RNCN5fuEZC8EX4CP/oT0x0PyhNw1msLPDBkN5IfGv0w=;
	b=KNrmCfWGtJ2jHsLMBYD72T2q0z46n0dahVCe0ibyncaNAGaN+YCdEVDtq2/TF4Q1Z3Vr
	 Kzc9j001QYiOTWW7bszuLFwGTUdVWcHpM5YJIgW1KhO0LpvTZiNABVY2fGdMyOldF9YLx
	 5KuS6KBVG5mi+ZvoKx++djHl3gHEFEo5cjFksTcJHNlkAWK8oGOWricLSnlHTEC5aMaHR
	 tHKvakqNb7VhWRXEvaUOfdyiu7wDLZpeOGAvGe9+LyyunHTI9JYqZsIwgcl3hqGpvqDDB
	 QKUQUOsAFIhNYk+zHcbeAQ+bh1wsqbPC9So2yE0ljz47QUVqHQ26INPqjzzPbftaAwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=trmuTPwI;
	arc=none smtp.remote-ip=44.245.243.92
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A86606B58F
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 18:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32A86606B58F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=trmuTPwI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794336165; x=1825872165;
  h=mime-version:content-transfer-encoding:subject:from:to:
   cc:in-reply-to:references:date:message-id;
  bh=RNCN5fuEZC8EX4CP/oT0x0PyhNw1msLPDBkN5IfGv0w=;
  b=trmuTPwIGLFaHbp5hdtlEmdv64jeiSUrcedwhxQlvJ8M2i9PXOxuxPQ6
   KUPn7CDmujfYAtTKqBBhvygsEzrXpfxshifo5n5LaQCCl1iuNXYlWsJQe
   Q2Y0AavtU/ribt7t/qFUYo4UnfFTEyabcCmb3zdlYtsqaMr4lykTPvbSk
   a+XCuXkzQgTX0phVDgvmR/7P6oIvcEssNv3EaETz1SoNZHYj/wHck2ah/
   +NVAbqvtkyTSVIAWPy2jUAy09X/GKAm9+saXq6vPZ8qUouEXSnS+LyL7n
   INZIxnqHWBks6v/kCkcwK+ZXMK0yDoDKNjev+gPV57yDA2/FhICNyfOf7
   g==;
X-CSE-ConnectionGUID: GP394pLQSIWkZ/f9BBiKZg==
X-CSE-MsgGUID: usXPLy52Qk6rNEOUQx6+yA==
X-IronPort-AV: E=Sophos;i="6.27,206,1787011200"; 
   d="scan'208";a="33154865"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 18:42:42 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:13983]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.227:2525] with esmtp (Farcaster)
 id c058846e-4201-4e3f-a525-390f069ee567; Tue, 10 Nov 2026 18:42:42 +0000 (UTC)
X-Farcaster-Flow-ID: c058846e-4201-4e3f-a525-390f069ee567
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Tue, 10 Nov 2026 18:42:42 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Tue, 10 Nov 2026 18:42:40 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net-next] net: ena: set admin device pointer before
 queue allocations
From: Arthur Kiyanovski <akiyano@amazon.com>
To: Avi Weiss <thnkslprpt@gmail.com>
CC: <netdev@vger.kernel.org>, <akiyano@amazon.com>, <darinzon@amazon.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>
In-Reply-To: <20261109071126.87125-2-thnkslprpt@gmail.com>
References: <20261109071126.87125-2-thnkslprpt@gmail.com>
Date: Tue, 10 Nov 2026 18:42:32 +0000
Message-ID: <179433615241.3327.1653126166147440177.b4-review@b4>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Mon, 09 Nov 2026 09:11:27 +0200, Avi Weiss <thnkslprpt@gmail.com> wrote:
> diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
> index 297fb36ab8c1..23b3ef50b8b6 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_com.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_com.c
> @@ -2045,7 +2047,6 @@ int ena_com_admin_init(struct ena_com_dev *ena_dev,
>  	if (ret)
>  		goto error;
>  
> -	admin_queue->ena_dev = ena_dev;
>  	admin_queue->running_state = true;
>  
>  	return 0;

1. This is a bug fix, so it should go to net and not net-next.

2. Like your other patches, this one has already been applied to the
amzn-drivers repository:

https://github.com/amzn/amzn-drivers/commit/7d1dc4341d4f8376c7affdc2a97c7e012118beaa

Therefore please do the following:

2.1. Add a From: tag to give credit to Wajeeh Atrash, who wrote this fix:

From: Wajeeh Atrash <atrwajee@amazon.com>

2.2. Wajeeh has agreed, please also add:


It should be added before your Signed-off-by:

2.3. Move "admin_queue->ena_dev = ena_dev;" to the same place as in the
github commit, which is directly above the q_dmadev assignment:

        admin_queue->ena_dev = ena_dev;
        admin_queue->q_dmadev = ena_dev->dmadev;

I don't see a clear advantage to the location in your patch, so I would
rather have both drivers aligned.

Signed-off-by: Wajeeh Atrash <atrwajee@amazon.com>

-- 
Arthur Kiyanovski <akiyano@amazon.com>
