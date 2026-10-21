Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792604136;
	b=qrV9xjQCwY2XsQv4CbTz6Srq+a9ad58qpJAm1GrwKHIQxgd6dKACdnQO5MXIuPSSiT8l
	 mx/H8zWDw4UOBG5HgCMwMuRzltaLxVIIbrOmEAiJOmAjlVfQApWXeE3PHdqee2imbCH7d
	 xyOa/pqxqzUMrotu982duS4Mzx/w84RCM0gPWsqCiVllAdFsDje8T1tCcBFelgEK6lV0m
	 MO7gTwPmPx68B/ARon86zBIvAuLKkwnSB7SVCVQVpXWjZ+9QnD/zPyO7r07VISgp3+JQ0
	 vBMKnIjlCJvqO/Dt+ZSg9Zewn0br1+0iy3OmBjSTINthnwKCOZXOhnRLr5nNDJb/Zbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792604136;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=oxoj2YGJZNtWF2GcnFYxZH0FxZtESaQb8g/zpGRT7HQ=;
	b=HnWTFcKctMW9zXiaV+HrNM2L9IYDk9M3GVly7udr0jeWN3AFh/fYUDXt90XvjOz+419L
	 KEEyOXux1PmwnLRekZmTSQM2WRkHdDoyD6vCnDUrmB8kEsBUIyIfsbtht34EYHh9exSf2
	 5hpD2zswBHWqejGjv1trUcv/jG7emuakD2VIjOIqjVlp2om1IFGNpxKSkEuIbF2ILFA0F
	 fYjdul2PlLdh2oJCwjm4wDuq+okKmJgnAjk91qEdOe8dPmNP6/fmaeIhF4BI2QueJ8xoK
	 jJh3hyz7CoxV2nt0+0tTehePNojomo336cWDm7cY9pM5Mdy9/hkUKuJecaR3fI4vocg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--eugenehlee.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=a4xpCErp;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D03606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 17:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93D03606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--eugenehlee.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=a4xpCErp
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ad30487d55so1263302a91.2
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 10:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792604135; x=1793208935; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oxoj2YGJZNtWF2GcnFYxZH0FxZtESaQb8g/zpGRT7HQ=;
        b=a4xpCErp1BLm5cVDAZeTXOqvxyO1Ce69bhrKs/KQlPTKe/fahFoLk72UqNA5ZxFnPC
         NX63q1bXJtvVttpmTLomSIg+qHk2FGu8H/oe9ykgBcX4Yg0Cj94oIYFtZyP5ZCOz0KES
         qgcmofIt+RutPcpWo5eocgK4JG6RaoXvUC7g8G+CK5SEuJ0kuUrme0Ks+bM/ev0HPKl8
         qvZ2VHVkp4ihFrbg/QRjpi/qdRI4kSj5GGSqPkbRM1a50u2jip4D5wBOrCExg2mKtxd9
         W0DoqN3gw0J4gq4R/aI2tLw8s067GPyIiDUo+9FVe4VMmd/WA5UDy4l43KRNWOOWGm5n
         +Q2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792604135; x=1793208935;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oxoj2YGJZNtWF2GcnFYxZH0FxZtESaQb8g/zpGRT7HQ=;
        b=2V3JXaD1Yv2BC2oMk/yGJa8r4tP9eZ4zbcDZtSExj9wD4+mJsIw3tpOl/4P4UeP27z
         ngnCjxwlNfjl5YVQ3oBOePXYCBkeOEMoPHE8B0PBE3d0aqoOepJVetRqIqyW6iWY5aQq
         31GGBEm7bZrf4HO877O/pCJKfO7q3fHsUff09pmJzjcxk4Vy8I6+PcQQz3eWsmWqPk+1
         j7amqb/BbpJwjLKftgM+KPFA3GvfI4hFch5ww00sMuRKFTsmkMofCV5LAW8PzuwJ4FNg
         UEBj5HAhMlsP1qSFSveXytNeSJzHg111HgNW1NXQAdp5fa4KYtFZbDoj2QHEASMq6PBQ
         YV0w==
X-Forwarded-Encrypted: i=1; AKwUvBxYXsE9WcyGeXSdhrrUQT3AWY8nvfP8mNhyDOfx1epEZNapdOEjDKKBQeWP2yThoZNPFYD/y5Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1IN7cYPoExK07o7b9wFuHBbT2rCQpmKPxvDVC5PDQwu94SsMI
	q3kAk4CHEMEPuQdcyOJd9npUQEl65VRLluTBE/e3qzESIbz043KjsAVI+uqNgxoDhf//msZxY0U
	CFJZQo4Z68yTqe7HErrdW2w==
X-Received: from pgbj21-n1.prod.google.com ([2002:a05:6a02:61d5:10b0:cc7:8db3:268c])
 (user=eugenehlee job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:580d:b0:3aa:6b5d:a00a with SMTP id 98e67ed59e1d1-3ad86f690b3mr2475625a91.53.1792604134739;
 Wed, 21 Oct 2026 10:35:34 -0700 (PDT)
Date: Wed, 21 Oct 2026 17:34:41 +0000
In-Reply-To: <AS8P251MB0001135AF3233180DC42DCD1C8672@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <AS8P251MB0001135AF3233180DC42DCD1C8672@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261021173441.702884-1-eugenehlee@google.com>
Subject: Re: [PATCH net] gve: fix out-of-bounds read in gve_get_flow_rule_entry()
From: Eugene Lee <eugenehlee@google.com>
To: elb12345@hotmail.co.uk
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	hramamurthy@google.com, jordanrhee@google.com, joshwash@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, stable@vger.kernel.org, Eugene Lee <eugenehlee@google.com>
Content-Type: text/plain; charset="UTF-8"

> gve_get_flow_rule_entry() checks the requested location against the
> first and last cached rules, but rules_cache_num can be 0 while
> rules_cache_synced is true: GVE_FLOW_RULE_QUERY_RULES returns the rules
> from the requested location onwards, so a request past the last
> installed rule - or any request when no rules are installed - returns
> zero rules, which the driver accepts and marks as synced.
>
> The next query evaluates rules_cache[*cache_num - 1] with
> *cache_num == 0. The zero-initialised cache does not trip the earlier
> comparison, *cache_num - 1 wraps to 0xFFFFFFFF in u32, and the read
> faults about 352 GiB past the cache. ETHTOOL_GRXCLSRULE needs no
> capability, so an unprivileged user can trigger it:
>
> BUG: unable to handle page fault for address: ff240996c4c64fa8
> #PF: supervisor read access in kernel mode
> RIP: gve_get_flow_rule_entry+0xd4/0x110 [gve]
>
> Treat an empty cache as a cache miss and re-query.

Patch looks great! I had this exact fix queued up internally along with
a regression test after reproducing the crash.

Reviewed-by: Eugene Lee <eugenehlee@google.com>
Tested-by: Eugene Lee <eugenehlee@google.com>

