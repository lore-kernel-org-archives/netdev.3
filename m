Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49881196C7C;
	Thu, 10 Sep 2026 09:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789031224; cv=none; b=hgTRHQIplMLCPpjVydruCfFuWMYvjn8w6GAwxkw/Wr7QpTgBLE89xYIjQFjvkKlqXAUV2QDDdGUobe3n3uIlFDYNKaJlmUvnJmLdvmDxNrvJo4wx+dBXkd037BTWvYU07Z37K2fqSiUjOtBajdMnPukQQ+o4P4pwGC0ZoUfDyi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789031224; c=relaxed/simple;
	bh=DcW8nDDKr7kcWVFsXctk9W01q2WPKCB9RCtIEIVT6i4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EYm7d7Rej6baKMltwffI/GzEXCoP/TP7yRdqlER1VsvkjX2YDYCqF9XJtI/mEzDADZErAwmfJbEZnKNL714LHogCP8v2G2029keCklTErubzEs4BY3o8ppeYPA3pTHdew8G1fE3h05nwG8NqklwtTydQXAVOKC1IYO1sjHK7r/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=hrdsPiDp; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="hrdsPiDp"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4A8FA404F10;
	Thu, 10 Sep 2026 11:06:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1789031217; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=85V6AxDobuh7+s/NLZ3B1iJeX8fNAbX7eyVc144CvSY=;
	b=hrdsPiDpzVbRlzWKtPLqK536p0zGK3+mvHhW3oTJlnHDJ28PlphioJqxtLOWZTM57E8TLb
	7OtJz3WbW10CztsvjxiQG6+gBXTPke3CmhOxDrTtiFf5mQQfPLVeqfK1/+SMFhkMaY4CtK
	cJPjALlZFoznPBY/YhKCt9Nd8bAy/RXwYPud72HviN942TfT63vmfHMn8BDMVA9pRXNF/i
	yLp9b2L/TQpdyR5jSoq0qcM4HKuPPJ61ZtUQG8y9b8wVRKpBWEV1QeO5f5GgjOvj5YRmKx
	k3uxb0WOsNEpj9XEerlHhSSvs66ibzR+eBh2ettq7oaSM9Yx2vgq17AG+joeHg==
Message-ID: <de010064-a574-4da7-8307-30bd6359e506@cjdns.fr>
Date: Thu, 10 Sep 2026 11:06:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: econet: add EN751221
 ethernet
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 vadim.fedorenko@linux.dev, maxime.chevallier@bootlin.com, dong100@mucse.com,
 wangruikang@iscas.ac.cn, 25181214217@stu.xidian.edu.cn,
 hkallweit1@gmail.com, han.junyang@zte.com.cn, xuanzhuo@linux.alibaba.com,
 enelsonmoore@gmail.com, jes@trained-monkey.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, naseefkm@gmail.com, b.larsson@gmx.com
References: <20260909212146.3184077-1-cjd@cjdns.fr>
 <20260909212146.3184077-2-cjd@cjdns.fr>
 <a9eac625-f0f3-47db-ac2c-26c7df66f52a@lunn.ch>
Content-Language: en-US
From: Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <a9eac625-f0f3-47db-ac2c-26c7df66f52a@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3


On 10/09/2026 04:11, Andrew Lunn wrote:
>> +        gmac1: mac@1 {
>> +          compatible = "econet,eth-mac";
>> +          reg = <1>;
>> +          status = "disabled";
>> +          phy-mode = "rgmii-rxid";
> That is a very unusual phy-mode. Is there a reason this is used in the
> example?


Mac 1 connects to an xPON or xDSL subsystem depending on chip package. 
The phy-mode is not used by the driver and when the driver was written 6 
months ago this was the best guess about the electrical protocol, left 
for documentation purposes.

Your question made me re-investigate this, and I now note that both the 
xPON and xDSL "upper halves" as well as the switch on gmac0 are all 
on-die, so I think phy-mode = "internal" is more appropriate and I will 
re-send as such, and with some light documentation about what this 
ethernet connects to - since it's on the die so it'll always be the same.


Thanks,

Caleb


>
> 	Andrew
