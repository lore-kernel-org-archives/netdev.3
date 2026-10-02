Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C512443A83
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 07:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790927767; cv=none; b=U7vfLboPdVAn3A16PaaRqxmLnVgSscx4MoyIS1VWRI9S42uji0FWs+ejvsg17Y+Ezcsp0MCxDxJAfijt1HsAhOTtd3w7cQ5+FFnuc1rigjDaTLVc2dSwWAuqHYlCO3PIcI2q+IWhhdnoUhRXd5yk+6R7J64rcYoOYFXM4OaIUpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790927767; c=relaxed/simple;
	bh=HJAV1pZ9lXgDKLEOxd4tNuiZSy+JrfvBzEnvT0zKL/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=awRZogEahVWpU9R3uye82gonas9yd8/pMhavH56rgIpxmDNm4hNGz17dvAHO62+ka4UHi/LHQofe6obXqlAtEZxOOEyUwpS6b6W9tcIm6cwkbGI8spXJnWBpJnoLCaGaPiEm0xqHWfsO7ONASF3I70bVzVsWCPOPo22v2CM/Rn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=byYlx+2z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=q2pldzC0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="byYlx+2z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="q2pldzC0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790927764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YvzMj0FWXdEre8JeFTQAy8sUSU4Rxxd4Ot38DPzLz1w=;
	b=byYlx+2zSkE/Xrg7nKuoSwGot+Xs/dPNmPHp4Modpv/V44H6KOk90Tyb9uTS5xduNgc3hz
	DrvwRYoC8NUN8AkJQa1tzx5dXU/fDQISBN5TvW0ykZ1pG0Y9tyli19OahS8Vw+xGUVWZZ1
	jnDUuaDjz6t+A/X5/ob6Rr8Qyizz2vw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-1p0cXrgcNbO23_XkPuIMKw-1; Fri, 02 Oct 2026 03:56:02 -0400
X-MC-Unique: 1p0cXrgcNbO23_XkPuIMKw-1
X-Mimecast-MFC-AGG-ID: 1p0cXrgcNbO23_XkPuIMKw_1790927762
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-487041c4c82so2398519f8f.2
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 00:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790927761; x=1791532561; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YvzMj0FWXdEre8JeFTQAy8sUSU4Rxxd4Ot38DPzLz1w=;
        b=q2pldzC0W8jNsdVUSv18rMGndoBhoeWTbyF0wql1eMChMMYnfdsIKrbIExWP3YxOGd
         MAjsf/Gb1ay8mM6P1XEcoG2eJXQAIvP9TM4c9XC/2Lr4DEtTaq9DmpnzIiGflugOZs4v
         69tBhdL5EoSxrEiwbPwtk4ISuMa6gtGWGFvwHWYEpR+m9Z7salJMfCGn+1p841rPud32
         nrTe1K3dwxskG3720DHq+p7qr70PBEW4fkqqCHGqItlbLSIBrjXovGfVZxBQQBXz/DkM
         nN4aJAgjwzVr7QNKOq+x60xQf5QHNC0W41HndAtlfbWTEFzkT1hgbj0WjC5M/AqmiCnY
         7g8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790927761; x=1791532561;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YvzMj0FWXdEre8JeFTQAy8sUSU4Rxxd4Ot38DPzLz1w=;
        b=D+5vQySiHeNh9Y8BQcc9Dzove6iXEPYmOQSW0Rvl4Jahy/HPKYV8qI4rl4QmD0WC2z
         f/fbVKLvdy/+7ZG06Cm4uZ7d+MbNgqyFBB+fInUUCjt1xMWRhGKPMSNKqaKaWKB2JbcF
         PEPlxH0wzu+q57Y8W82Y+p/X3aj6jgHl5snWUOVRUDKCvvaBH3pOV32Hdzh37ubrVyA/
         An+TlHm/cy7aI1sAOp/sb72Pcx1XdNGg3Srtk4A/dfv8Cir7pnjsSStc0cyOGFGzcYC4
         bgjQWUFA6H38LwIcIRHZFXWC0TCm/i0MI8qgKry5W60Dhn/gCKddS95AGaISCtwi82/j
         ZEHg==
X-Forwarded-Encrypted: i=1; AKwUvBwszdkHasx7OVlkeakbmep9M5dZlNTjSJODcbg0kNDQOC8xp5/8VEIjay8SWRL4fd62uPUxADU=@vger.kernel.org
X-Gm-Message-State: AFuF++nBfm5oicqm3Wo39EbuGYahI4A8iZHDWlIGJRmfU+ubNhcDmJQP
	csJhaga3YzZQrawIBd/FVVoR7B7pz/00hgGdE7rQe/QTgWglIql5IM/aspgDUPKkUML3I6udJnS
	5MOhpCYr1SXNAAR2WQIgREeThTAkt1sO4e/r2NsItOz8FGNvEe7hYcIPxow==
X-Gm-Gg: AYBFou2YmqHkfqayyR1fGmtQoBE3SdYEgrD3WfgvWEqXN2+UqW6H6njceqn0pI3j4Y9
	TUqfw5Vbdqdfhcnloj5QHXJY898BxY4AwGPXdZJBajd9/R7gcSqzAhJ/l4DuEYuNO3qsilz54lJ
	KvVmvgg2ey/rJKARZz6Mhf/i+QpJgMY8G/Hdv6MJvgmzI2UvCokj0bQ7GiLE9Tk/0rTuRQZINmo
	ZpzUBLgM2pxbJ68UUk0kM1p1XjhttbBYMHUYNzEILmEHcu/bzwkfvHOkufH+ajxTv6+As0eXRpI
	Ez7wI5D1IR1ZiD2zwrhZ3+tx+yjYSt5/uk0T5S9SCuEU4+yP0XyywEeHkVSxNx1UIhlbr5WTHiR
	dz2qN2p6D+anUuWEpcAdzpXezLVz/RRLDqHVjdeW8cC2NUZMu6QRXAmkK6mDYBmvTvcjOJgmMug
	==
X-Received: by 2002:a05:600c:34d1:b0:4a0:1cfd:321 with SMTP id 5b1f17b1804b1-4a027579e86mr36781445e9.12.1790927761524;
        Fri, 02 Oct 2026 00:56:01 -0700 (PDT)
X-Received: by 2002:a05:600c:34d1:b0:4a0:1cfd:321 with SMTP id 5b1f17b1804b1-4a027579e86mr36781205e9.12.1790927761148;
        Fri, 02 Oct 2026 00:56:01 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a02752aeb3sm62108685e9.0.2026.10.02.00.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 00:56:00 -0700 (PDT)
Message-ID: <5e6b5fce-b941-4442-a8d8-3064eb4b9d45@redhat.com>
Date: Fri, 2 Oct 2026 09:55:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/3] pull-request: can 2026-10-01
To: Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
 kernel@pengutronix.de
References: <20261001151905.1556270-1-mkl@pengutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261001151905.1556270-1-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/1/26 17:14, Marc Kleine-Budde wrote:
> this is a pull request of 3 patches for net/main.
> 
> The first patch is by zjamg and restores the skb header initialization
> lost during the v7.0 release cycle.
> 
> Oliver Hartkopp contributes a patch for the CAN net layer to fix the
> unique skb identifier regression under RPS, introduced in the v7.0
> release cycle, which causes lost packets.
> 
> The last patch is by Ji-Ze Hong and fixes a struct size mismatch in
> the f81604 CAN driver, which results in a TX starvation.
FTR, I appreciated a lot the effort in keeping this to the bare
minimum.

Many thanks,

Paolo

