Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933E538DC62;
	Thu, 10 Sep 2026 22:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789078790; cv=none; b=LfWu+yT96aiatRN/U+xmS+AlRXnF2sF2vn5SiEfGM+liEVUqOWhTCpIhB7lFCmdQbK5ZcSf77HqqVHrgGu9Hu1sTR42h2r0QeGLTfxfo40s/7KxC0eZkAWaJ9P51092uJcp7e83mXhHRPeI/CmEShP8v7ziYj/D9iVPzKGtuTC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789078790; c=relaxed/simple;
	bh=Gglb8Ttg0IagVCFsQJk+vch7e9SwxfzHBJ7aYTGzcds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ENk48M+aX4eX9PvGn+WrJva3Ch9jcdjFBKsobY2fir/SrsZ1IkuuiU8uifQaVd3mf3ePWnmuQCgY8OcgAQ9Fu/vHdnwhkA+dR+fUu0uO8BbuNlfNkBTHO0HE673JmKlzaJqaVtzA+ATH/6/6xpaTDs0/XupA36EY96OHqSiM0mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=rvvUrRmA; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="rvvUrRmA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1789078778;
	bh=Gglb8Ttg0IagVCFsQJk+vch7e9SwxfzHBJ7aYTGzcds=;
	h=From:To:Cc:Subject:Date:From;
	b=rvvUrRmAee3uAedtkHA/B/n79LYHu6MpbA9wwbQr8KvWRstnDljoE1hxbFLanf4C6
	 YbTNTDXqLORWJ4PMpkUHK8WcPSRuvCtmAYthwD2JXK7/ykQRIN6/DVdtV3Hqbnq8Fx
	 hHdwTe2gSkUFzGPyvwLTds0TD2/8kVpePr1eYkqECYIOutSdJDZegflXETDLarRZz7
	 cCZOwK2hClNtHfD+IfHDNN9fHBLweD2RycWW2fMNwAEOgXih90LQKv8U0HrBiuRLkn
	 Y3UHDc0+DVXkr8gR8PTWNKWW4Je+Uc1YeulKWxk/LB0Nel5MVBPP5uPk4xQKtauXr4
	 4CT9IXTr6CHbg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 3721760103;
	Thu, 10 Sep 2026 22:19:19 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id B9677201C97; Thu, 10 Sep 2026 22:17:34 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Danielle Ratson <danieller@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Greg Thelen <gthelen@google.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"Matthieu Baerts (Netdev Foundation)" <matttbe@kernel.org>,
	"Maxime Chevallier (Netdev Foundation)" <maxime.chevallier@bootlin.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Remy D. Farley" <one-d-wide@protonmail.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Heng Guo <heng.guo@windriver.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 0/8] tools: ynl: C-based YNL linter
Date: Thu, 10 Sep 2026 22:17:20 +0000
Message-ID: <20260910221733.1021864-1-ast@fiberby.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This RFC series adds a C-based linter for checking YNL/C alignment,
and as an example fixes the reported issues in rt-link.

The series is organized as follows:
  Patch 1-2) Prepares the last families for C code gen.
  Patch   3) Introduces the new linter.
  Patch 4-8) Fixes the reported issues in the rt-link family.

When run on net-next the linter reports the following:

$ make -C tools/net/ynl/generated lint 2>&1 > /dev/null |
	grep 'Linter summary'
conntrack: Linter summary: 48 errors, 0 warnings
devlink: Linter summary: 5 errors, 2 warnings
ethtool: Linter summary: 10 errors, 2 warnings
mptcp_pm: Linter summary: 0 errors, 4 warnings
nftables: Linter summary: 183 errors, 0 warnings
nl80211: Linter summary: 193 errors, 0 warnings
nlctrl: Linter summary: 23 errors, 0 warnings
ovs_flow: Linter summary: 2 errors, 3 warnings
rt-link: Linter summary: 173 errors, 8 warnings
rt-neigh: Linter summary: 31 errors, 0 warnings
rt-rule: Linter summary: 9 errors, 0 warnings
tc: Linter summary: 11 errors, 1 warnings

After this series rt-link has 2 false-positive warnings:

$ make -C tools/net/ynl/generated/ rt-link-lint 2>&1 > /dev/null
rt-link: WARN: vlan-protocols: Possible missing member before
ETH_P_8021AD (33024 -> 34984)
rt-link: WARN: netkit-policy: Possible missing member before
NETKIT_DROP (0 -> 2)
rt-link: Linter summary: 0 errors, 2 warnings

WDYT?

Asbjørn Sloth Tønnesen (8):
  netlink: specs: nftables: add uapi-header
  netlink: specs: conntrack: add uapi-header
  tools: ynl: add C-based YNL linter
  netlink: specs: rt-link: add C naming info
  netlink: specs: rt-link: re-align IPv4 devconf
  netlink: specs: rt-link: re-align ifla-inet6-stats
  netlink: specs: rt-link: fix ifinfo-flags names
  netlink: specs: rt-link: fix netkit-policy names

 Documentation/netlink/specs/conntrack.yaml |   1 +
 Documentation/netlink/specs/nftables.yaml  |   1 +
 Documentation/netlink/specs/rt-link.yaml   |  60 +++++---
 include/uapi/linux/snmp.h                  |   6 +-
 tools/net/ynl/Makefile.deps                |  11 +-
 tools/net/ynl/generated/.gitignore         |   3 +
 tools/net/ynl/generated/Makefile           |  27 +++-
 tools/net/ynl/linter/gen-h.sh              |  23 ++++
 tools/net/ynl/linter/linter.h              | 152 +++++++++++++++++++++
 tools/net/ynl/pyynl/ynl_gen_c.py           |  72 ++++++++--
 10 files changed, 316 insertions(+), 40 deletions(-)
 create mode 100755 tools/net/ynl/linter/gen-h.sh
 create mode 100644 tools/net/ynl/linter/linter.h


base-commit: 0abe8777490ebc008635ecb20297761d1b317697
-- 
2.55.0

