Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5A24BEE52
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 21:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789163548; cv=none; b=XEADeFjAvJowkkp/36uh806qaba0dcGOB4ZFMjjtSeeYRO64i4I3F2Up2Pw76yjMYGvSbaZETRQZK6yxwMvb2WV5+Fk55OBIY05v0ZyBN0lnjLvN9G5mIdaSab/ctDeeuvSlD0/+zHUBZM+kSAIvWK0LRdToMoZSMC98cQ1Y2f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789163548; c=relaxed/simple;
	bh=dMMPUJPO6blH+Tw6+p5Ha6xPKvSn/n39V4vIMAHGZxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxJY/jTIeMCQwYVyGB9xlWNVRFKqHsuxznR3GJJOCcpxa5ADDZVpFSMBbFpabwUmC6picFoiQgLUPZhq+Q0CGaI0JjtTo3a7Ks/6Eum/Ar/JcEW+MutXSDMOa9DVuusQoUBOAf57xpAQjLUkx3+fe9kKcAuYneZQPCWfe9LlJTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rqrTS3eB; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rqrTS3eB"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccff31419so405375e9.3
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 14:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789163542; x=1789768342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oIYfhVr2XF8SsjE4lRT/fASBc4GUKg9R1nm1p148xWM=;
        b=rqrTS3eBEEOsDBsEldV84TaCA18REBwRwMfaL+9oLGzBxjyh2FKDNg2EfxhhERe3x6
         GnhfN8E0fz5jTGt5B2JIiN11nOwUkM6OlHnVHe+IaVbUVGA/lAI8cnhLRpJ9oqNBRl1V
         fkG41Zq+QVOWWLQv8tU/98aMgHtup5gKgr7Jiqm9lc+a2elDQN8tU2RpGH8Ebj1RVmUa
         CFW7zjnFEvZUNG1sPnRM7RJMfd9RC1HngO1IcLwjC1l7Rw+OIV8Vz7jFH4kHs+jn2siQ
         4d2nnxjzWZyweEjErmuX0dqXMZtzN98OqbZR979ySZseqh1N+/ums8VLe8dYEhE9IqT6
         oj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789163542; x=1789768342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oIYfhVr2XF8SsjE4lRT/fASBc4GUKg9R1nm1p148xWM=;
        b=j2UlT3mveBy8Ql54Wo706XGfcg8UrrlRDEuM1SgnD3rt9YOb6/6TmZlvqaJFWu3IX7
         uaL2YikpkOjKrfevwk58UNDMCSjGa0699xuB/pVtQq/5EJb2vI+DhC7ZzKlX4rYdffoj
         G2d5lh50ql7nDL7iTAOIyQRiIjzMs76IhaZoApvLzxruYXxRWKXENuE7Dtbcy7iz2xi4
         iR8msnFTrOvgxa/Rl8KzfpfIlU5+YPAEJuA+3Wcx1w+GoPOipJUa1fThGx3U7OFmj6oo
         AA4G6DY46vL5J+gGac+xNmPMPQ9an2DQj/8EnND5hxr7B942piHxuMDxlRgIRPlgM7jV
         YZOQ==
X-Gm-Message-State: AFuF++mMlsN0at+t9NaLx7LNJoLs45cNkNmGd39/TEj3908Z9CvtuhuR
	AEC2GCJIpXCAr2Q2+RyluSYuc6GA3SF3ky2XEMHUpIDaQdcuYm+8OUwWiBu4sAa967U=
X-Gm-Gg: AYBFou3mQ96rdypYjYS3wIsquHW5y/KwGJ/rfdZVAb1JjPU454s4vx4ssJit+Hl1//6
	1tHva7UruIRrsm+31iXZRaB8AbwtHMjMlDKpW48tNnRsoi2OQEKkdYDoKKorHtmapOzBrG2kx7L
	i+IqVN7LoqmIAKe2QXNqWfUIY0g6HeCiXLcVQgo7JOqDSMYqtdOgscy++Le8JY4bm0ls6v9EH6/
	ge4vWdtVMT8YDXuPT7TAk9P8FqjlxO+IrAp5l2eidi1z+J6Mz/ewoIrE24htgnUAftOIzT01Jqh
	hHZuUre0Mm9QC5rJne7msvFe6jQ6JCRbpMTIxNHaqz1vk1vn2qIDMDy52TEnyxDMhlTt9Fi7g8q
	/6qcv6Y0U8v8i1bXkcuWOHnQiQJ5oC2X9+0JgY5AbjYe/Gpt0vlXOMwIE7x6L+DqWUPYBQkq2m9
	LcCHNrU/W4lDsKxe73lzalPQVQscCNfnhCPngpU5UcGnyN2lWC3jLfP04CE8oZOEsBhYb5xw5Np
	F9Qs6u0jT2h4uvF2nQV6RUc
X-Received: by 2002:a05:600c:5249:b0:493:c47f:3c55 with SMTP id 5b1f17b1804b1-49e6caa782cmr838485e9.5.1789163541803;
        Fri, 11 Sep 2026 14:52:21 -0700 (PDT)
Received: from kali ([169.224.126.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c1bc5fsm177081345e9.3.2026.09.11.14.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 14:52:21 -0700 (PDT)
From: Ali Firas <alishmery18@gmail.com>
To: netdev@vger.kernel.org,
	idosch@nvidia.com
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	razor@blackwall.org,
	roopa@nvidia.com,
	bestswngs@gmail.com,
	xmei5@asu.edu,
	linux-kernel@vger.kernel.org,
	Ali Firas <alishmery18@gmail.com>
Subject: [PATCH net v2 2/2] vxlan: vnifilter: roll back VNI insertion when the group update fails
Date: Sat, 12 Sep 2026 00:52:03 +0300
Message-ID: <20260911215203.3054653-2-alishmery18@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911215203.3054653-1-alishmery18@gmail.com>
References: <20260911215203.3054653-1-alishmery18@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vxlan_vni_add() publishes the new VNI before it can fail. The node is
inserted into the rhashtable, added to the VNI list and, when the
device is up, linked into the per-socket hash, and only then is
vxlan_vni_update_group() called. Nothing is undone if that fails, and
since commit aa6ca1c5c338 ("vxlan: vnifilter: send notification on VNI
add") the RTM_NEWTUNNEL notification is sent unconditionally rather
than only when the VNI changed, so userspace is also told a VNI was
created that the request reported as failed.

Undo the publication on that path and notify only on success.

Reproduced in a QEMU guest as an unprivileged uid inside
unshare(CLONE_NEWUSER | CLONE_NEWNET). ip_mc_join_group() returns
-ENOBUFS once the socket already holds sysctl_igmp_max_memberships
groups, so an add whose group is the first one over that limit fails
inside vxlan_vni_update_group(), after the node has been published:

  ip link add dum0 type dummy
  ip link set dum0 up
  ip link add vx0 type vxlan external vnifilter dstport 4789 dev dum0
  ip link set vx0 up
  for i in $(seq 1 21); do
      bridge vni add vni $i group 239.1.1.$i dev vx0
  done

The limit defaults to 20 and is tunable per network namespace, so the
first failing VNI is the limit plus one; with the default the 21st add
fails:

  RTNETLINK answers: No buffer space available

Before this change "bridge vni show" lists VNIs 1 to 20 and also VNI
21, which the request reported as failed, and a notification is
emitted for it. After it the same 20 VNIs are listed and VNI 21 is
absent, with no notification. 21 adds are issued in total; the first
20 succeed.

The default FDB entry needs more care than the rest of the state. It
is not enough to call vxlan_vni_delete_group(): its guard fires when
either the per-VNI remote IP or the device default remote IP is set,
so on a device with a default remote it issues __vxlan_fdb_delete()
even when vxlan_update_default_fdb_entry() is what failed. The entry
may also not be ours at all. A zero-MAC entry can be installed out of
band, and vxlan_fdb_append() returns early when the destination
already exists, so the add creates nothing:

  bridge fdb append 00:00:00:00:00:00 dst 239.1.1.21 src_vni 21 \
      vni 21 via dum0 dev vx0
  bridge vni add vni 21 group 239.1.1.21 dev vx0

The "via dum0" is required. Without it the entry carries rdst ifindex
0 while the add installs with default_dst.remote_ifindex, so
vxlan_fdb_append() creates a second remote instead of finding this
one, and the rollback then removes only what it added. With it, the
entry matches and an unconditional rollback destroys it, reporting
RTM_DELNEIGH for something the user configured.

Report through vxlan_fdb_update() whether a new remote was actually
created, thread that back to vxlan_vni_add(), and remove the entry
only in that case.

Leaving the entry alone instead would be a much smaller change and it
is inert in isolation: it holds no reference to the VNI node so
nothing dangles, the user can remove it with bridge fdb del, and
vxlan_dellink() flushes it with the rest. It loses on retry. Without
this fix an entry the failed add created outlives the VNI, and
vxlan_fdb_append() merges it with a later successful add of the same
VNI rather than replacing it:

  bridge vni add vni 23 group 239.1.1.23 dev vx0   # fails
  bridge vni del vni 1 dev vx0                     # free a membership
  bridge vni add vni 23 group 239.1.1.99 dev vx0   # succeeds

 00:00:00:00:00:00 dst 239.1.1.23 vni 23 src_vni 23 via dum0 self permanent
 00:00:00:00:00:00 dst 239.1.1.99 vni 23 src_vni 23 via dum0 self permanent

VNI 23 ends up with two default remotes, so BUM traffic is replicated
to a group the user never asked for and the device never joined. That,
and the asymmetry with vxlan_vni_del(), which does remove the entry,
are why creation is tracked rather than the entry simply being left.

No membership has to be given back. vxlan_igmp_leave() is unreachable
from vxlan_vni_add(): it is gated on
vxlan_addr_multicast(&old_remote_ip), and old_remote_ip is a copy of
the remote IP of a node that was just kzalloc'd, so it is zero. This
does not depend on the device's default remote, which the guard does
not read. Verified on a device created with a multicast default,
where /proc/net/igmp shows the same 22 membership rows before and
after the failed add, including the device's own group.

Two things are deliberately not addressed here. vxlan_vni_add()
returns early into vxlan_vni_update() when the VNI already exists, and
that path commits remote_ip and swaps the FDB entry before the join
can fail, leaving the VNI pointing at a group it never joined while
the request reports failure, and with no notification since *changed
stays false. It needs a second vxlan device sharing the socket to
reproduce, because vxlan_group_used() returns false as soon as the
socket is used by only one device, so the leave otherwise frees a
membership and the join succeeds:

  ip link add vx1 type vxlan external vnifilter dstport 4789 dev dum0
  ip link set vx1 up
  bridge vni add vni 100 group 239.1.1.1 dev vx1
  bridge vni add vni 1 group 239.9.9.9 dev vx0

The last command fails with -ENOBUFS, yet "bridge vni show" then
reports vni 1 with group 239.9.9.9. A correct fix there has to restore
remote_ip, reinstall the old FDB entry and rejoin the old group, which
is a transaction rather than a guard, so it belongs in its own change.
vxlan_vni_add_del() leaving the earlier VNIs of a partially applied
range installed is likewise a separate question about that function.

This patch depends on the preceding one, "vxlan: report whether
vxlan_fdb_update() created the remote", and does not apply without it.

Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")
Link: https://lore.kernel.org/netdev/20260323095544.3311285-4-bestswngs@gmail.com/
Link: https://lore.kernel.org/netdev/20260324133449.GA460138@shredder/
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Cc: Weiming Shi <bestswngs@gmail.com>
Cc: Xiang Mei <xmei5@asu.edu>
Assisted-by: LLM
Signed-off-by: Ali Firas <alishmery18@gmail.com>
---
v1: https://lore.kernel.org/netdev/20260904021707.2891129-1-alishmery18@gmail.com/

v2:
 - do not remove a default FDB entry this add did not create; the guard
   in vxlan_vni_delete_group() is an OR, so the v1 rollback could delete
   an entry installed out of band. Track creation instead, which is what
   patch 1/2 is for.
 - drop the vxlan_vni_delete_group() call from the error path entirely:
   vxlan_igmp_leave() is unreachable from vxlan_vni_add(), so there was
   never a membership to give back.
 - correct the changelog: VNIs 1 to 20 remain listed and only 21 is
   absent, not "the table is empty", and 21 adds are issued, not 22.
 - state what is not addressed: the vxlan_vni_update() path and
   vxlan_vni_add_del() partial ranges.
 - use the documented Assisted-by: LLM form.

 drivers/net/vxlan/vxlan_vnifilter.c | 53 ++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 5 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index 7e8abc55ef53..9cc932c6177d 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -473,6 +473,7 @@ static const struct nla_policy vni_filter_policy[VXLAN_VNIFILTER_MAX + 1] = {
 static int vxlan_update_default_fdb_entry(struct vxlan_dev *vxlan, __be32 vni,
 					  union vxlan_addr *old_remote_ip,
 					  union vxlan_addr *remote_ip,
+					  bool *fdb_created,
 					  struct netlink_ext_ack *extack)
 {
 	struct vxlan_rdst *dst = &vxlan->default_dst;
@@ -488,7 +489,8 @@ static int vxlan_update_default_fdb_entry(struct vxlan_dev *vxlan, __be32 vni,
 				       vni,
 				       vni,
 				       dst->remote_ifindex,
-				       NTF_SELF, 0, true, NULL, extack);
+				       NTF_SELF, 0, true, fdb_created,
+				       extack);
 		if (err) {
 			spin_unlock_bh(&vxlan->hash_lock);
 			return err;
@@ -512,6 +514,7 @@ static int vxlan_vni_update_group(struct vxlan_dev *vxlan,
 				  struct vxlan_vni_node *vninode,
 				  union vxlan_addr *group,
 				  bool create, bool *changed,
+				  bool *fdb_created,
 				  struct netlink_ext_ack *extack)
 {
 	struct vxlan_net *vn = net_generic(vxlan->net, vxlan_net_id);
@@ -545,7 +548,7 @@ static int vxlan_vni_update_group(struct vxlan_dev *vxlan,
 		return 0;
 
 	ret = vxlan_update_default_fdb_entry(vxlan, vninode->vni,
-					     oldrip, newrip,
+					     oldrip, newrip, fdb_created,
 					     extack);
 	if (ret)
 		goto out;
@@ -599,7 +602,7 @@ int vxlan_vnilist_update_group(struct vxlan_dev *vxlan,
 			ret = vxlan_update_default_fdb_entry(vxlan, vent->vni,
 							     old_remote_ip,
 							     new_remote_ip,
-							     extack);
+							     NULL, extack);
 			if (ret)
 				return ret;
 		}
@@ -655,7 +658,7 @@ static int vxlan_vni_update(struct vxlan_dev *vxlan,
 		return 0;
 
 	ret = vxlan_vni_update_group(vxlan, vninode, group, false, changed,
-				     extack);
+				     NULL, extack);
 	if (ret)
 		return ret;
 
@@ -718,6 +721,8 @@ static void vxlan_vni_free(struct vxlan_vni_node *vninode)
 	kfree(vninode);
 }
 
+static void vxlan_vni_node_rcu_free(struct rcu_head *rcu);
+
 static int vxlan_vni_add(struct vxlan_dev *vxlan,
 			 struct vxlan_vni_group *vg,
 			 u32 vni, union vxlan_addr *group,
@@ -725,6 +730,7 @@ static int vxlan_vni_add(struct vxlan_dev *vxlan,
 {
 	struct vxlan_vni_node *vninode;
 	__be32 v = cpu_to_be32(vni);
+	bool fdb_created = false;
 	bool changed = false;
 	int err = 0;
 
@@ -755,10 +761,47 @@ static int vxlan_vni_add(struct vxlan_dev *vxlan,
 		vxlan_vs_add_del_vninode(vxlan, vninode, false);
 
 	err = vxlan_vni_update_group(vxlan, vninode, group, true, &changed,
-				     extack);
+				     &fdb_created, extack);
+	if (err)
+		goto err_vni_del;
 
 	vxlan_vnifilter_notify(vxlan, vninode, RTM_NEWTUNNEL);
 
+	return 0;
+
+err_vni_del:
+	/* Undo only the default FDB entry this add installed.  An entry that
+	 * was already there, whether added out of band or by another VNI, is
+	 * left alone.
+	 *
+	 * No membership has to be given back: vxlan_igmp_leave() is gated on
+	 * vxlan_addr_multicast(&old_remote_ip), and old_remote_ip is a copy
+	 * of the remote IP of a node this add just allocated, so it is zero.
+	 *
+	 * The address picked below is the one the entry was installed
+	 * against.  If the request carried a group, vxlan_vni_update_group()
+	 * copied it into vninode->remote_ip before the join could fail; if
+	 * it did not, that copy was skipped and the entry went to the device
+	 * default.
+	 */
+	if (fdb_created) {
+		union vxlan_addr *rip = vxlan_addr_any(&vninode->remote_ip) ?
+					&vxlan->default_dst.remote_ip :
+					&vninode->remote_ip;
+
+		spin_lock_bh(&vxlan->hash_lock);
+		__vxlan_fdb_delete(vxlan, all_zeros_mac, *rip,
+				   vxlan->cfg.dst_port, vninode->vni,
+				   vninode->vni,
+				   vxlan->default_dst.remote_ifindex, true);
+		spin_unlock_bh(&vxlan->hash_lock);
+	}
+	rhashtable_remove_fast(&vg->vni_hash, &vninode->vnode,
+			       vxlan_vni_rht_params);
+	__vxlan_vni_del_list(vg, vninode);
+	if (vxlan->dev->flags & IFF_UP)
+		vxlan_vs_add_del_vninode(vxlan, vninode, true);
+	call_rcu(&vninode->rcu, vxlan_vni_node_rcu_free);
 	return err;
 }
 
-- 
2.53.0

