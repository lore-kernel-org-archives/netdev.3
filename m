Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793752770;
	b=kQp6QS6vxjWD61xzJ3BYxM9JkFmew8dqUNw9p/elJGeslJQAbkQ1RbWk7PSAPg16dUnl
	 mCa9s8BSiVBr2VlZSID4O0KoiYU19JKCozQX78EvlyZYUg+xnRe0LiypWCHtW/LP4fQ9t
	 nfR/IdSGBTJrVvRyeV/ZNPY5GWpZJYXW56wXI7j3zF8tRz69femP3g5Fc5YYyhZAelbeY
	 M0Qwu8w2FRCdYQQXp9Htp9yCu0dBYQMrr4CRpkTCBesaeSOy/LM51pkraCsyksNLkpTr4
	 P3wpR13aVYXcq2qXkd2SbmEsQpSVsnGRLPdCGnc0/OD1djlZjAOpN3WfMGOvDR04xKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793752770;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=lQ2xOzxsF+CEtv2Z632brvuKrWBZQypDKsxmzWa1C5s=;
	b=4NpJsYc8jQ2SoiFEpBZypKTT8vat0fBdI4uUg8bEiL2x4zeO6qIyGn487Sjv8sA1Hnko
	 dfRs+2QrBKcNj0hTZnaV0vpxX7pwxoK0IJL62L9DT4LqK4Wg3iEAbCaUtWhLv8kk5wlmO
	 aph5P8r3BA/at4VGPAc3C3l1aXrRTLeIRLoFVfYpZV7FXUqzShss5tCLG4r1J+Lkvgmfu
	 9nWFA+lPtZdTtIOmJhwgJXW+McIS9Vzlb7Gi/f85lHRu14V/S15jlP5ncl7cIgZ1ZjZ5u
	 n7RSnQj48dtv7CGymZxrGso4ey+4TypZxZQsW8mLgZSAZNuUDI6DG12dyQleUWKWDRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hr+JzZTf;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B97606A326
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 00:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19B97606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hr+JzZTf
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e9e53d011eso868845ad.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 16:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793752769; x=1794357569; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lQ2xOzxsF+CEtv2Z632brvuKrWBZQypDKsxmzWa1C5s=;
        b=hr+JzZTfML76aUBPRMSo/3TW8wG01zPPhuL/+lyor+y27KaG7K0wNq1h4XbItsLlae
         9aQFRKvZAF64WmcAU2FaEbMNIk3lag9vklnCV1nNbvazHFxJvS86TiagPTxFNZsiE0Xs
         vmuzGeSSudENZM5KFICQTPzdSCrbJ9JQ10LroE06YTO1PjeHV/Dey+drr3CWhXurH1oh
         /BkuNs0yz8eGrh5zbvxZUepb3LrXz0S3lsC414wKo84s+rmkO8uiO1APW2AtNOlMixgt
         ht6OtwB6e0WNLNDXQ1ZF55RHYIVaS/nYeFn69hB3sXqqBm+PAgLA4S4QokHq0OhiU7Ro
         6fUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793752769; x=1794357569;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lQ2xOzxsF+CEtv2Z632brvuKrWBZQypDKsxmzWa1C5s=;
        b=h19o4vw28P3i6/VyRs6DXi+3BYcJXZ0KerJdw+zSyIB7EY3ih61qHnRvA6zvIcerPV
         1bo1uGByMk8g55oi3T1a7dbtTWEK1bQEKB/xVef6JPwWhm7iYfANVwZu7m5V1BjtCd1V
         oWv2rzAtSTKM1GDAcEl9GvYmx2Tcb3bYyrH0L5oTifTVyVtsd4HkyHHs2T8FI6AqZM50
         PeMOhJwy/UDrUfJlFet/EXSc7IYKSLKcQhkBiI25kl+3xchVx1T6X6okjkxTd9FPXU0Q
         GGcH2ZasoSHv/nrrCK8V2QvMWpSOvgQnSkExxFePVDbTsO3qmE/lJmYJa/AEGhyKb5TU
         ZdHw==
X-Forwarded-Encrypted: i=1; AKwUvBw2jRiKo4S0Jdleqk4FIww6qjjEnwm0w6r0VseA2aVY4N7ZxhH5mnAd7yS7nJZnj2QGXiAaroA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/45uagcJJm9GrxcNvJrDRk+bs/ZnXRaqPHKNqL4NcBHCEaQaqs
	a6+itVhRrLMXrw8jY0e7G0gfory+bnNew/ZnW7Jo9H2rhIW48xc3NOCW
X-Gm-Gg: AYBFou3+p2aDGAGCsd+BHj9sXAw+1qxnAajXaZg6HeDuaMztvwz+kqWjIAYzLzmDsBV
	Sxe5L4segtUGdqZkUxY/odergc/IEZQHpbp0DGvMvKhw2hml9w2kEPxId4snvQWI2InuBDcMFY/
	O3XJqGfrLpw/SCoCOHXd5rOmRJopnIjoI26tBYtBwCNELMXI5B6LNcWRd47QRF3z2tYUmdoHeZA
	w4EgzFkN6lN7kENloqQy62o0bMXhqmPlViTCymDMrqPL8TvkeVCX5MqxYdWr6F2YGgr0eWGptk+
	sJLyGsMQrVKJCf9tjEGBxImweltMmb9aXzjln+/ujTzSwkFspiOC++mCw6gVNsjBByw+F8bOR7D
	NFXwf9WJZLPqCgifKaK2s7EIpCGD0S4SHIaAknkUlNJlVmpjU48KntUqZy9r6YSsnTojiCmmw/k
	xqk3EtyX+R2r4KfvZumzSqm+sxYwLJsmqvqqx05TAp/rDzGeOguF0fwYdqBRGRIDoaj2r/8CHwC
	w1WTGU8a87ryBB4JeKuVxxRWFn1lzKeiCrqCUr+YRVoSz6BdgjsigD/AAqrT0FUk3qNmMOquXGC
	QmJ3XDbeL3o9qnHDMqNksnM5/qEDI4wS1gtq9dYdsH2PnKHfNF2Ug6M4MYvqHmOiHHg1J2EDaTI
	Vzuy+WA6fnzTL4l/UnKtcwxb5+WSdZcpfuLUXkwpInR1cNiaOGi3uo9E=
X-Received: by 2002:a17:903:2306:b0:2e9:628d:e9c1 with SMTP id d9443c01a7336-2eb364b0c7emr143562815ad.26.1793752769163;
        Tue, 03 Nov 2026 16:39:29 -0800 (PST)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed090f7313sm510055ad.45.2026.11.03.16.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 16:39:28 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 00:39:27 +0000
Message-Id: <DMM0ADCEGAAB.2RFNF1ZI5TGWK@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Antonio Quartulli" <antonio@openvpn.net>, <netdev@vger.kernel.org>
Cc: <saeedm@nvidia.com>, <leon@kernel.org>, <tariqt@nvidia.com>,
 <mbloch@nvidia.com>, <dtatulea@nvidia.com>, <cratiu@nvidia.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@kernel.org>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <daniel@iogearbox.net>,
 <hawk@kernel.org>, <john.fastabend@gmail.com>, <sdf@fomichev.me>,
 <linux-rdma@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Antonio Quartulli" <antonio@mandelbit.com>
Subject: Re: [PATCH net-next] net/mlx5e: Prefetch packets of upcoming CQEs
 in the linear MPWQE path
In-Reply-To: <20261103235823.536706-1-antonio@openvpn.net>
References: <20261103235823.536706-1-antonio@openvpn.net>
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

On Tue, Nov 03, 2026 at 03:58 PM Antonio Quartulli <antonio@openvpn.net> wrote:
> While processing a CQE, look at the CQE MLX5E_RX_PREFETCH_DIST (4) entries
> ahead and, if it is completed, prefetch its packet headers, skb_shared_info
> and page. Also prefetch the CQE twice as far ahead.
>
> Looking ahead requires uncompressed CQEs, so this is enabled only for
> linear striding RQs without CQE compression.

can we prefetch 4 strides ahead without the CQE, like gve_rx() ?
In linear mode a packet takes one stride and HW fills the strides in order.
mlx5e_alloc_rx_mpwqe() allocates all pages of the WQE.
So mlx5e_skb_from_cqe_mpwrq_linear() can compute the address of the packet
4 strides ahead from head_offset and page_idx.

  per packet                 the patch     4 strides ahead
  -------------------------  ------------  ------------------
  CQE reads                  2             1
  dma_rmb()                  2             1
  mlx5e_get_mpw_info()       2             1
  headers, page              prefetch      prefetch
  skb_shared_info            prefetch      no, needs cqe_bcnt
  next CQEs                  prefetch      no
  first 4 strides of a WQE   prefetch      no
  stride is not filled yet   no prefetch   wasted prefetch
  CQE compression            not covered   covered

Then no need for MLX5E_RQ_STATE_PREFETCH_NEXT and mlx5_cqwq_get_cqe_ctr().

Something like this (not even compile tested):

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 22fea47..31d5bc4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2094,6 +2094,29 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	return skb;
 }

+#define MLX5E_RX_PREFETCH_DIST	4
+
+/* A packet takes one stride of a linear MPWQE. The address of the packet
+ * MLX5E_RX_PREFETCH_DIST strides ahead is known without its CQE.
+ */
+static void mlx5e_mpwrq_linear_prefetch(struct mlx5e_rq *rq,
+					struct mlx5e_mpw_info *wi,
+					u32 head_offset, u32 page_idx)
+{
+	struct mlx5e_frag_page *frag_page;
+
+	head_offset += MLX5E_RX_PREFETCH_DIST << rq->mpwqe.log_stride_sz;
+	page_idx += head_offset >> rq->mpwqe.page_shift;
+	if (page_idx >= rq->mpwqe.pages_per_wqe)
+		return;
+
+	head_offset &= BIT(rq->mpwqe.page_shift) - 1;
+	frag_page = &wi->alloc_units.frag_pages[page_idx];
+	prefetch(netmem_to_page(frag_page->netmem));
+	net_prefetch(netmem_address(frag_page->netmem) + head_offset +
+		     rq->buff.headroom);
+}
+
 static struct sk_buff *
 mlx5e_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 				struct mlx5_cqe64 *cqe, u16 cqe_bcnt, u32 head_offset,
@@ -2114,6 +2137,8 @@ mlx5e_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 		return NULL;
 	}

+	mlx5e_mpwrq_linear_prefetch(rq, wi, head_offset, page_idx);
+
 	va             = netmem_address(frag_page->netmem) + head_offset;
 	data           = va + rx_headroom;
 	frag_size      = MLX5_SKB_FRAG_SZ(rx_headroom + cqe_bcnt);

> - With XDP, skb_shared_info is not prefetched. XDP_DROP rate, low-rate
>   traffic and multiple queues were not measured.

Pls add XDP_DROP and XDP_TX numbers.
