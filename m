Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794436655;
	b=jJBJBdzhsru/KBA1QhGjXAbu0FZcFje2h4LdxZiR5owCQDVp4XmuXzu0KGkzKKg8znRY
	 6jdDol3e+f14OlMVYjAxgM4TL4cXKaUt8wh2bJKqLuokuqKRHSd+pFFVsB2jF2xEKIOOW
	 truPCYE+4RNGyZgSN/bRlMleXjnAUeKNvzG56o8N2MTRJAzqhXrSD/YqXbXc6c63FwwqL
	 I09hiWaI2yt69zyLH5Rnzuc91BcjlvKPKUVhQT6RrKAdyF0SS3PedDCz2K+uyAYY1EUL2
	 1G49sdD5JlAX/hVs5Fjj5ZKN2rNtCK5xOHF3mo1Y7WT87SnxYNvoZPmgIV3eOIoTAXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436655;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=A3RtMOJFfy+vAv7ZRp5Bx//dsvOVbj5s6n6hxHY1wW0=;
	b=TdTdJ1XK6+TO6t8Ka61gyFsAtMKKOY7q2qXyfeZQ+hEfkAI8podNbo4r7Ei42Y7Yw20t
	 r9Ck11h9jfhJuTyuC7AJ+tTqjgTImELqdocIHdNIUZEYBT/KjbQtIxyj3udoEqhuSk4Vm
	 h2pURTyBf9CYBDnyhIJD8ORzuPdeK+xrAs3fEtUlnWV+AHXTuZWIzUYpz8B6kSgt16ybk
	 x9W+G2cLYawCl+v3e5Aolpp5Ir1JI8IyxNj7lpnHDfu+A2H/6ZlP1I+EDT2R1Ck0uqFva
	 jE9IdAlTU1nQsV2yH3AjV38JrruqykWBEixwsiEvMoDnH20DkPHt0mhvbjVLeHQRf0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TZqxvBGV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BE7606A8AB;
	Wed, 11 Nov 2026 22:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TZqxvBGV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDCB1F00A06;
	Wed, 11 Nov 2026 22:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794436655;
	bh=A3RtMOJFfy+vAv7ZRp5Bx//dsvOVbj5s6n6hxHY1wW0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TZqxvBGV2iuroyyAZYdFql8VA1YInqb8JEashR9rUwvhYxQ8enAIvCqHEARMicfu3
	 MF/yLB6xJhAUevs6+9mOWRLS89EHyWGY7PAMPfvZxpkQH2vhh+Q5y751xY2pueBkuX
	 jcmhL2/qFzPynDitdWnTxCaenLFdcHr3fwiiW7hR00xYYihxjRqWDuQ8vta9MDZZZe
	 8uMQ+UQlE4xqFaXtlVjaWTRO+yMJzvBRaZJIC0tDmzqMM5AhNEJ19OjY5AsDvORnyx
	 qIfdx776I32l+0q77NJV2xEEAVIoXFG2W68INXqbyzgbMo2Q8WQQDdN7bcKc0eNg5d
	 NhcgQSRnBP88g==
Date: Wed, 11 Nov 2026 14:37:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: Justin Iurman <justin.iurman@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Hangbin Liu
 <liuhangbin@kylinos.cn>, Sashiko <netdev-bot+sashiko@kernel.org>
Subject: Re: [PATCH net v3] ipv6: ioam6: do not modify shared tuninfo
 eh.nexthdr
Message-ID: <20261111143734.2c57061a@kernel.org>
In-Reply-To: <20261109-ipv6_ioam_lock-v3-1-a86195859d1e@kylinos.cn>
References: <20261109-ipv6_ioam_lock-v3-1-a86195859d1e@kylinos.cn>
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

On Mon, 09 Nov 2026 10:52:25 +0800 Hangbin Liu wrote:
> +	((struct ipv6_opt_hdr *)skb_transport_header(skb))->nexthdr = hdr->nexthdr;

Please use a temp variable..
-- 
pw-bot: cr
