Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31184385D6B
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 18:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314633; cv=none; b=H8lW4iH9ZYMoQWC5pWHev+ThzsrM7C5/w4jGvi36S5eEi86mn6DLAWio/3dCEU+wFlY9kNcd5cJnhKLfjrarLe6qSfcU+BzvMteYv2BgWiNj3YyiXv/mNnVCNsGibX8LfYzbzmhS8hqUSBAf1JembSRQ6YTUazXnFGHmpAh8pAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314633; c=relaxed/simple;
	bh=cdsT1g/UScbLqDE0HMS7kmZr+Jnr+Sf+pdOK9p8hv3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fIjiTO1z6gQn3Za4EPE9sgT0vvfg0Kxw/I6l5/GPfA++W/ZtM/qlL6Nv/cIQMYgDj/RP9jwMQGk9zqwNCYplkctfDa8gCBibpHVJ4jJ1WxJuKX3DcEEw/RIq3N69MHGKUftPttUVmn7LGiYn/6J1OxXPc+0N9ytkBej5rewfba0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OoN4eC1o; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoN4eC1o"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cb5b8572b70so397748a12.2
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 11:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784314631; x=1784919431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eFrvVJj0ttdNJ8Fyf0cvI0idyV3cW7gdJ7kA0UKFrTY=;
        b=OoN4eC1oEuA7++l+MXxbIfHrSF4dX35Z0TyzsNEEQNWKhOO3Q5Zkdm47aIPP0nBHn9
         Gz8O5RUkc1aBcSQVWviDxjv6dhm+2AUbqTF40A1XOY6RM/CYu8va2nZRJef/hloGItsu
         5Oh0/BCZgyRGjZgl4OLeH6EPhR45YR+3PUvTrMFi6agSrr+PYYkXyrFBo5RgaVg96k5c
         sJqQsMZk6rkF0WztvQ/F7qMYOMjS/d4aUTF9VbgCy6urVZgoInF4ZMZH6OTMxr5bwKPA
         dyZKDnHp/hYIKNvsVLR42mfHfDBnjuQ2HHO4ASxzuEhN3OR8I7apCc4nyZY+it2HZqSk
         pkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784314631; x=1784919431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eFrvVJj0ttdNJ8Fyf0cvI0idyV3cW7gdJ7kA0UKFrTY=;
        b=QXHHeRDlKRfxlbt+r7vMrowrk9gzfN7z3Jt6kbamg0UxNTftMsFkM/L3f9e+LbZ8Dy
         3Pq7IosXDIPtqAL7bwEiO/7X8WRj8TL0dM3SO3xz2BkcF/JuXmgTkXlSb8LdI6Unq5hX
         IrdVdk8Welglw+wlcpqW/tRpDGwsL1Tk+rn4KOjPkqYCirIjg1Kj0g7dQnRSGewXFm27
         L7zi+H9Mt9cf0HHqEB+3mVept7PX0U4Tf7L7hE8JFqibUkT3t3NSm2vE8V1HzjYY7941
         6y7JxICz3TH7naNm/jcgTgopuQnf5FhfZ6ICQQyupIUJmcvWTYIWm4Bh/+Jk8MrzKEQQ
         ey8w==
X-Forwarded-Encrypted: i=1; AHgh+RotPes7sg0GsIt8EIgsfI+ozCmClcIQdmIctX5pfE9LNsmyH/eiRVXCnlTp8GDI95Q6Or4Uhcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIAh9gYlQA+t0mATEEqrrLP9FunPzGbLeiUCIZf5m4Uc/0KtRC
	GsZ7tHlRtjFtzl6h/SCpB9QRNY6PDRcwLJTZCwlAMCtx+UNrA1uglqFY
X-Gm-Gg: AfdE7ckZu0Q+y1lMhoy5MXa9xofI9yxi8XRTnP0PtMgubkFp/MP7Eprtg3RdBafMhXv
	lvohafnsafXB14Ncp79577labI+KIoqTrnVM/fMIoBG21RGaBl8JdI6CzHnk//FffF63PlcdOjC
	y0ssCDJpjAJwcUrWOdSLVlymKdhBhVFYR0Bnx6NLftEVJZbXx7ZlstAXju1t+T7XwXvvK/3LdnR
	Y8Itp7dLCBewAnAS1r6Wsp8ObA6U06yybmgXT8kRiLZXt3GtbpS/NXlSjSZ8MIq1myFNUa1XJlv
	CKnc+a0wtBV7KGdidQvFC5HPGvWgNnOUSoQTuIJv1k7bSz/aMjeEdpifK2cVo864gWGIqVNJgSf
	F/Qo+/WN130FrKYTD/v1bLgeG//AYEuYOocugFehhulxyQoEvvkWXzfkiFIyVciptfyO16Ayx2z
	uT8gLJeE2lwC5xaFSu2rdaCds27HYZuGSbok+Yjws=
X-Received: by 2002:a05:6a21:a8d:b0:3c3:7179:a640 with SMTP id adf61e73a8af0-3c3ad5d5738mr4427746637.3.1784314631457;
        Fri, 17 Jul 2026 11:57:11 -0700 (PDT)
Received: from kimi-bug-hunter.. ([47.236.164.125])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2cbb7c5sm7376688c88.10.2026.07.17.11.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 11:57:10 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	Tung Nguyen <tung.quang.nguyen@est.tech>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net
Cc: Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net v6 0/3] tipc: fix NULL deref in tipc_named_node_up() on empty publication list
Date: Sat, 18 Jul 2026 02:56:57 +0800
Message-ID: <20260717185701.2828080-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series continues the fix for the NULL dereference in
tipc_named_node_up() on an empty publication list.

Patch 1/3 carries Tung Nguyen's defer-to-workqueue approach, suggested
by Jon Maloy on the thread as the replacement for the item-less bulk
from v2. Tung's RFC only exists as an inline diff in the thread, so I
folded it into this series with his Signed-off-by kept. I tested it in
our two-node QEMU setup (veth pair, UDP bearers, node-id addressing),
both with an unprivileged user namespace and as root: the unpatched
kernel panics on the first run of the same reproducer, the patched one
distributes normally with a non-empty list.

While testing we found two residual issues in the approach, fixed by
patches 2/3 and 3/3.

Patch 2/3: tipc_net_finalize() does not check the return value of
tipc_nametbl_publish(). If the publish fails, for example on a
GFP_ATOMIC allocation failure, the node is finalized but cluster_scope
stays empty. The deferred worker then calls named_distribute() with
an empty list and hits the same NULL dereference, this time on the
workqueue. With this patch the worker re-checks the list and skips
cleanly, no crash and no link flap. The tail stamp in
named_distribute() also gets an empty-queue guard.

Patch 3/3: a repeated NODE_UP while the bulk work is pending takes a
node reference that is never dropped, because schedule_work() returns
false when the work is already queued. Found by flapping the bearer
during the defer window. One reference is leaked per repeated
NODE_UP.

Changes in v6:
 - Make the series self-contained: fold Tung Nguyen's base patch into
   the series (1/3), keeping his Signed-off-by. The version sent as
   v5 only carried the two follow-ups and depended on his patch from
   the thread; the code changes in 2/3 and 3/3 are unchanged from
   that version.

Changes in v5:
 - Replace the item-less bulk approach with Tung Nguyen's
   defer-to-workqueue RFC, which fixes the reported bug in our
   testing.
 - Fix two residual issues found during testing (patches 2/3, 3/3).

Weiming Shi (3):
  tipc: fix NULL deref in tipc_named_node_up() on empty publication list
  tipc: fix NULL deref in deferred bulk distribution on publish failure
  tipc: fix node reference leak when defer work is already pending

 net/tipc/core.c       |  1 +
 net/tipc/core.h       |  2 ++
 net/tipc/name_distr.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++----
 net/tipc/name_distr.h |  3 ++-
 net/tipc/net.c        |  5 ++++-
 net/tipc/node.c       | 35 ++++++++++++++++++++++++++++--
 6 files changed, 97 insertions(+), 8 deletions(-)

-- 
2.43.0

