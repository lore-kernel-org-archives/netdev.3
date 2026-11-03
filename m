Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749916;
	b=nVQvIYCpbrZFeSrLNb5a+jo9EacMqTmc0lATxEwd11mNZTFU8pHxdtthMTUQOdm08DaI
	 QIzYWUYif4NWzMV5TFgz/ywGjaSoa75acDwnNSMcOwo8fy3MrMmLNluywZLiKhilm2MGR
	 biNqBzEoAviBLDYKb9guPnPJ6Vj7ynfgplkL6EjrtrkFaP0RqyyqMYuuAvS5heUlWBMRa
	 Gdunb484TnmelpqP9WdiRqUNVkyGcKcdYFtXg2ZI2/ptqWjIvG1uUg8kDWML8f+VX5O5J
	 KGkD2rjKfvetY5UTWyATWSFLJuYzXz97PRgB9awp3TLslODNVwXmPmheyur+EOJd7MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749916;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WiIxk8lmn3E3SUR9Jb0MhBZnr39A0s76dtpbyO4LWvw=;
	b=eN36nfe16a0MxoBfu/Mh6xeJud8XYhiGJruzAWhd35oGZi5n322zTT6uOTNalJzWd5S1
	 JKACCFl4F64/qRA1sSB2jPi0Oc7P1urocQA5vluIsi1spfycEHUW2svjM6EcYSE25cQ0b
	 X5lJW2OBXkBCL/6qdT4zygvnu7lftMz802rrgisNx5ZyB4djLakP3LGBpvH9lm1m8Eiz7
	 Gyrtlfs9O6Kp8OifQGerRnPwdBA2RhHYIS76jd7oBT6A+9uk5wU8oYq20XHUuES7TgXzh
	 vhlvpJn1Q3+g+TwWlXsy0uty4CeEhgX19VfT/xPQhaLJv/1w1CL12elcZGhycWDSXIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="lbNZxN/J";
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D0B606A32C
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 23:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54D0B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lbNZxN/J
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-33e5ae86ff2so50021eec.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 15:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749914; x=1794354714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WiIxk8lmn3E3SUR9Jb0MhBZnr39A0s76dtpbyO4LWvw=;
        b=lbNZxN/JoRpFqMfhLuSYErnkgqNH49/S94mNzomhzs41p5Jmo25C6y4zIhyCNkRBN2
         gNtD5vdbAonjBWlPCnOFUDrQO9Xsnwk24ksZLC+N39b2xcxnrnna5dkjAoG0wVm4hVSA
         nSJT3DAKaLVM2N0Lh5DhMKrTzqPzBJPJH+Q1ucmtCn2N4+wLhXl8GPzCP/f8UTAfav9q
         4uMklp0MPw4JFNcVE0al6U7qZghyyfXlEql+y/bWx684E65qK80PZaJ0fcFWyvLSRTqO
         JbcC47LQqvshRFta58zw2W/FeAevgC2HcND5oRZ1zVhBwWv26L5yBTDs1nVuLmdMRUGs
         fxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749914; x=1794354714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WiIxk8lmn3E3SUR9Jb0MhBZnr39A0s76dtpbyO4LWvw=;
        b=i+M/uT0KN7n0zW6bg/ZGsHiJ25sgjd135Z5fFx2PrLRDMqsf7WxQ3WOOGKWSBV7p7E
         F52yskihzZSk5m0Q2N55XsFI1zQcEva1+kpA4KS9HQ1l6eZj3kO9tsLnKQslz5jGMQZC
         zxRUIIdq/ui+TPjqEBzfS99Ex/ksZu8KEouPu1GzcrWS7KB6j5Q6dkpOSMN+g9oJOS1l
         /h9gBVbMb6GXF0s4LDeM/+tGZorFRK2sppOIGPC+zW7+wzrxQM+7ENdJ9CUIOhkZeTk5
         XsMqweuezHuLRDTbC5exnRCQ3reKeAfNDr0a/lsVJeDDU+so39uO9lc0b/jWvkVV3Jn8
         ti/w==
X-Gm-Message-State: APuU4Z+u/nxMbbpBLrtM51yd8AQJxsh7WBXo4le8mJ+4C2XsadJk6Moo
	+cxB0OJj5Sg0Q9jXlNEVtbX6s8x3qdH+36o+CcpoUymScU4+XQHPh0YY8m/W4njR
X-Gm-Gg: AYBFou2Jo/aJDQ58LfrOHJHgNiezr7vnLci+wal8YVBi2o3c9v9lc0l/9UHhS8lg6pD
	Nzst6NnVQwrFs5Hz7+VWlT5DNDW14Rnj7819rRe0UOD3mKRzsNiTrGaHx7f52Ef5CA0tNLv0Zyx
	tmZPaf9p9YvRVpwcN2ssRb9GnREr49J1qmFljsarhp/f2abHvrFpfC6/BSscH2n61ppgCtEZK95
	atN7TJfdVa5xVz/b6bJpohl9cPxm1qJsedcTcf1RvVquHKeXGTvvPq+QFpOrgzO2L8qargOzupn
	ABNdFNTwAGczp0vGqdUKn0f/2B+EGCZ8JRTKbr4V1xgvgKp1lY0JvxD1NHa+X2bySIqXAX3L6VV
	p459JlD9iavbdAeA2yZHKLqdq1LG3cvb9sia4RdYrdlCd90yIXXj8sS+2AKx/utpXGFhvwANLF6
	+DV7x8UQ5Agt4Uuwyhu9JFou3tJSjjzqzFOmtojoZfzHmlPyVxSvLqric9yidPf+sMGywy37r6O
	Y/fEe8DG7O8yqXmdaJW8K8xShNo7JzE0i8xABuhGKpjeZo7VQC5Vn+Vy+SCFoz1tqXEcOKkVSXq
	d0xP9JYikU0+zJPZklosXzs=
X-Received: by 2002:a05:693c:87c9:10b0:360:e2e6:f849 with SMTP id 5a478bee46e88-36a4241985bmr21750959eec.28.1793749914150;
        Tue, 03 Nov 2026 15:51:54 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:44::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38fa273sm1755960eec.16.2026.11.03.15.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:51:53 -0800 (PST)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	edumazet@kernel.org,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	sdf@fomichev.me,
	almasrymina@google.com,
	bobbyeshleman@meta.com,
	asml.silence@gmail.com,
	razor@blackwall.org,
	daniel@iogearbox.net,
	leitao@debian.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v2 0/7] net: devmem: size TX net_iovs from the dmabuf layout
Date: Tue,  3 Nov 2026 15:51:45 -0800
Message-ID: <20261103235152.1904727-1-sdf@fomichev.me>
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

TX bindings use PAGE_SIZE net_iovs, so a frag covers at most a page.
A 64KB skb needs 16 frags, and MAX_SKB_FRAGS caps devmem skbs at about
68KB, which makes BIG TCP ineffective for devmem TX.

This series picks the TX net_iov size from the dmabuf sg table instead:
the largest power of 2, up to 2MB, which aligns every DMA segment. With
a 2MB hugepage-backed udmabuf a BIG TCP skb takes a few frags. There's
no UAPI change since TX addresses are dmabuf offsets.

TCP still bounds skbs by size_goal, so frags get larger, skbs don't.
A single frag can now be as large as the skb, which matters for
NETMEM_TX drivers with tso_max_size above 64KB:
- mlx5: 32-bit length per data segment
- gve: splits frags into 16KB descriptors
- fbnic: keeps the default 64KB tso_max_size
- bnxt: 16-bit BD length, devmem TX frags are capped at 32KB by a new
  per-device limit

Tested on two mlx5 400Gb/s hosts with kperf (udmabuf, 32KB RX
net_iovs, 2MB hugepage-backed TX buffer), series backported to a 7.1
kernel on the sender only. 1 flow, MTU 4200, receiver tcp_rmem capped
at 16MB so it doesn't drop, median of 5 x 60s runs:

                              before    after
  frags per skb (sender)       16-17      1-2
  throughput (Gb/s)            208.6    211.2
  sender sendmsg CPU (sys)     40.8%    19.5%   (-52%)

The receiver's CPU is the bottleneck, so the gain is CPU, not
throughput. More of the transmit runs from the ACK path, so the
sender's softirq grows (52% -> 59%), but sys + sirq still drops by 16%.

kperf output (sender side) of runs near the median, before:

  client: == Source <sender>
  client:   Tx213.826 Gbps (1603901849600 bytes in 60007723 usec)
  client:   Rx  0.000 Gbps (0 bytes in 60007723 usec)
  client:   TCP retrans reord rtt rttvar d_ce snd_wnd cwnd
  client:             0     0 633      2    0 15556608 7657
  client:   net CPU 49: usr: 0.01% sys: 0.10% idle:44.13% iow: 0.00% irq: 3.21% sirq:52.53%
  client:   app CPU 50: usr: 0.05% sys:41.55% idle:53.88% iow: 0.00% irq: 1.40% sirq: 3.10%

after:

  client: == Source <sender>
  client:   Tx211.242 Gbps (1584440279040 bytes in 60004741 usec)
  client:   Rx  0.000 Gbps (0 bytes in 60004741 usec)
  client:   TCP retrans reord rtt rttvar d_ce snd_wnd cwnd
  client:             0     0 556      3    0 15499264 7650
  client:   net CPU 13: usr: 0.01% sys: 0.08% idle:37.75% iow: 0.00% irq: 3.87% sirq:58.26%
  client:   app CPU 14: usr: 0.06% sys:19.48% idle:77.23% iow: 0.00% irq: 1.19% sirq: 2.02%

The bnxt patches (1 and 5) were tested on two 50Gb/s bnxt hosts with
CONFIG_MAX_SKB_FRAGS=45 (with 17 the check in patch 1 compiles out).
kperf devmem TX from a 2MB hugepage-backed udmabuf runs at line rate
(46.4Gb/s, payload validated) with 2-3 frags per skb, none above 32KB.
ncdevmem sending 1KB chunks builds skbs with up to 45 frags, the stack
segments them and the data arrives intact.

Patches:
- 1: bnxt: segment GSO skbs with too many frags in the stack
- 2-3: devmem TX prep (truesize, niov_shift in the TX lookup)
- 4-5: per-device netmem TX frag size limit, 32KB for bnxt
- 6: pick the TX net_iov size from the sg table
- 7: selftest for TX from a hugepage-backed dmabuf

v2:
- reword the TX truesize commit message (Mina)
- use 1 flow results in the cover letter (Mina)

v1: https://lore.kernel.org/netdev/20261102191438.1059771-1-sdf@fomichev.me/

Stanislav Fomichev (7):
  bnxt_en: let the stack segment GSO skbs with too many frags
  net: devmem: charge the frag length to TX skb truesize
  net: devmem: use niov_shift in net_devmem_get_niov_at()
  net: devmem: add a per-device netmem TX frag size limit
  bnxt_en: limit netmem TX frags to 32KB
  net: devmem: size TX net_iovs from the dmabuf sg table
  selftests: drv-net: devmem: TX from a hugepage-backed dmabuf

 .../networking/net_cachelines/net_device.rst  |  1 +
 Documentation/networking/netmem.rst           |  6 +++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  6 +++
 include/linux/netdevice.h                     |  2 +
 net/core/datagram.c                           |  3 +-
 net/core/dev.c                                |  1 +
 net/core/devmem.c                             | 37 +++++++++++++---
 net/core/devmem.h                             |  1 +
 net/core/netdev-genl.c                        |  2 +-
 .../selftests/drivers/net/hw/devmem.py        | 10 ++++-
 .../selftests/drivers/net/hw/devmem_lib.py    | 43 +++++++++++++++++--
 .../selftests/drivers/net/hw/ncdevmem.c       |  8 +++-
 .../selftests/drivers/net/hw/nk_devmem.py     | 11 ++++-
 13 files changed, 115 insertions(+), 16 deletions(-)

-- 
2.53.0-Meta

