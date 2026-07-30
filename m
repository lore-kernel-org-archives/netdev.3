Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15EE3DB62D
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 09:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785402445; cv=none; b=Z+ZQ8z2MqnJ/W5pU8eohQFdJg/ffslBi9W74pQctWIfz9DyT2nqgWK9mjZy19hBRpoRTR/KF+tqOq3zdjPLgmjAGdMucg8B3CfrOFk+5BeCJ6kGqm1KHJE5+F+09GvxjskrOjNwKkUHCEjTebcBVgvMly+OnW3h73N7IAVXrWP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785402445; c=relaxed/simple;
	bh=oFUrZtRRNj2gTDkbGbXwoDomFxQzWtw5x1jET3rFJzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bm1ALMcLrVLQwmHFPRHLgIL2cmZ65FMrBhu6oMwh/QHgfL0gyRsMERYEfILN3LEtyOPXYBD6pIBHSalsS2UVIE7BtW0KvU3IPntoUr0FbgCLSzDIxltUnY/nQcW2wE0B91NtDBikchXiEhz4EDtZkYHFVbqL3wVULgCSegkbuXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3ZG3xnD; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3ZG3xnD"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39c9a3acd40so15554051fa.3
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 02:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785402442; x=1786007242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U0z4UuuolGvo1Tjv+Sep5cfV44lwXxHOj4UIRPkpfFM=;
        b=e3ZG3xnDcplUTV+enEuRZVRHR9X1MMVotyHRFLYNDtu3zZwqhyoOSURHr5pbcBBgwY
         dfCq4TSxzDGBHGLaKZelPKplPKP2rqu+Zg9xICl1xTKgH8MyL11SgU6jNe564KYKNsVo
         FjFq12vaw/Fi5NDPYkYEa/4NMCv6v7hyZLGjHcg3PDoYZr/52Uu3egCuPwp7JGh41PWm
         r6/CIieSenHciP2gDlc21e4OYOZEkcEfKSYhPwFykYyve+i+eCaM7Y6AU9CakcmXcZOd
         zKafwtbO5KYxKG2tSNs6rtZ+i+ol1aTdPVdChOxg8KDX8FP/DepQHLYcgCNpGyXlnqyk
         xIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785402442; x=1786007242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U0z4UuuolGvo1Tjv+Sep5cfV44lwXxHOj4UIRPkpfFM=;
        b=kCHHQ7WgTqW8aDelQiIxITcMelgJm9RkkiOcfNoOQ4FkbzSLQI4WAR+qUikcj6Ltxp
         dyXSAHDXWQgjxt6rkb0D0rO7MrhES0zTjhrlE2Cl60CbwXYjrIqmp5FC4a/glDxjtE5t
         ra4Om/3HjtC2qyAtGqDcFoHTKPLbU41ZlQ6er0bw/99KH4rrEdwaP+eXngSC8GCG6xF3
         IoDFpTTsZcReDdtNm+Oo9zn/yiMkgH88u8MbxauDyAm0VyE8K1d/7MTQp1oUtDUrZUfq
         dDwNqrnlocYMDqY+IrAsykvURNkL4uKHJafXf1+hblyHrhMK4ffkiv0kKU4FYsIxPQAW
         5cpw==
X-Gm-Message-State: AOJu0Ywks+HSV/Zgd3DbShH+hdTYMOdcoV7VcepS+3IJfQAjtsAeCZ//
	Pgr5l56JKcWPlM8/ACUdREOAIN2DFqdJN785DzedAkgHq7/hqiHOiIkxiypStg==
X-Gm-Gg: AR+sD10MYkhX0m+NA8+p5Qp934GDkmIHI/ZEloQb7mAp7SOtOmb38zQ0k7Xnzfbwms6
	D6cXadD+6xsfZ63xXwMHQJWTgaglb5tDHEBU4V1JgBZj8LN/QZkcp/VWWNr1bH2eJmg4IMqUwrX
	4NvTJjdOymHhhkPDUqFtth8lrcq+vcRz0fxCnGw3M+Z1SPriZU0iA/t55rWGwoMKcsA74QFgbeL
	Obc9pCBQk8F0+8hEpG1QoDwFpUJDAMJvcfFfDdR5ZuAnAB1R59xDDgyVqV6DfWJtwLJQqj4Xncs
	oqN/id7mpOXpGdribouU7O0kucm8SMCBvYagVmqCBd2wz3h47QmTHdhhU0Ou+jBW9dk/luJHxEL
	0lMIv5Pm/gk4NyiwDaOdxoN2MGN5dP705QrwUtvDelAHwOUH23DPfh5YAIoD4sLdKfsIB1jU9TQ
	skUlY/eMW75mDgCGH031tcAC2G1ecJzXxqKL2iltBQAzYQRY0v4N4TSt3F6OQnT7cF8f1FIGs9h
	0ZAsIaID6hRUUrSKSu+lxXSW06PSOtaf+KYU4TGobkJplFyfKDoKhBORtI=
X-Received: by 2002:a2e:be28:0:b0:39c:628c:15ec with SMTP id 38308e7fff4ca-39f6b8a6772mr3117331fa.23.1785402441658;
        Thu, 30 Jul 2026 02:07:21 -0700 (PDT)
Received: from localhost.localdomain (46-138-176-102.dynamic.spd-mgts.ru. [46.138.176.102])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39f6a598d87sm2015941fa.5.2026.07.30.02.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 02:07:21 -0700 (PDT)
From: Artem Lytkin <iprintercanon@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] rtnetlink: cap IFLA_VFINFO_LIST at a documented number of VFs
Date: Thu, 30 Jul 2026 12:07:00 +0300
Message-ID: <20260730090700.65867-1-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729185513.52564971@kernel.org>
References: <20260729185513.52564971@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rtnl_fill_vf() emits one IFLA_VF_INFO per VF into the IFLA_VFINFO_LIST
nest and closes it with nla_nest_end(), which stores the accumulated
length into nla_len. That field is a u16, so a nest larger than 65535
bytes is written truncated modulo 65536.

Nothing catches it on the way. if_nlmsg_size() adds rtnl_vfinfo_size()
for every VF, so the skb really is large enough and none of the nla_put()
calls fails. Userspace then walks the message with RTA_NEXT(), which
advances by the stored length, so parsing resumes inside VF payload and
the attributes after the nest are read out of VF data: IFLA_VF_PORTS,
IFLA_XDP, IFLA_LINKINFO, IFLA_PERM_ADDRESS, IFLA_AF_SPEC. iproute2
prints "!!!Deficit" and strictly validating parsers reject the message.
On CONFIG_DEBUG_NET kernels nla_nest_end() also splats, via the
DEBUG_NET_WARN_ON_ONCE() added in commit 1346586a9ac9 ("netlink: add a
nla_nest_end_safe() helper").

Where the wrap falls depends on what was asked for and on the host. A VF
costs 196 bytes, 296 with statistics, 236 with GUIDs and 336 with both.
On a kernel without CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS the statistics
carry a padding attribute each and cost 32 bytes more, which makes those
two 328 and 368. So the nest overflows somewhere between 179 and 335
VFs. ice allows 256 VFs per PF
(ICE_MAX_SRIOV_VFS), which reaches it. Statistics are included unless the
request sets RTEXT_FILTER_SKIP_STATS, so the common case is the one that
wraps first.

A limit that moves with the requested attribute set and with the host's
alignment requirements is not something userspace can be told, so use
fixed numbers instead and document them as what the interface supports:
256 VFs, or 128 when statistics are included. Both stay well inside
U16_MAX even in the largest per-VF encoding, at 60416 and 47104 bytes
respectively. rtnl_vfinfo_size() applies the same limit so that the skb
is not sized for VFs that will not be emitted.

A device with more VFs than the limit reports a shorter
IFLA_VFINFO_LIST. IFLA_NUM_VF keeps carrying the real count, and
everything after the nest stays parsable, which is the part that is
broken today. An empty nest is already emitted for a PF with no VFs, so a
list shorter than IFLA_NUM_VF is not a new encoding.

Returning -EMSGSIZE instead, which is what nla_nest_end_safe() would
give, is not an option here: a nest that does not fit in a u16 will not
fit in a retried skb either, so it would turn a link dump on such a
device into a hard failure.

The other large nests in rtnl_fill_ifinfo() were audited and cannot
overflow. IFLA_AF_SPEC is bounded by a handful of address families at
about a kilobyte each, and IFLA_VF_PORTS would need more than 560 VFs,
which no in-tree driver allows.

Reported-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://lore.kernel.org/netdev/16b289f6-b025-5dd3-443d-92d4c167e79c@intel.com/
Assisted-by: Claude:claude-fable-5
Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
v2:
 - cap at fixed limits, 256 VFs and 128 when statistics are included, and
   document them in the netlink spec, rather than dropping whichever VF
   happens not to fit (Jakub)
 - drop the Fixes: tag, this is a long standing limitation of the
   interface and not a regression (Jakub)
 - retarget net-next for the same reason
 - changelog: corrected the per-VF sizes, which mixed two configurations,
   and dropped IFLA_PROP_LIST from the list of attributes that follow the
   nest, since it is emitted before it
v1: https://lore.kernel.org/netdev/20260725132236.88318-1-iprintercanon@gmail.com/

 Documentation/netlink/specs/rt-link.yaml |  5 +++++
 net/core/rtnetlink.c                     | 25 +++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index 68c26a70bb649..b80c2ac3ac311 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -928,6 +928,11 @@ attribute-sets:
         name: vfinfo-list
         type: nest
         nested-attributes: vfinfo-list-attrs
+        doc: |
+          Per-VF details. The list holds at most 256 VFs, or 128 when
+          statistics are included, because it is one attribute and has to fit
+          in a u16 length. A device with more VFs than that reports a
+          truncated list; num-vf still carries the real count.
       -
         name: stats64
         type: binary
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 31c65a545a107..6395ea6701210 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1174,12 +1174,30 @@ static void copy_rtnl_link_stats(struct rtnl_link_stats *a,
 	a->rx_nohandler = b->rx_nohandler;
 }
 
+/* IFLA_VFINFO_LIST is one netlink attribute, so everything nested inside it
+ * has to fit in the u16 nla_len. Bound the number of VFs described there at a
+ * fixed value rather than at whatever happens to fit, so that the limit is a
+ * property of the interface instead of one of the requested attribute set and
+ * the host's alignment requirements. The largest per-VF encoding is 368 bytes
+ * with statistics and GUIDs and 236 bytes without statistics, so both limits
+ * keep the nest well inside U16_MAX.
+ */
+#define RTNL_VFINFO_MAX_VFS		256
+#define RTNL_VFINFO_MAX_VFS_STATS	128
+
+static int rtnl_vfinfo_max_vfs(u32 ext_filter_mask)
+{
+	return ext_filter_mask & RTEXT_FILTER_SKIP_STATS ?
+		RTNL_VFINFO_MAX_VFS : RTNL_VFINFO_MAX_VFS_STATS;
+}
+
 /* All VF info */
 static inline int rtnl_vfinfo_size(const struct net_device *dev,
 				   u32 ext_filter_mask)
 {
 	if (dev->dev.parent && (ext_filter_mask & RTEXT_FILTER_VF)) {
-		int num_vfs = dev_num_vf(dev->dev.parent);
+		int num_vfs = min(dev_num_vf(dev->dev.parent),
+				  rtnl_vfinfo_max_vfs(ext_filter_mask));
 		size_t size = nla_total_size(0);
 		size += num_vfs *
 			(nla_total_size(0) +
@@ -1717,6 +1735,11 @@ static noinline_for_stack int rtnl_fill_vf(struct sk_buff *skb,
 	if (!vfinfo)
 		return -EMSGSIZE;
 
+	/* IFLA_NUM_VF above stays the device's VF count; the list itself is
+	 * capped so that its length cannot overflow nla_len.
+	 */
+	num_vfs = min(num_vfs, rtnl_vfinfo_max_vfs(ext_filter_mask));
+
 	for (i = 0; i < num_vfs; i++) {
 		if (rtnl_fill_vfinfo(skb, dev, i, ext_filter_mask)) {
 			nla_nest_cancel(skb, vfinfo);

base-commit: bc03e080390a1b8dd6252b598aa5ec801fc5e13d
-- 
2.43.0

