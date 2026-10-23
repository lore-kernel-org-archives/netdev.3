Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792746880;
	b=qD5QW2dLX/gyQeSXHSMPhQUHrGsqNx2x6pphf23aazi3Y+3fPz0/Hy+LwWTEB79yFwHv
	 iCoJbgdKn8POCdWpUmkpfT81ks0fl7AR8+lnL2ElquDPXhuak08VtFoQdxkkomcgzx12e
	 5OrVm3IFhqqbv5RB4cVIYXlbKrYBANNTmuDqumDTns8XWmJAIbByUYwJueR6+tQyucsg3
	 QeIBvVUhECmxgV/Pn/2Fje8ATFfKbBDJatp9HJuxkbBuNRcy2X4g8V6d5Yl33Mc7m+4Ey
	 NdLkBX5sI0bbNOXU5Cr2orDD4e4oHjbhu5U1rEWmZkYlZOJOi2AGWYPKP+GheIPuftA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792746880;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=4zAc3he/vCh5XQJ3xmbFTBFKdpkOc7QTrO/peAQSjfo=;
	b=5DSgybc4cfw/mtrZNawCrvAd9ZejWXlsbed4wYu/pexWz6b7GiK9yHxaLWPTUnwE0nH2
	 PvdAI79oS+fcKiaKfCKJQ2A1L+2MAfhVpyRZBIlw+Gt5KU3ivf3scPev6wDqKRpTQZ3GD
	 ma6RWXRI7Z/gGn9SCeWYMdjvbJlaPxruHRtvmf6uhd/W5HnxJvvzTnFjmp8sA8E24cyVd
	 7cGsAtWo2zRW6nDavN7tJDDBOn5C7aQYhR4IdpWCyEYvRYyLI+KOhPnjFa7cOOOyo4LYI
	 VwpF3qUCcY8zCiGVKPWFy7BAwsDlp54GLGFi2TuEviiSQ2qhyMI2SPI9wndFYAtcQBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FvmHYpW9;
	arc=none smtp.remote-ip=91.218.175.227
Received: from mta0.migadu.com (out-227.mta0.migadu.com [91.218.175.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799B8606A32D
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 09:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 799B8606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FvmHYpW9
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=bCF8cbR3CbPnLMlPgvVa1/bBaRcT7OGjsLq3olXXh6Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792746877; v=1; x=1793351677;
 b=FvmHYpW9aue5DDkI54G1xWxUCkzbbIfriTbxvh0qPAEbJunpYQD84yBr9kqdtmFDdh3zuNI0
 J+XK4IWtTWqJQof0Yu+ayZL9WCLHQVt/baf1oRKciCg0wgexG+gPkg9pIwAlU2LbvgBIfMyxnrZ
 W08ljWi7vhC66CWhS8XTbEUE=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5c5795b909675e0d;
	Fri, 23 Oct 2026 09:14:36 +0000
X-Mizu-Trace-ID: 5c5795b909675e0d
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Joel Granados <joel.granados@kernel.org>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Yung Chih Su <yuuchihsu@gmail.com>,
	Wyatt Feng <bronzed_45_vested@icloud.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Flavio Leitner <fbl@redhat.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	Petr Mladek <pmladek@suse.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/5] net: fix misc signed overflows caused by bad sysctl values
Date: Fri, 23 Oct 2026 17:13:26 +0800
Message-ID: <20261023091419.167088-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
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

Recently I have reviewed quite a few fixes for variable overflows caused
by config values, i.e. a value set from sysctl, module params or netlink
that is accepted as valid but later overflows when it is used in a
calculation. I believe there are more of these still out there, so I
used an LLM to dig through the code and it found the issues fixed in
this series.

All of them have been reproduced and verified in QEMU.

Jiayuan Chen (5):
  ipv6: restrict gc_elasticity to 31
  ipv4: fix shift-out-of-bounds in ip_rt_send_redirect()
  ipv6: restrict mld_qrv to 255
  ipv4: restrict igmp_qrv to 255
  net: restrict message_cost and message_burst to non-negative values

 net/core/sysctl_net_core.c | 21 +++++++++++++++++++--
 net/ipv4/route.c           |  7 ++++---
 net/ipv4/sysctl_net_ipv4.c |  4 +++-
 net/ipv6/route.c           |  6 +++++-
 net/ipv6/sysctl_net_ipv6.c |  4 +++-
 5 files changed, 34 insertions(+), 8 deletions(-)

-- 
2.43.0

