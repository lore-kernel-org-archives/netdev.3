Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA2959C984
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 22:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788908168; cv=none; b=PFp7OG7HX3VS1AoEbf/c1FW36/jzUcUPOOedzE+q4YskfR4lyHz4grzoOJ1Obv5kCkhyLUi589sVSkfh0c59y0AdTvnlnVjTGJS58Owdx0hKeY2NBbZEsQH7XQnhXqC86JzLqVpuTRbmBJcFgnj+LPXmrnw8wHZHo+LY1Sa1gb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788908168; c=relaxed/simple;
	bh=vsBDx43bAIddb0gfmnVkap80n2BUxIXNwZDCRSqU0zw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=ZFEaRBgdKYfKWPozDjvIFwdrAcs3A0b4ZU4rT0eSTwHLJIipRLPr18yQF0VK6h1oDFvkA6T4h9xkLhMomIr26W82w3wl4sAe3y0q/gZE/NhBDmSc3fkxlGOex7J5UxwvwHF4xM1xnnPOmVlmiSqy8HBuIy5GAyLVXKwWvyoQk8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8agsmbs; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8agsmbs"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-52d7a3defe8so51412891cf.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 15:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788908163; x=1789512963; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UviIj0mAB9dLNORxdxu0OPN9iCyl2WihzfLAQT9a7wo=;
        b=O8agsmbsZWP0vIWWvG1/AT2jYZeC0zXoctb2/Cg0+eIsidsXQT/WkZs6H+V7vxDA9t
         AuoVBht/vgsGsDpmUx0ijF9CO0EBJUbIo3/2JSx7tJtwvP5ZzUTdOaGFZPHnegHhf/d2
         j1yRyyw0gb4LB5E6GtcTmUss+pJKywXHltXEy+IicxpxHd8Tbb7Z/s3y7gTd67Yq3x1J
         Gs3o574yZSp4m/zxF/BKN8r9fxzGaB8nnNWHAhfqRmUKTICh1OwN6gUEE7hr9hDePSp4
         D6v1na1vitV8Gjsh6roGjx4eNbvToIBim7z81oaVyd62XgSDph+C6U/VRQKz2JZKE+L7
         ID0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788908163; x=1789512963;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UviIj0mAB9dLNORxdxu0OPN9iCyl2WihzfLAQT9a7wo=;
        b=MjPwcSxk39LEPY44T6VVopenYyfJLIQ7AcsHhO45a1HNdt41mbhc0GRYqMs+Rsf/io
         9Ep+mX1aApV3BFI9cqiaKgwB4hntj0bR6/GURn72Z7au89m/dB7EXbVOWrTlKkUZeIvO
         wsyz1g8M75rHGvcZtbom2L4p6VlJX/3gXuUegbzS2V9j9Lw2U2b8SNWSL4oQmbXUtvN3
         KbF8Y3IKpPZEU4YrtHQxWfWZbeeg0Ceg6MsRkZwkrJrToy0BRsME78ZQ2x/WwyYCGmMm
         nxE5tKc3cH0BotUWhMmGTNCAok1NfgcfWS+/Z81TCqBcO+ft8Ii4mxvE2J5V1VZWWwUj
         XHkg==
X-Forwarded-Encrypted: i=1; AKwUvBzpkwdcX3fwNeu2BWpoYLsoWVKMKu8R/nT+TZWyj3DIDEmzf6Au0hxfnBQZiAL5wi647tYs+R4=@vger.kernel.org
X-Gm-Message-State: AFuF++mVjAfRSW0FWkUuCpVrdvxIr5xCUwFt5obHP5UlBdm7rZLnVYRT
	7MJFUt2DRMpuhyO2XOVcQc6mQoCi/JH/fo0+21p4rp/aVBSfWPrReUHd
X-Gm-Gg: AYBFou2di8UiucesbeCmh7JavXnchu9C6KvggwLX7F5HhssHtZTA50xviDFXRq52+6G
	xMqGWUZjwnUb5hEdUpkCQgQSOeilKEefko2WavX0ino22+w6UuChJkewb3Imhtk15Y6Pu2VYiJ9
	/W+P1i0eT6/7d3HKVbzV33IW811itSAIKBdsOa65b9gh8bvo5eD3YR8nVMzs4Cg6L1TXO7/zBeC
	A+ho0kZTNJjNF7gO7afnA8CJUGHw2+5nwOkSqRIlIfa8kYOqijK3AmYSsI+p7/Feu4aTgFHXIJO
	+JZa4QkQwV1+lcPnFk8urVo4tLFXV5uVPmi3lYdqTdflUmcBO5b2yXyKoc0fKCfrAwcd0tJP8OW
	FowJQf/pXElQDFCXy4U8glyKxHu/D/AsOlu9wi3vjxpuCVyOSQ8KAdWpTAojW2Usyw7p8AcmTQL
	AFkuh3zgXYoum20wF2OPOTmcK421/NDTqy68gEs4Sv+rdWvNXHKoQTBskzavLfRQkoFg==
X-Received: by 2002:a05:622a:551b:b0:530:5418:92be with SMTP id d75a77b69052e-53054989290mr42134121cf.28.1788908158185;
        Tue, 08 Sep 2026 15:55:58 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9106ba5b95dsm7172286d6.21.2026.09.08.15.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 15:55:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Sep 2026 18:55:56 -0400
Message-Id: <DLAB0LQ7WDE9.1IUD2U6BQCRKS@gmail.com>
Subject: Re: [PATCH net-next V4 13/14] selftests: net: gro: Add PSP
 encapsulation and encryption
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Tariq Toukan" <tariqt@nvidia.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 <netdev@vger.kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Sabrina
 Dubroca" <sd@queasysnail.net>
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
X-Mailer: aerc 0.21.0-threadmapfix
References: <20260908065244.3799142-1-tariqt@nvidia.com>
 <20260908065244.3799142-14-tariqt@nvidia.com>
In-Reply-To: <20260908065244.3799142-14-tariqt@nvidia.com>

On Tue Sep 8, 2026 at 2:52 AM EDT, Tariq Toukan wrote:
> From: Cosmin Ratiu <cratiu@nvidia.com>
>
> Add a PSP mode which wraps every transmitted frame in PSP transport
> mode and encrypts them in SW with the help of OpenSSL.
> The receiving NIC decrypts and decapsulates, so the frames seen on the
> receiver on its AF_PACKET socket are identical to the non-PSP ones and
> every geometry assertion in this file applies unchanged.
>
> Sender packet construction is unchanged, PSP uses a different buffer to
> avoid double encryption.
>
> A few PSP-only cases are added: psp_spi_diff, psp_ver_diff, psp_mixed,
> to cover coalescing scenarios which only exist for PSP.
>
> OpenSSL is optional and scoped to this binary: gro is deployed by
> several suites, so a missing libcrypto costs only the PSP mode.
>
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
...
> +/* PSP transport mode encapsulation, as built by the sender:
> + *
> + *	[eth][IP][UDP dport=3D1000][PSP hdr][encrypted L4][ICV]
> + *
> + * Can't use the kernel-only include/net/psp/types.h header, so copy the
> + * encoding here.
> + */
> +struct psphdr {
> +	uint8_t		nexthdr;
> +	uint8_t		hdrlen;
> +	uint8_t		crypt_offset;
> +	uint8_t		verfl;
> +	uint32_t	spi;		/* big endian */
> +	uint64_t	iv;		/* big endian */
> +} __packed;

My llm is complaining that it thinks __packed is not defined for
userspace code and being used as the name of an object being declared,
instead of an attribute. Otherwise:

Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>
