Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.12.53.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440411;
	b=3GUcofHDFd+9Kky6IqZhmgPqDnTRc/7S0Ze1UVuB3Us0bviuAW6vvSN+KwTE2ZrAEevm
	 NbuwPm6oJCeH6kEza7DgnMMXl5f6pr/8nRabdI6snJZwD49QRNi0/LhmRWM5s6cZ+2DEb
	 dIswWU8eb4bCaK0Lj9ez6e3FKhYUaS/TY3DLZiKz94amnP/JZFvkM0fHvtRu/qlcn5uwl
	 hHGe2XttaQQRVXK2oQnRkpL8Dsq0ZVJF7EHAbDDOq8OBKuoYYhLx7CFN++mD4qHV90UTD
	 9yQrBLan5P4Gl+S8voiZWhL0QX3/eO9TdVCYKVXCjtPtwU92rP3CG4uUX2EgSovX4QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440411;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 CC:In-Reply-To:References:Date:Message-ID:X-Mailer:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=WAJt06IV5PWj215Zh7juFtVar06MHP85l5cHodr9kfs=;
	b=C/l8jHzP5xuaBEI6/lzQx90ar9AA6N7/BGA0QNJpQn89mNX431FQNTO+xJhvt0ftyFu0
	 GCYKaBKV+WcsmFCDDGvwu5t9tAtyYuDW3GCJn8xo0KT+86hJ1UDrBejnLg2z2z+VwP2Wp
	 ds57E44Dv9SsxCQ2z4t4IV/JwnVoyNu6/kGjfOpd8YAYFhqotycP5jEIlc7BQSTmgs3jO
	 14PIGs+F6gAcjZ23l2DDNvABjdf4S1ZAPu4kBEr0axF8bDTg3DA0eosB8NK0tB8qdAlXn
	 ljt7KaWRibl6eH1a9bsxrvBz7sK4NF0AF/Kw0kfElx3wZMIWsQklJlb+zOCPVsm6h5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=OM8Vrr23;
	arc=none smtp.remote-ip=52.12.53.23
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F9F606A31C
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 23:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27F9F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=OM8Vrr23
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794440411; x=1825976411;
  h=mime-version:content-transfer-encoding:subject:from:to:
   cc:in-reply-to:references:date:message-id;
  bh=WAJt06IV5PWj215Zh7juFtVar06MHP85l5cHodr9kfs=;
  b=OM8Vrr23Q8uQBxcOnHkYh3POrXP+sAkqOx2ZV9W7aNtlABGDFaGiME2v
   U2unqjIFzLQjHSTPVIncN3f2ZhzQ9WT5srble9c0QVjTp4CjEpsjeXsqq
   D0bJV0gyhC6k8/h5BZsZIP8ak68+BlfJjIHD94tsDSFivmU79Ek3VFvnb
   MFSPl9iUWCcHn+P9xmxSffZKixuTe3wEJzoaXHY6Wx2sJ/ta7shNY6TBN
   SX3Bxs3LTLipBhNghL7Od+EfAG/JV2uAl3BkpjixLizCL2PDpNsiiISpq
   pwGYZJoBwKM8oxmvtTRw14mMc0oDoyW8HMpO8OY5VB3KKlT617RH0mgR6
   g==;
X-CSE-ConnectionGUID: rIcx+i1ZQEysvipEcDXZ4g==
X-CSE-MsgGUID: u/ld1/4ZRUK/qXRKQoszTw==
X-IronPort-AV: E=Sophos;i="6.27,208,1787011200"; 
   d="scan'208";a="33632081"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 23:40:08 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:16962]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.227:2525] with esmtp (Farcaster)
 id 01659154-e0d9-4315-897e-e714be5258cf; Wed, 11 Nov 2026 23:40:08 +0000 (UTC)
X-Farcaster-Flow-ID: 01659154-e0d9-4315-897e-e714be5258cf
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 23:40:08 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 23:40:06 +0000
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
Subject: Re: [PATCH net] net: ena: avoid double-counting TX DMA mappings on
 failure
From: Arthur Kiyanovski <akiyano@amazon.com>
To: Avi Weiss <thnkslprpt@gmail.com>
CC: Arthur Kiyanovski <akiyano@amazon.com>, David Arinzon
	<darinzon@amazon.com>, <netdev@vger.kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
In-Reply-To: <20261109123934.824610-2-thnkslprpt@gmail.com>
References: <20261109123934.824610-2-thnkslprpt@gmail.com>
Date: Wed, 11 Nov 2026 23:39:58 +0000
Message-ID: <179444039825.7144.5680478965949082764.b4-review@b4>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Mon, 09 Nov 2026 14:39:34 +0200, Avi Weiss <thnkslprpt@gmail.com> wrote:
> diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> index 7eb6456ed0d5..e0df628e1df6 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> @@ -2608,7 +2608,6 @@ static int ena_tx_map_skb(struct ena_ring *tx_ring,
>  
>  	tx_info->skb = NULL;
>  
> -	tx_info->num_of_bufs += i;
>  	ena_unmap_tx_buff(tx_ring, tx_info);
>  
>  	return -EINVAL;

Like you wrote this one has already been applied to the amzn-drivers
repository:

https://github.com/amzn/amzn-drivers/commit/1d6a78cebd2d7c38b4dbdee572ab3d3755086248

Therefore please do the following:

1. Add a From: tag to give credit to Evgeny Ostrovsky, who wrote this fix 
   (without leading "-"):

- From: Evgeny Ostrovsky <evostrov@amazon.com>

This should be first line before "ena_tx_map_skb() increme..."

2. Evgeny has agreed, please also add (without leading "-"):

- Signed-off-by: Evgeny Ostrovsky <evostrov@amazon.com>

It should be added before your Signed-off-by:

-- 
Arthur Kiyanovski <akiyano@amazon.com>
