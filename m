Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC912D8762
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 07:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784618546; cv=none; b=IXn9BhyUoTIerX6H4YWuO5b4zANeq2+XXa+UfBbFy+kTVeI9OjjxS8xVqstJOCgDHoiWLkj/QlfS20dIAY7vIVa5LtMjp9DGebzoa6AExPAvZ2Y5nqbWFAnLxkM0tBWcQZliPHS+LpmViBfg6yelb8W3Wq+K/0GgpmLLJoALw7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784618546; c=relaxed/simple;
	bh=+UcZ8psnLF+IpdP85Yxo7cW+Mz/KS2qhLJ2rha4CNnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L5HTNxYEATCMuFkWucM8IanjXR78ZZbkF94OtGbCNzx/pTpTVSqB5dMZW5iM7jMfHQ/kxU6AklJyUaUgdEbHqgNzt2Cy/pPa0XRyTpVt9fh73vD1mCIuKSEwCnPQBLMtIg6pZiwNkAV7ACO+eo1WCEcdKngYNwTkcFpSiaAxSf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NzbQXgP4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JUXjMMa7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NzbQXgP4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JUXjMMa7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784618543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EpnAPb+szKsxLDLw8+sBnpML2P+PlPUb+adSl0ccDVc=;
	b=NzbQXgP4SwXUnfIMz8zw8NTbBqP0RrnL489w9b8ZGO+tGzamFk6Y1CS9la1E8dFS1a4YP7
	7VL5I1YSAdQHOn2wzU4Ty36b3gEUJSW4gYgxw7uy8roeScMm2BoGd8bIeCrvT91JyXxw87
	CxVzU6usvJXTcc0WCZkZtefIYJXM+58=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-_4eQj-wdNvKhgMYY6NTWRA-1; Tue, 21 Jul 2026 03:22:22 -0400
X-MC-Unique: _4eQj-wdNvKhgMYY6NTWRA-1
X-Mimecast-MFC-AGG-ID: _4eQj-wdNvKhgMYY6NTWRA_1784618541
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-473e18559b2so5012374f8f.0
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 00:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784618541; x=1785223341; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EpnAPb+szKsxLDLw8+sBnpML2P+PlPUb+adSl0ccDVc=;
        b=JUXjMMa7kIOld3Hk1soDnL8j6aDUfJB8XVMEajyYO7gl3j1E2NH3pTUxWve0RFvJ7l
         /UoeUa6X+bCZK2nKO/RMIXJUM6Jnke2vC0q0T+I49AqjF+/EC+vKYA8RfrJILj+OVJO2
         6BzYAPMBJhQkirYQjRCfj3tKt1kaIkZIXALDhNIkUPuq/RRqsw2M24RASljBk963LzGx
         LWERBu6gO4cA4BBeNVUPfM2tAjqGY8oueCB3X82mBnTAqNcrw+EFnVvgVMVSf25NwiAl
         3DpIjfzo0PA4gkhse1Ct/dQVi/v04dogUAzRmmRNm0eGJfm3DSZ23/euPdBT+YRYk8Gr
         WSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784618541; x=1785223341;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EpnAPb+szKsxLDLw8+sBnpML2P+PlPUb+adSl0ccDVc=;
        b=Nj1uEnu8Tn8T5truqh5N4aTFSsDXWVUpMmWXENkpJ8Z4d5yWQ4+6Sw177o0y+aK9qC
         COOTAlZM3Ncr2FKGhZzIeAN4l81gBkGme5NodA/BhXwpQaRJZ2AVQjgZG/M+SqqTk5hs
         QgGX2gdvC6u0jjlnSpb8rKtAv22wFcdgdeSkUu4TNN+pGV1A1paci1cGmf5ljRUzz3xh
         w7WFRFMgvW2nem+JjesPO3w5AsymJyUwG38l4HeRmSyCQwjiDqUlUKUQoTAge0JMH9dh
         dH3YdGzDYv6VWqwepr8Yc5I4bTaAxEjWXIUowiXviVzoXnFbJd3cBlnQiXNguo4cMVmE
         Fp2w==
X-Forwarded-Encrypted: i=1; AHgh+RoTn1oQF4ZNE94kJLkzeo0bmJNrl0QoFh6wkBFx6qgDyqhhbqS+/+wUSPHVrYQWjarw3XVqbGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/uVDPTOA4yauy8aJlBP+1WcQSZWlaUz5ObaMyrtRe8H4sqJX2
	NpkPMpdU8J37yGgbNPu1b7+SPbJBAqIthpinj0lbOTLMSiYqZpxD3ZpSPsjImO+m9yXNlPT3Un3
	wmiij9WuzZYoEOTKo82YqGItNlIbb7o5yDlga2iOkdbnvc4ZWW/UZCTEt7Q==
X-Gm-Gg: AR+sD11RTLq1knQJudFYK2oilp2dghkpmAW+ZrdmyYjydyM7+s2E5HA4KCuxzDQRmw7
	4XQfe80y/n4m3e5sNlz2UDyR/bYE908Wfsow0n7CIoXTbI7aHvgeRsHH7s09OWB3TNe65ro3yWm
	63aN7FU/8IjQOoaoGKG/7+R6Ik8j5NXeTcPOpiLoFVJuWkVzrMKi5dXdWL+QyQg2/syBgCRK6Mg
	cZXLKsMyDfuud0QLzigHkSbBCA405rvyf5rhYwW82RLTPW8bvMR3mpfCuQaspDrWw8vU+1fuJxC
	Ecu2IDhB3vvkNLmmETyfloAbDUtWNE+NbJC3qmKFU5tQYappOVdCJlWtSuv6nMNHcp4DkvLaMdp
	JJh7PFNm9RFXbvi9R/cRGy+1js4xFf7KRasZzd7dThWTqVjUGXXDnt+WHixwwPMho24GyNZ/2EU
	ZEaQ==
X-Received: by 2002:a05:6000:1842:b0:47f:7067:395b with SMTP id ffacd0b85a97d-47f706739camr13726477f8f.10.1784618541076;
        Tue, 21 Jul 2026 00:22:21 -0700 (PDT)
X-Received: by 2002:a05:6000:1842:b0:47f:7067:395b with SMTP id ffacd0b85a97d-47f706739camr13726429f8f.10.1784618540671;
        Tue, 21 Jul 2026 00:22:20 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ec7f55sm32452689f8f.18.2026.07.21.00.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 00:22:19 -0700 (PDT)
Message-ID: <d3ce71f6-042c-4a5c-a4b4-8efbb451a449@redhat.com>
Date: Tue, 21 Jul 2026 09:22:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 0/4] net: stmmac: eic7700: add eth1 variant
 support and update delay bindings
To: lizhi2@eswincomputing.com, devicetree@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 maxime.chevallier@bootlin.com
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com,
 pinkesh.vaghela@einfochips.com, pritesh.patel@einfochips.com,
 weishangjuan@eswincomputing.com, horms@kernel.org
References: <20260707064033.1265-1-lizhi2@eswincomputing.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260707064033.1265-1-lizhi2@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/7/26 8:40 AM, lizhi2@eswincomputing.com wrote:
> From: Zhi Li <lizhi2@eswincomputing.com>
> 
> This series updates Ethernet support for the ESWIN EIC7700 SoC,
> including support for the eth1 MAC variant.
> 
> The series includes DT binding updates and stmmac glue driver updates
> for the EIC7700 Ethernet controller.
> 
> The changes include:
>   - Update the tx-internal-delay-ps binding property from a fixed enum
>     list to a range-based definition, and make it optional with the
>     corresponding driver update.
> 
>   - Add support for the EIC7700 eth1 MAC variant, which has
>     silicon-specific RX sampling behavior and TX timing characteristics.
>     A dedicated compatible string is introduced for this hardware variant,
>     and the driver applies the required RX clock inversion handling and
>     timing adjustments.
> 
> Due to silicon characteristics, the eth1 interface has a fixed TX
> internal delay of approximately 2 ns and an RX sampling skew of 4-5 ns
> that cannot be compensated solely by standard RGMII delay settings.
> The binding models the effective TX delay range of this variant, while
> the driver handles the required hardware-specific timing configuration.
> 
> Only the DT bindings and driver patches are included in this series. The
> DTS changes are intentionally omitted for the following reasons:
>   - The HSP bus infrastructure is being introduced by Pinkesh Vaghela's
>     DT series [0], currently under review.
>   - The HSPCRG clock/reset series [1] provides additional infrastructure
>     for the HSP subsystem.
> 
> Once these dependencies are merged, a follow-up DT series will enable
> Ethernet, USB, eMMC, and SD across the HSP bus.
> 
> Reference:
>   [0] https://lore.kernel.org/lkml/20260706081055.1126275-1-pinkesh.vaghela@einfochips.com/
>   [1] https://lore.kernel.org/all/20260605060730.1605-1-dongxuyang@eswincomputing.com/
Applied, thanks!

/P

