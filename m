Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FEC3DD516
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 07:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789889155; cv=none; b=mShIwSsBpPgzIrUHMdB8xVJ5rBV6YNoQjSMJWlPiesP/NLNjdD0wjejZK204Ha9lRYs5ghgEw3HZh/hJkiC/tt1hcPD4O4vCeDw/wN/OsBJcGqjk8t3xrrpOiXI/9cBjktAs27hWfUv6l2v9bRtA7xT2Q2K6VKC0Jv4AzO6husI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789889155; c=relaxed/simple;
	bh=zh5Ol2TuPLH0d4OoeJAaGteSoIwYvBaEbtNs4QWKGvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZr+dBW2hOJDCPOhKYpB7HFOtoDid9WKAfRXdCfpSH34xUTlSYR1Wq2FVhpI255xvDtX+qLjg+XUEcdhUwMGz8pkZnZkTpwfBevcpl9AX9YFivjeKD4cfr0fr+To5lWYZnzhL3a6srQjTV4UfMAkWGVFQVZ1riS0Rwzj12cFd6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XoARAIA8; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoARAIA8"
Received: by mail-pz2-f43.google.com with SMTP id 41be03b00d2f7-cc4aa0f1a94so1403639a12.2
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 00:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789889153; x=1790493953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dW4gs9SAniP9kxUqfZ2XWITnN57K9b7RZGjbG0t6JAs=;
        b=XoARAIA8VigVO5HCZjH1NGMNoP3hps6yNiwZ3AncyCgViDK7upWcbMp8cwwxBKVNVS
         n21Mlqpv3jXQrAnzcowYkUD/2voSpPPh+K6eM/LJn3rPs+mG5NN6CutQq0FbtlD9iJHQ
         Hd9s6Njm2j2YURP3wjcz9u5LQ6t4uxpN0OhCHUasjMk8Nt5JT6kpZVsqr4f11SsU5sKL
         ZHQlZQYRUMnY5LT+59sohDJNFQBIdURPXxcvTwgrFMspM+Aa9n+MYd0ejBYHX589C9GX
         m7oG14h6zBICGXRJcaYogeExxJuKLVcLMoA/4W6NSmdV4ggROoO8iQMulLCNhHlSs8r5
         +BzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789889153; x=1790493953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dW4gs9SAniP9kxUqfZ2XWITnN57K9b7RZGjbG0t6JAs=;
        b=aZYD/NpzTUa2+cg8xuyTxKpWNSvuidSGTXqpUBlqhj9AonvUbD0Kl2ZsxAV9S5CVc0
         eEUgN2AUJlacnLA6HinHlNYzLepKZcHzg1AevY0cxUS2oLTS4v32b4V5ZZeExJ+ifbBM
         QCQEfdlHeQmk29C2fCkJMkj0Dcx3affB965Sqre7k2PBLmJoAoO8YBhlVvqtd7YmSB2K
         3OknJFVvPDoPBF4izyfcuo3q+MkIQ/RHodqwdSNBUBnJiIyThKIGN2JbA9Uc3wGXq3G8
         CWp53Y7OEjwWnFFgwHtys6X50eqhKz2T3S9B1a/fUKb+RU5YQv6gulYC/9KuA6trAyzx
         7fag==
X-Gm-Message-State: AFuF++ldx3yDEDxrvvJBG2qUdW7AzCCNbf4YXXHBVjiPTjr7htnIv3vz
	LKm8P/+dwauYRpVD10IaxlXf7Bdktp76gSrKa4g3CD6zjzqc2Nao3GWEqS2ovpJJzCw=
X-Gm-Gg: AYBFou0bVil4+2meE1zNKl2qqF9WKMlGudxG58CgxqnfPbGXKmP+YeekygB81jnaek3
	6mSptFUqg67k9KY08Nw9R4uLBbpR077lOhkF27OuIFLw23Hlzk7xvV4VLE0S0bclubJak77u/aY
	phvuVuBQTh+Vyy3k/3E/8ll5ary2BstU6NI/0rjWxaZS9ktPOKNLB0hpsUGn2aeMaICfZmGJrD3
	uDsmoZpFxGbikLescVvu41+VwEDueUwKTRg7ussa4c5Pl0ACbufrLrMpyaWllBcTl44SuTBe2Mv
	X/kThULZ1IYLAEuP6VdWFoJ3xpN24WoiK5oQN4mqoVnNLyzO+GZPVQoGlabVtlFl/25xbrKwCbU
	ZuXJH14fH6ZoFGJBTyFBLLo1bCDE1cWr6iR+SW5ZoNCpMYo1OY1enzqVzHrGJ+5VWYurWYYGXHV
	UIIguX8thQ06K++mCb3CwvL4Kgbptq57H1hXSrO0XIUV8uEkvMKoCDTn1di23plZoltEF9PxyPd
	GhXDOQzNR7ilEMHIYn2vw2PmLBx92CNRjlXvTcFO1TrGxK77fxB4Etvfc1a
X-Received: by 2002:a17:90b:4d11:b0:39e:6c69:34cf with SMTP id 98e67ed59e1d1-39e6c69373bmr5984342a91.51.1789889153573;
        Sun, 20 Sep 2026 00:25:53 -0700 (PDT)
Received: from lenovo-thinkbook.lenovo.com ([58.247.171.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c379c4bsm8342727a91.7.2026.09.20.00.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 00:25:52 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	xuyq21@lenovo.com
Subject: Re: [PATCH net 1/1] net: ipconfig: bound DHCP option construction
Date: Sun, 20 Sep 2026 15:25:03 +0800
Message-ID: <20260920072503.60706-1-xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <7808dfbfa2162dfd0b19f59aff5742d6e0db2abb.1789798023.git.xuyuqiabc@gmail.com>
References: <7808dfbfa2162dfd0b19f59aff5742d6e0db2abb.1789798023.git.xuyuqiabc@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sashiko reported the following finding on the patchset page; it has not
been posted to lore:

> Blind copies in BOOTP extension parsing (`ic_do_bootp_ext`) cause
> out-of-bounds reads if an attacker provides a truncated option length.
> location: net/ipv4/ipconfig.c

This finding is about the receive path, not the code this patch changes.
It is a real, pre-existing issue; this series does not introduce it.

This series only touches the transmit side, ic_dhcp_init_options()
(net/ipv4/ipconfig.c:698) and the new ic_dhcp_add_option() helper
(net/ipv4/ipconfig.c:680). The function named in the finding,
ic_do_bootp_ext() (net/ipv4/ipconfig.c:919), is reached only from
ic_bootp_recv() (net/ipv4/ipconfig.c:1156) and is not modified here; the
diff contains no receive-path hunks, so this series neither introduces
nor worsens the issue.

The receive loop is:

	u8 *opt = ext++;
	if (*opt == 0)
		continue;
	ext += *ext + 1;
	if (ext < end)
		ic_do_bootp_ext(opt);

with end = (u8 *)b + ntohs(b->iph.tot_len) (net/ipv4/ipconfig.c:1078).
An option whose length byte overruns the remaining space drives ext to
or past end and is skipped. That is not the case the finding describes.

The truncated length in the finding is a short option length, not a
length greater than the remaining space. After switch (*ext++), ext
points at the length byte; the copies ignore it and memcpy a fixed-size
value at ext+1. Option 1 and 3 always memcpy 4 bytes
(net/ipv4/ipconfig.c:935 and :939); option 26 always memcpy 2 bytes
(:968). When that option still satisfies ext < end, those copies can
read past the declared option and past end. Options 1 and 3 do so even
at length 2; option 26 only at length 0 with 3 bytes remaining. With
skb->len == tot_len that is a real KASAN out-of-bounds read. It
predates this patch.

Since the receive-path issue is independent of the send-side overflow
addressed here, we have kept it out of this series.

Best regards,
Yuqi Xu
