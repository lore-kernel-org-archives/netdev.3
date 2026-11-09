Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794259563;
	b=vJp5AGSpmJWfWETN3qZLVM61sHzesWTc+N8iA7YMc8XoUKcwoWGKNESAPzHh7i+YYYj6
	 tJPnugR0z7il6CKrdfspROmpOOxNNdQ+sGBI1TbzK0EZ4oODk+A50MlO6ruoOWes4gBW4
	 kG+y6BqruKGEe7uae79UMJJXDY6IgnW4czHWruOcdT7YnpgY72Ket73ciLXSFl+RYzhm0
	 8Xce06PteqgO0g4NLrvPR7BzAQubYJVlyLHh5OAIIs2Y9vn13q6FP252QJAgv+JpOlLP1
	 PPr2wl8nVQueJH9pf2blF11fQwpksaGRPG85sQ+F2ocjbIk1JHLFAFpax1dS6bXpdTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794259563;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=So58nkxBn/1sh9oUy8UMMPh3nuvv9mqA8Gj+ns+yy5s=;
	b=nBZ/AEUv9TmkAhzwvW5+bVOn76ZPHPsXHbaHsMWDtHMlkOW/X/t3YAhshVX/c8F3hln8
	 HFmpjNqWpKF7sdFq+DrajN/guz7D0fKM4jXC0MJxcvej1IGjBKXJwqlJ9ILNrgyhVe0a1
	 Y4dRbwDCRlhfjf4FuUFF+U2eatpUbW0jyg0xLewUEfmGS9OIRGO9BmID53y8m6e3+cses
	 hw+y6qXyX360bEiVwOUF8s02vjpVV1zuOiqdVaVekPLcH+R/V0USXCUwilSE1hYZnDoZs
	 pTdx24OSLiBvs3Bl8UiS4Or84z0ea/YA3lVtZZAQL9T2MzaGvrLZXOu+JlEws5+qmdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=cPb9WBQV;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CAA606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 21:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21CAA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=cPb9WBQV
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8b67f25e6e1so610577b3a.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 13:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794259562; x=1794864362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=So58nkxBn/1sh9oUy8UMMPh3nuvv9mqA8Gj+ns+yy5s=;
        b=cPb9WBQVZGuA2p6y5G1rnf8qrywNuLGbquUytmjFSVK2c9cFSmSBsr9IJC1lNy4c4k
         nAfo2pimOolJx78Igw2BAO0LF7ZrC3nc07T0K0sKRfvqeXozq6HbSc5yPkbyI3+Nm9Nb
         ZMtLYYsAAn9drr1v6NLvmq9cXwVI7ZI6abXWMuXYSNe+VIGDA/k87IVuWp4jE8QOLtkF
         X8Z19WdwhsMFvagnoWQ5Ljd5k4/ECxoQ6m0okWPBCfGHpGzD2tVqzsyYTGS+ePgSyrqL
         b99W8w4FjFRO6Q6cbkpoJxjtd6Bkyh+oUYl8NCSxojZo5B1whJws+RIWVj2ESd0yQQSR
         Xj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794259562; x=1794864362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=So58nkxBn/1sh9oUy8UMMPh3nuvv9mqA8Gj+ns+yy5s=;
        b=dldMupPxUr3ssUODagVkKKI8SkAhSgDFaDDGVcymug7NGxkluaqg8t9MvpM6Vc8GMT
         gIA8UCEIoV0+ROaDHKy0PzTh8dYmyCiwNawpS9ap4kO7rbf4XJVvyUqtVm7hrlObZyHg
         TRTJQjybW+EDn9OSSK9iAblWxQJd7/tImvt/3Wc1pSvSGxQ8Ine8CsfK1JWmXLJxOq3l
         ToyfsBBTOv7J4KWccVQF2G3w/XoIVvl5JVtiebKMJ1z+WzqsrA3QJ1jOf8oEUw7pJZGf
         MHkHPj+MW0e+pysARRmFc5JQo9LRpSelm1u+ENoLaWdw1Vr7kHzho/YvEJ66cY5WNJTN
         8Ltw==
X-Gm-Message-State: APuU4Z8g2brgRCX1niMquT8Gb3NGWUi77NWz+ILdB3Hk831VbxiAGQSY
	auiMuBI2BBjIaRUKmlp9ZMogJX8WdU/UXSS/MilvKnpgzvJ12dnUNj4mgBFIxw+ZIuxcdkTA4CC
	fsHlqjAM=
X-Gm-Gg: AYBFou2jU0Inz9Fp0D1F5dNZiMGfe4/G2OAhWziYJG22euvU72opCkQjgZkt6Ar8eZQ
	1bCx3SfNrm1AA1hheZY80cGK09evxU+3YVlwbOe5tZ4Arqnk2SoRgiduKxYkSzJVEB4RrUggrHX
	5Tsoz33oHRkDOF50r5W9W3gJfPkm93OFuiOg6M3oIQpjl0WQSx9UHllOTtWY+xqoYhFxtr0Irua
	Kp3AQTIG2T0lSboY3QkohmgmmzFEtsem/VQsmkn9xkCTO8JDYVZe1h/mfOQc5qU2dW0KKsO0oGP
	eI7WZR+Zt6ThSAqYm4AKtyeLLx/5c/rDd09lYz9tkf6XMo/ibPjB+Y7/30Kt3b2/5jRRPx++f4R
	TylXPdwJpDlgwQrn38tyqcOl0pQUf8agGyzAtrkaF0klYUCzEOB+vHEPXwgsoC+3FyzSST6N/Dg
	RSsXvIyROPmz9b/5/B544ddKmWfLQwVqaeDwjPFKAivUXUJWdaibZaUJwAWAm/Etp4tEOS4TkQm
	XKoy6ZyQ6a+kEUmrNc5Hq9oREYx0SOdQeszECT2vg/iLlQ4TaTetCMQbKnGpaTO8fxp3BfmX6D/
	hIDZhJYE2371Si05fko9ia+VNb6Ud2ZRh997agXHfnfa1Wg6G/lP9k9pgle6GF4aWb5Z
X-Received: by 2002:a05:6a00:17a3:b0:897:4932:5098 with SMTP id d2e1a72fcca58-8ba86b939f6mr746526b3a.27.1794259562386;
        Mon, 09 Nov 2026 13:26:02 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa7de3619sm122854b3a.5.2026.11.09.13.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 13:26:01 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 00/11] ss fixes from an OSS scan
Date: Mon,  9 Nov 2026 13:25:16 -0800
Message-ID: <20261109212559.39661-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

Fixes for the ss findings of scan iproute2-20261015-004, plus bugs
found while confirming them.

The biggest overall change is removing all the fallback /proc parsing.
Even the oldest supported LTS kernel now supports netlink for socket
diagnostics. Users building their own kernels with custom configs
without netlink socket diags will just see an error.

The other changes escape names chosen by whoever owns the socket,
bound state and type values from the kernel before indexing name
tables, and stop treating a netlink port id as the owner's pid.

The overall output format is unchanged. Replaying a TCPDIAG_FILE does show
more: the recorded IPv6 dump was skipped before, so those rows are new
and the address columns widen to fit them.

Stephen Hemminger (11):
  ss: fix double close on sock_diag send failure
  ss: drop /proc fallback for socket listing
  ss: escape names chosen by the socket owner
  ss: size the TCPDIAG_FILE buffer to the record
  ss: replay all dumps in TCPDIAG_FILE
  ss: bound state and type name lookups
  ss: fix rpcbind service cache
  ss: read socket SELinux context only for -z
  ss: check owner before naming a netlink socket
  ss: keep following events after ENOBUFS
  ss: report a failed SCTP or MPTCP dump

 lib/escape.c                  |   7 +-
 man/man8/ss.8                 |   3 +-
 misc/ss.c                     | 874 +++++++++-------------------------
 testsuite/tests/ss/ssfilter.t |  26 +-
 4 files changed, 239 insertions(+), 671 deletions(-)

-- 
2.53.0

