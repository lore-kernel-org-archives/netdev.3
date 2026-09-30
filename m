Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5BD39CD0F;
	Wed, 30 Sep 2026 07:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752668; cv=none; b=fwCelvU0Q1Rip9aIHl61EKtniTYCjn833YiAYwbbgr94DVo40ghFa0HZmertmfVkNlB95hNdTHVl7DIIIikkLKETHF3amqD1V5YT2rxLUnhOrNp6W5Ub41JcYczpck8lrtaxWhe3VL7mumohpcwGrRShUksR5SOmq7k2TJyigDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752668; c=relaxed/simple;
	bh=pitpDOpI0vLNTL6kvv5zJFZ3QOVZfIphnnTHst5X+MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=miupqOFzmNcK7JjhmQDZv8dL3PMMWC41ByblIzXfNSezHvSC7UIJ0rQ7UJAye0597GE5I9+w8Qs7KIuz0BCiipFHWSESLVU3fqTtl0TeSrUrBfG4D6+m8+bEAqExQfNK/DJgjCGSwdGyaWc0DUiyCQrBf7cU8ed79VMfHw1a+FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=nPpdmlhs; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="nPpdmlhs"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7FBD93F0AB;
	Wed, 30 Sep 2026 07:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1790752657; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=X002Vn+YhKKbTWkw+KWRj3nY4Vp3Ksry2t01J523f6E=;
	b=nPpdmlhsGbb5IoJn7Bm2OehRsHrZvTs5BaoXDhsUmh5tB2MUuM64sXfIqkmGwco4EN7unU
	RinRhyADr4EkLgCI96i5myalz2pmVildPvytnAat+HMUitvmJfCFYwkldHG0dSeNpjQMh0
	1rUXlrulKmJAcLU+NN1j/QXkSdUvgLeqgjyvodxYV+cNxktVv4P1OCHd1tkQKvJFy4tNpI
	Raxqzk3dryN9krLOB6wzhLZwdIkdBLG3m2fWrag+q696y1O5g2y6NnUG7eVfOUHO4FfPZU
	r8dNQKrMiEWN6LwYAYyg0kOerjVxdzJTiL7d4uoze/BToqWI8MWluyGq76Y2ew==
Date: Wed, 30 Sep 2026 09:17:33 +0200
From: Arthur Crepin Leblond <arthur@marmottus.net>
To: patchwork-bot+netdevbpf@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, arnd@arndb.de,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, krzysztof.kozlowski@oss.qualcomm.com
Subject: Re: [PATCH net-next v11 0/3] w5100: restore GPIO-based link detection
Message-ID: <20260930071733.GA7777@marmottus.net>
Reply-To: arthur@marmottus.net
References: <20260924-wiznet-link-gpio-v11-0-42a332517b30@marmottus.net>
 <179072880777.1183624.15268647911165769785.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <179072880777.1183624.15268647911165769785.git-patchwork-notify@kernel.org>
X-GND-Sasl: arthur@marmottus.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTFAktZjHRoYS5zKIoSDOVtc0HcK1X+5S7wV8QSXbIqn03GrGZh1cnfY0pBw1b1Rx1zq7wQynOUx8lF5RCiZm8Cq9RBEatXwttvg2q6IRtcvfq8ehJj4O5wULfP6D0l3UMTOWwR2Tht7nvKEpTbblEh1VQ/hFznEBzJpVfOglqVJpv0MUyXMdDeSayiW4AewYgKIaT7HWSnSNqQNxQCHg5+dmyiRDZFdnSdezbNMsdNw6cyMzKQVZJnKzhNzo2UpG046yiP7Ijb2HWdXi2+n/FbheYUp0cH2pMoZF+l2J+yezfOcpUxDFxT0jTEvnIO81OibDpN0YiVtN2t2br0+wdT5PQxiA1EFhTX05+JBAM867/Tk9iIkJt98wnaFSkcruPEwux9P9/5PUbxxXNoGK1qFA9IQaJkDNid9DhXhsBE5eofo0dJPpfUePDUk18z/61dMKQn2enjJmBmm8Be6WQbyf5m9krQ19FD+B/LhmW8KEkfN9X1GrtOWcm6UIQKOIaLJs1ZblGwS5A9diJ5tFlS43OByT8ZQC+KmIQgnnDuYdN0VhkIuTILVnq8w90bqcUwC/C7vL6pw/cNs9Zmuvxj44SHE94xvxzy2mmzN321LgWx7MKbiZYKYF4dYyUtimGms0IBdEsKYLFQgeiBplbYzBnxLoIciIIsO/PZpzh5JSA

On Wed, Sep 30, 2026 at 12:40:07AM +0000, patchwork-bot+netdevbpf@kernel.org wrote:
>Hello:
>
>This series was applied to netdev/net-next.git (main)
>by Jakub Kicinski <kuba@kernel.org>:

This is wonderful news! :-)

>
>On Thu, 24 Sep 2026 11:48:10 +0200 you wrote:
>> Hi,
>>
>> In the previous version of the w5100 driver, the LINKLED pin could be
>> wired to a GPIO to detect the link status changes via an interrupt.
>> This only works on w5500 as it is the only one documenting its LINKLED
>> pin to hold the link status (on w5100 the LINKLED pin is changing with
>> RX/TX activity).
>>
>> [...]
>
>Here is the summary with links:
>  - [net-next,v11,1/3] dt-bindings: net: wiznet,w5100: convert to DT schema
>    https://git.kernel.org/netdev/net-next/c/be15d99d8ebc
>  - [net-next,v11,2/3] dt-bindings: net: wiznet,w5100: add link status interrupt
>    https://git.kernel.org/netdev/net-next/c/50c4bbaa0d36
>  - [net-next,v11,3/3] w5100: detect carrier state using link status bit and optional interrupt
>    https://git.kernel.org/netdev/net-next/c/323767fa31a2
>
>You are awesome, thank you!
>--
>Deet-doot-dot, I am a bot.

Good bot.

Arthur
