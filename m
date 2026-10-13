Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0FE3F4125
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 09:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791885106; cv=none; b=HCXXlDf2FIZQLACGSJS36EYeghe4O2TgDx1zgTT6zsB8O6yIAAAhmrBTIazz5RzZkfGi+L6d4lPNhJrP+gla6TREAbPOoME+z9OOj6mC5PknllHzXqbTgjDg4u+cL9Pcn45e7r0vHdvTRxK1yt0zGxOqFf3sIp5gXsFbhbFis3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791885106; c=relaxed/simple;
	bh=u2pFwzNMAxD0Oo1isB+38Lg6jL+zokAa+aYI4Z2T+gA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWij+FPybS0uXbtPJHFKiec4XRS1kQsa04uAGeMF4boekJD/+AQ4EAp1fd10Qiephgk9q2jNmos/NB+agF8QAXX0ufv8NZ/Z79qro+a4CXkn4mhxONoiRyJBtNgXZWBniyXAp9hkZ+02TYoHyXh87yk7lYkEyQVmGtZPfcdsDBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=eKs+gJw7; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="eKs+gJw7"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a16c1608faso35551025e9.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 02:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1791885103; x=1792489903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fB0uk4ljewcdj9xikOsJ5AGGEnsL0TpvKZ1I7QdEXRs=;
        b=eKs+gJw7VW1GeB6DnjpOMr7bd6VCFHuH6L/5Jv4Q0UBMbbuKnCUpe18tTA55/r3wfU
         LluiHValxpemh9EsOzAW+QafHcORb23BzGdxwZQJC8Rjud8S07QQlTvGdfDIYexGdnpc
         mtbjiDH8v+6D7eYSUARD1QrhT2Gaz7djNB6SzWynfs1Eoo6TyA1YNDuD4wjq/wHnR4Aw
         aiwYmYKPG8Sh3nZIcoSU742E8R7f8yfp1B8itc7JQhtcWMr5l3+ecoZlFsPwtYD+731x
         zLN1SjbfT+aOlqyzSHQEzAOq4TUZoMq6U653m8wv71EJwpuuPcZkjS+rIU9ZPValUZ/y
         nLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791885103; x=1792489903;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fB0uk4ljewcdj9xikOsJ5AGGEnsL0TpvKZ1I7QdEXRs=;
        b=buNJ2G51OG9R388nN0PE+rwBBO384n4kO+XFwOESFp0DDnqLsXigg32awmGyJl6svz
         1IiptrvMkAQjBXP726ih5/UxCF6Mj41C7oG9Zwth87XvffiZ8692YnfjxCIgjEuJ3oy1
         orbtvDMBvCNR6gLRaR7ut5qMbH9ky7W4NkBl06H4cuWk1Ec9TY56iooIwjpyahOiqJD4
         QZfwpMfJMstLrrAg+4DAKSfDLc1GySE7nGBlRaCdJjg4qTnPJSk480fvj0FaLqzFvXtU
         3i5wD9EuEj4F+Ei73AceWk/Mhe27ymfBByAICrVUeboi2V2wfTuluMQSQq4o4mNsMaxs
         TjVw==
X-Forwarded-Encrypted: i=1; AKwUvBwsOZD5d4JutAifHwBUIKJKd9ulgKV4xZConaUcuR2JHIUiKbRh4B9mfkXcTeZiK35XJhGbJow=@vger.kernel.org
X-Gm-Message-State: AFq9FYICmhqV6F2csP9U7juN3gNTdhJG03iospOF8Mx+cgsb7Ai62hJt
	AlNQzA4FLn0gxA/F/h5PoWPdUL1EbC2vx9YQIbPc/pkA8SyBtYg0FdJtJj21ulOS0NA=
X-Gm-Gg: AYBFou2mkrb9lMgx2MV06yMYXUlx/ixhbf60unxOWFAbu4VL/GUy2za+IhB+4W618PL
	RXSqC2HHNpIyjUj0WTz4ta/gyRuuvsmwxR9keAwo70tUVV+XnyRrSZaQHBRazw9koi+NDw/lBKp
	r9n10bJjvjzahOUXDZWMO+RiObJW9cTbmLncpf4E+x74UXKQb76cddPYXhZ8LelDfLT4kgraCYJ
	S4L3yynhPxW39BuHpm9QINQQYuLnKS8gAOxZHpeMgo6AfL/2Yhc5ETZtXqrWqlOGWL/lM3LIdnj
	t7S9Uky51UhuciG9y/s8MSJ/7lgvnGGbp7EXAXATm+R/RqnZCkVrVgs0JhKATZtvzV2dkBsTE8E
	kzsi3ORgQKRfWBjGw15aiCIsVJfNY2rouO9B3vs+lzyDlS50kJaBbvAy8zSixdhOMSVwxvRItfL
	x8LuWGiyBdqUxKEkQw/7FFy/Y1dD2ZXlEBO/eCFBOXGZ9S8TpkYtMON0VciDEB7ftlSxjDKmNv6
	yYW/BBWdP1Yx+jikcTtGUzUaGLkoM1kxkrHIAb5LY53rC+hpq4dM0M8dzGYwsQpkz/t2fcR7ThV
	n/ziYVitnc3iU+nxUS0UjeN0+xYc1oRtsMJCt9Cnn5CH5IPY3Zcl5H8NVdM=
X-Received: by 2002:a05:600c:8b78:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-4a18e4837f2mr222616855e9.5.1791885102854;
        Tue, 13 Oct 2026 02:51:42 -0700 (PDT)
Received: from aspen.lan (aztw-33-b2-v4wan-169864-cust3247.vm26.cable.virginm.net. [92.239.204.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18d12fe04sm217361885e9.4.2026.10.13.02.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 02:51:42 -0700 (PDT)
Date: Tue, 13 Oct 2026 10:51:40 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Davide Caratti <dcaratti@redhat.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next] net: stmmac: fix mqprio and cbs combination
Message-ID: <as3_LNUGanrChZ8Q@aspen.lan>
References: <20261012-stmmac-mqprio-cbs-combo-v1-1-831e323eb4ef@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-stmmac-mqprio-cbs-combo-v1-1-831e323eb4ef@oss.qualcomm.com>

On Mon, Oct 12, 2026 at 11:14:06PM +0200, Lorenzo Bianconi wrote:
> The channel-mode mqprio offload and the CBS offload can currently not be
> enabled at the same time. tc_mqprio_validate_chan_mode() refuses the
> mqprio offload as soon as any TX queue is configured in AVB mode, and
> tc_setup_cbs() refuses to enable CBS while the strict-priority scheduler
> is active. As a result the combination is rejected whichever order the
> two are configured in.
>
> The strict-priority scheduler selected by the channel-mode mqprio
> offload and the per-queue CBS shaper are independent MTL settings and do
> not conflict, so drop the checks and let the combination be offloaded.
> The following configuration, which was previously refused, now works:
>
>   $ tc qdisc replace dev eth0 handle 100 parent root mqprio num_tc 4 \
>         map  0  0  0  0  0  1  2  3  0  0  0  0  0  0  0  0 \
>         queues 1@0 1@1 1@2 1@3 mode channel hw 1
>   $ tc qdisc replace dev eth0 parent 100:2 handle 102: cbs \
>         idleslope 800000 sendslope -1700000 hicredit 494 locredit -1049 offload 0
>   $ tc qdisc replace dev eth0 parent 100:3 handle 103: cbs \
>         idleslope 400000 sendslope -2100000 hicredit 247 locredit -1296 offload 1
>   $ tc qdisc replace dev eth0 parent 100:4 handle 104: cbs \
>         idleslope 200000 sendslope -2300000 hicredit 124 locredit -1419 offload 1
>
> Fixes: 47891d501e34 ("net: stmmac: add tc mqprio hw queue priority offload")
> Tested-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Also FWIW:
Reviewed-by: Daniel Thompson <daniel@riscstar.com>


Daniel.
