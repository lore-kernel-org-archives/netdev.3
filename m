Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFFC2EEE7B;
	Thu, 10 Sep 2026 00:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789000830; cv=none; b=tNnUXj4J0Jwo4QgcT5ojnqIx+E+O20+me8WbmPHW/ZAp3MYFK/SZRpluTZvTcQ9D+IyLBXePdYvDRuKZl9p9xx71hfRl3af+Y3HXn/FwnNHhZaQ5s+D+nntBYqXqQC2qgP/MuSCoDfqHnuZeNCjkuJJRSLHDnL0NZS4fRK99bqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789000830; c=relaxed/simple;
	bh=CPBwrW7AMHZbi49TGAepTGODqjPbJX/LSYLSbSicYqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MwNv8/luK81gdXBVn3d2fRYcJKD+TqkyAe9zFBS+qotgoTMqLnzH2+zjwDwDrR2VxPUMrFCYvLxq7J+wDI+qxJdS0vPdHMNvwy1BF8y8Pbn00qBSzYgNo/vDbP/mZfWccv1dTzeJBLfLFKwSq2lHaeu03XGHE+uye6ffZyMv5SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=W2e0+R+j; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="W2e0+R+j"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ADACC40E58E;
	Thu, 10 Sep 2026 02:40:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1789000824; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=LB4xOGwX5zRvsIqTiz17TCA8SFZm8FpI7B2jc9dy2MY=;
	b=W2e0+R+j5MhtDmDdh4jEQPXtRn2UQUSpSayn4MrW/NP39/u/IvlpGWcZWJY4zwClYDQUzv
	CVsbJXXCxEis6yeZPP8PhS628sxtAa6o2kSnhGKVTtHwpdxRpQz28T3jHfdNRl91JpJK17
	j3zVTIrdKBxvtCCAe7rM1lZN6NChxCMcvus84hPhVafJRaSRoRAMD5QyaxC0qJKBFs3QpL
	MIW5cpvlvw6UP9JuRNeY2KhE9XCW0Uo7HIwB/iO3ntqfdJ0G7GLezv3sWjJCW5gApBps7G
	TYuqkcPWYJ0oE1S4QfMMEUd2tW284zNPKoiTo2oCEPB7vIC9GX4Nipve6uqmsg==
Message-ID: <508e083a-2bee-4003-8ee9-e9b269b2821d@cjdns.fr>
Date: Thu, 10 Sep 2026 02:40:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: econet: add EN751221
 ethernet
To: Matheus Sampaio Queiroga <srherobrine20@gmail.com>, lorenzo@kernel.org
Cc: 25181214217@stu.xidian.edu.cn, andrew+netdev@lunn.ch,
 angelogioacchino.delregno@collabora.com, b.larsson@gmx.com,
 conor+dt@kernel.org, davem@davemloft.net, devicetree@vger.kernel.org,
 dong100@mucse.com, edumazet@google.com, enelsonmoore@gmail.com,
 han.junyang@zte.com.cn, hkallweit1@gmail.com, jes@trained-monkey.org,
 krzk+dt@kernel.org, kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 matthias.bgg@gmail.com, maxime.chevallier@bootlin.com, naseefkm@gmail.com,
 netdev@vger.kernel.org, p.zabel@pengutronix.de, pabeni@redhat.com,
 robh@kernel.org, vadim.fedorenko@linux.dev, wangruikang@iscas.ac.cn,
 xuanzhuo@linux.alibaba.com
References: <20260909212146.3184077-2-cjd@cjdns.fr>
 <45cb6035-4d15-426d-bb3f-45d20b4201da@gmail.com>
Content-Language: en-US
From: Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <45cb6035-4d15-426d-bb3f-45d20b4201da@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3


On 10/09/2026 01:09, Matheus Sampaio Queiroga wrote:
> Hello everyone, please excuse this email.
>
> In my opinion, the Ethernet driver for the Econet/Airoha MIPS SoCs 
> should be merged with the existing Airoha driver.
> i get PPE and xPON to start and work on the en7523, en751221, and en7528.


For my part, I don't agree with that opinion. When I first began 
developing this driver, I first began trying to work on that driver and 
I couldn't find a way that didn't lead to code which I consider ugly.

The main differences in hardware are the number of RX/TX chains in the 
QDMA, number of IRQ banks (we only have 1), QDMA register layout is very 
different and we have fewer features, and we have two GDMs rather than 
four. Also as I recall we have fewer channels available so QoS logic is 
not drop-in.

If someone proposed to me to add Airoha support to this driver, I 
wouldn't want the same econet_qdma.c file supporting both platforms, and 
in the Airoha driver the QDMA subsystem is more tightly coupled - so if 
I maintained that driver, I would not want them merged at all.

I added Lorenzo Bianconi the Airoha maintainer to this thread in case he 
may have some thoughts on the topic.


Thanks,

Caleb


>
> With a discussion on the Openwrt forum,
> it is said that integrating the en751627, en7528, and en7580 Ethernet 
> drivers into the new EcoNet Ethernet driver.
> These families are closer to what we already have in the Aiorha driver.
>
>
