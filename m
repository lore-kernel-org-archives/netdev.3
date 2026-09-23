Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589132AD03;
	Wed, 23 Sep 2026 00:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790122289; cv=none; b=m3la3fgnxLzsNWueAeZMuHcPemCu213wJnP9iUE++olhi+ONKhTDb/tfpp+wwt57b0hnIMdWusD3XE0qY7tHsN2sd03aEcEd25ymilZZnyMeMt/BjJhsxqEyrlvYo1Ebc2LOcmvGZfepuP0zMtSP+AiIMyUfSFsKdi/H9ocrpfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790122289; c=relaxed/simple;
	bh=fxEmH9gZ1oYrOHdSDxrKgHNyfpaxrbrnS0sfCxVXzc8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qo5/lbr4VtCoe/0QM+vGf2aZtmux6IBFn09dqKoOAbD0b/iLbUDDCpOVjUZvYm1ivXVXv7+2fEAN+m/M/Ah5VmuaropwFPdMx2NiZ8lIvv17x2yRA9+/GdFrxdre9RUMMcW2OG5KQXvPyVbYI8DXCWbA0fkSNG7JAGVg6Ma7ULc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOXq24Zt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOXq24Zt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802F81F000FF;
	Wed, 23 Sep 2026 00:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790122287;
	bh=/v3hhP0H20HIQY0qnN2arpZWeY+d+HdAb+cLIoHO6XA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oOXq24Zt+xCEEWF3BfwKPxzniQHkQWn/Frp6hC0wEfhmTwFriybOmClf7iBCRjM04
	 OdzaIIiGEEynB1VkoOqUDBCTK8+cKyKvWxvnkkBBtilRba38pE0rfVpN0UojbS6j7q
	 zn4Cyw2c5bPYHT56z+rQ3gYbGkakDwhvqzdF1T0x628tgTp/rtwaKn4lC6vIqEVIjn
	 MivVGx38OD8Y/o4rf7AFGCS3U2oFNgdR8qdqXjeZeZ68qHNZHG1aS9+SuqhmdIugGr
	 T/R0XXSlXw6WalNlrbQdHbN/CWea/n48DGbGRb8eHTKCqsCJ+WmsY1TAUBlHMAQyK+
	 9Vc9t1BuhPUSA==
Date: Tue, 22 Sep 2026 17:11:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Zak Kemble
 <zakkemble@gmail.com>, Simon Horman <horms@kernel.org>, Ryo Takakura
 <ryotkkr98@gmail.com>, linux-kernel@vger.kernel.org (open list), Nicolai
 Buchwitz <nb@tipi-net.de>
Subject: Re: [PATCH net v2 00/10] net: systemport: Collection of fixes
Message-ID: <20260922171126.7abbfd23@kernel.org>
In-Reply-To: <20260922232440.598918-1-florian.fainelli@broadcom.com>
References: <20260922232440.598918-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 16:24:30 -0700 Florian Fainelli wrote:
> - dropped patch 4 and target it at net-next
> - dropped patch 11 which needs more thinking as to what is the
>   appropriate DMA teardown sequence wrt. topctrl_flush
> - addressed Nicolai's feedback
> - added Nicolai's Reviewed-by tags where provided

Hi, our patch limit is 15, please don't have more than 15 patches
outstanding against any tree. As you can imagine everyone has LLM
access now. The number of outstanding patches in pw is 640 at the 
time of writing. Please.
