Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8372B49DB98
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 23:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788910283; cv=none; b=fRioJUencyJD8BxvFw9cWWmryo8iSWYSNgK6799cOPQ5oVUBcdzkOtLlEJ4TLuvU19rJCNgT+cRb0Wzj4E2x5LZ1kQTP82DeefHUqsN40f0R9LzKFWFPPJ2BfBIJcug3WSBRqIWGPrxAWTQq/KPRWHvAcjIcBzjgcdmePrq7zds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788910283; c=relaxed/simple;
	bh=lgK52YWEbmOHlLC5XhevTS6kX/pGRh0yPlV7xZbQ1f0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QKpHnrb499/N0duvxrCEfgr7U8qrOIZQ/qSSADdXtVsk+vXH/KubJL63mmfL3nVpj9TsNg/H9Ez2VfukxSbAt/gezlvp4cDxuJo4Wd6ZP2V++irTfHDRkt4sf0RHlQX5uK7r9+4SlHSLbdHPZ+We/97BcxnW31HJ06yUV3mh2go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8i4RLV1; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8i4RLV1"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-90e7c71f86eso36989266d6.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 16:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788910281; x=1789515081; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Yq7lXkoWC5jfEWJMNBS6tBwhDj/bbJjyiLJq/Z7eNiQ=;
        b=a8i4RLV1pifuM++BymVVYhMaH0AdhH/xLDGup7aZ6IlEPRIwxlfnQpkUQ56dZBmVbS
         txpSL4mTMqPsJKXmxi3PYxf+Ua1IlW9pXqvM/VAyNVtEAZj/Qp3iXAt1ZOtGbjGFQ1oA
         2uXFcotFa9pnuMQOAI9juTQas/wV39y67P7IPsca+LSgnRKP9ZiQCbOscBdZVOALKhrP
         dbZuB78tfy00nzLF0nmd6ZvNs+FRX4I47RTeLNooVg2349Eum25A2+WVACsbjPxq54mu
         kmhTj4QlgFlEEivseQTrU8tLSs8WKZE1ykn+BFw8siruaFVjHO/DNn4GOW16abW1SbHi
         OmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788910281; x=1789515081;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yq7lXkoWC5jfEWJMNBS6tBwhDj/bbJjyiLJq/Z7eNiQ=;
        b=gv4aBcNlg+z9iAJbO+mjq3juBkEe9Dq/rAzoHxrtzths7lT/qakHyaPw8qa9u4uqou
         9WQ5JJuxav0kGhnQ4L8y/D+26SUniwyvb822BI+YSjJljAjHXADUlV//a/vW7tjVK9JP
         5sbP+ArtkRJabjsqMlJlsAlqcAE+NlTeklw/sWMOaI3Ivxt0nE+nGATUQjBx9NDAIN+/
         i6Y7fNsE4H7YTBUxPfIb0+Ta3Bx8gjLSqxBToo2Yx4EE1d8q0FfPvomsU5Oz5pQ/CBS1
         cnDs3raGq586mLKhd9D4kSfLLS5HNdq1Ig5iyDuY3vgpBTIjamJtxDO8tznBI7+QXe9F
         H3AA==
X-Forwarded-Encrypted: i=1; AKwUvBwEf1jH8jRtEZ0mymlfrQss+XwEEvACPLTGnClEMp+ZbFw7ewdVnpgZx8/c8Qfx2LueMrHB6Bo=@vger.kernel.org
X-Gm-Message-State: AFuF++leTZlAQMbUGKhu7GGRYDruzUVRLWVKxoksM8JzBEuNrQEwms9u
	0PtNCYXs3KfXUIT+iStBjRroXkfz8I6VBrsQQDuoX0mcgIiAL5w+VMte
X-Gm-Gg: AYBFou2bn1UtJ+3vK+SFt6WQ8dHlEbxSPrDO/avz8IOxQE9EwVBsX7EOFL6FIgmh6AY
	nc4Jvp3v+npKHKaSWhsh9Cm90MnRdagoHlnjSEMRNOPBeBsXk1Ewjv3e2rBMVtr+fXpXlw+Q7Uo
	dYnMKaculeuna9T1UfbR00n7gfn1AacSqzUyzwR0IKbxFTNAXdgXb+6Kpwrkqjpj3iNYWNzhqtZ
	6Sg6wmHS1VxPspq6MayVlkQ8zihROUcuYOV4/QSkc5LcPv4yRMhg0UpPCIT834Ts/XGUO4NGIPM
	hfSTgZqFXmVgGmpiuyG+CWbfEIpRJD/tjOr7O1l8OnRq1aQQvU+iY00ZDSD5t+ZUt/qSW7GaC+u
	J28WCxPWZ0bbHqup/7cmZVAgHyzOiLSFm/8OdUf089gslLTrRKv2LUc6j4feh1BFM8BwyMqvgQE
	MAFoC5dmJyLvuc3Q9+aFVKYDWk9v3S63NBsLNDgRA3fKgWrtw8tSWzLPXF6xpt8ZzRJA==
X-Received: by 2002:ad4:5ce2:0:b0:908:958f:4db with SMTP id 6a1803df08f44-9103eefd24fmr369191086d6.3.1788910276570;
        Tue, 08 Sep 2026 16:31:16 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91040694c35sm129077696d6.36.2026.09.08.16.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 16:31:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Sep 2026 19:31:14 -0400
Message-Id: <DLABRMYUL6Y5.2AH8IHHONR58N@gmail.com>
Cc: "Bobby Eshleman" <bobbyeshleman@meta.com>, "Boris Pismenny"
 <borisp@nvidia.com>, "Carolina Jubran" <cjubran@nvidia.com>, "Cosmin Ratiu"
 <cratiu@nvidia.com>, "Daniel Zahka" <daniel.zahka@gmail.com>, "Doruk Tan
 Ozturk" <doruk@0sec.ai>, "Dragos Tatulea" <dtatulea@nvidia.com>, "Gal
 Pressman" <gal@nvidia.com>, "Jianbo Liu" <jianbol@nvidia.com>, "Kees Cook"
 <kees@kernel.org>, "Leon Romanovsky" <leon@kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, "Mark Bloch" <mbloch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, "Raed Salem" <raeds@nvidia.com>, "Rahul
 Rameshbabu" <rrameshbabu@nvidia.com>, "Saeed Mahameed" <saeedm@nvidia.com>,
 "Shuah Khan" <shuah@kernel.org>, "Shuah Khan" <skhan@linuxfoundation.org>,
 "Simon Horman" <horms@kernel.org>, "Willem de Bruijn" <willemb@google.com>,
 "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next V4 09/14] net/mlx5e: psp: Add an rx_decap
 steering table
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Tariq Toukan" <tariqt@nvidia.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 <netdev@vger.kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Sabrina
 Dubroca" <sd@queasysnail.net>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20260908065244.3799142-1-tariqt@nvidia.com>
 <20260908065244.3799142-10-tariqt@nvidia.com>
In-Reply-To: <20260908065244.3799142-10-tariqt@nvidia.com>

On Tue Sep 8, 2026 at 2:52 AM EDT, Tariq Toukan wrote:
> From: Cosmin Ratiu <cratiu@nvidia.com>
> =20
> +static void accel_psp_fs_rx_reconfigure(struct mlx5e_psp_fs *fs,
> +					bool decap_wanted)
> +{
> +	bool decap_supported =3D
> +		MLX5_CAP_FLOWTABLE(fs->mdev,
> +				   flow_table_properties_nic_receive.reformat_del_psp_transport);

not for this series, but this makes me think having some way of letting
the user know whether or not psp with hw gro is enabled would be nice,
so that they don't wonder why stuff isn't coalescing when they have old
fw like I do :) I could see a similar thing being useful for gso
features if the psp device can't segment something that it otherwise can
for non-psp.

> +	bool decap_enable =3D decap_wanted && decap_supported;
> +	struct mlx5_flow_destination dest =3D {};
> +	int err;
> +
> +	if (decap_enable =3D=3D fs->decap_enabled)
> +		return;
> +
> +	/* Create the decap table if needed. */
> +	if (decap_enable && !fs->decap.ft) {
> +		err =3D accel_psp_fs_rx_decap_ft_create(fs, &fs->decap);
> +		if (err)
> +			goto out_err;
> +	}
> +
> +	/* Redirect traffic to the correct table. */
> +	dest.type =3D MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
> +	dest.ft =3D decap_enable ? fs->decap.ft : fs->rx.ft;
> +	err =3D mlx5_modify_rule_destination(fs->check.rule, &dest, NULL);
> +	if (err)
> +		goto out_err;
> +
> +	fs->decap_enabled =3D decap_enable;
> +	return;
> +
> +out_err:
> +	mlx5_core_warn(fs->mdev,
> +		       "Failed to create/modify PSP decapsulation rules (err %d), HW G=
RO for PSP unavailable\n",
> +		       err);
> +}
