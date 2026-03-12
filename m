Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3F432E692;
	Thu, 12 Mar 2026 01:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773280087; cv=none; b=Urob0Unt5y+IicIW3K0Hpp7Ca/RKJyK4SLAAmOytr/n0zQ23f9Ldm6+Lb5e3SiWUVvNvY0Q5bToUUoHRiydEifAV6xDyo6mjP9UCUImN76XXqmpa7+qPJw1TjOdpREe0CeRgbAojfoRC7R/UrYqPp9NowkdjOPD70/kkf39C+b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773280087; c=relaxed/simple;
	bh=g3zU/1nV6yV8qSKK59IKoogKsS8ghmFNA+vbOPXnYy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t8NIAEKVmnJ4yEySYuDkNLtQDgl4sOuyikFhxoGT11Buprl5JB36JmghA0mIzNyQCvrnWHFTUTsBZsjLXnHiTAmWWj707DHSFbj6eDixI5gJ7/3NJ2wO9nJggm842W1P6t1FFXoHGEkvPkeUqFBSGRD+X+R/jWStGWRZMRpmy9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBxdjXMU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBxdjXMU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B11C4CEF7;
	Thu, 12 Mar 2026 01:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773280087;
	bh=g3zU/1nV6yV8qSKK59IKoogKsS8ghmFNA+vbOPXnYy8=;
	h=From:To:Cc:Subject:Date:From;
	b=WBxdjXMUnZLCi1L30HMfT/NqjNuesWfU0csvFq4pLX6tYzEl/LjWwpuU7ajVsp45s
	 TZ1WyppDHNB/tgBoZLYIVy7Uwa4cvwYOauOYnhbhg+3wLeCOApALV9/tMLiU7nULXG
	 UhJzoc3yeXsMxG22kczBr9IkCBTvMpw3kBWULBqR6lb+dk5xU0P9+tbnVfq/Osgj6S
	 8MjHqE3M9goWp3OqyivcvauTOFtGnc5DK+1tabENYfPiCZ8cYnfW2OamkSwAfpSybM
	 YD2ES8rBjhDQ1LdtBIdRNx+JxNm4FpBR9cZ4O/ie1OJs4oPjZgjndQYOIpJyhIYfEB
	 RZ97zMJnqW29g==
From: Chuck Lever <cel@kernel.org>
To: john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net
Cc: netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 0/8] TLS read_sock performance scalability
Date: Wed, 11 Mar 2026 21:47:56 -0400
Message-ID: <20260312014804.5083-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

I'd like to encourage in-kernel kTLS consumers (i.e., NFS and
NVMe/TCP) to coalesce on the use of read_sock. When I suggested
this to Hannes, he reported a number of nagging performance
scalability issues with read_sock. This series is an attempt to run
these issues down and get them fixed before we convert the above
sock_recvmsg consumers over to read_sock.

While I assemble performance data, let's nail down the preferred
code structure.

Base commit: 05e059510edf ("Merge branch 'eth-fbnic-add-fbnic-self-tests'")
---

Changes since v2:
- Fix short read self tests

Changes since v1:
- Add C11 reference
- Extend data_ready reduction to recvmsg and splice
- Restructure read_sock and recvmsg using shared helpers

Chuck Lever (8):
  tls: Factor tls_decrypt_async_drain() from recvmsg
  tls: Factor tls_rx_decrypt_record() helper
  tls: Fix dangling skb pointer in tls_sw_read_sock()
  tls: Factor tls_strp_msg_release() from tls_strp_msg_done()
  tls: Suppress spurious saved_data_ready on all receive paths
  tls: Flush backlog before tls_rx_rec_wait in read_sock
  tls: Restructure tls_sw_read_sock() into submit/deliver phases
  tls: Enable batch async decryption in read_sock

 net/tls/tls.h      |   3 +-
 net/tls/tls_strp.c |  34 ++++++--
 net/tls/tls_sw.c   | 213 ++++++++++++++++++++++++++++++++-------------
 3 files changed, 184 insertions(+), 66 deletions(-)

-- 
2.52.0

