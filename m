Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FFC3B2D39
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 23:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789256624; cv=none; b=U8agDWhCOlM8PsWYAApiiMtKSsCRyqEZ5T9NEJJGMVuGusyq3yvZOrdZ5sb6eDWxI+OOLTmBqSw4Kk9tF/HJlLpFFgoFJ7DWCuLcWwOaYUFXkYKZf2/9QQz/DYDcj0LUElvMrSM0nNSa+sLj2+pFeaBNYxypTyXmvnOKbgJxWqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789256624; c=relaxed/simple;
	bh=fvjb//GMakb6J0bgW304veUaC0VFSRS09IqwuKKwZdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RnH5FwMSq/Axsp/Ct9jgrrnJ33EKuwQopmLAGMlSmToNK+N3RPu5LPxCJD/DOEV6C5CGct+g1WTCoCJDBe/rW5LVgALjQFZfndcGPdijlo17VLbcO+l68reL522RqCbseHjaabShC5Mv5TaXY0vGD1IY+XV8V9ZugbjjSz8TnPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZlklkXt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZlklkXt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7BC1F00899;
	Sat, 12 Sep 2026 23:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789256622;
	bh=eXD3l6z/PuuMophaM/d+Lykz1SJmxclr9y/Y5OPjZSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UZlklkXt8x3NkhSJ9slE1Q2jXifFl7cJIpk35WZRKkY1bLr97l4DutxRfwBL0NtPM
	 VZguSmouD7EZ60D7i7GdJQPHCFw4VazFV1d61Dcy3gr5++FdQyasj9QCARjaY5q8gU
	 GpmaKRKlTCe7n4W8YUIikGcAEtFMI2SSuvlBXtosWcjrRAp80W11/L4xdwpELXc0Ju
	 9VBA/Sn18AuRAgtAS95gYbMu9EuNhxE3DE6soCbZVp6S3KbeYJCSBG2YmblwaxC0Oe
	 49u2LI29W7CM79+9SJdmE5+dULVaNiCGOpzHzgM2393jvNhPDO9J4+IIwn31YLUAX4
	 IeasezQ2KAsJQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/2] netlink: specs: tcp_metrics: drop the RTT shift instructions
Date: Sat, 12 Sep 2026 16:43:37 -0700
Message-ID: <20260912234337.308298-2-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260912234337.308298-1-kuba@kernel.org>
References: <20260912234337.308298-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All four RTT attributes tell the reader to left-shift, which inflates the
value by 16 to 64 times, and the two usec ones say the result is in msecs.
The attributes carry srtt_us and mdev_us, which hold 3 and 2 fractional
bits. The shift to get the integer part would be a right shift.

Drop the instructions instead of turning them around. The number of
fractional bits is the part worth documenting, whether to shift, divide or
convert to a double is up to the caller.

While at it fix the acronym on the two variance attributes.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/tcp_metrics.yaml | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/Documentation/netlink/specs/tcp_metrics.yaml b/Documentation/netlink/specs/tcp_metrics.yaml
index 1d365908084d..779e8a22b765 100644
--- a/Documentation/netlink/specs/tcp_metrics.yaml
+++ b/Documentation/netlink/specs/tcp_metrics.yaml
@@ -93,14 +93,12 @@ kernel-policy: global
         name: rtt
         type: u32
         doc: |
-          Round Trip Time (RTT), in msecs with 3 bits fractional
-          (left-shift by 3 to get the msec value).
+          Round Trip Time (RTT), in msecs with 3 bits fractional.
       -
         name: rttvar
         type: u32
         doc: |
-          Round Trip Time VARiance (RTT), in msecs with 2 bits fractional
-          (left-shift by 2 to get the msec value).
+          Round Trip Time VARiance (RTTVAR), in msecs with 2 bits fractional.
       -
         name: ssthresh
         type: u32
@@ -117,14 +115,12 @@ kernel-policy: global
         name: rtt-us
         type: u32
         doc: |
-          Round Trip Time (RTT), in usecs, with 3 bits fractional
-          (left-shift by 3 to get the msec value).
+          Round Trip Time (RTT), in usecs, with 3 bits fractional.
       -
         name: rttvar-us
         type: u32
         doc: |
-          Round Trip Time (RTT), in usecs, with 2 bits fractional
-          (left-shift by 3 to get the msec value).
+          Round Trip Time VARiance (RTTVAR), in usecs, with 2 bits fractional.
 
 operations:
   list:
-- 
2.55.0

