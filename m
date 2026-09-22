Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F8C54DAC6
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790084240; cv=none; b=aFHk0LuKWQ9h7LuZGEt7/k3u+G0CgU1lJ+yccUjZFlyFcLZFZ+S0jdS1MEfRM8ydc1GJqg3JlzwRkwOESUAGgmIHUS60sYiqr4TSD9jcS7CJVStD2m4ns8Flu5ivGGCIC6Qm8CZmTiI1eFPXxzRWO1kpS80jIqPIkqewYYZHVhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790084240; c=relaxed/simple;
	bh=gsGMeDbZxJOvaf9xEsUE9ntwkDlI9w8S1DxceZflmV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=erh0PLZbILabITqRGBPW9vd5knxHv84ZZDJ0RbFrxeMF99kgpOLvzG0azRgxYfRc8b4GQAxL16t6/37T1nf7Iid2vjsFUVUZpuVnBBm7hbdskTOBGZZzw9N2r3gwQ7MAJ0OBq4L9O3mAFdcETElgENvhgyVMNYVZ40qPRkWjTCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNNfRyc5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNNfRyc5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F431F0089B;
	Tue, 22 Sep 2026 13:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790084239;
	bh=jxWRejUtIeE3d2ZGmdL1cYpY91i/eT87f2tDvql+EHA=;
	h=From:To:Cc:Subject:Date;
	b=VNNfRyc5joEAXYeJwbqwjw8L9JBBgRwf2wQP05yrmtvU298gSro14zLmqdx3drB0x
	 5XZSPbtziOxuaJ1vhSUNJVbTleJC5AXH/R3W7i8cAL731a6/HgBns9c1AjhKO5cZaC
	 W3NdS01r440A3V3Swu54hu2XmBDn9c6vo+XTUfDiNE5wlvSo5PSrOczx5MEgpexT9q
	 aGkIaeE3k34jI2YwIHt20d0kmgVj6PbvoyFsLIGfWcr1HH151iZkJZNp1wOZvY8wUK
	 rrnS3zKI/SYtMHLrG6Gb1WmQvSmbnKqIKRu/k+q+7wpXnjqv0d7j2s7V7AaV093z6O
	 3Q9cf7FtWp0iQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 0/2] nvme,tls: minimal handling for TLS records
Date: Tue, 22 Sep 2026 15:37:06 +0200
Message-ID: <20260922133708.84522-1-hare@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

TLS 1.3 can send additional TLS records while the connection is established,
and typically one would evaluate these records with passing in a control message
buffer for recvmsg(). But nvme-tcp is using the read_sock() interface which
does not allow for handling of control messages.
So as the lazy way out I opted for resetting the queue on any non-data TLS records
as this would be the default action anyway for most non-data TLS records.
But turns out that this does not work as planned, as the TLS records are evaluated
(and errors generated) before ->read_sock() is called, so nvme-tcp would receive
the error but not start error recovery.

This patchset is the minimal fix to handle it, start error recovery when a non-data
TLS record is received and also return a distinct error code from tls to indicate
the situation.

The 'real' fix will of course involve actually reading the control message and take
action based on the type, but that is a rather involved operation which will be addressed
later. So for now this simple fix should be sufficient.

Martin Belanger (2):
  nvme-tcp: start error recovery when read_sock fails
  tls: return a distinct error for control records from read_sock

 drivers/nvme/host/tcp.c | 18 +++++++++++++++++-
 net/tls/tls_sw.c        |  4 ++--
 2 files changed, 19 insertions(+), 3 deletions(-)

-- 
2.51.0

