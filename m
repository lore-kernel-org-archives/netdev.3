Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1A6417340
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 23:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785366100; cv=none; b=fgGJbaQmVTSvkXykmdP/jg3CAkT9W476civEPPxP2PYTJUrXno2P0BEmqtNYcTmIerJ7Kd6Dtq7kn6nf6ajJNUO7/WOiUGXa2js/Ic1MdC7Pz0YnUCTJ7nmvVvb8syQj1715H/I6fIHF9DUZSf7a3xIlL8AG024GUeEPQI/jWjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785366100; c=relaxed/simple;
	bh=UTBQNiiDAmrF8eEJjWhCmxOzyNEEcrA/1vh+3XzaKGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D1pzqtQLUlrWIvxri3VC9co3PHijHvMTUq0JCRxn/BoniN0n45yYEGL2x1soOJhcNoxfp9O8Rn4HJBGDLCjWKjkz8WHgjd17vWOLadgjKm3WHyTsyLtYdhKhoakJRQ7UAKS5757niaDCjv2gyM3AJ6frfXGSYdTCdOS38AuAJqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=bS8BbCEE; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="bS8BbCEE"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d032846c95so2586415ad.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 16:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1785366098; x=1785970898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qSd0JLr+KED3yZIYym4slkvBs2YohNvZDaDN+nkdRjE=;
        b=bS8BbCEEb+myP5DDocn60bCC0GrJEZzWk9BTHRthrwD1bSe7xKSEK2UN73Si8Ydcjd
         E4Yqf+gpELy1nexbk5dLmlUBFF4jgMI3kV461UKwKRI6f0f5iQ2gfLwgA8eOjx+yR3Gr
         hQRpaH/3614jSJNHyFEs0BiPkBi8Qm7hSjW8MPZ1lf3Gdk8NnMty6/9UowBa7JO4jkJ2
         yvoDLgzcg7Wfn+rgbVnFr4XJWnUoloLsL3l1jvjuuXiA7ZJsI72Zwa5QI61tMap6WeG9
         RY2jTMtgY+cexTtc+rzzfob70xJHA4VNOcR6KWAPTJ0AjBvvlXCiIcRR5ske/U3JnNME
         FVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785366098; x=1785970898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qSd0JLr+KED3yZIYym4slkvBs2YohNvZDaDN+nkdRjE=;
        b=Sgz/pEEviPriKUiRl/XEUNlfjt0VlO3Pub8X4DMLg/1lp+sghE/vEa3zP6j49NELqv
         Mt1BiL0PcDuLdQ63rc3sPnOA11SD7dUKthxsl/ODareRSKMHfLzGsoyOw7jrOMA/9WXW
         cFua2DD8nbW7F5XxJOd5E3AP6ulrEZ8+5TvUodUZO062f3QLItq3VHe+BSsZVF+h2UpS
         eisGj5ViYqSJXDlQxudsgnlh3DXQM5fgco12n2L9mfvCLPHdFpewcsvQ2FND5SApDBRM
         gtVaM1d1hHHtKxOpSFibwCGDwm8lkWSUXkNwvFwak/0LhnBkMZE5B80jiQdLUtGATWFM
         B6mQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro1A0EUZx9nlZfniJYKIi/fJlfzG8EIIii7dE4g8uNWpCzoMm60YniByLZAcnxyAhTYPPjQ6Ws=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmzv+iMsBjNvQlbGWAsYxtmLBngWdaL1RfEwkuHmElMsyknGZ9
	YF3SnPKbg1zcdbC8QesVwHcy1BlXvFglKHHi+jUfaspv3jwRVy1FZ+/e+AaHD5Td5A==
X-Gm-Gg: AR+sD10oLiwysApr8WMwo4x1WpXKL1RcnklxYSA9WuXULg5NxbrPe5rGR1J0d0DTBdb
	7vAyEEpNyoHhxFFmnT3J1HHJqNq2LQsgoN0JnTdxTNC7yWEOGigm0eBSBQT3fJg1BI4x3re3EwV
	gA2Kf6+vUXHAwjZFn8yzuYAMN4PleYSbrZSVgRv7kwebaiQUAQdun/T+IWnZL3Ht8Z4V23bt9u3
	duBvEa/Z+rudbU0QqgEQF9PeP0x4Lk6tw0TtW9hjPeOW9WkjkMGfK8eIBl+g40ckEvGimXl+KAH
	FzmbyDZiViYLwR1XyFZTtv1IS3HZ4Iu6Qgdd5Ls/35SHTWxGtc/i+LxSdEQcjhtaaqhI7uTVqKQ
	cvsixXrwXu+NUZHdnHupGxlzkXKMc4BsNBmR2U1I5MWkJ74bmMnxAxDsWT/ogA3cLEZyMax+myD
	bc6rtXetkn+ADisCFbakoXdqGLiiolrKHqdbhCLrZP5McCB5XZf0fgInJGAm7m80x70Q==
X-Received: by 2002:a17:90a:da83:b0:38f:5828:a40c with SMTP id 98e67ed59e1d1-38f9bd99229mr178404a91.10.1785366098384;
        Wed, 29 Jul 2026 16:01:38 -0700 (PDT)
Received: from xiang.tailc0aff1.ts.net ([20.171.14.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504d373c3sm13777272eec.23.2026.07.29.16.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 16:01:36 -0700 (PDT)
From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
To: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	"Xiang Mei (Microsoft)" <xmei5@asu.edu>
Subject: [RFC net-next v2 3/3] bonding: use skb_vlan_push() for probe tags
Date: Wed, 29 Jul 2026 23:01:19 +0000
Message-ID: <20260729230119.2717507-4-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729230119.2717507-1-xmei5@asu.edu>
References: <20260729230119.2717507-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bond_handle_vlan() open-coded the VLAN stacking with
vlan_insert_tag_set_proto() for the inner tags and
__vlan_hwaccel_put_tag() for the outer one.  Now that the callers push
the link-layer header before tagging (arp_create() for ARP,
bond_ns_add_llhdr() for NS), the tags can be inserted with
skb_vlan_push(), which handles both the inline and the offloaded tag
and grows the headroom as needed.

Walk the tags from the innermost so each skb_vlan_push() moves the
previous tag into the frame, and free the skb on failure
(skb_vlan_push() does not).  Reset the MAC header in bond_arp_send()
so skb_vlan_push() finds skb->data at the Ethernet header.

Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
---
 drivers/net/bonding/bond_main.c | 38 ++++++++++++++-------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index d5a7a7dd1eb2..0da57e9bb47c 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2973,37 +2973,28 @@ static bool bond_handle_vlan(struct slave *slave, struct bond_vlan_tag *tags,
 {
 	struct net_device *bond_dev = slave->bond->dev;
 	struct net_device *slave_dev = slave->dev;
-	struct bond_vlan_tag *outer_tag = tags;
+	int i;
 
 	if (!tags || tags->vlan_proto == BOND_VLAN_PROTO_NONE)
 		return true;
 
-	tags++;
+	for (i = 0; tags[i].vlan_proto != BOND_VLAN_PROTO_NONE; i++)
+		;
 
-	/* Go through all the tags backwards and add them to the packet */
-	while (tags->vlan_proto != BOND_VLAN_PROTO_NONE) {
-		if (!tags->vlan_id) {
-			tags++;
+	/* tags[0] is the outermost tag; push inner-first so each skb_vlan_push()
+	 * moves the previous tag into the frame.
+	 */
+	while (i--) {
+		if (!tags[i].vlan_id)
 			continue;
-		}
 
-		slave_dbg(bond_dev, slave_dev, "inner tag: proto %X vid %X\n",
-			  ntohs(outer_tag->vlan_proto), tags->vlan_id);
-		skb = vlan_insert_tag_set_proto(skb, tags->vlan_proto,
-						tags->vlan_id);
-		if (!skb) {
-			net_err_ratelimited("failed to insert inner VLAN tag\n");
+		slave_dbg(bond_dev, slave_dev, "tag: proto %X vid %X\n",
+			  ntohs(tags[i].vlan_proto), tags[i].vlan_id);
+		if (skb_vlan_push(skb, tags[i].vlan_proto, tags[i].vlan_id)) {
+			net_err_ratelimited("failed to insert VLAN tag\n");
+			kfree_skb(skb);
 			return false;
 		}
-
-		tags++;
-	}
-	/* Set the outer tag */
-	if (outer_tag->vlan_id) {
-		slave_dbg(bond_dev, slave_dev, "outer tag: proto %X vid %X\n",
-			  ntohs(outer_tag->vlan_proto), outer_tag->vlan_id);
-		__vlan_hwaccel_put_tag(skb, outer_tag->vlan_proto,
-				       outer_tag->vlan_id);
 	}
 
 	return true;
@@ -3031,6 +3022,9 @@ static void bond_arp_send(struct slave *slave, int arp_op, __be32 dest_ip,
 		return;
 	}
 
+	/* arp_create() has already pushed the link-layer header */
+	skb_reset_mac_header(skb);
+
 	if (bond_handle_vlan(slave, tags, skb)) {
 		slave_update_last_tx(slave);
 		arp_xmit(skb);
-- 
2.43.0

