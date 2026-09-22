Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B60A3E0226
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 19:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790103727; cv=none; b=hs9+87mTc1uia8tlY/VrBDqqLn4E9Hh3g0N0JbHtK7EghClhhV+JOLPtbUpo3kpry/HO2WwaPnC+qLpNXaZ8Yepx1lNmd8J341pXZfwBrCQDzXB3Yv3YQjfnugWW6yss0EojxiI9J0adKRmXkAHlGm3OAIBOEf7m/HUpZW8uw+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790103727; c=relaxed/simple;
	bh=IiMRz9fb9xrWmmW+xd/fQ4MVyvGH71H+eJO3EwdAq6w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=h8xLnM0HSr9c5zUNYjBJqGD2J0Knvl01gYw3cqQk/s0ez0YwU42Tm32QGMNi5+rjo86Hn69emIbGk8kacvGkWq6p3rUxsuStp2uchc7OJMhC8XbmYAFJ8jbv+fhf5ysXSTsly+lJ6VyoBlIHBtKrN7ktsyWYM0+oZcq5kGCYKgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LOlJ8euW; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LOlJ8euW"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 81F714E4102D;
	Tue, 22 Sep 2026 19:01:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 44FFE60580;
	Tue, 22 Sep 2026 19:01:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 62AAB10328441;
	Tue, 22 Sep 2026 21:01:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790103712; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1eBHuLb4Kv+kmCOhtJ0Iew9q+bsMi6SpUVnn/GIgs5Y=;
	b=LOlJ8euWGdW6Z7VgQfiCrKdoAmVLhVA/QlqhegZXhgCeozRi6mKELH/uxRKmCg+g99O/cU
	WyeICU7w1vjCDniXKkXjorcl3JXcQ1ZD7QQb/S/Bw23eODnIyJgwrb9LsB4/kWBWfDy7Kw
	23I3+RonBpEqsJRdHr5s54yRwt9c5h/1B6rYLrTX8plvWDzB8+NhVA9tqdlXW4pACT7ydf
	GR0PvWpe5CDbLHSAKkRzOj9mYNDYpMgs9XPyiYPHw3H8UqRkolNvUg8EJnYAFacN3exbbf
	4Gu2fxqcEFbWXbIEnydjG2O0iJ3dahFpGgeOU0DDGM5sXxfauPptU3FfBe1QnA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 21:01:43 +0200
Message-Id: <DLM2SWGU9QV6.3H7Q7U7MLE786@bootlin.com>
Cc: "Conor Dooley" <conor.dooley@microchip.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Richard Cochran" <richardcochran@gmail.com>,
 "Nicolai Buchwitz" <nb@tipi-net.de>, <linux-kernel@vger.kernel.org>
To: <5mghybrid@khu.ac.kr>, <netdev@vger.kernel.org>, "Rafal Ozieblo"
 <rafalo@cadence.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next 1/4] net: macb: Preserve timestamp settings on
 rejected requests
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260922-codex-macb-hwtstamp-submit-v1-0-9d1abaa53296@khu.ac.kr> <20260922-codex-macb-hwtstamp-submit-v1-1-9d1abaa53296@khu.ac.kr>
In-Reply-To: <20260922-codex-macb-hwtstamp-submit-v1-1-9d1abaa53296@khu.ac.kr>
X-Last-TLS-Session-Version: TLSv1.3

Hello Kim,

On Tue Sep 22, 2026 at 11:10 AM CEST, Kim Wooseok via B4 Relay wrote:
> From: Kim Wooseok <5mghybrid@khu.ac.kr>
>
> gem_set_hwtst() can reject a request after changing the TX one-step
> setting, because it programs the TX mode before checking the RX
> filter. The call returns -ERANGE, but the hardware may no longer match
> the cached configuration.
>
> Validate both settings first and keep the adjusted RX filter local
> until validation succeeds. Then apply the register settings and update
> the configuration. A rejected request now leaves the hardware, the
> caller's settings and the cached configuration unchanged.
>
> Protect the NCR read-modify-write with bp->lock, keeping the descriptor
> writes and cache update in the same section. With the register writes
> now in the setter, remove gem_ptp_set_one_step_sync() and
> gem_ptp_set_ts_mode().
>
> Fixes: ab91f0a9b5f4 ("net: macb: Add hardware PTP support")
> Assisted-by: GPT-6 Astra
> Signed-off-by: Kim Wooseok <5mghybrid@khu.ac.kr>
> ---
[...]
>  int gem_set_hwtst(struct net_device *netdev,
>  		  struct kernel_hwtstamp_config *tstamp_config,
>  		  struct netlink_ext_ack *extack)
>  {
> +	u32 ncr_mask =3D 0;
>  	enum macb_bd_control tx_bd_control =3D TSTAMP_DISABLED;
>  	enum macb_bd_control rx_bd_control =3D TSTAMP_DISABLED;
> +	int rx_filter =3D tstamp_config->rx_filter;
>  	struct macb *bp =3D netdev_priv(netdev);
> +	unsigned long flags;
> +	u32 ncr_bits =3D 0;
>  	u32 regval;

Same remark as Nicolai (no surprise there). With that

Reviewed-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

