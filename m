Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D8C3A874F
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 05:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788155199; cv=none; b=pvBcaSiGA+ZhzEB6uhdzEIKFxMHypeCqRYc7SgPlomRDvGjIFrLc9fb9gQhuzghKGExSgsdgNbvZlEx16FTPUeVFrLbgSHC7J5LevsrFox1YILoHo78WxVG5SnfhcFji78q+OwuMZg1JHhsOFG1+B3aH3OJVuCrkO8d1w8TLH78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788155199; c=relaxed/simple;
	bh=2SIG03l0reg2VYns4LMyRg7qlZrAz5l3My7Xpaw8Q8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=grGP2jPmYJbEy6c8o352pIO8dRWpQxDUZ35dFIlToZrZBcTr8sR1CrV7nIFTggEekUSbyKKWTKzN6PxNrd/Cn/oOj8s7BguggUkZ0c2ntjnWrnmdlVH74uI1boC5kvRlP+EbHc9G7tQb9yj4IigJ/vLqasyg0mxorm1kzUNUS7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qPmhisgy; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPmhisgy"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-855d2bfae95so3144222b3a.1
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 22:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788155197; x=1788759997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S7Yz+YOY2+16/lpuKvY5IjxeWag/EA2jCZBiex1Smc4=;
        b=qPmhisgyP+ceBJU1xMtDo6lJsRJpP5sAhAlChfH0xJHFQ13gfpM7lC+bhR+tjHRe6m
         Gg6gyohX3r2yeqtp9Qe4jB7jVxncmR++VUX2nvFVbPfF2bo6eIhF0g/uvgVda5lai6tq
         Dg2/zZEYwX/nFeKy5SRmpF5Pu2qvIhRUsSXy/gm9JhlbTDflxTPSsj6IDC9qGKqpU50G
         DyRYj8X1bPyHUtz70J31f43Lh96T1gKP0mqCXzRZqVkpvuJlg58Cz2eDiSNiRDg4XceJ
         jvR4FBgpTDtCPQw9BU2o8dqwv1e4FXA/EbHM+hcGmi0V1V/XXllCLrtKwly0ooh24JAN
         SpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788155197; x=1788759997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S7Yz+YOY2+16/lpuKvY5IjxeWag/EA2jCZBiex1Smc4=;
        b=VAPTIXbtyZxlUXa1C6v18gXHNYGkVNjYzGOq6Y6nNZfkmtVgcjaayZxMz8fHduBX1v
         m630BR7XUzudgtmVqEq+U6+NT0aSXC2blqq7783ZqHZ2Z+HI4VpnQjcf5aAU1irdv0FQ
         vQ71FLzgHLSK4kb9yCJv7PfM1dj8bsHIhLXAIX3w1XKnbHHRHBVNVdm8P51DMYjy2Wn7
         EYPU/r5Y1RBZ1ppeV4AZw4G5b0+MYFnQq/5KgSc6lBftNf/wmLnjijwuODeC0IdjQKfA
         Yno0Qh9cbZDzkC+Gz/rvWqDBsdghqSOl0K8ZjYMzgGUQ39NoDvWmjhuuvMfE8dNJ8sOK
         ODqQ==
X-Gm-Message-State: AFuF++kQqyWg5QPnh+Itx/+hqN9h8ffoTdo0JWz8NYvnbwjagB19LO/4
	RPXzMPtzU518uilzn+9Usqeym7ipE9Eo8dxzO+Tt09JFSit3jJk0kit23PKmFGC6
X-Gm-Gg: AR+sD11XBVgcTXRnrHKyuENNq6zHCJmRm2g6xSMVlYyhsdAy2Bmq7W7cBrSzK2jTnA4
	HhzH8oV701a6yvKFj+TT0sE+cE/iiyrrgNqraynhkqfgojEkDPz40Mbk8lJS3QG6DTKNnV4jIQh
	Og7o9qsR0VDVlu7A6PuwNwQCnFIlw/Q1Ond3n/E4zX4XDuwGAY4IatUuP8y0Z4qG60cxzGqKjNF
	OQy+RMzyI/7m8+m1O2wJ8+EXnORFT/JQD04kH2ukhRKh61itemmgWdwE0L2TKpbYKWqTjY99fEo
	ShRupqgeB79SA9CL9lPx6RNmzSUOhfzNz83VuFxeAPZJGOX07fzINOHdbfeRuL3anNtPS8iHi2x
	VJLpfWyPKsn++MNqfu7czNg3yWohKTYQvWnuXZdMJmNH1ybM/30KMhZC7jZR+CrhIFvHkDqE3DP
	oUtgpuACi7NRjo4a2TxYJi5sVAcLTQFG9xaeKUP61Y+HBOX72ARDSXXF5sfOxukukQTYrz9AovW
	iVTK3IwkGWdg24s4ON7M/6c4eItmeTGsSJQReEEs0GtZNDhC0B1
X-Received: by 2002:a05:6a21:a08:b0:3bf:b7e8:68ab with SMTP id adf61e73a8af0-3d5d7187981mr5135057637.2.1788155196875;
        Sun, 30 Aug 2026 22:46:36 -0700 (PDT)
Received: from secrnd-cstp.tailb7f510.ts.net ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f36aeb7esm3642714a12.15.2026.08.30.22.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 22:46:36 -0700 (PDT)
From: Sanghyun Park <sanghyun.park.cnu@gmail.com>
To: netdev@vger.kernel.org
Cc: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Stevens <dlstevens@us.ibm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] vxlan: use one headroom snapshot for neighbour replies
Date: Mon, 31 Aug 2026 14:46:14 +0900
Message-ID: <20260831054614.2069896-2-sanghyun.park.cnu@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vxlan_na_create() samples LL_RESERVED_SPACE() to size the reply skb and then
samples it again to reserve headroom. A concurrent vxlan_changelink() can
update needed_headroom between the two reads, creating a TOCTOU race. The
second value can exceed the allocation and make the Ethernet header write out
of bounds.

Snapshot the headroom once and use that value for both allocation and
reservation.

Fixes: 4b29dba9c085 ("vxlan: fix nonfunctional neigh_reduce()")
Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
---
 drivers/net/vxlan/vxlan_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 459f19f7071e..e5a92d30113c 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1947,13 +1947,15 @@ static struct sk_buff *vxlan_na_create(struct sk_buff *request,
 	struct ipv6hdr *pip6;
 	u8 *daddr;
 	int na_olen = 8; /* opt hdr + ETH_ALEN for target */
+	int headroom;
 	int ns_olen;
 	int i, len;
 
 	if (dev == NULL || !pskb_may_pull(request, request->len))
 		return NULL;
 
-	len = LL_RESERVED_SPACE(dev) + sizeof(struct ipv6hdr) +
+	headroom = LL_RESERVED_SPACE(dev);
+	len = headroom + sizeof(struct ipv6hdr) +
 		sizeof(*na) + na_olen + dev->needed_tailroom;
 	reply = alloc_skb(len, GFP_ATOMIC);
 	if (reply == NULL)
@@ -1961,7 +1963,7 @@ static struct sk_buff *vxlan_na_create(struct sk_buff *request,
 
 	reply->protocol = htons(ETH_P_IPV6);
 	reply->dev = dev;
-	skb_reserve(reply, LL_RESERVED_SPACE(request->dev));
+	skb_reserve(reply, headroom);
 	skb_push(reply, sizeof(struct ethhdr));
 	skb_reset_mac_header(reply);
 
-- 
2.48.1
