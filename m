Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793846025;
	b=YmJhWtfEmgjM15BO9/WfIz/UZoOAROwUTZhlaN+SmsKtBWuy/23/hIMR/OM3quIX7Rim
	 akA1H9zIMPuv2sHm+b98oK/Yci86gD7ur5kcKT86Xgm5O8zzqetReDYZcEUgYeiCyxCHM
	 Cm6hHl0V07gIvFQ6UAwOY9jb0+Y5SbyZp1yVcEwaYHq8v2CyNe62kERjq/iqQRDUqf2Lv
	 fp3lsLI6q+04nnfqXAeC54umZxeLN3YXDFygKhMfOau1EARDnILog+BNZ3n0hDlCKM7Ba
	 5FTf4M0oWtZXrrQdM6FtovbSP64y/AhO94zFruheOjiDKMJ8/68phvHfMDNHQTc+czw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793846025;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ogRG1U/oWZ2H7p29NoIDQN8HgnZMCr9flXRbDMfJFOo=;
	b=5hQCkMYjAF7A3w6rTR9NePP/rdaZrd9NgeVInnvwiZWo8qukn+43YbkLoVGKJjET5627
	 1waKzPiSHwTb7VDIU0k+r6D0dWywYJzi9WNw1V2HYqNDu5VCesRliRqPYmcL2HWGAPP5j
	 f7PUhzbbhYSaPvLJmGHYAW3SuV0iYvG+v3HpzVjFwrQ+uYlUp9ing3JwGmXzKSQPklLWu
	 nia2EQtoQBkp7OJabYZm9elazm+HHuIjFmhuNqqodC5HOotGzlmjrH0N361YLih8jRJFD
	 9ugPpBVV0mPxiO3Cxlv1h3d8e3WNtUyi8dqxoN9AByAMLb6BxECYvxSN4+mOk9IDE4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=hq8bBSZt;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EC0606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 02:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37EC0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=hq8bBSZt
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3514b90bb89so2662271eec.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 18:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1793846024; x=1794450824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ogRG1U/oWZ2H7p29NoIDQN8HgnZMCr9flXRbDMfJFOo=;
        b=hq8bBSZttFswu0JV3y+wQGnqFu25gl323WYKtq6AGOsC7ggPyTWaOspBJkIfpebMw3
         wVBsR89X5CuNftPEGbWuY4z4If8fiW6uaMlz/086evHbyijIs2uVcmezpYnW40eKryjb
         eu8HfBWo6iXINffpMYOh36A6gFp/h2eMa+B+R1EWDt7/R3DCSebKFpzHNipFn1/2Btea
         tbBmIZ/ux2YESG+NbULkiaHs44QqWgSCfW3ovs0m+Ib5W8QftrXIzPqA2QVL2T2meVzi
         OscOnEDBBWHpZQWer5EXCVZKRoncY/a6aCILUp3APi7Cry3JWpXSQFiIYvVZQbKltpC0
         Af4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793846024; x=1794450824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ogRG1U/oWZ2H7p29NoIDQN8HgnZMCr9flXRbDMfJFOo=;
        b=l292mQ3a2K5sZ3/9hOINSGFHjcogskABO/NNsSv/de0nGVbrFZKOk+Vf5WL7OL78yu
         aEp1J8NW30C7709c6gRbFSl8AxdMxg+72WeLLXXRbJl41fVC2BcJihAcxO3VUh/tsPx6
         qg3cvqDLS+GItZFBTtR92c7TygGEuKEcFiM4sDIdgIRMI0npW8O4oYBKHZuQ8RunJY5L
         y4BwU6JpBxAVw6rAx2R3QXkC8F853DVmObxSMy7ddZzr5FybgwMyazlFZNnmxYpqJRE5
         5jpT36evnCoPWlA8PkB6l81m/xIRYZk/7w1sOnvC1bRZ+DQwp6mx9dDFGScd1iJ0AO2D
         cWSQ==
X-Forwarded-Encrypted: i=1; AKwUvBw3ayPKdm6ptHG8v+4oQkFNmuJJg5lZteBpku7VNHFYjLt35azSgAPee3WeuVpTH93Qcu6eRu8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8gals6w6oHgUCd0BrtEZYnX8vMxFZvFpev0OgzNLf6cFid7cm+
	pIQW0eE2GCA4S4NAB/qcNAXBCacT12vTMhOBrkpkpLdzq7x6ppbu5KyzA0qgzjV9JHY=
X-Gm-Gg: AYBFou0JqG30DnfnP/vDYzMrQMU4lMky9Ly0rlz9RGWzVkmcf20ApsqYly/ZS9mRsxE
	k6lhXG9Her/RiHDM44rPJw7HWFlU6cqYe1krlSFZGMd1zdujYZMxGPKZS57eSbxj8tpE1qDsu+I
	kbpywF2SzXxrom3o4qAUJL4KCO6hA1kIEPs/9BJM2sVtvPs6F8bIuWcenDDVem1d3o1g/xfWoSf
	UmuKDzeodMq4eXFl0t8IUlcXTNB1z3uokGXpnWsrTmsq6UAgq6AmgDVlRUgUzqFA4tHuZ6F1USt
	Ut3COuLYA4WSa/uF7FUmsIH4CanxEJQWYD0I8m1dYzIfuz0Tukw5RjJF5KHB7NmwuREWaiSxOmI
	QfdP6ayDfLUp84VaXhRcK3sorirBhNObpbcnzaQ1Nm88vDoSREiwwppZf+2ZlwQ8Zj6TQRALC9h
	9PAAL4pSiH4Ka4ihCvDwFM5TCVvhYH+GlEvU3YKaH6FG15PyZQQa3IeJJFOsORcGYpxkCq3hfFr
	GTTmaGRAoUwg2+1NSbB9aeugMgIlXL6m5evNSpOWnCbQTUdVq0NS/OSmkBYJYkqhgUmsLnYRIZq
	Tei5KGAW/8H6LEtLUxwNQd/3FkNVZp8W8tIzgAjOPlYJxIxe39nKrO/yF6ouiX1GXK4Vkmcb
X-Received: by 2002:a05:7022:f20b:b0:136:c443:80e5 with SMTP id a92af1059eb24-1ac56d94b0amr27300481c88.6.1793846024101;
        Wed, 04 Nov 2026 18:33:44 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c2de58sm11403400c88.12.2026.11.04.18.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 18:33:43 -0800 (PST)
From: Omar Ramadan <omar@blockcast.net>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] amt: make the per-tunnel group and source limits configurable
Date: Thu,  5 Nov 2026 02:33:40 +0000
Message-ID: <20261105023340.19774-1-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <361bbccf-6ce7-4b1f-bd55-4d8270423320@redhat.com>
References: <20261015231825.2852054-1-omar@blockcast.net> <361bbccf-6ce7-4b1f-bd55-4d8270423320@redhat.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 10/21/26 15:30, Paolo Abeni wrote:
>> +	amt->max_sources = nla_get_u32_default(data[IFLA_AMT_MAX_SOURCES], 0) ?:
>> +			   AMT_MAX_SOURCE;
>>   	amt->hash_buckets = AMT_HSIZE;
>
> Sashiko noted that with this setting is very easy to livelock the host.
> At very least you should scale `hash_buckets` accordingly, possibly move some
> processing out of the RX path.

Thanks Paolo, and sorry for the slow reply. Agreed: as posted, v2 lets
one Membership Update hold tunnel->lock in softirq for far too long.

I reproduced it at the v2 ceilings in a UML guest. One 64 KiB Update of
about 7,500 empty records, all naming a group that holds 4,096
sources, held tunnel->lock for 1.7 to 2.3 seconds.

For v3 I plan to:

- make the A-B case of amt_lookup_act_srcs() linear, as its own patch.
  Today it compares every source in the group with every source in the
  record;
- bound the source-state work of one Update. Each group record is
  charged for its passes over the group, and the report stops once it
  exceeds twice the cost of refreshing the tunnel's whole state;
- size hash_buckets from max_sources (at most 8 sources per bucket,
  256 to 512), and lower the group ceiling from 1024 to 512, which
  keeps one tunnel's worst case at about 4.75 MiB.

With those, the same Update stops after 26 to 45 ms in the same guest,
while a full refresh at the ceilings (512 groups x 8 sources) stays at
about 5 to 10 ms. UML is slow and noisy, so these numbers are only
useful compared with each other.

That keeps the processing in the RX path. Once the work is bounded, a
per-tunnel work item would add a queue and limits of its own without
changing the worst case much, so I left it out. If you would still
prefer the processing deferred, I'll do that in v3 instead.

Sashiko also flagged an existing race between the source timer and
tunnel teardown. v5 of my net series "amt: relay tunnel lifetime,
validation and request-path hardening" fixes it, and I am posting that
next. v3 of this patch depends on it, so I'll post v3 once that series
is in net-next.

pw-bot: cr
