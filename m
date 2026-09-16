Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC964AF69F
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 09:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552222; cv=none; b=kuYJ+K+TNBbmxH3iz394v2v8bGwODRHozDgRc8aEG6qILj4OnevgunwDmeJ1gTifUE0q1gabWwb8HlQRD9UrDcaq7ota906hp/jxbS89aHlUcg6VYFuEydBhry4iR+yKZ0/w6Jv/gfUI8YZu1GBn8IZvf7Kjje0yLCIrsPa+Q18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552222; c=relaxed/simple;
	bh=eu8f5FCnTca0TkLoILu6E1Ex79RV51c9eJ7Z0fo+MHM=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=EcqdEphv5VXW1KAwzkjnKChLZArMGm4Oa0o6PB5hgMEL13oKhhsUueimiP6rZa9wYk65aQYxX/qyDJziUQTcyvXPq1gToUZwf7LGSZdMN3+YHBjb6Uy/g/zAVNu7aZ9DYeZOUl5IPsdFLSqemvp9ezJxZ150alpvqNp930nVLJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:tivesync1t1789552124t1cc6fdad
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [122.233.172.177])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 1009071293264724054
To: <netdev@vger.kernel.org>
Cc: "'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Jacob Keller'" <jacob.e.keller@intel.com>,
	"'Kees Cook'" <kees@kernel.org>,
	"'Aleksandr Loktionov'" <aleksandr.loktionov@intel.com>,
	=?UTF-8?Q?'Uwe_Kleine-K=C3=B6nig_=28The_Capable_H?=
	=?UTF-8?Q?ub=29'?= <u.kleine-koenig@baylibre.com>,
	"'Rongguang Wei'" <weirongguang@kylinos.cn>,
	"'Chenguang Zhao'" <zhaochenguang@kylinos.cn>
References: <E5215E3514E295BA+20260916063312.203457-1-jiawenwu@trustnetic.com>
In-Reply-To: <E5215E3514E295BA+20260916063312.203457-1-jiawenwu@trustnetic.com>
Subject: RE: [PATCH net-next v3] net: wangxun: use cached NCSI and WOL capability flags
Date: Wed, 16 Sep 2026 17:48:43 +0800
Message-ID: <02bc01dd45c0$8f532090$adf961b0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQGZo/KSQRPqL0GSVyv0tGsJ3RH597dYN/6Q
X-QQ-SENDSIZE: 520
Feedback-ID: tivesync:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MHO0m1kA5sGIk6qU9yqz8Erp4sC/7fsbpNNc4NAkRbkXG3r4OOwMSo7K
	qmdtWZcplc1FaUlGX+BWEjcjZmnaXwOspNPdWET8HX7jZGnRHxF/8hPsbZHPXFyVDwmQutE
	ayO++soddGPoQfi1ECdo+2MSwSOBeoPLkuVcxuxvCxLm0V/pKolKyhOnCCnircNnUqvyoEA
	02qLK9P/gEgqtBhyEuvPbLDVBURYSeNJBOhRqSJmL2td7M0ueJTsMHaAuyVJsj3erukf+cn
	PJtkrt2fthFfSOIc8xV256en33sDnjo75uOTuIX1EmwFKTBL73kjQ8OUrfO8FW4JeF4FMjj
	A/LW88vE2bSgTzflboWgg1UMWse4m10YUVuKbQnwNMhQdpzG2m5mwXOctLsBhquvX+y3Gjz
	mxPQ1UAlRBm+6b7WVyUjfIW75suj7sB3jk7YPpzq+VR+ti6I4eVKga7dpyMkca7rUFp5zGb
	WyH15iX75dc/BU0vfG/rSU9WLA5uidSUqPiGIzCqOw2LIkWBGlhLa5OQgS59PA+aK/DFUUr
	eXUkN6XEVSN9yr+iAuAk5TEwwbtsO0uTrumWPMMcD8wMkHJKbd5eyFBZzFSIw/H1fUkcCWM
	Vkg3ubKmGjA0M4YhG3tq3Z41BSq2aVNsCBdrIvBq8uLmU/c5cu3IpRBZ3zcFgulcCvxtq8R
	xXUJkpyE1skriQsBLNfGU6MdeIYoXIjUVevmMVlKHF5KFTlCO6rQMblaX9U7CrZM4OVbQy8
	RXRU3CzEAHantzS5IARkq0mTyhxw3tG4G5gyOD5b1cj7M2IYdjZrXfw+/pxhMEA22Limi+d
	1V6M097n/zIaVpqprJ1V5jyO5ThNY+ddP0IbsCyM5VnNZ3uR0aE9iK0DhqG4+iRWpDlCwHZ
	coL+41JK9sv6cUbowN6fJNNSDitOdx53juTbvoLPSvcPl9+rHraeffHd9+5+dmJuzzL91+o
	tv/uTors692CeO25TpQoVBqRw/6V3xukQpHM84cr6AxYTiuLaQ3ETcffpuFFd4XZi29B84S
	rFZVqGDGUrayMef7KIK6NUorfbVmibb9Voe+tW1bDqyDfKF7SQfoO6p7z4pMTw/zS/RB9Wr
	bdHIKI/AvHOZ6qNWFdijR2OXnfE+tolFsOs3vDKnLzn5i6Cy0k6yH8Nr+yYEmu0So+SQYe3
	kKl9fGj4WyjY94gscJMT9G38Eg==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

On Wed, Sep 16, 2026 2:33 PM, Jiawen Wu wrote:
> wx_disable_rx() and txgbe_disable_device() open-code the same subsystem
> device ID tests to decide whether the MAC receiver and transmitter have
> to stay enabled for out-of-band management:
> 
> 	(subsystem_device_id & WX_NCSI_MASK) == WX_NCSI_SUP ||
> 	(subsystem_device_id & WX_WOL_MASK) == WX_WOL_SUP
> 
> ngbe_init_type_code() already decodes the subsystem device ID into
> wx->ncsi_enabled and wx->wol_hw_supported. Do the same in
> txgbe_init_type_code() and let both call sites test the cached flags, so
> that each driver decides the capability once while probing instead of
> having shared code re-derive it from raw IDs.
> 
> This is not equivalent for ngbe, and that is intentional.
> wx->ncsi_enabled has never been read since it was added by commit
> 02338c484ab6 ("net: ngbe: Initialize sw info and register netdev"), and
> it is wider than the inline test:
> 
> 	wx->ncsi_enabled = (ncsi_mask == WX_NCSI_SUP ||
> 			   type_mask == NGBE_SUBID_OCP_CARD) ? 1 : 0;
> 
> OCP mezzanine cards are NCSI capable by design, so the NCSI semantics do
> apply to them, and they need the MAC receiver to keep running for
> out-of-band management. The inline test does not cover the OCP card
> type, so on such a card that does not have the NCSI bit set the receiver
> was turned off on every path reaching wx_disable_rx(), i.e.
> ngbe_disable_device() on ifdown, wx_stop_adapter() from ngbe_reset_hw()
> and wx_configure_rx(), and management traffic was dropped. Reading
> ncsi_enabled keeps the receiver enabled on these cards.
> 
> No Fixes: tag is added on purpose. The broken behaviour goes back to the
> initial ngbe support in v6.2, and wx_disable_rx() has since been moved
> into libwx and reworked several times, so this does not cherry-pick into
> stable kernels in any useful form.
> 
> For txgbe both flags are newly initialized, but wol_hw_supported is only
> consumed by txgbe_disable_device() there - txgbe does not implement the
> WoL ethtool ops - so txgbe behaviour is unchanged.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

This patch should be deferred.
Another conflicting fix needs to be committed first.

> ---
> v3:
> - Rewritting commit message.
> 
> v2: https://lore.kernel.org/all/F76F75E3FFF42A39+20260908025416.42250-1-jiawenwu@trustnetic.com
> - Remove single-use locals.
> - Describe the behavior change on ngbe OCP cards.
> 
> v1: https://lore.kernel.org/all/95D34449BA183C54+20260901070238.78509-1-jiawenwu@trustnetic.com
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_hw.c      | 3 +--
>  drivers/net/ethernet/wangxun/txgbe/txgbe_main.c | 6 ++++--
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> index 111aadf79208..2490c4dd548f 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> @@ -1313,8 +1313,7 @@ void wx_disable_rx(struct wx *wx)
>  		rxctrl &= ~WX_RDB_PB_CTL_RXEN;
>  		wr32(wx, WX_RDB_PB_CTL, rxctrl);
> 
> -		if (!(((wx->subsystem_device_id & WX_NCSI_MASK) == WX_NCSI_SUP) ||
> -		      ((wx->subsystem_device_id & WX_WOL_MASK) == WX_WOL_SUP))) {
> +		if (!(wx->ncsi_enabled || wx->wol_hw_supported)) {
>  			/* disable mac receiver */
>  			wr32m(wx, WX_MAC_RX_CFG,
>  			      WX_MAC_RX_CFG_RE, 0);
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> index eb91c4f28ecd..0ecbd1c0e553 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> @@ -267,8 +267,7 @@ static void txgbe_disable_device(struct wx *wx)
>  		wx_set_all_vfs(wx);
>  	}
> 
> -	if (!(((wx->subsystem_device_id & WX_NCSI_MASK) == WX_NCSI_SUP) ||
> -	      ((wx->subsystem_device_id & WX_WOL_MASK) == WX_WOL_SUP))) {
> +	if (!(wx->ncsi_enabled || wx->wol_hw_supported)) {
>  		/* disable mac transmiter */
>  		wr32m(wx, WX_MAC_TX_CFG, WX_MAC_TX_CFG_TE, 0);
>  	}
> @@ -381,6 +380,9 @@ static void txgbe_init_type_code(struct wx *wx)
>  		wx->media_type = wx_media_unknown;
>  		break;
>  	}
> +
> +	wx->wol_hw_supported = ((wx->subsystem_device_id & WX_WOL_MASK) == WX_WOL_SUP);
> +	wx->ncsi_enabled = ((wx->subsystem_device_id & WX_NCSI_MASK) == WX_NCSI_SUP);
>  }
> 
>  /**
> --
> 2.51.0
> 

