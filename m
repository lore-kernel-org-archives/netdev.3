Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F98D4D7D4C
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 18:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830352; cv=none; b=FiXkSmX2Di9K1D3FbR4q9+9eA8K4qT6U9N3OPg/48OlT0xKaAwo8GNMPpC3Ik7ZTSRP3sDcm+MPXmggG+eToBeSUxXyMvGpqcKC2Ry4OqPYEqK6DVYj+nHQUtP23C31nbSOfeRe1hh1dOy34QqTZjx8KU2aQUqdLlcg7arOVk/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830352; c=relaxed/simple;
	bh=DWG5xbSbtuZQ3Yi/ma2sPH0E7BKe08p6QVtLH+Y436w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j13nUxSpkS22rifhZju6t/8kCQ/S9GxluORGTtFrMhTjaPgeJexQhKxDRcyVVniRU5En5wVqdDdg0O2V1uk4elYrt6uTfPmusSBvg06bUvOUeNlejSiNHdC4SalR9dqHrTD/wkQwX9HDcETWuIv7g68nJB1bgibxULLVWQfAD0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=gtjMJfGW; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="gtjMJfGW"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-878b44611ffso1375540b3a.3
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 11:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1791830351; x=1792435151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vXwD7B7wFoNoD+47iCkliLk9LICzBNESzSCZLUAHn0M=;
        b=gtjMJfGW+UNdqPN0p9ttkTOxHaLe+y3dttIESgXagpQO7BZaL7d2sSDMZEUHjBuIxu
         gK2737m24egPPmnAU0DI56gO8z307tSEt1+9VXiOwHVrvZWHLiee4ExcE4rG5Htz4noR
         DVkPUC1Hms0bD8H+1C5yW2/WkDPA6Crg8RKYm/JvatdH5NNUIcTvfDl6kPBqqnNmCY0Y
         OXDde1vKAjXu77m+Pat3H+aJaECpm+1XAUmVPdNvH8VkzP2qZXO6Dbclm3okmK1XNGm8
         TIqvEIpKIvuwoZ3Gwf0UcDsjsNy5EjzN3sqc6rMOyfXzQy6vH4TGlqx7ZDrf9gjmMB+S
         738A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791830351; x=1792435151;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vXwD7B7wFoNoD+47iCkliLk9LICzBNESzSCZLUAHn0M=;
        b=IvgpYjsrpN5m10j37JE8oh9uKBgtHM7rFxHcz0PuEKw4okn1v4RsCtiTSbcTAYODj5
         KmkhUFPQ1PP4W3mWFS26mV6/R4vecoAsTTPfML/xeOFqxS+Z6NgrdDX38a/IFXWAJY3Z
         d0Msjbsz8bKO1XRMpTc48eVLoaHmltAZmrm+LiI6BIADf2Y4j0BOzfEfidS6oyQW8XNh
         vHIpt4lebzNnqi3mw9qIBQV9tiM6YdqVJogQV7M5anDHXL1LH/KngsFNzB866tH4dyUf
         eyaboDxiravrM0JaHjqbg/usuwq3wWfaU3VlAu7Uai96XMhAe4w0cAUisAcuOXd+g95N
         LYZA==
X-Forwarded-Encrypted: i=1; AKwUvBwH/Cjl+Z/TXCTW7Q0vviIM+95JiXuqe6xKmn/ssj06LpnOTWSp7wr7mCyJUDmgh/0nc4iZGEw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLMvVTIjl7lnk97sVzljMfWLYqoso1deviheCjUTQsnrYDN2Kar
	4DBdX5IXsyIIp4ftacltQsqw98s8Bss5jn/xjXDpSSw8DhhZXYuGzLSgraE60kK22LQ=
X-Gm-Gg: AYBFou0VJvSrvytyorgFmlLqeDxbPBOFf4I92WTR/m7ieBx3jT+jqxRpPm6cettpNAd
	0thRdVPGtjqH4NnEDM9g/3qoOBypQfaYChPS7F2bs23ZOFxJV+Vjwe4A64YZW1bsa7+eNL8LDsh
	Qij2uoptM/NWqhyHTzlIUcWDaga1d4cRH5YHZI11bLEOrkE4NgmDkuZX6mQFZbBRIn4E1qtVH/a
	VGvuTF2a8kLTBDsqqrjno8kw2xHLGc1v+VcLmbhUL65jBwfGgjAxHdy3//pAS66pLFnjKZHyntr
	tULr4iB3cbDjT/y6CP5ZbTPOl9oVvVD9lDee9bxr3pwjJeKazdX3DC5rbvh9BH5wbpUtOW8uD/h
	dlJfQrFdfZPwRVn7yW1SdCGjm/mNDPTkuBPLZcQe74/GGc/kcwcjFgifC3rxa7QH4vb4k1DKbu0
	I72YzSzh/PvcJwZqM3trh/JLFMqTgLpP8BIf4UTFjMisrGWOzpNc2gPe52oyOmkLxV69dVPiuiq
	oc8+CoyaXQ=
X-Received: by 2002:a05:6a21:4d0c:b0:3de:9d59:4d19 with SMTP id adf61e73a8af0-3e16b794290mr8792696637.0.1791830350766;
        Mon, 12 Oct 2026 11:39:10 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3d9e08c89sm4506558a12.8.2026.10.12.11.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 11:39:10 -0700 (PDT)
Date: Mon, 12 Oct 2026 11:39:09 -0700
From: Joe Damato <joe@dama.to>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Alexei Lazar <alazar@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Shahar Shitrit <shshitrit@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Stanislav Fomichev <sdf.kernel@gmail.com>
Subject: Re: [PATCH net-next] net/mlx5e: Rename state_destroy to
 rx_mode_active in flow steering
Message-ID: <as0pTSCMTCOAbs0c@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Alexei Lazar <alazar@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Shahar Shitrit <shshitrit@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Stanislav Fomichev <sdf.kernel@gmail.com>
References: <20261011093100.769149-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011093100.769149-1-tariqt@nvidia.com>

On Sun, Oct 11, 2026 at 12:31:00PM +0300, Tariq Toukan wrote:
> From: Alexei Lazar <alazar@nvidia.com>
> 
> This flag controls the enablement of RX mode handling (promisc,
> allmulti, broadcast, netdev addr sync). It acts as a safeguard
> that prevents new FS (flow steering) operations during device
> teardown. When the device is in destroying state it is set to
> false to indicate RX mode operations are not allowed.
> Its name is misleading, as it suggests a destroy-state flag
> rather than RX mode activity. Rename it for clarity.
> 
> No functional change.
> 
> Signed-off-by: Alexei Lazar <alazar@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en/fs.h |  5 +++--
>  drivers/net/ethernet/mellanox/mlx5/core/en_fs.c | 17 +++++++++--------
>  .../net/ethernet/mellanox/mlx5/core/en_main.c   | 15 +++++++++------
>  3 files changed, 21 insertions(+), 16 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>
