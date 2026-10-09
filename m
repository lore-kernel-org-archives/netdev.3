Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DAE483800
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 20:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791576896; cv=none; b=LDVi6sKx5ztqiFuBwj84W32UxYnIouz/0K+OQM8Ruun374LkxjCRiSFHXrFRlzpfpgWHXOLoA/sobD6BRppFfACIzZur53yX6eel1RMi68yW2BekNqh7/n+sJoWMjqY315AWBdpWAIQwx5cScJBUdR4Nk0a/hsZqQFTTW4eY9Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791576896; c=relaxed/simple;
	bh=WFMQZ99UMpZplb7RsBAhDd2v9uvyJrKd1KhsSZExxLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYhFyKwrrEPFSMFrpqN6Dhoil1LqqbYyfK4kqyhIjRyHAcfkDOk6irDoJUO4VzCIT7DK2QBFujz0O9C0x7hIURuLg9vyh4MM2Snw2urTUA8EIVeSItFrDv7+Wz4IgQTY3utblIoYzLMSOZoE/hNsk+Fh+UpcMchhuFCkdcOGdS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=cHRV6qEI; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="cHRV6qEI"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-14394530ec6so143653c88.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 13:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1791576894; x=1792181694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LbJd+F8HdwB4ZwrQUMxv51nPVS5BB9PcOKCpwSnYCy4=;
        b=cHRV6qEIrcaAD3WuIEOu1zfaOUZFKbk9YlmfjlqgxWOhj99TxD1igCSOWuCxLj/75b
         Zo/eRK3WFXtfshTnE+JIjfmrZr76U7B13pruDLbXlZ1mwkBnO+lVvwtfwI1bC40YBlua
         B19t0aTu/G8EuZqq/CC8yKZcivwiQuvfSgA+qv3RkCThD5IgoAf2mf0uRvqzKVhEVCup
         CA+e2bCpRzlfwUM8yIlz2DhcVJNDZxNKQFoIS0jdQUwHkznmXqwkOwra/p4MBYetATYb
         sw6sOxG5zvblvw7SSECBVXpUzUEITZ1Da3Uw0qTwe0aRBZVwQPw8GxqRfoUgdgQNwdyO
         nQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791576894; x=1792181694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LbJd+F8HdwB4ZwrQUMxv51nPVS5BB9PcOKCpwSnYCy4=;
        b=L1++RyXs8DN7xJM1v7CqHLhyVZ/VXpPmblETT50ANztqWcflbb0iLzW+9pFUGrcxs6
         gKl9mEHgCeYSay8BhD5KCbnRv0Sg0FyXBp4E6DjmKci4tq+qjO/fc5k+h+IjNvyUEvNC
         bkMJAoqlj4QfPwD6k1/ag9J7tFoMORgaJh6qnaUK1etnR4pf2+K6REmVJeoxc5JRZDqw
         PjlprbCwVJog2j9tk+TBiGXUvMEs1y0Z0OBB4ElyWeu7FOyffVmvC2thl/1OnOfQFbkH
         Q1JCjHWeeiI4tkoB7esSypAWcc7oqtQFqNnR6cyxVHljvgoOOsUWPdtwz1eETF13ZP5M
         4xZA==
X-Forwarded-Encrypted: i=1; AKwUvBxCKo+/MAM1Y/cHEe3lPw7f6tH0J1d+Y/GhRas2pJDwn/ceMJhbccLZnSQjIFpqorXBKR/2aOo=@vger.kernel.org
X-Gm-Message-State: AFuF++kxBEOQhZ1whlaPrgAf/uWhtcn7VmMofmaAPrUfg/2RVIbr3ZoN
	xqsRJwgqiEAas7G/08ZI4nbSlubSHOB4EILtfQc4N6rbNr6P7OK2LfQbiAwnYxHWN+A=
X-Gm-Gg: AYBFou3mW8pKXywo+fmVod8LvWiL9bqcy4jxlQFVt0UTSh5HxQKtAxbW9SiykQ5BvVx
	JXOSl6VIjFbPSJfshQJjtcXTSm0Ym2O9HPKe5LMWEkidJ8POkBROGhvyHxejVgKQ1KVNQ6XHPGO
	HAKO6Uuak3T/vh/MHpWv5litl621JpHeAnZ+S0gN+HNNaIST6IXNAICrhfvCeuxzLrE0Q9fgjm+
	LI7iM1xe4LwjNuN0SAK7ZSeOCM4osOJiXR2ZfSqYUK7nYAvdAM1K5LhGU33BaGYpTVzLdEV+9Vo
	/GlHZg3q260A5co/CUBdgTEJVkCj4VW3nej7S2NTDbtMYVo/Dcb1jfdDYEn7C7iRNggsAODQSBH
	oQ69uSw+m87Hkz+Gek+Yw++EK3jOnIdsd/rw+YEQH8fDT1L+5+ltyb84OXvCrYf6RT1myY6pSvh
	4SRuSOSytFvumzS1SxzH6NNBkN4Aoq1TcGy7RiYeXVJ/vbHmal0ri8pPXeTzvGgvqK/EbF4UMsH
	Db+Pf2tbJpPY0QQ5MNiNjjE6T8njuATSL4isJmO
X-Received: by 2002:a05:7022:2381:b0:144:fb31:a597 with SMTP id a92af1059eb24-16a645d3a02mr5049180c88.47.1791576893792;
        Fri, 09 Oct 2026 13:14:53 -0700 (PDT)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca67b21sm8275284eec.11.2026.10.09.13.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 13:14:53 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: netdev-bot+sinfo@kernel.org
Cc: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net 0/4] amt: fix relay tunnel keying and unauthenticated-Request DoS
Date: Fri,  9 Oct 2026 20:14:50 +0000
Message-ID: <20261009201451.1903979-1-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179141995124.2527009.16759719486523759711@kernel.org>
References: <179141995124.2527009.16759719486523759711@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks -- both are fair asks. Answers below; they are also reflected in
the v2 cover letter. v1 was generated against v7.1 and did not apply to
net, so this is answered against v2, which is posted against net with the
General Query patch dropped (that fix is already in net as afae89de73dd).
v2 is three patches.

How it was found
  Manual code inspection of the AMT relay path in drivers/net/amt.c, read
  against RFC 7450, with LLM assistance -- hence the Assisted-by: LLM
  trailer on patch 3/3. It was not a syzbot report or a static-analysis
  tool scan. Patch 1/3 (endpoint keying) came out of the same reading of
  amt_request_handler() and amt_update_handler() against RFC 7450 s4.2.2.

Whether it was triggered
  Found by inspection; not observed in production. These are availability
  and correctness defects, not memory-safety bugs, so there is no oops or
  stack trace to attach. The symptoms follow deterministically from the
  code the diffs change:

   - 3/3, exhaustion: amt_request_handler() allocated a tunnel before any
     validation of the source, so Relay Membership Requests from distinct
     spoofable source endpoints fill the table to max_tunnels (default
     128). Once full, further Requests are answered with ICMP_DEST_UNREACH
     to the (spoofed) source and genuine gateways are refused; re-sending
     once per amt_gmi() interval holds it full.
   - 3/3, desync: the pre-validation lookup jumped to the send path and
     overwrote an established tunnel's ->nonce/->mac, so a single spoofed
     Request carrying a known gateway's source endpoint made that
     gateway's next Membership Update fail the "Invalid MAC" check -- a
     silent one-packet denial that consumes no table slot.
   - 1/3, aliasing: address-only keying collapses two endpoints that share
     a source address (NAT, or one host using separate IPv4/IPv6 ports per
     RFC 7450 s4.2.2) onto one tunnel; the later Request wins and the
     earlier gateway silently stops receiving.

  I have not staged a live end-to-end exploit run -- the above is read
  from the code paths, not a captured trace.

Fix testing (this part is observed, not inferred)
  The three patches were applied to net and the kernel booted (arm64,
  QEMU via virtme-ng) with CONFIG_KASAN=y, CONFIG_PROVE_LOCKING=y,
  CONFIG_PROVE_RCU=y and CONFIG_DEBUG_LIST=y on top of
  tools/testing/selftests/net/config. tools/testing/selftests/net/amt.sh
  passes all six tests -- amt discovery, IPv4 and IPv6 multicast
  forwarding, and both IPv4/IPv6 traffic-forwarding torture cases all
  report [ OK ] -- with no KASAN, lockdep or RCU reports.
