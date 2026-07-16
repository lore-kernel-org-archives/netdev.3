Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E232034250E
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 19:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784228686; cv=none; b=sjt6FdqMd877zzhOklEPFgff9YuP0ZQB5P5luP7qriNO15c29GAhtrCwm+QI7QfBxueyV7hX/vmjI0znIXA+TFDZ3w1ZfYum4vQE1c/3t2OAKl+EGnKh0fcNrXzeLxG22QY+pNPcwJrAUqgAI8J4VRHhfGe1N5onEh3hJLc+U3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784228686; c=relaxed/simple;
	bh=98rBX1rZxXsA2fdmEyaTrCs5K7RWoyiP0eSgFB1yCEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vrj6UPy1yyI1r1P0d/ChvkH6yPLVMEeVnsmWZL7wrLNHPb9aTZJssHEinZLuCISwKq/UFcMufWonnNAyoQ+4rPzoryqStvIRwGgA7t3cK6vFJa9l143uhxpfvuMcKAI3x8ejMmYyWU99T9/gVCwBsP07RQMBACKPd0VnZB3QE2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAFw5jeB; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAFw5jeB"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so5130844a91.0
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 12:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784228684; x=1784833484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XEjDdaAZMpUfOqCEHt3DSSCB9102Ct5QGcJX87+iqFA=;
        b=MAFw5jeB0OQf3ncGrMtXbkiF3k8lbaRyPtvOENVPP7itgHD5bNcqaYvqYmFTAea9xb
         i9w9Eqqe1Pz5+SETG3FZjPH9Et+jf9/jh0FUGQC977JAfXC3pOz0X44ehtq5xMLkhcY0
         uj23FmKsEEqGhGCHeX5maDwmK7toZOqOXTy9fmkMx8cANpqVcQ0jLCOhn2m9O41uYp4R
         ArjYLuWV/BL19LYoeKA8Dx2l9S1QOE6VsyRaW3gl9zLF6x583nYulHrOTEhv6JnsVECy
         M3mCd04KCFEIRByw1ZySTAIRRgFpiiHqukdlYjrOh4Qu3zN6NJvKicKuxvz8wpcUlXba
         YmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784228684; x=1784833484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XEjDdaAZMpUfOqCEHt3DSSCB9102Ct5QGcJX87+iqFA=;
        b=qF7I0HiUNJiKkerUeAF5lmSQgEljOw5VCQ8WKYW0qIBzszvVyJ0G025IfZhvfj6b0d
         E9bjbYakqXDsNbxP42ZMYPzoAbyVBNndFbglNm/nEspnz1nHx5+1OH2UM8N7jXpO9zJd
         fvKLcu2c7hXn3r4hSMVpLXA9Tdvf8CnO5bROLiHjx4aqBM0F3J7RDh8lwcphfdIvUyRr
         DSxqDbEiDjnWg8aJUI/A0ApHM7O6MDA/x/GqVDIBAKVsEgoPefJhHOLWUj0mShYhFLsW
         iyFl+hOF5jV10R2+NTP9UEwvyAdXS1exePft2MwaMCKFVWtT9IlUv56yAucyeqs6Dg2V
         S/XQ==
X-Forwarded-Encrypted: i=1; AHgh+Rru62RDU0hH2PmHZVJEh0wWwyWA/fROMFchNVjFbhorlnLPmNkdP3ipbDkurKD+/wlR6SfQ68A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ54YoTXPBC/v9jwUPZJCrc2gZoNlLJNAHRUSCJSgzb1kdRXu3
	6vbk6yBYby1eR7CS6kYo2pgdj+PpzWhppZVYArlg7xoHNCQksVrLfzeZoQDacqoIDkE=
X-Gm-Gg: AfdE7ckNFDSIzXGsL8mVVSvvSaNbxKf1zOuephhsmCBMz62wXyrmwzq19SpSq8knwRT
	WIRwLRoKYvpHZ2DgIraKFZrZ/HVLGDXuwpSt7bkeGT0ZXPqYJXChVpFOp12nnL7LVa2Z61u6Vzl
	1vTAaF2WH8L6s5inp+nWqrQ8vyESifzp3D3m/jS/nodu7djPV8dlMN3n59SNi532oySd4lkR3g5
	LnTI5UzXS3UkC4RIb9Qy7AREzVMXStojMjvzS6FvGgANRXkFq6+cHO4gLFCqHh+wnL60FjwNYUQ
	lbtEUQkc21lwspDU7jZluk4hZKP2lbxqTSy8eu+BNog3z1hmZrj2nMgUaWp+/046o0LZZ7P+M2Z
	7WX7hNBafv4DJZhwbt+a+Q1WMGNZUkFF1s+oqrA24bt1hdiBf247HVN2fumibMDiCQpOYgrv1+w
	h8by9CddduOXexr5Q5zNtfDj6fEl7NaFcZn9SUokU8uzodTK97fFu8Z0EWrQ==
X-Received: by 2002:a05:6a20:3d82:b0:3bf:6856:d8fb with SMTP id adf61e73a8af0-3c36c16d449mr9012416637.29.1784228684252;
        Thu, 16 Jul 2026 12:04:44 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cd4341a37sm11580151c88.12.2026.07.16.12.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 12:04:43 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Hoang Huu Le <hoang.h.le@dektech.com.au>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	xmei5@asu.edu,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net v4 0/2] tipc: fix NULL deref in tipc_named_node_up() on empty publication list
Date: Thu, 16 Jul 2026 12:02:03 -0700
Message-ID: <20260716190204.100895-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

named_distribute() stamps the last_bulk flag on the tail skb of the
publication list. When the list is empty no skb is enqueued and the tail
access dereferences NULL. tipc_named_node_up() hits this on an empty
cluster_scope, which happens with a node-id configuration where
cluster_scope is populated only later by tipc_net_finalize(). It is
reachable by an unprivileged user over a UDP bearer in a user+net
namespace.

Patch 1 guards tipc_node_xmit() against an empty list, so the allocation-
failure path in named_distribute() cannot pass an empty list down to
tipc_lxc_xmit(), which has the same tail-of-empty-list deref.

Patch 2 emits an item-less bulk when the publication list is empty, so the
peer still receives the last_bulk flag and does not stall this node's later
name updates.

Changes in v4:
 - Keep the original return on allocation failure in the build loop (v3
   changed it to break). The empty-list block now runs only for a
   genuinely empty cluster_scope, so an allocation failure no longer falls
   through to it and cannot emit a bulk that misrepresents a non-empty
   list.

Changes in v3:
 - Split into two patches; add patch 1 to guard tipc_node_xmit() against
   the tipc_lxc_xmit() deref reachable via the allocation-failure path.
 - Break out of the build loop on allocation failure instead of returning,
   so the last_bulk flag is still applied to the last queued skb.

Changes in v2:
 - Instead of returning early on an empty cluster_scope (which would stall
   the peer, since it waits for a bulk with the last_bulk flag before
   accepting later name updates), emit an item-less bulk so the peer opens
   normally.

Weiming Shi (2):
  tipc: guard against empty list in tipc_node_xmit()
  tipc: fix NULL deref in tipc_named_node_up() on empty publication list

 net/tipc/name_distr.c | 14 ++++++++++++++
 net/tipc/node.c       |  3 +++
 2 files changed, 17 insertions(+)


base-commit: 4595d2c77ea4bfe4ae0efa38770a59ee5d2f06d3
-- 
2.43.0

