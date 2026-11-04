Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823280;
	b=SM39aMcuRGE7GKLoRmH0b8hhTHgUmBK4R4E3NmZWWtSpY+Fd+5Qsbjnny6BuJMbJUO5i
	 KR6RGnJ+uBa3dk8py/9hNoj3Blag4p8bUvJjBcjiTFZxLkNXb0OCWeNMa38Jm0eQoUS3q
	 Qkip2581ZsI1Hik+pS8JaHETWnWKY0RmFTxnuAOQsnmRM+Gxuu3fCfQ8joOg1DZVgAVKg
	 sld0NKawL787K4fUx9dzSCNQSMCunJbGYIofs+UNKU409TOS6ekRmp4Bots8u1UKK9X7K
	 VWNJ11nVeAHyN8bvvkc0GQSDA8gM2YOdTPZmRLwmAFTiz5/KpSk7ecOS6M+nH4owEdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823280;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 From:To:Cc:Subject:X-Mailer:References:In-Reply-To;
	bh=nAk9TdoYQsbnhW9OiR+BprvysYmI/LWBbcb+XpKe3i0=;
	b=IT60FxRobSvorz80AtiRCNGZHRpAk9xNHL7Xw9NH0uYMvd1qnPqAXEs+PJxWwBeN/t9T
	 mHCP3Ib4ocXJJvITJjRL4LiDd4QRU2dskJ3C1dH64gUBC49GdSMWKtMH60wM+BUAYHoGB
	 ZmIbeX32d3T4JWgGjCQGozDmVXqz9lYVAAQKAWZVVQkD46pTRQkWDBaS9x3QUwJ3wEtjh
	 T2EAwzMzhWPaw0pTE2U9xmNPcLAQ0DcND0W0cs9X+96ShaQWCSSdCgxmTSTelLhAzZ4PW
	 509HUOgvHpMDWDNtL8pI1TyLXdRTE4QNzstzAnNFoIXXYKNAGX4X6vkcPE8Go07aDVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ql+XRLib;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B0160B88D1
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 20:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01B0160B88D1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ql+XRLib
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so529334a12.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 12:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793823279; x=1794428079; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nAk9TdoYQsbnhW9OiR+BprvysYmI/LWBbcb+XpKe3i0=;
        b=Ql+XRLibDWnQ1LnoQjFEX/qf72hQkbUy+kGN/fXTX2FCPHDIlqSMYkBDf3lVI7MaKM
         VUWVMULjccrZBJ/djTGNKLVIVDpRmRhcEZUUQBwZK4+Rr8mO0+Bi0mkZfd2ZHBPpudVQ
         EPZbDUg7TiomNlcc7z64bbg+e4EE+2sg2iMSx3lmLZVHDo+GZSxXWifh1/SaayVPnaRp
         fgl3Wyi2yHuh+5k9k4PHZmTk2AbYt+1hHwsaY8Jwj4YkXCITgQsAVWUFq+2ocr269ahq
         tZeFIBtfeAQ2FlkWYd0pHUvZGR0OtNpSGdz2nBviXUv0PFsroYvJfhjYOzvU4/UdckL8
         DAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793823279; x=1794428079;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nAk9TdoYQsbnhW9OiR+BprvysYmI/LWBbcb+XpKe3i0=;
        b=yfulojMjY2wY+lPlvXjAQjI2UB+VXjLP5PxjKIrkhgtONfrKyCVqfqyr5a0mWY529t
         k2gFoJ9tYUFmVYfIHQOtSNkG3uZSwibfwWGc4Y9wYAYVHYcIKhUprMUhNGkqQucTsxtx
         RcOFLD3L/ZVE3FV6RH5GlxtQjBmt54tMguucPGDjQcMuEbghkf7oztz9iSCOp8HfYXO/
         hc0qMubAynl4ML8fROykxQPKhFK6rRLknmQT8lTcBfSn+atq4kYZXXzFwuQrqxDmi0nh
         LfxMDcxRUSf3ewCnbyH+/XutXeXmnrT4pBfaZnLKqwnNLC+Q39Hg3tVM5RDjFcaYHt5l
         zfyg==
X-Forwarded-Encrypted: i=1; AKwUvBysUW89DKCm1fH5tY3P/P1skgXoIHbC98CCgB9ZqSfSMar6bug5+ItncyFtJfHk4knltN5+0eQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9El/s5WCVvEZ3J0Z4osHctHbad2GqfmUn1xPTCkdaSEdqdMQ8j
	9PAJtgnHoOmOQt9Q4lWqC5RALs7VpchPLXSmLT6pPgJ/heEz1n7imXt3zfxd7w==
X-Gm-Gg: AYBFou1uPawMNkld4MPp3mFolSyfXaHp3zxVTEe6YaUkumkZRDmteCCY+eR7pwwrAVl
	eCN2RMup/5lYOg2DpJ9sg0taIsaxiRV4eBdpA59RePIWNecHM+MqKpQ4gV5oefjLpDVlJ3cEkZc
	5aia3xrt26ANgvroVyLHxuGyUoBPjBMEVmrM0tn153ITsIqLZ6uO8lvUe+ewti7DIH1yHUE7pn+
	Fr+X45BeMdbzNuP7LahOL2MuK+6MeOYxd8u3JczaVQpgC35dKOMWlOkng6gVWVKyLn+x5fxptlg
	eD0TOEePrZDMXlPy9sWLKMOxF+E9mOAupQzA6jq6lA5P90zdcSiPDAJyWr6iV+OGEEnZPVMl0wu
	cYSv5EYea/pr62REryXW+vwAwbzP0zjeRQFKKVnqRcziItwHeTa9zVgy5cM4Lk2S3BMGMyfC5Ok
	mEF7pMtirOjDYpD9g6qnEpl0idBZoE8fcY50w4l2JEiBcDBojNDCbgE9EoOUEqNenep8OZP8Wld
	OK59nkxPhluj9fglq4uVHelvWwNJ1PA/38zxK/41XP7+qtuqVwDRWG0mEtCF56BXpWLsLniYQ9q
	WjfNedWAbC1UsDxuIRESzqIoeCkcxBZ2JbkpAoRswzz1xyixb2EXl6Pwki8YEQ4kw2Q3pOI8FSG
	i+/tGNSMltMH4CNm6bdOe2q+TF7eEDb3J1RA=
X-Received: by 2002:a17:90b:57c5:b0:3ac:b44c:2d84 with SMTP id 98e67ed59e1d1-3ae897cc815mr14967216a91.13.1793823279118;
        Wed, 04 Nov 2026 12:14:39 -0800 (PST)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b094ce9f65sm2992245a91.1.2026.11.04.12.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 12:14:37 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 20:14:36 +0000
Message-Id: <DMMPA4SE5V7I.BQOTSW259XNA@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Antonio Quartulli" <antonio@mandelbit.com>
Cc: <saeedm@nvidia.com>, <leon@kernel.org>, <tariqt@nvidia.com>,
 <mbloch@nvidia.com>, <dtatulea@nvidia.com>, <cratiu@nvidia.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <netdev@vger.kernel.org>,
 <edumazet@kernel.org>, <kuba@kernel.org>, <pabeni@redhat.com>,
 <daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
 <sdf@fomichev.me>, <linux-rdma@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net/mlx5e: Prefetch packets of upcoming CQEs
 in the linear MPWQE path
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <20261103235823.536706-1-antonio@openvpn.net>
 <DMM0ADCEGAAB.2RFNF1ZI5TGWK@gmail.com>
 <f4bdb8b8-45d6-477d-bd7f-4ca4bbafef7c@mandelbit.com>
In-Reply-To: <f4bdb8b8-45d6-477d-bd7f-4ca4bbafef7c@mandelbit.com>

On Wed Nov 4, 2026 at 7:46 PM UTC, Antonio Quartulli wrote:
> Hi Alexei,
>
> thank you very much for the review!!
>
> On 04/11/2026 01:39, Alexei Starovoitov wrote:
>> can we prefetch 4 strides ahead without the CQE, like gve_rx() ?
>
> Yep! I measured your version against this patch on the same system (one
> RX queue, MTU 1500, mean of 3 runs, gain over stock):
>
>                                     v1      yours    yours + shinfo
>    UDP 512B flood, packets/s       +39%      +35%      +36%
>    TCP, 1 stream                    +7%       +5%       +8%
>    TCP in an ovpn UDP tunnel       +36%       +4%      +34%
>    XDP_DROP reading the packet,
>      NAPI CPU cycles/packet        -38%      -45%      -32%
>    XDP_TX, cycles/packet           -35%      -30%      -33%
>
>
> It matches my v1, except where every packet becomes its own skb, like the
> records of a VPN tunnel (ovpn from a development tree here).
> In that case I got only +4% instead of +36%.
> Dropping only the skb_shared_info prefetch from v1 gives +5% there, so
> that line is the one that matters.

Thanks for the benchmarks. Glad it helped.
