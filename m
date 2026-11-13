Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591484;
	b=Q7ElRwkzuCVa4MkNpniqOIDNhf4+zJ46IyI2Fl/yQYkAx8H9DAhKz3xJdZpVgtbOguOH
	 E4iybFyrMF0GYOqddpRUX56Ais61ekLu6CjFXM2TFZPiZ8A+4rHZoioK3kxeIe3O2UjOs
	 uWDTSogVQaMXu3KG3W7L2EwQ1KMeU4tOpd2VuSYXAcjr+GIDGnUvLhlQxntS8FdVGrYaX
	 Lfe+SZGE5SfVWG5F9icLZBpkt7XYuDkWMyVpCQxBHWV00NU7YfRCo15JKH9wpLvE1aSm1
	 JcgiBp9n46NqwxSCyG4bOvL0nLZ7iVqMnv32cv3rDX4P4BD6RbhtfnW5Z+UvxMN4neQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591484;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=f9eDxMtZQOEH/tkhoV3/TAWcEH7YSnWvrip0hcgMasM=;
	b=de8wo0qM8b8PyKQjTBpJkMFSzyKFXrhH5/A32U+uX+vdsJ8o1l/2d5r7n746TPU11g4Z
	 LTB6rwpFvWTnUoZB16PT2QYlB3zOepzWIC29XHmZg/PRoQ8mAT0nLGbS6Tg/UVoXrVYPF
	 IXLQ3I0imLlt/tSWmajvR6TCRfnFUjrMdG6hkREnocG7TuRdJWochtFeWrlTA6pWMC1R5
	 j33WRL0R/+ScMnc/Yh0eN/o14kjkNahu09D+Idm8bFci8tRS7bZVdSojm2Gtp4KbOXXZA
	 9D1qIpCSPnKJKK2qL/JBCtXOE3oyJpX7c3X2sLAd6+Z0bJuwJm6FGDDytccFT0VZn+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jcC0LKYB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2742607E042
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 17:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jcC0LKYB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C5A1F000C8;
	Fri, 13 Nov 2026 17:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794591484;
	bh=f9eDxMtZQOEH/tkhoV3/TAWcEH7YSnWvrip0hcgMasM=;
	h=From:To:Cc:Subject:Date;
	b=jcC0LKYBx+k5RKkNbmrsc4h7uGWw9HoS9l1X+RDYecDm4llrEy+dgalRL5tYhlhjv
	 +eGpAAE1y/7TdACL7QTOQdm6gl2NUiB8n4Kga0LvwT+2CzWRpiH8UlblQHyTa4NpBk
	 +ZSwZJSeppg+0my+eRwmzWztUD89mWwgrID7qGvk7lVi2djAmnJORhVqshL/SOtKJA
	 oXK/tQ/8B/cQp03EZF+s8a6vm0SL36NjQFIf03Lb8tPRepZqemdiKdY8mkt5zbMwM0
	 SDRbKZ8SEf+AKNYkaBGJvomroI+0f1k98PD3MTTjSl1bXdUaejJFwX/WoWJYna5IEY
	 ZsDmGjLZMve7Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	sdf@fomichev.me,
	razor@blackwall.org,
	daniel@iogearbox.net
Subject: [PATCH net-next] netlink: specs: netdev: clarify Tx queue stats
Date: Fri, 13 Nov 2026 09:38:02 -0800
Message-ID: <20261113173802.272995-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
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

AI has been complaining during mpnic review that we don't count
the offload stats on completion. This is expected. We don't want
to force drivers to fully re-interpret the skb on completion just
to get slightly more accurate values of informational offload
counters. It's fine to update those as we produce the send queue
descriptors.

This was always the intent: the tx-packets / tx-bytes docs
explicitly call out that the packets must have been successfully
sent, while the offload counters say nothing to this effect.
The checksum counter doc does use past tense which is probably
what threw reviewers off. Rephrase it.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: sdf@fomichev.me
CC: razor@blackwall.org
CC: daniel@iogearbox.net
---
 Documentation/netlink/specs/netdev.yaml | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 4303593e5003..0de7f93f0c4c 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -378,6 +378,11 @@ doc: >-
       up to the total number of events, will only be reported for currently
       active objects, and will likely report the number of events since last
       reconfiguration.
+      Basic Tx counters (`tx-packets` and `tx-bytes`) count only packets which
+      successfully reached the device, while offload-related counters
+      (e.g. `tx-needs-csum`, `tx-hw-gso-packets`) may be incremented at
+      submission time, and so may include packets which never reached
+      the device (e.g. dropped due to a queue flush or reconfiguration).
     attributes:
       -
         name: ifindex
@@ -510,9 +515,8 @@ doc: >-
       -
         name: tx-needs-csum
         doc: |
-          Number of packets that required the device to calculate the checksum.
-          This counter includes the number of GSO wire packets for which device
-          calculated the L4 checksum.
+          Number of packets which requested the device to fill in the checksum.
+          For GSO packets, this counter counts wire packets.
         type: uint
       -
         name: tx-hw-gso-packets
-- 
2.56.0

