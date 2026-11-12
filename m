Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487937;
	b=288DrwB78Z/PdijGkxIu0inbFRTfvO5J2mtyjvK7pIzWMUM9Id6gT4IMUxT2mxV9KXQD
	 AUfWHVYsoshkQSsXZtNnXKfF+p+aFY80JyoX7CD6JzCbwCiSZC1Iqz58ylKdEKnUJh5tu
	 Tq6911xfug7dYpxOdu+leHD6FUiBoyakCdVaR4T0QZRq1qeQJxN45iQ7Xi9t506RliAgQ
	 4bEBEZPhvzn6IdSJ/nRuoSpKR4npMtpUA21pBGCvMQuLUQD1HYyV3Oa32W0uG9vnC6tCF
	 S1jKqVK966kBWtlgImLzymXKIj8OaBL76dxKTlpw0mGrOc9I6AaBWYuQRDJTBlfSx+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487937;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KWl2nH8QGR76CCLtZk6bqGKfbZExirp/BPFDBGPTkYk=;
	b=oYd1RWT4Gz7AITUWZXZiKqJC8swXja//7o1OCj8kukmmjRdQhSP9bB3JV2xLBprIVfWW
	 qgioqf/IhhYQEhVGXzXlIN4CigEOKqkkgS2c/hiv2j8B4j2zjlFL7Lv+Uj1s7mShpauC2
	 kLI/5D+ayA/304YBBaCo+/3zMW91mNE0gMMAtijmHWplN6UARnVnNcfmcGttqxwxd0kW0
	 0tKQWp+dfGDbuql1wVmBR14hk9xMabclmJZH4cEtlFjEFuA3yLyKT9Cgsod+FPTT/xyV9
	 +zolQW+EV09QI8t+FfI/yPsAhdUNbckGpeouMJWas4AnCQoLK4TTYGUrerKcZALECmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=n3VRUvKO;
	arc=none smtp.remote-ip=115.124.28.170
Received: from out28-170.mail.aliyun.com (out28-170.mail.aliyun.com [115.124.28.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301EB606A323;
	Thu, 12 Nov 2026 12:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 301EB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=n3VRUvKO
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794487925; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=KWl2nH8QGR76CCLtZk6bqGKfbZExirp/BPFDBGPTkYk=;
	b=n3VRUvKOwIzpuLc/YV1XH7nyFfNt6qwb2oGsjp24WiDe5k2/VFegqJJi+lECBNMRSoi8P0iVX/+JN1/ZjRm96RRuhJGTf4Mhq2E9GhTWXAp/PZB3m5w+8CuhtdkFXnoYJpJXDD86xXZxcsz3Z6t5qa48QmghnEHrK6oe2+hUroM=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04498484|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.20549-0.0143386-0.780171;FP=3337311923600399844|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033025068124;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.k0cpdZq_1794487922;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.k0cpdZq_1794487922 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 12 Nov 2026 20:52:04 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	netdev@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Maoyi Xie <maoyixie.tju@gmail.com>,
	Simon Horman <horms@kernel.org>,
	M Chetan Kumar <m.chetan.kumar@linux.intel.com>
Subject: [PATCH net 0/5] net: wwan: iosm: validate MUX DL lengths and offsets
Date: Thu, 12 Nov 2026 20:51:56 +0800
Message-ID: <20261112125201.1019-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
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

Several lengths and offsets the MUX downlink decoders work with are
supplied by the modem: the size of the received block comes from a
device written transfer descriptor, and the ADGH datagram length, the
ACBH block length, the command chain offsets and the length a command
header declares for its parameter are all read from the block itself.
None of them is bounded against what actually arrived, so a truncated or
enlarged DL block makes the driver read past the received data, hand the
network stack a payload the device never declared, walk a command chain
that points back at itself, or decode the bytes of one command a second
time as the command following it. The aggregated datagram block path is
already covered by commit 526b8ef54668 ("net: wwan: iosm: bound device
offsets in the MUX downlink decoder") and is not touched here.

This series adds those bounds. The checks only relate the device
supplied lengths and offsets to the received data: no command type,
response or protocol semantics change, so a conforming modem behaves
exactly as before. Patch 4 is the prep change for patch 5, it stops the
driver from copying the received parameter union by value and from
building its answer inside the received block.

cmd_len is not used the same way in the two paths. In the aggregated
path the parameter boundary is next_cmd_index, or the end of the
received block for the last command: the flow control decoder already
keeps a backward compatible handling for a cmd_len that does not match
the header and its parameter size, so the field is not a hard bound
there. In MUX Lite it is an upper bound when it covers at least the
header; a smaller value is not taken as a usable declaration and the
received length stays the limit. That is a compatibility tolerance, not
a valid input: the protocol requires 0x10 or more.

A parameter too short for the member its command type reads is dropped
with -EMSGSIZE, which also ends an aggregated block at that command.

Patch 3 also delimits the command chain by the received length:
block_length is checked to cover the ACBH header and not exceed the
received buffer, but skb->len is what bounds the commands. The
array_index_nospec() call of the walk is gone with these explicit
checks: it bounds a byte offset by sizeof(struct mux_cmdh), which
turns every legal offset past that size into zero, while the checks
constrain the same value against the received length.
array_index_nospec() is kept only for if_id, an actual array index.

Patch 2 relies on the ADGH header check introduced by patch 1, and patch
5 relies on the ACBH block validation from patch 3 and on the parameter
pointer introduced by patch 4. Patches 1 through 3 apply cleanly and
build individually against the base, the series applies cleanly and
every commit builds, W=1 drivers/net/wwan/iosm/ is clean.

Found by reviewing the DL decode path against the MUX protocol
structures. Not reproduced on a live modem: reaching it needs a device
that truncates or enlarges its own downlink blocks.

The series is based on the net tree at 145480b28ca8 and applies to it
cleanly.

Fang Xieyan (5):
  net: wwan: iosm: validate the MUX DL block length
  net: wwan: iosm: validate the ADGH datagram length
  net: wwan: iosm: bound the ACBH command chain walk
  net: wwan: iosm: pass the DL command parameter by pointer
  net: wwan: iosm: validate the command parameter length

 drivers/net/wwan/iosm/iosm_ipc_mux_codec.c | 197 ++++++++++++++++++++++-------
 1 file changed, 151 insertions(+), 46 deletions(-)

-- 
2.50.1

