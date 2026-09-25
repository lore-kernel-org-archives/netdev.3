Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745CE46F4BD;
	Fri, 25 Sep 2026 13:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341612; cv=none; b=U+bgZknTvwzq4vpYcT1Kg/wBDTVW2l1VHmSkJHDksZkSbNwX8I5IaCU9LrAxJP3b4UNxTqU3doV9bvo0k2BrBiB2hZp5R5HGZtnHd/dhLCDfp8nnPgKkKfFuVF9fSUrKSFVrltIsUnaWDM6kPSsUol4rsfnq5AW7C8ubsq1BvdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341612; c=relaxed/simple;
	bh=5LiU7u1Sd8vqr5RRPtFupIejm8J7rPUf9Xtw/ZZXIiA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tG7mvvV86VFf6DveAPTA/QJ9y//6zQ3fXM1SIgTLzn9iJUirE0sRAnsgA4E6/rtJOEF2JI9XCDENsGKdywTg3sDUH7oz6xFih6FbkIiLKviO6p6lJEDDzuYv+3R2nehiAzZ5d0KGD8ClaW9v/8z0U+qtw4wVr9yra7U6ox8X3vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=P6sPMLxJ; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="P6sPMLxJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790341610; x=1821877610;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5LiU7u1Sd8vqr5RRPtFupIejm8J7rPUf9Xtw/ZZXIiA=;
  b=P6sPMLxJ1iDDQks46WQX4Ee0nsTRGWGW5CN/npI0i+mLG9vvGSu6Kumm
   WsREuH3tuJFWAm/L2st8YO895mKDWstLp7s3Qm8hPbILuCt4K8THQzaRl
   LbzOR/TwuOk+/Kr5Oakt2LLOw6BcA1wqiRpdqPeLAbq9MEV8PNsLVcpo/
   pNSfY7xoQkuOBuQhLYsOxpK/282ZAJ30Vpp4WI0XshsKOtxuYDrmxiJMi
   y0G99mUp6wb9+w9WYg/5+TeFFXk0BtMl5OLY4sboix1B9UoDZCoxxrguj
   kLeOPsNZwIuLiwx5GXa1BS5zuvXbE9taJ58egdZICrmlR3MbxdOzpTi9Z
   w==;
X-CSE-ConnectionGUID: 0oTG/wW9SWmgreduiR0bWg==
X-CSE-MsgGUID: U+rPuNpRSV2rV5jNhfO0Yg==
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="295561569"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 06:06:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Fri, 25 Sep 2026 06:06:43 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 25 Sep 2026 06:06:41 -0700
Date: Fri, 25 Sep 2026 15:06:41 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
CC: Steen Hegelund <Steen.Hegelund@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
	<error27@gmail.com>
Subject: Re: [PATCH] net: microchip: vcap: stop scanning after deleting key
 field
Message-ID: <20260925130641.awviajhuq6mcb22w@DEN-DL-M70577.microsemi.net>
References: <20260925063937.963430-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260925063937.963430-1-harshit.m.mogalapalli@oracle.com>

> The only call outside the KUnit tests is in
> sparx5_tc_add_rule_copy(), which passes a fixed key list with no
> duplicate entries. Therefore, the potential double-free is not
> currently reachable in tree.

Agree. Not reachable today.

> 
> However, vcap_filter_rule_keys() is exported and does not require its
> key list entries to be unique. If a future or external caller supplies
> the same key at another position that the inner loop visits, it calls
> list_del() and kfree() a second time on the freed field, leading to a
> potential double-free.
> 

Also agree.

> Break the inner loop after removing a matching field. The outer safe
> list traversal continues to process the remaining rule fields.
> 
> Fixes: 465a38a269e9 ("net: microchip: sparx5: Support for copying and modifying rules in the API")
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/all/ahs-lCAXXikkaHky@stanley.mountain/
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
>  drivers/net/ethernet/microchip/vcap/vcap_api.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api.c b/drivers/net/ethernet/microchip/vcap/vcap_api.c
> index 788c0728d763..0f8d98f2094d 100644
> --- a/drivers/net/ethernet/microchip/vcap/vcap_api.c
> +++ b/drivers/net/ethernet/microchip/vcap/vcap_api.c
> @@ -3527,8 +3527,8 @@ int vcap_filter_rule_keys(struct vcap_rule *rule,
>                                 if (key == keylist[idx]) {
>                                         list_del(&ckf->ctrl.list);
>                                         kfree(ckf);
> -                                       idx++;
>                                         err = 0;
> +                                       break;
>                                 }
>                 }
>         }
> --
> 2.52.0
> 

Patch is missing the target tree (net), the fix LGTM.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
