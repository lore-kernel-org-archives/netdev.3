Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=63.250.43.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793847456;
	b=eHUnCISMhcAWXCP6LFyigQR3DeTtfxSf2eTIp/dbGDzaTabVaDqHG5ZwFGLXn/4wJg0C
	 KHPNq3l67pL3up3BpPD/EuZBJ+tys/N+x+hrp1jKPhRaaY1XkkBHiHpxFKf9BCh9Hn5e5
	 aEDauLvClgVOfA2g6MQKGfiPC3CXC08J4SCMfVi8EoPljlcuFuI01PaOxVFHQbEFhxjxH
	 f5aMD9huMm+pwh+WcFc6TWEAInmukOM0wew+XnNtx8iusM+7Mj8sFs3/Ac7FOhXYXIMTv
	 vBCibZvpi2/U0Fsh7DyUFeLS3J7v9bWrVojxysWsybbLHALdlTKAITTrgSMtO2YOYUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793847456;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-Envelope-From;
	bh=l8/0xa3PC32xn5HbMvXsINTXTxxz/3V7tp0GPxGULew=;
	b=OjExjhlOCfxWkjXUU5QMSLDEUv4qE+uYgnL3VmrbXVTm0e+NCs0qqqm1CPEwiZQbFTgQ
	 85AFpMvxViPxyCymIPsNzwB9bj/aIdb1gjMeeRQ4X+sBjEGPpex4UWpQ1Ye/Dc1bSxCRA
	 5jax9yJjrN+T4AeLPdFsiqOKCCijWh/WkW7EmmwuuKcyqwuumJ+YQfbSzWzfbQG/SmI6L
	 5OTO/19cyefaq+3P8DGWaTWKUB44VziE+0K0gJXPgUS/Q4f5t+pqsgts1j7Nl1hHaSHd4
	 TxSHIDtQuQUJQoSmx1sTajGS+5yYUkDmGYJTpJq3woyVAm+S6Lv6+F5tGoMhtHLHfXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tychen.cc;
	spf=pass smtp.mailfrom=tychen.cc;
	dkim=pass header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=PXns6i8N;
	arc=none smtp.remote-ip=63.250.43.118
Received: from out-2uec-a118.jellyfish.systems (out-2uec-a118.jellyfish.systems [63.250.43.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0D7606A333
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 02:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB0D7606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=PXns6i8N
Received: from [10.18.116.108] (unknown [151.145.76.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4jKn6B4hgfz2x99;
	Thu, 05 Nov 2026 02:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1793847445;
	bh=l8/0xa3PC32xn5HbMvXsINTXTxxz/3V7tp0GPxGULew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PXns6i8NDEU0YPdR6SSmzZBfMhMylL4SSMHEJOCAjDv2WIsx73ueFsg3dNgM2oUOs
	 9cvQFjZFtUmoLNQIyHLh4HFN/Mq6G+qYgZMbSAC6ww7kbcaOH9TKe3/djIfr4P+cIm
	 TJYo8isaatovcHfbh6PF4JhvKmRzJh4CAu6JUG/DhtJOmdY7OsO8EsJ6zycG7xRU9l
	 Q8W/7jvD25O8w0juF65wDYA/DcTR4rNLWfqoA5885rpU09ocoLLKzldPMr4iHjlffL
	 hhRGj+h/esJ7fELmi1QuB50OTA6n3Dls3FdooOfFWHh6vaeLVoXnZ1zqSK7eMKqVwv
	 z0UvUZqmU8rTg==
From: Tianyi Chen <hi@tychen.cc>
To: Ido Schimmel <idosch@nvidia.com>, Hangbin Liu <hangbin.liu@linux.dev>
Cc: hi@tychen.cc, netdev@vger.kernel.org, dsahern@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH net] ipv4: igmp: report interface group allocation failure on join
Date: Thu, 05 Nov 2026 11:57:20 +0900
Message-ID: <179384744061.507013.15578905095186813950.igmp-review@tychen.cc>
In-Reply-To: <20261025105743.GA126003@shredder>
References: <179260356668.911829.6576504063198285556@tychen.cc>
 <20261025105743.GA126003@shredder>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Envelope-From: hi@tychen.cc

Hi Ido, Hangbin,

> Looks like unnecessary churn. The failure is not realistic.

I see your point. I found this through LLM-assisted code inspection and
have only reproduced it with fail-nth, not in normal use.

Hangbin wrote:
> Is there any details about the reproducer?

On loopback, I used fail-nth=2 for socket A's IP_ADD_MEMBERSHIP,
joined B to the same group, then closed A. B stopped receiving multicast.
That cross-socket effect was why I sent the patch.

I'll hold off on reposting. Thanks for taking a look.

Tianyi
