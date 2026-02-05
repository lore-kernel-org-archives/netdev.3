Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328DA24A04A
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770298798; cv=none; b=PXsKV8Scvyv1DtFva7D466HgDtZipVo3cMvH3GAIvAjMBKDVR3g1we9uVZYsi4zpVvBX7sUSPAkBGP6W1V8GkK6eG5TGobaNKySHjY0dt3a3trDMuEjI8B17UbAin10ZPikWzZVRHGceYtjjicNsGo03BM1PWBsEiS2tf/FP0tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770298798; c=relaxed/simple;
	bh=DiK3AERHYiJWeSipUtYpdQ8NPJTIs1wQ8/VYX9MhsII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UcT/pb7R/ET01+mc954rZKffHHwdW3n+H6pnMk0+WRlXH9V8DRMuS6PmwUERWgg0E0TdvnwqEhlFs+fDElhzSGmiJCdbuEQeE0ZPg1K43QHyhUf+TKQwky0LvQ+GyVzqTsGQvqGoUTmKZE6b1XhBK5wq/z2Z4uTOo/DF1Tv6eGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=T5DwhB2c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oMO/8Amb; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="T5DwhB2c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oMO/8Amb"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3903B7A016A;
	Thu,  5 Feb 2026 08:39:57 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 05 Feb 2026 08:39:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1770298797; x=
	1770385197; bh=5l8zGgcM53WRqArqgDXrrgU1MKDYoqcb+hA8zMlJ/fY=; b=T
	5DwhB2cMFM11U/nezdmkrrhE1S/AaAGSbZRbsYWdNbeYHOIgphLhkFLK1a1q8jDC
	01qhlMrXa0dy3o3YkWwsC0DuFd05OH9+Rspj3BcAu43s8vDbADfGVq5h8xwolAgW
	hnLgtevZ5pYn/PIMmhhGCXQg9djuNLeVtjBSuWr6TYBTdB27hS2Z75DvQ3PRFfhl
	yzdOKFKtO6rw8Z32VDZYnPkn6q5ZaN5U3RMqVdvAlIB4TkxeaydA1ZnINzNKW80Z
	/g0Zw3C3PK1fEgOGS8lSCtC6CJcyYWCsqyOi4qTf5kwaJXfzK74IStud2insxcrH
	ydYyVy8K5+5aruqZZh4nA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770298797; x=1770385197; bh=5
	l8zGgcM53WRqArqgDXrrgU1MKDYoqcb+hA8zMlJ/fY=; b=oMO/8Ambb+fmTvIKp
	6JX6qB5Jt+Y63QHi7RF03b06wrldg5law62lczi4viXoEsxPTs9+TEaez28mCH92
	8a1EeiutQJfpIOeUz3cZdDlh2A+shUATTu+ohFSioaqo7C+Bw1Tcj6n4/P3wirTM
	AMRNmltl0OS4K4lCPSSuyO+NDPIykqWv0ct0CzuOjkVmMUyqsmNSoiXH0gWrGJIT
	BLStefsoLztxq6Z/S4vhdG4BOQMmjpBqYc1CrMF3mBU6DbGDX4VZxPntI8dXCv9T
	6KFsiXG70z28HaB5g6uIhfWY7T8s6yTyVtRRq1olHRB5xb9pQBVQJgQ6LdJ0EnIe
	4XAbg==
X-ME-Sender: <xms:rJ2EaZg2bLpcvz5JEeHkXZ_hgPsR2t5MmcZeY0CVa_3G803t2AwjpQ>
    <xme:rJ2EaUZNqg8momp-XPcim-szNKkOjflImOUBjW-Ll85r1q-WUvJP-6kQBv1iI8k4G
    i7Bs10cxXag1EJ0HuJbqwmrYMchyTXXMcS2Q5sQLdo8mWnGOO3sfVE>
X-ME-Received: <xmr:rJ2EaVXsZxqBQsa8L5u5MUbKmuqqntMqDWJBKnavnYw-FwB7v6ZGEWBf6B1BbMjs_PEePA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeehgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrd
    himheqnecuggftrfgrthhtvghrnhepteffleejfedvhfehieejlefgkeeljeevueeggeev
    tefhgfeuhfduffegkedvtddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrghilhdrihhmpdhn
    sggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnh
    hivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhesuggrvhgv
    mhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggs
    vghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigihhnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgv
    lhesghhmrghilhdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:rJ2EacGdXZY6Qkh5c73aM_0cQAOvjWjFUl2bwRL9nHOAByuYdZjXcQ>
    <xmx:rJ2EafabbYbfTPv4hxMNH0N3bylir13y-5Bkvzi8fM0gNQryqAaBog>
    <xmx:rJ2EabG3PN-M8iK19MKGQU4EhTeW0XvgddrmnBDwAjEgPcpRkHKdAw>
    <xmx:rJ2EaV0f_egVJ1rzE93FaqmLBv23oDvUSBG45sFllLfpSUcZht9aig>
    <xmx:rZ2Eaed8MaWIJiCMDd3S9yqoKLKhTowcSGHvhbsS2Wfc7afp4oUAF3n7>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 08:39:56 -0500 (EST)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net-next v5 07/12] ice: Remove jumbo_remove step from TX path
Date: Thu,  5 Feb 2026 15:39:20 +0200
Message-ID: <20260205133925.526371-8-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260205133925.526371-1-alice.kernel@fastmail.im>
References: <20260205133925.526371-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alice Mikityanska <alice@isovalent.com>

Now that the kernel doesn't insert HBH for BIG TCP IPv6 packets, remove
unnecessary steps from the ice TX path, that used to check and remove
HBH.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 396326a6d5be..6fa201a14f51 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -2156,9 +2156,6 @@ ice_xmit_frame_ring(struct sk_buff *skb, struct ice_tx_ring *tx_ring)
 
 	ice_trace(xmit_frame_ring, tx_ring, skb);
 
-	if (unlikely(ipv6_hopopt_jumbo_remove(skb)))
-		goto out_drop;
-
 	count = ice_xmit_desc_count(skb);
 	if (ice_chk_linearize(skb, count)) {
 		if (__skb_linearize(skb))
-- 
2.52.0

