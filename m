Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0332DEA75;
	Tue, 29 Sep 2026 00:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790640059; cv=none; b=J6t0Wq8KCDW3wxx3XWX0KI3msr0ax7OWAXEFTk4LKgB6tuUShadIvhwjVucwBuqQCgLt/mKph5Ch8QDhXfvJT1AMI0UI06uWIEhp6RI1LA/Ni4YW8Jdp08VwR1tmaT8VORYkALpJZbudA0VqhzfF2LgNGl13/Y9UkeUT5c1gmpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790640059; c=relaxed/simple;
	bh=xMkNX6KhXJ1rcmQ6GQ3sV7tU41WHH9YSZaJDyux8Xgg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bEtCtvULnsWE1EfOJLgnuEoCGDVbTYKlEuAdLbJKx8U0xlRS7PLRr2RoQYN0xfbuO5hk3xmMkB0l8rO4Q4gmmplgA4SQwppFWxXp44OnY5950/LoKIUW2XedC6IsdQMsXCH9V251NZtmuGJImBq2lI1xVrQDLdqtNCaP/oXmPxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtUuVAC7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtUuVAC7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8801F000FF;
	Tue, 29 Sep 2026 00:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790640057;
	bh=4jXAS4oY5mgsnaydb1SE0LgAUGjvCpMjf9ZXzrPnafU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WtUuVAC7GM3nBR79gn3Mwz2yj4pXOUju1VtFUsnLA41DjgBqXQ77W5+y1Z9v1qknL
	 t6QRvjoyEwWScDZc0vOCvI2/bSBj1M2ZOHohuItC9Zcjn+6jLxiIuO4KYWVYl1Vhj2
	 e260xAi0/ErovWDpOEKtWTDbQtgrpHBSUwTqwUR70zhPxBPrdC21ggUCaJhEIPrc7c
	 9/S9t6pt9whl4ZZGKJH/OgDZrVyGh26yVfnr74SNqzAPZXkJ5dE6T2RwpcRVThghga
	 YIUlE2Q5JwQUe1oVyyMyoCwTT6MoD+EhrsUyDfI0rCOWp6gW4oK++eQmuHDC7sUU3p
	 DaMNMHmbdf5JQ==
Date: Mon, 28 Sep 2026 17:00:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>, Doug Berger
 <opendmb@gmail.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Zak Kemble
 <zakkemble@gmail.com>, Simon Horman <horms@kernel.org>, Ryo Takakura
 <ryotkkr98@gmail.com>, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net v2 02/10] net: systemport: Fix invalid dev_id
 argument in bcm_sysport_poll_controller()
Message-ID: <20260928170056.33dbd040@kernel.org>
In-Reply-To: <20260922232440.598918-3-florian.fainelli@broadcom.com>
References: <20260922232440.598918-1-florian.fainelli@broadcom.com>
	<20260922232440.598918-3-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 16:24:32 -0700 Florian Fainelli wrote:
> Both bcm_sysport_rx_isr() and bcm_sysport_tx_isr() expect their second
> argument (dev_id) to be a 'struct net_device *dev', as they call
> netdev_priv(dev) to retrieve the private data structure.
> 
> bcm_sysport_poll_controller() was passing 'priv' instead of 'dev',
> causing netdev_priv() inside the ISRs to treat 'priv' as a net_device,
> leading to out-of-bounds pointer calculations and crashes when netconsole
> or netpoll is triggered.

Can we not delete this ndo_poll_controlle and let NAPI polling take
care of netpoll?
