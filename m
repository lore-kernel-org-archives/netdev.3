Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793870823;
	b=s6l6Irkg8IHFRtMwuzJE4NAEb6t4sKSD65j3wPDQfzMpdZ5bcTXfaGpNkeV2ifg7NHtq
	 apiX6dscd7Y6IyFgwPzsF/yXlqPhhTxwMQyukv240l7uDckDW0MWdlbnk/t+iBEdVHs0W
	 IikQbToBtLMQHMMeKB1qkzscqVVfuT64seGxtlWGYsNJIJM8HgZBYOy8fg6O2YpRGOt5W
	 ejg1Kt8sxIye5ScMZaLpx26LWyWiwEV/eDU0RDaB/SYH5lu399fUwqdFHrxF7oz7LAJTW
	 v6UuuFu/bqVvB3VaEvJRIHPZA7rEqo/mK8S/6Qrl6gor710l9Snez/ebHKrdrokxHwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793870823;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=xZzKTf//DQYIAN9VwQEvMddExwcCW3dbdXpAj0Adyw8=;
	b=KRqnTnq35p3kal3Gi1ELx+5IdKtY2nNYsFlj7UH5S2x0TMX/zVgn385U4ui+f9h+1sZ2
	 fOopYd8BbAY9hUfXhLW2IOzIbYwbtjpfE1IU9xj2DwoCiJ2SwUuxG1DvXifZmnep3aGux
	 l0f0v98LEOrRbk06dwULiPEvvq3z9QxuyIFVFyDIHkolrREWy7CzhpuHGTKJPDARIq4O1
	 xZwYHAWL/jLtlnk7efBZc7Z1ePcfFdd7OiZPWnT6ZdCakljOlfMQn7XCEVC6GcfCLtQds
	 yu6Lhfcv/YFXqs5QHkxy9tAkvzm97tzttRYU6mN8n9CcTJFGwXY4Ofoga+eBZO9l4LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b2pKC2Ub;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=fHaYctB5;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AECE606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 09:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AECE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b2pKC2Ub;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=fHaYctB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793870821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xZzKTf//DQYIAN9VwQEvMddExwcCW3dbdXpAj0Adyw8=;
	b=b2pKC2UbTlalxXeMydjDn4mD7Db7+cdC3bcjvHaiN4yUZZeoGNz/nLfZIn68iq+SSayXCB
	bP7ZSWCLCNWLJj+kBNimNPdwjzhXdSGKv4V3dvcg3NkDwBm349HGLonEt2FotdfA+5R5D0
	8bhGcr9YlrRqOQFka+6y2mSBbERyX/E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-pwcMn-UBMqW1nIKZIOeB7w-1; Thu, 05 Nov 2026 04:27:00 -0500
X-MC-Unique: pwcMn-UBMqW1nIKZIOeB7w-1
X-Mimecast-MFC-AGG-ID: pwcMn-UBMqW1nIKZIOeB7w_1793870819
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48fcb657f32so1166158f8f.2
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 01:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793870819; x=1794475619; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xZzKTf//DQYIAN9VwQEvMddExwcCW3dbdXpAj0Adyw8=;
        b=fHaYctB5SIwZSj1A3PKQanr9lALpXaILeX/6MjjI404AhOp13dWh1YQif8a1iYbuCt
         ySunMulrJl/RQRuXZoJWi+csEThcA2w2sRxnSkJzuObKEInFuGhts1j6u7KEZQjwc0nS
         iekFHHKNsR9BkG4iI+l6Vs5vQzhdorWMsTZvlGtctQFlRAM3MszCGmgZSA2fYamYGTOD
         bXNig0r2OmPE/0OQJonuA+vmZW2eLXVzEqxcBr06yPf97SsoJbRqk+dHXywiDsC3i572
         b9Wd9BRij5gaYN3Wo/u6N8QsdgxHve0jrvQQU+BC7hNliMTmlXMXCUUnkSoc55E9Sbdr
         Cy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793870819; x=1794475619;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xZzKTf//DQYIAN9VwQEvMddExwcCW3dbdXpAj0Adyw8=;
        b=AdPz8xVeVTYY8Sqe+kLHnSjWiPctV+aA2rwNHe6Nce43gmJBYRMC7GrqrD2qFt+Fg8
         RLyAOwSmBCgWZIrFONL2FpcMILeV9aYXEYBvceZnJixI8PI9UXV7qli9+gFGO8BST25K
         +qFToVphYnT4IMiDJUQYUR4nB/6nFKOCvmXwNDmBVI2scB6R/YFgQIVEN9fBHz2LkeAN
         0UiHCMjRrFCiRJ1Kvrx6wCNre0fEIfc6el1iGNI8yyNN3oKQAWe4NReLBvYNZ5/MJPho
         mNiY2B/uTrPLX+79IEQjQDMjyAf7eUhJYrLZ2jOEmeehO+FwBaz+hrQk9sPLglH3QBN/
         YWrg==
X-Forwarded-Encrypted: i=1; AKwUvBwEZ7EwwHpsO/ywfKw+yodASSQ6De/fc66cH64aDiB5ehZ5RJORi3/Zw5nkbBsDam3HU7NYzXI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/HX7lPM4nRZLqvrfMcLWC07RvOY4acIZS5Q7t49ULKPGZeUNaW
	qt11i1XZfGfYs9b70prcC46dENlIdn9dLf+083ZBcuTL78rtu9M+f2y3DbZrjP3x30dElI5HDXx
	aE8z6GPskxqhAyUq/4D2rAnV0urLqja+Hoz9zMSyTiOAji1yI+j/rni0qWA==
X-Gm-Gg: AYBFou18TJDhV79RARQmTIIRQne31C5fqibC2z1hzhy4cWRKjZw/7cdrnLGU1qlQP5w
	mu+yHPMJCiCW8FqY0juDXZA225xF20SbmSEDfzrgK+JRvszCuqCUEaAEyCn/QFm5TYwssDXvsp0
	GDp9f954VB5r0itAHD0vp9iyoupC8Wo3Jd7IYyECTdveLSTnmKcxgGPAHl823MVZrf5TheY2oDw
	/mcAuzcKPq9u9fyg7Zs/q3JlRM4rqFIo2ZJ4XVJwuLv0KiCrfScky5ykg5uH1YeyFsBxlbWw+fz
	U5VpgZOR+omefBudHHFlfF2HkNv3OUGgZLJ9jTe0BGw3abivaIL8MqTihzoffsj6SXqAHNpdSa7
	UZ4SyU0q2RPwtcBiGZRhMZzHjEMZ9SgipIpwnTk2MfhyvUshyiYpP6I7Oq5WbvtXJgf2A5mU87x
	NZOP7QamRjUXnD3QFGSQ8MDnGT6+uMpud9lR6c/URI8VQ=
X-Received: by 2002:a5d:64e7:0:b0:48e:17d1:16c9 with SMTP id ffacd0b85a97d-48e6e4f5652mr39090755f8f.40.1793870819107;
        Thu, 05 Nov 2026 01:26:59 -0800 (PST)
X-Received: by 2002:a5d:64e7:0:b0:48e:17d1:16c9 with SMTP id ffacd0b85a97d-48e6e4f5652mr39090709f8f.40.1793870818660;
        Thu, 05 Nov 2026 01:26:58 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fece998absm9617108f8f.22.2026.11.05.01.26.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 01:26:58 -0800 (PST)
Message-ID: <679b8dcf-0aac-4674-a006-5af0156a82ae@redhat.com>
Date: Thu, 5 Nov 2026 10:26:57 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/5] net: sparx5: add tc matchall port policer
 offload
To: Daniel Machon <daniel.machon@microchip.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>,
 Steen Hegelund <Steen.Hegelund@microchip.com>, UNGLinuxDriver@microchip.com
Cc: robert.marko@sartura.hr, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261102-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v2-0-3bd47ec1b227@microchip.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261102-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v2-0-3bd47ec1b227@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/2/26 13:21, Daniel Machon wrote:
> This series adds offload of tc matchall filters with a police action to
> the ingress port policers of Sparx5 and lan969x, which are both served
> by the sparx5 driver.
> 
> In hardware, each ingress port has four single-rate leaky bucket
> policers. A policer drops the frames that exceed its rate and burst.
> The four policers of a port share the pass and drop statistics counters
> of the port.
> 
> The driver uses one policer per port, because with more than one, the
> statistics reported to tc could not be attributed to the right policer.
> This matches lan966x and ocelot. The policer meters each frame without
> preamble and inter-frame gap, so the configured rate is a data rate, as
> tc police expects and as on lan966x and ocelot.
> 
> Since the policer meters all ingress frames on the port, only filters on
> chain 0 with protocol all are offloaded, and filters on shared blocks
> are rejected. A police action that is already offloaded as a port
> policer on another port is rejected too, since in software it is a
> single bucket for all of its users. Only drop is supported as the exceed
> action, and the police overhead parameter is not supported.
> 
> Patch #1 drops a redundant prefix from the existing POL_UPD_INT_CFG
> register macros.
> 
> Patch #2 adds the registers used by the port policer.
> 
> Patch #3 tracks whether the ingress block of a port is shared, and adds
> the per-port policer state.
> 
> Patch #4 adds the hardware programming of the port policer.
> 
> Patch #5 adds the tc matchall offload.
> 
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
I understand the following will be very frustrating, but for unknown
reason AI review did not kick on this series.

The changes looks sane to me, and addressing points raised on v1, but
I think nowadays we need an explicit AI feedback.

Could you please re-submit the series?

Thanks!

Paolo

