Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9595B2857F4
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 13:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772285619; cv=none; b=s/fJxgg9hTJZUEk+L2lMECjJbK+GQCn76SWjtJUVdRX9FFGO5hz+lAMggMq+FxGU+yv0Ny9jugpktwJQ6DGZwBY6SheuRFQ9eQFpNUWUttvh6crPZlNsiW9f/94+cNdhLugokTN7ABJXjt9ZnElxBSTjLdugpjPmVqjAZ3Gf3Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772285619; c=relaxed/simple;
	bh=gp6pd1wLFrvlv+Ak487hRTVHB348mjPXKb3hetJsyXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CAKsZbnfUH/7BdHflkptldDEyETuPRpyWCDqdDn95tb5axIgVkcIPZgGNVl9tBKbmf2OsjCL6alDNt1Jfc90OfTvnYXHKpXnmPsM09G/eoR8+dtki/At7Z/CgEY6/NGqeN7MWinDlCtfY/Z6lECPcZ8OoGvsL0xon+HzbH6MqbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=a0clzu4c; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="a0clzu4c"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43987b97701so2324603f8f.3
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 05:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1772285616; x=1772890416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AOwo+gr17+PaBI/SlU7H+W7TFawNfdrbhqFXyTJsWvU=;
        b=a0clzu4c0GlFwsvBSuIgUVUJu5tBphpn+/iAoutoj/mQtNRLRk1uSpGDutAzCW1+u2
         OMPGGyMcfEvqpVAIZH/m+6HQMQrWfrqODUY4cMzuyFgSE2eIzQPYuLrue08rSWBhW+zQ
         5ztjLIXrgdodMzV6ceOUV+fvzTaa5GnsckY+Ns7Wue9O0iCaYyqk/Mdg6WMBTe9VTbm3
         Unzs6oGCFo8/ggafMQTkLgoiAPGmTjvFnRoJVRiUaoyRbNILZ5kSb0edcYZxScHICXCW
         PjELlopcD+GUgPk1GKvP+bwoePJxvZGK35vEuixsHGIkJGFUFuT7+3LeFloGGlnDPepW
         CeJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772285616; x=1772890416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AOwo+gr17+PaBI/SlU7H+W7TFawNfdrbhqFXyTJsWvU=;
        b=EZoexovwu8+1ymD3x3bJQbHHPAZarRuXceSxpLPdXucWGNRV5evcmQdN5Ic/fEYD8X
         Gk8m/49N1MeWnI1AZ5gwSF6dAeOhSOc1ZbbNUXOKpbZMzCUY4xkt8WPqhmPkU2zdbAxX
         Z6I2DGZ3Ec4RMy7acFO0ifYnm6Kz/OHZMsAxRr7jLx+c5x85VoHULi2f0PGKH593sp4r
         sUHPONCsvvDRI9TTMxYgRRVvxNImV6qFspog1EL0M/L/kQxapAdFwrovN7qUZRjoOgsy
         7Cb+nv457bksH5xzrayhPR1UeTlMM9KXtuE27jOSse6GDW6wxQ7Klj/F2zBBjGFv0PN+
         /v8w==
X-Forwarded-Encrypted: i=1; AJvYcCVVakGLPb3IlXnr16fiKzcKlKS+ht8K31Pr1O4RVIvbi8spZ+iQFG6AsmowJRv52S9eatGrZT0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/3SvLaYGwptlj4mrBV34xXPr7xNx/5w6deFdABes1l99wAwQm
	INDKfOoKmjaDTesZJe3WSB1q2nOOeyuQK779behBlGa1sNj4LtLJUmMhroL6gSzb8MU=
X-Gm-Gg: ATEYQzzYpfEMUUMd2/Dihg3rTn6FRNkcvyRqB1BFGHtVIzd9Yj6LRmuDRSs0ZVUcNnI
	QTRttk7Vpwub+id+L8uHaTyb16H9OUgUyj08U9QgWQnn57yZMEeKJ8yiH6fNNhnPrrUObldYqw/
	MmOSqh9HZv4lZLjipPp2EWu7f/dE9BfnnVgZQZLtP7OxhlH43sbNlCYkOvE8qTDmRRhSq1AQVsY
	dWWn8OH9aS2XU+g6wE4W5H2MtqusZqCqIg8fZIjiv90v7GKbOmG81SZSEQzFCpJ0mXrfFfv12SS
	rnUlj+kMgQAyB0IG/zjul/h4mHH42qRgsWRRqIXCq4qwuTq9wKf6kVqFoQvomACbKbNiNFSsW5f
	3J2qj6dmrLOfXRrxrTCru6tdkdpkAg08gtlzTLCPZ7baGJK+ZCUYv5zOiXvzZZ2wOiGgogEYLUE
	rkW3FLb4MJWuyGfU1SMMhvb+yBOLLhgQ==
X-Received: by 2002:a5d:5f89:0:b0:439:8f86:e60f with SMTP id ffacd0b85a97d-4399de27794mr11997866f8f.32.1772285615892;
        Sat, 28 Feb 2026 05:33:35 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.73])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c70e8dasm14209355f8f.9.2026.02.28.05.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 05:33:35 -0800 (PST)
Message-ID: <8cf89fcc-f45a-474d-b2fe-2f90352c2ab3@tuxon.dev>
Date: Sat, 28 Feb 2026 15:33:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/5] net: cadence: macb: add EEE LPI
 statistics counters
To: Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org
Cc: davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 nicolas.ferre@microchip.com, linux-kernel@vger.kernel.org,
 theo.lebrun@bootlin.com, phil@raspberrypi.com
References: <20260227150610.242215-1-nb@tipi-net.de>
 <20260227150610.242215-2-nb@tipi-net.de>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260227150610.242215-2-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/27/26 17:06, Nicolai Buchwitz wrote:
> The GEM MAC provides four read-only, clear-on-read LPI statistics
> registers at offsets 0x270-0x27c:
> 
>    GEM_RXLPI     (0x270): RX LPI transition count (16-bit)
>    GEM_RXLPITIME (0x274): cumulative RX LPI time (24-bit)
>    GEM_TXLPI     (0x278): TX LPI transition count (16-bit)
>    GEM_TXLPITIME (0x27c): cumulative TX LPI time (24-bit)
> 
> Add register offset definitions, extend struct gem_stats with
> corresponding u64 software accumulators, and register the four
> counters in gem_statistics[] so they appear in ethtool -S output.
> Because the hardware counters clear on read, the existing
> macb_update_stats() path accumulates them into the u64 fields on
> every stats poll, preventing loss between userspace reads.
> 
> These registers are present on SAMA5D2, SAME70, PIC32CZ, and RP1
> variants of the Cadence GEM IP and have been confirmed on RP1 via
> devmem reads.
> 
> Reviewed-by: Théo Lebrun<theo.lebrun@bootlin.com>
> Signed-off-by: Nicolai Buchwitz<nb@tipi-net.de>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
