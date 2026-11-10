Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324338;
	b=K4aZNx5lMbc+6uQVNosfPFNWbAuBk3l4N6rxnE1ygtIrcCRL7n9OnSd9UOnGfR657W3r
	 yk9UUORAfIIlgi/FuGBFwccDX7HN7PgvvzJXtdkYkRY86XUaasHqdJ73zsSnUY8U0Akb+
	 QHjMDxAeOoWQLPzQiudzzUzzTQWG+tsUiBHMZ51rsUbnI8grLNg4bun1ACaETtGJksz6g
	 GXbCFeoNqXdUxfNeYrCXt0LpkbEs8bm8B83FdU5pBJY5rJpiHQvV1JjE8sCD7D65v/pmg
	 o2hccyIkJpMGIILuOgWwVOUHUt0jxOIJd/yggGNuOqTJtiHPQLFSoxFFo1iPbK7tGkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324338;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=wfzKELCAp0cqmrsetofqgnVnCBGLz4JZTetKNjquJ78=;
	b=pBluZ3EFYxkXfMvM4TIjYtIqUC2vSJNbUMZeVSRAeh0s507McS4fE0g1YwqfV/JnmQwF
	 h5GMRp8fsXXevGbtwpu+eKq8O05IGEcqkEMRJ2Le8ET+KXGyvDNFt0Bf37gvxIb10Z+KD
	 iD/0nEMLBmH+njqCsGSTLFh1qaiIQr8MrhRExXo+FO8gmxvuBaNmDfrX4BISuKFmf/GqF
	 JMUW24YA4Yv9emld0d78nX74dpm5e9wPdHz4i8N95j3Dz6meCBRbBLKagYn3Lm73/qN3j
	 S1h0IWPR4oiTMQdzpFxirS7IhFPZyEhuGLUfK/Sao5WOBc3kF1rT0XZS774RLHFKpig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WIO2qeaX;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=DDnyK00v;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD44606A325
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 15:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FD44606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WIO2qeaX;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=DDnyK00v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794324337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wfzKELCAp0cqmrsetofqgnVnCBGLz4JZTetKNjquJ78=;
	b=WIO2qeaXBEvhhhVh0G2jozaBfS4mlxQNW18Q85w/+wGEzdBb/1g4F+aHiyLtRwzsgk7zKN
	0pfmwJBvKwArn6x5p+pmvNc7thCsZUPrRqcgB4Hj+zrhBFIcmFIsZ66kOiqGY27sJUChCs
	Ap90lS6YXBUbgF3o2x5N2oSfUPcaYME=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-v6pBMVrgNHaB8ioRDwNv7Q-1; Tue, 10 Nov 2026 10:25:32 -0500
X-MC-Unique: v6pBMVrgNHaB8ioRDwNv7Q-1
X-Mimecast-MFC-AGG-ID: v6pBMVrgNHaB8ioRDwNv7Q_1794324331
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4ba078abd70so2603755e9.3
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 07:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794324331; x=1794929131; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wfzKELCAp0cqmrsetofqgnVnCBGLz4JZTetKNjquJ78=;
        b=DDnyK00vImLWL+Q0AZwLrkWX9auIPGPQiM6c1SnILlCCdDdj3XokEj8m1bXrv7riHz
         /gIyGCLoqA59Arsmmta0VDl0VUtwNmsF7+nU82u26P3Y/8kgE+BTbVoFBwXsSt9B3GVf
         swFcnXVMbuq0FcX/NeqX2SUweiQd4LxI3SMI3vbZ0YaRnRm6X04YH4vsfE6/5roC/6aE
         SEVcejmudHFSMFIOC4bUhJ4USDOy4JjQl9rL5TT1528aSZ9zF6oqDEqzuqHw2yDWqiF6
         tfQfVBSGd00b6+94hDkCsVz7YxNvkOSoi6DDk5InWq56N0o8iOBsL38C0gFo6u4JVDk8
         h/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794324331; x=1794929131;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wfzKELCAp0cqmrsetofqgnVnCBGLz4JZTetKNjquJ78=;
        b=BDABdr0Vk5/w2tfCTnAndcWNvVM1WnF+TJyvadijcB8h9gmYAOJh3YX8jxjLaqWaAV
         0I6O3T3Kl4unb3vBbTUlVhmRL4G9BQ53cdMxR9nJOy+hqHPEj2VumQUyC70jiHl6AtYq
         BZdd9axCJ+0xJBhhzzKwVkFFvNjEc97zMWfqUUbgBH+gtaCCDPDlBD5fXNg1/5iCDOcS
         U3joq+8OjtGoYYjaX9xcVR5CQQWy1CgEBBFL32tUZMKqCXb9iD1joZnK2b9/GSFFKPoM
         TS7g0NUfUNbwTX/YYz1UxBO3d54FG+3VG6lQoK0HkmFSOqTV5G8LtH+Cfn+xbcutqxo4
         zk4g==
X-Forwarded-Encrypted: i=1; AL+hErF1JYElqvBgNUbS7qWoi4jKcawPI32qSgwGyOXKgzx9cFwMYuuA1y362QaR5RkALN2WYvmft+E=@vger.kernel.org
X-Gm-Message-State: APuU4Z9NFO2otGDndC1iZkANrWNqLlywwSjkC6tdKW9UJBOkgYZPAKAt
	hkwTKmwKhayPy+BkhU71PyxV9ZtxEjqRkx67gct6WaKbmiOtayMeNY48nxqF5gnsankEe1chpag
	BYCv5lFlebkFpqDgnG9KUnqWk4r7Bu9v1uFeD181mQBPE9d0F+Qw2GEuu2w==
X-Gm-Gg: AYBFou0MjFtgjdy7RZLyWqkQBDuF9p2pEiQDq2LuX0N1ZRNbVAcyRfr33Rt3fgG9+XU
	iNQtJX07j4JKL4dsFgRxjlTnccz8/OC/qBn3UONJyNeZSKlqiaJEYCSQp0KEjdEitFD5eQT54e0
	4WFbe0RtM4n16bHYxNkDptYh9Thf3yQUfbbNps7CFpcwXaQ6zJw5HrmQYBR0yuLATiOYRG8ZuHR
	2Ph4MX5ljIuAUWDC2vvEzaM4GOADLkoZvt7XPh5pfU31jgudxcAT4UWeLGF6uPjW1zFu45jkmqT
	QF7hhArZu+1g1Qbxi4+3TJKkLTH/RbfBPBFff7FG60Lb+Spg4OV/oxSH3ZjT+Q0XKh9QIAmfu8J
	JSLCNC1hqxNdXqHMuQ5FrFFhl2sM6Fc4LNvQ=
X-Received: by 2002:a05:600c:524e:b0:4a3:59c7:f226 with SMTP id 5b1f17b1804b1-4ba02337989mr51499505e9.6.1794324331032;
        Tue, 10 Nov 2026 07:25:31 -0800 (PST)
X-Received: by 2002:a05:600c:524e:b0:4a3:59c7:f226 with SMTP id 5b1f17b1804b1-4ba02337989mr51499015e9.6.1794324330573;
        Tue, 10 Nov 2026 07:25:30 -0800 (PST)
Received: from [10.43.3.161] ([213.175.46.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fba476sm83278055e9.2.2026.11.10.07.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 07:25:29 -0800 (PST)
Message-ID: <cccade50-26b2-49e5-9d06-bde1c4f1c004@redhat.com>
Date: Tue, 10 Nov 2026 16:25:28 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] dpll: notify about a reference sync pair only if
 it was added
Content-Language: en-US
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Milena Olech <milena.olech@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Michal Michalik <michal.michalik@intel.com>, linux-kernel@vger.kernel.org
References: <20261105131145.1010406-1-ivecera@redhat.com>
 <20261105131145.1010406-2-ivecera@redhat.com>
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20261105131145.1010406-2-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/5/26 2:11 PM, Ivan Vecera wrote:
> dpll_pin_ref_sync_pair_add() sends a pin change notification even when
> xa_insert() fails and nothing has changed. zl3073x gets -EBUSY when
> another channel has already added the same pair and ignores it, so user
> space is notified about a change that did not happen.
> 
> Send the notification only after a successful insert.
> 
> Found by code review. Reproduced on a ZL30732A board with kprobes on
> dpll_pin_ref_sync_pair_add() and __dpll_pin_change_ntf(): loading the
> driver adds one pair twice and the add failing with -EBUSY sends a
> notification. With this patch it does not, and the successful add still
> does. A test module adding one pair twice shows the same on the monitor
> group.
> 
> Fixes: 58256a26bfb3 ("dpll: add reference sync get/set")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/dpll/dpll_core.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
> index 8389983f425695..277692d12d3d1e 100644
> --- a/drivers/dpll/dpll_core.c
> +++ b/drivers/dpll/dpll_core.c
> @@ -1081,7 +1081,8 @@ int dpll_pin_ref_sync_pair_add(struct dpll_pin *pin,
>   	mutex_lock(&dpll_lock);
>   	ret = xa_insert(&pin->ref_sync_pins, ref_sync_pin->id,
>   			ref_sync_pin, GFP_KERNEL);
> -	__dpll_pin_change_ntf(pin);
> +	if (!ret)
> +		__dpll_pin_change_ntf(pin);
>   	mutex_unlock(&dpll_lock);
>   
>   	return ret;
Reviewed-by: Petr Oros <poros@redhat.com>

