Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F303B28D
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 00:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788828622; cv=none; b=fvdfZoc/IP/ikm8cefPnXOICrP7jmfmg/ikQijzUPN7ApuhlxLXuoJx+N5p7VI3Snmuk2Dqhju+vj8b0XMTtUm+BPB2A5XfrACvKHpnGMi1zl+cD5qYiCf+J/nfVU9J9aO0JCXJufxto3vAGvWF4JURh8iSDc6OF7rzvVpTCPuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788828622; c=relaxed/simple;
	bh=Wp1bW1JKpA2WILd44Kl7bIaimSLpMkMNIYC1VMhh9so=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=oHHbVyGdmD+lHiaaOhZkRL0LoBeZp8KEl9p95ni/vS6en56/TSvxj4jghWhqZt3hZt8vtBb6vcilJmG25Lgk4nThTBpZbjyrwd/VzRUz8XdkDmEKIKt4NSbK5erT6Y0+JwNWBuBH+Ydc214IX94p2HbDQ89RQ/I3+gjrBs6u0Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdMYkeSy; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdMYkeSy"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-836c8bde2dcso18805817b3.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 17:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788828620; x=1789433420; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wWINRTmBNL5BC+rpZDWiCf8CPGPbAJz+2FvHQTxo+PA=;
        b=kdMYkeSyfc2+FeSJhRAjbVpROkuVff92SlTPE59RlzSajn2fS6xanbL8xD9/5qGPIk
         1bF8AujGsBy3NMZVT9zlGm2YF+/e5s25j7qmnQ+qOlR3L2P/JrcvsxldJacNkkaFqZHC
         0uxx9gayIL0f8YX3S+1WstsActsTvRbcLoTlCvM+02/oybe057OCTmmnhQWRaudlMRDR
         uPWs2T7OJHoioCwkREm6WIn1y0Vo3DXW2CQmrrZbGHdO1Ah4JEgcy+YKXZzNFTWSHwyM
         +Ft18Anre337Bhhn25QTe4abYKQVgLK5d332iyydwYBqd1d/7nYlpP4Q8nQkT76oJogY
         K8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788828620; x=1789433420;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wWINRTmBNL5BC+rpZDWiCf8CPGPbAJz+2FvHQTxo+PA=;
        b=S7p2TI71Z+0GXD39/OjJ4MqYJDq2IzKF6sFa4tyPlDRBpFgUyGFoRuy+w7n0sDHsah
         ndLQINLhcgLtHcJuyheUqG2ew9A7QK79YAzLt3Ro3UiKQgDDDH3YlTk6xGtJ8AGxEFfZ
         U3rn2nevCnZQ7/RVo2p6o+ysI/BCULp+CBmDn7/zXQSq5OeGAxl0y44Vq651+Yfp+BwE
         NRmLqRTi0hr+lNs5Gd7dqbM97HbRD63HA9MoLqCuHmmAfqKJNwOCwJtnVQ4/eV8yCPqc
         rybF8aXekbcNw0Bd84vh4IvFJ6SDtDlJX9XEeb2AO6zIFAKWAdDJTRTjH3dGZz6RO0wG
         8/xg==
X-Gm-Message-State: AFuF++mpxdQjMNPI4JokMdvmJOLq3TMBywNStKSAHM0pLh0Brv3LvgcB
	AtDb1iMCh/SK96TC8ZbejqTPWhPZoOBF5L0P9wanLVWbWbIkhJri8vE0
X-Gm-Gg: AYBFou2mbYHktvKj9X5PnDZ8StxW7jtMBkPGBJfI4JjkmY2qgpwsgVBuMhM0FNgwGQU
	NBydjGqsemoqTM6fEv6jEjKaDml0QJF2vQKgyllK+8GmTYJ26YPNmrqnYjyG54UFsX+rSdzRxDe
	VYu30KaqTu3qMH6yN+GYXEhsaUCPKlPESqHuHt10Tob+z60HpB4sx0+jjRKXNsUlXvbTeDLrpAV
	2EfuExzgPvYuJTriZJiqx05UnW4mvsvsdy5ROq6UJJqshv4hiQ6gnNlhCkT5EcCLtjM1iOY9KXK
	Goi7ITZRB3FygS4b2z1XaAEv9OaLFR/YezcZpKDLMbg01Mf1vQ8tzYG5d+DP15ll6a0218EHi3n
	QmL2RAJyS8b2pBAqRALqBxe1k9OQBb1uWO3vVjQEhAlqhLef20dWzFQhgCoKaJ3ifHM43/4+y3e
	1816JestEch3vo4LN5WTPTy00PUQCCoz1LB2njzEWfmZcsbizpshWBSc+bC5YTMZ4njMizBPnAn
	9KaMl6YFAaj47+INR4bz89+iP+q/mn9uAof9tbbZQ==
X-Received: by 2002:a05:690c:39b:b0:833:968e:c223 with SMTP id 00721157ae682-871263d2d51mr91733987b3.21.1788828620533;
        Mon, 07 Sep 2026 17:50:20 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714ab73f23sm80140157b3.33.2026.09.07.17.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 17:50:19 -0700 (PDT)
Date: Mon, 07 Sep 2026 20:50:19 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 andrew+netdev@lunn.ch, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.19b10eb6885cf@gmail.com>
In-Reply-To: <20260907161258.2b0b421d@kernel.org>
References: <20260902181747.2483351-1-willemdebruijn.kernel@gmail.com>
 <20260902181747.2483351-2-willemdebruijn.kernel@gmail.com>
 <20260904160106.08acccb5@kernel.org>
 <willemdebruijn.kernel.173115664f973@gmail.com>
 <20260907161258.2b0b421d@kernel.org>
Subject: Re: [PATCH net-next v8 1/6] net: rtnetlink: add
 pacing_offload_horizon attribute to net_device
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Sat, 05 Sep 2026 22:22:06 -0400 Willem de Bruijn wrote:
> > > > Perhaps I don't understand how dev->pacing_offload_horizon
> > > > would function as a boolean.  
> > > 
> > > The only uses of the new value are:
> > >  - as the qdisc bound, replacing the max_ value  
> > >    -> Leave the qdisc as is, let qdisc config define the active horizon  
> > >  - in the driver  
> > 
> > I see your point now, thanks. A flag NETIF_F_PACING_OFFLOAD?
> 
> From the name I suspect you mean a feature / ethtool (-k/-K) ?
> That would do, but presumably not as a real low bit within
> dev->features ? I guess it is a datapath feature but somehow
> those bits feel too precious.

Makes sense.

An ethtool -K that does not use dev->features seems like a hack.

Keep the existing ip link attribute and make that settable only to
zero or max_pacing_offload_horizon?
 
> > The two configurable offload_horizon fields is definitely redundant.
> > I do not want to ship idpf with the feature on by default, because of
> > SO_TXTIME. But a boolean will do.
> > 
> > Plus, a netdevice_notifier in FQ to clear q->offload_horizon
> > - when this feature flips to off or
> 
> Not sure if we should be clearing user config or rejecting
> the feature change if currently in use.

We cannot reject the feature change, if it's a device reset and on
re-negotiation the device capability changed. E.g., from a firmware
rollout.
 
> > - when dev->max_pacing_hardware_offload changes to a value smaller
> >   than then configured q->offload_horizon (e.g., on device reset).


