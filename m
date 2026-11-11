Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794387280;
	b=iDFGz5VRu0qvRE12IIqi9t80D+LJ6zQ0FIDhdyFVjuDDiJ6iMl5PSshLP173diKi5Jhc
	 vZHulxM4MdJodpYONofqzruCpxw8Yx05dNF2Di5b4fskCNaL5bwdo2oxh7Qh/7qVk6bTA
	 gM3igZlw3B/dCYxgvXXMHKFYTkZhXI1bu8NMNur2mSx+0OVKG32hLKAAPgGFwRdjFS0TA
	 UsaD5nPbPIYC/0s19+wrxGAgEig21QpYjVa7lBb2jVxzBpdOebtYZDStGeWWGDzKunsz6
	 LNZSQd7dbosfTXXmGGXSNkl4zSuv8gwAFamV2cwjnhmyVjKmr360/+JklK407xTxC8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387280;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=H9xQdz4C/rsJnWG8Tvyeuj45FC1IesSP+JuLGf4H6wY=;
	b=n0J23W8I9OxfKKuAZ5rmw5MXHploKgyM0sEfFqQ7ElyhvTzPUw6ExKI25esd6gYm1Bs6
	 47Xg9qyxCucfg5Bw/m4zKNWInk7Ck20UFKcFAVTIAe8XoC0qfXV6Y5WUdknUdmhDqLfFo
	 dwOEw7z03819FNsPkrcBRePlwOgF1zD5kienVjt5SvKHPKLd3EXuQFVgXrSijNKEe8onx
	 PNJwMEppOrE6igyIQxprb9Fn3LiJb0pR6Z+ImLdNF7C/QQ/7BcUVH6UM0TvrkQaezYvaj
	 kp12fM7nUABvrofL65ahcPiFFXCMC2v4BdTzznl4Vha0Yifv+RStEzuwaUq2TNAT29w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=Jf1QMhIy;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B808606A31C;
	Wed, 11 Nov 2026 08:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B808606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=Jf1QMhIy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794387279; x=1825923279;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1k/YXEKmMzughT4nsaiJ1xGa8u3qxICvCdqo9g40zr0=;
  b=Jf1QMhIyj1DC6LwEADAWEdDR98g9ybOqhalY4XToEeyCd22vv2USjS4C
   +Pe2sAk1Tn5VB3tiJqfbbGbS1n33fWcDpVbSt+V8LB8jsCCtfn6+8LFny
   urfGKnrC8hn88yayO3AM8WA7ZazRYheUXsMiX1FnHCpT7ioZCoV55dbmD
   ng5uoGvVoBI7mRkZixFUvhLYADiIztYBDWvozgMfmauJ/HDKN5d6+v5s7
   cpT6InUkVkS1C+9vA8zD+5RdgyGzFTeqtznJSWS0bHWvHhGkBjVoRIc5g
   mEI1fz3zsOS9HuiorBKJUMqzFThBsTUWr6xzXUy6RBbH60KiNGJGatopD
   Q==;
X-CSE-ConnectionGUID: N6sbYLZJRvec3vhKpBr4aw==
X-CSE-MsgGUID: BqsdtgrBQ+Gt21t4f7etKg==
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="65379101"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 01:54:38 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Wed, 11 Nov 2026 01:54:38 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 11 Nov 2026 01:54:36 -0700
Date: Wed, 11 Nov 2026 09:54:35 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
CC: Petr Machata <petrm@nvidia.com>, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexei Lazar
	<alazar@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <1342116488@qq.com>
Subject: Re: [PATCH net] net: dcb: flush rewrite table on device unregister
Message-ID: <20261111085435.q7x4x7d4xsdo2tyj@DEN-DL-M70577>
References: <20261111033114.133296-1-sunwenbo@cmss.chinamobile.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261111033114.133296-1-sunwenbo@cmss.chinamobile.com>

On Wed, Nov 11, 2026 at 11:31:14AM +0800, Wenbo Sun wrote:
> In dcbnl_flush_dev(), which is called upon NETDEV_UNREGISTER for net
> devices with dcbnl_ops, only entries in dcb_app_list matching
> dev->ifindex are freed. The entries in dcb_rewr_list added via
> dcb_setrewr() are not flushed.
> 
> This causes a memory leak of struct dcb_app_type nodes in dcb_rewr_list
> when a DCB-capable net device is unregistered, and leaves stale entries
> in the global rewrite table that could inappropriately match if another
> net device later reuses the same ifindex.
> 
> Iterate over dcb_rewr_list in dcbnl_flush_dev() and remove and free all
> entries matching dev->ifindex, mirroring the cleanup performed for
> dcb_app_list.
> 
> This issue was found via LLM-assisted code review, confirmed by
> reproducing the leaked rewrite table entry upon netdevice unregistration
> in a User-Mode Linux (ARCH=um) environment, and verified in UML by
> confirming that all rewrite table entries for the unregistered netdevice
> are flushed.
> 
> Fixes: 622f1b2fae2e ("net: dcb: add new rewrite table")
> Signed-off-by: Wenbo Sun <sunwenbo@cmss.chinamobile.com>

Thanks for the fix!

I reproduced it on lan969x. After a device is unregistered, another
DCB-capable device that gets the same ifindex reports the old
device's rewrite entries in "dcb rewr show". With this patch the
table is empty.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
Tested-by: Daniel Machon <daniel.machon@microchip.com>

