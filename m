Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1143E3D86;
	Fri, 11 Sep 2026 15:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789140819; cv=none; b=tVeHTGoNuck175syOXdlKGNkprzhKyas7JuWeyyZozZhhmbxVHqfaY/4MTB1vYmTz+jrXHA0cUSbAgqanX9BTi64QtHq4Xq59iwG4GRsJvB7nvjSKneTLFm8a09iQS6HKlLhd44y65KVGwV80STCz3aDSs0cVARDE1ZiBXRFoWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789140819; c=relaxed/simple;
	bh=6nXXw3W0CyWUSk513hjKemKAvMgCPmex9ZUW3h2qq6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tK1aKbgILCJ1GNbIffhRIq612kc0/I4ur+E/CMoDdsExRLsMTcO0ifpiULIm1/lxiYzkHSOTNR+26QMCooN00ABVwPvrGsNBwy877BNSnTXBn4cVgCFHfJsxkxP7rylc6JUMvDO5/tmu8wRdmZTHDtsbvgXeVnOMIfx8dfGd+8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=je+m/5De; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="je+m/5De"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8C0723ED9E;
	Fri, 11 Sep 2026 15:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1789140815; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=+XBkVdBbqTxc4W5+9+4zB7d/pO65MPSLqPWWRb6u3+A=;
	b=je+m/5DedQvvF4GB6CJDiaMfhldEkzFf+rn0IBF+aYnhG/1rvy4dSFUJTWRDiKcmt2Q4o8
	HKX3YdI7iXbs/+GqQN4T6cF8Dvj/ewT3O/pxvLFsPZu+jd35VmTQPcV8I+urJyZyYDMI7R
	wRiiFZKXdOhy+eHhxFP5OVXMBF9k6fMBgwTWtVJ3BsFh9sn3rKB7qxKyFK2iQiTn5D13Qu
	Sv93oRAlBQDscIzByPSfOUfXKK6P8mIJ9jTVoGEoFWzzL5+iWXhWxeMwjEqo4bZ4Ppr4hi
	mYkWpg5casrGdShuEkNMVeRQlvACyj/xW06w8btq2TI4nCqjyEMpACYvL4+N7A==
Date: Fri, 11 Sep 2026 17:33:25 +0200
From: Arthur Crepin Leblond <arthur@marmottus.net>
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, arnd@arndb.de,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, krzysztof.kozlowski@oss.qualcomm.com
Subject: Re: [PATCH net-next v7 2/3] dt-bindings: net: wiznet,w5100: add link
 status interrupt
Message-ID: <20260911153325.GB9585@marmottus.net>
Reply-To: arthur@marmottus.net
References: <20260904-wiznet-link-gpio-v7-2-69f01b70c96f@marmottus.net>
 <178895754004.219967.902137420360139647@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <178895754004.219967.902137420360139647@kernel.org>
X-GND-Sasl: arthur@marmottus.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTF8FhyhVzSO567TwqQR2SglJ3I0fYtPZKyUxqL32JcYMD8pUhL1wI3RhB/NR1uSRNVoBRGcqBJVCHs+u9AuEdy29fLdXaD4hKoyCuWFmgsxGjyEK5WwF1vlgWwwh6ukNHRUF3VYtHemwJT+UIzEH2InP2ghnFgZ7wAUdUflPkQIbrcNCte5rx3DmSNL+hZ1amcD4ENDsn8md1CLvR04SfkfyY+t1QDJ4NAD1qRb4rl2soseDFGyxA3CTj14BUW2bw9YJKf6FsAViCaV9YCfnUgvAKypa1HJvwJSfaqTy40S3KaqZQUNf5dNdPYXaZ94m6qr3gFCQEOOF3EfEQPeYNAiVKnBOYrcAY7fCIgB/j5C2rAA9AZToeJf3nJRqhoq/TzfyjMNddHkjE2UxOZZVB8ytEo2AYqxuBtCFHAPpqgzV9R9z2sH+c4zRH+JDoLjg+7bvC73B8nYuj3gEvHCE8s8ZQdoS83MzVNGqve0dt+edBgm+fuDeA8v8vKG06lsp8l7N8zWo9IOuNFSlouBGw0HT/skdRZRr8w3LRWtmLvPlyLbJzMhKMZB46sCe/GXfBaAjyzk2W1E9aXkz5W0rzPnfu12YCGDrfD0zzt0UWLTBQRynQWpfJgcU0ZwWLkqkGjcJVhf6bioMx6t9kgRzsNR22TCyyKOfi4BSis/7tM71A

On Wed, Sep 09, 2026 at 12:39:00PM +0000, netdev-bot+sashiko@kernel.org wrote:
>Should the item count be tied to the compatible string, for example:
>
>  allOf:
>    - if:
>        properties:
>          compatible:
>            contains:
>              enum:
>                - wiznet,w5100
>                - wiznet,w5200
>      then:
>        properties:
>          interrupts:
>            maxItems: 1
>
>The driver side of the series treats index 1 as w5500-only:
>
>drivers/net/ethernet/wiznet/w5100.c:w5100_probe() {
>    ...
>    priv->link_irq = ops->chip_id == W5500 ?
>                     fwnode_irq_get(dev_fwnode(dev), 1) : -ENODEV;
>    ...
>}
>
>with w5100_get_link() returning a hardcoded 1 for the parts that have no
>PHYCFGR link-status register.  So for w5100/w5200 a second interrupt in DT
>would validate but then be silently ignored, since fwnode_irq_get() is
>never called for index 1 on those chip ids.

Let me update this and have it conditional and re-request a review
from the devicetree people.

Arthur
