Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F5F37E5EB
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792105552; cv=none; b=A8i41VandUcJxlqddNydzFh8qCqdPC9UWrPD3cMmvmPKECsyo4cyFKdwWkqi6mHHKFQ3+oU1ZETjBoN0Zoh0qYQRhI3u5X99mbFfl+lhHAsVix25PGwnukJ3+vFpzmZuheecCqPDJsuVxk0sZQtTSbYg+NSozREqBAPico/tWTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792105552; c=relaxed/simple;
	bh=e/DZLD/6etq+VKlol3imzl5M/acsGSQ+j65/ruElLJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VvLJIgeSafJLH5Ie0ilqEe6KqIOhCugpGRWVYVzcLZ4EX0Yf1XgXQE5SIlOW4sZ7+F5bddSVUa5BCKYkYDQG+ChSxkPox2CnCLnd7d8JAygmH+1b5bB0xvIq9lnb1YZ77MvTPuErL+ZmwTKeKZFn5ao2S2QabItszsFUFntorGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZZ02Tm2; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZZ02Tm2"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-17bc533fda3so2817949c88.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 16:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792105550; x=1792710350; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kXARPhTICfJDeqk9KU4Bk9L9MT+pESA+mPUtjl9Az4k=;
        b=QZZ02Tm2gDtnuFWJyhP2qW5wDxfwex1XQ7IakxUItpSMSLYme6mAQyDpwcfiZ9Ylzo
         uVs1Wk4wlWAFMyt5jNgUJOJUCnbpqNMU+aRexqcQw537tIo+6PQHNaX2JX3tZ3uo1qel
         UtPHs0LeGQjChl70NkufSYa3PsdhDRGdu/akgXjGfooYejcy+46ibXarkd49ZSE8gdPq
         bjY8kPtgncQulOIZ7dHSoQjEajhWBXB1rQBwj2mUC+922XfUTSdmSKdOcOW/rMlL4nmi
         WmKHr4b7WYxv4vFt/y1z0ZdzXpcTLOBWbVvcCwEDwpcupKcLRxqWzw8L9LSX500RA/H0
         5V2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792105550; x=1792710350;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kXARPhTICfJDeqk9KU4Bk9L9MT+pESA+mPUtjl9Az4k=;
        b=w4eBLBCdcAbwNZGTo8C7HtTsLTTcWEM7A4LvxM5iBkGfGAUV1Bw4kl0Ns7bdQ5p52E
         LgudAijR3kXS45oJBUi7y3v89iOa0EGyXOfFCweAvuH4IiOFHQTIfsssTG4rSj0nPGAx
         qw6sUAWw8+yAdc3SzhxcOZsLbjhgPE61Afi4i8BBcyv4vCdCnwYHmDxrXO7aQ8FtLnhx
         jo5JCqiQLf4MUY+KImABiTjqPQDggW5sTF3+H/bIA9qthUTw5tmBnMYGODzeF9N9W5fw
         qgBfolOerZiF1lqq4StL3e9BQ7kAW9ABva1DoOOb+YWf1JSGtPDzQaymTRGj4OtWFjvP
         feKA==
X-Forwarded-Encrypted: i=1; AKwUvBzdY7bCxXGECDvUnHEkIMhb/DOiaaazYYQ8tD8FDXQSdKfmqMwMKMEKuDJHwB8VKJXq63bLePY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKS619XiZJ7OwhyYMOKY5cFcHNBpTITiCXv3foRxOqHO738JPEi
	/WboVWJMjxX5BnkbpkydJR/MaLDHS6JMUxnBunBIpwwG+MqrGcbOOrB9
X-Gm-Gg: AYBFou1Ijgyt1tIloR4WcSkpwP62XkXsTwOZ+lNT1VQJtJ0B+rZgZKdu8tpE/udoul5
	hi04E3RK+0jJjbP1juMusLkO9ERy0dOQa9DyFULOKBGR0YlY+Fc98msqTzI3EUvp41C+sCaGFDd
	wv0HAxzGZ/SsfMJant3PGDwHSLOeUyUn1rCPI0BGzJxoEJfKYui8ihHdJXOzCx+Q/pRBEmewnOv
	+SEwiCSp5UgkMVuF9B0Kh6fO2J+1w6qJoyJoc3HScp4DX5TV/BLBEgJxg+85tUwsrkwuqszRgtI
	MuAbctisqopNOwR0rXSnIaOJ/SFX0P3Svc9kt1oFwa4WlY+eV4KuJOUY8b09T0GIBETr+3ajPnY
	DPj/FqKzqlu4qIJ9Ob9dNCoZBOvNlFqrx1FIcixST88oudz4FwC3msUC1MIlXrwaHQyRzAVJHuz
	Wk/8W/VM2MFwqVdx0GwLUMPWdmkS4FPDaEzkZ0tuflsbUmI1geBiXdR/AnOvYF5Vw0EiQHhd/kj
	9e8xaqi0gNrzOEzuQiAg/7pPbdPfBN+EFb+B6K5sQKHaGyUkqYbDs40+foQDQ==
X-Received: by 2002:a05:7022:ea48:10b0:17f:7280:1332 with SMTP id a92af1059eb24-17f728014b2mr6433454c88.40.1792105550482;
        Thu, 15 Oct 2026 16:05:50 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:c24:4ad9:f660:1904? ([2620:10d:c090:500::5:d964])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831c4d4675sm554954c88.21.2026.10.15.16.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 16:05:50 -0700 (PDT)
Message-ID: <a95dcfa0-2d6b-44be-9f22-9927d03af0d2@gmail.com>
Date: Thu, 15 Oct 2026 16:05:49 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net/mlx5e: advertise tcp-data-split support
To: Nimrod Oren <noren@nvidia.com>, "David S . Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Gal Pressman <gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, netdev@vger.kernel.org
References: <20261009025137.2631215-1-dimitri.daskalakis1@gmail.com>
 <0c4ce4ef-4133-4cf9-ad20-7a4fdc4f0b19@nvidia.com>
Content-Language: en-US
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
In-Reply-To: <0c4ce4ef-4133-4cf9-ad20-7a4fdc4f0b19@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thanks for the review.

On 10/12/26 4:35 AM, Nimrod Oren wrote:
> Thanks for working on this, a few comments below.
> 
> On 09/10/2026 5:51, Dimitri Daskalakis wrote:
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
>> index 261c466a4d36..c30d751cac2f 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
>> @@ -378,6 +378,9 @@ void mlx5e_ethtool_get_ringparam(struct mlx5e_priv *priv,
>>  
>>  	kernel_param->hds_thresh = 0;
>>  	kernel_param->hds_thresh_max = 0;
>> +
>> +	if (priv->channels.params.packet_merge.type == MLX5E_PACKET_MERGE_SHAMPO)
>> +		kernel_param->tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_ENABLED;
>>  }
> 
> With HW-GRO off, tcp-data-split is omitted and appears unsupported.
> I think it should report disabled when HW-GRO is supported but inactive.
> 

Sashiko also pushed for this. I verified it should be ok, so I'll include
that in the next version.

> ...
> 
>> +	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_DISABLED) {
>> +		NL_SET_ERR_MSG_MOD(extack,
>> +				   "TCP-data-split can not be disabled");
>> +		return false;
> 
> I think the message should emphasize that TCP-data-split can't be
> directly/explicitly disabled.
> 

Any suggestions on the wording?

> ...
>> +	/* Disable HW-GRO if it was only kept on for HDS. */
>> +	if (dev->cfg->hds_config != kernel_param->tcp_data_split)
>> +		netdev_update_features(priv->netdev);
> 
> nit: the only transition that needs this is enabled -> auto,
> so maybe something like this is preferable:
> 
>   if (dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
>       kernel_param->tcp_data_split != ETHTOOL_TCP_DATA_SPLIT_ENABLED)

It's harmless to be less restrictive here, but if you feel strongly I can
go with what you proposed.

> 
> Thanks,
> Nimrod

