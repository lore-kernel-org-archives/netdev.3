Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793195902;
	b=5swNq5LLDEhY0lnPp9fT5DvXj1uaJF144t89FGrPzbNU8CbxiV4YgIawRgP115UDPoza
	 e1gJHPC7YU0pdw7TT+aJqmAie1MQw1mBf1aUMMYYlj+3xXnF5Vm8/jEfpKAZyv+X28N+p
	 DQleT6M1AvZsXCp152h7KXsmjGuxdoRwH55W/ld3Ba6l7PN+majpK/GbsMyH9O6jv+GEx
	 GSFtqqaBOImP9P4NAro11f02LmgYgHbFAGLy6Hk7/gN7IJh9cHc9+FcBgM7Xs5DHICJHd
	 5Q12sFZdgSLUz4GbThPSfHyo3NoFPupKwIfpAYUIFCLLIzbkUOtCvPjrCoUK8yR6yuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793195902;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=v3fyVv4Ya76C7r2Vq1iLeoNaMysX8bvNUTglnpUyUfc=;
	b=ib0qIYtwJgeBmqb2JrMKD2cb7kTUtOeUT9zrhD5PKs4vRaq9BEEaRDLL94x6LXExzM+3
	 EbfHWc0TwyW8wSIUrNbn84cqmmvCQLrF3GOR2eNTUiQtSZ8h7h170IEi4fdxEKXtNGo9l
	 t9aZA3aR1orhalzkJV4AA6b5aXnju9a11zSiPVOytxGMG9I/QdBfR+9GRwDzL6unvcfKx
	 Ez0+L1cNX6/7cHLuXVe7aRwf/Ny5UVYxcueJsIQ5+B3DlrsZI7Q/JdC3LDuAOE8o05p2/
	 wZJzglZOjO9u+d88Jjdfcxo0gyoXDqGwW/bpE/p5Tc81/qz3vHikFtSgShyAAbtbHVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mZ7sbCDZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0BF606A31A;
	Wed, 28 Oct 2026 13:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mZ7sbCDZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6B31F01825;
	Wed, 28 Oct 2026 13:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793195902;
	bh=v3fyVv4Ya76C7r2Vq1iLeoNaMysX8bvNUTglnpUyUfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mZ7sbCDZb88DnfoD/8kYWLSOFGUJqIQxVCfFqUQnFCrlARcxAJQgRI8HJMV0K0NTc
	 V65P4GbGvBfUkM+hFFnkNItkY1jTAgqL2HeeMMmrnU2npeESsl2MBBvfHcMHFY/j3B
	 qgPL+q0/aYb5eFaGxtU1l6qlGiYw8xsJWLwFztzCmEd+SQ4jogJaeTiELqErYwPX8T
	 ri3wlVjNeMIeG+tyFBPnfngjQkY6GkMfcXQy7xV28IW8DxFgRjmXPOuweNAUFl3/3r
	 +apE4BRgWkgnYdaFM85sMqp8J4d3mFJb2BUwZHJcTAfv91yx9I52ivcdkmDSFwq+xF
	 dW8WQE7thCN3Q==
Date: Wed, 28 Oct 2026 13:58:17 +0000
From: Simon Horman <horms@kernel.org>
To: Vikas Gupta <vikas.gupta@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bhargava.marreddy@broadcom.com,
	rahul-rg.gupta@broadcom.com, vsrama-krishna.nemani@broadcom.com,
	rajashekar.hudumula@broadcom.com, dharmender.garg@broadcom.com,
	ajit.khaparde@broadcom.com
Subject: Re: [PATCH net v3 2/2] bnge: fix RSS table sizing for large RX ring
 counts
Message-ID: <20261028135817.GU257209@horms.kernel.org>
References: <20261026092757.9168-1-vikas.gupta@broadcom.com>
 <20261026092757.9168-3-vikas.gupta@broadcom.com>
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
In-Reply-To: <20261026092757.9168-3-vikas.gupta@broadcom.com>

On Mon, Oct 26, 2026 at 02:57:57PM +0530, Vikas Gupta wrote:
> From: Dharmender Garg <dharmender.garg@broadcom.com>
> 
> bnge_adjust_pow_two() adds one block before rounding up to a power of
> two only when the quotient is 0 or 1. A larger quotient that is
> already a power of two is returned unchanged, so 129-192 RX rings
> get a 128-entry RSS indirection table and 257-320 rings a 256-entry
> one. The rings above the table size never receive default RSS traffic.
> bnxt_calc_nr_ring_pages() always adds one, which is correct.
> 
> Make bnge_adjust_pow_two() always add one block before rounding up.
> 
> bnge_adjust_pow_two() also sizes the RX, RX aggregation, TX and
> completion ring pages. For the default 511-entry rings their page
> counts do not change. The completion ring is sized from more than
> the default depth, so its page count changes where the old code
> dropped a partial page. With 8K ring pages, TPA off and the default
> rings, its budget is 1533 entries and the page count goes from 2 to 4.
> With 4K ring pages and TPA on, when the firmware reports a
> max_aggs_supported of 260 to 387, it goes from 16 to 32.
> In these cases the old completion ring held fewer entries than
> its budget.
> 
> Fixes: 627c67f038d2 ("bng_en: Add resource management support")
> Signed-off-by: Dharmender Garg <dharmender.garg@broadcom.com>
> Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>

