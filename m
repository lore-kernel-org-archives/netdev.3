Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794297209;
	b=EGMfALqxikwABBhjW1zP7lV73foPnooL0RR8Boujje8sEPPn8TKYC74KQVDlsTXmvs9o
	 02Soa0HhlyY84hcjAmhGFRma8rQlNzY6eTES4PSQ37KwQAg1tts4Fo0We+Wbr+5U7yA0W
	 WJ+tp/uukCXV5e8GgCbUnPbp7aI+F2l1KS6lK6m+PhLQuzmIxvEBVjPMt/tPEiazHeUzk
	 dbKI060xj+pih16zKESBNMd481V3Qa6i9ryQoQkqWaCQhT/D0n8DuoJyJRI1cySYynkhr
	 Hh/NgMCjc7dl3p1Rrt5l3XsLy3u4U9bFwh95Rz6yzzRgSXBAAyXzxGP2BYf+fuYx9oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794297209;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VHS9PME+lj3sobM0nuC4YjIOUceVBhWAlwGY7ffSBGc=;
	b=qZJ1Bmg8bj6QEkl1xpNoIN9m3q3UZUQO73C3e9BFLxoW55ze7nMAa2eyKHPS8yTA/XG/
	 TOGjVHt0Xf06hFXprc9BpD4frxcb54JaBvMWS8Rfkr5zpv0R+5dVwYtBnKrV9Q+eIpAn5
	 uK+GG2rEdL7oy1FqdFZm/ORXxoa+4gEj9Em5ax76ij6nnmDzwnhdVh3wpS7PkKz7eMCnd
	 8mDNNB+8dgoNotoSTOJyD4L2kHywHz3TX/ESuNCAzLJQC/mSYsYH/y1azCCG762Z7Zf+U
	 LnmjAbKD3odNOv6rtW2AarAz8Du6L626n+qN5B5zRIKNJlHMtSSJvMYjwGEI3aKGucg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b="mW9Vdaz/";
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E8F606A334;
	Tue, 10 Nov 2026 07:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47E8F606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=mW9Vdaz/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=mW9Vdaz/XA64uN17RQ32bPeGIIjIymPZen9zbHpQhcnKphIVWNrXqQI87jol9aa9OHd/sDHIwLkU+
	 Q6Xsq3th3d78FGntJMNlfvXbJmenqhc1cpN2lLHKNEEz2WYpfu/KLrvZjzdV/ItPQe5NidzXQuJDvf
	 SsmfGU/4TrgYLW9c=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56af2cd76a68-c9fd9;
	Tue, 10 Nov 2026 15:53:26 +0800 (CST)
X-RM-TRANSID:2ee56af2cd76a68-c9fd9
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from openEuler-24.03.03 (unknown[74.82.203.40])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76af2cd6bd67-acb02;
	Tue, 10 Nov 2026 15:53:26 +0800 (CST)
X-RM-TRANSID:2ee76af2cd6bd67-acb02
From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: yanhaishuang@cmss.chinamobile.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	almasrymina@google.com,
	daniel@iogearbox.net,
	willemb@google.com,
	willemdebruijn.kernel@gmail.com,
	mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	narcisav.kernel@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/2] net: do not run out of frags in alloc_skb_with_frags()
Date: Wed, 11 Nov 2026 00:46:59 +0900
Message-ID: <20261110154701.26310-1-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

alloc_skb_with_frags() can fail with -ENOBUFS for a data_len that passed
its own size check: it splits the tail into one frag per bit set in its
page count, and when a high-order allocation fails it lowers the order
without checking that the frags left can still hold the rest. With
vhost-net + tun, a guest that sends a GSO packet above 64K can then make
the vhost worker retry that packet forever (100% CPU, device dead).
Patch 1 fixes both cases; patch 2 adds a KUnit test for the tail case.

The issues were found with the help of an AI coding assistant.

Changes in v2:
- Patch 1: also fix the fallback after a failed high-order allocation:
  only lower the order while the frags left can hold the rest, else
  retry the same order once with direct reclaim (reported by the netdev
  AI review of v1). Changelog and test notes updated, including fault
  injection results.
- Patch 1: reword the comment as suggested by Narcisa, and compute the
  page count with DIV_ROUND_UP() to keep the line within 80 columns.
- Patch 1: say in the changelog that this only fixes the frag accounting;
  larger frames failing in tun_alloc_skb() are a separate problem.
- Patch 2: skip the test instead of failing it when no order-3 page can
  be had, and name the fix by its subject. Dropped Narcisa's Reviewed-by
  since the test changed.

v1: https://lore.kernel.org/netdev/20261108100617.23840-1-yanhaishuang@cmss.chinamobile.com/

Haishuang Yan (2):
  net: do not run out of frags in alloc_skb_with_frags()
  net: add a KUnit test for the alloc_skb_with_frags() tail split

 net/core/net_test.c | 35 +++++++++++++++++++++++++++++++++++
 net/core/skbuff.c   | 30 ++++++++++++++++++++++++++++--
 2 files changed, 63 insertions(+), 2 deletions(-)


base-commit: a45dbf182137275f44ad7c8bc8acd23f7af6b2cf
-- 
2.43.0



