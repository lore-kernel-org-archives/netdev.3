Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B912F2DF142
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 18:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784313054; cv=none; b=SlOpmcNWQ3iOSRKFgAS1SIH8SIeTGAf3Cu/NO8NRjH2YPi+Ru1FJzGh3gLMeBm4xtX5Bw+2vybXcHb3LwXRY6CAu+XyaJanOb4T6QbcuVJaKg+I0lPsHB+jCiq58Faul8/zpWGZnRgMuGsHFNkT7IKAwSkV+B/xcbZnT6BgXR/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784313054; c=relaxed/simple;
	bh=S0fBI2BnPftZwM5qyrmuPThS40ohvVBYZNXaxzmt+98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XGwcCKAqavND8xyA+QaH0pnXYQB1kHXNks3Tjpj/yNYxqhz1NElokEfabaN389MJJKnFVPKGXp6cU0HKO9PJNaIw9jUjfH2wOQ7eiJvYZnc+NZrXtYPghjCaSnUQ3CTlNGpkxZpgsv1y6XbKKyqsQut3Fk93XKo56hSH0DoV6zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqeW78AS; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqeW78AS"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso4994806b3a.1
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 11:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784313053; x=1784917853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n5qFnXDuynaBWXB+xQXJpY4due2ILsvQaghrEXz5Up0=;
        b=AqeW78AS1wt2hL6UH4CrvalfuY/qSCuEGS7Fmyka94QQ7GPX5v5mee0Wl3wuoVdhEw
         bsYyz9QTUAyzLtOw7nTesPmXEN6RDOUPhn1ec8wzJEhz1ja0ecGEQrnItV6ohELdT94A
         iswko8uQQsuxdGeCkbSYAuRxwbR6Isn/ViRdoSjJ+VkQ6T+MtUU45vLgCoVX0MagbRXq
         yByh7HBsb/G+p0+1vOadWiOmzl5KP8RLOnQFERCKW/AEQ5PRTykwa1kgLQxWG3tlhptO
         sifehWK5NAoBezZ8zLqnz5vEufK2xG5w+dupArUkkVIXJZVo4MdF1SHIYAkphNNu0oA1
         pLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784313053; x=1784917853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n5qFnXDuynaBWXB+xQXJpY4due2ILsvQaghrEXz5Up0=;
        b=i0Xzvs5nR4ueRNrY7f3MTi4GA+pPQvcQNtiMpfbTzndz2HZkbGX02/plMBttFl7xH5
         XMvyfgSBqi/SyjI+ffaCsm61BaQ9t7+Z9p3T8ajF6tIH+PUl7ZR4VcvLHkbbCPNIjOUL
         8GlXqG2P6HcPN/2o3z2sQbU0JTYy9sIFm+uAREo2WgjU1Y7Fp+P/OM7xS7qshqO69VL3
         RlxGfqi84+7KKo4cvLOEJSZUP6PsF0LaAb1prGcNrDqelBuWijRz5s9DZ0DQw2inNHlE
         27jUkDTx1F5bk6BFijw8gujFUlRLlF/8ci9/QCISfcpUm1GeHffnqLjiMz8nQtJ7sN0X
         H5rg==
X-Forwarded-Encrypted: i=1; AHgh+Roipakx4KHq5J/Jfk0BOw/Yk+UeXAfkWRwSrvbPOB7e/M5kxwNJvQqXdvIgVwGe/bCrxpi5gQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2mc2rxdelpRWcgx/aUhMP70u8rOr9aQhY3WfpXHoVUAyoG8Wv
	Mp2lsSrUipyP7dQ3Iq7FtcRuLFQiK1z3g2LNEKjT3IKmStQqNKii0pw0
X-Gm-Gg: AfdE7cl+yWYnW1fn6MAKN3XDNXqMRnS1ahQbfRpc0Bi5OUGOWDbEHtjPL5mguonLIo1
	5zqzosHsBhsMkU/uS25l6GHHurwm64GGd5hwDJBcsbyEvN8cJR/olvVA+68BeemY3fZyhkcVjtg
	xX7OruX12U4oF+lBiBJ+VWO6jO8+JyH2iB/vClFv3llj5xmCy94ia3K5y9PRV0ZXjqKeelxNB4a
	2VUdPuax+s07NORySYBt/5sWqq4pjfS3k6w52clOz1h0F/g+SeognwmPXKMdnagTA0fnsg8ziXg
	FAnYVHhA/3PWNGZXsugyJ7fS48X9e/dV6wuLAOsaxC8i6CZkGi+KVQecUPqj2RaQVAf1f69TTsQ
	m4poTJc9U6zfHkPpMDG6HnG2SjoHXeOyQWei88nwBRvYiOmlwDSlPFlDCkvZwX5Y+2JjyP/hQGZ
	5LW4Wnd9f5mzygxejMaxwcUrpyxgTFhWlF3WYsww==
X-Received: by 2002:a05:6a00:886:b0:848:2f84:f42c with SMTP id d2e1a72fcca58-84c294d4f7dmr4012571b3a.69.1784313052574;
        Fri, 17 Jul 2026 11:30:52 -0700 (PDT)
Received: from kimi-bug-hunter.. ([8.219.140.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2afd07e2sm1565255b3a.61.2026.07.17.11.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 11:30:52 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	Tung Nguyen <tung.quang.nguyen@est.tech>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net
Cc: Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net v5 0/2] tipc: fix NULL deref in tipc_named_node_up() on empty publication list
Date: Sat, 18 Jul 2026 02:30:44 +0800
Message-ID: <20260717183047.2725959-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series continues the fix for the NULL dereference in
tipc_named_node_up() on an empty publication list, on top of Tung
Nguyen's RFC that defers bulk distribution to a workqueue. Jon asked
us to test that approach. It fixes the reported bug in our two-node
QEMU setup (veth pair, UDP bearers, node-id addressing), both with an
unprivileged user namespace and as root.

These two patches fix two issues found during that testing.

Patch 1/2: tipc_net_finalize() does not check the return value of
tipc_nametbl_publish(). If the publish fails, for example on a
GFP_ATOMIC allocation failure, the node is finalized but cluster_scope
stays empty. The deferred worker then calls named_distribute() with an
empty list and hits the same NULL dereference, this time on the
workqueue. With this patch the worker re-checks the list and skips
cleanly, no crash and no link flap. The tail stamp in
named_distribute() also gets an empty-queue guard.

Patch 2/2: a repeated NODE_UP while the bulk work is pending takes a
node reference that is never dropped, because schedule_work() returns
false when the work is already queued. Found by flapping the bearer
during the defer window. One reference is leaked per repeated
NODE_UP.

Changes in v5:
 - Replace the item-less bulk approach with Tung's defer-to-workqueue
   approach, which Jon asked us to test and which fixes the reported
   bug in our testing.
 - Patch 1/2: handle tipc_nametbl_publish() failure in finalize, and
   guard the tail stamp in named_distribute() against an empty list.
 - Patch 2/2: fix the node reference leak when the defer work is
   already pending.

Note: this series applies on top of Tung Nguyen's RFC "tipc: fix
NULL deref in tipc_named_node_up() on empty publication list".
Tested against eb3f4b7426cf plus the RFC.

Weiming Shi (2):
  tipc: fix NULL deref in tipc_named_node_up() on empty publication list
  tipc: fix node reference leak when defer work is already pending

 net/tipc/name_distr.c | 11 +++++++++++
 net/tipc/net.c        |  3 ++-
 net/tipc/node.c       |  3 ++-
 3 files changed, 15 insertions(+), 2 deletions(-)

-- 
2.43.0

