Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9797C4BF957
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 19:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791834335; cv=none; b=KLVcmOYvG/M0e5AMkv4ew58fagw+hifoypbZYQH4At8WlK8mpViFHzDjaI6dZz8GJAftWK8pKkI9rAjBbahcmURTRAiNsgHxGL8gmd8ItGdmXvCqxOApNk3eAAlCxNyLB13fT0MEDfD022FhtskTdH1sBTWuxmd6CKHLyXiK/os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791834335; c=relaxed/simple;
	bh=hEkbRnhnj0O1IetiVsWx2lR3sh8uGbO245n2d8Cng0Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bCXBAeJq0hAnfALoUUR56lQGaoLqyrRVTaCid3c1zmYPLca1Sga0wCLsKKcm9aph2xo9qWH8SCXmGxxs4FyQry6luJzW8PlCpVi6opeW2D7dCN2xLaA7arUul06Ypt/0W5Cd+WugX99eziqclYK8oGCAuKEQFOmNPUrfQTMG69k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vtf81Hq/; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vtf81Hq/"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3a7fa5e0442so3206090a91.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 12:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791834334; x=1792439134; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bw4NbX4ZjlalLn/wLQV3GOOzOHCRxS308mecsbW9qTA=;
        b=Vtf81Hq/1Fvpt4w9CkxRjPmhpaF9U3xl0+4ZF/MyZZRYgA0m9zTDvp1bOtEu228rfq
         hETaNcDUkXu/U7cawCzbipwGa+1ZC6n6DC1AiQguBXS/Ki/zLboZA33cdvO14ufstZjf
         8xOsdg4VzSjSDlwgaVaM3UqLxiHZJyEsF/xhS4g3oalVyRjjcwdEH0z3WGLJp90b+TxV
         rl+JhztWf1gFuEtJ+x9PevsiM3c0BxlV73OhNE/gYkVyO0Bz/Qsh4+giAIjSngEK+MxG
         2UNsX19fIRidbQUNIsCJ07xINjH+/RHD/JDx1HolmYzg9j0Jshq9s2LFSueaNS2eFE02
         oe5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791834334; x=1792439134;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bw4NbX4ZjlalLn/wLQV3GOOzOHCRxS308mecsbW9qTA=;
        b=tY70Vs36MFVMaGlVi1SO9/Jm1runerYSeebd9ZlWJ3+RhTHSxFv+FhizB9bRiJPxOP
         MMi8Cc/qtDrObF35LRn6dvugtgFmwCNSLpE+R0W5P48G3dmqFpmwTqmgcMuJ1+B6hYlC
         3ik/CT7boylZ54z7G4POREiMh7AmrXLc7i63wA5MJFPAyEsQC3RlfEEO71gfi4gKkmQs
         fFRlPRetn6oAYY0AS103XkUyK5BugwdLoqdiU9YeGnGRIRWHLS98BfqXgOhvI8jLqpFv
         IZReQMSP3BeKSDigUXdpWZPGqqCO0SrZmgoBI2YPXZhGn0YZ53hxMQJbQe26eeidy96s
         sR2Q==
X-Forwarded-Encrypted: i=1; AKwUvBy8GufztqQpjSZaXLo5hMLlmU9bnh3XNr4W9uIFV2KSqIigs8mvc+ogNcmyvxlV2/9iPw7h1cs=@vger.kernel.org
X-Gm-Message-State: AFq9FYK0OdUyOYw0nPtUjkN8iCS24ts8cTEIEeVS4FXbnU1bRFjNTDRc
	jrj58xtfjQLIc3k2UcGPj2MFfKUJu+Hgoh4eIcS6oNwfLF+dlKftMCg2kSDLbZFdsy5S9luxXf4
	dxdKgOA==
X-Received: from pglr27.prod.google.com ([2002:a63:515b:0:b0:cc7:e6e5:e624])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:4c82:b0:3ab:a3ee:33ad
 with SMTP id 98e67ed59e1d1-3aba3ee3e2fmr3555714a91.22.1791834333726; Mon, 12
 Oct 2026 12:45:33 -0700 (PDT)
Date: Mon, 12 Oct 2026 19:44:56 +0000
In-Reply-To: <20261012194530.3751034-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261012194530.3751034-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261012194530.3751034-2-kuniyu@google.com>
Subject: [PATCH v1 net-next 1/4] Documentation: networking: switchdev: Replace
 arp_tbl with arp_table(net).
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Since commit cda2962b6e2b ("neighbour: Namespacify neigh_tables."),
arp_tbl is a template for the per-netns table.

Let's apply s/arp_tbl/arp_table(net)/ to switchdev.rst.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 Documentation/networking/switchdev.rst | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/switchdev.rst b/Documentation/networking/switchdev.rst
index 2966b7122f05..8e8ab6632ffe 100644
--- a/Documentation/networking/switchdev.rst
+++ b/Documentation/networking/switchdev.rst
@@ -401,14 +401,15 @@ The FIB entry's nexthop list contains the nexthop tuple (gateway, dev), but for
 the switch device to forward the packet with the correct dst mac address, the
 nexthop gateways must be resolved to the neighbor's mac address.  Neighbor mac
 address discovery comes via the ARP (or ND) process and is available via the
-arp_tbl neighbor table.  To resolve the routes nexthop gateways, the driver
-should trigger the kernel's neighbor resolution process.  See the rocker
+arp_table(net) neighbor table.  To resolve the routes nexthop gateways, the
+driver should trigger the kernel's neighbor resolution process.  See the rocker
 driver's rocker_port_ipv4_resolve() for an example.
 
-The driver can monitor for updates to arp_tbl using the netevent notifier
+The driver can monitor for updates to arp_table(net) using the netevent notifier
 NETEVENT_NEIGH_UPDATE.  The device can be programmed with resolved nexthops
-for the routes as arp_tbl updates.  The driver implements ndo_neigh_destroy
-to know when arp_tbl neighbor entries are purged from the port.
+for the routes as arp_table(net) updates.  The driver implements
+ndo_neigh_destroy to know when arp_table(net) neighbor entries are purged from
+the port.
 
 Device driver expected behavior
 -------------------------------
-- 
2.56.0.385.gd3acb90ef8-goog

