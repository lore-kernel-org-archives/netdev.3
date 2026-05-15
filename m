Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAD2413D8C
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 20:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778876384; cv=none; b=eVmQ+RJW5zWEHBKXxGl3o6v4ByZwX7iMHqpjzSw/vG/fZOlPC+rjsTx8hWvFC+XfGg1f0+E/Y371Y8Hp2H44WAmJJXct0DTbvDsV5roG3sqirlxuwzEO6xLLRRBl9Ev2wFDWK7fg3nQTLcecvkNlIljBVXRsWiepKa0eXQdgQdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778876384; c=relaxed/simple;
	bh=IVAG7AjADp9pbIkirnW2LF7lyZL0hDgmHLHln1JCBGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bpf+Yb9lfz8ED0Wul61a9GGq3VSUHCBSQM1HeomRNEaX++bJ6b7nnbpCNyPkogKj8TK0fCmojpy18wg71MD5/dD4sTUtS5eahQ3krRYop/PClvcR3YuxJVNMMlHJ6PRqznBGKqyUZs4oC6PYmRmcI+WKQ+oyCwlx5+aDQh3m4r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so1947385e9.2
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 13:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778876381; x=1779481181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wKWO2Yi4eHfQwzUIECRCEbVVtbU/J0JhEXvTgyUNag=;
        b=hCY8y8kYAfIXQN+EBDxQJIDT3AIdXBNGwGgn0imoKVyeeZjxeHCC9i8iES4GU0Xy3Y
         rwlzrG/1wsCD6VRWma3Nhy1lNabHPuIKXqgjHGT05ekiifuMC1d17Ya7N7aocQ+4cvEr
         xHrFDSsGGEfmN32IfliHYeneUIhTyf30K9pnh/ybIqTkhTFrgrAPM/0kLUBXPLenDfFR
         HpXLEAe9Lp7YVPDI3xU16aUIELu1ghjYwviYIzYX8rgOsVx1mGhcLk9jwCb2dxwlwakJ
         bj9UEnbL+wMacUs17IN8LSul0ctUvNijyA+veLI9X/Ch6+DRNL9lrUl01y8deK8bRCYJ
         yirA==
X-Gm-Message-State: AOJu0Yy2xyMd2qlgeGGYpVAr5kPsWCor9SjIQFM64evu/2K3N/kYmqYB
	qJAnceP5Z8nkGmjeJRyPIYmSm6AzeAxRySv49XLDOCgfW+p9We5nBCXlc7cF8hNl
X-Gm-Gg: Acq92OHpJO7v1d52o5wPvoI9eXtSkRi16VoRqtena9Mc1/081wKg2LIz5rSrVoYQruY
	BrWL220bRNl8QMvJWaudXlwtqssl1QGBoDWm0szvdwWC8KPGWwOtGcGA9zFP0zWIpbeIFU9XvFC
	IE541oTa6t8YaI0jqrcS40uNtrHmSpxkimjNdED24Ldmj0wyf2RxqYJFyiTMsyHuVNL2stC0mUh
	sfoMjT1e2FjbE4FpjX8VOJ8zBxKJa6Hb6cPY92PbBlWjkQhTg/g4Wgd37avNlMB0wkp6UUc0gCj
	JfLWZUCBsall+6ahTw/NyQD1UTEee6EnPqVJ3nVEW0rqbUzbfPDV036nInoOmrXZ9viHDOIdFNB
	m4k0nDICN592fCqX1O0FPGA6OGCgf2cbNg8olmya3bVOBm2THLsy/EvA2lsx/rQPvI6eSvsVM6v
	Kno+vsBGz79kVBrtn7MXUHpTh3A9/s4TaT68iD8/0IASCvq4EJTBgITAJWPNc=
X-Received: by 2002:a05:600c:a11c:b0:488:9bf8:7f17 with SMTP id 5b1f17b1804b1-48fe61f27famr55369845e9.14.1778876381107;
        Fri, 15 May 2026 13:19:41 -0700 (PDT)
Received: from im-t490s.redhat.com (89-24-32-159.nat.epc.tmcz.cz. [89.24.32.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feab2896bsm22924605e9.4.2026.05.15.13.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 13:19:40 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Adrian Moreno <amorenoz@redhat.com>,
	Jiri Benc <jbenc@redhat.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Matteo Perin <matteo.perin@canonical.com>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net 0/5] netlink: fixes for cross-namespace nsid reporting
Date: Fri, 15 May 2026 22:19:19 +0200
Message-ID: <20260515201937.2813983-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While working on some new features for OVS and OVN we discovered that
self-referential NSIDs get unintentionally allocated in the system as
well as unexpectedly reported for local events on all-nsid listeners.

More details in the patches.  They change user-visible behavior, but
the current behavior is arguably a bug, as it makes it hard to use
all-nsid sockets without a decent amount of extra unrelated work of
tracking when new NSIDs are allocated for your local namespace.

Tests are added to check the expected behavior and YNL is extended to
support all-nsid sockets in the tests.

Ilya Maximets (5):
  net: rtnetlink: fix link nsid reported when the link is local
  selftests: net: add a test case for cross-namespace peer netns
  net: netlink: don't set nsid on local notifications
  tools: ynl: support listening on all nsids
  selftests: net: add a test case for nsid in all nsid notifications

 net/core/rtnetlink.c                      |   2 +-
 net/netlink/af_netlink.c                  |   8 +-
 tools/net/ynl/pyynl/lib/ynl.py            |  32 +++++--
 tools/testing/selftests/net/link_netns.py | 101 +++++++++++++++++++++-
 4 files changed, 132 insertions(+), 11 deletions(-)

-- 
2.53.0

