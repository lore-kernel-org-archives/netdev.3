Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794299484;
	b=TLYvdrg2pAm4AZ6srXn0BkwCQ9RzyjhTSprcOaxbjuQVQOYfG/rsBPSn0eUYTVxJlBhi
	 c0Dc4x4Ou5XF8SOnA37L6meF81jpPBHe8++u9CA3+QvrXIwhnFZ4YCnZh0lIKfNZEvjXA
	 YUpYuiBaznDY+B3/Fn2ML9DVjM/zDu+hx2xxERV9ojFqwEAPnT5vzoe1DPIiGEewNUN9c
	 f4wk2cwbkFBCglwXoWQ8qXy0AF1qbv2/gdqeAXrhHIEw5EpeEaoIVn9mVIhrVAXATiCKJ
	 dKT2gXR40JEqmrtEo2CV2PE7PvHMD040L4qftEmEgcsBHeouQsAXB2fd6wvsOeQ6haw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299484;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VHS9PME+lj3sobM0nuC4YjIOUceVBhWAlwGY7ffSBGc=;
	b=BTBWlW/9oTnJuj0zGBqUd9+wz36H4+v6vyt/OBfY3sWcJA+Gauf87/l8M7EVzIuRQLOb
	 Xc3DQXaba2RdGjLYMbUHNmrTXJtyOT1D9Bn2zOVInmHlmcFsYMOGywJ0FXXqcPzI9l5WL
	 NvtAc1LH0yN9yyYvC2O9C3riIywT/2VxxMu99Vpxc5TE0qPc1qPPcTK220XWzoTwmmMhT
	 OCbCllZRkpHblJNqiyg7xYwsKTSQ8L89+nggWBPitsuoJ3sKPb/phnwx35m7p5VGDOUCd
	 Ai8/3Y/KN1SHTnrD8aZcLODTKSFtXIeqh6rh5+D4dcD5UzdXiG4H6xphha9NwZ+Bgww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=IFwHx+tm;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B13606A31C;
	Tue, 10 Nov 2026 08:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0B13606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=IFwHx+tm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=IFwHx+tmQrcNrRL6FKEyzMhc5Oenr9Ply8PNTAAU0vfOt10CKaafguJHW2hycC+r46ubVjtSVvQtY
	 TLTQdGELmD3w0ZSbWI8sGjbGqjPepkLonbz8cDox5b8RcLcMU9tPMsP4wr26neMuPPgx2nu9bg3yiu
	 coz2Hyn4nPNzPOjU=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46af2d659e64-6cc7f;
	Tue, 10 Nov 2026 16:31:21 +0800 (CST)
X-RM-TRANSID:2ee46af2d659e64-6cc7f
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from openEuler-24.03.03 (unknown[74.82.203.40])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76af2d6503b8-ae19c;
	Tue, 10 Nov 2026 16:31:21 +0800 (CST)
X-RM-TRANSID:2ee76af2d6503b8-ae19c
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
Date: Wed, 11 Nov 2026 01:24:16 +0900
Message-ID: <20261110162418.28322-1-yanhaishuang@cmss.chinamobile.com>
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



