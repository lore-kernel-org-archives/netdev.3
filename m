Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E493BED66
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 08:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787818238; cv=none; b=Fd89mAKUi5eET6/WE+QPH8j/jUcfFh3YsnUhUgrPcuUbnngymu0HH3XwL02r/scDjVvraKd9IK7q186oyIqa+oLi2eKT99c1H1jPGUfrdv51mLlRT6vbQIn3iX5bAyeVt8bBYDqHQJHsS15S5VpOlGwlVfo0USHxVs0soy4d900=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787818238; c=relaxed/simple;
	bh=v8DlLY7ma2LyAtWyVwiNsJ5k6Cb0yYYgQsJlQMG0xg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SUwA4OvSb1Rpj4VHo8I9MIX0QE3SSrgKAGzLSkOGmqZis/CG7rQMQTdkf3NngE4HwF/atp1E7rski0KzingUOuqrBW2ji5nnUI4h1DBPwRYVkvqipLNy6/QVOHGDQvVaQVAodR4vD1/KluUhS4eJC5YnvCQTI3n7MPjOIaq3sTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KBIcBuTL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BqJjMqYU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KBIcBuTL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BqJjMqYU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787818234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LjEuQn0GyYN4mR6spCUyGj8pF4DNE5yUhyvyjSUBEAA=;
	b=KBIcBuTLFmfvETNuNjm+YClnbWyh1iNU6VfyNlhMHyy7ravDB7HxtGFqe9GXwa1/LwRVwr
	eHnsFAmubfN6QM2WooHwg4Y7SVNyf12dys+Yzcn4cHT0OxTX0ppqVfrzMeYbXEOP4lGJdq
	AT3xq+tDiXIwXywRNdRSSC+eEAwb5eE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-OsGkzxqhMZCQlqmXudIV3A-1; Thu, 27 Aug 2026 04:10:33 -0400
X-MC-Unique: OsGkzxqhMZCQlqmXudIV3A-1
X-Mimecast-MFC-AGG-ID: OsGkzxqhMZCQlqmXudIV3A_1787818232
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49b7c1dc61eso2232435e9.3
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 01:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787818232; x=1788423032; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LjEuQn0GyYN4mR6spCUyGj8pF4DNE5yUhyvyjSUBEAA=;
        b=BqJjMqYU2/36jLSx9+Pe5fLck42enSGzdoE3bcUpcSOMU6JRdMp44mSRRpmT0uFfVH
         dCgA5t53caeWMUgQfzMGj2/asBf3zuCVwV/cAYzWDU02VTQ13Bdipl2hVMmEUCAF0q2k
         Of4ujqOg8/+pL3Ttb8OeOeG6i2GPCnoYPsAw+nEa/oBd9YQA+LSH1jPNzz/mZRijQ0tn
         Q0s9mKhETN82aAP3KVbzt1r0bQvRqyBY2EcEpQvKxm9sR8uU4VhorUaeFYyvt1jyDKAm
         /ZmcO3hs4hfxrXX6GuXsDNpffE41w3qkBLtnmkmZmfbDiSTLvl2natsjjnEnyP6gxZB5
         HyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787818232; x=1788423032;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LjEuQn0GyYN4mR6spCUyGj8pF4DNE5yUhyvyjSUBEAA=;
        b=BkGF4F01W6BhFbQb8OSS/QkfHChTvNjAtRm2C7IHBu/Vgs6DAhjEHRcw4Ir0hIyPOE
         VRE/lB5E13C+B1wJH8+N5SMtKgeaOo+jM5FQTue0q8nUkgtM7OusbGhMk8GYWo3b92DN
         OiE6eGURmwrkpJzY5je7PKznNfqwFZLK/iRnUvgKqvwIRAu18CZCGtHfgYW03lJjY3qj
         zYhz2i/IiJZJOkd8qz7Am8/Qb+fdX0KeQk6+VKkyRE/HJvxwH7/U+nq3SjoxSjC2MO+7
         2u1bUCL+OFwCm+NCHkrMzVXoElAF7q1ZGuTlhdNqFcKFdBLIsQckAmVCZcYli4PmYTG+
         pbjA==
X-Forwarded-Encrypted: i=1; AHgh+Rp6dpy8bkjKSmO9uCUewNNkzYzcy9+p3NlY1IdWA8ace6spRH8xx/BApksfColulyb3Ka0qm2E=@vger.kernel.org
X-Gm-Message-State: AFuF++kyEbVSKLk/oTyHWWIYu3u2y+eOAh778/KRLWLDdqN1Uu2AZhYg
	7Mq7rTyXzkuogDUAZpF529lhV+cx6fNIyJ8MEdyINToFPln35VuzZ6JnWxERMvMqakpasEIscNB
	/Zn8sxCpGSxWbk6CY5gyW1X3TujGXHiYIJYrikzZSLr9MCDsk4Q/jDEfCxg==
X-Gm-Gg: AR+sD12MknXDYpz/WJcegr29xinfR0p/DDYKAE1ZWYXUCLSHaFlnajvsIIvnsNC5Aaz
	XKMi53OYfiXFcx1TDyJyp11UkwEah+hIRfSgHX7n4mcAI100Mt/tsA4Yc5ouE8PZQ8HnvXMpe/O
	kOukFdXC/NvBrBSGtSTf9tw0AawY03gPNoKWkTftUclWGcfCbXcs6tjJ2JqpeeFcXuqDy6lILtd
	tLbKS0xYdFd98S1dnPnZxGyQfNV88MaF9pzo0CUatjJKJMuRnJo1qFksQNa9X46ruADLpa68iwr
	8ppaWi2VBbrqJSnT1Sfx2YgXvv61HQaou5SW2gQ+Pxh331M1w887bnC/fZypRwVHdR9nbEEIUgf
	gsesognmFfoPz0OtKKSzyV2K8U0jsrKhUyGRFLaoImGgrymIGr/zPOH4Jlt2ixSbas/9y6nQ=
X-Received: by 2002:a05:600c:a43:b0:497:fecd:5b00 with SMTP id 5b1f17b1804b1-499dc717e27mr129887115e9.9.1787818231663;
        Thu, 27 Aug 2026 01:10:31 -0700 (PDT)
X-Received: by 2002:a05:600c:a43:b0:497:fecd:5b00 with SMTP id 5b1f17b1804b1-499dc717e27mr129885015e9.9.1787818230497;
        Thu, 27 Aug 2026 01:10:30 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499dd56acedsm61647295e9.3.2026.08.27.01.10.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 01:10:29 -0700 (PDT)
Message-ID: <69d874a2-dc5e-45c5-8f94-418d5a73e738@redhat.com>
Date: Thu, 27 Aug 2026 10:10:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: fec: support RX flushing via an ethtool
 private flag
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>, netdev@vger.kernel.org
Cc: Wei Fang <wei.fang@nxp.com>, Frank Li <frank.li@nxp.com>,
 Shenwei Wang <shenwei.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260825091908.1362677-1-alexander.sverdlin@siemens.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260825091908.1362677-1-alexander.sverdlin@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/25/26 11:19 AM, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> The FEC controller can flush the RX FIFO of an individual receive queue
> through the RX_FLUSHn bits of the FEC_QOS_SCHEME (ENET_QOS) register.
> 
> RX flushing prevents frames in the RX FIFO from being blocked. Blocking
> can occur when the frame at the head of the RX FIFO cannot be forwarded
> because the ring it is associated with cannot accept it, i.e. when the
> ring's RxBD[EMPTY] is not set or ENET_RDARn is not set. When RX flushing
> is enabled for a ring, such a blocking frame is flushed (discarded)
> instead of stalling the FIFO and holding up the other rings.
> 
> Expose this per-queue capability as a runtime ethtool private flag
> ("rx-flush-qN").
> 
> Due to erratum ERR050395 (observed e.g. on i.MX8QXP), enabling RX flushing
> on more than one queue at a time can lock up the receive path, so only a
> single queue may have flushing enabled.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
## Form letter - net-next-closed

net-next pull request for v7.3 has already been merged, and therefore
the net-next tree is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Aug 31st.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

