Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492317;
	b=D9d1JtzTl1a8Pt000cVshJyKDysfrkhP4DoMjMK8RqTqu5UXq1HeNvDyJhQXpkbcybXP
	 QolQgG1DgCIvDsyhaEZjfJsyMZUF9EVY+xh+H0s/VA/AicJaQYCEjBH3akoREutUjju0g
	 FCRoniN4E7xoHOoox6iTcdLAX1QUp/dlvdgcbVeicxZ4fnfCeFxwOvZ0tTjK+szJC8bVF
	 jP1mfW8iOWutbE9IfNhQ/CVGRR2PpJ6jQmW7abcJpJqBddINT/O5Epp1ueInWnQ1L8cpm
	 JG7oBU0tsQHjkaerS8C4Alt9wUCV66zNeeimJGbMMcWW50C3HLfXlNEEJXtEcTgFcJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492317;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=qwOHr2x3L679VhytAnH3M283eQvtUAQoXPmyYPQX/nw=;
	b=UUd9u2urtPQFx9kWah2xrVfToRZQagvX9nw+l4Jc/XEh3k+jD1+1qTzUuA3oS/dtMsO1
	 S0rSob4ZnHhZWBfLvEVuE0lGq17pnYARL5+MQArIW6Z+/pXYzPjU9vMX4Ch7xESEh0zO1
	 ub/u25v36ljoLic+HaiCgngvjYzbbooDELJ5gHWoPG/jvRURoVR/YKCc8NsOXCQr54a14
	 4ButgmvrmtSnm9SGi+c36LJa3jvdh4L1RQKckSC7BbQP2RcMmO91IRSqNmI5o8UF4oNEN
	 x1xgBITVOQVLJlt69F1bQoHh+rOrm9BiM9LiL4CHjS+7/Y8omH2UXxb1B0TWKWCYOpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="fI/l4XZW";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=g+cw5PSh;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB90606A338
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 14:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BB90606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fI/l4XZW;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=g+cw5PSh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794492315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qwOHr2x3L679VhytAnH3M283eQvtUAQoXPmyYPQX/nw=;
	b=fI/l4XZWEisf4VO5sxe76eUST3pzAeeoLaztAegxnmOhpLuPXmeg3h+hJVzX+WqvZJQHqo
	PxC7FLa+Cg0C4sXxe7zkFXZu76ztnBguHQlyJErUDCfHjUE3DybE1uWUS03VYp9b/VlNby
	uPdT5Ue4gIu+6W1xKxPKsWNs+MGBNHY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-pOVSyhTPOPmplW7E2hYCAQ-1; Thu, 12 Nov 2026 09:05:13 -0500
X-MC-Unique: pOVSyhTPOPmplW7E2hYCAQ-1
X-Mimecast-MFC-AGG-ID: pOVSyhTPOPmplW7E2hYCAQ_1794492312
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4b9f7cace4bso39959965e9.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 06:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794492312; x=1795097112; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qwOHr2x3L679VhytAnH3M283eQvtUAQoXPmyYPQX/nw=;
        b=g+cw5PShQ1TmdYi/Ffx1rNJE34Y90yiPGG5zzOZ1RoI4DT9ZjcLp9bDkZDnQDXwCGW
         n7Vnqx9eDfmgQd88aMjG7A3GtFd3Ab6OGtEixjGIigoDrq9NAYQv1T3aDP3E3FYRFHwu
         O/3UyX8tMOBIcY8vnhAzJBC2jNnJjTar6RNuybDwIvnvvrtsTeG0lJDl+tygtU6LpQha
         r7qmXbC7XIqF9Sh4aCHVlAyTIE9zOM1TwbeHNUizKZSZn44kT3BspMC9q8m6mgketHAa
         44UqaWzNr/ZgOr3OQPzlMTOnbtbV/ZO7m+BgQ+2xZNLPJArYW5mKz+IftthH7BTk5j1C
         5Uqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794492312; x=1795097112;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qwOHr2x3L679VhytAnH3M283eQvtUAQoXPmyYPQX/nw=;
        b=UIpK5nqo684s6yHZY7fMNAwMNhQ7M1JD55T/YuRmP7vZG7wJN5xhofB/X/eMzeI/RA
         L44j4r+Kma6wk8+aoao6xC83cVdg2KGTMG0i5laFX8QMi45cVSFFgAGH/5yiteeOsEAb
         Bq5AolC270yM6Nspr6zFo9tz68A1BnauYhnZxqKhbSVGm4kjpI6rc2JraLZPOX2Mv+bg
         gjy0ApULx2K5m/JtPTRM8kEFManQO56Rxlu4xAJGTzoDoj0dv8p5NHne32jLY+Y41nfF
         rEi9KIeffMIkSfs7lD5SvrNu8vXQJOMVQugpLCX4JYBfb9PdO0Pv78Not81h2EPhR6eO
         xXSg==
X-Gm-Message-State: APuU4Z9XLU//7PrB15H8ELkCTtcj5QkBbw+qjiAdCVn4ZGog8CklVOg2
	9r3vL3Qvqm91hrkYzU8Ixv0kP2dm0mRtQ0LE20LAT387G+ns3/SyYCuqbSAUVIfTXemVo/r398Z
	EC0QQSGDHjY+fIXTnDshlidd6M4bePBKHn0iYeIgBcACCxcDWaF7vYrAzRg==
X-Gm-Gg: AYBFou00lqdMy3UMMugG7MYp/IPB1Mdq4m3UWpPU7jBb/Q2I8tLj2eIujLrzyxrRqRm
	rvQE8hZcAh7GqV31Dwd+rGVUeQGG/jJ2TZ3ws6Yai1NoJtxlem53RcyxjX1+K7mUR9uwfWmjWxe
	JtLe9ugu1gOZILpKmeRetRVog4c3LNV3Un8/ZC3sct1mL35jEeh6WxwMGp4BnFGGrdRiI8brSfR
	GgRo1tSfiFaVr9EMlpQqqPcnHWgFfC0DokGoxEZLX9sU2IXCZlb/D6RCx9zTXNxDsQ3D8OjNFq3
	6i3cUS7lzj90i+VWU2rfLFd9bgUPTScuEuqt5cV3klWRYFL/M8rAjMDUNR3uIyuDsN3YpsHTSDx
	6/Vm0hVN6ccdEHPSoldMEZaQ88KieJ+27V1wZ+4WubladJpfFnbW+jMNUq2zjgQXPGrkWpxz+Xw
	VN4a2qbcHRsqBS2v7F0UdfrpYK6ugqgQ==
X-Received: by 2002:a05:600c:3486:b0:4a1:d8fc:8165 with SMTP id 5b1f17b1804b1-4ba093b981fmr95344845e9.20.1794492312289;
        Thu, 12 Nov 2026 06:05:12 -0800 (PST)
X-Received: by 2002:a05:600c:3486:b0:4a1:d8fc:8165 with SMTP id 5b1f17b1804b1-4ba093b981fmr95343965e9.20.1794492311603;
        Thu, 12 Nov 2026 06:05:11 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498366c43f4sm19847458f8f.47.2026.11.12.06.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 06:05:08 -0800 (PST)
Message-ID: <06c0d36d-3492-4fd6-a6cd-8f328b202baa@redhat.com>
Date: Thu, 12 Nov 2026 15:05:07 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] selftests: tc-testing: add gact probability
 dump tests
To: Linkui Xiao <xiaolinkui@126.com>, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linkui Xiao <xiaolinkui@kylinos.cn>
References: <20261106064114.3592670-1-xiaolinkui@126.com>
 <20261106064114.3592670-4-xiaolinkui@126.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261106064114.3592670-4-xiaolinkui@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/26 07:41, Linkui Xiao wrote:
> gact probability attributes are emitted by tcf_gact_dump() only when
> tcfg_ptype is set, and budgeted for by tcf_gact_get_fill_size().  The
> only gact cases that look at a probability today are 8e47 and ca89, and
> both check it through `tc actions list`, which is served by the netlink
> dump machinery and never consumes the get_fill_size() budget.  The one
> case that uses `tc actions get`, 525f, runs against an action with no
> probability, so the RTM_GETACTION reply path -- tcf_get_notify(), which
> does size its skb from get_fill_size() -- is never exercised with a
> probability, and the netrand random type is not exercised anywhere.
> 
> Add three cases: adding an action with a netrand probability and getting
> it back; replacing a probability-less action with a deterministic one
> and getting it back, covering the tcfg_ptype 0 -> non-zero transition
> that the unconditional TCA_GACT_PROB budget in patch 1 has to cover; and
> getting a probability-less action, whose dump must report no probability.
> 
> These are coverage for the dump and sizing paths that nothing tested
> before, not reproducers: RTM_NEWACTION, RTM_DELACTION and RTM_GETACTION
> all take
> rtnl, so sizing and dumping always run in the same critical section
> and a replace cannot interleave between them from userspace.  They pass
> both before and after patches 1 and 2.
> 
> Verified by running the tdc gact suite (38 cases, including these
> three) against a kernel with CONFIG_GACT_PROB=y and this series
> applied; all passed.
> 
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
I think the value carried by the added tests is too low and new tests
consume nipa resources. Let me apply the first 2 patches without this one

/P

