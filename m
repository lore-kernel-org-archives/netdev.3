Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794464379;
	b=j3qTFHaE06W3gLHv7+7+FJ/AkFDfqJosKHR6ZZ678Nt3SKfkpnyI4KPlE4NdZpZoTgVJ
	 ux0xW/iw0VABlxmI3qdeSZbug4egd0wbWjEMQbMjbE97IWnPHDjX4J8nyyfMmTwCHcUly
	 LEqQaH0noJYWcE7Kdq8Q75F/vGywb8AVwTx9RYYPid48B6vHwO+aRTWCNHksTLeQL9WTl
	 KDnMFWQHya30CRU5nAo6mBbc2kM/VoIVtOvun1D0ZgYRJDvPkp+8EbZYdNOoH0mJcGGxe
	 Z4R3735Gko1RSDwMZSGYwyTrUfRIGYX+q6l8UZCamQrg2VNvK6JPaJZemoQpCKvzvwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794464379;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=uA08ZWVt/bTm0lpe94c2sMUhRAmYMvhXE/vdrih5bQE=;
	b=au8sT/gXa2LSDZM+Fvtqho/JWlPyHdg/RARRbTLT0bIZN65+QMZvYY5m2k4dZQwf7vLz
	 njdb6CXPjAg2XF6+u9ks7qQjJaejpZDVeKOaTWZ6tg805xL5sUXWc+STq3p3R5dfk4X+a
	 Fw7oH4mSGFEKttQgqkUxHfMUn3Lv6ffDP77stqQaDjxwEXX9MOEx3Ckd+xG6GVtmypYXJ
	 byLKaoJJmn2+wxC1FbR+cJq4TH4GCPQwxQUNPEctMjhF1FBYMBvTUUtHtyEddDoMRYn3E
	 xxhXi250WRQYyq+Sk0AryES9T0f5cjWm1+0/UjcQT91k0sv+Cv3UZyuvgaSnn1ILbNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cC3QylXu;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00219606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 06:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00219606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cC3QylXu
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e942b1cc86so38469615ad.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 22:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794464378; x=1795069178; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uA08ZWVt/bTm0lpe94c2sMUhRAmYMvhXE/vdrih5bQE=;
        b=cC3QylXuOkBJcuiM26egHlrAWxVqHaqwt7BW3rf3hfWxts2eQCo99NOFUNM9OThYbC
         br5d6PQW4MGr4O/mvH6l7VhpT15vMaPdsFoS/4yAfJLR3TrmATfGFHHIpo1I//vetc2X
         9Ne/PJ0MMwWo1kVhTpmr7rcPdBKvETkknFA2m1aXj5WROYKdMQv07jihN4MqSihTkivW
         tD11w8Q20dbeGJhyWBNdxGrRIYxqDSfM/WddJcx43zH3UT+cL/57uAGUKpNlF4nrvrLc
         A3jg3w3rNR+X8MeRpKW/z0IYA37SRMvMA427qYqQTO3CpTYBOirRUlOwwQeM/pmGvdFY
         xtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794464378; x=1795069178;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uA08ZWVt/bTm0lpe94c2sMUhRAmYMvhXE/vdrih5bQE=;
        b=tanVdiMnUA1iS0Hl6BM2xAikIpdIZ53oOQeCYDGcqIUQLRgjp93VB7eJ85G7jbKv7U
         mbvBsczzGlrjhqVo303jHQbbjyFCyYnSiHaTeaHheFf8O/kLPYy9D5RJj5pwHgVflwJD
         o4zJY5quoLMPzw/xILuYnhWVty8SFygKt1RI067hCqEgMsh2w8MEWU+KpJeQmMCLfWVB
         frYAQewnRg/JiSWSfxmJn8aidHS0nIUMYBSwOoavLBikf4mysFlGSzMnWsJZSQLOSXlO
         W+5Pl35nkDIDedtBkZoD+fTCwG6/astAAo2GEt0IKHceAVHokeun7/0yKOHMFDeelP0J
         4OFA==
X-Forwarded-Encrypted: i=1; AL+hErEuHPnoonlCNVEWagAn6G99H2xMh1iYxawweWOMADuTURAzojOwFV/v9YrlkTDnnb+w0T+OFFQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Tfrti/eaHtU1xN6Mb1gdzfsz0Fn2UjagUlkkNvE5OgSHs3Lt9
	12UcRF00Z7cEZ+ePaee1MKX1WmQufMvfJoLdtaoh6ZeTkzH9+nZi6nNEP69brLQZAlo8ayAa1sC
	nmXsXPw==
X-Received: from plbja7.prod.google.com ([2002:a17:902:efc7:b0:2eb:16af:1567])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc4d:b0:2e9:9a19:c43
 with SMTP id d9443c01a7336-2edd7ab1fefmr46833585ad.15.1794464378116; Wed, 11
 Nov 2026 22:19:38 -0800 (PST)
Date: Thu, 12 Nov 2026 06:19:37 +0000
In-Reply-To: <20261111023222.77227-1-sunwenbo@cmss.chinamobile.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261111023222.77227-1-sunwenbo@cmss.chinamobile.com>
Message-ID: <avVaUr1ZOMeEEXsf@google.com>
Subject: Re: [PATCH net] af_unix: Inherit SO_INQ in unix_stream_connect()
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 1342116488@qq.com
Content-Type: text/plain; charset="us-ascii"

On Wed, 11 Nov 2026 10:32:22 +0800, Wenbo Sun wrote:
> When SO_INQ is enabled on a listening AF_UNIX SOCK_STREAM socket,
> accepted sockets created by unix_stream_connect() do not inherit
> u->recvmsg_inq from the listener, unlike TCP_INQ, AF_VSOCK SO_INQ,
> and AF_UNIX SO_RIGHTS_NOTRUNC. As a result, recvmsg() on the
> accepted socket never puts an SCM_INQ control message unless SO_INQ
> is set again after accept().
> 
> Copy otheru->recvmsg_inq to newu->recvmsg_inq in
> unix_stream_connect() using READ_ONCE() to pair with the lockless
> WRITE_ONCE() in unix_setsockopt().
> 
> Found during LLM-assisted code review of unix_stream_connect() while
> comparing option inheritance between SO_INQ and SO_RIGHTS_NOTRUNC.
> 
> Confirmed on UML (x86_64) by enabling SO_INQ on a listening AF_UNIX
> SOCK_STREAM socket before listen() and accept(), sending data from a
> connected client, and observing that recvmsg() on the accepted socket
> returned no SCM_INQ control message.
> 
> Tested on UML (x86_64) against the reproducer, verifying that
> recvmsg() on the accepted socket now returns the expected SCM_INQ
> control message, and ran the tools/testing/selftests/net/af_unix/scm_inq
> selftest (all 6 test cases passed).
> 
> Fixes: df30285b3670 ("af_unix: Introduce SO_INQ.")
> Signed-off-by: Wenbo Sun <sunwenbo@cmss.chinamobile.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks
