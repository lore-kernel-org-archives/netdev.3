Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7A1483824
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786721763; cv=none; b=nAxZkerk5zzFQwIM1bQ/RJWndTn3SSL38mBJLtDySec7MfJWWC2RxDpwqXAGjxca1NksH0qaW3nZUDTK0w9fbW/NnzqtCWQxcn90ivblYUWIQEGD1VIINd0eb2Af4k30CwKymsmPvy3QaNIeYL0w9pUIudKX2xK49LWpEhCW+4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786721763; c=relaxed/simple;
	bh=oC8uxnUoHIJECXnXDW3nO3VgCsMdStFUvRtmZ+GRTjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RMw7N/tM1HLKP7MIFSlljrzbYQLPt5J8BOU8NsAeGKVBU+59DPDaWVXL42MQsbH5Ewpb04KQpou3TfrRcJjllKgEHe4l7474BlsLO/mwVu4uRFcr8H/Zz+4z4HTzm6NjFdrbWbgoH+/61syWTQP3YeTxTd/SuH3QE+dkfehtW5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=Wtk1Sqce; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="Wtk1Sqce"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cacb8416a1so11823575ad.1
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 08:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1786721756; x=1787326556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JYY5l/WqUktJys7ji2DTJAIhZftIqAFNwlTbRpzmO7c=;
        b=Wtk1SqceAh0YTWlv39zT5HX7O0ECTW+SgtekIElu7qrQIh6Ds98+qxRqSwyrQwmxsh
         0RdDNdp0P/Wn1imXnlTWF224Ac/T0CxWUllBzdsvIha/JAau54YR+E0/rOyaYKGdx74P
         VfRnrxh2OWJeGCGSBKunwLLai9nqbIEoY7f9iSvNfI+lNVQZPb/f/CiD6WR9Wr7LUKIn
         OdHy6lQ4hgI+iR7bCzlfuCRfWjnRiPt21Bbh5/R0g2Cb1umf9PUOwKehCJEz/otIgPP0
         HNAp/aY3JwZAqV1xSKyD74YlGNdMxZZoo3aneNz9zubfNJX9PGxt9GCYvLiGWrWupN8P
         Z/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786721756; x=1787326556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JYY5l/WqUktJys7ji2DTJAIhZftIqAFNwlTbRpzmO7c=;
        b=scN1yR0WGsGchIBC2FJZl+ht8xmSwt5oZoouwhfeeK8uMFanqK6UTkyAGeZCw/jMjY
         wJUuH8jVXTVZ7AtD+aYbsL+lsBhBwetftrkP00Zc6zpGNYuXfeCIqBN1x1T7W8kievfZ
         vzZivP2+wMlc6inH73QVLaLO6syurGiUKfNTCIp3zu83dcQQ93/ELbUN8f/ayNDG1Fvv
         2ppMxHMZBzrRYCJ4jQjZDkRQdyjwXcjBuMPjHrZOJYtvgtyohTuxJoFxbdlE/bceO7JD
         hxCbwuHJcfDx+5XeJzQWzP5u/030KF0BfrmnOaChDiLGh6MPDQE9velq3roJQm2kMBR+
         jXiA==
X-Forwarded-Encrypted: i=1; AHgh+Ro3nBqnGmgTLPlqESV7yT7CXqohshZkHDFDXlxrHUdR0UzxC2yXi4dVKHqbeT7/4DDlPyeViU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmqLYds/EQ5hD6WOLqUH3ISfphZMwn8+HiPLbv2YjT6sB7iXg0
	eNkgKqu+KkNIyyYlZpfdM/rE5b2hgyvt1QAFhls0lMPPhws2HjezJu6/qibk9X3IsDKRXB+yIdY
	rAstkF3Va+w==
X-Gm-Gg: AR+sD12lQdRtZ9i+Tm1xFyFu2MhlPuQL0DwKelnmNT2+UZy4POO3mJ33zWIWvyYTruc
	b//AmfJGoTfy3dYQosRDTYvdSTHgLgZArofMLe6bpiK6uI5CoRH03pcfNKI1qTi9f6bpZC2WRPX
	1qItZ7pXVlaVFkULBm88N567jDuS7ibiWwkDlR2ASXXKYZ2OTOY7VnmBjYrF+Gn8Mym6EHY++Wf
	OA9UImsusHNNojNz31j1kI3jjPxkLmdytF4u+LdZS3GNlTnNeOo0FK+tjaCEGKGKC13cpu8K/SG
	iwA+0SLrtJjQo49aQuIg6H0vGx5e59FK7a9adgCn/egg1R9RB1oVECqg0KqGdmM+0TgngC36sTW
	/Cu1x/R5NJNjWuX0pBIG+/Y1xxecYMFCOhNUDi+8kOU38b24McZnCj2QcEk9Ma/mjoVLLBUqoJk
	qz0Lkk/ZMX9cXgOMrBpTym9nnyhPFlYMj3sxBQJmvIaf23InLi1fHi+kffIM7x2fjIbMRc7YYL1
	Z6uzYKOVImNIRqS86Ejkl1vi0uVXIVKoAspFg/vNHA6
X-Received: by 2002:a17:903:1b66:b0:2cf:b68a:340 with SMTP id d9443c01a7336-2d3b0c43462mr79071135ad.10.1786721755388;
        Fri, 14 Aug 2026 08:35:55 -0700 (PDT)
Received: from localhost.localdomain ([125.181.61.26])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3ae7d16e8sm11459485ad.31.2026.08.14.08.35.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Aug 2026 08:35:54 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: idosch@nvidia.com,
	razor@blackwall.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	federico.kirschbaum@xbow.com
Subject: [PATCH net] vxlan: mdb: Fix use-after-free in vxlan_mdb_flush()
Date: Sat, 15 Aug 2026 00:35:47 +0900
Message-ID: <20260814153547.29567-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vxlan_mdb_flush() iterates over the MDB entries using
hlist_for_each_entry_safe(), which only tolerates the removal of the
current entry. Contrary to the comment above the loop, the removal of an
entry can trigger the removal of another entry.

Flushing the remotes of a (*, G) entry also removes the (S, G) entries
that were created for its source list, once they are left without
remotes:

vxlan_mdb_remotes_flush()
-> vxlan_mdb_remote_del()
   -> vxlan_mdb_remote_srcs_del()
      -> vxlan_mdb_remote_src_del()
         -> vxlan_mdb_remote_src_fwd_del()
            -> __vxlan_mdb_del()
               -> vxlan_mdb_entry_put()

Such an entry can be located after the (*, G) entry in the list, as
vxlan_mdb_entry_get() returns an existing entry without moving it to the
head of the list. This order is obtained by adding the (S, G) entry
before the (*, G) entry, the latter with NLM_F_REPLACE, as the addition
of the source otherwise fails with -EEXIST. The (S, G) entry is then the
entry saved by hlist_for_each_entry_safe() and it is freed while the
(*, G) entry is processed. The next iteration calls hlist_del() on it
again, writing LIST_POISON1 to LIST_POISON2 [1].

Besides device deletion, the flush is also reachable from RTM_DELMDB
with NLM_F_BULK.

Fix by re-reading the next entry after the remotes were flushed. The
current entry cannot be removed by this flush, as source lists can only
be configured on (*, G) entries and the removed entries are (S, G)
entries. It is therefore still linked and its next pointer reflects the
removals.

[1]
BUG: KASAN: wild-memory-access in vxlan_mdb_entry_put.part.0+0x328/0x588
Write of size 8 at addr dead000000000122 by task ip/327

CPU: 3 UID: 1000 PID: 327 Comm: ip Not tainted 7.2.0-rc7 #2 PREEMPT
Call trace:
 vxlan_mdb_entry_put.part.0+0x328/0x588
 vxlan_mdb_flush+0x1d8/0x25c
 vxlan_mdb_fini+0x8c/0x100
 vxlan_uninit+0x1c/0x7c
 unregister_netdevice_many_notify+0x954/0xd4c
 rtnl_dellink+0x210/0x530
 rtnetlink_rcv_msg+0x434/0x4d0
 netlink_rcv_skb+0xc4/0x204
 rtnetlink_rcv+0x18/0x24
 netlink_unicast+0x4b8/0x548
 netlink_sendmsg+0x29c/0x560
 ____sys_sendmsg+0x390/0x3ec
 ___sys_sendmsg+0x114/0x188
 __sys_sendmsg+0xf0/0x178
 __arm64_sys_sendmsg+0x48/0x60
 invoke_syscall.constprop.0+0x58/0x180
 el0_svc_common.constprop.0+0x74/0x140
 do_el0_svc+0x30/0x40
 el0_svc+0x38/0x98
 el0t_64_sync_handler+0xa0/0xe4
 el0t_64_sync+0x198/0x19c

Fixes: a3a48de5eade ("vxlan: mdb: Add MDB control path support")
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
 drivers/net/vxlan/vxlan_mdb.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
index 055a4969f593..385889c001d1 100644
--- a/drivers/net/vxlan/vxlan_mdb.c
+++ b/drivers/net/vxlan/vxlan_mdb.c
@@ -1422,14 +1422,17 @@ static void vxlan_mdb_flush(struct vxlan_dev *vxlan,
 	struct vxlan_mdb_entry *mdb_entry;
 	struct hlist_node *tmp;
 
-	/* The removal of an entry cannot trigger the removal of another entry
-	 * since entries are always added to the head of the list.
-	 */
 	hlist_for_each_entry_safe(mdb_entry, tmp, &vxlan->mdb_list, mdb_node) {
 		if (desc->src_vni && desc->src_vni != mdb_entry->key.vni)
 			continue;
 
 		vxlan_mdb_remotes_flush(vxlan, mdb_entry, desc);
+		/* The flush can remove the (S, G) entries created for the
+		 * source list of this entry, including the one saved by
+		 * hlist_for_each_entry_safe(), so re-read it while this entry
+		 * is still linked.
+		 */
+		tmp = mdb_entry->mdb_node.next;
 		/* Entry will only be removed if its remotes list is empty. */
 		vxlan_mdb_entry_put(vxlan, mdb_entry);
 	}
-- 
2.50.1

