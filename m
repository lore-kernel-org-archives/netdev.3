Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EA25111B4;
	Mon,  7 Sep 2026 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788799716; cv=none; b=L8R/ABs4mjNRXoHbz6Tn4IVjABh5ySFdKKfSUy4DUweq9cKUhWzru/pFk11lG11kPAtw/uexcTVkWOzFihZ9l7Z8cmJ9I7Qrrz6EiEMstthm7mDGXeIMSn0IwsXXOIn5yC8n0/WvvUfh2irXjPNw8t9PrZzN0vBfE+j+DOD+Ojc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788799716; c=relaxed/simple;
	bh=kwI2m1iUU4+WXQsG+OZNBZprZHpEnMTkNocut//aGK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AH4cv2teGNs3JFjALzrU4FQhMG7+uI3YJPyZAfqNWpCLgHr6G1kTCYRGTAxbQ7q08xKGWSg9UY3+FMTZrchxEmhuzxgOrMvQb7JRuS0LEz8OLdlrdmgSMbM0oOAZcKsTtGCADuzdPQ2/yzMXvupn+NAF8/Akz+knAUn9sjHbipM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=KBo4vUkA; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="KBo4vUkA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Date:Cc:To:From;
	bh=8r9SnL35HhiSLVJEbRnHKRUmG3f/HAJLdYLhcCv44DQ=; b=KBo4vUkAURwWxaGK5c61L2ZBD6
	HAaI50GF6FBzxK//MHyMxipG1loqo/2a9pYvo5iN1wtXgWeLyO4N00+r7OHZZtAh6j5iobJ4kkByS
	LNy0hZ2BotczspO/v92IX9fVD4Y7Y07i9eJSGQgn6hzNRdXIfwOd9tz0D3MBr+K9OnVFwCF1gS/t7
	+lfVkptVw21SZCQW1ZVFSYaeFZcxQ42swJjJK92BRw5JchysovU8VbS9wwQxUnB0zuhjHQR96GOq4
	c4uVQ70mCo2kaGMXS/UBgY7oZU9AN/DKFq70nWVXl+lxzhYME6UkJO6+e9nW1dHP1eEgSoY0iWmJj
	0CHQfmTsf6Y5gTAca9GJemMJaD1WHohg8CcT5gRhL+2qWvFHTHiZ13NlyT1AyHKHY6eD5voXkxD1o
	xy6mZCJvbsxzW390Lr7HeBSsPJu1YrI/KIaMQ5iOJ3MD8CkIFsAAtFbicwU5YVFhF7pSMlrgioHZO
	oM19YAm8lHu3+MIrnsink7tD;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1x3cW5-00000000BzV-1gZ3;
	Mon, 07 Sep 2026 16:48:22 +0000
From: Stefan Metzmacher <metze@samba.org>
To: intel-wired-lan@lists.osuosl.org
Cc: metze@samba.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ice: fix double dereference in TP_printk problems in ice_{rx,tx}_dim_template
Date: Mon,  7 Sep 2026 18:48:10 +0200
Message-ID: <20260907164810.1048081-1-metze@samba.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ice_tx_dim_work and ice_rx_dim_work generate the
following: "has double dereference in TP_printk" errors:

 REC->q_vector->tx.tx_ring->q_index
 REC->dim->state
 REC->dim->profile_ix
 REC->dim->tune_state
 REC->dim->steps_right
 REC->dim->steps_left
 REC->dim->tired

And the first one hits a WARN_ONCE()...

Fixes: 3089cf6d3caa ("ice: add tracepoints")
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
---
 drivers/net/ethernet/intel/ice/ice_trace.h | 44 +++++++++++-----------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_trace.h b/drivers/net/ethernet/intel/ice/ice_trace.h
index 4f35ef8d6b29..c641f8ce1aff 100644
--- a/drivers/net/ethernet/intel/ice/ice_trace.h
+++ b/drivers/net/ethernet/intel/ice/ice_trace.h
@@ -63,23 +63,23 @@
 DECLARE_EVENT_CLASS(ice_rx_dim_template,
 		    TP_PROTO(struct ice_q_vector *q_vector, struct dim *dim),
 		    TP_ARGS(q_vector, dim),
-		    TP_STRUCT__entry(__field(struct ice_q_vector *, q_vector)
-				     __field(struct dim *, dim)
+		    TP_STRUCT__entry(__field(u16, q_index)
+				     __field_struct(struct dim, dim)
 				     __string(devname, q_vector->rx.rx_ring->netdev->name)),
 
-		    TP_fast_assign(__entry->q_vector = q_vector;
-				   __entry->dim = dim;
+		    TP_fast_assign(__entry->q_index = q_vector->rx.rx_ring->q_index;
+				   memcpy(&__entry->dim, dim, sizeof(__entry->dim));
 				   __assign_str(devname);),
 
 		    TP_printk("netdev: %s Rx-Q: %d dim-state: %d dim-profile: %d dim-tune: %d dim-st-right: %d dim-st-left: %d dim-tired: %d",
 			      __get_str(devname),
-			      __entry->q_vector->rx.rx_ring->q_index,
-			      __entry->dim->state,
-			      __entry->dim->profile_ix,
-			      __entry->dim->tune_state,
-			      __entry->dim->steps_right,
-			      __entry->dim->steps_left,
-			      __entry->dim->tired)
+			      __entry->q_index,
+			      __entry->dim.state,
+			      __entry->dim.profile_ix,
+			      __entry->dim.tune_state,
+			      __entry->dim.steps_right,
+			      __entry->dim.steps_left,
+			      __entry->dim.tired)
 );
 
 DEFINE_EVENT(ice_rx_dim_template, ice_rx_dim_work,
@@ -90,23 +90,23 @@ DEFINE_EVENT(ice_rx_dim_template, ice_rx_dim_work,
 DECLARE_EVENT_CLASS(ice_tx_dim_template,
 		    TP_PROTO(struct ice_q_vector *q_vector, struct dim *dim),
 		    TP_ARGS(q_vector, dim),
-		    TP_STRUCT__entry(__field(struct ice_q_vector *, q_vector)
-				     __field(struct dim *, dim)
+		    TP_STRUCT__entry(__field(u16, q_index)
+				     __field_struct(struct dim, dim)
 				     __string(devname, q_vector->tx.tx_ring->netdev->name)),
 
-		    TP_fast_assign(__entry->q_vector = q_vector;
-				   __entry->dim = dim;
+		    TP_fast_assign(__entry->q_index = q_vector->tx.tx_ring->q_index;
+				   memcpy(&__entry->dim, dim, sizeof(__entry->dim));
 				   __assign_str(devname);),
 
 		    TP_printk("netdev: %s Tx-Q: %d dim-state: %d dim-profile: %d dim-tune: %d dim-st-right: %d dim-st-left: %d dim-tired: %d",
 			      __get_str(devname),
-			      __entry->q_vector->tx.tx_ring->q_index,
-			      __entry->dim->state,
-			      __entry->dim->profile_ix,
-			      __entry->dim->tune_state,
-			      __entry->dim->steps_right,
-			      __entry->dim->steps_left,
-			      __entry->dim->tired)
+			      __entry->q_index,
+			      __entry->dim.state,
+			      __entry->dim.profile_ix,
+			      __entry->dim.tune_state,
+			      __entry->dim.steps_right,
+			      __entry->dim.steps_left,
+			      __entry->dim.tired)
 );
 
 DEFINE_EVENT(ice_tx_dim_template, ice_tx_dim_work,
-- 
2.43.0

