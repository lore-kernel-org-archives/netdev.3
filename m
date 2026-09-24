Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B832D592C
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 09:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240983; cv=none; b=gu7oJArUfUGjBlHVysZN257I2YyPZqYixPD3srlGQg/ZRarv38OmvL73mRBhl3Qg4D4c5YQ8Tw4bEeJCGW4CRjHbn3qRcX1xJdhNZZIQMboz/YnVVbc2p2hYlhK22cVjh3qWLHJl7PVsJe0pIHxEbZiCifasH9GQP6GkHTmb6bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240983; c=relaxed/simple;
	bh=+b1PxkzxUHjCQHucmaUD/w6jANCaIGxvM/3X2XRvDVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0tH6w4btO0j4R1L/1rCVo7oNSQ2Syw0LNR+lQC2CS2BcyGS9T2j1EhyYCAFfLq6qQ8zqaxscmePZVfug15EvmQ3lw+8OWMm8wC//I8WhBiLUr7ZUIILmQPoIc0FB68ZN77hj2Z8R8Mpf0fc/+4lsCZZ8VhFlTIj2PJuUje3Dg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=Fjc/PvF8; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="Fjc/PvF8"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664d340aso1185839eec.0
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 02:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1790240979; x=1790845779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=09ymdF0kRw/wrumKrU42mNzgKkPx44zAXCEbJHy04aQ=;
        b=Fjc/PvF8nCzts0bqIq2H+e5YUqGQhYCPjJFn+lkSjSDCx7lLyH7vxyg1XINhMQ4nLD
         zSErIZ+6y4rt7dMnIqZ1QyNxjlqGbk8LtR1no9npcotRG0e651qZBqpZkv/lMO2cmdFD
         EqNwNqk096yIkxH+RaEb3KnzE7r62ySMsBcp8zgpUMb8KpuCzaClFYgsRLJSG6IeGa1c
         1k5M2dOgOhwAC2Bf4V0OYPZdVEsbwZbVtfIfv/dFpplu9CXVI5IUnu5OSOsKV2Aei01q
         2DORnf201gACEjRVHk1SbMrjykK2eK118xvJQ9Ol88yCNMJOEFJHaWIMzGxmHtTl1SjQ
         DVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790240979; x=1790845779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=09ymdF0kRw/wrumKrU42mNzgKkPx44zAXCEbJHy04aQ=;
        b=PFw/bA+es3wIQpR3sdt+6ejUhuu+YE8Be1xD/oaDC5LzElxbDRtMr7cG1pOYE5sO56
         Z3BNR0S06l0GQPUneINQsi9w+BKIw4ky8fY2Tt45xD4AxzKSPD9Zp/556X9M/j44Glis
         eF8jo6k+ibh9GqsPjOyEqM6oa2jnUzy3TUtHUBGXqawa2WXBhpOOQFJC6BZdQCzPBahz
         lnkKPhk6eTjwy68vvM2OcEdqaJHVaFTIm9umGv4FR2kJ7kYL+3WbiyFiy7ATNmEjdm/e
         1t2Yw9AMaO/YghXcciFqiqhO74sFvsg0itT8oA4IIvxIdEy3RPUZqH8ZyNZmE9EVfl44
         9f3A==
X-Gm-Message-State: AFuF++lMS/X8eC/xSWKxMDHrINH73mV3Xu9UofDe9izqKmDzYrYyoKyL
	6V6yTGtF0Ky4PIyjkqci3AJmiprbDuXqsdjOx90UjFnMXOA6H6D7GhTRQ0m2zFOoBhADpshKLPE
	Ja0YGwZWsEj47sGCZUXYBUYJMWlMqJ3SdzIvMgRVzR9MUfd6S5NNCJsN1q+hLTzOEyADLELcNiR
	A=
X-Gm-Gg: AYBFou0CM9/qNDTWOtkVCP+uHLZLckca1WPYNHlaJ1s1uO34uiL6zScKTc1KkJWC63C
	45iqaA15q/NA4wlTyY6rojAW2CEhCo+748b0WmLEgXeAooNP6elOH84AdJTKr8ijymV4qxJvF0U
	28peua8Wzx29jUDgJsfXt0gaJup7svZqX8ag1MaJB4xkKz1O7ngkIb9TMcKnnCdrStN9ggR/teJ
	lFG3RXhsvI4wl/MTY6BBLLzzcXb7YBO4EFeWcH7yPXbaQZrNEx6Kp7CQybFSAHZHJcp9X1bOUUB
	S6DVnoi9XEqSUyDc7I2/FneDvG85GI69aXgG9vrlh02ZzwfAYiRG95IQDHZpILrNGZWIcir5Y9B
	1C6OZTpXUSKVA64rMBagJQxG1kPUW04fqk3jWbpqXbpPOsOSt/dCsmuWCQiPOXHWKbdA+nDVM9i
	8cZbW0aTSCmmE6Ulz6V4aWEQRNsa3gdvWHFsbs0IH7w37sHJlSgWZvUYebK1P+jUyThgXf77Zrg
	LB2D4gGJWDcj+rOYey0/A==
X-Received: by 2002:a05:693c:811c:b0:33c:e91:66c4 with SMTP id 5a478bee46e88-33ffe33d3a8mr1428744eec.3.1790240978944;
        Thu, 24 Sep 2026 02:09:38 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34051b73e1esm3716288eec.23.2026.09.24.02.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 02:09:38 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Wang Zhan <wang.zhan@smartx.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jason Wang <jasowangio@gmail.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alice Mikityanska <alice@isovalent.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	dev@openvswitch.org
Subject: Re: [PATCH net-next v2 2/4] net: gso: support bounded TCP segmentation
Date: Thu, 24 Sep 2026 17:09:23 +0800
Message-ID: <20260924090923.4182481-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <willemdebruijn.kernel.3a0e7cb98a0bc@gmail.com>
References: <20260918084651.3022878-1-wang.zhan@smartx.com> <20260918084651.3022878-3-wang.zhan@smartx.com> <willemdebruijn.kernel.3a0e7cb98a0bc@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 23 Sep 2026 12:50:09 -0400 Willem de Bruijn wrote:
>> @@ -117,6 +119,7 @@ struct sk_buff *__skb_gso_segment(struct sk_buff *skb,
>>  
>>  	SKB_GSO_CB(skb)->mac_offset = skb_headroom(skb);
>>  	SKB_GSO_CB(skb)->encap_level = 0;
>> +	SKB_GSO_CB(skb)->max_segs = min_t(unsigned int, max_segs, U16_MAX);
> 
> Can this use GSO_MAX_SEGS rather than U16_MAX.

Good idea.

>> @@ -4975,6 +4979,12 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>>  
>>  		__copy_skb_header(nskb, head_skb);
>>  
>> +		/*
>> +		 * max_segs is a per-call limit, so output skbs must not
>> +		 * inherit it from the input skb.
>> +		 */
>> +		SKB_GSO_CB(nskb)->max_segs = 0;
>> +
> 
> cb has to be treated as uninitialized between layers. All callers of
> __skb_gso_segment should (re)initialize this field. Is it necessary to
> clear it here. Note that we do not do that for any other cb fields.

I checked again, it is indeed unnecessary, and I will drop it in v3.
