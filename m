Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794625536;
	b=Mv4WcaEB3/qZJnJVSE4k4ElRLkHDF81OVZV8zBlTxeIbtwYR/fTyjYM2e6Whdl2U99v1
	 WO/Hh5zOe/OQKJF97k5PolNCeTCw9xCltWu3gXo/11jnYQC9ihHZfNr09Vz5+gOwy/enP
	 Fb9tAfqIORUcCL5EAq9/0qQ8EYFv/oyG/WM6seo4+PyNI+KtvJnqiqEgsu9S/mszQ7wcq
	 cULyQaEHwNKhlTQ8mfDvETPM0KleFq4nLikrEFSnc2/ek1Eu+jkuB0oKlGupxxYWDfh2x
	 DJzVntd8moQZFX0u+a/cGf1BsEdBVCw0+IFLKKslD96eS3xGRXex20n9hcENxcL2FmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794625536;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1JkuRp3TNB1JHkU7DQf1wJVxEmAivZrbavKu8XaqjsQ=;
	b=rqxLvww89b5AOJ0s9QmbVHtkuvaHrt+0z7ML7oVv+pnPxtqy+O+UK72QofdMRjNwjzmf
	 2Qa2QbP1W4OwhvWc41txLNzaZW7ordXh/A26zGt99gOK4i4l0pUm9YaXkGE3U5u1SLf3k
	 33c3oaH8DINxSR0hOEeNd0W1b2Ku1nAXP2PUB4+7LlU9KZVgeDqafX70Vr+ZZMFEIMF6U
	 l+sCgLhaYEPHTWIDumBdvlcTUE1P3A73nYgbTwFRTgEuVwGI74ycL+qVQM+aLIcrdi0ox
	 g1XqY85HD9GYBDmRXucaciAFfNpz+JqUbaNktdtny03Z8tW90vAYnt4Smi67iaySZyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rbco+J7i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80DC606A323;
	Sat, 14 Nov 2026 03:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rbco+J7i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127E01F000C4;
	Sat, 14 Nov 2026 03:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794625536;
	bh=1JkuRp3TNB1JHkU7DQf1wJVxEmAivZrbavKu8XaqjsQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Rbco+J7iAydez4dOA0yWH/aFRHm2IHdYBV//QJDafvGG6iIyO2uKNMvWGRmh2+k0A
	 ol7EJ4D/4z7XxY2JKy5zOS95XAns8NF4Fr8SvAKJBlxdqQ2lxMj3TZVsr9MorfU2fh
	 FRtJtcUhIIt2TI5oaPc6kh+yiGkKIBAurqJUFQLNHSGOJTXH3rHRQ6lcIQnuhU+Phl
	 K15ZNJLcA+fVdGDnFGFcGRlXZ68ijn+mqN4nro+6l0yVqk9kfds2YfpjNr5u7G0o7k
	 oBIvgr85P9ZocZOWVlsKYW4wlxEeFLbhxkAPXFUCVI+yMQkUwBhiEZzviQRVtHNv8h
	 ufCqfU9qhsNJg==
Date: Fri, 13 Nov 2026 19:05:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Eric Dumazet <edumazet@kernel.org>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, Jianhui Xu
 <neuromoments@gmail.com>, Emir Beganovic <beganovic.emir@gmail.com>,
 Nicolai Buchwitz <nb@tipi-net.de>
Subject: Re: [PATCH net-next v20 11/13] ax88179_178a: Update driver name and
 information
Message-ID: <20261113190535.0e74cbb7@kernel.org>
In-Reply-To: <20261106-ax88179a-v20-11-37b5a1189983@birger-koblitz.de>
References: <20261106-ax88179a-v20-0-37b5a1189983@birger-koblitz.de>
	<20261106-ax88179a-v20-11-37b5a1189983@birger-koblitz.de>
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

On Fri, 06 Nov 2026 08:21:26 +0100 Birger Koblitz wrote:
> -config USB_NET_AX88179_178A
> -	tristate "ASIX AX88179/178A USB 3.0/2.0 to Gigabit Ethernet"
> +config USB_NET_AX88179
> +	tristate "ASIX AX88179/179A/178A USB 2.0/3.0 to 100M/1G/2.5GbE Adapters"
>  	depends on USB_USBNET
> -	select CRC32
>  	select PHYLINK
> +	select AX88796B_PHY
> +	select CRC32
>  	default y

The rename of the symbol causes the question to pop back up and it will
likely annoy Linus. There's no reason for this to 'default y', let's
stay on the safe side and drop the 'default y'

You need to rebase the series, too. Someone mass-renamed a bunch of
kmallocs to kmalloc_objs upstream, let's make sure we use the _obj
form in the new places too.
