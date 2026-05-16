Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ACF21256C
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 01:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778893666; cv=none; b=AmfCoFrO53N1nVKqn6FSxw1Osa3oOVZ+AjP8ZUoR7+9xClDEs9MaJvuRAvBd26TYIYHOPkELBKloJu/wrNjl8yf/sBHFL5q3T8QPSWG+zbugnDipv3s6wftpkqyZ9df9Vqt/ZPeJijsYpPIXS8Dz4zVOPYEawCzds6HJQqwUQ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778893666; c=relaxed/simple;
	bh=ld/JSCqYFVN3s44m1b3MilskWc11mxCYOBq+McqeK24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ry1WFOBAgQXYPRzf/rX15dXVB6U1VHRGpo7IZjKsVc+Y1ZrVzuwFFQ4ao9q4NjIJwmWxM+OnYGN1+qa5IBDk6GsY6MHtx6RtruleEsWi8NLTJWk8tRXJEbYennDI8SGZcW0u6Fh7XW9rEZprZyf80g7c/eWr8gg5UAFQK1QbABE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIMV+Hot; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIMV+Hot"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFFCC2BCB0;
	Sat, 16 May 2026 01:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778893665;
	bh=ld/JSCqYFVN3s44m1b3MilskWc11mxCYOBq+McqeK24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DIMV+HotyqUdLM6e0U3C6KiheG9PhjNv2Z8RfyrC9U7jAfLywrSzM45Id4Ei/uGGr
	 697li0DRptnBJkxTSJcw3KcfYvI57ZdgGltXKNL8jOBmybXc86QlXuqoeV55nOaCeV
	 lYqx5aAh9WG2DYDAfFM93MWv7bd5m0PJapOsdSoB7xLakH2BP0l0Bkb0CDQu49FOEW
	 46e7r9zg3SM2Cpl9vKRIe9Oe1zdkFOygF6HNsE5XXNnbPcmWwIKqCu7hIjKc/BF7BZ
	 tJfps6KUCUg1YjdDKXqikPkUnIPeGXyJ3zkAM/RocTXzYnPKfURgBRDIoEpTLTFiVZ
	 Wr8Fe+hsz2wXA==
From: Jakub Kicinski <kuba@kernel.org>
To: mengyuanlou@net-swift.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com
Subject: Re: [PATCH net-next 1/3] net: libwx: add support for set_ringparam in wx_ethtool_ops_vf
Date: Fri, 15 May 2026 18:07:43 -0700
Message-ID: <20260516010743.1855097-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514103405.42175-2-mengyuanlou@net-swift.com>
References: <20260514103405.42175-2-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: libwx: add support for set_ringparam in wx_ethtool_ops_vf

This commit adds support for the set_ringparam callback in wx_ethtool_ops_vf,
allowing the ring sizes for ngbevf and txgbevf to be configured.

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> index 5df971aca9e35..31034cd208703 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c

[ ... ]

> @@ -775,6 +776,64 @@ static int wx_get_link_ksettings_vf(struct net_device *netdev,
>  	return 0;
>  }
>  
> +static int wx_set_ringparam_vf(struct net_device *netdev,
> +			       struct ethtool_ringparam *ring,
> +			       struct kernel_ethtool_ringparam *kernel_ring,
> +			       struct netlink_ext_ack *extack)
> +{

[ ... ]

> +	wxvf_down(wx);
> +	wx_free_irq(wx);
> +
> +	wx_set_ring(wx, new_tx_count, new_rx_count, temp_ring);

wx_set_ring() returns void, so memory allocation failures inside it (like in
wx_setup_tx_resources()) are not passed back to the caller. Does this mean
wx_set_ringparam_vf() will falsely return success (0) to userspace even if
the ring sizes could not be changed due to memory exhaustion?

> +	kvfree(temp_ring);
> +
> +	wx_configure_vf(wx);
> +	wx_request_msix_irqs_vf(wx);

Is it safe to ignore the return value of wx_request_msix_irqs_vf() here?

If request_irq() fails, wx_request_msix_irqs_vf() cleans up and sets
wx->msix_q_entries to null. Because the error is not handled here, execution
continues to wxvf_up_complete(), which starts NAPI and the transmit queues
without hardware interrupts. Could this result in a silent network stall?

Additionally, if the interface is later brought up via wxvf_open(), it will
call wx_request_msix_irqs_vf() again. This loop calculates
entry = &wx->msix_q_entries[vector] and dereferences entry->vector. Could
this cause a null pointer dereference if wx->msix_q_entries was previously
freed and left as null?

> +	wxvf_up_complete(wx);
> +
> +clear_reset:
> +	clear_bit(WX_STATE_RESETTING, wx->state);
> +	mutex_unlock(&wx->reset_lock);
> +	return err;
> +}
-- 
pw-bot: cr
