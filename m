Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845824C33E8
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790687573; cv=none; b=ZBgiQxE2wCJaAscQdJ0UAnT+NELO9Hyspw3/A85H7nyiI1RHOjZCIKeVzKrx1XrbKE3IL9Aappkh5p/ADLChjVGJjg/AlAxu+GVT/xLYDwX5KegjdI6Bfnnt7d6xODBfCQZd43gUP5LlSQK9lWp0O9HpiomOBsEL+WcEibJq+zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790687573; c=relaxed/simple;
	bh=qIvHSoh3BzPhEA+P9L4MU2Y5FKWM1AvxMVzN32tVaWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cvHFVlq5OPTsn0RbCYjOUsHUQrXY6gTDYtgeoftL1v9u4da9FONyQuNqwTddQ11AW1lHiTuaTvMVn8Y3isBIQYM8Ftdi2kXbmQlcpAPFOaijVTXrQQ4d4tLg++GZeZid90AKfqXRAMJnrIUF2Er2BN1kSYUsyXk6VQzMOnv12yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6KDvOXK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6KDvOXK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493681F000FF;
	Tue, 29 Sep 2026 13:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790687572;
	bh=ahZMk8IuffA+0zVMPEZXsoMAl6bzCyfxCspujF3LPrM=;
	h=From:To:Cc:Subject:Date;
	b=X6KDvOXKZjjce7idPjfYbq9EO7Xr8rwxr93D29A2+f+YdHxJ9wjAYeY31lW/i0s+l
	 1XjGnZHOWxf7wEUk2HnGmWp9PTOhufvXKLRkhp7zw/I8HtXlv8K2hSu9z76GYyb4RT
	 s8PXs+m/Qyzc8FWo+l9Oee2lDUwKyPCLuoI8yiE5tb77SgxPqL1cXLCYNE0UomtjL0
	 mlJxKjwIP/Hj/tHC+pInzeNuMFjIK1XXmf+6G9ltv86F0tTsXEUxcosrXJ8ombBSBw
	 pqcW1C7MDFDgMr8JB08LlnmP4WCzs5sGk6u/LVKsI7Rk/hR6vKvLWqioTW2cUuoboe
	 AHHrHTJiD9mkQ==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	netdev@vger.kernel.org,
	edumazet@google.com,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH net 0/2] ipv4: fix IP ID reuse for GSO packets
Date: Tue, 29 Sep 2026 13:12:45 +0000
Message-ID: <20260929131247.401104-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes two cases where IPv4 GSO packets can reuse the IP IDs
of previous packets:

- Patch 1 fixes ip_select_ident_segs() for non-TCP sockets, which uses
  the first IP ID of the next packet since commit f866fbc842de
  ("ipv4: fix data-races around inet->inet_id"). SCTP GSO is affected.

- Patch 2 makes __ip_make_skb() reserve one IP ID per segment for
  UDP GSO packets, instead of a single one.

Both issues were found by code inspection.

Eric Dumazet (2):
  ipv4: fix IP ID reuse in ip_select_ident_segs()
  ipv4: reserve one IP ID per segment for UDP GSO packets

 include/net/ip.h     |  2 +-
 net/ipv4/ip_output.c | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

