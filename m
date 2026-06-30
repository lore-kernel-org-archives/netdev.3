Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4D82F8E98;
	Tue, 30 Jun 2026 01:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782784457; cv=none; b=i34CVKqS+xQ/IbpBAzcG49if9ZCi0aGyIvqhvx4P4ZRodvIiI1s7sGL8ybtZ1UWmZ2bGVJ7LvNMra9I7sDwMQRf4F5rHpAxuS2Iq9srUjC8AMgqav9dcparIUbIrwyPLJu88ZZZbIspQo2EJp/VcqmfJdfQgeF8Ymtt0BHfNXiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782784457; c=relaxed/simple;
	bh=G+Zxlz53+flqDsWEQBE4Q9MC0i67W8TGf2XxpOHs4fw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z+IKu6AOjhtaL4hSfgmwdGA/iw9WnjbaPBl5u25Y51qTZRXhZKaxB/U/NtO1rOvvFCDgbG04BTdHob1ABm+PbAx7ILp7UFcG82C4OmzWM2Y5FOMuAcwMPJmr6L5upyN6LmlR6MJKpx3MNSxLk6zmBCu1JqdORwNGzH/ufywgjRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHqkpGaJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHqkpGaJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F7C1F000E9;
	Tue, 30 Jun 2026 01:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782784456;
	bh=B3/1fWurN9ZwfutD/RVbG86aLwljhCDdo+Xa5xf/1v8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hHqkpGaJQZ/0SR/fc48c4cBIj+mWdrFDO8UKytKdciTg23c7xx3EbFJF66JifiDrg
	 rN8i2sIPMYAp49C7iMCNBEq2P1mVHxc3DmlVS+V4z1KoHmMjYcKirapJZL13JddMs9
	 UHFLP8H3OJd3Z51J4x/xuLoqkUqiREcvDYvUppq3uEqBrwZ0F/hH2u01VSmkqiwDJR
	 Ev/Qiex7FXRFW/EK62Ch3jsbBLLHAux7/RuBP/gd+/iwMGxiE/hVgrqkAykIv5yTvx
	 Xt31Xt/oX2vQasQnBqmCtCBKZ2B8ulVr4QXtn589EjPsf7tSjlGykWV+FVV7jsRPac
	 SiMpIUi1ZYwsQ==
Date: Mon, 29 Jun 2026 18:54:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Weiming Shi <bestswngs@gmail.com>
Subject: Re: [PATCH net] net: usb: net1080: validate packet_len before
 pad-byte access in rx_fixup
Message-ID: <20260629185415.56ec8b67@kernel.org>
In-Reply-To: <20260627212854.4025016-1-xmei5@asu.edu>
References: <20260627212854.4025016-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Jun 2026 14:28:54 -0700 Xiang Mei wrote:
>  	if ((packet_len & 0x01) == 0) {

just add "skb->len &&" to this condition?

> +		if (packet_len >= skb->len) {
> +			dev->net->stats.rx_frame_errors++;
> +			netdev_dbg(dev->net, "bad packet len %d (expected %d)\n",
> +				   skb->len, packet_len);
> +			nc_ensure_sync(dev);
> +			return 0;
> +		}
-- 
pw-bot: cr
