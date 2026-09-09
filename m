Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6913DDB1E
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 09:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946058; cv=none; b=dmA4t8bGB/13gUjpEX1QnkI2Snx71TJ9xJvKFtSoRHR0fIayxSeYmI1aPRl0AtKau4Dkv6g/85huKGkFdrqPhZEcifDZwyK0szRoDXBdBvqm8t1BkWorOyeWfnUFusa4tt5HyuXMzZEhhJmSa50wGAYB72hT3VrteJoENqc2L6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946058; c=relaxed/simple;
	bh=XNWBIph23mlpOAwkrFz2gQLEt8XxytxPsdwjkMDBWDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a5AUK1MTL/kRM3UwkCn/ockgGWdKj9l5wiqaaRKvwEnBwj8GUD/63AX/Btk3OViiw1cbE1qGr6ULrqI+wYIORNmiTQKIil/fm1UsADXw0TzTtrDnlcx4LIt61SYGjJ9o2aqjV3r1AIynjJBHt3xQyQW7XHkpin7n3fmimzDPvDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLCQggOf; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLCQggOf"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48441a2ba1bso4085461f8f.1
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 02:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788946050; x=1789550850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oIc+krKzuLe553b8U04qr19znUhU0RNHQaKuS2T3NkA=;
        b=PLCQggOfmgyok7dQwxkG1j49UZthq2o8Ic6mSzEu3xonOQSv9xc6y5vpnNnjru49JV
         Y+Lex9sAbEMLxTCdlAgDXDwCifkeF1ix7wIDpnKdPva2XLvXd3kxq5kMwDIrwm7Laq65
         DM4QcEY9hQa7Hnl+spthW1Ubj3LzQ0Pdkc5fF9ZY0533GFsHBWbwTGdF7nI7Xz+u6G1I
         DKNrVvYVikG5yighTN2Usli8wU+iQtZK/cdWWcc0AtnzbkOA0EENpZjByy/zFYLZdowo
         reqLdi0/8qqLxxP/9DHzaHVsxneAV5xQshiQkSoboNVhaqJ+tzaGlxneDvVhA/TF5Aw3
         xFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788946050; x=1789550850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oIc+krKzuLe553b8U04qr19znUhU0RNHQaKuS2T3NkA=;
        b=ac6ooHHE2pfg99vrTFrGEtxcQ+5rTw6mEBkjoVdvm3xgv036Jf43WTGyXkdahq3T+0
         w7/6Ac7oCVmZqga3RBy6Zknz+KMgvJIgUAnP+lVzYJGQRGxsjIqdXygTKkcoqgoGRcAK
         PK3RuF/2W0yX1HIa0zo5Y5DIa5YD+0tkBBCRVdfJtMjNdpMENNGI6zgPsFZrmyLYUJU0
         yo2Ssmx66zyskdha7T9U/DiyzgKcT3WnrC5BWelbXxObujpUEoR2Zd+f7HNvAoDvkcN0
         5/K09oE6ro1RkScWBsUnLMnFd0wdqPtCCCpbHVrqVr/fRtV6c8+Q6ri0LbZM075MCblV
         xLWQ==
X-Gm-Message-State: AFuF++lx93hjvc/7Vs9aw8EyK+smRjW64p061WXz/WtqqhcgXvVy9+T3
	IoXIuy6unCSREFu6441fkclgj5tEW8GUgIYQUgc1TaGLor5AAMf3R77JluNYhpA1TKU=
X-Gm-Gg: AYBFou0dKZfhiSqoHz7dEfhsQWgxaZxAoEPLz6b8jFI9wPkVC9S/3AQcxSoBtzBQ0lQ
	yzV0KPN0ZGXSdJoz6BDYUTq/TQHwS00LHah3mTM9eSz7To+TcWStuDRegdnxryL95V9BRdc3maw
	EWndRreqCeyApLLXJR5EHTp4LMu5RPXcAg8gVDkdsyChtAnOM+X48jMWwj1jrqBu8yU8T/T/r5x
	I+gV9mVxPb6SHzKuTL3aluKzE0SzwMoq/NfiEQeAJED9xQspgE+K8FPBJaAsE0XcFfRswEVu/14
	g7yT0sSIhSaQf+5UHmcsPugfTVgG35tcL52YyUy1qgMfw6hd9epuSBozl4EiLUNYZQMnps3CwC1
	2ldIunnDdwYkgWbwt0AfR7GcmuDvhJMmkc/AkzlpuEyrTu/qWcs7RzsLcsh6mFW7hR6OeQfXYEo
	4cdnPthc0Talcpfuxfh9zDHqf8e2KkWZ3ufB6+dkZavHEeEhwYkFWktjAjXAE12PNLQoH8m1hq/
	7D8lnHkiMkEFmY0BnegUNCmXP8LbcV0XxVa
X-Received: by 2002:a05:6000:18a9:b0:485:9211:6560 with SMTP id ffacd0b85a97d-485921165d7mr29788013f8f.25.1788946050163;
        Wed, 09 Sep 2026 02:27:30 -0700 (PDT)
Received: from kali ([169.224.126.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c074asm41558442f8f.23.2026.09.09.02.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:27:29 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	Ali Firas <alishmery18@gmail.com>
Subject: [PATCH net 2/3] vxlan: vnifilter: account VNI node and per-CPU stats to memcg
Date: Wed,  9 Sep 2026 12:26:44 +0300
Message-ID: <20260909092645.3105263-3-alishmery18@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909092645.3105263-1-alishmery18@gmail.com>
References: <20260907141001.GA708129@shredder>
 <20260909092645.3105263-1-alishmery18@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vxlan_vni_alloc() allocates a struct vxlan_vni_node and a per-CPU stats
block for every VNI, both with plain GFP_KERNEL. Neither carries
__GFP_ACCOUNT, so the memory is not charged to the cgroup of the process
that asked for it.

With the range of a single request now capped, one message can no longer
exhaust memory on its own. This is no longer the primary defence, but it
still matters: nothing limits how many capped requests a task may issue,
so an unprivileged user in a user+network namespace can still accumulate
an arbitrary number of VNIs, 4096 at a time, and none of it is charged
to them.

Per VNI the add path allocates 128 bytes of slab, an exact fit in
kmalloc-128 and measured at exactly 1.000 objects per VNI, plus 64 bytes
per possible CPU for the stats block. The per-CPU term is the one that
grows: 256 bytes per VNI on a 2-CPU host, but 4.2 KB per VNI on a
64-CPU one.

Charging both allocations confines the damage to the caller's cgroup.
The kill becomes CONSTRAINT_MEMCG with oom_memcg set to that cgroup,
memory.stat attributes both the slab and the percpu bytes to it, and the
host survives what previously took it down.

One limitation is worth stating plainly: try_charge() reclaims and then
invokes the memcg OOM killer rather than returning -ENOMEM, so the
request does not fail gracefully, the caller is killed. Accounting
confines the blast radius, it does not turn this into a clean error.

For a caller not under a memcg limit there is no change. With no limit
set, the same workload installs the same number of VNIs to within 0.4%,
fails at the same point, and a bounded add of 1,000,000 VNIs costs an
identical 128 bytes of slab and 64 bytes per CPU. The objects simply
move from kmalloc-128 to kmalloc-cg-128.

Conditions to recreate the bug:
- CONFIG_VXLAN, CONFIG_MEMCG.
- Unprivileged user in a fresh user+network namespace (unshare -Urn),
  or root with CAP_NET_ADMIN.
- Create a vnifilter-enabled vxlan device and add VNIs in a loop
  (e.g. ip link add vx0 type vxlan external vnifilter dstport 4789,
  then repeated bridge vni add ... commands) while watching a
  memcg-limited cgroup: system slab and percpu grow far faster than
  memory.current, pinning kernel memory outside memcg charging.

Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")
Assisted-by: LLM
Signed-off-by: Ali Firas <alishmery18@gmail.com>
---
 drivers/net/vxlan/vxlan_vnifilter.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index f18ce0e1e741..3d6718ec3f55 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -703,10 +703,11 @@ static struct vxlan_vni_node *vxlan_vni_alloc(struct vxlan_dev *vxlan,
 {
 	struct vxlan_vni_node *vninode;
 
-	vninode = kzalloc_obj(*vninode);
+	vninode = kzalloc_obj(*vninode, GFP_KERNEL_ACCOUNT);
 	if (!vninode)
 		return NULL;
-	vninode->stats = netdev_alloc_pcpu_stats(struct vxlan_vni_stats_pcpu);
+	vninode->stats = __netdev_alloc_pcpu_stats(struct vxlan_vni_stats_pcpu,
+						   GFP_KERNEL_ACCOUNT);
 	if (!vninode->stats) {
 		kfree(vninode);
 		return NULL;
-- 
2.53.0

