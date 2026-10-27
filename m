Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793060223;
	b=bRfVw+irBIhpP4Hf8xLxRSbWOHngz9i88EkGrfjr0A79EOqU46vWXXZmepntQUpASfzd
	 Ejo0B6fX1KoMbjw9mWKHtzBbVzjJ4St2jeOengyawbP/Zo9Wemn6QW2/biucGKsM0Scw3
	 YWcWh4/urqM7zM+HN503XGyt0Dwgeq2HNE61TwCzkAWsCSiV9H816Odi4PomgRqr6HuJv
	 CPW0ieigX2dRecODuTPHu/I/8zItPG6dZ3s8msZPw24eQMApz01yPC3LR0l882dMIbyyB
	 KRw41m7uOPH+AXiI6JQQpZOLV2Yw/YYfYm5yT4NKLL4ASwCQCHwW1Z6FwL6m+mEA7wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793060223;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=X2buSjv8QkJzoYlyrpxwJTJC8kX1yUTRak0G8sS956g=;
	b=mmpj8IrkcaDY9N76QF4zic4RK3/ZPLkhdLEc6SHdP7UGYMFYVCidTg7M8HVtdG95N3k9
	 rmDAuyYpOF3W6Ru15xfGN4BYkZIxqN4n3IYQQystYzDq2BKu3NaJ759KhJyDQ6Pq2uJuM
	 YMQgpGpkuHAz7LSubuxZS/bEI1EHoljOa3YyJOT/ovHWsfYYO5VyRDR7hrV7W6NroFv6z
	 EoND5NG/0/eOcp1/G6I1gnuAo1L8GiOo9WxJVzvph7Wqx+bxHLca+p9Qn/RipcGphVInM
	 /PoG0ZT9zTr9Vh5ZRKCxBux4aISG8djCloDWFF+cMp/gketGeskJA/iyUd6eq1Bxj0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GfRHQhWF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CB4606A31A;
	Tue, 27 Oct 2026 00:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GfRHQhWF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A291F01825;
	Tue, 27 Oct 2026 00:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793060221;
	bh=X2buSjv8QkJzoYlyrpxwJTJC8kX1yUTRak0G8sS956g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GfRHQhWFkk40mOnqV0ZHgWI6xnJc0wKJVNuiSwLZ0/VdQptThZAm3s611gNBV2AgL
	 Qg0ypTXikwBriNsdwH49+/ujj61JjZAwHOEgLrtCdr5Z30Gzsy6GXrKF/Tp8tDPBsN
	 GWVOBM1YhNf+133bfEpKySml0bcj7V04HDFCh+1ZR0SpdwsypEfev58AHKJmhW/ehQ
	 qgvazQ5nU+nOV3xttlro4pwyE6VVXWclWnK7gsd3xc8Ilnu/nQhjBrHUPTzgFQ/syt
	 m1TGcMWksg3U3RsnCxU+DkNmAVRLCPsnl6d6SI9NEgSOezADiH62Ge38kj4UTYdIuf
	 ZeXpBaK2gzcSg==
Date: Mon, 26 Oct 2026 17:17:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Frank.sae" <frank.sae@motor-comm.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 pabeni@redhat.com, edumazet@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lingyu.zou@motor-comm.com, xiaoyong.li@motor-comm.com,
 jie.han@motor-comm.com
Subject: Re: [PATCH net-next v?] [PATCH net-next] net: phy: motorcomm: add
 YT8831 2.5G PHY support
Message-ID: <20261026171700.06ce6543@kernel.org>
In-Reply-To: <20261022054642.1332801-1-frank.sae@motor-comm.com>
References: <20261022054642.1332801-1-frank.sae@motor-comm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Oct 2026 05:46:42 +0000 Frank.sae wrote:
> Add a driver for motorcomm yt8831/yt8821-vd ethernet phy.
> Verified the driver in BPI-R3(with MTK Filogic-830 Soc)development board
> YT8831 works in AUTO_BX2500_SGMII or FORCE_BX2500 interface,
> supports 2.5G/1000M/100M/10M speeds, and wol(magic package)

## Form letter - net-next-closed

The merge window for Linux v7.4 has begun, and the net-next
tree is now closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens. There is some uncertainty
about how long this merge window will last, so please check
https://netdev.bots.linux.dev/net-next.html
before reposting. net-next _may_ reopen on Nov 2nd.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

> +/**
> + * yt8831_set_wol() - turn wake-on-lan on or off
> + * @phydev: a pointer to a &struct phy_device
> + * @wol: a pointer to a &struct ethtool_wolinfo
> + *
> + * NOTE: YT8831_WOL_CONFIG_REG is common ext reg.
> + */
> +static int yt8831_set_wol(struct phy_device *phydev,
> +			  struct ethtool_wolinfo *wol)

Please run scripts/kernel-doc -Wall on this, the return
value must be documented in newly added kdoc.
-- 
pw-bot: defer
pv-bot: closed
