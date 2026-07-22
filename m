Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F3B26B2DA
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 12:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784721682; cv=none; b=TAkaj1mlCB91UE5YxgbG1/OjgpUokDV3Qf6zQ6tDGLNk/pshRxlLQxnpKOATt/vBCc/YJu4jB9Xy2apU0O211XFEKNLqSOtIerYpGn0I59IBXS0mCWUy1JU2e2Bon3SSn40KrhI8THor/b0zcJ7WDzsuGcvXzVVUkGeWltZV54E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784721682; c=relaxed/simple;
	bh=1iYzcSzBVszfquoB5Gao5ixYdfrJJeuKpOGKLbt9UfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lnA0GgX7vZo/+kXqy5e5+p7TNrlnCpnY7uUw7JzE2StLtO8ze4b4r4IMg0HmoQym9oDeX5HIl+mem0R6WNrv7Th8y39Iwl3hyNQdqiDJL008ZYzsi8pnHShuJwmJMCOp935Gj38R5XNjqbAwGUnp4vyDG6TkACpxHDB9nuMQHg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J30N8+Gp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FAUJ1ssJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J30N8+Gp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FAUJ1ssJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784721680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gjw5fk6FJX7T3TM7SWdjeZeD5xQvuAq2f/Ljq1xib+Q=;
	b=J30N8+GpNOVpIAA0Ywwf0Fre9XfwqpnC6fp2UZMGWFYx1N3OG6RlT3xJfMI1Vn4S3Do3Yp
	+7T1VdsPCQzARxdACAqPoj1yugsfXA1d2vh+rM5mbrD8kGXCOw57hOfCIjVqk7yqQdPjjZ
	efy+JtaItE3hyU1X/7nRA0RWvmvCQjc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-N3noiLP8ODCFb4eDxD4rDg-1; Wed, 22 Jul 2026 08:01:19 -0400
X-MC-Unique: N3noiLP8ODCFb4eDxD4rDg-1
X-Mimecast-MFC-AGG-ID: N3noiLP8ODCFb4eDxD4rDg_1784721678
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f24a50f0cso11499443f8f.3
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 05:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784721678; x=1785326478; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gjw5fk6FJX7T3TM7SWdjeZeD5xQvuAq2f/Ljq1xib+Q=;
        b=FAUJ1ssJ1vspDqiICOTYo/T93BCI7NQWXLT8vAA9Wo9P+hDoeIqpS+Bjq1DAbxtaG1
         LsEfTEj6pSgDYdzevXwY0IrZQSF4fUwx0TjUXrTHa0WAk5zqINi1hvYyY4lb6o7OTFoG
         N3Wia73kzPA797IyubKolt3iAaOTEJuU8CD/B9b5Lx2ywjYqKQutiKeQeclftPavgkfS
         Jpi1uG/7obrhYkVN4/K8PBTn7YrGs7WSmqT82UV6NXGA0QO8/NoIBpn91SLPgcBj57yi
         sT1uPZVmOHzNQOlXRPeF9S9LACEKJjCR63jRT4g2k/DEjJry5JOq2C/VKYqbZsOHuV/h
         k7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784721678; x=1785326478;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gjw5fk6FJX7T3TM7SWdjeZeD5xQvuAq2f/Ljq1xib+Q=;
        b=bpez4ZW0gluoigwBidY67eVFExzKzig2oSbriA3cBfD0Uus08bM/wpbm1NKMvq5eAg
         ZFaWrp2FHYWBcUKvLLa4M4g1Pipw2kj6AkuGgkiS2ptKpfy0XjZd+y9sSELT4EAyrAdd
         Vwvj/4u5ovlM7br0C3neRBrXz1sJsI5RktvwHgqJcW8qZ0Tdwb1xt7I86t1DcZeHRZbf
         vkfzlHzgiy3FjW1Dz04gYtmyxot/cJGxCb9p49y73I/l4MDlkAg5ox+5Bala4QwatpTc
         9SA3HyHUjcMk0r3M86d4UbW2Bq7E3F9ypSfkQEikVM0IrajLfiEzoqH5Of3+ATN+jE1p
         rfmQ==
X-Forwarded-Encrypted: i=1; AHgh+RoazNJE8u5OnQspHmFKyQiEae5LMMq5H3ZrP70iLYk11wl9DPGewUAxntFjepr4Yd+g1EYF/zY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfashO4eocNJKZQeYFzvZCdU0PfncB5e05L5ZCV/Lg/Kjtqbhg
	dnT6nmbeDCZZX4QNRi6RV8dqwfnqZjmxhjVocMxGyqihjcSSWx/bfgvnvIy87VPQ4RgRI/qJzlc
	Tcg25zVImKP4JzgE0K9/OqYz9d96BBTzpI0NxTAyeQ+vHktV4lsU0TdhAng==
X-Gm-Gg: AR+sD13OKXtvJEHm6vqXqXb2brgc+t3K6RdqgHBs94roVwbL3TbkqLot7qcZJTQr6jx
	/iMirxqe5Y+N/tKQe/ZwvP79JNaNeGxpPh7HuXwEC4xOkpioQRMPXhXFjTGq6oIXrsF2GUTjghH
	SkD9Kj3GCTvfn+GTN1TAdI+Wzjn00uO4u8JJD5gMUt4S/dJMpuTPqDx8otCncz6vpfZdQ/H4lws
	hdpTs36VtjWkmby9yYAyoXN6ZaTtVpY1dp9SpisNncWEDvS8HgYFFzEK4riYf49EFqn5tL6waaa
	vNfJb6mRpNQc1qCczO+gMA9tDfk1Bouzosw4iQbrFqOFh+z6xnr31RJvgoayKnxZCaHoS1YkBi6
	25XZoPGkt1xJEW3xu0nWhtRbL5PLWKU+SeWcL5Aw3ihBF8K0DJk4KkCwHQngCzidE01uKvYlsv5
	HjGQ==
X-Received: by 2002:a05:600c:6287:b0:493:e79e:da63 with SMTP id 5b1f17b1804b1-4954a51319dmr260289405e9.34.1784721677626;
        Wed, 22 Jul 2026 05:01:17 -0700 (PDT)
X-Received: by 2002:a05:600c:6287:b0:493:e79e:da63 with SMTP id 5b1f17b1804b1-4954a51319dmr260288815e9.34.1784721677119;
        Wed, 22 Jul 2026 05:01:17 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a4aae16sm64553015e9.0.2026.07.22.05.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 05:01:15 -0700 (PDT)
Message-ID: <32f55932-e7b6-40ad-95f9-9daff98356c4@redhat.com>
Date: Wed, 22 Jul 2026 14:01:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 0/9] BIG TCP for UDP tunnels
To: Alice Mikityanska <alice.kernel@fastmail.im>,
 Breno Leitao <leitao@debian.org>
Cc: Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <stfomichev@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
 Alice Mikityanska <alice@isovalent.com>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Xin Long <lucien.xin@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Nikolay Aleksandrov <razor@blackwall.org>
References: <20260710134242.216538-1-alice.kernel@fastmail.im>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260710134242.216538-1-alice.kernel@fastmail.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/26 3:42 PM, Alice Mikityanska wrote:
> From: Alice Mikityanska <alice@isovalent.com>
> 
> This series is a follow-up to "BIG TCP without HBH in IPv6", and it adds
> support for BIG TCP IPv4/IPv6 workloads in vxlan and geneve. Now that
> IPv6 BIG TCP doesn't require stripping the HBH in all various
> combinations in tunneled traffic, adding BIG TCP becomes feasible.
> 
> Patch 01 adds accessors for the length field in the UDP header, as
> suggested by Paolo in review. The usage of udp_set_len is then added in
> the following patches that start using length=0 in BIG TCP UDP packets.
> 
> Patches 02-04 close the gaps that prevent BIG TCP packets from going
> through UDP tunnel code.
> 
> Patch 05 validates packets in udp_gro_receive to exclude packets with
> length=0 from GRO aggregation.
> 
> Patch 06 is for proper formatting in tcpdump (set UDP len to 0 rather
> than a trimmed value on overflow).
> 
> Patches 07-08 bump up tso_max_size for VXLAN and GENEVE.
> 
> Patch 09 adds selftests.
Thanks for the effort and the persistence! I understand the frustration
with AI review and discontinuous feedback, unfortunately the volume of
patches on the ML makes such sloops more frequent than before.

I merged this version, addressing an hopefully trivial conflict. @Breno:
a second pair of eyes on the resolution would be appreciated.

@Alice: please follow-up on the possible gso_segs overflow ASAP.

Thanks,

Paolo

