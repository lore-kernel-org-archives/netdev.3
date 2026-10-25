Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792918860;
	b=FfJbzXTNEJe7tVYtSquNBZc6EQFHtztes9cVwECaVdpknXveCfD0SZHtv+WjB4K/lzNp
	 z5bXBgVTs2uNWLpaf6mN/y4LMmTwY+7VE6Y7MsPgrPjfa3tTK7zEhpjU8E//nYrfvS1lV
	 5X3Whs3JN8qv89ug5opr1i2ACnE5ENB9ThfOfhJbxXxG3oOoa4X+BRWWzau7GwUbKOc9G
	 mcyOLhhi+U5ke6csY6BnEZXAd89i1YPKZwNVBeTZe2rOGY8VjDFBZZ7yJ/3xJNuzOEPb/
	 TpPuurccjYDJSiO1DWKGWX6OE/pT1ulP3eaZBUOGYJlmoeuVq/UtKQbj+faMX7jmCQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792918860;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=InzIDyXEr+I6FKQ6MXVz9W56i3VO0fJ2tHFBcvb6StM=;
	b=1/a8lQ2KfRnriOGbIM9k7b3ocbz/J/6b4hWqER7kU2fA83W/WAvc+zWfmPHcK+p169iv
	 N6pJDdDf1QTxmaIuj7N7M5z4jUCgYBM4ixVtT03vWwe04x14pJzA1P+M+M6tuwEB/utej
	 KWI0m6T5+GV92tf3ieD8dlxrFvBCUXH95yQsb68tOYGFCeZ8wgEPM5f35gD9L5WQ4iPiJ
	 Oq9eoiyT+BGxD4XFMlod0H4l9j+x++drEhZ7OlnClcjTEZj/HfR41riIl7r5WxVVNxcpj
	 FTn8caJNcagWeRaP+7cP3Cb1O163eh+H/lVC3Y+Ck3IczmQrflUPpjHS/F4hxsVqLQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=W6+2wPJT;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E848D606A31B
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 09:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E848D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=W6+2wPJT
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e0d885929so1297258f8f.3
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 02:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792918858; x=1793523658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=InzIDyXEr+I6FKQ6MXVz9W56i3VO0fJ2tHFBcvb6StM=;
        b=W6+2wPJTpE+MLIPiT3uOv9PiHfVtmlWi/kv0EoiD7NhIs6vGogcZQ0AFkvaZFhnaqA
         V1kpSPuJToHO5p5vgBD5iZIbbxoHA54mXjby0MBgFLircJMYDsG8h617Bbv2c+9BkYjl
         fwSyc93i3pxgErV10ObO3M2eh1jrtvNHCEimL6utJe72B+YcWN6VsrVH5oMMdSf+CVef
         pevaU728H8azko/1P42vRgN1nn3vaErhw48o/aGvBfPt2Aq3cmmXZDIGuEyp2pP2jpCE
         Kahc0y3LPtb3ZH/iIuQfC8GS66icKeOayYxFgQnXvmnMTJgAv7h1Ydd4cIdryDW+EL/0
         6Fnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792918858; x=1793523658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=InzIDyXEr+I6FKQ6MXVz9W56i3VO0fJ2tHFBcvb6StM=;
        b=u5PbFTgBUUutGKsLm1xxDnTriR1A2/li0bVybgAkw7csjZf1pcacT3ciGG2DOQvnHg
         cfHwxvoepE154DhihoTvI8xAmTA5M/wb+5AtAGGQzHM0fqYSM2BA4AgLt0keH6XlCiM4
         XuTa4CZmHiB90n4NGYkoH92lCWYmyc+HAIoXpmoACYKPOAEJLNW/iWO9mld5Ie25Hs+y
         8wwfo6QQ8+E7Jl37Vqb/+1O09RDA9vfYmiwDmyMJp0M5J0YkOwJy/M/5+5XITQvpRDtJ
         b+xmqHdnplLE+Qr6BwV5dnOTUqazfyXgWkP7dPc0YRZYvv34FT8W9aXOWTqerxRUhPM6
         l8KA==
X-Gm-Message-State: AFq9FYJ2biySWH9AMrIMKX5Qy7RnhRFxQ+x1Sa9+SUV0HU71DwJ7FgAU
	PFrL5k2f8tWy0NQkUU015Srynf/8JNkaFXgh7yhLoSNvj4v3wjAPCQVQ8//TBHZp
X-Gm-Gg: AYBFou2A9Rgg16Gdl9GG9WwVe5kZVBcBOTZU6cmCVmHC+7jzTd4+7PpKimvGVRcZ8fy
	KDKBvbqF/LTqFRfrHy6mKqxv1fhJZY70PrB+7G6z/F5cuW3h5SmA9Bnd0k/d+weFt5FeibRabFD
	G5F7I37qKk7Uy8ud6igfZX4/3JrEq8pj+g+1U1exp9pfWqiDl12HKQB528/I6gi4m3y4nthYJdD
	+a0JFdFuhrSwkPiQOk3T2z9UVCs002C79F2W76Fz2ibuB0Y9Kj1IrEQCRgiItPw9Umn0DbQRoK8
	s6ZE9Kf7mJ4BF8Scr7oftTyBDAYrXqqoWG0GpXAXaHf4Uje3YLcYeDaG1yzXZqMZyB7RbxNPqoC
	dfPK8EmmmXJ6/DkikrOVVmfA0ltmKX0otTXC7f4fYgkWbFU7hMRdMFYeKj7bGvbxzax2Kf8CBPU
	MJDV9dKCNiRMWM8xVZDpS0uRuTzjJWsiENtxpnCpO12aS9eBYHCElv9jPQPgU6Lzub+sWT4+RiY
	hgvV7dKyPf5iqnZ1hs2gJ1e4P4AVJhTZ89GwBwscp5o6g3o9kxXAFKebLM555QSalsDmg3ffeo=
X-Received: by 2002:a05:600c:c110:b0:4a1:e00b:a10b with SMTP id 5b1f17b1804b1-4a35ac91142mr55780775e9.7.1792918858092;
        Sun, 25 Oct 2026 02:00:58 -0700 (PDT)
Received: from zheweiy-mac ([2a01:4b00:b60b:cb00:c67:3956:189c:b7c3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a5822a7sm111588615e9.11.2026.10.25.02.00.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 25 Oct 2026 02:00:57 -0700 (PDT)
From: Zhewei Yuan <yzwlhm@gmail.com>
To: netdev@vger.kernel.org
Cc: Zhewei Yuan <yzwlhm@gmail.com>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: [PATCH net 0/2] tcp: Fix fastreuse cache initialization on first bind
Date: Sun, 25 Oct 2026 09:00:46 +0000
Message-ID: <20261025090048.27870-1-yzwlhm@gmail.com>
X-Mailer: git-send-email 2.55.0
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

This series fixes TCP bind reuse cache initialization and adds eight
KUnit regression cases.

Since commit 8002d44fe84d, tb2 is already linked to tb->bhash2 when
inet_csk_update_fastreuse() checks for an empty list. First binds miss
fastreuse=1 for SO_REUSEADDR and FASTREUSEPORT_ANY for SO_REUSEPORT,
causing unnecessary conflict scans. Patch 1 recognizes the sole,
ownerless address bucket; patch 2 tests initialization and conflicts.

Bind-only results on historical net f4377bf85887 (not the submission
base): TCP/IPv4, one-vCPU KVM, GCC 11.5.0, identical configs/programs.
Means of 3 guest boots x 3 rounds; only bind() is timed, with all sockets
kept open. Each case uses one reuse option, the same UID and port.
"same" uses 127.0.0.1; "alternate" interleaves 127.0.0.1/127.0.0.2.

  16000 sockets                 before (ms)    after (ms)
  SO_REUSEADDR, same                 4256.956        20.004
  SO_REUSEADDR, alternate            2476.914        19.983
  SO_REUSEPORT, same                   20.600        19.557
  SO_REUSEPORT, alternate            2491.294        19.830

Same-IP SO_REUSEPORT measurements overlap, so no stable gain is claimed
there. These are bind microbenchmarks, not application throughput.
A minimal reproducer is included at the end of this letter.

Validation on submission base 7076f684d513:
- KUnit: six expected first-bind failures and two passing conflict
  guards before the fix; all eight pass after it (same tests/config).
- bind_wildcard, reuseaddr_conflict, reuseport_addr_any,
  reuseaddr_ports_exhausted and tcp_port_share: pass without skips.
- Full x86_64 allmodconfig W=1: baseline and patched builds pass with
  identical configs, GCC 11.5.0 and CONFIG_WERROR=n. Existing warnings
  remain, but normalized diagnostics and counts match: no new warnings.
- Full allyesconfig is blocked by the MCTP KUnit static_assert at
  drivers/net/mctp/mctp-usblib-test.c:819. A targeted unpatched build
  reproduces the same error; this is not a full allyesconfig pass.

KUnit A/B and patched allyesconfig/allmodconfig W=1 builds also passed
on historical f4377bf85887 (GCC 11.5.0, CONFIG_WERROR=n); those builds
are auxiliary evidence, not substitutes for the submission-base checks.

Found during manual code inspection and GDB tracing. Codex assisted
with analysis, test/benchmark development, validation and patch text.
Requests covered real first binds, cache flags, automatic ports,
conflict preservation and separate reuseaddr/reuseport measurements.
No failure injection was used; KUnit inspects state after real binds.

Reproducer (not for the merge commit). It gives matching results on
the submission base 7076f684d513 (16000 sockets, same order as the
table, before/after in ms: 4178/19.4, 2416/19.4, 19.8/19.4,
2428/19.5). It needs loopback up and an fd limit above N, e.g.
"ulimit -n 70000; ./bind_bench reuseaddr same 16000".

  // Time bind() of N TCP sockets with one reuse option to one port.
  // Usage: bind_bench reuseaddr|reuseport same|alternate N
  // same: 127.0.0.1; alternate: 127.0.0.1/127.0.0.2. Sockets stay open.
  #include <netinet/in.h>
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include <sys/socket.h>
  #include <time.h>

  int main(int argc, char **argv)
  {
  	struct sockaddr_in sa = { .sin_family = AF_INET,
  				  .sin_port = htons(40000) };
  	int opt, alt, n, one = 1, i, fd;
  	struct timespec a, b;
  	long long ns = 0;

  	if (argc != 4)
  		return fprintf(stderr, "usage: %s reuseaddr|reuseport same|alternate N\n",
  			       argv[0]), 1;
  	opt = strcmp(argv[1], "reuseport") ? SO_REUSEADDR : SO_REUSEPORT;
  	alt = !strcmp(argv[2], "alternate");
  	n = atoi(argv[3]);

  	for (i = 0; i < n; i++) {
  		fd = socket(AF_INET, SOCK_STREAM, 0);
  		if (fd < 0 || setsockopt(fd, SOL_SOCKET, opt, &one, sizeof(one)))
  			return perror("socket/setsockopt"), 1;
  		sa.sin_addr.s_addr = htonl(INADDR_LOOPBACK + (alt ? i % 2 : 0));
  		clock_gettime(CLOCK_MONOTONIC, &a);
  		if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)))
  			return perror("bind"), 1;
  		clock_gettime(CLOCK_MONOTONIC, &b);
  		ns += (b.tv_sec - a.tv_sec) * 1000000000LL + b.tv_nsec - a.tv_nsec;
  	}
  	printf("%s %s %d: %.3f ms\n", argv[1], argv[2], n, ns / 1e6);
  	return 0;
  }

Zhewei Yuan (2):
  tcp: Fix fastreuse cache initialization on first bind
  tcp: Add KUnit tests for bind fastreuse caches

 net/ipv4/.kunitconfig                |   8 +
 net/ipv4/Kconfig                     |  14 ++
 net/ipv4/Makefile                    |   1 +
 net/ipv4/inet_connection_sock.c      |   3 +-
 net/ipv4/inet_connection_sock_test.c | 303 +++++++++++++++++++++++++++
 5 files changed, 328 insertions(+), 1 deletion(-)
 create mode 100644 net/ipv4/.kunitconfig
 create mode 100644 net/ipv4/inet_connection_sock_test.c


base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5
-- 
2.52.0

