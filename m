Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793136452;
	b=LOloW21K5A/YL7DfSoexQ2viACbdmv5xVyU7q1duU6x2PoFzmI+I2SUU+tXRNj3PFClh
	 Rg2x20z+xInd98k9vt9D3hiEJWndC+sLr+2gUHlXqQTFLyNUUvlYcgM3COMsar3/F5ItK
	 TUGV+aoGOGSJ/mAhRCUEKlYUI/PHFDkC4cNCOOXK2/yJTkL6EcihjM47lDuy/kzSIgs5c
	 5+BZnXoM7DVKXXpkW5V7mCDYFDuVwxx4Zf5DMvpwSFN/vwHoU/m4l9SbecxRxXtPdnoLQ
	 feiLcxmUrJbA7j4PP++W9DEdbrbMLN+8GK+s3IDLLGInRvrXAvVhkkeXHdb4MH7s1FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793136452;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=zmfjQ+QJFoW1j+qRFoligu6O+sZZbd+7UWwEUgPrfjk=;
	b=asXFmGRbZvZ7y1aeVgVoIUPDZT52ICY/59+3bg1+zsoyXAzu5kf8Q7JUkN55F0ea0HEh
	 5UR0cVTgXOqWYa3pvKl+xWiTZNfri5Suu4PUI27Z9sOdhq5WMzw0ywwWTUWy6L0GbYzWd
	 djCm/0m7pmOeVmRsIX2SX23YQya2/Oq9MJ2tGtg66w/bYV+YCYrolWBTbuj5BAtDTtoB2
	 JWTOQBtw7wH2ENYl4hJQcSEkYGFIJ2FxAJrsW71zLF9G5527a3jF9tQMjDLNSkwt3QbFC
	 XJda65atSnk8NaX4I+hYHMPIfVeN5pe0yAciuZGiC9MRcT0Eem5Mtz2fxYhwSCwGLcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HBsaAymq;
	arc=none smtp.remote-ip=209.85.221.169
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99FF606A31F
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 21:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A99FF606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HBsaAymq
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5eaeb7fdda2so369045e0c.3
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 14:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793136450; x=1793741250; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zmfjQ+QJFoW1j+qRFoligu6O+sZZbd+7UWwEUgPrfjk=;
        b=HBsaAymqvQ6e3C208Z9epw6vz5FpkGs2UPqRvGkcy7eeT8xedN4cMAjHC389rdsTp9
         0ulWpDKH8JyQJhAzOmpR4u4IPYt9w+s09bGYW65H1hL1H5349sFtUf2cZKLA+rLzCJJb
         rHvT820FBKpXmgX6vd3Avr2PUb9ETGrcpQZsdXR1YF1Us2uN9mlmggnSVAk0RebLwjfg
         7flLpT2gMoFS6t7vhwQqTzI2BAAERs/Q2C/hJLn1sDd8oGWIa8c4xVhT5mKUKbVj//MB
         m+p4dr/juATYVk6KgVJxCQctQY/ODmt9F272gk7sQ4fxrxtaMcJ2zlBjbW8Q7JT+RYmm
         lnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793136450; x=1793741250;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zmfjQ+QJFoW1j+qRFoligu6O+sZZbd+7UWwEUgPrfjk=;
        b=vgjHR/XbSNMUX+GHHfw4txPEg/xDd0castldYSRGyK3UEAhSciNbTE1d7c/S8OtXhy
         gHHH0zbes9WhO5qoy//amybTXjs4/Nr+hDM68NVrjIrEfM/Ipabwe1D4cxhZcf/Zpza1
         fErmLeQCDEwxlPDu+4C7kTO4df9TFoy9Y6JNoMiWsjldzxyUTCKDQE6Xc8lmB1wUXlBm
         Ek5dfvjytLeC5lxP7p9IrCQqJGpfPAnEeqWM1+H/bZXgsTYw0Bmfhj79ctPIyWGHhL4f
         INCOOkJHMc3IE4JgZ6m8YeUOuDJNcIi6SHSJiwt/ibXXtLZ1BBPYIy3GhVzwDYWkU5RK
         d4Sg==
X-Forwarded-Encrypted: i=1; AKwUvBxbTz+lxYJv2h7dIiMqQPGNnoX4R1OM0FmqtcM1s3jgZJAzTSbxE6pS2E/yyRst0nCCSHTc1Ys=@vger.kernel.org
X-Gm-Message-State: AFq9FYJUcFjIfW7K53MbjkUMMKbJVyzCk9wMAgP7E07oWc9ckbYPG/Q/
	8p96CCTrPg2KnAakEeWizmOOMtw/rpRKWvn0IUfVLzlDA/Xq/aSD/yCi
X-Gm-Gg: AYBFou0JCVLzfYcb0LpUbI/MFLgyTEnwTXRQwC5A06uzAMnBD4TWE8SrSMC/DPQ+vkK
	rnjlWiUN0IgWRzG8W0ZyDhFJPyl4GDwhd7EIIFyhzo5Uy/Ou08OyHrP4eSD+A8Vairwww+6zbbu
	qK6v4aGcyrwB/3VaC2bkiueKtiSCkTCHhhY8dee0ahsRUms6EQGMYuAp++7QEfiGI5LHVdDOYeo
	hFibIaggyu02W9vTCH9ymqTRngc+ROjlElCkBewL+puiyKjoEI8Xyz2MKFGWUEdRrqKMYPhVetb
	x6b0KrMNmqxv2OOBX66eiQBNj2jfeCAqEORrdb5trBVq4ivXMi8AZr1q/4Rg3zLk4Iv2ihs+2GS
	eH5bksz1qXdcAPaYpnNz/UwSrT9paMYKwzuQA5ZIQqm2Xe4Fj2qE7kGCdEWBR+lTAlEAWir/V0B
	cfns2tCBImNFH3qYp839zx+Y3/zej7lZaihXIrqbsZeRuTXbWsSfcgcFPjUjSVMV1wGXecpAzf5
	YOqBmzyXjHBZenloIhsBhobnYIr5vbw9W16vyb22UNUvJ/2f/yk8zarNv2l52sueW33AYqavW8v
	Lg3QFXagveIj7GIMmfooYWWzxXO985ke+v1aA+fCxHAUfQ==
X-Received: by 2002:a05:6122:3306:b0:5c9:a60c:273d with SMTP id 71dfb90a1353d-5ec4cc9d3d9mr258607e0c.21.1793136450614;
        Tue, 27 Oct 2026 14:27:30 -0700 (PDT)
Received: from 16.15.168.192.in-addr.arpa ([187.74.25.171])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec23067632sm12770415e0c.0.2026.10.27.14.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 14:27:29 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 Boris Pismenny <borisp@nvidia.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, David S. Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/mlx5e: macsec: free SC lookup entries after an
 RCU grace period
Date: Tue, 27 Oct 2026 18:27:19 -0300
Message-ID: <179313643925.89661.17416575088535677375@gmail.com>
In-Reply-To: <20261027142601.GM257209@horms.kernel.org>
References: <179285888829.90275.17386097105525068016@gmail.com>
 <20261027142601.GM257209@horms.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Oct 27, 2026 at 02:26:01PM +0000, Simon Horman wrote:
> This patch does not apply because the problem in macsec_del_rxsc_ctx() has
> already been addressed by ad17ad50b8dc ("net: mlx5e: Fix use-after-free of
> the MACsec xarray entry on RX SC deletion") using kfree_rcu.
>
> I would suggest taking that approach in macsec_fs_id_del() too
> unless there is a reason to use mightsleep.

Thanks Simon, I missed that ad17ad50b8dc had already landed. There is no
reason to use the mightsleep variant, so v2 drops the macsec.c hunk and
embeds an rcu_head in struct mlx5_fs_id so it can be freed with
kfree_rcu():

https://lore.kernel.org/all/179313582625.87630.11382992904624255106@gmail.com/

Joas
