Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC11368D50
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 16:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788194523; cv=none; b=oebinoXyHiLbHd6C8cTD8TlZoRoStIjguypWKFnVe4p6PNc00Mcl4s0kTyqBHjTGPQxbsuls2izLGBliuUbzcowSKjNSyUeSPwlKdgIB9LUV5YgThVTrWSgxqcvkq55wWyDyr/dSEvFPaGgkrc+/2b4ZqlWB8dnZSdzwoc61t08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788194523; c=relaxed/simple;
	bh=jPX7zpjEzTXBH8AzVNhZN3TQTCIal8jJ9k+XCk9j4Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UAHiIUWVNmXGCjuA0IaDI3p8rqUq08xs9ooitQoS3351HjggyEPKBHf+qDYPCkMjTg0ZY7YFb2S47S/IpvMJVLgymAnnkjz4zGyqiNJB1qsQSNLvk5zSckYgk9fJr0A7cuE9Lc0LRtTbzsEzRNoY7CktP5WtUlx5YkPxJDCyLjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsOu0fan; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsOu0fan"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D181F000E9;
	Mon, 31 Aug 2026 16:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788194521;
	bh=qdRXNUAIgeRKzSir6v4ixjCB1WzemIZmQSCxn1vOZ4M=;
	h=From:To:Cc:Subject:Date;
	b=WsOu0fanR0qDLQZa+avUb+yRbqkVmBdTi69Gw+zZURL7a0dVaSeJjwp30gM5ukLE5
	 lMRAJrq6C2pj09V2bd5LUFyrwM1IH6FhbucESY+SE9PyqK4U4pIF/S3nNgR3Zuc5Au
	 GZrQ+8BlC64qL1Jka8v82KbReY/0QiiaWAmrP9NCM1cnfS3aRGNTq2tJzLNRQbIR26
	 vQ5HpH6HqeE0btLIFUq9RGGW/jxi8qI1BIu5oroDakcO6e6I3PyY5U+qe957sVjVMG
	 sMt7vZ2mkrdud+T18NeFJjjagmJTKk1xAdyaMEAIrNDDHqpqCm7Q22ztwUr/e7WsCi
	 GHFiV87M8xVdA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	daniel@iogearbox.net,
	razor@blackwall.org,
	bobbyeshleman@meta.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/3] netdev: address a handful of nit picks
Date: Mon, 31 Aug 2026 09:41:55 -0700
Message-ID: <20260831164159.1124679-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1 of this has been sent back in June, it seems to have fallen thru
the cracks.

I got slightly concerned about the state of the netdev-genl implementation
after Gemini found the bug fixed by commit c849de7d8757 ("netdev: fix
double-free in netdev_nl_bind_rx_doit()"). I fed the file into a couple
of models to make sure we're not sitting on more bugs. The models haven't
found anything worthy of a Fixes tag but some of the nit picks are
borderline worth addressing.

v2: patch 1 (the only one with feedback) was sent separately
v1: https://lore.kernel.org/20260609190804.1137085-1-kuba@kernel.org

Jakub Kicinski (3):
  netdev: correct error code in netdev_nl_queue_fill_lease()
  netdev: avoid skipping objects on race with device disappearance
  netdev: don't use dev->flags for IFF_UP

 net/core/netdev-genl.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

-- 
2.55.0

