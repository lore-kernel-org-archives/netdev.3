Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550DB39936D
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 05:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786599693; cv=none; b=bgcUeDu4CpL4o/i06imNS7r6+fKuZ0M+1Otz1cZftc6QmMWfNwZU3tGrWka7COMsZzx6TxwB0+QjjPg48wOsbw0jY4c0981Qrkr+ezsFqthu/Tmr+GJF4d/ZSY7tcvD94o25JC8OfdXcPWe2GfsWudKj1MLawBCJ0KQM245DVd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786599693; c=relaxed/simple;
	bh=FKWNBQ4L3P5B+nymClhtBWp5DG9BL1EK4lUObCqDNXw=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=XgpLUX6fvKKHuP22BdmUUlbOmJOnbjZ189jaqAKbJLB0V510hHmYf3or152DOl2Mfd3ExcpOLTSJVjXY/oBGD9OTdz0o9aFhsWTVPs+rT6gRyGLKZW3h1BblMMJgFCK7TB9fUwltdQVhvr3l/iw+ZH0mKoT3uDqjLQXrilmbIck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=WPwGfAMH; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="WPwGfAMH"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4996f1ee4a4so10635715e9.2
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 22:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1786599689; x=1787204489; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vd1ZVm9SVNzR9kTZ02Ls9IMCoVG4jSJzXtyP5bkoQRw=;
        b=WPwGfAMHto9M0OX5KnFQzdJet29CY8wrUe7QTeDwu9qNq3SzPrfPDo8kQbaKHzKDQy
         OPjyKNd3gmdhdoLhg07DDp9L6ZsfkKs+YsQDjLB853DRRXi2jxxk0V/qxTNCoCaCwtdj
         BFewX8nQ/H/eKmAXsF/JdaC/PqqNzJS66k0cdKaFyW4VAHgrBvQQtgx2vb2OL/jn3yqK
         mvnGxFmsLZtQphnKUDzrXY+8Z2aijsLEh+ZnVKwEp305RN6ik5wagEvYzJA3PbzjWGrO
         t3lmbr8sN/uMaMYjqYbReFbKt9pSm60Joj03diJBGSGUzc3nZ4krec2scEbnDW+QmX82
         M6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786599689; x=1787204489;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vd1ZVm9SVNzR9kTZ02Ls9IMCoVG4jSJzXtyP5bkoQRw=;
        b=lwPJekzlrnFMUiuLnNpjVY62i5ZkDnYUtW/1zXbruuve1F/tAMvBwVAlEASiF6k16j
         pdgPeUeWMd7LG57BcX1qVOx8vHIT3KX3p7sWHXtmgiNozOTA9wXWzH3jWS9g4m7Xt2pp
         vwZGO0Biv/smvhx+lEjo6SxCsypQzJfeWfA5h7xudMxkhDB6s9v4D/vjIeZkb2jk7aFZ
         BnYEUcJ1oSOhdlfrxloBMgbuKX7bwn0WwB2lJK9IdafuO5K6onqtfdkfiwwqbZl77CiF
         JLlPh1v+WGikPnkbsNH8mlWD8Zeco3hCOjkvnmaYJKxE3jBQBLrf7boWXqgbFOmI/A1u
         0/Wg==
X-Gm-Message-State: AOJu0Yxc71GZOC7PC7QC0NZeB7l7cmjRmixLr8i9PethxxUS/2h0VDvW
	cq63PyrIyGv+wxBHg1/mAyvu/ZfksgtoJmOJoIIZii7igOU7dIPnxRHtOZbh7XT+WE20GvpGiey
	crvtHHO23EA==
X-Gm-Gg: AR+sD10rc/rAdQ/cPKl9137+DNe+zc4Bp19r0wfK8WtoheXCMbKXscDP+sD2IqgNOi4
	mQFmagTbuxsvhpG1TRDxMT0ei1NbUqi/4NQBOlhmKIaLKyHlACegnoqbaZLKL4Pmco6bQ+YrgAs
	g5PqcvYceXWmeiy/bTUm+lJnWPEFsBCN5Q3Ce/13+rpYRzyUiyyXhoNBLKZ2JHxXUAiliCAhc/c
	UAiSspVFpnuIW7BpSF5Axq1Z8NADyCTEx4Q9yRXV6IIlk8iTKa2L1QnDY7mAzUL43kyZ2uG5lli
	M4Bkynbio1Jx1bQFihCjODTiDkRner5sj6XLlBijwImiftg+irwbeJ9rHN2EPyDgb0DUWzlNt2I
	DfENgBzmkNeKawUx2mT5o0iDIdsqL3PZ8CyfzfUa88UH9AZxPT8NB4drqaae5soaVBghCTLXMDb
	D6vtX0Pd18qsYMgMEP8XpmRpX3mRePF1d/5fOd6PM+XHrMTlEUL97nM+4mIDoKVpcMveBPuRYAR
	PNsIm8/ckO/yUfmmUFQP+XCJd1pfDKiBnfXOgN019UJqQKfzSGCnWGw0NcBR6IvZPClDdUCFTTG
	+1tlBwYmWVq9YLtH/MIAUg==
X-Received: by 2002:a05:600c:4584:b0:496:bffb:fb7b with SMTP id 5b1f17b1804b1-499821c680amr25867245e9.10.1786599689499;
        Wed, 12 Aug 2026 22:41:29 -0700 (PDT)
Received: from smtpclient.apple (ip-88-212-19-42.antik.sk. [88.212.19.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981b6abbcsm39097775e9.15.2026.08.12.22.41.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Aug 2026 22:41:28 -0700 (PDT)
From: Norbert Szetei <norbert@doyensec.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: [PATCH net 0/2] net: don't strip zerocopy frag markers from a
 forwarded skb
Message-Id: <8063260C-05C9-4997-B9B6-2135063C4858@doyensec.com>
Date: Thu, 13 Aug 2026 07:41:17 +0200
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Kuan-Ting Chen <h3xrabbit@gmail.com>,
 Zoltan Kiss <zoltan.kiss@citrix.com>,
 dev@openvswitch.org,
 linux-kernel@vger.kernel.org
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81.1.4)

queue_userspace_packet() calls skb_tx_error() on the packet skb in its
error path, but it only borrows that skb: on the OVS_ACTION_ATTR_USERSPACE
action path do_execute_actions() ignores output_userspace()'s return value
and keeps forwarding the same skb through the flow's remaining actions.
skb_tx_error() completes the zerocopy uarg and clears SKBFL_ALL_ZEROCOPY,
and with it SKBFL_SHARED_FRAG.

For a MSG_ZEROCOPY skb carrying page-cache frags, SKBFL_SHARED_FRAG is
what makes esp_input() skb_cow_data() instead of taking the in-place AEAD
path. Once it is stripped, a later local ESP delivery decrypts in place
over pages the sender still shares with the page cache.

Patch 1 moves the skb_tx_error() into the one path that does drop the
packet, the "default" arm of ovs_dp_process_packet()'s switch(error).

Patch 2 removes a second such strip, in skb_zerocopy(), which calls
skb_tx_error() on its source when skb_orphan_frags() fails. A copy helper
should not perform a destructive action on its source, and both callers
already report the error on their own drop path. MSG_ZEROCOPY skbs cannot
reach that one -- SKBFL_DONT_ORPHAN makes skb_orphan_frags() return early
-- but producers that do not set that flag, such as af_packet's TX_RING
path, can.

Norbert Szetei (2):
  openvswitch: only skb_tx_error() a packet we are about to drop
  net: skbuff: don't skb_tx_error() the source skb in skb_zerocopy()

 net/core/skbuff.c          | 5 ++---
 net/openvswitch/datapath.c | 3 +--
 2 files changed, 3 insertions(+), 5 deletions(-)

-- 
2.55.0

