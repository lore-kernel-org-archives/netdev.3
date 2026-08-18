Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5392D8796
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 11:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787051499; cv=none; b=fmnSXjYXVmJZGap1KNQMe/YjtiZiFM2Py4DZtBbbMOX3p+EQiicx48vfbahRR+2YZstMtFuA+3SLumIs9PY/9S42NeVsLpL/u1ia/FLMAV1wqBxo94FBvW7AEN7h5aTbI141RYh4zbY3EL2DsNkye2NsKeybAlz1Ab177Iw77VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787051499; c=relaxed/simple;
	bh=BbY6AugiYJJO+Aqx8xAwWg0CsYBvQjrLuUBuwkgsj7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sfPchL4AquMUrhPugNccDayB4KioB68HSmt/1hJ9LJUkysySdjE9fEZ20ZRZgBu38LBknxiPxkhgD4oFw1+dS5ouqRJ+eFb9KKD4jrZfV5ujZWtTxhbH7Th+pz4bm3L0V+KyFfes9+0mevtgamtfuNgx/nFgW3wJfj6kXiLnJfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gNSbI3B/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HLqSXh15; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gNSbI3B/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HLqSXh15"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787051497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q7xmBaR8c3MOstN/SERsMR2kSJUtTOjfrtXkiSiGFzw=;
	b=gNSbI3B/gy4lNsBY50oU0N8Z6Gi+VSL2KVl/QKdYcbR8tpG8YnghBmtq91d0YlRfGraXC4
	fCPzSLoOiGGh3RA7uYtqoCY691gB7vIX0V+OFDsK9sbzipwulLJD8dzMviPE3dwfHbOg90
	eaKFK4wp28GjTyuUu4JJ453zElnuNDc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-ByHQohrhNXah54roP4yaIw-1; Tue, 18 Aug 2026 07:11:36 -0400
X-MC-Unique: ByHQohrhNXah54roP4yaIw-1
X-Mimecast-MFC-AGG-ID: ByHQohrhNXah54roP4yaIw_1787051495
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f4bff865cso2443054f8f.0
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 04:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787051495; x=1787656295; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=q7xmBaR8c3MOstN/SERsMR2kSJUtTOjfrtXkiSiGFzw=;
        b=HLqSXh15S7Or6BMd8Gh3BjvVXwW/t09/TnopUNyn5aiaUZ9dIJgnxCABKh/qcLMOGh
         nSWPISVQZZRPOmjQF0I18AsDD0ckVCx7mNLl+DTOdsmZbmPows2/vujDfyGuuag7pONk
         wN/m9S+9jjFdWjFa9YavWPov0pTiKgbtZHXH+Y3bxjdHpGgNAiNEf2Q6dSFOvu4H0sgz
         F9m5EyUM/Vzd3M2uDBhu2uJvrOtfFyUkYW3L77xjpXMx+eECUCi0W9+1dTwiZPZPQVDQ
         rmQwHw8Ch62C9BSDhHmKckCaaOyAUlIaZOkHt7Pfi7jYG9ILUfjGfnISm1PHeBfHzMV8
         ichA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787051495; x=1787656295;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=q7xmBaR8c3MOstN/SERsMR2kSJUtTOjfrtXkiSiGFzw=;
        b=mTEXRR6MzTOCyH85vyqFZXqtZitMxcbM8YjNVxvo5NSurF2Iixi05wXVWdHURbtwJk
         CfvLkTkgf6WQd0YXbesisVz1cnNcHnotvNBaSf7/zssmIkEQ39wCIMPQRNCAWVziGpkM
         aD+LcdOZRh/D8HeGg+mADLNJN/CAabLLLqgVSE5VgdFGQOn2DJUUp4uq41lxg/LPAoMP
         krP6308CJIN3e2SkkRwGqgChC1fy0B1GNeHXVbeDHaMlD3ZXPokBcRMJtyPAYscOrx9+
         PByIWcxd+qREImRmTRIKipwyqiSN9ISIYmETgjnH7xVHakcV1Ep2ILExROr7Hb4IJiMz
         CMvg==
X-Forwarded-Encrypted: i=1; AHgh+Rps8+9vD/UQX/5aJEv9fUgBxKp7GvKmY5WYUtKjaWSmuCyOiYHFSiq2IpuSwyGfkfvvJlA5tEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdayO34ejtk0u3t21UEVezs/b4dwtQzDSFeN+YpWywWig6bZ33
	1rO1gzEdlMEd5SVJzxVEzA8J4EFWwDvNZPC3UgGrOEkfIwFPfFu5abUdH2L5haTdY5FheZDdI8W
	747FkXYVCaak++bZe5rI0WLFf1XqU9U3ZVICc21wBZj2cliUf5IolGw+JIQ==
X-Gm-Gg: AR+sD10T0hN7VtilVSpRu7msrK2LdhJ+6Fo+iGg29f0Br1Cbsi8joBVlAd5k/eiOymN
	hT730GOmSFyggw8XZVBpSoWuzkxN9Ua2o/WzDSxJ8UkXREDDJasoTyuq8knJOJBChLvbvUzIvKR
	/bjyQzAYM5U2+DxdVxyIQ4GWcm/CoyCqP+DXk8TYNYei5qB1vS/Lb9vxhB3UmQ2C6hCR/ZhC+o/
	FYEJuWB9PHZ0ByGQ39Q0jx+WtXWMJX70DCgTzAflH5MimNE2P7dEtOLeXmrX6aCEN1CXrX7z99p
	FtSup6VSATk7wQVnYGU9+96i1doe5vdrVehMHv/01Xsx7wBPI4xYDA6IgRUPtXyPP+8WUCGWsRO
	xdAqfb41ehbErZrQ8ToH2SW56jg1yBIYWzv+V5SS8gQaUwvf2OqmA93akms/JxSCfXbEY34+2o1
	8=
X-Received: by 2002:a05:6000:4201:b0:47f:e760:e5b9 with SMTP id ffacd0b85a97d-482a903c1c1mr11739163f8f.18.1787051494522;
        Tue, 18 Aug 2026 04:11:34 -0700 (PDT)
X-Received: by 2002:a05:6000:4201:b0:47f:e760:e5b9 with SMTP id ffacd0b85a97d-482a903c1c1mr11739063f8f.18.1787051494124;
        Tue, 18 Aug 2026 04:11:34 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a7bc6esm11928055f8f.19.2026.08.18.04.11.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 04:11:33 -0700 (PDT)
Message-ID: <3bc731d7-38c3-4ffd-94f8-e59cde66f5db@redhat.com>
Date: Tue, 18 Aug 2026 13:11:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net/ionic: avoid OOB TX partner lookup for
 hwstamp RXQ
To: Anand Khoje <anand.a.khoje@oracle.com>,
 Brett Creeley <brett.creeley@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Abhijit Gangurde <abhijit.gangurde@amd.com>, Shannon Nelson
 <sln@onemain.com>, Leon Romanovsky <leon@kernel.org>,
 Eric Joyner <eric.joyner@amd.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Kees Cook <kees@kernel.org>,
 Mohammad Heib <mheib@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260813083705.454897-1-anand.a.khoje@oracle.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260813083705.454897-1-anand.a.khoje@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/26 10:37 AM, Anand Khoje wrote:
> The dedicated hardware timestamp RX queue is allocated with q->index
> equal to lif->ionic->nrxqs_per_lif. The normal txqcqs array only
> contains the regular queue pairs, so using that index to set rxq->partner
> can read one entry past txqcqs[] and then write through the derived
> pointer.
> Only link RX/TX partners for normal queue-pair indexes. Leave the hwstamp
> RX queue unpaired, and make the XDP_TX path abort cleanly if an RX queue
> has no TX partner.
> 
> Fixes: 8eeed8373e1c ("ionic: Add XDP_TX support")
> Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
> Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Reviewed-by: Shannon Nelson <sln@onemain.com>
> Cc: stable@vger.kernel.org
This is net material, you should have set accordingly the target tree
into the subj prefix. Also your SoB should come last.

No need to resend just for this, but keep in mind for future submissions.

/P

