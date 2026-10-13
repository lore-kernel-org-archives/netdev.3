Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445D833509B
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 11:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791890625; cv=none; b=tfeETZTxZD0H37Mg/h2W2etNHEaVqb13DGV6qovx91L8Vnm9mUMFNAXoHKZEunQjqxqlIon61s7CdrG9DIl6YHjbsZh86He+jCzAtiQ/VJqpMJKX0sgl9LiASlu3w7kSmJ1Eu/donSenBEBvLMfIlrQVlS5bku3br80Ok1keJW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791890625; c=relaxed/simple;
	bh=OAiwtZU5lLsZFm4lU/ObgFuPYWMbbn0X6/o2OFhuq3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C5YthYazlKfkTuTzHLAdY/RDW653ZlFw7ToR5NSpmdnWMz/ol2mUBf2m0ghISDwiPr/lxJrp+5xnF408cIV1tCOf7x6SArGkDWMmtDq4kYKfTnsLbOmfbGeB3ER+zRnFqb4BfBm5XWy6XAtnvZLjtIzbSnxpcRTAM3vWdBMIqkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bwNmBlFb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XP9uTZ4+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bwNmBlFb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XP9uTZ4+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791890622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=726Kbi3ZQ5SGlJ93iqUEhDyhLP3woij09STW5L6+pXY=;
	b=bwNmBlFbm4jzsaIl6XB+Jelh9hEEWzaxo8eeN2chtEjDrBe8iGXua0brVrYM3gUZODPXPA
	l3o3QR+wP3aVQLOStHULQ9s9Br4fu12TDW650bp0bxX6tBMlMJbnqwNjwnpfafZddgnPdz
	hJbxHfv/kevG2/7F0zMHvx2QCBy2lk8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-5vyh-WjBMMusyDZqDJS8wg-1; Tue, 13 Oct 2026 11:23:40 +0000
X-MC-Unique: 5vyh-WjBMMusyDZqDJS8wg-1
X-Mimecast-MFC-AGG-ID: 5vyh-WjBMMusyDZqDJS8wg_1791890620
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48c4649b368so2481951f8f.2
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 04:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791890620; x=1792495420; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=726Kbi3ZQ5SGlJ93iqUEhDyhLP3woij09STW5L6+pXY=;
        b=XP9uTZ4+Eohw5QmhTtDdj9l+uCEB3GAcx0ervA25SQisbc7zPP40wnQlYtSDEl66qX
         uGrD633de8RZrsFBUvPksr42/IEzj95CpWPgwYbjQajcayMEJirs6m39l3CQ9Q3LiQT/
         6b/wpF4OuZE6svpoAZv+3IAWcaOpiS5ty6lRWlPzpTPInVox+m8fsTT5qb4uUvSb6J0A
         5GUvKLP6UNcPuAHy7ZS9I2pp9b9KJpdSh5ZdB1TDwGXex00JgJw/EQbEdTYX11M36L3+
         WKyS7FZfU+KittnSZ4zmuLfkEsLMu7XdqhH0Xo6G8RMArq0u7HcMXfoWJSnzHNVeonPP
         wxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791890620; x=1792495420;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=726Kbi3ZQ5SGlJ93iqUEhDyhLP3woij09STW5L6+pXY=;
        b=gIREhkM40PJi3ZmlENMQbUfD7OyzXkZJ1mz+iTftBtFVRj5OMNRS31cUQymWB9PRGh
         i2Fxnrd+kcrFTwODbJDzaE/B/jxXCLpIPF1s5WHuvMhwMmfpEyyE2ObXM3oatvOWTotg
         ViYCSyflDXZRILPWwBf2Wr+8GOkjmNs5/mraajidKPTDgsRoDAKVPvPUpaBT6Stb4TpI
         xnXhegMOJJupTwdPpcPtPqDujlwwmGO6tqJkYKeQjkNS3+iD1smg+zMuQeEFWZpysiMy
         P/eMaR3Jiv7SVhsynCSoNt/yMbaSMaKxCffG9TWOwc51XeulWuqv1MOqg0L43b6ZH7KS
         Lo7g==
X-Forwarded-Encrypted: i=1; AKwUvBysQfHreublwqnnnWTXYaOFAzK9Z9fwtL0ZCHO6dTHs059uaown7bVwDhr3c66yg+1Hv42nbq4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLpPEea7FihfTjxPuwucY9Ge/Q/yjeDQkYtC3NlDrrii2zCTOKk
	CtUbwDXMB0sr9T5W4wggzdHJVubHEDuUfrNBJihkTEdNjDWi3BuaYKTtiltjt2qfq9q7seDjtvS
	yA3SDq3B3dM/Pi9s4Jbx9S28NSXUR8IrUB1SVj9u/FzE6TxRTpvZL2HXN2g==
X-Gm-Gg: AYBFou3R4tf+IASu3p5Eqc6/YgzPPYuvqCxztitBHutGiRT3clpbx3JPcrNEWjXcDj6
	+OR2NKYuIFltrqTeW5eZ517YeZgp57TjkoxJviXznpFiuEJ2O1vTemtoaEvMDTkN/yub/j5rpiA
	u9Me1u7o26ye9OBr/01AfDf8+Pg+88ETjnRHwXPPHRZSJmIo9Z0zCLLeh/u97xTfAqR1MLfkFrl
	0pIppzaU+VjpFaz6rUqPi8GTkVC42gSaC1KuYGqu7LQYRXX6gl/ark8vEYj1TMzdMK50ki9/ZGm
	qJ/1U1cq5MwiJ2813fTL49vO/xnQ9xWt8U7N/PmNehjUrr6eKyPE5JStEz7rAdMhnrc1NSAC9u1
	Lzz3xzM0IuipPlaHzw7VTpTQH9wavQ6rieLrxaOR+NyGjpMUvOH6ADi+CNRPSoqqrXCOJIoouIA
	==
X-Received: by 2002:a5d:5f87:0:b0:487:aff:9952 with SMTP id ffacd0b85a97d-48dbaadd0b4mr23455640f8f.16.1791890619506;
        Tue, 13 Oct 2026 04:23:39 -0700 (PDT)
X-Received: by 2002:a5d:5f87:0:b0:487:aff:9952 with SMTP id ffacd0b85a97d-48dbaadd0b4mr23455576f8f.16.1791890618944;
        Tue, 13 Oct 2026 04:23:38 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc6b82sm4628216f8f.51.2026.10.13.04.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 04:23:38 -0700 (PDT)
Message-ID: <6bd52b02-e701-4589-824b-87c1475bc4cf@redhat.com>
Date: Tue, 13 Oct 2026 13:23:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5: Attach late uplink netdev to loaded
 representors
To: Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Cc: Cosmin Ratiu <cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Jianbo Liu <jianbol@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
 Leon Romanovsky <leon@kernel.org>, open list <linux-kernel@vger.kernel.org>,
 linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Shay Drori <shayd@nvidia.com>
References: <20261006110219.257714-1-tariqt@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261006110219.257714-1-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/6/26 13:02, Tariq Toukan wrote:
> From: Jianbo Liu <jianbol@nvidia.com>
> 
> mlx5e_vport_uplink_rep_load() returns success when the uplink netdev is
> missing, so the ETH rep is marked loaded with a NULL netdev, the IB rep
> copies that NULL association, and nothing repairs it later. Unbind
> mlx5_core.eth.<N> in legacy mode, enter switchdev, bind it again, and
> rdma link show still reports no netdev on the uplink port. The netdev
> also keeps the NIC profile instead of the uplink rep profile.
> 
> Add an attach_uplink_netdev rep op, run from the existing reload-reps
> work once mlx5_core_uplink_netdev_set() reports a netdev. ETH re-runs
> the uplink load, switching profile and setting rpriv->netdev; IB redoes
> ib_device_set_netdev(). Deferring to the work keeps the devlink lock
> out of probe context.
> 
> Fixes: 6b4be64fd9fe ("net/mlx5e: Harden uplink netdev access against device unbind")
> Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
> Reviewed-by: Shay Drori <shayd@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
The AI feedback looks relevant, also this looks quite too big/dangerous
for net at this point of the cycle.

/P

