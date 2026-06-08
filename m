Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE64B37B417
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 12:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780921337; cv=none; b=NJkRuHv4pVfXu6vu5lByisnZ5ZAHUsppIRYaW9f3c9oKp0qfQt7K/hPkdnZywSoGRLWnGRvNh5TqwuNvR7YPSVYdk+5CRdr4YZ3PP5I5QcKp1fjquLJSKXstY/4jsvmu+QW/LHiRiNiC7OusLj5op764uGTT/iJd5fQlGCIVyJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780921337; c=relaxed/simple;
	bh=cXhlPwKrLeHAVxJiuHh44tc8y7FFmo6iTPxjGHDtsLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q5IIDn6oZTeFwL7F65uRDaGxAzgaCg8ZA68SOQFEKidTU7eJ8HQ5Kgyhn4BxBnCEYC/NfPp8shF4CnIcl8Bk4fwhX0NAoIkURDeco25a7Kk6nBZQwcIW/G8853Ui401IXJTAWW3dlJzWeMtwz3lqyTKA9Vtusm7qFLplbP/pv5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlMGgb2t; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlMGgb2t"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8ce9df4732cso45112826d6.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 05:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780921335; x=1781526135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrRhNerf5D40vnQiScNa9aZv5+AqBmJvjpLa5KmsVBc=;
        b=RlMGgb2ty8etJjyV4i6z8SLJ6Jbg2hcxjVKdmZ9mw97UFy2CmE1WgtP0Uw44RkG/O7
         jRd+4WpGzn5a3c5PH3YQmdGWlmnJqjl11rM9BLIpKmyFstPLS1RtN5v2+p9OCLqmeFIl
         g45l6Ycezslai7RB7vPAwceHf2mb6VKzBLBLM7BNXndZce4y3GoqFAjiTwKaHiyB+flv
         wF0ACLng81bVQrYtPxXVsMZQ5glElj5WtaWcu3zqkv5BErLrCcpYdTnwylo1KyXrN9+o
         xPrp46yRfJj94kB+c319BjlOxTcl5civtFK0Wr64aBBPWF2GjsdPUkgLonHpIjdasDeb
         uq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780921335; x=1781526135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CrRhNerf5D40vnQiScNa9aZv5+AqBmJvjpLa5KmsVBc=;
        b=pCvEXrvT+/ztbSRjVike2/4F3SstsLOJ4HgulcOk4sAx1BRD+Dizfn2JGMJLbUmlTu
         yNPLFA6vZy0aBCELcCkhdb7aVh47II0Dm/+13wlW4j9ahGgq9SBk6oKJ0rjh/NEWZ0xx
         JckL806inY0qHtzrgMMfRv2fWn7rL0w6tRldGC2RC/c52fjyuXdkXVYEnRTdx2rXzdBk
         GnLhxhUgYYVHjCpOPhG/S+V8Eq/Mexa869l78HEb7s+YAxyeu9XpwPMH49woI/KVpwRS
         osCSNmBggh1PFUjKsQak6Xrnvz+f9YytXbbPPaMqUfcIcndV0Ds6X9j3kdZE1GQdnQbD
         dVdg==
X-Forwarded-Encrypted: i=1; AFNElJ8tv4Dqpxl+ufdMgSgpBAf7fDg7ibyv+lUL+Po/Z6Fqr66DXiEs8kX8Wxr7bcWuGjxVSnvaGkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYccI4TpvHo2XVOuYTAG020AXJcuiHe5a8EiJF3BAFLWFIiipi
	D0ZBeHqAplRyem5VEzzy5YDMM60+8jC93JZpERzT1c3M3aKoo8yWn4of
X-Gm-Gg: Acq92OGiDWMNqXUyPmDBxGaZntO+SytzQAiLcMoiaSDUzUmjHYHoH4LsIhEUalM293L
	QrN0eBw+zgA3IBvE72wACMwXbSJ4qGWJxvwI+g6f3tMe8dnvF1lH3pqRVW5WArYlm59dQw44YgV
	NvXuWxUgP1De95M4rq6xq6SIJxImVAT8G2E97KagIbSvQcVILwWi5zUEf+q5DFsE363lppNQIYp
	bpun7gl5WnMMwqLZNa9jEuLW5j0044dBi/WsrO6qmTsF2XbBco3A2vLyH3mYp12p29/u1HnWGcN
	QYWIBbJiKMGsR8/94ZFwOZClvUG/XY/XVI8OOqe3Kc+vY+QPjh5InB1Ai79GlIMbspGsrl3akvB
	3lRednMZT1f8meaDJ9GJR0i4dwU8A2I+Tr5wls+44bJXZWhMjOQQkKVsjgDio3s5HuSYWb/8fdz
	yISMa2QCHyrs6Nz/GozguYMEkaDJOThj7fyw+ONgcWSood4pG3H0myfZaymP8AJs3rwLoWCCVRk
	OkiDJSXHSgCx/br9ZcBPpjhZOBoyh0=
X-Received: by 2002:a05:622a:2489:b0:516:cc8e:9fff with SMTP id d75a77b69052e-51795b83e9cmr202509471cf.52.1780921334588;
        Mon, 08 Jun 2026 05:22:14 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517af149fa5sm46086911cf.3.2026.06.08.05.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:22:13 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Ying Xue <ying.xue@windriver.com>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 3/3] tipc: reject inverted service ranges from peer bindings
Date: Mon,  8 Jun 2026 08:22:06 -0400
Message-ID: <20260608122206.458290-4-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608122206.458290-1-michael.bommarito@gmail.com>
References: <20260608122206.458290-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

tipc_update_nametbl() inserts a binding advertised by a peer node using
the lower and upper service-range bounds taken directly from the wire,
without checking that lower <= upper. The local bind path validates the
ordering (tipc_uaddr_valid()), but the name-distribution path does not.

A binding with lower > upper is inserted at the far end of the
service-range rbtree (keyed on lower) where no lookup or withdrawal can
ever match it (service_range_foreach_match() requires sr->lower <= end).
The publication, its service_range node and the augmented rbtree entry
are then leaked for the lifetime of the namespace, and there is no
per-peer cap equivalent to TIPC_MAX_PUBL on locally created bindings.

Reject inverted ranges in the network path as well. A peer node can
otherwise leak unbounded binding-table memory by sending PUBLICATION
items with lower > upper.

Fixes: 37922ea4a310 ("tipc: permit overlapping service ranges in name table")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v3:
- Restructure the declaration block (move ua below key) at the
  maintainer's request (Tung Quang Nguyen).

v2:
- Reorder the new u32 declarations in reverse-Xmas-tree order.

 net/tipc/name_distr.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
index 190b49c5cbc3e..ba4f4906e13b7 100644
--- a/net/tipc/name_distr.c
+++ b/net/tipc/name_distr.c
@@ -280,12 +280,21 @@ static bool tipc_update_nametbl(struct net *net, struct distr_item *i,
 				u32 node, u32 dtype)
 {
 	struct publication *p = NULL;
+	u32 lower = ntohl(i->lower);
+	u32 upper = ntohl(i->upper);
 	struct tipc_socket_addr sk;
-	struct tipc_uaddr ua;
 	u32 key = ntohl(i->key);
+	struct tipc_uaddr ua;
+
+	/* A peer-advertised binding with lower > upper can never be matched
+	 * or withdrawn and would leak the publication; the local bind path
+	 * rejects such ranges, so reject ranges learned from the network too.
+	 */
+	if (lower > upper)
+		return false;
 
 	tipc_uaddr(&ua, TIPC_SERVICE_RANGE, TIPC_CLUSTER_SCOPE,
-		   ntohl(i->type), ntohl(i->lower), ntohl(i->upper));
+		   ntohl(i->type), lower, upper);
 	sk.ref = ntohl(i->port);
 	sk.node = node;
 
-- 
2.53.0

