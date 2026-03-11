Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CAF31AF1B;
	Wed, 11 Mar 2026 00:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773188400; cv=none; b=rnxzrbKEuC8iXuRTNDhvCoTm6Z9HimMy4QolSgOd59pmRsUs6CPma2EIhpHb9j6sEOmK+Xsj6T1G4+1ez0QDqNaSUeFAy0+vvDogvo81LH6YeGsedcKui992bhenqRP+6+qG/RHZgYhVH5UByY/sxcNJWmxSIBRhK+Nn8yU/sQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773188400; c=relaxed/simple;
	bh=GL5j6EBn8e7PiwvxkxPwtJQFu27gagZNFuIBqE5fhco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bUpmQREhoUXItYrWXX0bx05RBNwqE43dksXuA8ImN7kkgMgQeU7BDRbjn3cq5vZbTmwE2Xt6QZCd9GR9KghyWloGA28ue82gwQm8or0EBfMbF846YhFXi3DhmjttJF5hom2o/j1FZyxxwrhwhi9RArujxF7/gBBevNTcsLMDaUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4/H9U0U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4/H9U0U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A96C2BCB0;
	Wed, 11 Mar 2026 00:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773188399;
	bh=GL5j6EBn8e7PiwvxkxPwtJQFu27gagZNFuIBqE5fhco=;
	h=From:To:Cc:Subject:Date:From;
	b=J4/H9U0U36BgfAPpk2KvttJ8D5ErUg93ot78AVvWHeTtIPbrndqgU3q7K85JXr60l
	 MAyrj6ywGV1/S7rlOPYtcD3aLih2LK6iIAOQqZAbEr1oFUzQc/uGquxAIYZmVVTzlL
	 zijGZMvj9xVeusQpP76otHHDczRwZ68au+LNXFqh8AhUvXaApVz9HQQkMK1ng7yD8L
	 Rwa5Sd9PAJ2nS+L+hRLUQelY/g8xD8U3AhDWqO6nzP0+cNxS6o7fzuTFIjOT0L8xfa
	 eYHG3/kpduSYElM3nu938YO9SS48Mdl6dM6LWkMfoJ9ka7UdSLBzigtQ+6xSmLOq3q
	 D2xLOXDoxl6Iw==
From: Chuck Lever <cel@kernel.org>
To: john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net
Cc: netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 0/8] TLS read_sock performance scalability
Date: Tue, 10 Mar 2026 20:19:44 -0400
Message-ID: <20260311001952.57059-1-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
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
 net/tls/tls_sw.c   | 212 ++++++++++++++++++++++++++++++++-------------
 3 files changed, 183 insertions(+), 66 deletions(-)

-- 
2.53.0

