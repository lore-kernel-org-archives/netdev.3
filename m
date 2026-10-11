Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB8E349CE7
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 16:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791736206; cv=none; b=iwURDks+pmpULl4r1SVsTq5BIubzmWxgofnzpylBcjkj6EHbGTL5Z9zEy1nVYCYtUzNSTml1Vf6PeG4rYLgN8BQ54VXO5+Bfu9iWcrggpyUcE8sNurHmmIek7N0uaMFxfQCs7zK8xV2zabtkiNb85qbZXEfnixwNITxmd51jUGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791736206; c=relaxed/simple;
	bh=gySf8tkZ428le/U20u/o3aiJzjkbegB76EnbNa6P9wY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gM+N1owWY+29pyzYSdwHE1e/dlLJ8USMru/ous4EwXo+JZ+i08yuuOKL2E17N1NXj+CzL1SNkrMIqWPeVfwpsnvSU8y1hACEGEFLcPyOFtO1gP7/D2Aoo4RhjPblMq/HwWgGNJiO3WY7tUSWCxcXhOD37Q2ijqK2hDMNyWVy21g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=JSweP+ED; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="JSweP+ED"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48dc202a60eso294120f8f.3
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 09:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1791736203; x=1792341003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gdYE9zpvqOI/pBDY8tVSICunrB86zu9zwPxNrA/jEzM=;
        b=JSweP+EDdEAE/RiCrhIKV8bFEjoBeR74IMDd+Ugrq/8Tr5ZdhdHn1003RSbN6RtnDe
         IyTU5hGzofjuFkd9/meVOgrI1o7YpEJJS4Enh3iN72gAipq2G/INjm0fz/1QsUbrpyji
         6bhsB8WjH3dh5TXaGdJE/Mj3i5Hk1Ri97jx4dD9A8jPlewAmPgKJwyG3FpKmBc+lE7it
         +OuBLAdiZpXUH1G/KwuoF0lLySZFjwXE+TkVUvZShQMdC4cnHqUxUkLXbTcmdl+d/SuC
         0KuxX+LFSLMTD4al0asnaKxHw4pPXFbJWW3iyx6ahTzelFZIinj1RBwAKhTYZj/Yx16T
         nA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791736203; x=1792341003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gdYE9zpvqOI/pBDY8tVSICunrB86zu9zwPxNrA/jEzM=;
        b=OCqAhHeKzniIxOOcuDxb6kLwuCyCG5sBd0rZRhIy8X5KyrZPA8130Hf5ahmPKGYotj
         dC+owGhHgO3QMdrmtaJ2V1Tktss5R7oWzTWZkfydgVeSMRhNrFkBi0DIBxLPH0253PXW
         iUgr9hSv2SwsQqwt5DRMA+eVEtqnKQiI7hjgDJVZQRpDJkpEn5R6QYmIiek6wU2Geqe1
         hZyLnjcrtAL4zljBbrG9pWNMmNcPu84pqAWMIX74NDpKVjTsrLj03rGRiomFNHUKUyMZ
         63Lw7k5rqKRLQJeAqrHigxLMigcbd+hwk4nWhiTuC9bsRe7SHe4cfyfFYa6VFFPbwl45
         Lcag==
X-Gm-Message-State: AFq9FYJ6UR/X9ly7ud62XzvoukCqMo68R1+z2nxr3usLXVrrKBtcwSVg
	RlOycCczerhfgCwKRXuJvJHCpVWg2TM4hquwlGheo74YRXy2Ksi3ZUuXipxuDzK6/rN/VYE/F+x
	wFnHDag==
X-Gm-Gg: AYBFou0T7mHGMTengTWSZO3juelTkU259ms5KXJXpV0SNb8YyiA9i+9Ycn1VR9tNk7F
	mbLPRbRoKENgxHjoQqTQ0DwwR9gKBhZF+nwnN2HYt5Mshh8ePxVXQvvntfRLCEtmskozgk5rHBi
	rqZ5wk7S+pGe2Zy2+hKDXSqJBIEjQg6TVr3Xlnpj8zfnxdemaT1QvchNeiVPbZo9iQnJCOi1lxm
	W9ngKlJiiWlhVpeiQDTLrCeCiEAqPdj5PAaGLKpUHeUtXDzkKRfd2qRiiKqlsdk/+PtPx9/Jq+C
	3brmSfUSn8haD+iI7soGExy5Le1WDNz25t9sIOn83nRnpD7rNrt92LxRfZflTP/DdpibhRmrN/h
	baCzboyx08ksFalzAS2osYuh2xKB9wZ1b4pqjD2TBSGvDHcOghsGXwKMs9KoJwYQj7U95ZuwIId
	vtssS8qH4bt0D/2Hl00t8QTWWheTwC+cO98D3pVsnqi3tB6kQBzHih+DfTuPHpbs9CyIh/Uqoe9
	gPSSUdeld4wlp88Cd7uqEkpz+8tpJqnjLLo5MLy202PQQM+2XGbvjZ9xgm5pShASy8K0nIVljTb
	hzgmWQvgkdWGHQYKqK2unV8XqhMeGOyr7A3y03zFl5mCXFiThQOFTBfmrQJGaVJ1gjQssnbFbYL
	0vJhZPUjMKvkD2APeFMlwraH2TFaqq9pqg2piF2mnwSkW4TEIwkT3mWni6i3EA3CDso0pur1ycG
	BVJ9ja0Xlg7254Qpvs6lAYnpeQSPfIYjYr0IcwPSmEaA50576eVG0Qqcctu5w=
X-Received: by 2002:a05:6000:98d:b0:48c:4a62:9af7 with SMTP id ffacd0b85a97d-48dbaae9e03mr11164653f8f.28.1791736202395;
        Sun, 11 Oct 2026 09:30:02 -0700 (PDT)
Received: from Desktop.vpn.uni-hamburg.de (dhcp-40-52.vpn.uni-hamburg.de. [134.100.40.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9acc936sm14657920f8f.44.2026.10.11.09.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 09:30:02 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	steffen.klassert@secunet.com,
	willemb@google.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 1/3] net: make room for the tunnel header in skb_segment_list()
Date: Sun, 11 Oct 2026 18:29:55 +0200
Message-ID: <20261011162957.1328474-2-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261011162957.1328474-1-julius@bairaktaris.de>
References: <20261011162957.1328474-1-julius@bairaktaris.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

skb_segment_list() pushes each frag_list member back to the outer MAC
header and copies the tunnel headers in front of it, but never checks
that the member has the headroom. A fraglist GRO packet forwarded into
an IPIP tunnel and segmented in software hits skb_under_panic() when
the members were received with less headroom than the tunnel headers
need.

Call skb_cow_head() on each member before pushing it.

Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
 net/core/skbuff.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 41beaf625421a..3f358c0fc0483 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4729,6 +4729,10 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
 			}
 		}
 
+		if (!err)
+			err = skb_cow_head(nskb, offset + tnl_hlen -
+					   skb_network_offset(nskb));
+
 		if (!tail)
 			skb->next = nskb;
 		else
-- 
2.53.0

