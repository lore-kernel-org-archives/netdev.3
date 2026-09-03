Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF5441D4D6
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 08:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423566; cv=none; b=K8QGVJWHfxnsJ4cvOjXKU41YDMCGoTOjj8VZpeyjRqHekmWhwDhMVakAQ1B0FV33IWufBEWXwcdEaG+JeLnz5OFYZQHe2irytrfDJUyS6cABtI/i/6BBKLxroNyMrYN3M3kFU34P4ZV1/hZfDMJUXUHMBVTqGbNPN+XaHvNN6Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423566; c=relaxed/simple;
	bh=RiFy5vnSzzozta+uWSFt5ZQr3vwE2SgtoAJDzWqi9kg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BTXniCZy8XuuvhGIRPj1O8ZAD1vrCfWJk5FnItyL4NUTpaHAMsXAx+oH1Qdw1vIndWmpDdclJ3JXtWxZNBrkadgM1CE+b/1fmDel9nSOZILF0tZhO9qwXLCYTYPgIuWHgA3ibWCZ1i9D4TpCts7S/9VhAUf2HjE3QbwFBPIwBvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UoS+MzVC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UoS+MzVC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788423562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZG07PiR01c+3MJ74XIVRkMxGArX2wQLveIT4kI1ZVP0=;
	b=UoS+MzVCpCqWcphJ6RAFIBDBF/fiyAyLZ+iyX5QMVZZ4uUizcwq6sbVPpB4F7LkdIfn+1N
	She/RMRQCmJPCeYEyoApJOE3/T4ZyPSIELBrCFosU7gGk2gpTGFAMKOvA47v6V3utWD0zG
	/Ho4FPZ4OFW0pJnORwNBm3LSCg3RBAE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-eBMGjL86OByk7EXTkNljlg-1; Thu,
 03 Sep 2026 04:19:21 -0400
X-MC-Unique: eBMGjL86OByk7EXTkNljlg-1
X-Mimecast-MFC-AGG-ID: eBMGjL86OByk7EXTkNljlg_1788423559
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 45663195DE7B;
	Thu,  3 Sep 2026 08:19:19 +0000 (UTC)
Received: from ebuild.chome (unknown [10.44.32.224])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E79B83000223;
	Thu,  3 Sep 2026 08:19:15 +0000 (UTC)
From: Eelco Chaudron <echaudro@redhat.com>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,
	aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	cpp.code.lv@gmail.com
Subject: [PATCH net] openvswitch: fix wrong flag value in get_ipv6_ext_hdrs()
Date: Thu,  3 Sep 2026 10:18:59 +0200
Message-ID: <d42d6f04596dacab6cabfb1f06aaf4bd53394d3d.1788423539.git.echaudro@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The ESP and AH cases in get_ipv6_ext_hdrs() used IPPROTO_FRAGMENT
instead of OFPIEH12_FRAG when checking for out-of-order extension
headers, causing the fragment header to not be recognised as a valid
predecessor.

Fixes: 28a3f0601727 ("net: openvswitch: IPv6: Add IPv6 extension header support")
Reported-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Eelco Chaudron <echaudro@redhat.com>
---
 net/openvswitch/flow.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
index 46c1d66aad8c..868d9fdf3afd 100644
--- a/net/openvswitch/flow.c
+++ b/net/openvswitch/flow.c
@@ -288,7 +288,7 @@ static void get_ipv6_ext_hdrs(struct sk_buff *skb, struct ipv6hdr *nh,
 			if (*ext_hdrs & OFPIEH12_ESP)
 				*ext_hdrs |= OFPIEH12_UNREP;
 			if ((*ext_hdrs & ~(OFPIEH12_HOP | OFPIEH12_DEST |
-					   OFPIEH12_ROUTER | IPPROTO_FRAGMENT |
+					   OFPIEH12_ROUTER | OFPIEH12_FRAG |
 					   OFPIEH12_AUTH | OFPIEH12_UNREP)) ||
 			    dest_options_header_count >= 2) {
 				*ext_hdrs |= OFPIEH12_UNSEQ;
@@ -301,7 +301,7 @@ static void get_ipv6_ext_hdrs(struct sk_buff *skb, struct ipv6hdr *nh,
 				*ext_hdrs |= OFPIEH12_UNREP;
 			if ((*ext_hdrs &
 			     ~(OFPIEH12_HOP | OFPIEH12_DEST | OFPIEH12_ROUTER |
-			       IPPROTO_FRAGMENT | OFPIEH12_UNREP)) ||
+			       OFPIEH12_FRAG | OFPIEH12_UNREP)) ||
 			    dest_options_header_count >= 2) {
 				*ext_hdrs |= OFPIEH12_UNSEQ;
 			}
-- 
2.54.0

