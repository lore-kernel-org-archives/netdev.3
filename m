Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792578646;
	b=EFh668gS3G7YWtvc9wZKbzuF8gSH5LgoQAXnV4/fqzTWEmjHOqlN8vTmKMVjytmRSExN
	 +fKoiY8oOhrDpnkL22x08lqdUqxCLeBPKjazeJ3iZLRD4jT8G8vFkaF5h7JJkL1zIY+kk
	 u3zt6Bw2HItkyKO+XoX6C3yb1uOmGec/EPvoUzuEnhDBQ+6DuJwEJOedQCImtH1kTsBtK
	 cmue7yXNz2S8qKtqwfeMqNaltRZ9JMj3swSmHI4SjfYmhYV+LTi/kXo2Jz15+45au+sz+
	 RveSrLw1plGLTqFdqVAKT2pRarG5KIbYZZLM8UcyESGg6AOI7i284+TJp9DdpFtwZCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792578646;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=y2MXVuSopof1u2e0UlPr5RPihuMcVA09Qb/rkeKWPFM=;
	b=W8YCINwhz9gyP2i8KP5T8yQ2KAzGIgbp1FhTzMAWrKt5447ZyoCKkiOdUku4sXHZUyAV
	 Vwge9I3ot71STA/uVZeokRC0ISQcP4pSqC373CdumwzTCO0rvh9oueMyy6KjCKbpuR8a9
	 yFPKUBpZXMyxrftYZAlOlXZgTS2ONnpUGia1fQp5Jhgv7jIITcNDRcmaHO/Bmw8jYxluQ
	 VWVpkXm/VS56uuB7PDhIzOrU7TCCqFaFsAejKD0OSKISolfqD7A5jGgrOTpgW5vanXL/Y
	 Vz2qFMlh+PiLP2GG6oA1Z4Io+6QoVDgoXbO0TCaccz32oe058UHi7MVLTactKUdq5nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NiN47LXO;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9EE606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 10:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B9EE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NiN47LXO
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93f20b304c0so64859585a.3
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 03:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792578645; x=1793183445; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y2MXVuSopof1u2e0UlPr5RPihuMcVA09Qb/rkeKWPFM=;
        b=NiN47LXO04v4hyKr+QhytOE2XBZual7D7I4CjlAT49XnuIDnsILBroE+wzeG3RgHkf
         aKpPZ6tOC2iWHiRrGVpHjfOW9OWSe1El/yQ1bVWHaF68SnV7s2Tbz+Q9dGKuyBiCOOUI
         k1EfZRvJ+fJtsb8u7/K2kBo5MwX+4RKW+usn0kgiAOynxgT2NrGxhYERUWSTH2ttDANg
         pDNURVRkiKuubm2NanbZUE9zrgUoHUuCGWQL9bFZ3usxAgFGpoOnRfkifri2ViO14ywh
         Y8TVetp1OAUKuKxNbhcnCBmJFMoKFV6xHqdMK+03JZDA4b8Y1M1/rnfANyYCFSwODd15
         +htg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792578645; x=1793183445;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y2MXVuSopof1u2e0UlPr5RPihuMcVA09Qb/rkeKWPFM=;
        b=l6DAGT2iWAMvb0FfJmCeQbe7DtHHe1YOf4n9jU2uhYhXkfUC9P5bLlWNh8KlYZpqP1
         JocTOZkyjjSTWAYA79Xf40Nob3JtkiT4HQH9EiQIN01hQqJ25G9E4/+ZfsbK+utZ5/FQ
         R+rzzV7Fxl/UEn84tgZtToMevvjm5QTAER0i42mIhj3Ye1+DO/G/SjVXu6fRPoFN6jth
         iPM8Hq2LXTPKFJMXytgYNeEo57Xi2NxkuxBzpoqNXnAfdm19UR8XIUVMap0fHhGRPBM6
         eqxkdEqWG5GkiQB8V7e09TfHT0yR8ar84a1oq2YomuOIeQTWqtEV+mvodmEF6OstYuXZ
         Bt+w==
X-Forwarded-Encrypted: i=1; AKwUvBxlQGYLBALl7KDaIDFwFN3OdaQXuC8+VLi1R0CYxMTPE6xAkhJsYCDgfbq4qvkdaubNTJI8T+U=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7cA4stsldBztb5f2sm9W5e4yOGosXS2IdBc6TtKhqAVyrrnZ3
	MNb56mljE+XyfAr98xDoS5QJdIRJgP0cjxdSNDdkLjzF8+sVuc7YYvHu
X-Gm-Gg: AYBFou1GfSajv9GPD+8AIK0iY4Oa1c7FgbLq38Ht00NdYh0OfgiP45YaUCI9UYKTNQt
	HVKPF6NEMYtnJ6Uw5oMk6isLLE2IAu7fOgV1Dx78QASt76LhyHQUEHvuXUkbtGTazE9UyutO0A+
	7Zfy4+U3oglZFaVNKAJdyFjQnj0r7C6qjytkoSla3uU31msPkMa7HYb/UBwftvV0pSLWxUeTeUm
	aLBoLKILDvYkqS5DwY2D2i055yTVWUGFNFcz4z8CMNGAm/zjcEo/MUvIeNqYBhKgqjObJ9Ug+Vy
	iUWUulsJz3SSCLVCUIFcOTu0x/Ya9qMPfbueoMTHyW9dAC2x2JDL/wU6+AyX01B7/v4nR+Q7vxc
	AYEzPsAO++0pTS12f6muzV0VxM1rLmOsFyIbn1GKUf+IC/6IE7CvfYglNCMo3eZgk9ZIEdgg3RX
	uvCZ7l7zb+vgXjqdiMrt6SG58YrQ5WJy5tGX8eSBBmexqKfc+b9dyC865RczDAaZP0HSg47V3ap
	CWy1WZYld6ospAthH+trPSk9+2zanYaknTm52nNpJdMb06S3/5s6XlUdwiq
X-Received: by 2002:a05:620a:29d6:b0:93c:635e:6f3e with SMTP id af79cd13be357-93f57f1d225mr356392385a.35.1792578645233;
        Wed, 21 Oct 2026 03:30:45 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56d9af50sm215318985a.8.2026.10.21.03.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 03:30:44 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 06:30:42 -0400
Message-Id: <DMAG3G194BUB.JJKBBQWZCU5C@gmail.com>
Cc: "Boris Pismenny" <borisp@nvidia.com>, "Cosmin Ratiu"
 <cratiu@nvidia.com>, "Daniel Zahka" <daniel.zahka@gmail.com>, "Dragos
 Tatulea" <dtatulea@nvidia.com>, "Gal Pressman" <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, "open list" <linux-kernel@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, "Mark Bloch" <mbloch@nvidia.com>, "Raed
 Salem" <raeds@nvidia.com>, "Rahul Rameshbabu" <rrameshbabu@nvidia.com>,
 "Saeed Mahameed" <saeedm@nvidia.com>
Subject: Re: [PATCH net V2] net/mlx5e: SHAMPO: Do not merge PSP packets
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Tariq Toukan" <tariqt@nvidia.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>,
 <netdev@vger.kernel.org>, "Paolo Abeni" <pabeni@redhat.com>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261021062805.3466208-1-tariqt@nvidia.com>
In-Reply-To: <20261021062805.3466208-1-tariqt@nvidia.com>

On Wed Oct 21, 2026 at 2:28 AM EDT, Tariq Toukan wrote:
> From: Cosmin Ratiu <cratiu@nvidia.com>
>
> PSP packets are UDP-encapsulated, and enabling HW GRO (SHAMPO in mlx5)
> makes it possible to merge those packets in a silly way:
> IP|UDP|PSP1|payload1|PSP2|payload2|...
>
> That happens because the HW GRO machinery doesn't know about PSP and
> considers it part of the UDP payload.
>
> Reject merging when the incoming CQE has PSP marker or the pending skb
> has the PSP extension.
>
> Fixes: 29d7f433fcec ("net/mlx5e: Add Rx data path offload")
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../ethernet/mellanox/mlx5/core/en_accel/en_accel.h |  6 ++++++
>  .../ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.h | 13 +++++++++++++
>  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c     |  6 ++++--
>  3 files changed, 23 insertions(+), 2 deletions(-)
>
> V2:
> - Separated from the patchset.
> - Moved the PSP merge check into a helper in psp_rxtx.h, with a stub
>   returning true when CONFIG_MLX5_EN_PSP is off, and an en_accel.h
>   wrapper, replacing the #ifdef in en_rx.c.
> - Also reject merging when the pending skb already has the PSP
>   extension, not only when the incoming CQE has the PSP marker.
> - Fixed the commit message diagram and capitalized SHAMPO in the
>   subject.
>
> V1:
> https://lore.kernel.org/all/20260917175433.4090878-8-tariqt@nvidia.com/
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h =
b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
> index 3f212e46fc2f..5a340f1435e6 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
> @@ -218,6 +218,12 @@ static inline void mlx5e_accel_tx_finish(struct mlx5=
e_txqsq *sq,
>  #endif
>  }
> =20
> +static inline bool
> +mlx5e_accel_shampo_can_merge(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe=
)
> +{
> +	return mlx5e_psp_shampo_can_merge(rq->hw_gro_data->skb, cqe);
> +}
> +
>  static inline int mlx5e_accel_init_rx(struct mlx5e_priv *priv)
>  {
>  	return mlx5e_ktls_init_rx(priv);
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.h =
b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.h
> index 2b080c39cc37..9fd1ee789de0 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.h
> @@ -85,6 +85,13 @@ static inline bool mlx5e_psp_is_rx_flow(struct mlx5_cq=
e64 *cqe)
>  	return MLX5_PSP_METADATA_MARKER(be32_to_cpu(cqe->ft_metadata));
>  }
> =20
> +static inline bool
> +mlx5e_psp_shampo_can_merge(struct sk_buff *skb, struct mlx5_cqe64 *cqe)
> +{
> +	/* PSP packets cannot be merged. */
> +	return !skb_ext_exist(skb, SKB_EXT_PSP) && !mlx5e_psp_is_rx_flow(cqe);
> +}
> +
>  bool mlx5e_psp_offload_handle_rx_skb(struct net_device *netdev, struct s=
k_buff *skb,
>  				     struct mlx5_cqe64 *cqe);
>  #else
> @@ -110,6 +117,12 @@ static inline bool mlx5e_psp_is_rx_flow(struct mlx5_=
cqe64 *cqe)
>  	return false;
>  }
> =20
> +static inline bool
> +mlx5e_psp_shampo_can_merge(struct sk_buff *skb, struct mlx5_cqe64 *cqe)
> +{
> +	return true;
> +}
> +
>  static inline bool mlx5e_psp_offload_handle_rx_skb(struct net_device *ne=
tdev,
>  						   struct sk_buff *skb,
>  						   struct mlx5_cqe64 *cqe)
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/ne=
t/ethernet/mellanox/mlx5/core/en_rx.c
> index 903af3b3e779..d49f26323b1e 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> @@ -49,6 +49,7 @@
>  #include "en_rep.h"
>  #include "en/rep/tc.h"
>  #include "ipoib/ipoib.h"
> +#include "en_accel/en_accel.h"
>  #include "en_accel/ipsec.h"
>  #include "en_accel/macsec.h"
>  #include "en_accel/psp_rxtx.h"
> @@ -2268,8 +2269,9 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct=
 mlx5e_rq *rq, struct mlx5_cq
>  	}
> =20
>  	if (*skb &&
> -	    !(match && mlx5e_hw_gro_skb_has_enough_space(*skb, data_bcnt,
> -							 page_size))) {
> +	    !(match &&
> +	      mlx5e_hw_gro_skb_has_enough_space(*skb, data_bcnt, page_size) &&
> +	      mlx5e_accel_shampo_can_merge(rq, cqe))) {

nit: we already have the skb from the line above, why go back to the rq
just to find the same skb again?

>  		match =3D false;
>  		mlx5e_shampo_flush_skb(rq, cqe, match);
>  	}
>
> base-commit: b6ef0d965fe8ce0ee4b4dcb58b3511f83003e42d

Makes sense to me:

Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>
