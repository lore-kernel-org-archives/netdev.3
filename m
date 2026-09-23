Received: from out-2uec-a122.jellyfish.systems (out-2uec-a122.jellyfish.systems [63.250.43.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341AD438FF4
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 09:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.250.43.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790155288; cv=none; b=lSBHAqcleNsh/BYpO3bkfTrziRsvIGBMVqkO6U0PvSGkHfC99dRnxvXp19K2AxYB49Bim4r9v2qp8Lrf0geRFZfwtQJTd8R34EhhhZBeiNAC/qPr9+5yyyTbfQZ4xTW7Y2BgsCI3Q+gyUDd4RxngNkiGi/JMR583RkEC4jlLAzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790155288; c=relaxed/simple;
	bh=cN6z/Pe0tXCGy/MD8INkQlbrW6q+ydU7Lhd1LS0jMsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hH1HP9KIsQ83xz+Xk5RJX1EyTluNM3QCdmoQ2FT/m7+YbOz2LQR3DbFYk9EAJhx2Xjt0wGAcEbMbj3F8JxQbP6a3FsmuCQxy9xkVD9dA1NqhNIYCNld/d7Oc9DZGmkv6m5R/8vGwXP8XQCZRpBmgZQJBOrkZ+agJHz7u5QKITWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rexion.ai; spf=pass smtp.mailfrom=rexion.ai; dkim=fail (0-bit key) header.d=rexion.ai header.i=@rexion.ai header.b=YPg6FAu3 reason="key not found in DNS"; arc=none smtp.client-ip=63.250.43.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rexion.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rexion.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rexion.ai header.i=@rexion.ai header.b="YPg6FAu3"
Received: from research-box.ec2.internal (ec2-3-80-226-50.compute-1.amazonaws.com [3.80.226.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hqWY95FF6z8sXh;
	Wed, 23 Sep 2026 09:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rexion.ai;
	s=spacemail; t=1790154974;
	bh=f0xvgxyic25iqtM158tAljgKODNBCj3X84E9dZhTLy4=;
	h=From:To:Cc:Subject:Date:From;
	b=YPg6FAu3ejFUTct0z+/bNZN+24U+rIpMEF9HGwl6YMuQCwkP7c08t13f6EO9syiuB
	 0sfBUiQYQTivWsFS0rcDKnnSgAAic9Awix5PQq15OnnFxnchQcizlW+pJvSTtbeKhE
	 DTGWuIc5SHrq/ZSwursHEReDvtm0GLIH1A0EBUqXPINJ+H+/w3SAz31rCwD1R3kbn1
	 rDlGICPXuHtd9Inpl4K1uvieWqlXUAd1YNmo8nG6BzJuiuCFBA1VIiOGChoiAxVuhb
	 GysdXf54MkWeF4rldilEro86Qsu0D3zg8paueqzdCM1ka/fWng7ytSCZiqIbiNsnQl
	 mb5FhfOARZLVg==
From: Rahul Chandelkar <rc@rexion.ai>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	Rahul Chandelkar <rc@rexion.ai>
Subject: [PATCH nf-next v4 0/4] netfilter: conntrack: shared port parser for helpers
Date: Wed, 23 Sep 2026 09:16:04 +0000
Message-ID: <20260923091608.2617604-1-rc@rexion.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: rc@rexion.ai

Both nf_conntrack_irc and nf_conntrack_amanda parsed port numbers from
application-layer payload with simple_strtoul(), which requires a
NUL-terminated string and returns unsigned long without any range check,
so a value above 65535 was silently truncated when stored in a u16 (e.g.
65537 became 1) and a conntrack expectation was created for a port that
never appeared in the payload.

Instead of open-coding a range check in each helper, this series adds a
pair of length-delimited parsers to the conntrack helper core and uses
them from the IRC, Amanda and SIP helpers:

  nf_ct_helper_parse_uint() - bounded decimal parser for an unterminated
    buffer, capped at UINT_MAX.  Its body is taken from
    nf_conntrack_sip's sip_strtouint().

  nf_ct_helper_parse_port() - wrapper that rejects port 0 and values
    above 65535.

Patch 1 adds the two helpers.  Patches 2 and 3 convert the IRC and Amanda
helpers (the actual truncation fixes).  Patch 4 removes the now-duplicate
sip_strtouint() and the open-coded digit loop in sip_parse_port() from
nf_conntrack_sip and uses the shared parsers, so there is a single
implementation in the tree.

Compile-tested (W=1) with NF_CONNTRACK_{IRC,AMANDA,SIP,FTP}=m.

v4:
  - Rebased onto nf-next.
  - Move sip_strtouint() into the helper core as
    nf_ct_helper_parse_uint() and build nf_ct_helper_parse_port() on top
    of it, rather than adding a second uint parser; convert
    nf_conntrack_sip to the shared helpers and drop its private copies
    (Pablo Neira Ayuso, Phil Sutter, Florian Westphal).
  - Target nf-next (Pablo Neira Ayuso, Jakub Kicinski).
v3: https://lore.kernel.org/all/20260503083220.630655-1-rc@rexion.ai/
  - Added nf_ct_helper_parse_uint() as the generic base and a fourth
    patch converting nf_conntrack_sip (Phil Sutter).
v2: https://lore.kernel.org/all/20260501063156.2520780-1-rc@rexion.ai/
  - Introduced a shared nf_ct_helper_parse_port() in the helper core
    instead of open-coding range checks in each helper (Florian Westphal,
    Pablo Neira Ayuso).
v1: https://lore.kernel.org/all/20260430161230.3438973-1-rc@rexion.ai/

Rahul Chandelkar (4):
  netfilter: conntrack: add shared uint and port parsers for helpers
  netfilter: nf_conntrack_irc: use nf_ct_helper_parse_port()
  netfilter: nf_conntrack_amanda: use nf_ct_helper_parse_port()
  netfilter: nf_conntrack_sip: use shared helper parsers

 include/net/netfilter/nf_conntrack_helper.h |  5 ++
 net/netfilter/nf_conntrack_amanda.c         |  8 +-
 net/netfilter/nf_conntrack_helper.c         | 68 ++++++++++++++++
 net/netfilter/nf_conntrack_irc.c            |  4 +-
 net/netfilter/nf_conntrack_sip.c            | 86 +++++----------------
 5 files changed, 98 insertions(+), 73 deletions(-)


base-commit: 87b80c2f6b05cad9f0ff9136709c62a0f59923e3
-- 
2.43.0

