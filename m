Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCA92E1F06
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 11:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785585009; cv=none; b=aCU91bDsGcPTpAbI706a4IpDtGbn9gbGUhDvYve25KxnvdM6rfxVlfEfpctplOz/RvveIvry2uII+v9Ne8xjp0+zxJzS3aWeuKCSxMoYgCTXTaQ7pmCbDzOtTAL+Qy0JI1DZn0J8VAQVhBm5RX9srSIYldfme7X0Ep4GkzJ1qz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785585009; c=relaxed/simple;
	bh=GZTIKKl6UdIOedEDI8ahlfygs4bDLFNB+TldskUuKtU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uCJXa5o6N+fow6133SCnBRFGrsgXc6IlS0/tpHqhnt6TNQHEJUNwg6zuytPtzQOdbfSoyz1mC5si+JOQcK4HWh8HfeALTah4aimk64Tn0F77fp3UFTPx5tFufvjQaUmgT5h2YRNROaoPMIRHqyc7jzDVEYcqAy2YbpJkSjn6xzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROIXq89r; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROIXq89r"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b2a8e4c77eso1866184e87.1
        for <netdev@vger.kernel.org>; Sat, 01 Aug 2026 04:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785585006; x=1786189806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pQtmovRllX2fB1npPmoV718rgWYferS7+ilcZezJvdA=;
        b=ROIXq89rAjdUFRXltGQtXLwuhvCH8UHAkyxXgD6/L5F7Cq68Y4NK/0/OAeAy5D6iC8
         kHPBGw/tya28GnJCkT+M+ys+C5gmdcpIjPIxPl4Fd5+x+FaAiF4AKAg/AWkOTMiQp/F8
         OAit4GbSIgXS1iXZDl0XViza29h3/YqcDTTitGEiwqGagFVFwF7cdi6UCAC2/5wB1qZh
         VC/5Wo9wtHt74jOMuRZ18pSm8YtfagtpTfHgla1XC3n4eno3TWDroQeTsZRfBzXYpXKT
         ZedfbMXVlAlj90kvx7emABcAaiIlFYROloAIM6tuHvmwfIGymiGaxT6LWYJT8aZ1Pj3E
         QtWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785585006; x=1786189806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pQtmovRllX2fB1npPmoV718rgWYferS7+ilcZezJvdA=;
        b=GlYNZMZMYszphOKvMhwEnUFRw3rHuu4BqljUAkXZPlkrVCPVwKyr2y0ReuD4oBEN+K
         AruMYy217SzYguMYlN1++mzYfr3LZcs/Khnjp1EuJxIMiztLIimCVl2mIMdwBOajsYB7
         Ow1DsDZKPsxokmhiY2Qal7RSSNwxj5pGLR0sz7YXKQyHkf+D98nvbYt5dL7WMyeH8Qjp
         ywsc57xGLulPsNViUmHuyXgXUUBPTBvu1OfvqIpbwU9i6Ifvg7GgctMRVTy3+mCg0bNV
         4Jjkabenz++Shf/97UP1cvpkkrdKQK05yG9PUnZ3aHZPEeKbI7c3NFB8yej34iDawiWJ
         thPg==
X-Gm-Message-State: AOJu0YxGzcQ+XiZ/cGwyEPd10VZCEFy/Y+zm+l7MVgmlruNu6R8RqUGd
	Pk77+W4UAKf3ZQZ0SfDMnT1NcG6oHFKKEC+xu3G9N9yi5ySZFgEbV29ev1uvXw==
X-Gm-Gg: AR+sD11R+WGYPDhR4j5z7umMlxczm5qkuTEn7I38Usvrm60MuBSQ/+ts2WDbrzOgl2R
	T4KtMMA83tciZR7BQOTGuUz/XJcR4b5gTvud59aw4uSkZeHkbqWKEDC13DPCL6pOVeVF6OZGROE
	xmr95Qjh2SkiXj2JF1/R3JsaXPNg/quYb8UoSuUg/OIFcjBxp1518qEDCIsn+qB78eqXRygwLM6
	UiSjg0jEHaIwzJsSGLyFH06Aw4HZfJKT/h2+crT16uNnet/fG8hUqEGW0fX4u8wC35kuSNzg29d
	Q4rqbMGTqDJYXZZgEeSmvwxsFG2YjMqh5l/rQkVNTS1mHDKzzALbhkIC2jgQlGcfkxncsxUp5OB
	f4yR55VH0qqObgXGcbj/N9CIKvZX60ddgIcmyPhEwyabVqLAOMoNMgjW4CjXDaJfHE80KhvsNMI
	3qcGqKbyqKfJaYftjz4lEMvg+RFuMFtuL9XVD07F8yB7m830WHu6Tt2ybQbxBsIYJ/qeXkMq6SU
	6Dsx3aLrkGfTuNGqb4PE+72TCwuQtiMDpkvh4cuIqnSUOT2P+/UcNjgjkSA2O564mkw
X-Received: by 2002:a05:6512:3f8:b0:5ae:b75e:454d with SMTP id 2adb3069b0e04-5b2e4f80129mr468437e87.45.1785585005574;
        Sat, 01 Aug 2026 04:50:05 -0700 (PDT)
Received: from localhost.localdomain (46-138-176-102.dynamic.spd-mgts.ru. [46.138.176.102])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2e2441e71sm886919e87.41.2026.08.01.04.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 04:50:05 -0700 (PDT)
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
Subject: [PATCH net-next v3] rtnetlink: cap IFLA_VFINFO_LIST at a documented number of VFs
Date: Sat,  1 Aug 2026 14:49:44 +0300
Message-ID: <20260801114944.115272-1-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
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
bytes is written truncated modulo 65536. The list dates back to commit
c02db8c6290b ("rtnetlink: make SR-IOV VF interface symmetric") in 2010
and has never been able to describe an arbitrary number of VFs; nothing
regressed, the encoding simply cannot represent it.

Nothing catches it on the way. if_nlmsg_size() adds rtnl_vfinfo_size()
for every VF, so the skb really is large enough and none of the nla_put()
calls fails. Userspace then walks the message with RTA_NEXT(), which
advances by the stored length, so parsing resumes inside VF payload and
the attributes after the nest are read out of VF data: IFLA_VF_PORTS,
IFLA_XDP, IFLA_LINKINFO, IFLA_PERM_ADDRESS, IFLA_AF_SPEC. iproute2
prints "!!!Deficit" and strictly validating parsers reject the message.
On CONFIG_DEBUG_NET kernels nla_nest_end() also splats, via the
DEBUG_NET_WARN_ON_ONCE() added in commit ff205bf8c554 ("netlink: add one
debug check in nla_nest_end()").

Where the wrap falls depends on what was asked for and on the host. A VF
costs 196 bytes, 296 with statistics, 236 with GUIDs and 336 with both,
and on a kernel without CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS the
statistics carry a padding attribute each and cost 32 bytes more, making
those two 328 and 368. The nest therefore overflows somewhere between 179
and 335 VFs, and ice allows 256 per PF (ICE_MAX_SRIOV_VFS), which reaches
it. Statistics are included unless the request sets
RTEXT_FILTER_SKIP_STATS, so the common case is the one that wraps first.

A limit that moves with the requested attribute set and with the host's
alignment requirements is not something userspace can be told, so use
fixed numbers instead and document them as what the interface supports:
256 VFs, or 128 when statistics are included. Both stay well inside
U16_MAX even in the largest per-VF encoding, at 60416 and 47104 bytes
respectively. rtnl_vfinfo_cap() applies the cap in both places, so
rtnl_vfinfo_size() does not size the skb for VFs that will not be
emitted.

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
v3:
 - dropped the two defines for the literals and folded the min() into the
   helper, which takes the real VF count now and is renamed
   rtnl_vfinfo_cap(); the comment describes the helper (Jakub)
 - changelog names the commit the list came from, without a Fixes: tag
   (Jacob)
 - fixed the citation for the nla_nest_end() debug check, which came from
   ff205bf8c554 and not from the nla_nest_end_safe() commit
v2: https://lore.kernel.org/netdev/20260730090700.65867-1-iprintercanon@gmail.com/
v1: https://lore.kernel.org/netdev/20260725132236.88318-1-iprintercanon@gmail.com/

 Documentation/netlink/specs/rt-link.yaml |  5 +++++
 net/core/rtnetlink.c                     | 22 +++++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

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
index 31c65a545a107..81c5a6104dea1 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1174,12 +1174,27 @@ static void copy_rtnl_link_stats(struct rtnl_link_stats *a,
 	a->rx_nohandler = b->rx_nohandler;
 }
 
+/* Cap the number of VFs that IFLA_VFINFO_LIST describes. The nest is one
+ * netlink attribute, so everything inside it has to fit in the u16 nla_len.
+ * The cap is a fixed number rather than whatever happens to fit, so that the
+ * limit is a property of the interface instead of one of the requested
+ * attribute set and the host's alignment requirements. The largest per-VF
+ * encoding is 368 bytes with statistics and GUIDs and 236 bytes without
+ * statistics, so both values keep the nest well inside U16_MAX.
+ */
+static int rtnl_vfinfo_cap(int num_vfs, u32 ext_filter_mask)
+{
+	return min(num_vfs,
+		   ext_filter_mask & RTEXT_FILTER_SKIP_STATS ? 256 : 128);
+}
+
 /* All VF info */
 static inline int rtnl_vfinfo_size(const struct net_device *dev,
 				   u32 ext_filter_mask)
 {
 	if (dev->dev.parent && (ext_filter_mask & RTEXT_FILTER_VF)) {
-		int num_vfs = dev_num_vf(dev->dev.parent);
+		int num_vfs = rtnl_vfinfo_cap(dev_num_vf(dev->dev.parent),
+					      ext_filter_mask);
 		size_t size = nla_total_size(0);
 		size += num_vfs *
 			(nla_total_size(0) +
@@ -1717,6 +1732,11 @@ static noinline_for_stack int rtnl_fill_vf(struct sk_buff *skb,
 	if (!vfinfo)
 		return -EMSGSIZE;
 
+	/* IFLA_NUM_VF above stays the device's VF count; the list itself is
+	 * capped so that its length cannot overflow nla_len.
+	 */
+	num_vfs = rtnl_vfinfo_cap(num_vfs, ext_filter_mask);
+
 	for (i = 0; i < num_vfs; i++) {
 		if (rtnl_fill_vfinfo(skb, dev, i, ext_filter_mask)) {
 			nla_nest_cancel(skb, vfinfo);

base-commit: 69963a0678a347d57c4ac8b16939dba216eb95ce
-- 
2.43.0

