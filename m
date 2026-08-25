Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472DF32B109
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 04:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787633805; cv=none; b=A3Om6x9mY1Z5jLAW/iS27Ur5UcIoL6pndz1sWZrppbGzjXNaw3PFCUjLUUi3DtxD8qvTW2kGX6DjgB3MoulA9XAL40tN7I3izPukelekwKaTo2p8/G0iWf2Zvfv85fiJr/dr+2Sru/utiF1V2vWozlrfWUEtyfcUntVTlwT7TWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787633805; c=relaxed/simple;
	bh=xh8zMmJjjGXC6wtiuYUFUCvEzj2uoVqq+mklBD7siOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KkdFnFYr7lZj0uJk2tqpB6oCGXrWsyCylQvME+6D7Fxxydt25vTKstFy4pN8TTYYXncaFL1/P39KLu8loLjfy9KGI42Mk6hM/gT9m6CwqDFoPEg4P1dd16gzpxt2AZj1j4i+YbP2k9zAs1q90KgExtxg2aXXBk3+oPTWkCRGIhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V549B50A; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V549B50A"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-66c82b32121so6444867d50.1
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 21:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787633803; x=1788238603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xh8zMmJjjGXC6wtiuYUFUCvEzj2uoVqq+mklBD7siOY=;
        b=V549B50AskZb/pSEw2NWzpGu0EPN7QJCl3ht+YXroBFnoAAKKO0jmaWcEv9i2neCiq
         D7kIv2XX23XLEJ8nq4tj88sGdJfKSsUSKtrVybrQqfVyhaU8CMAIxUN9iiPvR9r+Z0U0
         U+H1BuOZkW1cLCEJf3JxK+p173H3rH5s4GyJHl7Z1Xsb19vevNqL6xq3nN8MmWBTBtM7
         qucMchabZCLuoP/3a5XaBVGvYHArT1SRuW8mqVx/bFiO7qZ3yX+ZH5nj+cpt8BhAPnZl
         ftnnSW2LJbObrGN0CqSqHBcU6ARP9yIa/OZ4SCWRvYpcSJtX2VYyQeplb4eFB+VeYmuf
         WjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787633803; x=1788238603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xh8zMmJjjGXC6wtiuYUFUCvEzj2uoVqq+mklBD7siOY=;
        b=iKKYI3Y0lFwW1yRlksxYPisBY1rCf6crXmLDxwysrXBWl1LjdGS+qUvWipznYEhW9A
         Kivwrme++oj42YivQGngBmCy2p/tEVM6/CiwZFp2x6jltGEbk2ye+6KyD3hgNZv/Bm8K
         QqXK3gCoWCdZXqcMrWCvgJ+jl2wkeoKv9Tr4zdR74pM3SEOlIxOGWvMEUx7d0CTP2UMb
         86B1Utww/aw3LBBgJgQR+tiV+wWQ84Riz7bGOb0qsAmfEOxreur6U6/BIgD0QriB0ctk
         BEnFXk+hiF7D96NIWMZtbT0wy9gx/E5L0crYVsRMa8P9GSpsVvJo+rhrHJmTEUzbcE5l
         QOcg==
X-Forwarded-Encrypted: i=1; AHgh+RpTbomD4WAuSx/wLH8HyqeL7xcq/NmzLh1ClO5elBXesO+m2n1YLchevEM/r1SJKXLY5oRrShY=@vger.kernel.org
X-Gm-Message-State: AFuF++k+FKmAMvSWBGqDwaPhRM7tXPlJUEYEuEVB8tqH/AQZG+i/Qa6M
	FXNvjx23JNv1zI75XCAcS06hz8KuTIRjYLw/c/zsgPzOpaeBWO1yPMXk
X-Gm-Gg: AR+sD10O0AgzdtkvWmcZmx6od8nS0Eg/gYiy84+2hgjUquNU0HvnIk7Lo9Z2J/U+kMC
	Or79GECNtWpVRL8Dxn0avqJj/Msc82lAkgRhBdF+V7BCqEkRbWRB1XlvX168lUUWF4tRpe+vCpx
	3rFNBuhBQrMk1C27EXePh/04ofU0sG7dEv0YCcmAuJuuQJS6IoUDf67I2uJ9YxXmyNk+DUXUECC
	4TZXtiewQz6DNDoIDBtMfqDs3BMwulcdqJQ9R7MKHrSjtcPSHCEasZcWeiZJwm2ahGgc9uw+pST
	pdzadq751ZdnV4B7ji6BUtVa4otLyt2hxwyvBJ9j2GDfeisPOdzZ8OuMIO0jlQlaxvqn8apeR1K
	etXPJ2A4rJPlQChIVLuB3HLn7Dl5MJb2yMT+ncRxcQKuqCaw23zPrTRlDco3gTZYXAKc4b80UBm
	XoujoAS9fQT4t4epBlSUfbqWhXxu41W+S2VNZkSUdrZBmnuAS5/W3l2EBmnM0HvajRurs=
X-Received: by 2002:a53:b3c3:0:b0:66c:486c:aa07 with SMTP id 956f58d0204a3-66cf21bd42amr5572435d50.35.1787633803283;
        Mon, 24 Aug 2026 21:56:43 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84ca62f6799sm43525737b3.19.2026.08.24.21.56.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Aug 2026 21:56:42 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: horms@kernel.org
Cc: AutonomousCodeSecurity@microsoft.com,
	andrew+netdev@lunn.ch,
	blbllhy@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	kys@microsoft.com,
	laforge@gnumonks.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	osmocom-net-gprs@lists.osmocom.org,
	pabeni@redhat.com,
	pablo@netfilter.org,
	tgopinath@linux.microsoft.com,
	xmei5@asu.edu
Subject: Re: [PATCH net] gtp: fix NULL pointer dereference in gtp0_handle_echo_resp()
Date: Tue, 25 Aug 2026 00:56:40 -0400
Message-ID: <20260825045640.39522-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260819124820.GR265046@horms.kernel.org>
References: <20260819124820.GR265046@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Aug 19, 2026 at 01:48:20PM +0100, Simon Horman wrote:
> I don't believe that this is sufficient to address the problem described as
> there is no synchronisation between the reader and writer of sk_created.
>
> I wonder if this might be addressed using smp_store_release/smp_load_acquire.

Thanks. v2 uses smp_store_release()/smp_load_acquire() as suggested.

While reviewing all sk_created access points, we also found a teardown
race in gtp_encap_disable() and a missing RTNL lock in
gtp_genl_send_echo_req(). These are addressed in a new patch 2/2.

Regarding the Sashiko review:
https://sashiko.dev/#/patchset/20260816035205.57966-1-blbllhy@gmail.com

> Could a concurrent RX softirq checking gtp->sk_created without
> smp_load_acquire() still observe it as true while gtp->sk0
> remains NULL?

Addressed in v2 patch 1/2.

> Does the error path in gtp_create_sockets() properly synchronize
> with concurrent RX softirqs? Could this lead to a Use-After-Free?

Independent pre-existing issue.

> Could the KASAN null pointer dereference actually be caused by the
> teardown path? Does this path need synchronization to wait for
> concurrent softirqs before clearing the pointers?

We reproduced this and addressed it with another teardown path issue
in v2 patch 2/2.

> Does modifying the RX SKB in place during an echo response corrupt
> data for concurrent readers (tcpdump)?

Independent pre-existing issue.

Cen

