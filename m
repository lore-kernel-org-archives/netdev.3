Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04142DF717
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781279376; cv=none; b=ItoewKIwx44PW/AUGv+3Gn0qDpl5fD4JJ3bumjmOSeocwU4XKXInqlpQcZdBv2W45tmenFNt+vokCCUuGZn3bG3NuwsobBdjpKx6351+zRB/Op5iP78Rt/l5nfQlw67sBcT3ISurw7eO0ZvqDxkiffgodvRuwjfLt35+l9Jx5H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781279376; c=relaxed/simple;
	bh=0zkb4ClCsld0pfT11iCPSPp5oKltSYYwZ4Yf2LWDIXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSFeVvMFL250N7JBQc7Be6miGQkLLglIFfagT+iT8auv/THV2i3l+As1mm2azcOtEQtf1edUPYOQT5izq7HxIKtqaz8p+4WSX+cIdq0mkFprb13YYj2EjwIvZdArFOi7e4FLfSLMlHPg5NqMBc9zVrC+7QJYPY13lpCYEtnXa5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hi58u3zD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hi58u3zD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59791F000E9;
	Fri, 12 Jun 2026 15:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781279375;
	bh=mBFAIu47flLDK4Vql3yeYdXEId80+kr8GAJ+CYap1r4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hi58u3zDzfGv3MTQ14CW//u7RaSynOwpwQAkgkkvgazUHD1EeA0ZpElRGgp6AeLPs
	 +a1kHM4Jr3cAfh05d6fuNYqFyq8iZIvzIzM/qnWbyPGodHBTrHUYeh4tcC8DmYA5Ka
	 4HRe8n5PP+woG82Cl/A0rBRvR1TLLGxH9u+aIcC55GKo8+byA/wG2Z5cEnOeRaU6vx
	 Cu3d1AlQnFqZkqkFc2LidJIKEvwx/ERIiIt9bDESWxacFy/attJgRM2XFRfYtfZhgd
	 aS1AvdUhga2awDZoux3KGn1mlUNR+MZy+wNDpk0igZJXjDZIyIAVoyFOecmJxm4NZX
	 4ulcXjl4sCnYA==
Date: Fri, 12 Jun 2026 16:49:29 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>, Joe Damato <joe@dama.to>,
	Breno Leitao <leitao@debian.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH net-next v6 4/5] net: wangxun: implement soft quiesce for
 PCIe error recovery
Message-ID: <20260612154929.GD671640@horms.kernel.org>
References: <20260610060917.23980-1-jiawenwu@trustnetic.com>
 <20260610060917.23980-5-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610060917.23980-5-jiawenwu@trustnetic.com>

On Wed, Jun 10, 2026 at 02:09:16PM +0800, Jiawen Wu wrote:
> Function wx_soft_quiesce() provide a lightweight shutdown path during
> PCIe error recovery. It avoids MMIO-dependent operations in PCIe error
> status.
> 
> Waiting for the service task to complete may unnecessarily delay PCIe
> error recovery, especially if the work item is already blocked by the
> hardware failure that triggered AER. So the service task is not
> explicitly cancelled in quiesce path. As a measure to block the service
> task, the checking of WX_STATE_DOWN and WX_STATE_RESETTING is added at
> the entry of every work item.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

...

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> index 44f3e6505246..dcc8b3ae1445 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> @@ -842,6 +842,27 @@ void wx_ptp_stop(struct wx *wx)
>  }
>  EXPORT_SYMBOL(wx_ptp_stop);
>  
> +void wx_ptp_quiesce(struct wx *wx)
> +{
> +	if (!test_and_clear_bit(WX_STATE_PTP_RUNNING, wx->state))
> +		return;
> +
> +	clear_bit(WX_FLAG_PTP_PPS_ENABLED, wx->flags);
> +
> +	if (wx->ptp_tx_skb) {
> +		dev_kfree_skb_any(wx->ptp_tx_skb);
> +		wx->ptp_tx_skb = NULL;
> +	}

AI-generated review of this patch on sashiko.dev flags a potential UAF here:

	"Could freeing wx->ptp_tx_skb here cause a use-after-free or
	double-free?

	"Because ptp_clock_unregister() is called after this block, the PTP
	 kworker might still be running.

	"If wx_ptp_tx_hwtstamp() reads wx->ptp_tx_skb just before this
	 free, it will pass the freed skb to skb_tstamp_tx() and call
	 dev_kfree_skb_any() on it again.

I'd appreciate it if you could look into that.

I believe that the other issues raised in that AI-generated review have
already been discussed in the context of earlier versions of this
patch-set.

> +	clear_bit_unlock(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
> +
> +	if (wx->ptp_clock) {
> +		ptp_clock_unregister(wx->ptp_clock);
> +		wx->ptp_clock = NULL;
> +		dev_info(&wx->pdev->dev, "removed PHC on %s\n", wx->netdev->name);
> +	}
> +}

...
