Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D9D3CF680
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 10:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783508235; cv=none; b=cXpRhIpFAArjYWMe+TxBCrfhHIvQr6FcZEBOTr6M3/xtV5270AarzWr4YWHiSWTWYm9w9s5DWtFLSmQLXPbXQHNDCERxmkv6V9Iv90HCYjbO8JZIaKTHWNUuLbbKJbPNGeNbsoQ6mVfL01R+lXQF4xYBZtp/YPVZG8aF0BmsZy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783508235; c=relaxed/simple;
	bh=M4cKxG7rn03qGW5kSZE88jYrpIP4zvhW58ZIabmPFvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ayDHq8GIqkZY1CtpXnAKA2VeDqOSCxHYWz5NTk2ZU8ATw2puo6wqFcams91n11mzOeZsv59sbfoWYVzG3zSyisffq3S4ozQ7EojX+ooMUDmiVcUUSZDr6NIoQDwho9ZIKFV7vFB7kPNjguFDb1FCorXVlntZwSyMqAmanJ1VGMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kchoqdpo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IiBeau2n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kchoqdpo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IiBeau2n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783508231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nRaQ/pUZXsFDjpZJaNCEg3QzvRcLSiDykic5pLM08Kc=;
	b=KchoqdpongJZWdD5sul4eLeyYZ7XRJRHb+k2T40+75Fvl9bAPTBIWpYkqQW7PX6yYf+fHS
	2draiQMSMx05mm4wfpXgQM85hsd48yK4SH7NLAQ2+K5oUXD/dtNFld7gkMYyFMWHD212uq
	LyCNu5oG2X9KajDvTHLamHD53USL+lE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-HwpRVH8EMnC_DgW2vpgP1g-1; Wed, 08 Jul 2026 06:57:09 -0400
X-MC-Unique: HwpRVH8EMnC_DgW2vpgP1g-1
X-Mimecast-MFC-AGG-ID: HwpRVH8EMnC_DgW2vpgP1g_1783508229
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493bc2b376fso5117535e9.3
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 03:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783508228; x=1784113028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nRaQ/pUZXsFDjpZJaNCEg3QzvRcLSiDykic5pLM08Kc=;
        b=IiBeau2n1BfryWMwc0qCCUjEim+xQwfL8k2wOB8NIKCOenk3RKWofZGJEFB2UpcAbr
         DOXPqCTVfwsyDWxl8P0R3B4GZjj22tNrx1vcRpk7PEvWWSfuRJLTJhlI0KYi5Renx5JJ
         0UFKhCTfY9ZztsT5x5Ly1UfSzsN9doxvZtbTiBN1xoNzaSQAx2FX1hcAnUUEneFgAKzs
         OVUiTYs2/v+PJ9mFcPIM5FjNGEhYb268be2UcZXMBn8C+/8TILpINNiFq8z/WGPZnVgn
         IHDnNMRdVeDOhv5zz3hFiDbHXwjHpMKsvFz3X96+TiPumRQzwvMXWnECxeIsoqQ46jai
         DTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783508228; x=1784113028;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nRaQ/pUZXsFDjpZJaNCEg3QzvRcLSiDykic5pLM08Kc=;
        b=tLjeNks5lvhWdKZ8kNAqRnYAxm9nioWYlGJT5IOOKdt1bO76auFJUBp12vpCsS+Zg9
         dj56SzaveAIafgslOKaO0vgm8nA0Vz1V8rXgztyukAM1sisjYb0yOlIXkTYXe7QY81ME
         idGF+muxsiM79+WvPOmdUiUc2rFqw/qK+NA2Ej8MPyNaDLrPB6134n5KdXPgDrufhoIm
         d+aPF5329lCXvSCI7q2Tz+Mwc7VIG/ZPzmJQH5zMWgmpaVJRYpJODhM/lan96KmPzAJ/
         KLWHPNOaIPbaPA2quwXLojswb99gX1rnSwFrjZ52huuwaH63fW+VvaTonoSrb7cpxm3m
         /PxQ==
X-Forwarded-Encrypted: i=1; AHgh+RoY+6cOXreJRx9vuMXrGuYUWBYwqlfT5nBpCMcHSewXuuC9UoR/InxjUXN7Q0JWdhvW0BW7/ck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2cZ9rQ1yv19VMydJNzhgY2KnIpg5c9rav6fixe6QXdQVdaHnf
	ApMOvAhuwb89zxfBTEkFQwovr8SrZjo/5nJ9yJgcgzdTnjMr4j0SOq7xB5GgtpRqlFEj3WtBAku
	I+tgcNO4u2oYB7C3DGHLCKeQvoTeFMerhFOM4zsV/G+ykqaFJVy1TbiAFKw==
X-Gm-Gg: AfdE7clsuhbho2De3BKZ98M4vcdhID+szKim+DpWViNTrpWbzXQ2fKiM9tJirerYZSF
	ZjVJoYWprZvoKuXAZTyWJ0sNUJgXg8NE/H/B22WViSW3ge8P4Gy4RlEoSICZhBOhc2QshRCm0W9
	QnlmfyuxebjOc6bm46tqsNiVT5JyIyz7GFuzlJRrc0kCnScHDAJWur2/PtxzZWXbZgLphwRBF48
	fAl9c5GdfyCvhPG7eOk7Jw4WwQwO8kOjvhIo43PZrDG+sFiMuxAA2XBPzKe1VHjeuarxQDDSJRE
	KXqWPHUGB4qNhHTUt3mwPQgBaYYKLrLxssbi7fQN7iBSXsC+KN1rRIFBCYQSuFqcYdE20+whP2n
	ttsPqxBePh4PuLto1QbB6HQaPmgVAgfYv7Rwwg5N2751U5FKsY9Mqxehcb8Fp8eu+12IDim24X8
	R7W1WXCE/nfIj9
X-Received: by 2002:a05:600c:34c3:b0:493:e79e:daa6 with SMTP id 5b1f17b1804b1-493e79edba5mr17133765e9.33.1783508228691;
        Wed, 08 Jul 2026 03:57:08 -0700 (PDT)
X-Received: by 2002:a05:600c:34c3:b0:493:e79e:daa6 with SMTP id 5b1f17b1804b1-493e79edba5mr17133315e9.33.1783508228188;
        Wed, 08 Jul 2026 03:57:08 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f5b811sm211634515e9.13.2026.07.08.03.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 03:57:07 -0700 (PDT)
Message-ID: <d359508d-76a8-4df8-87ef-2767fe7fb40d@redhat.com>
Date: Wed, 8 Jul 2026 12:57:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/2] net: mana: Validate the packet length reported
 by the NIC
To: Dexuan Cui <decui@microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, longli@microsoft.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, kotaranov@microsoft.com, horms@kernel.org,
 ernis@linux.microsoft.com, dipayanroy@linux.microsoft.com, kees@kernel.org,
 jacob.e.keller@intel.com, ssengar@linux.microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260702041237.617719-1-decui@microsoft.com>
 <20260702041237.617719-2-decui@microsoft.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260702041237.617719-2-decui@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/26 6:12 AM, Dexuan Cui wrote:
> Validate the packet length reported in the RX CQE before passing it
> to skb processing. The CQE is supplied by the NIC device and should
> not be blindly trusted.
> 
> Cc: stable@vger.kernel.org

This need a Fixes: tag, to help stable team backport.

No need to repost: just reply here, and I'll add it while applying the
patch.

Thanks,

Paolo

