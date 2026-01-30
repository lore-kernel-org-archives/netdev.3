Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A11C320A14;
	Fri, 30 Jan 2026 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769784719; cv=pass; b=Wfkykv5ISvWiVc/eig7fzRcPS0/Po9VsNCPpFuOH3JmAuezsYFTrUOwoT42Eygl4G12J719pUb5OJ5kV5rK56KodK/tYFoHn+JktPeL25F6gGJ5zO9sIKWdQoF9vytECN2c+ullcR82OcFIacSpu5n+s2C1pfPo5AgadDGLSY8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769784719; c=relaxed/simple;
	bh=j6fbFWZP2ADs2fqCLeUadbhMNFm3KNswEk7ADDlDjVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PADWpGxmZ10mADycL8oCS8YrwkOBm2/lNHqI29je7I7F4mkTQ0Q/KsHN299BlGEixqJA8Objmn9J08jJ3NQoyBdK1YgRM0N/f9DREWb7Unfm/jv3362uyujJ40cqGN4Px7Ea0iJP459eIf8nTYDUfzpbpDwmDfZpfZE+VC87xnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=VK00dKWf; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="VK00dKWf"
ARC-Seal: i=1; a=rsa-sha256; t=1769784700; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kiL6eAYiiyG+XNCTUcX3pA9sH+Nk/coH6tw89v05crpDP/LxBK/YgTukWje+t5drNFZXADtH+yw3577GpIjcK0fm0k4AnxILWR8ipDqMMeC6ERsXHTfPoI8mcPfyJLZ2d0Ir4g8xCdy7zDHDJcyEhAiYg6uGk7emtfbmQPAPZMA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769784700; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8hiaHrWtokc3qBHDXLZaKhVyvciOytw2eznn0slri4o=; 
	b=mTy5XzFid81gXR07Ohm1JcveXfh8kEp6jAIDeajMSoQu5ixMlOgJs3x5RlhQ+sbMRiQ4d8zl+1J0qxra3Glrm5vvdTNTzO1jO/+8/BdAGnIrzeTR2bKezMji7y5t6q0zkHBtsEATBEAcBthz74Lf9gQwYmeeKnAE6sd2Ypluk/A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769784700;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=8hiaHrWtokc3qBHDXLZaKhVyvciOytw2eznn0slri4o=;
	b=VK00dKWfmFybsLH+7/3XM8WZzdrFP94INY3bS7PR805Du4cPMdMZTAjYV+THCqOq
	YeXhjLVPO7NjhHv0lkbv4/YcAH63QaDfKpAkg/fnOBLtSR/v7h3PCVNHVPj27smS16W
	ZAC6AiHWewtJHcoeCoahmQgo45hoRDM2GcH9y8nI=
Received: by mx.zohomail.com with SMTPS id 176978469610848.338806107559435;
	Fri, 30 Jan 2026 06:51:36 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pratyush Yadav <pratyush@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v1 0/3] liveupdate: suppress TCP RST during post-kexec restore window
Date: Fri, 30 Jan 2026 22:51:16 +0800
Message-ID: <20260130145122.368748-1-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

LUO supports kexec-based live update where userspace restores preserved state
after the new kernel boots. For established TCP connections that are restored
in userspace (e.g. CRIU), there is an unavoidable window where the new kernel
has no socket yet but the peer can still send packets. The TCP no-socket path
replies with a RST to segments with ACK set, causing the peer to immediately
tear down the connection.

This series tracks a bounded "restore window" in which incoming LUO sessions
are expected to be retrieved and finished. The window ends automatically when
all incoming sessions are retrieved and finished (or their session file
descriptors are closed), can be terminated early via the global
LIVEUPDATE_IOCTL_RESTORE_DONE, and is also bounded by a hard timeout (15
minutes) so it cannot remain open indefinitely.

On top of that, an optional cmdline knob, liveupdate_tcp_rst_suppress=on,
drops established (ACK && !SYN) segments that would otherwise trigger a RST
while the restore window is in progress. Default is off and requires
liveupdate=on.

Tested with an established TCP stream across LUO kexec + CRIU restore; calling
RESTORE_DONE after restore avoids TCP RST and the connection continues.

Li Chen (3):
  liveupdate: track post-kexec restore window
  liveupdate: bound and control post-kexec restore window
  liveupdate: suppress TCP RST during post-kexec restore window

 .../admin-guide/kernel-parameters.txt         | 10 +++
 include/linux/liveupdate.h                    | 26 ++++++
 include/uapi/linux/liveupdate.h               | 34 ++++++++
 kernel/liveupdate/luo_core.c                  | 31 +++++++
 kernel/liveupdate/luo_internal.h              |  5 ++
 kernel/liveupdate/luo_session.c               | 85 ++++++++++++++++++-
 net/ipv4/tcp_ipv4.c                           |  5 ++
 net/ipv6/tcp_ipv6.c                           |  5 ++
 8 files changed, 198 insertions(+), 3 deletions(-)

-- 
2.52.0
