Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3D42F1FFC;
	Thu,  5 Mar 2026 21:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772745246; cv=none; b=FJI9X8RB/OByKAZ9X88p+W5z3xKwHPnGbR8suNyfCwNV4mATB4XhFTO10nmOqzMl9gnQ1Jymd1uNQxGV7ODeh8O4TAN9Z7J6cUM/2uZlVfKZJYDZCEEQecN1oWa0x9AMDziWppc+mrpfnolxyaHGbhjVuHzh+4ifVmoBFMIx+zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772745246; c=relaxed/simple;
	bh=sNzzSK7Tv4Zf+h+tnePYHBy64GXLa66ZaCoSTRTeFdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kuJtYewa5XetbSB+zEogJsItkS5pNJrTzIG26jZtAapmHl52q83whQ2kaxBcODZxPhjNC4UogpYyIWqDk4OQ0PAwUceipy2ckDfZzWNcF0ADTjS5VSvNg6/tpfeFeOKjgVrBPfy8heHsfA2cHO62CDOnLOJ7/NodyxatgTgCOjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFulUc1q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFulUc1q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87097C116C6;
	Thu,  5 Mar 2026 21:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772745246;
	bh=sNzzSK7Tv4Zf+h+tnePYHBy64GXLa66ZaCoSTRTeFdc=;
	h=From:To:Cc:Subject:Date:From;
	b=EFulUc1qE8tN0qcWjIwOrjcUdKaBs/ULowooNkQbzTL2iSSuoXXXEt5CSykoFfRdd
	 aHqrdgOmlSDOIcekCNbysl7QHWBSo2LXVcCP1eFrLSUtSAdAYC7ht5TtxcuJW04EDK
	 uDvj5Vp3CohVPEYVkP2CoG7clPGblUJmiYIuP+OXbWfgCxTvSn5TTyk4OOwj+VAY0/
	 kaS+fcFqg1RuH7i31HrV3xM6xHMoX3vXiUpUW25sfMl+Z1a/H3DgiEjzXdI8RiJHBR
	 gPUpGR1Gm6cUvvkKvEW5YMmZw4BynLQd0aerb7hWQlKzNmHcrhJ3rRf33DIQx32l6H
	 m/F9VvkeKL+Qg==
From: Chuck Lever <cel@kernel.org>
To: john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net
Cc: <netdev@vger.kernel.org>,
	<kernel-tls-handshake@lists.linux.dev>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 0/6] TLS read_sock performance scalability
Date: Thu,  5 Mar 2026 16:13:56 -0500
Message-ID: <20260305211402.39408-1-cel@kernel.org>
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
scalability issues with read_sock. This series is an attempt to
run these issues down and get them fixed before we convert the
above sock_recvmsg consumers over to read_sock.

Each patch's commit message speaks for itself, so I won't repeat
that content here.

Series is based on commit ab99e1167293 ("Merge branch
'net-ethtool-track-tx-pause-storm'") in the net-next tree.

---

Chuck Lever (6):
  tls: Fix dangling skb pointer in tls_sw_read_sock()
  tls: Factor tls_strp_msg_release() from tls_strp_msg_done()
  tls: Suppress spurious saved_data_ready during read_sock
  tls: Flush backlog before tls_rx_rec_wait in read_sock
  tls: Restructure tls_sw_read_sock() into submit/deliver phases
  tls: Enable batch async decryption in read_sock

 net/tls/tls.h      |   2 +
 net/tls/tls_strp.c |  36 ++++++++++-
 net/tls/tls_sw.c   | 157 ++++++++++++++++++++++++++++++++-------------
 3 files changed, 147 insertions(+), 48 deletions(-)

-- 
2.53.0

