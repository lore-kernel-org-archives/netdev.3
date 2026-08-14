Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E66F36308D
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 23:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786751354; cv=none; b=llc31fxS27GvJNfT29f3KCtFUf3AlwU7rmEVf/yDXUhBjK9jZOEiv32lveV74ZVwsi+E8C8PSpn3gZJ+9/sHNwNLUr28sNNpAyC3y8FgTfX5BuOMwFJAWpuw45Qbx6BiPWggVzgXKY8iJZO8Lsm+nvef6H3pwPxjYLdRA/lifrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786751354; c=relaxed/simple;
	bh=x8eg9Jt6w3cS6X7e91rfazYnIdbQdxW90QnuVAm/iJY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dt2niTJmLLYG3feJnFC0h+ddQLBCCHtcxOBdeURyRUlYsqSWRvyvtKy6jAgudl0784FcQVVvD7Dlske8/KGtZmQ15rst3u+SeVQvEml+Q4eNRUjQVYkvbuIimU/xsYibn+7AAWJ6/tnK1PI+o430OxNpnokI9GRgaqXI2gajHYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EzGLCdLA; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EzGLCdLA"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-848568a6f62so1632377b3a.0
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 16:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786751352; x=1787356152; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s1YbbHnn1o8ujr85Ja1lB8ygXtUPaAp528+7LLKHOkI=;
        b=EzGLCdLAMV6cboWVOOULUgjfPL/wuUwLk6sNd8y2I+U/slTKDjNDgaEUpe4bMAasWE
         wGIAuefZhE/jX2JHhdfGTS3oEJ0dqzdBTWvW8paT+3bF6TOF1MQlL3pkX49zuhiGbUUK
         R0hz3dNLZgq0eSIqTVn9C+LPLizDRuXH4PmkTRAy1lszBjDOMu4JYbCcRIIUvASxdm5T
         jVvwrjpopExyITWd2RKOzVzg52u4lQ8LiJquJtJDQaFGr27hu+UL7PhN7gsjsZpMB4RP
         XSxju9gAzQ3VBrZLoLnNSIq88fhfAfntBm3NUg0tyeRrXVrOWxSJpPyUAkd8//v3z8uE
         5csQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786751352; x=1787356152;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s1YbbHnn1o8ujr85Ja1lB8ygXtUPaAp528+7LLKHOkI=;
        b=dCwJwRL+ZKBj1rzbQi/Dgqx1P30jRA63wmGLZnI7IGrc/i6PYU6FduNpV3dfJusarG
         KIeG0DKl076I+KZLxDQInjCtJp4EdP6KMYTfETbnipXH88QqWJTParyyX64Io34IAmES
         LDliNy10rBoFhUyDKmEU3T145bE7VvKflQ8XJEso3fucAwdumo6AUeparnC982EN7XYl
         AkMBf4TLJKORg1QtTGZbDO0zZLmCzI9bCPeklBWmehmcC929AY85rWITIYoyfIcJrifl
         lv+2hTMz7cmA8CnuTzeAXPgp9tBE41puxJ8H9oq9drK880LC072yOHU+Ot4J9q7ep/+N
         cdgw==
X-Gm-Message-State: AOJu0Yz1ZnOhyVouSZYHnLg+f5/sST4+AqEPcuSDx92m3PG8oMBfT1oH
	6YA/YwgtB8UvUoFFtJ687kcIjyT4tE84fC7nkqWpvImXycP48lU7h0fNSD3mHbAJX1vZHawlBOS
	v6g2WLYwC5fnCmdWuVYtDIkq7ezuY63qFZzp9HRD4RHU6v41+ldFTv9XzaxQLed8J29sOBryrEv
	pqPynwoKB4SQxquABKG2ZQCJvFs1K2MHHHrxcqk9QuxCygk4s=
X-Received: from pglf1.prod.google.com ([2002:a63:1001:0:b0:c9e:a22d:15e8])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1895:b0:845:4928:8655 with SMTP id d2e1a72fcca58-84fde33319bmr9287557b3a.39.1786751351767;
 Fri, 14 Aug 2026 16:49:11 -0700 (PDT)
Date: Fri, 14 Aug 2026 16:48:39 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814234845.773189-1-joshwash@google.com>
Subject: [PATCH net 0/6] gve: various XDP fixes
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jordan Rhee <jordanrhee@google.com>, Willem de Bruijn <willemb@google.com>, 
	Ankit Garg <nktgrg@google.com>, Tim Hostetler <thostet@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch series includes a number of XDP-related fixes, both in the
control plane and the dataplane.

A summary of the changes:
1) fix an issue where XDP packets weren't being counted against NAPI
   budget
2) fix an issue where XSK buffers that have not been processed are
   leaked when disabling XSK pools
3) fix an XSK buffer leak when an RX error descriptor comes back from
   the hardware
4) fix a NULL dereference due to incorrect registration of XSK pools on
   queues not set up in XSK zero copy mode
5) fix a deadlock introduced by attempting to acquire the netdev lock
   after it has already been acquired
6) fix a racy NULL dereference due to DMA umapping the XSK pool before
   queues are fully stopped

Joshua Washington (6):
  gve: increment work_done for XDP and error packets
  gve: fix XSK buffer leak when rings are stopped
  gve: fix XSK buffer leak on error descriptor
  gve: don't register xsk pool on pre-existing queues in RDA mode
  gve: fix napi_disable deadlock when attempting to disable XSK pools
  gve: fix NULL dereference from premature XSK pool DMA unmap

 drivers/net/ethernet/google/gve/gve_main.c   | 51 ++++++++++----------
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 20 ++++++--
 2 files changed, 42 insertions(+), 29 deletions(-)

-- 
2.55.0.691.gc56d675ccc-goog

