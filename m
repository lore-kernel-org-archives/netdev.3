Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C933D9520;
	Fri,  3 Jul 2026 10:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783075479; cv=none; b=hQkwnhjapV7taRAuSdAfiLSxpF5kuPdtwKqWDDQmaWZdf6+SuyJNxrBTwjqgw8Awx5Q3xyfwfJ12RnDcgZN9BX5ZC7YzVlFs6BK+she3nfr5vyVWGT1fc1AP+8U+dxynUj0UhXFysfFr74DSSUWDR4O8I3X8RrOfUiGbqATs5wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783075479; c=relaxed/simple;
	bh=XnxoIlVwr9J3rE7etf3DG7iiZqvV3ZVvgQqIrj4dN14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HEYbazPooAA2VbwdfnZ1SXr9wLunEJI8g4CIPdXYDc+6qgN4rqJWmR5/byrWvQuRdyYfzOv0K2FnkF4fQ/jp3MftOK1Cg4/w5D4+mdO0emqu3VI2ZeUoAFamIQ1YHKLUZZvMDyOhlgo/6H4SvW7os13x7LjgPA5BrenCYuS0DAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=Z8mODJ3v; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="Z8mODJ3v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
	s=unimail; t=1783075279;
	bh=qctwS9LPST2/33+gavfp9uKFDcxocIgaWfG6gvJZ2CM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Z8mODJ3vew8ISCrnXa3eXTetlCZc4xBF8FSQ1qPgQyn3Fb4c1/4sk3Au0bUu+7Anc
	 2FXZxL8TQ+tkGKfCWEvTsAxIKshd6XWREyKa4uE5m57D945kwRZPC6b8KRIRORRmp2
	 oaRXnp0rQoddd/bL6jD827WscgeVFZ8f29Q3YszE=
Received: from [129.217.186.105] ([129.217.186.105])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 663AfJMl029086
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 3 Jul 2026 12:41:19 +0200 (CEST)
Message-ID: <a1bae349-61a1-4c65-a531-179850576642@tu-dortmund.de>
Date: Fri, 3 Jul 2026 12:41:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] tun/tap & vhost-net: multi-threaded
 network performance
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
        Tim Gebauer
 <tim.gebauer@tu-dortmund.de>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        linux-kernel@vger.kernel.org, Brett Sheffield <bacs@librecast.net>,
        regressions@lists.linux.dev, netdev@vger.kernel.org
References: <akVnoOYQOrt8k-Gu@karahi.librecast.net>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <akVnoOYQOrt8k-Gu@karahi.librecast.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/1/26 21:16, Brett Sheffield wrote:
> TL;DR - Commit 1d6e569b7d0c0b2736636749e4be0a27f3cefcb3 causes
> significant performance regressions with TAP interfaces and multithreaded
> network code. Please revert.

Micheal, I am convinced that netdev_tx_stop_queue() and
netdev_tx_wake_queue() are too slow. The communication between the CPUs
is just too slow. We already spent *a lot* of time speeding it up, the
patchset was only merged at v12...

Yes, I would *love* to have qdisc backpressure on by default but I do
not see how anything could speed it up.


*Is there any issue if we introduce IFF_BACKPRESSURE?*
I implemented it and it is a simple patch that only executes the
stopping / waking  if ((tun->flags & IFF_BACKPRESSURE)).
I could submit that to [net] very soon.

Thank you,
Simon

