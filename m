Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792746985;
	b=y4R3UZfC5/Q3KxPHGKDKfnOzzk5LW43nSb8y7nNw7yt1L2X7Uf0htBe3cqhU5ywNSx/V
	 DYwLuN9+T4M0yxUzljw41L5qNuBkgs+3APZXECIwv/sDzCJ31g5b+pnUL0Ia4qidK39Zm
	 RBrqbKKTqIFiUWzzdFMOTQkhXIzfuDPkysTHGsLXemP6AP8YXNG4HcTtMTTn27ELOMKOh
	 ve4hdnE3vSFq79ijHfV12the6ZCQbZycPEyo77eU2J8XfJGwmQCLD6uDtDrpNV3soKwSj
	 R7mA1QX551bXEpR4C9LHu9aIb4jxVWy55JoirgJm8jmawTJKqmxJK961HzTAWGZftiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792746985;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oBI4N91izr3cJn6kY+KTMO5nPi5tQd2NZvpOi2lFG5M=;
	b=NbgOmNvRVqWQ2rtdV132Bqh6817G7/F5RVfWZkgIvKqrB20XHA6ocFzTZHKeHTo84LKK
	 cLyCEXSF0bgY9yk5hdCXqcp2ezoTsi23aDu7iEBQa3beBxMM9ksrTGzkmrfL+A9zWSwqC
	 Z9AD9D3pg1Lkpp743FBKzIUmrvyRkdWwXbTjDHFpikqNu+jyP1q8eh2Hw1qncm57K6/AM
	 QiLuoOvJXMKdPGa9GCXasBDOXuXreaY/A376nFW2n5xESTUUphXpjC5ag02gCwNVcBJhd
	 1vXcHUgttz+8ziQwdjCUBqxuO/CiK1j2/abniegQ5TSTISR1ZhpIUIQjepCY7uyO/XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=r0ysmh8K;
	arc=none smtp.remote-ip=91.218.175.25
Received: from mta0.migadu.com (out-25.mta0.migadu.com [91.218.175.25])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99013606A31B
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 09:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99013606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=r0ysmh8K
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=X9TM650OebmRwJLsuG71hTCuTdvOT1LW5J7WGLHQn1Y=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792746982; v=1; x=1793351782;
 b=r0ysmh8KT78Hflw428Fr+mrCwAUcbpK2JYwvqX0eMHJDsgBntIvbOv2RhbWaIUyzXOioH2k3
 gyFqQEW0CNhVVpT6tVnxcehW0yNEpB+zZzeff182EauIuhZPZsGnuuOoqBLLETnwN3j1SoHs2k5
 l+tCzwJV89iuwXApwlIO9Qb0=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 43f3da9f26efb15e;
	Fri, 23 Oct 2026 09:16:22 +0000
X-Mizu-Trace-ID: 43f3da9f26efb15e
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Joel Granados <joel.granados@kernel.org>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Wyatt Feng <bronzed_45_vested@icloud.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Yung Chih Su <yuuchihsu@gmail.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	Flavio Leitner <fbl@redhat.com>,
	Petr Mladek <pmladek@suse.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 4/5] ipv4: restrict igmp_qrv to 255
Date: Fri, 23 Oct 2026 17:13:30 +0800
Message-ID: <20261023091419.167088-5-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023091419.167088-1-jiayuan.chen@linux.dev>
References: <20261023091419.167088-1-jiayuan.chen@linux.dev>
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

net.ipv4.igmp_qrv only has a lower bound, but ip_mc_reset() stores it
into the u8 in_device::mr_qrv, and the IGMPv3 retransmit counters filled
from it (crcount, sf_crcount) are u8 as well. Anything above 255
silently wraps. With 256, mr_qrv becomes 0, every
"in_dev->mr_qrv ?: sysctl_igmp_qrv" falls back to 256, which truncates
to 0 again in crcount, and igmpv3_send_cr() never puts the state change
records for the group into a report. The older version querier present
timeout (mr_qrv * mr_qi + mr_qri) also collapses to just mr_qri.

Unlike MLD there is no WARN_ON() here, the reports just go missing.

Cap the sysctl at U8_MAX, the largest value mr_qrv can actually hold.

Fixes: a9fe8e29945d ("ipv4: implement igmp_qrv sysctl to tune igmp robustness variable")
Cc: stable@vger.kernel.org
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/ipv4/sysctl_net_ipv4.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index e3760daa3470..ef631a2759b0 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -33,6 +33,7 @@ static int ip_privileged_port_min;
 static int ip_privileged_port_max = 65535;
 static int ip_ttl_min = 1;
 static int ip_ttl_max = 255;
+static int igmp_qrv_max __maybe_unused = U8_MAX;
 static int tcp_syn_retries_min = 1;
 static int tcp_syn_retries_max = MAX_TCP_SYNCNT;
 static int tcp_syn_linear_timeouts_max = MAX_TCP_SYNCNT;
@@ -978,7 +979,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE
+		.extra1		= SYSCTL_ONE,
+		.extra2		= &igmp_qrv_max,
 	},
 #endif
 	{
-- 
2.43.0

