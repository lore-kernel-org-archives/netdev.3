Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794435411;
	b=Rh1q9nXZjgXiiHs2/+0XyofB3bCQUMZOeg6Yoz+J/Q27BPXlii4kGIJlOYDgr/FUyWIr
	 TAkC0wX4K/esDTLCpBWhojv1aAyNnXpgOdRIqU+c4/c8E2on6QXTD0RMezQgoY3Nhk0Lm
	 S7nranrgix234HqJwoQBEZ/OZa1O5Q5yWCKobl7p7M9PTkOw2YeT+nJEIzY4kOTppw7Yz
	 l7baVgERmyyeO41Ld2UqSXzy4AOtlotVDev5lSFj7IjSpRrtg8ZdLrhqgKcFRKEmSR9r4
	 z6OaMsOzDWGA6gJnUkVkLAmbozhqCYyjOiByvZA9B/s4DsSx/O5iQTXbbYHLLYEQqXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794435411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=vnKV4PnxU9HF6j4JAgfB2zweGVhKP+4yJbw/eTtZUp8=;
	b=I11Hu+hgCd7Y/Cm4IIYrmufy85G0XupYaa7GiuXXCGAUPS5ho05pdWHQY+on9fmpI9pj
	 AzX/fuFDIiLg1Jj6okGnCEFa9+C0ejdYth1lmymzQJlQ2dsMVljvhVfAr/t9qi47bDufL
	 kQNJC2u1KkRXP2YJT3FjwegBJBf/tDb5vYl0kgChjEWDFE0biHU1fJG0cBW/2lFnRt/Hh
	 0Fgjs8njksGmVUwLvOKegpcYj8FHRLP//i4buNt7vtr8nd6N1qFVIUFfg5h18KtfjZdUo
	 NimpGq51p4LdWE+LQJw0hXAG5Q6+N38Vc/o9AhnSsOGpa6IobnMsVK1Y/LSBXSpwWsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hU3Rs4Sj;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8753660A380F
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 22:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8753660A380F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hU3Rs4Sj
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-3678f64d078so4323429eec.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 14:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794435411; x=1795040211; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vnKV4PnxU9HF6j4JAgfB2zweGVhKP+4yJbw/eTtZUp8=;
        b=hU3Rs4Sjby8PtUaslxBXzBVvo1G90IyFvQqlvS+9h3K38uEuZQg6Ez+RsngRu8oknX
         q8c+EkC8Ilg0jwfabfGTOSf2bgCDnzQVXQY7lhHbzxuN/Tx7XGwlmXgVWutMqpM4a9OU
         Gp6ijqwpnIM4jGYoiJTx3h4EmYlmWu69ccv1FynMw/5SpZ8OjWqsCuiMZq9Fd3RzdKZB
         bVhgHiW4ZkF1E/nnJK5aCrJ5C3sIyN0gyeDut9I9ylGIgRI19pwnarlPTmY6fbWSPsb+
         tB1QpVyXxVfv7STUwuEg6MofELktIg5Ty/oEs2uI9gGgLJUq5EJ8sZmF/AxqHarQX6p3
         3u5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794435411; x=1795040211;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vnKV4PnxU9HF6j4JAgfB2zweGVhKP+4yJbw/eTtZUp8=;
        b=vZoEQPPKzJgmPgh+b9WjrNgU7N5gx90lxU49iSWsBMFreeJaOaIi+iMihGZuDgtZ2e
         y9+oMr0Z4IU2QkOiAPRQtuY8Upp/GgJTcPD3vTBCI/o4Bzjn1Klv2R7Z0Ybua3ziUmv3
         isSnyIZDMYvDpZ4wZgZplupYpgg+KlwL6ut2BpuX/dItV+lclhNg0K2/NfsJpEV6V4++
         s2IkmX19wWOxvJJSTfnc8vxzVnhHVwUiL1T5JERyXLudLVjzjLbxmgUkhhYXARxVQfD0
         tQOnyYCtndSu7bJuB+/RENx/4a8C7nZhEmuK+KewmFfU6zHfUj/bybRwzya7VthqswuG
         p5hg==
X-Gm-Message-State: APuU4Z85/yDe8GzhVdsuXL22CHLaY3JLHoEdRSljnW2LZ5sbIWvNBfs1
	v9GrdtxhFZkjcqQ3s1quryi7ZcvmHFotEofFPwLfCDXhDcVjUoz+C6/4
X-Gm-Gg: AYBFou1zOtn/EWOBwDQHiActnFIJ1aZuqxZo6MA3yE8smk53g3Dkn1C7OQyOu5kc6EB
	2VhrNaFMyqXvsF3QC7bK0xb9b5pn3Je/qun+CInRLLYWYWkbar0e0XPhEJtGRZmQs8yCtIlmgu0
	SE1YpTGjKpT5PpX/4W9p156UAAtvB90q1LtfdPWa11lFzFVYSb1hqeBusZRc95l/tT7682J6fll
	kyN2V6RNRHnGvVDZIkwZua+eskvUyTkIx0D1igG9gWooufzcYCoK0z6ZghqqR1KDOYeNLMJ2y7p
	W7Gvoo+3wwOM0jAdzSegmyS6xdM/sLnvn9xfCTjIRdcshhVlFQP8tKn4BR+8qVB/bzMbJ4zxmEJ
	mIXm491YhwfSBm9MXSXFSlk7NLpxKRbhNq4iQ1/Yfh1+E1CpOMFlt7lWRdrT3NwkA+7D72H8ZE2
	wflvpzp6XnVjpODXtT03MGK15BKw56Xyy+sgaPmCU4ZIDLpjhAupWWWRUNz4eGmXZlzgD5rWBvh
	hirXDm5qyf+9igSW7yMiGZxFF0TIaiTEhM+KMcfK0I1l+WPk9MyMf76ExtZ6AkHu88krcJy+4Kn
	Qpgr6DVE9yF4gxHtiwytvkxmdhMvZlaqxt1jtUka/c7I
X-Received: by 2002:a05:693c:2582:b0:378:314:4042 with SMTP id 5a478bee46e88-37803144bbdmr425280eec.14.1794435410616;
        Wed, 11 Nov 2026 14:16:50 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:40::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfe29fsm21570686eec.21.2026.11.11.14.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:16:50 -0800 (PST)
Date: Wed, 11 Nov 2026 14:16:46 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Xia Yan <yanxia@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, edumazet@kernel.org, kuniyu@google.com, 
	pabeni@redhat.com, willemb@google.com, davem@davemloft.net, kuba@kernel.org, 
	horms@kernel.org, asml.silence@gmail.com, kaiyuanz@google.com, 
	linux-kernel@vger.kernel.org, almasrymina@google.com, yana06070@163.com
Subject: Re: [PATCH net-next] net: fix token index wraparound in
 SO_DEVMEM_DONTNEED
Message-ID: <avTocmy4u8HH0Yo0@devvm16445.scu0.facebook.com>
References: <20261110120331.13661-1-yanxia@cmss.chinamobile.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261110120331.13661-1-yanxia@cmss.chinamobile.com>

On 11/10, Xia Yan wrote:
> SO_DEVMEM_DONTNEED computes each index as token_start + j, in 32-bit
> unsigned arithmetic. A start of 0xfffffffe and a count of 4 produce
> indices 0xfffffffe, 0xffffffff, 0 and 1. Once the sum wraps, the loop
> can erase an existing low-numbered token from the same socket.

Sorry, I fail to understand what's the issue. This is (buggy) userspace
misusing the api and potentially removing different tokens, right?
So what are we fixing? Can you explain more?
