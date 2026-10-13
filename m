Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021003BBFB2
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 21:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791926362; cv=none; b=jauGTcWbieKxBDvP3cgTZOdGqWx2Oz32oFi+/On91J5OyOkONijtnHGctnyhhWO6xgDb7B4ue+9burL80uL57c+rmiPOW46uyOGlITMP4Lijq2dK88MwH+Dxut3/ZuuJvpaN31dxpiSOQn+nAxxNqMbeHIETp9OwjmjlcTa7LTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791926362; c=relaxed/simple;
	bh=1uNx9pzFaHS+zXAmCIRRbgV1JINcqDr9GCYtkIvBKVc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XbihA+qfKIMhpQ1W1jhvrNr0+uFzqi156bJKWN/qGIh1H6X1UMfFkUFfte9UpjGuA9K/Skr/xNZelCyBvQes4Svr+pJkynARR3poc5WN70ULMq2fAcK6MhG07iYslFuJlOWF1dHllc4ByrKpVwpNLQ/X/fDuUXgvF7YzNwcLbek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=DrusZRC1; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="DrusZRC1"
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DKWnZH1242603;
	Tue, 13 Oct 2026 14:19:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=1uNx9pzFaHS+zXAmCIRRbgV1JINcqDr9GCYtk
	IvBKVc=; b=DrusZRC1ckGm8kR+nCdOZRq8CflQer6XAIU9Pf5UzfIXohYIqslzb
	qCdQjPb+syWdrdF+WbF9J98/uZ/HVZ/RaPUeahQJU3I5bouTaoFIW/mrPWaTEXAk
	UNAZHAKkoGPaHki3ESKB2G0NPQk67/k3I3ChqZOJ2N8KUIabS6V7UM6QL4xZFNfd
	XP8Ko4A3MxxjgBcpU9dJmR70tobNp7NuJBQ/ogqfVo35IcOS6qNLemIlObkF+dQ1
	TSnYWMr6odwmE2b+SQ4C74QR4oCZsK1ajQUuXFUEXehv27XvS5lPN7pF2LLKIA7d
	HmO4SoTNPHCyb3Z8ECgJ9gkC1PY6jxj8Q==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4h9spysrqs-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 13 Oct 2026 14:19:12 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1b::2d) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.49; Tue, 13 Oct
 2026 21:19:11 +0000
From: Erfan Sharafzadeh <erfansh@meta.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <almasrymina@google.com>,
        <kaiyuanz@google.com>, <willemb@google.com>, <asml.silence@gmail.com>,
        <sdf@fomichev.me>, <bobbyeshleman@meta.com>
Subject: Re: [PATCH net] net: devmem: allow peer-to-peer dma-buf attach for bindings
Date: Tue, 13 Oct 2026 14:18:54 -0700
Message-ID: <20261013211854.2297826-1-erfansh@meta.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012170754.669462-1-erfansh@meta.com>
References: <20261012170754.669462-1-erfansh@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA4NCBTYWx0ZWRfX6IMfEooh2/Q/
 NRRWbO5dnnwCjdA6ygUmH1MwvJNLY3fbwpekqX2BaXBpRInSWpML2D08yGyptfa8k5jYzR69L+0
 RCrGwrAtGeQES6G//Qxop56HOWAxzY0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA4NCBTYWx0ZWRfXx072Aa0Vt5J7
 Zk50B6RWQLY5xIaQpuknQD0iGhZeNdQe4anBUGa9f4yYTslwDZrI3MPH9CcQcwUfz8rbfBqy/xK
 GMmpcBIybfrySsmkAum8kIMIW+iDyHVqIr4TV4OS8fzIjEeGTHK1BsmWm2tClp4GSO2Nd/BKOS7
 AcOLD4NC34BzH2/+lEI9FfMPq9LjIxuqhTG+80SVSck3ICLjS+xnzE4tc2Eo2rLq7zE3VQaA9qJ
 9RUEbsPHbn2povVm5PGzvT9Vtmh+NGyDY37kBovEKVP9AoMb0/4HFqUdcsaXuApK7i4qVY1cuaB
 NKEhyH1QD8JjSAhIcbuPt9jOdyB5g50520FDrXWzObripzGG47YV98AWqUAjkYYUUIMpRfuOY7n
 m2luLl5dVAV14m2s1FHi8OjiTvkkTUf/Nifv42d6/yqZfZiqaRdGb7EaNFUyxZR8ezm0XriX3nw
 flak0sZzExX3ukbwaMA==
X-Proofpoint-ORIG-GUID: ycrAQSYn_7RTgCO8qM_KFT_8OphMi_G6
X-Proofpoint-GUID: ycrAQSYn_7RTgCO8qM_KFT_8OphMi_G6
X-Authority-Analysis: v=2.4 cv=XYMcX455 c=1 sm=1 tr=0 ts=6acea050 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=wpfVPzegXHpEFt3DAXn9:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=QVyZS0C2BbivBtcjcHQA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01

Replying to the Sashiko AI review of this patch. Three of the five
points are addressed in v2, which targets net-next:
https://lore.kernel.org/netdev/20261013210954.2170175-1-erfansh@meta.com/

1. Fixes: tag on an enhancement

Agreed. The static attach is correct under the dma-buf contract, and
the patch relies on 575157b1b5fc and 609fc8766d68, so it must not go to
stable. v2 drops the Fixes: tag and targets net-next.

2. "fall back as before"

Agreed, that was too broad. With an exporter that pins in a single
placement, a later attachment that cannot do P2P can fail to pin a
buffer that a P2P binding has already pinned in device memory, as with
pinned RDMA umem. v2 states this limit in the commit message.

3. Uninterruptible fence wait

Agreed. v2 waits interruptibly, as dma_buf_map_attachment() does for
static attachments.

4. dma_buf_pin() on every bind of a userspace-supplied dma-buf

Bindings were already pinned for their lifetime before this patch:
dma_buf_map_attachment() pins static attachments through
dma_buf_pin_on_map() and unpins them at unmap. The patch keeps the same
lifetime and only lets the exporter choose device memory. The amount is
bounded by what the user can allocate from the exporter in the first
place, and it is the same model as pinned RDMA umem. Whether BIND_TX
should require CAP_NET_ADMIN, as BIND_RX does, is a separate,
pre-existing question.

5. P2P bus addresses and no revocation

The binding is non-revocable, like ib_umem_dmabuf_attach_pinned_ops.
Devmem has no way to tear down a live binding today, since page_pool
and in-flight skbs hold references to it. Supporting revocable
bindings would be a separate change; v2 notes the limit in the commit
message.

pw-bot: cr
