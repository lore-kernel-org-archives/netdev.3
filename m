Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78D7377575;
	Mon, 24 Aug 2026 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787594394; cv=none; b=ApMtIXV4CYMtbT6BAooPuIeZIx5JB6rzJbdIHq8So8efQaHUiEhpfcb7GPQ0T+5tribTcNJYsaALfm3Pqw09C290/97JEUJnhS8Ty8bNUmJd7btoy7Lh2/bV3rUqRxeDin+N+S5wFxrUosau9EBbaBfobHvnOWE7PqUDTyTVpB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787594394; c=relaxed/simple;
	bh=d5ihp/bxSPCVxyeDTSdgnB6LttFP7P6DhZLQ67DjDY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atYVFO4DhZJEzrkdW9hnxcUYYogvh0fP1tuUIQqxvLB9hdy1QEg9Ve1dLmjNlMTtGs4Mj3NnjZ+mkXv/JlcB3sf+aWl1SrYUty4lffiBN9H7aiR6dfdFT9VHyH8OdlYAv6GiF0hmS3tELQuBKt5bhuZVJqldV405QeXkGflRRyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1Q/mqR9u; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1Q/mqR9u"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FcPD9clUGhAh17Nhf3ipyfsSy9gotcTKfJyfZTLUReo=; b=1Q/mqR9uoAlE+YcCUJKPGjS10a
	1VEQMkFJiUVJnt9UW9yK430RUyaJl7PVKm05yOG0XN90LE6uzwrBWfXqYDALViHD0YBRS3zX/zGfp
	CeskfIdzrq+lW6FavrhJlRPl2wG+cpgUGCVA2PkdeCqwM0jiMeu0Ckg3n4S74UIxqiAM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wyYxO-001Hit-Cw; Mon, 24 Aug 2026 19:59:38 +0200
Date: Mon, 24 Aug 2026 19:59:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: han.junyang@zte.com.cn
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	ran.ming@zte.com.cn, han.chengfei@zte.com.cn,
	zhang.yanze@zte.com.cn
Subject: Re: [PATCH net-next v1 1/3] dinghai: add firmware version check and?
 RISC-V readiness polling
Message-ID: <aa56dcc9-0637-493e-8cbd-cb8f0426c811@lunn.ch>
References: <20260824033249934VsArgTPOU_qew94PPABbD@zte.com.cn>
 <20260824033538020rXU4GiMrh05w37DWs5k7v@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824033538020rXU4GiMrh05w37DWs5k7v@zte.com.cn>

> +	struct zxdh_fw_compat *fw_compat;

> +	/* Firmware predating the compatibility region keeps the erased
> +	 * pattern, which fails the module id check below and defers the
> +	 * decision to the readiness wait.
> +	 */
> +	ioread32_rep(compat_base, fw_compat, sizeof(*fw_compat) / 4);

> +/* Firmware version compatibility block at ZXDH_FW_COMPAT_OFFSET.
> + * Copied out with ioread32_rep(), which converts from little-endian.
> + */
> +struct zxdh_fw_compat {
> +	u8 module_id;
> +	u8 major;
> +	s8 fw_minor;
> +	u8 drv_minor;
> +	u16 patch;
> +	u16 rsv;

What are the endinness of these two u16? Should they be marked as
little endian?

> +} __packed;
> +
> +/* Health buffer at ZXDH_RISCV_HB_OFFSET, maintained by the RISC-V
> + * management core of the firmware. Fields are read through ioread*().
> + */
> +struct zxdh_health_buffer {
> +	u32 synd;		/* Bitmask of active syndrome flags. */
> +	u32 health_counter;	/* Incremented heartbeat counter. */

Same question here.

     Andrew
