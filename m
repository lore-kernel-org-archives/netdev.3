Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793888866;
	b=A03x0v2ya40lTb+KKYff/jmctFUjsiy1dfMOzgG1epsDsiQJrRzpMC+Rp55uI7TRPIbr
	 W92LfkWmfvnwiRuxfm9Yis5h7NQo0FZptESSLui51Mis5Agjv/llUVxsgmvMo55s1g0/S
	 ZT2rklRgXklmkEO1E+TO3+ra7y6W2hFb7YBgCutlnksutnIbJV5AJCSqnGuSbHKgXZ5pq
	 j1HTKNaVMfPXWcdiseKhAGB4g8cYRcKhAnMTdwjDgbBatoIPnWnO4W98WjDBm+r6Zoxtw
	 BoZVgJAEqMlw9Nn8Y/BuiLAx1q1s8VNnaxERjQegGEKwquPZHeB98f6BthzsavmJE0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888866;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=rYHcTddsMGFJxoooXt9bGT/cprdRwsLwfNyq5sklZCs=;
	b=b4POG9yel+IWuUVkQxhW7V4POdri/m0Md5jYsoeSJ8bHh/ssYKBzotxqbe3KNi0iCnaB
	 yw5RyGkNn1HKSMiK5DWkaKNLdhIS/sqUFRIEH0tzpRZNP+k5JC7UQd3BnQ1JrWcCcxi3D
	 EQi1LQ8C7bU9vUDgmoxfNOiDOhwT3Pj9DHhVGWTlgUu7EhFOeILdeSRbDo4mnjTKg/f9C
	 wyCZjww2DQyQL+jj/LRCU6Tu/pqK8ZuxTh3SfRmQdNUuW1gkl+R0ivWJX1HrqPDtywxo+
	 K3V9HJUnH1nnVfNLcY8QkcUuVNZjSoo/2Xl7jjgo4SaCsyNotksr8DWmh+xQtQkA7ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rk5o+f1O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66EA606A32E;
	Thu,  5 Nov 2026 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rk5o+f1O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305201F000C1;
	Thu,  5 Nov 2026 14:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793888865;
	bh=rYHcTddsMGFJxoooXt9bGT/cprdRwsLwfNyq5sklZCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Rk5o+f1O6peQxQ9MqrF1F0MAgBXS1+MgHM1NL5rXIJ26rX2a7K/cTEaoepPELDyrj
	 eqj6eQtTFCOr6fANT/YDv7PBY8qUn+sqP87GUD6Xa73W4qRHUy4vbGr0Ltycf8T8jg
	 vEsW3D83z0t7XuVMbr/tGJ1QgCBxjDRSaCzNFZzs9CYyvmZBAk8BarpROmU+k1U1bs
	 4xxI3zTbSNdX1BNJMAq2u0FF8p8pDQDkDo0kHZnAcoZBUs8F0u4eirZmnzteFm0Rr2
	 lchBU6uFjD3odeJIkkNYZt3sUGSuaX479mgI4BRJt+YqJ1++38R9a9SHY4wIp8B2OP
	 XiMELJIEKt/zw==
Date: Thu, 5 Nov 2026 14:27:42 +0000
From: Simon Horman <horms@kernel.org>
To: Sandeep Haemoon <sandeeph@loljews.com>
Cc: netdev@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: ethernet: mtk_eth_soc: skip page_pool
 for
Message-ID: <20261105142742.GU865646@horms.kernel.org>
References: <patch-4f863a941889f0bceca1c082f2d79624@loljews.com>
 <patch-f1b04513b0fe3fb0a35ac744799fb0f3@loljews.com>
 <patch-fdfc120d5c46c3e5d484cbff30f63316@loljews.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <patch-fdfc120d5c46c3e5d484cbff30f63316@loljews.com>

On Mon, Nov 02, 2026 at 12:48:46AM +0200, Sandeep Haemoon wrote:
> page_pool allocates order-0 pages and the pool is created with
> MTK_PP_MAX_BUF_SIZE.  Rings that need larger buffers (9K jumbo or the
> HW-LRO rings) cannot use it.  Only create/use a page_pool when
> ring->frag_size fits in a page; the large-buffer path already uses
> mtk_max_buf_alloc().
> 
> This is required by the 9K support in the previous patch; the
> large-buffer path it relies on comes from the MediaTek downstream
> series.
> 
> Link: https://github.com/mediatek/mtk-openwrt-feeds
> Signed-off-by: Sandeep Haemoon <sandeeph@loljews.com>

It may not be particularly important, but I do wonder
if the order of the patches in this patch-set should
be reversed: as it is 9k support seems to be added by 1/2
and fixed in 2/2.

That notwithstanding:

Reviewed-by: Simon Horman <horms@kernel.org>

