Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E2C3D811C
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 21:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788902064; cv=none; b=g+hhl3NrZFErk4Y21FI1DeqiacJC3zJ3Pw1URUJJfdB5U5tT0q3Tnl7FjNAGQ15KaM/uo69NlPBp1GDlpWFLJd3cfiGO6RMcRzp3Qbwmhvtc9Ko6ed7aXcrRP8KBDRbwEdHjGrZY3rHuFlxvVqeUNsYdzhb3HrSeeXdgtGZEmIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788902064; c=relaxed/simple;
	bh=6m1Qz8mz3PEIpBKFi+U0jsY49qH+UBTXZ7dw9HTEazc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZWYv0rrl66RP+ssC4cs+pyYn8R8Xx5MgfbYAYDQLkYN+uOQyIkngqG0CNUHESFItCTZKzlMZVV/c6H/qDTv7Fk5EPzKWuA0e71K2ODa5Wbjo2jJePcVn9tHB8cQ5SKn1122FUCl5YA5hJ4N3p3kJiWjQo8IUR5PNVzeeLcxcEEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AdbdxRJj; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AdbdxRJj"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-855f662439aso2723407b3a.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 14:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788902063; x=1789506863; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qe0umcbZ90lJhtv8SesCDOA8pqvLc4Z/5z8FYvDK/vo=;
        b=AdbdxRJjujPBIcog22yvDPfLU/HHWaLBGDJ294g+0p5TEajsCpNFnSTRhfrBEXBlgG
         kBx7ihfvLd4W2P2bmevesanvLkIaJe2EY1D0Pf4ob54ndo1ycNaEp1Vfs7IRRgiXcgBz
         ScVjgLXF5Z8U0t7CRKkgkNxPgQMGDwu8hqZ/gcQVg4jV4dEDnQfvzQcBuFJQOhwYZhQJ
         XBk+hGUKa0hDNI7rtjkbd8eRCK+JALGeCD/rvdG9biK8RWwVxhAO4skZ8WCd56fn/DC3
         pY/Y7g/FS4aKQl2YqfkFyhggg7YgrZ3DTywa9V11DtA0x7gGqV/DEaBRo4OmFvk/QJ4C
         LBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788902063; x=1789506863;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qe0umcbZ90lJhtv8SesCDOA8pqvLc4Z/5z8FYvDK/vo=;
        b=NIlx0FbEgyeG6pehCUZPNjrMrHIypOH6Xqrq27uPMzcuXyw2yTNPZs2OWyXd1N9vcI
         m1gHXXuuKkAu8iFuyafpeH2VuVUqHgs5kpOUp6GmN1pTfvH6ixndevJs4alIXPPsRq7S
         EWbFZuy8BfOrglRmwzD35hvU9ZY8VxwaFXixxIhmVM3B6HO32iTW+gphD3a0SOJIF4+l
         GtzL1nOf8bxePEBsUZM1iK9DZ1lk6wU4sLD+PVutktDIuGRwHqPXdSaBE2zN19P8JF0F
         k50TTG2JarFDaF2X27TFbxLS10jRE+0Ui6Xr/NWXeKnOoJ1ApTHekfUbCDmaOw1kwAKQ
         LCtA==
X-Forwarded-Encrypted: i=1; AKwUvBzdjzvpGNY8pYCj2VygOP0/umMRLBRn5Kmze9ArfsESl3kc2D/vJowUsjPWaDT3BpVlrfZqC1Y=@vger.kernel.org
X-Gm-Message-State: AFuF++m9OQGJE1Lu1+2gU29VTMrbDehrV1rs/0zBGIuz2B99C500009b
	uf/hmkyr9d/HxNcZoNtuUhE/2/yQKRKS6kz0QmkvmP7xOh4xk2D3HW/NsxP9YDEuXoHJDobJ1sL
	c/s0gBw==
X-Received: from pfbic3.prod.google.com ([2002:a05:6a00:8a03:b0:84e:2062:2edb])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4408:b0:848:6f5c:a327
 with SMTP id d2e1a72fcca58-8616ba62d7dmr47806080b3a.15.1788902062381; Tue, 08
 Sep 2026 14:14:22 -0700 (PDT)
Date: Tue,  8 Sep 2026 21:12:45 +0000
In-Reply-To: <20260908211419.882954-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260908211419.882954-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260908211419.882954-2-kuniyu@google.com>
Subject: [PATCH v2 net 1/4] neighbour: Add missing RCU annotation for neightbl_dump_info().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

neightbl_dump_info() fetches the first non-default neigh_parms
with list_next_entry(&tbl->parms, ...) and iterates through the
list with list_for_each_entry_from_rcu().

However, list_next_entry() does not use RCU helper.

Let's use list_for_each_entry_rcu() and skip the default parms.

Fixes: 4ae34be50064 ("neighbour: Convert RTM_GETNEIGHTBL to RCU.")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Use list_for_each_entry_rcu() and skip the default parms
---
 net/core/neighbour.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 1349c0eedb64..49dd7df149ef 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2611,11 +2611,14 @@ static int neightbl_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 			break;
 
 		nidx = 0;
-		p = list_next_entry(&tbl->parms, list);
-		list_for_each_entry_from_rcu(p, &tbl->parms_list, list) {
+
+		list_for_each_entry_rcu(p, &tbl->parms_list, list) {
 			if (!net_eq(neigh_parms_net(p), net))
 				continue;
 
+			if (!p->dev)
+				continue;
+
 			if (nidx < neigh_skip)
 				goto next;
 
-- 
2.55.0.979.g7e5102b832-goog

