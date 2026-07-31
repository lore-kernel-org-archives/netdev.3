Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADF340927F
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 10:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785493036; cv=none; b=aLtb2TyqjGMEQ1CJiE4H2FKiSRsSgKW9bidCpfb8/V+pXt8AMUkcFEg5kkEbccOe1nC0wjV9TaJC6O78ExAt+Y0oZFHlGmcYz3e9pqtqTEWiaZRq/C/R7EZLb/yEo+xP0+53GNUYrZHbNvgpsPSuwp64Ke2iZE7J0N+czfYXEIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785493036; c=relaxed/simple;
	bh=zvnzDL5jc91mCpziI/WkXoqIm6A9BOrC0ngqHkuasv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uwUDVtpkaWb1RQXaE/X5vANR/V9fYXrahH13BkBOToRqlQ7lrmM6NMEbuoP3wqczGqnGTZP9LCaUAstnb0qwLuKIMfptJDv+3iJh0kP5x73Y6YJmQsV1VyIqh1zysj+omm5f6Kq8iLbOL6SkVvBZomTjD/IYY/bPDTHWi+7VI7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdXhqWR+; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdXhqWR+"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cc891373e0so7894285ad.2
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 03:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785493026; x=1786097826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jYPlNC3zN2lWfLh36G6tN8zz1VZu57wO9xdzsz1WXLc=;
        b=PdXhqWR+evCSlfrYoGbA+nNHf2AC+cDOlpLkIMwKs2DxXwe8zfc0FctDcYG5gXm/Eo
         6CniObB3V8+taFHxePLDBvIEDmDxr92PVdokDLWUccaCCSj53KNsOgEaR/hNfoyy4uOm
         Ol/QCWkM3pPNkvQam8yB9dxOLojEJ0NBLbvQJHnNoytRE7A1dmQ+PJ4Df7cxXyvXkfyo
         FYcRO5K03M3thVVwV89eZREV6yp///TSHcD+juNpQEbdm1jPDal28TYpl9JeQbYok8we
         xjGuHPlWsc+TR74p45ZjWgO1t9XsKZiz3HyS38Ie++99HewvUXaL/3ba9iVGhKPPdlPN
         XTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785493026; x=1786097826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jYPlNC3zN2lWfLh36G6tN8zz1VZu57wO9xdzsz1WXLc=;
        b=O9YRagqJcbTugKviCCyaBKsl0mZFBCFgJFwfy7oCeBRdeexeZVzcQuf+sSXMwb4sk1
         t6aWuQFqIErS/05Ept5wREu/qc4jRLNiDknxDlrzSOQg0wYqJrRsosiQVgs8P6ZSdDu4
         4NghRH2C5ZlwqLWBgiNW6f9L0T9QSGU+nbLdqOjP5xJdIqKGwjZW1/Ic4Mu9BZPAyWsL
         td9FPmRNzMHRNMjuIFHzFs54xFEuSc5vge1w30d23yEiqEgVs7cM9DqgPRSpf1C+4z6a
         FVkdmGjtOJaiG96ROX2q0FSiY5L04oItnzZJMZU4Dly6owsSeaFjjUFcm56OxQGDDfdj
         e7BA==
X-Gm-Message-State: AOJu0Yx/OlEYvHvIfsNfm3yoMSAg9sZid8YdROqDE3aDVeAR8GSn4jFJ
	jkkZBx0FofQx79CAwUbeM6++Hf14h9ZwOw1kHlyLPhbezjyaVfRhiWMsYfGLuaIRgTiAGVJN
X-Gm-Gg: AR+sD12eBhbFht0nxOx/G+iUG6YsaQwzFnOV2Fr+WDq7/ctVHZXjrlPTWPV0eDTpAMM
	uuu7vHT//TTGKLFyB6o5t8+lWKJ/2qY/zYx/0/+ETjDFoAKBzfSVqFKyEXZ+XA2SzR5fH/mdWw0
	xEJ3RrD9kqNObJ25ds4QCD49eioSnhBOs2L5B72Zj3Wd5zhat/np6ikrQokPEvdr3BofIB9o3wV
	GyRNtUwbuGiBErhpOyOwiM/7mQKW0mt/6AC49rF1TYFW3BrHenI17lP3U2mwoNYE7U21IKvaOIG
	rbp8BFZkWSS9f+Fa/RqgZKdxe9XUTVNjWJRYxNPIikV+hpxGVu11+4wkq/cIu+Vw7J7r/IOUVbJ
	iHfBugIeM67TafaXdjf2vMmY+bDKYCOz2v2kTdU1Y+d8jHq0nyH6yj3uhhPahEExKep/F3hOsfe
	EmwZfT+MAlXf12xEO/4V+AghfUR1yvl296/NpovrHpWufw/V46UtqSfIfg5ulMXD8lp+m/8kPsA
	XXiPVZ4d9b+r11wsQ/Gs63eLTU=
X-Received: by 2002:a17:903:1968:b0:2cc:a853:1311 with SMTP id d9443c01a7336-2d046ef0be8mr14436195ad.47.1785493026001;
        Fri, 31 Jul 2026 03:17:06 -0700 (PDT)
Received: from JUNVYYANG-MC1.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b15db1esm3436485ad.81.2026.07.31.03.17.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 31 Jul 2026 03:17:05 -0700 (PDT)
From: Jun Yang <juny24602@gmail.com>
To: netdev@vger.kernel.org
Cc: Jun Yang <junvyyang@tencent.com>,
	stable@kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>,
	Jon Maloy <jmaloy@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] tipc: reject name table updates with invalid origin node
Date: Fri, 31 Jul 2026 18:16:37 +0800
Message-ID: <20260731101657.29119-1-juny24602@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jun Yang <junvyyang@tencent.com>

tipc_update_nametbl() trusts the origin node carried in a received
NAME_DISTRIBUTOR message. For a WITHDRAWAL it removes and frees the
matching publication with tipc_nametbl_remove_publ() (a {key,ref}
wildcard match that ignores the node), then calls
tipc_node_unsubscribe() to unlink the publication from the advertising
node's publ_list.

tipc_node_unsubscribe() is a no-op when in_own_node(net, node) is true,
and in_own_node() treats node 0 as "own" (addr == own || !addr). So a
WITHDRAWAL with orignode == 0 frees the publication via kfree_rcu()
while the paired unsubscribe silently does nothing, leaving the freed
publication linked on the owning peer's publ_list through its
binding_node.

A subsequent legitimate WITHDRAWAL for a neighbouring publication that
the same peer advertised then performs list_del() across the freed
object, writing a kernel pointer into freed memory (use-after-free
write) and corrupting the live publ_list head. The whole sequence is
attacker-driven from received packets and is reachable by an
unprivileged local user, who can gain CAP_NET_ADMIN in a new network
namespace via unshare(CLONE_NEWUSER|CLONE_NEWNET), enable a TIPC UDP
bearer, and emulate a peer over loopback UDP.

A name table update must always originate from a real peer node, never
from our own address or from node 0. Reject such updates up front:
in_own_node() already covers both cases, so a single guard at the top
of tipc_update_nametbl() drops the malformed update before any
publication is removed or freed.

Fixes: 37922ea4a310 ("tipc: permit overlapping service ranges in name table")
Cc: stable@kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Signed-off-by: Jun Yang <junvyyang@tencent.com>
---
 net/tipc/name_distr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
index ba4f4906e13b..a496e2e9ef62 100644
--- a/net/tipc/name_distr.c
+++ b/net/tipc/name_distr.c
@@ -286,6 +286,9 @@ static bool tipc_update_nametbl(struct net *net, struct distr_item *i,
 	u32 key = ntohl(i->key);
 	struct tipc_uaddr ua;
 
+	if (in_own_node(net, node))
+		return false;
+
 	/* A peer-advertised binding with lower > upper can never be matched
 	 * or withdrawn and would leak the publication; the local bind path
 	 * rejects such ranges, so reject ranges learned from the network too.
-- 
2.55.0

