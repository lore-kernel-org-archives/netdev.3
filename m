Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA373BE62B
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 12:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782392212; cv=none; b=q2bWr1iE7Dd+sKYXiPKjW5cAJEW1Bnctw0Vsc9jqKla10VUJ8FKEwMi+BcA3MXaFw7ec7sUo4FL0hiBO1YHC2QYBR6ACsnNIic50PWSGZ+W/yw0JWSeAsrNK3xifUH9XAErq5LF3bzEt8yfF7GjJKo1sL2TaSboNAUmNjIYriCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782392212; c=relaxed/simple;
	bh=5YpAJgY9oE7RUhBs02qMJeES/R9xV1KU+HJ49b2OSzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pYeGcMsycrJmdZ/d8tws/4SvIpd5ZKZ3ZkSZmRvHsWl5XYQ4q3wCZNDReuzUTesoVbk+5LkYmJnaC4IeHf3nc1vmchmwvNOX+4UXLNsmibTr20sE4WgEclsoiPPVyZxhVH3QIPHxVCSn5SDu0m7uNcNadrkdJJW5mXJtOOIxAD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEcUaYah; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEcUaYah"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c85d4b4245aso1331576a12.1
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 05:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782392210; x=1782997010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YpAJgY9oE7RUhBs02qMJeES/R9xV1KU+HJ49b2OSzo=;
        b=WEcUaYahaaPTCAhpicpUOt0qr/2BIpAfnEhK87mjPJIe6lA4HYK6gph0CNo57iIGDk
         ma/LlcmIO3c56jS9hw1YFa7oPt09wb8zkj/KTEL8zzOooFfXUR+sp96BNTUVJXRpXgSO
         gi1h2ag3J62sd/pW2egSk18qYW9o9nPE7ldH4tNSI00UvXnUJrYSxSAn34OYSrDHLw3z
         qDcK6ixetP9fF/P7bd/RO39D5GsOozS0LeJoN3a98qi4WY1gxd4tZ3bTH1WkF7g+2Lwl
         yz5gEKgYdKrgX1CGGZWz1vW5PMwgrsx09eKyfrV5K3c3Ls7fJ7YxMN6WYliZo3ig4aAQ
         NyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782392210; x=1782997010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5YpAJgY9oE7RUhBs02qMJeES/R9xV1KU+HJ49b2OSzo=;
        b=lZDrnXzNvQmiKe2vT2Zy6zwWOwqybfvW0vzFkvSYTOBp3OBsJAy/ijJ6fJ1mwwdrWa
         +/2fsrcGUsmUX03YZRCu7jkP44TdfKRO35EIPwqiHS60qOFAnq9Y4saUa1kdy5g06ufV
         s21lQhi9DagnshKU79aO8tTRui9uA5uZzXBcOuCRteyaX8mFk5RtXZPg6pEF8nQXROtX
         jG6UDL0TTC955CFD5OJElUMlNFMBQ9BsJc+HXZY/IZReZZK+kyMoNydsA2gyYbpXu10O
         wBx65LHtz0msw713vUEoS1jHNpMddbzD+KT0EFcCqwJW9Lc6ufu0XJxwQqaQGIQpNu0Y
         lb+w==
X-Forwarded-Encrypted: i=1; AHgh+RrAqbQGolS57cCf95SWvHJiAbxEVccYf83vf3lztJjxicK6UMBklL2g4nJAg7KEsDIg336f/Ts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4TTaW+MrsOR+/AbpLoyWLav22CHmt6a4fR4QsRp8cUeeTavZG
	nGvcWpKiLHR7p33qnem0CaVDjIiq9bMlvBhkBC8/2GxESWHT8xH8sCdY
X-Gm-Gg: AfdE7cn6+OiHmBZiJrnAhCiq/LtCMcQhCPEgq5HgaZ/dTPbQe+Xbas3WBVGtOZLkOsa
	Ae0TAo8nhLcM9uFD0UiLSMBTUKK0PjvBpy1iPV5K7vm7eSweCj8APm3g/0uXn9z+QabK1RQBK4v
	v39X8HvUXSNVWSFEkVie5xLS4VZ6R9f35TWzyOHMIA9Ul2A5DA+a25caf4yftNQWPhjiu+XC6qs
	fTVcig2ErXs0TH6VLaQ3zBQ5K70GTVkKExTD3JvGQRVlpiwyzSuluBXrDV3+l9oksHImP5No1xr
	BUf4Rh2KB1PXlV0Ixsm6eMQnfiMg6qvSgomoY4a4muYuGhcgrbmQH1SpNM5Ow7YWff9v/Ld3Q+h
	jve6boPaHRlI57Kl6gOPUyxg33xX07hZf8GtXy8xzuy2GcaOXQdiER8tY4zYHN2tQFcM4FaKNep
	aTlwjGZmlk3iiffQ+1ZNgJDNeZDMQ=
X-Received: by 2002:a05:6a00:80f:b0:82f:8e9f:bdd5 with SMTP id d2e1a72fcca58-845b39e2166mr3211912b3a.1.1782392210317;
        Thu, 25 Jun 2026 05:56:50 -0700 (PDT)
Received: from online.mioffice.cn ([43.224.245.228])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a41474cfsm4517619b3a.61.2026.06.25.05.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 05:56:49 -0700 (PDT)
From: Pengfei Zhang <zhangfeionline@gmail.com>
To: idosch@nvidia.com
Cc: dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengfei Zhang <zhangfeionline@gmail.com>
Subject: Re: [PATCH v3 net] ipv6: fib6: fix NULL deref in fib6_walk_continue() on multi-batch dump
Date: Thu, 25 Jun 2026 20:56:44 +0800
Message-Id: <20260625125644.1044294-1-zhangfeionline@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625122411.GA1175897@shredder>
References: <20260625122411.GA1175897@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Ido,

Thank you for the review. Thanks also to Jakub Kicinski, Eric Dumazet
and Kuniyuki Iwashima for their feedback on the earlier versions.

I will prepare a patch to fix inet_dump_fib() using the same tb_id-based
resume logic and send it to net-next once it opens.

Thanks,
Pengfei
