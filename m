Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4847C4F55C5
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 13:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789565140; cv=none; b=jLWAcq+bwGl9YT+d+HzzlHpCvI8gEdbsv3rsoZZh9XN5zlEeUTZ4PTQhelpMfTqSuub6QzNMuTsAmzZpdnTeU8a1GisAI9xDCBzK+T0E9U+mckrfW2SGjn62roqQyAwb4Irn4Pg4TyaijqzCOopHJ3qY2pK/MbrduZPZGp6Ymp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789565140; c=relaxed/simple;
	bh=F+gU5XMmR2kptT6GmNWH+4hjVFSti9qy/FxRYezWCsU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GxC42GF+jZmBPto67XpIf41Q0oW83g32SP5KqpHEJVs9+9XuELoE1RLUFDHPtFwk9yKfWb4uzKhVH0SSl4txp0C6IGpEmkjPViMEuiFzpMVcONXEcaiyJFd4sQqeSFQ/m1S8ge5S0i2cN/x+agaKCjEIqHHlTBb6/FzjSaEY3H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uy9W1gy/; arc=none smtp.client-ip=209.85.160.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uy9W1gy/"
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5328412a7aaso10928851cf.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 06:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789565134; x=1790169934; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FkcvYsFEuu469Xag9lIuC5Uiz4Jn/EQtYsOpUmUNT5Q=;
        b=Uy9W1gy/u6QABbwacI0NtMepFOKUECmJUSopK6OjiJV+Cz4kLtBJrzYkXwALsSC4B4
         WE+dfunpNkqFSfwvouik/Ayc1gmaBDso2LPT1CJNf4WLRP9clm72S7XycgjmG7PwvTwD
         JqlvKFhzSyUN7JgrGysW7aJoCmJTNyrFDHeZ9Hf724bkWJUdKoo0E6KRZymlfxgHAjrG
         jBGWLks/up4mhMGgykEgdyv0SOgaGBRBsg98zbrPZ+ariiG4wNHHOJFvtjZMynNuYUqO
         JbbluvOwpEmv3n5xKKdpmCT8OlLAV0yfAgGEJ4QCMQvMU76SF1Vvo8WZ1eGWLn167iFK
         EDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789565134; x=1790169934;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FkcvYsFEuu469Xag9lIuC5Uiz4Jn/EQtYsOpUmUNT5Q=;
        b=HqLqHzL6KMsn53rL7PvGSONdKfbal7dr3S81Jo9qfoHFd0lU47MbfzEVeBpWwxNFb2
         h63Wm0gtDIJwlTiK5J5RnV8eauYoeTiD1S+ji0Hur54eqlGVXxVlvV6J/droTT9QoKWk
         wNA84F626g+mleZulaDU0+7f/wPxbF+KdahWS1hRbFMhulnUpQVUum31yyJ5VomL4UcD
         lJNZq/9nDJ9wGJQzG3pr6fS1Rb/YFmwKO3ROiZL+b6MsO1uZ0tHofJlVV8Xmh/aU1BwW
         5DD40qPZdjNL3aAKM6cB1z8oNOiI8kQbBSwqhGaFvmMzBZHJzjPCFgRI/qdg5UmtpgSd
         ucSQ==
X-Forwarded-Encrypted: i=1; AKwUvBxYcKnl0uDC43nK4cvzodx+J9DTMzaipj//eGKO4uPHfskw2Tk9raulsq5Hf8iUV1kcqb+QfeA=@vger.kernel.org
X-Gm-Message-State: AFuF++kpd7nt/sG3FDz392VMJbjHPqrCdAkG/uwH1qe/775bAMlXFBO2
	OR4A1oh5tnOXCJ/b8vFMR+YdK8PGj5hfcDa0LYUyh2edwli85E+Pck9oYbhEagxKm57KxgDk+HB
	iHtysNTXBJuxgVQ==
X-Received: from qtpe12.prod.google.com ([2002:ac8:670c:0:b0:530:fe1a:99a4])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:50e:b0:51c:d1c:10e3 with SMTP id d75a77b69052e-5327eea9d51mr45679021cf.35.1789565133897;
 Wed, 16 Sep 2026 06:25:33 -0700 (PDT)
Date: Wed, 16 Sep 2026 13:25:30 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260916132532.1785657-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] vlan: lockless vlan_fill_info()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

vlan_fill_info() currently relies on RTNL being held, because it
uses rcu_dereference_rtnl() to walk vlan->egress_priority_map[].

While auditing the fields exposed there, it appears that
vlan->flags, vlan->ingress_priority_map[] and vlan->nr_*_mappings
are written under RTNL but already read from lockless contexts
(RX, TX, /proc/net/vlan/<dev> and vlan_get_size()).

- Patch 1 adds the missing READ_ONCE()/WRITE_ONCE() annotations.

- Patch 2 converts vlan_fill_info() to RCU.

vlan->egress_priority_map[] needed no work: it is already updated
with rcu_assign_pointer() and freed with kfree_rcu().

This is part of a larger effort to remove the RTNL dependency from
rtnl_link_ops->fill_info().

Eric Dumazet (2):
  vlan: annotate data-races in vlan_dev_priv fields
  vlan: no longer rely on RTNL in vlan_fill_info()

 net/8021q/vlan.h         |  2 +-
 net/8021q/vlan_core.c    |  2 +-
 net/8021q/vlan_dev.c     | 37 ++++++++++++++++------------
 net/8021q/vlan_netlink.c | 52 ++++++++++++++++++++++++----------------
 net/8021q/vlanproc.c     | 18 +++++++-------
 5 files changed, 65 insertions(+), 46 deletions(-)

-- 
2.55.0.1032.g73a4cd73de-goog

