Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAC83ADBA4
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 12:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785501691; cv=none; b=AOBsXoyQHFivIRltmc4fUPLqb37gDVqipO3I9BDMlxBIPg/bYSWHpZJgS2GS3F+TX43pctm9py6L3M4ubXFG6Vq/brK0htGHquL74P5/6uuY4kQGXlnGhEWxQ9B1AV+nlAayxOMH7uZLYTYtdWVWnpQ9dDW7hAc3kAQRPyhOOC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785501691; c=relaxed/simple;
	bh=keIsujryx3Uee0mJit7AKr9nN0ssqKTbSC5x1osOq28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CEGznUgWsobVf7dst9b6Xhhx1igcRuXterCa8epMFaZMDj5ePn5BPEhwsc38yvjTCVQNGvVsnTgKMhdpQ2gFRj85Ukn6PgdfyIc71vt2/VZrq9rxRGANgH+HkRs4S58vVdSzqLL35aRUpKHypYFx8AqOAvJgjfy5vTJaWfoIKdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6nafXas; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6nafXas"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8eeadbc5e21so5535916d6.3
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 05:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785501689; x=1786106489; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AR51AZn/bvW2dwxRSuHfDMRFFtyWMfnouj4EfaRrzZs=;
        b=i6nafXasKXLG6nPUYRVBnBIWDGnj99S2pyfmAT2SMCWXhLDV8XaYrouc2Ua2i5vimd
         UUXEjqOji+58UkOqKxSbvC33VFKvxw7L4sGbacPAUAIXlq80E19WLzwA8qQSPeKkl2r3
         Z9XqISG1mtM7UD2DkFdMqLsP8GKgKzA4FQXBHQ/65SNEeMqkq9dpzySYFRhCkLpiKTfu
         ODht7ZlfQdd1TZGhwUwP/AR8ys9xgWE3iHFC1f2kHvvhkYNIsLfG5clzN29EaXwMEkls
         JYIOd1M+Gu+c/ZQzbbF3RPRyK9jEqIQ80Vzk20y6O2vdK7enadd2F4bGmXY/EJFU3KIq
         e9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785501689; x=1786106489;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AR51AZn/bvW2dwxRSuHfDMRFFtyWMfnouj4EfaRrzZs=;
        b=a8TCqgi6dQmSSG+jFZBknzR26sClmh8WL3/bFCEDzE/qBw3ZFpe8kOzvKokvLwhMoV
         zyy/jGYaB+oMJpDnBfe/y28KMkzhOoRUUboJt7mR10poLsXZ+igyQsw2X/93ybYHLA40
         j3DB+81vHabBcvli64mfqfZCU37mfnhBBzGsSDMVW0y6Gw6KoA7m/9cKuAr0zPaXp8zs
         5EIYBzs4wL0yo7jzsVu+ZQuuhNBOysAK24rvPEwYA6lt5+i8w5gCJRwJVBnO7+HvamFL
         lqnvRDxdjr/jKDdg1AaAOErStI5hAG2mEPjDCaUBwuiAY1DmhmbTDJ/eFN8R8kTzmadr
         AvAQ==
X-Forwarded-Encrypted: i=1; AHgh+RrRV3RngpP58TJuSGK3dpSJUa7pamBdsc0Kvx+r+batmNUDfP9tL91NzTGdE+LBYUrOAJ+6d14=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFOAdwVh5M2rEwvfQwJ/gRpvcqrNvwDdN3VJTYkru/68W2suWd
	qluwFwcCourDEDWwGf08y5slds2qWXnpeQxIe8Ycn/gdWhIlESVdMnEVn00vWQ==
X-Gm-Gg: AR+sD10s3Axp7wmklpvXcr5mh8M41mpieZ4aJNB8uvdn0RasWhqyqPzPl3dNrfZhCTG
	yy7cEO6iNk4uxnclmeUEn1cTQPUdx6BZkit4GudhioWR1/s6o+BB3++dR1/fL9ceTl6Qo1EmYhM
	wufcSm+bpRo7nsgaRQzWzQ8jg2RugX2sChILbxszttZBQOh6fVEawYL6Z+YLcUWKYcLk6tPwngb
	CfAAhykncNZtXiYSLK7xJZY55YGZFUR2h8HMlEzsEcNpMnsgXEc363b7thGOS586yKQHmHYkEai
	pP8CY39IFJGHlpP9YUK8SywplJn19hSGvFoMPSEUUlt6Ckl47N95XhlBQQowgrQvXlq1Mv1rTpd
	0jgDu/d8leMEkj2E3SOu2Vht3KxUAT13ckZQ7BOx3owr7A3IMiNH7OCyev+43kNJDeG35SmU8vn
	+6bqRqNJiMmcvjb9Ho8APe5Bautp4cOfg6Ah2GNydKgFp087CuDTEI8YBWOBULHdnJpzLaqjwYC
	yVltyFc99tHFO6dnMb96Dco/jwc2sU=
X-Received: by 2002:a05:6214:3f85:b0:8ef:91c5:8edb with SMTP id 6a1803df08f44-9084218e7a2mr38156866d6.10.1785501688541;
        Fri, 31 Jul 2026 05:41:28 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1145:4:4e58:3e50:ad11:4e7a? ([2620:10d:c091:500::4:2e2b])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908435dfa6dsm9313106d6.33.2026.07.31.05.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 05:41:27 -0700 (PDT)
Message-ID: <0d72c5b2-6d4c-40d4-8cbe-8cd95d61a230@gmail.com>
Date: Fri, 31 Jul 2026 08:41:26 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 09/13] net/mlx5e: psp: Add an rx_decap steering
 table
To: Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Sabrina Dubroca <sd@queasysnail.net>
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Alexei Lazar <alazar@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
 Carolina Jubran <cjubran@nvidia.com>, Chris Mi <cmi@nvidia.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, Doruk Tan Ozturk <doruk@0sec.ai>,
 Dragos Tatulea <dtatulea@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Jacob Keller <Jacob.e.keller@intel.com>, Jianbo Liu <jianbol@nvidia.com>,
 Kees Cook <kees@kernel.org>, Lama Kayal <lkayal@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org,
 Mark Bloch <mbloch@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>,
 Raed Salem <raeds@nvidia.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Stanislav Fomichev <sdf.kernel@gmail.com>
References: <20260730091756.2543777-1-tariqt@nvidia.com>
 <20260730091756.2543777-10-tariqt@nvidia.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <20260730091756.2543777-10-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/30/26 5:17 AM, Tariq Toukan wrote:
> +static
> +void accel_psp_fs_rx_decap_ft_destroy(struct mlx5e_psp_fs *fs,
> +				      struct mlx5e_psp_rx_decap_table *decap)
> +{
> +	int i;
> +
> +	accel_psp_fs_del_flow_rule(&decap->unsupported_rule);
> +	for (i = 0; i < MLX5E_PSP_NUM_SUPPORTED_VERSIONS; i++)
> +		accel_psp_fs_del_flow_rule(&decap->rule[i]);
> +	if (decap->reformat) {
> +		mlx5_packet_reformat_dealloc(fs->mdev, decap->reformat);
> +		decap->reformat = NULL;
> +	}
> +	accel_psp_fs_dealloc_modify_hdr(fs->mdev, &decap->modify_hdr);
> +	accel_psp_fs_destroy_flow_group(&decap->drop_group);
> +	accel_psp_fs_destroy_ft(&decap->ft);
> +}
> +

[...]
> +static int accel_psp_fs_rx_reconfigure(struct mlx5e_psp_fs *fs,
> +				       bool decap_wanted)
> +{
> +	bool decap_supported =
> +		MLX5_CAP_FLOWTABLE(fs->mdev,
> +				   flow_table_properties_nic_receive.reformat_del_psp_transport);
> +	bool decap_enable = decap_wanted && decap_supported;
> +	struct mlx5_flow_destination dest = {};
> +	int err;
> +
> +	/* Create the decap table if needed. */
> +	if (decap_enable && !fs->decap.ft) {
> +		err = accel_psp_fs_rx_decap_ft_create(fs, &fs->decap);
> +		if (err) {
> +			mlx5_core_warn(fs->mdev,
> +				       "Failed to create PSP decapsulation rules (err %d), HW GRO for PSP unavailable",
> +				       err);
> +			decap_enable = false;
> +		}
> +	}
> +	if (decap_enable == fs->decap_enabled)
> +		return 0;

An llm is complaining that fs->decap_enabled is not set to false when 
the decap table is destroyed with accel_psp_fs_rx_decap_ft_destroy(), 
which would cause problems after doing a psp_dev_ops::set_config() down 
and up.

I'm not sure if this is legit, but figured I would flag it as it seems 
plausible and would be easily reachable by a user.
