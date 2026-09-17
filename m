Received: from sender6-of-o54.zoho.com (sender6-of-o54.zoho.com [165.173.180.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802384A3F32;
	Thu, 17 Sep 2026 09:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789637180; cv=pass; b=aUmJ4AaNvZ0JHXcCbYz9xTJHW5a3fFgptIKfaCjq58zHkakVxordPcfODFRTbWC70zMFc4s4su9uiqh4XClHa/Q/SGgU55MwplJ64+T2hBQ4trKQt0Z49zt5grRu7cJzE64bExEXBgpqYgphAcNVHzwlHpmu8SK7HgJoJuoqPQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789637180; c=relaxed/simple;
	bh=bCRwsjIX7WaxgJ7GNM72qg0VF76uTMEtzqR9zjyg9cA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=q4WE9MN8tLy/YxfK62a5DZ5RVGia/PXQXqwDPcBIzAkqwahV96lOca/ryyeWH1fUQxhxUvlny/4MwhIYrHsMrSz1fn/oO4930aMkXrBYBq3J3AE5xTgAfn1YOybZdelNwT9WrxmgvYC6fQB68oE6pEVk6NYdxWYaaqrD1ldPhJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=fUZ/QP1E reason="key not found in DNS"; arc=pass smtp.client-ip=165.173.180.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="fUZ/QP1E"
ARC-Seal: i=1; a=rsa-sha256; t=1789637151; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bxdvY0wxrVa9HYz3ZEXGfCZkhJh5Dv+UAFyS88JylcZeTY/3X6aJq8ivnGl3RBuqyHoehQVVpaaSqKJ3SKPlVddt60yEJxiMzW55xSYaDA5uhjC396JMXDYcD64Zzvm2lRReOZczuILxa2U3D9+tO2PcltRs3HbnznBnghCaFB8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789637151; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UBzcHJxTK1fmt5BfFvOXeDsJtIo/3Y1KYBhtxqii7go=; 
	b=D/qRsUkrPM7QQIC+cvPKGsUGq2v6WtGPctP4qP8u4NOadAGC7Tqx6myxYrbyKnjd7IUzo5hVYUtfgQgMD9+6aoEnq3veqRWSUSGXSc2kwy77zCSbCDF/MuEIzgaYf3tDXIkkwi6Fxn8wed7l3YO2p1PxTOtRFS2SRJht32xPU60=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789637151;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=UBzcHJxTK1fmt5BfFvOXeDsJtIo/3Y1KYBhtxqii7go=;
	b=fUZ/QP1ErygIPzBqDhLGximVz+lQ02AW+SNQ0+8rgmLVoxuXNKMg19hztLrrXEm8
	LYCtAYAuHfzDEQ1aRtQu8kaxQ9IYa1QFoHSGA/4ifiZ2qkNF4OzEG/qbkvNo4mkfO3W
	TqqypK11PJPQFzrKqTfM72pEjr6Qz72pdJaJY6JI=
Received: by smtp.zohomail.com with SMTPS id 1789637150402869.8423370487822;
	Thu, 17 Sep 2026 02:25:50 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH net 0/2] udp: two fixes for the 4-tuple hash table
Date: Thu, 17 Sep 2026 14:55:31 +0530
Message-Id: <20260917-udp_hash4_fix_v1-v1-0-718891af0d7a@mpiricsoftware.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAuyq2oC/yWM0QrCMBAEf6Xss4FLKGr9FZEQk9OcD7Hk2lIo/
 XejPs4uMxuUq7Di0m2ovIjKuzSwhw4xh/JkI6kxHLkjDdaaOY0+B829f8jqF2tCPDE5Sj2dBzR
 trNyeX/KKwhNu/1Hn+4vj9I1h3z98gb5OeQAAAA==
X-Change-ID: 20260911-udp_hash4_fix_v1-ac7e020d4089
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Philo Lu <lulie@linux.alibaba.com>, 
 Fred Chen <fred.cc@alibaba-inc.com>, 
 Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Cambda Zhu <cambda@linux.alibaba.com>, Janak Bhatt <janak@mpiric.us>, 
 Kalpan Jani <kalpan.jani@mpiricsoftware.com>, 
 Shardul Bankar <shardulsb08@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Shardul Bankar <shardul.b@mpiricsoftware.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External

Two ways a UDP socket ends up in the wrong place in the 4-tuple hash table.
The patches are independent, with different Fixes: tags and no dependency
between them.

Patch 1: a socket that connects a second time is not relocated, so it stays
filed under its first peer's hash and packets for it fall back to scoring
the hash2 chain for its address and port.

Patch 2: a socket bound to a specific address and port is not taken out of
the table when it disconnects, because __udp_disconnect() only does that
via ->rehash() or ->unhash() and neither runs for it.

Both are in code shared by IPv4 and IPv6.

Patch 1's cost, with N sockets sharing a port and one of them misfiled,
200k packets sent to its 4-tuple:

	N	without		with
	200	1,061,652	2,093,259 pps
	500	  522,553	2,055,078 pps
	1000	  279,729	2,136,606 pps

Correctly filed sockets measure ~2.1M pps throughout, so the cost scales
with the number of sockets on the port, as the fallback scan does. For
comparison, commit 78c91ae2c6de ("ipv4/udp: Add 4-tuple hash for connected
socket") measured 290,860 pps without the table and 1,889,658 with it at
500 connected sockets.

Patch 2's cost is not in throughput. Its stale entry keeps hash4_cnt raised
for the life of the socket, so every packet for that address and port is
sent through the 4-tuple lookup first; on IPv6 the entry is also matchable,
because __udp_disconnect() does not clear sk_v6_daddr. That last one is a
separate defect, which I will send on its own.

Neither patch has a selftest. Nothing in tree reports which 4-tuple bucket
a socket is filed under, so a test can only measure the cost indirectly.
What I did instead was add pr_info() to the hash4 paths and a knob that
dumps bucket occupancy, then run the same scenarios on two kernels
differing only by these patches; that is where the numbers above come from.
The instrumentation, the reproducers and the benchmark are at [1]. If
exposing the bucket through diag would be welcome, that would make both
defects testable in tree and I am glad to do it for net-next.

Removing the connect(AF_UNSPEC) limitation described in 644f9108f3a5 is a
side effect of patch 1 fixing the general case. I can make it narrower if
you would rather that limitation stayed.

Tooling, per Documentation/process/generated-content.rst: this series was
developed in an assisted session with an LLM. The assistant did most of
the code reading, wrote the instrumentation and reproducers behind [1],
drafted these changelogs, and ran the A/B builds and the regression
suites below. Every claim in these messages was checked against the
source, and the IPv6 behaviour described in patch 2 was confirmed at
runtime.

Tested on x86-64, IPv4 and IPv6. No regressions across reuseport_bpf,
reuseport_bpf_cpu, reuseport_addr_any.sh, reuseport_dualstack,
udpgso_bench.sh, udpgro_bench.sh and socket.

[1] https://github.com/shardulsdk-mpiric/linux/tree/udp-hash4-fix-verification

To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
To: Philo Lu <lulie@linux.alibaba.com>
To: Fred Chen <fred.cc@alibaba-inc.com>
To: Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Cambda Zhu <cambda@linux.alibaba.com>
Cc: Janak Bhatt <janak@mpiric.us>
Cc: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: Shardul Bankar <shardulsb08@gmail.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
Shardul Bankar (2):
      udp: relocate a connected socket in the 4-tuple hash table on re-connect
      udp: remove a disconnected socket from the 4-tuple hash table

 net/ipv4/udp.c | 42 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)
---
base-commit: c9151088f1674fd29ff26a20f5fc687acf53a2f0
change-id: 20260911-udp_hash4_fix_v1-ac7e020d4089

Best regards,
--  
Shardul Bankar <shardul.b@mpiricsoftware.com>

