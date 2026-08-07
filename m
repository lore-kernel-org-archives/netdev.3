Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6043F1ACE
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 23:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786145515; cv=none; b=BG7t62TTtpZdDxX546AZWy2T7dZAPYpx+axjfrA19EkcUdgXKu9CuXZ2X2SPcLjVN986kIHEyI98iOIhSX8jivh96/T1qNxGK8+RYI3Cd3xb4dwYxXBHJE0TqPz9agY3H36Be+mBOIZhZ+PafEpFcDi7a8OwpVjnhObLbBaxgEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786145515; c=relaxed/simple;
	bh=WwoDNzYCkmz72xwDXpg4SRfNnVQDPKazEleFehM0ihQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i4inO2w3sa99mq3GaQGjO4MOGfVHDGaDyWo4iA0OzIUovvB/cOSNiFOCBiaR0Dk80Ci+FVEuRQJDkLGvI1l2fc48cWWPAZUyA2ZtzaqHg8mqtXh1IT9+iDVpHLp75nKjTbTokXHl/+lIgAy4tHJxdSAkNpndxKPxULiFlf3WNjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lo4kMYbz; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lo4kMYbz"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8484f229529so34680b3a.2
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 16:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786145513; x=1786750313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ot7fup0kusR5tG1UGVX/rPbwtpKAAtHcgc4bshclt1A=;
        b=lo4kMYbz8vBJGy+0sy1UHph0uBWm4Lw1YsY9CN7S3bBxlvoQhVmPkNp/Ux8cg82P8C
         lLHcjijogfQOZXppb5VkdfDas7H8Pq+yywZlRX/yXfMLK/S/cZOq11toO5BFh4gMG5Co
         xxb9yRUfQGxpdmN50zeYfWfWz30mrogNCuFGeF2dSMMy8cQ5gwyRsFqpE+m0s86pp0jm
         sjT2IJ5IoI54kCZF2kywuia0wQCiVDUs+Cy28qnqptFMvklc6BYkxcFlVqktqiGE8CC4
         KVcYInR0SfB6pyr4vrEx8i+Db6BU3kuYKIFkCRIObs9FxgKKRh2TOCpN/6xJnU1oEn79
         ZHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786145513; x=1786750313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ot7fup0kusR5tG1UGVX/rPbwtpKAAtHcgc4bshclt1A=;
        b=mU0cIi+lH4Eda7oknlb/fwqgj+K9ToZtGDqN7RCYx8VGJXnhmq0nyhdtzuVQ1lb4Dx
         /4ZRTN9voKzg8R2/Obbc+m+YWEAKyhkOKyZH/KExeb8dFAAekWjcX3ecDcn4lJJweZUH
         EUkL73WOficjxTCq28EMzZNba7yrCn1L0drgsue/biM4HgexvNy2SsCniSWjrqPB4ZQs
         N+yLPkD96NhZOIQuabYgqvyoxqEgLHi4rzrn80tcBdC5drcnmB+tDnUWQjayRveZUpld
         BF6DukQ8BxWIv3XAEepI0zUiO8fpZnGuukNVzhW7kC6n26x20pmaHPDwqnVf2ceJRtaA
         v9Sw==
X-Gm-Message-State: AOJu0YwLKIbB/9NG4Y+1WvkAxm76RB66ngVDL0tuNh+mYgFl0lX06fWo
	0bwFyp+RXWlcxzGv/Njm04fYlzkoT+cutTv/PyKz0/4sLXK0z1pEfCVK2oIm1Ec4
X-Gm-Gg: AR+sD10d2JAhrj0R6HgU1k6rLK3p8+ohPVkB7Zn6iIUw92blzOqfVy8bvwsrTqeQ7Oa
	ZDhvHDBvWEVFo2DtTdGOIh1SWQvkN4fbt1n82SBq4zqv90hwovDTZq1VOhG24QqeoCTG8m4niwN
	ZcESoyIyILOjkxKnBpKwzSZ+5+hSTHXyb8QMpALKHDmFTn2tursv4TLhqyUnM3UyqM8ppulh+rD
	sGKldx1Phs8ogALpbbGOSLE7vRGIboEjz+DIDUzhZYqjG4T6eg0JD7Yq9e5CL0GWXopG2JcdMQs
	3Y/im5hGMsxfDerXOAQVumb1y74bHf/iRHPbmoJSWkl50G+uDOqc3ywGL0wgnpzVffh8Y5oESus
	0lybuq7qo3ltt/y1WdQVReUFu1meb2h98m2TPUVcDAQJXMDzBv6OZQqLTbxvzNkJtgAAf5F5yLQ
	T1LgKyuXaDlEvI3RoBpW0RdJw3EvpBVQzGY5AOXyviziQ4iRtQfkuoP98UT0HLw7aDXJx3+QKNO
	wxS8G8B76KxwMl106TumuSqqdwCU0Gux5J6gaUs5VdlyYwY/UYbv4jul6shf+kX27Nt
X-Received: by 2002:a05:6a21:330e:b0:3c3:a168:edc3 with SMTP id adf61e73a8af0-3cbcea3127emr4608448637.38.1786145513185;
        Fri, 07 Aug 2026 16:31:53 -0700 (PDT)
Received: from l.localdomain ([76.51.34.120])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bec5aac2sm13347222eec.30.2026.08.07.16.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 16:31:52 -0700 (PDT)
From: Dave Seddon <dave.seddon.ca@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 00/11] net: flow_dissector: opt-in byte-identical fast paths for common shapes
Date: Fri,  7 Aug 2026 16:31:51 -0700
Message-ID: <20260807233151.4036252-1-dave.seddon.ca@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <willemdebruijn.kernel.c1b4383fb19c@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks Willem, for the quick response and the feedback.

I think your point about where to draw the protocol boundary is a good one.

Eth + IPv4/IPv6 + TCP/UDP is clearly the common case. Beyond that, choosing
what belongs in-kernel becomes increasingly subjective: VLAN/QinQ, PPPoE,
MPLS, GRE, GTP-U, etc. all have substantial deployments, but that's also an
argument for leaving those cases to the BPF flow dissector rather than
continuing to grow a parallel parser.

On the +2500 lines, most of that isn't actually the fast-path parser:

    01  +75    gate BPF lookup behind a static key
    02  +302   Eth + IPv4/IPv6 + TCP/UDP fast path
    03  +180   + VLAN / QinQ
    04  +95    + PPPoE
    05  +103   + MPLS
    06  +134   + IP-in-IP (4in4 / 6in4 / 4in6)
    07  +121   + GRE
    08  +270   per-shape counters (/proc/net)
    09  +37    bound tunnel recursion
    10  +1102  KUnit fast/slow-path equivalence test
    11  +137   Documentation
        ------
        ~+2500

The KUnit test is therefore a large fraction of the diff. I don't want to
dismiss that as "just tests" -- it is code that has to be maintained -- but
its purpose is specifically to make maintaining two implementations safer:
the same corpus is dissected through both paths and the resulting flow_keys
are compared byte-for-byte.

More importantly, if I take your protocol-selection concern to its logical
conclusion, most of this series disappears.

A v2 could contain only:

1. the static-key optimization for the existing BPF lookup; and
2. one fast path for Eth + IPv4/IPv6 + TCP/UDP.

That is roughly:

    +377 / -50 across 5 files

plus whatever reduced KUnit coverage we decide is appropriate for that one
shape.

I think there is a useful distinction between that case and the less common
protocols. A network operator or vendor with a specialized encapsulation can
reasonably deploy a BPF flow dissector. Requiring BPF in order for ordinary
hosts to optimize the overwhelmingly common Ethernet/IP/TCP/UDP case is a
higher bar, especially since users of RPS/RFS, fq/fq_codel/cake and bonding
benefit indirectly through skb_get_hash() without necessarily knowing that
the flow dissector is involved.

The performance result is also fairly consistent across architectures. In
the isolated Eth + IPv4 + TCP benchmark the straight-line path reduced
dissection time by 47-55% across x86, ARM and RISC-V. With all shapes
compiled in, the Eth/IP path still improved the tested CPUs, although by a
wider 4.7-31.6% range.

I agree that duplicating parsing logic has a maintenance cost. The reason I
think the single common shape may still be a reasonable trade is that the
surface is small, the fast path is deliberately allowed to bail out to the
generic dissector whenever the packet doesn't match, and equivalence with the
generic path can be continuously tested rather than assumed.

For the other protocols, I've implemented the same idea as a loadable BPF
flow dissector:

https://github.com/randomizedcoder/flow_dissector_ebpf

That seems like a better home for experimenting with specialized shapes
without growing the in-kernel parser.

So rather than trying to justify seven in-kernel fast paths, I'd propose
shrinking v2 to the static-key BPF lookup optimization plus the single
Eth + IPv4/IPv6 + TCP/UDP fast path, with a correspondingly smaller
equivalence test.

Would that reduced series be worth posting for review?

Thanks,
Dave Seddon
