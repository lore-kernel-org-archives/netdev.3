Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C413CF1FD;
	Wed,  5 Aug 2026 17:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785950628; cv=none; b=EZCFNpGuevGCIb0gnFrqpnVzxJmVQlcbjmw5kqAGecDBL6q4RasX3mbx+XaE3SjgpszaE8024L0ICMAoKCMmtrObeCh0vVu9CPdsRDnrcbXozOjmlspwOeasXDH42kD/eCzNNu3O8xrhMDvaAgZvEivlq+kgyaQ6Kfapy+8/e+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785950628; c=relaxed/simple;
	bh=9D6Q9mdlRQPkayQ1wzu3TfTVD++gDwLq96UPpl8fkJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmkHE7YaoJPT7zZXJdCjAwRnJrbfjPvX9/BDhrW/DiSedF6ek3kkncLRHKY/8WfYdipYVEj6tEJ7mNvoPX1U6edReJr06lmyv/SHAPT7bSt7QLSq62PQiMxTgvxOAXdzfhRzWiSf1DegBo6Qbl07ztsRikjBp0h6RvDDBKo0Z1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=fxTGfDYS; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="fxTGfDYS"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 47BAE3F563;
	Wed,  5 Aug 2026 17:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1785950623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9D6Q9mdlRQPkayQ1wzu3TfTVD++gDwLq96UPpl8fkJI=;
	b=fxTGfDYSe4VoNUSNsffPxRCIi/GSGAcwtpklz+gU5RBscAqlYe8z0EIMuXzTY5nIVTRZTx
	b/UxlwRXp09MRAtcfwIV3uFCa86DIY6st/M20tH5xKhkcgiOACsZYeqngnpJLnZwNxDt90
	z5AgnH0mYxKwRUEhrKbzHcV0W1qtX3b/oggSZ/tcm+fzlXloHKATgQAJvQgSecWC7I/pbD
	CUSkI0SK7QeI8Ytbwmv3ryks3IAkfO3Jdo+RKClqLxp2huKl9USUqkgmbIAcglJ7tUcx2V
	bg46UHWg3nzCqxVz4prIBQPlr602wSwIMQIKn0kGhJfotxXSW2tMEvCuGe98uw==
Date: Wed, 5 Aug 2026 19:23:36 +0200
From: Arthur =?utf-8?Q?Cr=C3=A9pin?= Leblond <arthur@marmottus.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: net: convert wiznet,w5x00 to YAML
Message-ID: <anNxmAwfdJKlatSI@pc-du-fromage>
References: <20260804-wiznet-link-gpio-v2-0-3b1d0c870f35@marmottus.net>
 <20260804-wiznet-link-gpio-v2-2-3b1d0c870f35@marmottus.net>
 <dd38875b-1df5-42d2-acc2-98fbe86ce3fa@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd38875b-1df5-42d2-acc2-98fbe86ce3fa@kernel.org>
X-GND-Sasl: arthur@marmottus.net
X-GND-Cause: dmFkZTFs4UanMfmHEAPPY3h70JsU8HT7Z2h6RUJDGXMip8OaY3orJRiyy0Dke58K0IG3ATex/aVCOAcZf0SIkCfxGnFuLN4Ow2k/ryd18pxN1nTOaV/GpaHbkscHp4z/GDzb8lQiMjB307zBjyozqFpg1idc5LiygpAXHAuW1S4g2l6hgG0VRDK5zqIp7DBCLYyVTckVuB7SutChaTAanae/g/7ohdw6oqCLv+oTZiPqrFChbQKDetmgQ/83ujTY4XS0iy8IrjKDqnW1ejXJonuwTjoMdWotaexfVHzk1yzxyW4gHIyRwgmVXuIIIuNnVpjxUNovdYBdIpaNreBh/Jv+Eb9mNos0a/vLfbQnjQsXIpRJjlFy8vUDTK37dONbgDIfP8yAPFh49jqiC0OSqUPuUo5bojJWwxL13TYrWCaE7gx4NQlUoT85jBOdc8HvnsLv0/+EGgRVdm+XO5guY1a8XyRUVBd62I6O4zSSI4ainbyEiHr4ZFiPyKD4tmfVJPYauUhX41w6aMNuE4VXtPqM9OCFHop6Dja6v1MxTwhMkcdH7vltzZb0ERLxNQzExgcShSFhYVKt0h4J+VMlk3ZsT/z1N1yiqr1SEiG0FkJJLIX+xdOaAaG+G6PrNG9N78j8YfjDZudJSTw2uz/FEfIHoBl2I7bEJj64qVAmB7DDljHpZQ
X-GND-State: clean
X-GND-Score: -100

On Wed, Aug 05, 2026 at 01:08:35PM +0200, Krzysztof Kozlowski wrote:
>On 04/08/2026 19:40, Arthur Crépin Leblond wrote:
>> Convert the Wiznet w5x00 SPI Ethernet controller binding from
>> text to DT schema format.
>
>Limited review, to spare you one review cycle, as it was not tested.
>
>Subject: s/YAML/DT schema/
>
>See also:
>https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/bindings/submitting-patches.rst#L23
>

Hi Krzysztof,

Thank you for the review, I'll address all the changes in a new patch.
Quick question, since there was no maintainer on that text file, who
should I assign it to?

Thanks

Arthur
