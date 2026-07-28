Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5456D3BE15F
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 11:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785237181; cv=none; b=XbtUBYIUVxJkvL+vZfcJNC/P+op1J4WpThRWZORcKSAl3ALd7CF9wqddTXpQ1FvFprJgp1Cj3stDWKvAN44FaAAS2K6zwu4LjlXQQH2ORbFwB501hLTLzyu/+xk6a+VJ3PijoQEwuaFLIVNA/EjeMU1nSxZJ3n8bIjEztVqOgSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785237181; c=relaxed/simple;
	bh=FcJab1d4wKaGbN1K5L45zRsnPXHEzhNKKaHhvSMpD+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UWkJ/CqErzLdQLxH7S0Ej3YFpkMWoWMH3YK344SngtM97x30FL0bwWbGgeeGL2b7ILNzR3uj2H23i0EDfPS19AVL1QkTOApkGtCGDaMWgVzOJvMMxeQrBZKKbv1HvzeiZR1QGcKmibFGuKOv/Vu9msaxg1MqkG/81XCtWOTESm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hzvTGV2U; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oPaH6jAI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hzvTGV2U";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oPaH6jAI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785237179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bGJ4Tg+9r3wkBe/ueTnI9a7CbdUxzDkZ4FWsmLQCGUg=;
	b=hzvTGV2U6OGUgr259YlAdNfR5WAVZ/SyNmOt115sQ5e6W7QdIzoNfLQPSxmG7ySwBHmLFm
	5b9G5vcMBWWPnYS1ezJhVhS0SuuV21MRReR+1vWauv2gZ7gkFrPRDM1EZaL0pNm9W2SshW
	lJKoOudLkxtgZB1U3zU/8cA1tnxRDOM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-GFZvBmPLPr6ilH7_EGditA-1; Tue, 28 Jul 2026 07:12:57 -0400
X-MC-Unique: GFZvBmPLPr6ilH7_EGditA-1
X-Mimecast-MFC-AGG-ID: GFZvBmPLPr6ilH7_EGditA_1785237176
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-472c330e555so2178315f8f.1
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 04:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785237176; x=1785841976; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bGJ4Tg+9r3wkBe/ueTnI9a7CbdUxzDkZ4FWsmLQCGUg=;
        b=oPaH6jAIwNLNEtjenuiCD3nc/tZv3VsHe3ox0GHjmvj47cjy31RfdTg4qKuvf23ryi
         EYAU4ufqzJk5tRNbe4zk+PY7Id1uAcjwtS+DP34dJID0lFE45IKAOqk15BYp04UjSB/x
         mezhoOmDvpHK/eb37AyPcrZ17uWJn1blPYf1p1x70hT388jjiBuzrK5GzmtzvZncQ3vJ
         3FnEZ4UREK0YI1DNSiQusKZ1hDbNj2yHvvtdffdk5J9xbGmOcW4GHtb78p0fFe7MKQJF
         hlVJ7DBFxKO+IdvFXFL5uPJV0/9tWHS0XYODGvnyrZ9te5pRaMhTTH9q7LtFy0/fSnFv
         LC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785237176; x=1785841976;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bGJ4Tg+9r3wkBe/ueTnI9a7CbdUxzDkZ4FWsmLQCGUg=;
        b=q2w/W03COiR/o+HsWu6BbC3nUeAgPYIV4IrG7h4BaFar9KPF4noaqh/HU/12OTwaEl
         NK+d2rjwuFQtj/UXZKHTH4d7qpNeiy2Ud505sY4vWoQCKmMdBR1AJp+fy7m6qF+TPiwk
         rFbRIVz8hZpgnJFmkTvP94UmWbc7MEq37ZeTIbawg23ZKusfYqsGxbk3kF2vr9bCV0Hj
         7sHoQclhI1QmHjTB/F+YXAnmG7ClzHt6bpVbIisKJj+UqA5aYNLh2Tx8eXnFv/eh4CFS
         0QtmcOQ5KwBrqgHGPSPGO9r7CWGwhJM+gMTRDTWLBtl/REqz0Ib1IEiggFuZoyYe1EKr
         epwQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr398uvoHusOzMAv8CtMO9K5WpenSYqlJ31qaSQmBvZEvWhEcPuS8uJtIMI4B4U3vApgEv0WYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsY/9TO1DS4p6ZP5SQaRTjCrFf1lxzTEMY1tOKtbFQ5DfYWXsQ
	19SHmcYXGX91Fs7UqQqrxMRnMMQEqgToGlsIY+uNOSbw03hiFB3a09X1VaHgMIUkmtwRV//IaHA
	KY+UcFbMBzLJg1NUIdkiFSwRL80gNmm4tUhwk5YxwkcIEe3HB5u+CXt8/VQ==
X-Gm-Gg: AR+sD101pfIA9jilVSTofQcVm7pdb5VjtG0YhXJP/yKIn5KppuRKQEDyfLVd2XrbIv2
	frs2r4QL8wjiZJvxwTD5roL6sNb+QUQonYLCxvXLNXBOksLgJX/7M9vQ6NtW1jVgftmnDI7h+Wg
	0MqqoNQxGZ15IBazdZG2YrQejRU3zaZqjYvdECjLtemaiCiz1LPAB1XctgtilThr0e+tdbSjk+U
	HstCvSkHY8/qrl7RT9uxIDRDmph6DWe1R5F4GkMOcCk2IDivBSOOjg0Le5fFIdAkPTeTDjBFwON
	RQ1u68dZlmUmBDkJYZKi2LJEiiwZPro2xPVpfBMCnKtdrqmvvI1TdoZvnhQP5K4JRS8ZaHb8vbj
	MTMPowGpntr5v96HY+9aBpUOMAEW67jbN8bdf+9VDFgQlH5yADvLHs0jfz/S4T01rjgeygpDa3V
	xKjw==
X-Received: by 2002:a05:6000:2884:b0:47f:48d4:3f0a with SMTP id ffacd0b85a97d-47fb1edbff5mr2084115f8f.45.1785237176379;
        Tue, 28 Jul 2026 04:12:56 -0700 (PDT)
X-Received: by 2002:a05:6000:2884:b0:47f:48d4:3f0a with SMTP id ffacd0b85a97d-47fb1edbff5mr2084084f8f.45.1785237175988;
        Tue, 28 Jul 2026 04:12:55 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb5a46sm56864881f8f.9.2026.07.28.04.12.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 04:12:55 -0700 (PDT)
Message-ID: <1f22ab9b-7951-478e-9271-3d659e991ea5@redhat.com>
Date: Tue, 28 Jul 2026 13:12:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/3] arm64: dts: renesas: r8a779g0: Add gPTP
 node
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "DavidS. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260721132936.1331318-1-niklas.soderlund+renesas@ragnatech.se>
 <20260721132936.1331318-4-niklas.soderlund+renesas@ragnatech.se>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260721132936.1331318-4-niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/21/26 3:29 PM, Niklas Söderlund wrote:
> The gPTP module is shared between the RAVB and RTSN Ethernet devices on
> the SoC.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
This deserves an explicit ack from Geert, I think.

/P

