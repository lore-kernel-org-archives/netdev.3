Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE0B34D93B
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 18:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783018543; cv=none; b=ex7wsyF4zzsNLDWZkb6o+AxUB0cxhy3+PfpWTBdNQpPL6OLTJLgtdeFTWkVXP4caE9w1nhKiQimd96coziXBRAtYlDWKOs0SdS+sE27MkbB7WXU9fBSSBx/coCmgukQipaqG4d0n/PWXgEtyiMoBNH6HgfBM1nIgTlCxBwxxQqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783018543; c=relaxed/simple;
	bh=NQtSnHOqKribaHMloH4q3ORqVR1Jdel9GdNDJFaJ9nM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bc4GNpmuJ76C1KaFiux5nJ+HIsm8Qtmgni35fOfRe+5O18cr4r9OrBvx9bnLuFvukHEbSlMm53PxPYsojawg+YvXV/l+04v9SxOWozfAYluczN31DI+QtPEGMYb52gPcQrFNfwKNJ9IGopsBEYKABvs9QzCsCJD2pfe7EGJO9Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJ0Okgkl; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJ0Okgkl"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-474560436c3so1984155f8f.0
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 11:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783018541; x=1783623341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=yFPjV8jYTAv1A7ukJs6vQvdxSZpBv41upHQ98f41JsE=;
        b=VJ0OkgklUGUA3rSqwD0M18bs3komamNlWNMKoUEadJfNMt0r5YIRAHrgXvu+5ogJ++
         FeyQf5/oORrCMC77yir9zvWqkXvV6nR1foSgooXAjZ7uOYQrHfq/M6rkPiSll6d0j4tf
         oozOsQ1JKks/Ny0TlNwca7VLsNJONzmBzkpXhRLipZSFaTAHhh+yvo4lyY44PDAtAHr9
         dGpzAHw7q1iZ13eVogPchxUDeupr7w7W5puGTtZDeGCIEd+7RAmv2M43vzj/DBZv8Yof
         eFFRm2r0s/XdVhaNPz8WcDXvzIO8AmhzexMQ4PKQaHdcWeiCQjl35cQqGLG8VJ9zNLOK
         4bjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783018541; x=1783623341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFPjV8jYTAv1A7ukJs6vQvdxSZpBv41upHQ98f41JsE=;
        b=E4WLLZuj8DvpUTO1VurIjcK3l9SUaGVr+eXpL0UJctXUqoynR45H+FuvdMyIcqzNKP
         WXjYfKgSe1fIQlg9Rqz5vcrtYRGnHbnnAwl+NMbdPDnWeAmWjNBzdx7BNCMmhs5GdM7D
         ge3tzHJ0oHOFDv63FPXkHctV9QGS7CKVZX6/J0MP1eMoleLxymgjsrb90jbN8VCjU1LL
         kF28au+F2x73RWgz6hhtQ5dcNETkPiWzr/R+F5sdibCj3StxIK3BvB8TtcmWUszzZKXd
         V+TRf1jSi4f+x6kgOhIHh7huYLmwQUA98l8isS/aucdMjUlqFjW8MJ9TJ5YTwdbYUFuJ
         7GUg==
X-Forwarded-Encrypted: i=1; AHgh+RoAuQ/euoP4o74Ggx6sNo25eOAlDdDksCQCb6Asuq2O4RUNOa1hmQF+X8D1cDrXAUwFF6nuOuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/h39WV6l5ircmfohN3wwewKUc22Qc31SevmeHGOzmXoVOc2VW
	uvngO6l5RccfkeA1cGz09MT2B1fLkTn7G6xcZED/bfz/ZXAVBNRPv633
X-Gm-Gg: AfdE7cm1pP3ETby08c4HEsnbl/epbkQfNqdJvSgd7wf6Qly3cK6J2ox1sjTl2OqFrWL
	SlZ4d1xKJNJ+Y6PzU+LVYXxZFgMpHwS763GdJoZsIyCfsYDXEJUuIQbQ01OfbpBotAR3ze9ck3x
	vytJrzQeALK2RMVcDJhMM/z/YzMGnN7G2cHUjKGTYDoTyiKk2y5wycl4B06zgJSGwIbkSAYAqeK
	2wf0Ql91+Leb2Ge3ZAsJO6yUayiwlW5krpMotnEhQF0j3B254+xCf2kso+wKsjBE6ctUJEhYPBs
	ZYX8GGbqa701iLBKj4e4rgXwL8fYQM1gBHk4Yc19/IZa2uk2xAiKuFsXf/mUrQh1cg96R3cn2xY
	T0MhOEsDuKtyJ7moqWuVckleq2q4xCR2OORTnxz4fJz+zNBO5UDlKNoZYHuaV/+QuyOnvo8rRB/
	0VqG2kqRXy7eLhqw1HYDB0Okr7uIOwssdDC0wRrypY+z6ufSbQSoIEXwuV5G8XR9gvtQ+yTMECV
	wK1BjpPWSNmAFd4G+k=
X-Received: by 2002:a05:6000:200d:b0:472:c96c:eeb with SMTP id ffacd0b85a97d-477abfe6d8fmr9677027f8f.0.1783018540774;
        Thu, 02 Jul 2026 11:55:40 -0700 (PDT)
Received: from [10.128.11.240] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477dd94c9b5sm11637009f8f.20.2026.07.02.11.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 11:55:40 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <1fdd92f2-d968-4080-af57-7d144be80a33@gmail.com>
Date: Thu, 2 Jul 2026 19:55:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/9] octeontx2-pf: switch: Add pf files hierarchy
To: Ratheesh Kannoth <rkannoth@marvell.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com
References: <20260630024715.4124281-1-rkannoth@marvell.com>
 <20260630024715.4124281-4-rkannoth@marvell.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260630024715.4124281-4-rkannoth@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ratheesh,

On 6/30/26 03:47, Ratheesh Kannoth wrote:
> +config OCTEONTX_SWITCH
> +	tristate "Marvell OcteonTX2 switch driver"
> +	select OCTEONTX2_MBOX
> +	select NET_DEVLINK
> +	default n
> +	select PAGE_POOL
> +	depends on (64BIT && COMPILE_TEST) || ARM64
> +	depends on OCTEONTX2_PF

Could you keep the 'select's together (move the 'default')?

- Julian Braha
