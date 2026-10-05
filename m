Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05B9404BF9
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 21:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791235245; cv=none; b=juzfqFGJ2qnpT0ZNQTnWmvJ/+xcJpB29dF05+niY33p4Xg5xfJRPjCuBgyxtY4tYFekfmtjJyX79h1Z2zT7gmiCTWPg2QkFiA2nLd1TvkBp3FK9dI+HzQf6sTcrNKADSNIO1XYwyUGxyWwksA6FKrl04D9DujNyrvCGyKpLnb04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791235245; c=relaxed/simple;
	bh=eKEhRWg8r8lcVQlTsVVu0qrr3lXjUZhkr92zgqGRhF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nSm+I66BEwKNkkNJtV5GMiReHMt8nmPOF6FC9Df1VFkVTd8uO3Ev+znSlNmJ+LeQSN5CZ8zCqUwksraPNVZxmsp3vy5YhKUAm24LrO+kUA785xgRYbOo9NWHPffppQonVURN42er2BQWF5sR0bjPXhfCUH3vT9WqTyl9HptLCsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=0GW03P+/; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="0GW03P+/"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a1688d7769so14604665e9.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 14:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1791235241; x=1791840041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Iq44C5dsPAhwLXRlUUC1A0u7pKaUDbi940VQRcT8enY=;
        b=0GW03P+/V2U/QA+KGvBbndvWZKaUIWR6Phs5dV4YvSuU6ihg0FOqP0ZE0fi/uKAWjn
         fwwqAuilqXLIzbk8Xaf7eC7CuJAf+WXOkERp+4mjc/AetaXznzzyivUvp2jvBGG+4Pfr
         Ph8kuAhlN5Vv4IkpzP6j6BQDepKu0xvoy6XNR8tNTart9H5e/Dmpm0/WnZYAqHm+NsQd
         KJHhWMFU99Ge/YJLCs12oeqJRY5rzB8n1Pn+YxGIyGJGF1twld/hTP1FJdDBAu8w+gcP
         UbU4F0MynG7fxh00taUBUFPo1hfQNAk6cwe9Qu6Q5vDh0lEpc8Pj35OsGGvqmyp0hlZl
         c1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791235241; x=1791840041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Iq44C5dsPAhwLXRlUUC1A0u7pKaUDbi940VQRcT8enY=;
        b=YSMc6e5QIRMj6InWfPuo/9o5gDSrU1oO+HOjN1NwqffPBXfv1q69Vk+0H/MCaFvLSH
         K6Cc4iVsFI22ssB4xl4V0IsNvVMQBtVxR1UkfDPeR8gkX5NRdI/2JVda4ONwC/2AA5ws
         zGcb6CW1hDRX3wp1JVu64VWUpnt7zZD8MHVl1r7fKfinJ0ZkHR827DxYkSGsPuAmoaRe
         z5sa24AM1mRM5JII0QxifWXDzLanZycmb6+RGZwaMIwFDrD+z7NeTHrG8Hvy4BMxrv3o
         esAy/sXq928P5DokhUK/X1mYe7nHvDg9ijY3n9O9xj8krucGqdeDm3gys3A5mhWX71t0
         1KGA==
X-Forwarded-Encrypted: i=1; AKwUvBw+DthGdn0zD9y6FJAP2cGailcVnkDieQabmDy21Nyu/sgUBsnUm+wU8qo/n+aqTSzI0Cya9y0=@vger.kernel.org
X-Gm-Message-State: AFuF++kihsPZ2tpMwbxjcC8NsN/KSujJmRlZqMAWDgoVpZ+F7y9GaEoe
	ZEokoFohJGxDCGyZ3NrqeHmUT7Ku/V+pK/1gfWviAeYdbPmlS+1BWJkMdAQh0GjrKw==
X-Gm-Gg: AYBFou17g55FAfNRtQXoSmDQEdFWrTWiu6+/WIW1VjxnEjbRmnSRgpsGiDsKziMNys2
	SI5AwVrsEj9w9bS1Yt3EIEdd7i+6Mq7q+o8si0MjmnHDT81vH4S8LbxAytAyp80ekJUpxt2ZBWu
	z3yJO3M62qi8ZlZFqsUUXGMNE08Io/TT4xv3poXMqxm9eyEC1pQ1x1d7RUo2xdODrkaqV1DT03I
	fLKj0utcUWUzkNpgZj3P0cvqhJ9ct5bnOFFGptCIa59EHIqGSpw4vvFepGb/reWmNXPFEh+/U0I
	s3+ao+YnS31tm1xylwAuKFR2ugK0/28Bt/BWnkpN/13YvcNAT2PVJEvfcI165iw5NGYG9b7eXA6
	ZfbjB36TCnuoMM3xiTUfWsEy1xz+kgziTrBS1w1S6crzo53hq9CHbjWg4vG73hBYoag6AaKkSdH
	sAElOjCEdY+yj7H9nyRjuHSFfVwxCeG2u2v1BmvNGsJLE/IHo4oRIPDGAb5kHPqn30mKJNVc0UI
	teUR0lG2BgqFlOW/EcrrhKSvsdAXE4jqAWgjay7NbqRhGGCoesgaWSkBjseY5YhjKHUYfUoc7od
	UsFAPlwLslFpH4vWaek0srkxri6TXx0xifcXd7wn1KLSe74ws4YCCTeHiYxf430G3v1OjyHuYvt
	2+rwZEGa3alEpXZ7NXMLGDzXOfXQYwSx9MoK2i/Vm8cx3p2MrS4rnM6ZujZHrmmuPXcA=
X-Received: by 2002:a05:600c:3e0a:b0:4a1:6843:eabb with SMTP id 5b1f17b1804b1-4a16843efe6mr133495455e9.1.1791235240914;
        Mon, 05 Oct 2026 14:20:40 -0700 (PDT)
Received: from Desktop ([187.40.54.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178ca8127sm18607725e9.2.2026.10.05.14.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 14:20:40 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: sashiko-reviews@lists.linux.dev
Cc: netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	pablo@netfilter.org,
	fw@strlen.de,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH nf-next v3 3/3] selftests: netfilter: nft_flowtable.sh: check the priority a flow carries
Date: Mon,  5 Oct 2026 23:20:17 +0200
Message-ID: <20261005212017.2997-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005171647.3D12A1F000FF@smtp.kernel.org>
References: <20261005171647.3D12A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Could this introduce test flakiness due to a race condition?

I don't think so. test_tcp_forwarding_ip() waits for both socat
processes and compares both output files before check_priority() reads
the counters, so the connection is closed by then.

check_dscp() reads and resets its counters the same way, and its
"dscp_ingress" check also expects zero after the "dscp_none" run
counted packets:

    check_dscp "dscp_none" "0"
    ...
    check_dscp "dscp_ingress" "$pmtu"

The test passed three times out of three with the series. No change
planned for this one.
