Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E62A4E56F0
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 15:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788450319; cv=none; b=t79B/1n7jBbAT35i61QXcNY+984L/8uooG3UhR3oO9xrbxdp2nkBEpUT2SIHNYeiwn0nKn3yrdlZcSzZfQCsrrhWZSfdv2nYzkG5F9nigEyaoAWukHAQEStp+04iqTerp76osDM9tXkHie8f4+5GexB84PxQte3i5ZRz6LuXCjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788450319; c=relaxed/simple;
	bh=wNbZo52/jCuXUnRq9hwDsnLal9ayYeRAqN3lGb9tVZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=N922KVPTjViZ39L+4qOmwoMfuQ/HcEFs2hrs1fRnaWpda8mx+yB6h8GhOsRDqAwDaASEZJsZOuKYEL3XL6/kw7xsScDigAeVxSJqY+fKKwMN5qUtIszy54iE27TJHhcpHxLfM7GpShTC5/woRg6AWRW9fn9rBIB4XBd/3goVPkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dsXEK9oz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MeOfvMEM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dsXEK9oz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MeOfvMEM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788450317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nLnpM91lg5cKjPDt0j7rgsNLagyFY0gB25r5tI9lEhA=;
	b=dsXEK9ozWqXUv7ziM2qDp4mD1Wl8FXrwPgjJd0vVepouqOPnAd9xAR+MGqXVT7MEheoJTG
	nuYI+v3uruNecry0lHUeNrVI9542duVAwe7MTGlp97GzupsY6bQrjk0nBasR8Jd7CnRU7L
	VIMcgcsxZCRkn0fSoql8KNnTrUOuO7A=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-nrBfQbvENLiai2r_VLv5lg-1; Thu, 03 Sep 2026 11:45:16 -0400
X-MC-Unique: nrBfQbvENLiai2r_VLv5lg-1
X-Mimecast-MFC-AGG-ID: nrBfQbvENLiai2r_VLv5lg_1788450315
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c24ae1a510cso255078766b.3
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 08:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788450315; x=1789055115; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nLnpM91lg5cKjPDt0j7rgsNLagyFY0gB25r5tI9lEhA=;
        b=MeOfvMEM1aJHH7q7itcAUahtutfuYcctyC59ldTBGeV6ZF4aiTP7IoqxD0n2g6XUTc
         OdD9OBVOZtEcBgXT082rwUlaMyB9t1una2ocl+LlWu4EG8cXIyJR6uMGTp5Z2ssifAci
         y663oDIaTa8gU6esD48Wsi8c7d3xotVDrrYsQdQPtiytAozb6NZQGphw9eTmH4X4EIUL
         dhDK15oTmG/fYEMDCHlVrHv4CNoqLpaVQKtAIQVySa2TSa8jD+cBrkmQLuwTuMJwP9b3
         fnIgKax6bvfQdUCPLjqdCLFalmvsDH+ffDUphQx2fZxg5074GHOdICH94ArQ7abh4dC9
         c3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788450315; x=1789055115;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nLnpM91lg5cKjPDt0j7rgsNLagyFY0gB25r5tI9lEhA=;
        b=oVzmoXqDwVe4CPDxJluI+dz3Q22uVjz9CdGDAYzTtW9SerbOPNCpQSKjoRw0EocYkP
         wkod1gxF5kQw85/1qb+BEkX2kK9JMsTiAh0SPo4LhaISD/KuGYYnEC6IkCGbli8VB2f0
         jJKYOVxbADJH3qcEpTvNZEz0dNFfzmHk2jW6WL2+qKB/IKjgcWNq0McRl4Jr4KFtEOwx
         lv7RUPrs0cHTTU+FbA9MVJ2TbtCq6CXHv6M2N1J88/7MZEwiz3cGZhQH1811i8Ciu3zN
         hHIH92HqlUJEsTM+zO9QhM9UQFW1uKCsXcHuoqkWsWiWspc3PhvvKY9Rj/MgG4v411B0
         mVXg==
X-Forwarded-Encrypted: i=1; AKwUvByzfaUhqCgTFFQP/Vtbnu65OBgFUzwzjshYnmcjRzNpDRpB+e48LjtOUBpTdt+S8NEfeAUnyDQ=@vger.kernel.org
X-Gm-Message-State: AFuF++n3QeDgiv+B3RvXmyzQTzj/o/Q4zdKkTMO+RdprlmsO48fz50fe
	3vvDARTr8kMcjk09NyUhVRYGWIe4vbhVuA0iP7W9bjGcXPpq88TuGbw7bIjowWY1WBSSuvTlU/P
	5W7vflwOueMkLHrwbMAKta4yFnyz4CJEqa5jFrbG1oGc2zq2T+FwcoMCiog==
X-Gm-Gg: AYBFou2Ao/fKfpc/Y+oWIXiY7MiYHr2Tlz/cSN/yz3miwm5TNJLmyKPkjrrkZ2hqUi4
	HJ5hkx9vy/qqLwUZxLye/w4MLngWO4I2zqSMmOQrnsiGiwwUJLeWnGJ4zlKE2GaP1i2nV2zwLeo
	3QwRVF0MFCAkFBGbocATLIlEwIU/wD9dGcimhNlho4haYRjAD8DWJ0n77XvKURYQxwRFK/r8tW+
	yU3dseoCK5GxYhMzpt95FXXjPaAnjAU9koT7xktih1zUnEsUHgdrLrC7eQSRIl9GcBrvvhTuAlP
	yzxde7aPgiAsyf6B0diyb04VrM4Pnd3GwxJJG9deAHY3hn0XAimoPnnTZGtkw7A83J8HE69jLBu
	HeN3CD2qaf9hoCn6CfauuknG2M2J9hN5aomyl9t1DvtWB2QR45nOU6sHojtecUEM/MNGKNWsyuQ
	==
X-Received: by 2002:a05:6402:5515:b0:6a3:ee60:b13f with SMTP id 4fb4d7f45d1cf-6a6829aeb56mr9034742a12.14.1788450314613;
        Thu, 03 Sep 2026 08:45:14 -0700 (PDT)
X-Received: by 2002:a05:6402:5515:b0:6a3:ee60:b13f with SMTP id 4fb4d7f45d1cf-6a6829aeb56mr9034715a12.14.1788450314163;
        Thu, 03 Sep 2026 08:45:14 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a67f94242csm2510375a12.21.2026.09.03.08.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 08:45:10 -0700 (PDT)
Message-ID: <81bd9bf0-e9ae-444f-ac96-a341ae7faffc@redhat.com>
Date: Thu, 3 Sep 2026 17:45:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 0/6] Fix a variety of TPA bugs
To: Joe Damato <joe@dama.to>, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 kalesh-anakkur.purayil@broadcom.com, colin.winegarden@broadcom.com,
 rukhsana.ansari@broadcom.com, linux-kernel@vger.kernel.org,
 raphaelcf@meta.com
References: <20260902015652.2421609-1-joe@dama.to>
 <bb4ae7c9-e705-4eff-9813-065ea4bd9514@redhat.com>
 <apmQGp1mEhQ1EiEb@devvm20253.cco0.facebook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <apmQGp1mEhQ1EiEb@devvm20253.cco0.facebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/26 5:19 PM, Joe Damato wrote:
> On Thu, Sep 03, 2026 at 11:37:34AM +0200, Paolo Abeni wrote:
>> On 9/2/26 3:56 AM, Joe Damato wrote:
> 
> [...]
> 
>>> I boot tested this on a Thor1 and a Thor2 machine and there were no crashes at
>>> boot.
>> Waiting for Michael's ack here. Note that I think that the AI report on
>> patch 5 is not a blocker.
> 
> Aright. If there's no reply within 24hr of posting do you want me to spin a v6
> that:
>   - fixes the commit message sashiko doesnt like for patch 4
>   - fixes the resets stat it mentions in patch 4
>   - add the return value check for bnxt_init_ring_grps in patch 5
> 
> or just leave the series as is ?
No other revision required IMHO just for the above. The 2nd and 3rd
points could be eventually follow-ups.

/P

