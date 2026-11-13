Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794578677;
	b=GTN2VMZ5prravLM+GURmoISu6Kg8PZhUrW1kXcw2QhKBzZcCv+7Kl5ZQyy6oIraY0F1Q
	 RUksKOYTjyp1PvQoIiymw0KrFS+WmFv4dON8D0lB8BOaYbAJWqRdQ+/CsGgEe/DUpDb4L
	 VKmhUo1gpFmHebzxIHfGalX3xhCOn7rfnAjv2B/7kGOzOk4mFWIhdLuzx/cD763myyD6S
	 +HIKbV22Ioq/qSRBwkHe3+Tt+AHpmF3xr7Vj87lstkidicXgIfDdlJpYIokSXE0NNEfJJ
	 e/z/iSbLpR+5i3dykwkjk/dkoiDm2qyYEg/0CPjSnlJy5VaZkMXLuZRxiMwsa6IvzmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578677;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=Iild291BQt1rZVunkiVGj1yEjCJ3Qroi6/j+amR3uKY=;
	b=m5D7wx8RO4PFGW/Tcuse9t17tUYHMeJwXQnOD5EDk1JQv0U8MVFvHeddoC6INWCKdQ1c
	 ZER9S+QcbiAykQOqEZWxmYMYsqx74WpsYsVy0oEg6j2/jzgDSuT2ZjhXWngPZC0/kr4XA
	 5cVBplmN/BHPUr6pNVOekQuoKC/ImjkTdN7tywE5vaqbS44TcTPAotiIx41kpofVuaM2z
	 aPgY8/II3E19QTeApWxfBOxA83KGjDVfe65yAd3sGpO5T8VDnGwPIzZW9lsCY3JXt7fPB
	 9Ciht/GyOdY1+DMxBuySm7QSMmrDO25MWl9xdnO2PPDmX354vChgvkH4tk35TNFqPEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ClgqgiCC;
	arc=none smtp.remote-ip=95.215.58.74
Received: from mta1.migadu.com (out-74.mta1.migadu.com [95.215.58.74])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD74D606A330
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 14:04:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD74D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ClgqgiCC
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xC4G0Cwhp7kj5bOO1KBaJmJUIF0RxwnSoVCIDB5s2WI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794578673; v=1; x=1795183473;
 b=ClgqgiCCzP13A/TYbH2Pfche+WTNU/pcWwKg4EiN63b9do3K/w0Xbtv2WllaHNvpctJpaz1y
 Hh6e4HCBLyLWowEXdndnH8ZoyNnap24oK4dXV6DEAMM5eMxwT8La+tgYsAdgKFeyuKiF3/mXlKi
 RfcW76bIdLFP9894KALKZLVY=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 6508aef634fb337d;
	Fri, 13 Nov 2026 14:04:33 +0000
X-Mizu-Trace-ID: 6508aef634fb337d
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Subject: [PATCH net-next 0/6] bonding: refactor bond_enslave() to fix XDP
 ordering and error rollback
Date: Fri, 13 Nov 2026 22:04:15 +0800
Message-Id: <20261113-bond_enslave_restruct-v1-0-364c549e78db@kylinos.cn>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMUQrCMBAFr1L220AaIaJXESlt8qorspXsthRK7
 27Uz2GY2UhRGEqXZqOChZUnqdAeGkqPXu5wnCtT8CG2Png3TJI7iL76BV2BWpmTuaM/RY8YMsY
 z1fZdMPL6+15JYE6wGt3+RufhiWTfLe37BzkzkyWDAAAA
X-Change-ID: 20261020-bond_enslave_restruct-30760e62def9
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Hangbin Liu <hangbin.liu@linux.dev>
X-Mailer: b4 0.16.0

`bond_enslave()` is over 500 lines long with complex logic and numerous
error rollback paths. It has XDP ordering isssue and missing some error
rollbacks for historical reasons (found by Sashiko when review bond
patches). The fixes are trivial, I plan to refactor the function to make
the logic clearer and resolved the issues. This patch set is the first
phase.

This series hardens bond_enslave() in two stages: first fix real
ordering and rollback bugs, then factor the function so the
infallible commit point and fail-fast validation stay obvious.

Problems fixed (patches 1-3):

1. XDP capability checks ran after the slave was opened, linked and
   could already be visible to the datapath . A slave without
   ndo_xdp_xmit could therefore be reached from bond_xdp_xmit().
   Checks move to the top of bond_enslave(), before any mutation.

2. Fallible XDP setup (dev_xdp_propagate()) ran after publication.
   On failure the undo ladder jumped to err_sysfs_del and leaked:
   - promiscuity / allmulti / synced addresses
   - ns maddrs added just before the failure

3. Error paths were incomplete versus release:
   - bond_alb_init_slave() success + later failure skipped
     bond_alb_deinit_slave() (TLB/RLB state, borrowed MAC)
   - bond_3ad_bind_slave() + later failure skipped
     bond_3ad_unbind_slave() (port left on its aggregator)
   - automatic fail_over_mac = "active" was not restored on failure

Cleanup (patches 4-6), no intended behaviour change beyond patch 5's
extack string alignment:

4. bond_publish_slave() — explicit infallible commit point
5. bond_slave_xdp_check() — shared by bond_enslave() and bond_xdp_set()
6. bond_enslave_validate() — all read-only checks

Testing: build debug kernel and run all kernel selftests

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
Hangbin Liu (6):
      bonding: check XDP support before enslaving changes state
      bonding: finish XDP setup before publishing the slave
      bonding: complete rollback of bond_enslave() error paths
      bonding: factor out slave publication
      bonding: factor out XDP slave check
      bonding: factor out bond_enslave_validate

 drivers/net/bonding/bond_main.c | 174 ++++++++++++++++++++++++++--------------
 1 file changed, 116 insertions(+), 58 deletions(-)
---
base-commit: 573af801552999954caa8347e4490b04cf4763f0
change-id: 20261020-bond_enslave_restruct-30760e62def9

Best regards,
--  
Hangbin Liu <liuhangbin@kylinos.cn>

