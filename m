Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C1024A078
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 02:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789524924; cv=none; b=nMR5QQLzyqfYkycFkgf2Ux0SillCLNbTU0rOvjI3wc55JCF3exHVNAAlwEreResz2fBiVUOsJrqyzLrfhAD3C5mRsa6IGaZLDPlyX9p7LzlZtlaoomu+6l4Ckcsxp5j7BAi7BdWtmS3qhFgvOV7G8PKuEvzFqVvm5nMvqfucYd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789524924; c=relaxed/simple;
	bh=jJuTjhxBzAWuLAaqOU5DvB5luNqVOlRV1PcOfAmXKw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ha9g+scS7TX3jK7v0c/4SsYzAXhEl5ymwTik4IK2m/0x9SZohbuxO1hJfu2wwDs8mSxFhe8SKuDK7NyZDhdCXPnwWO1MX8yENw2je0HJiFeY5wn9yiEg3/sN6g/L2Kl0sLA9OQwqvWZV7yicA47Wa+anWTOq9ntydE9fb3DtzDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqzN8RDf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqzN8RDf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727151F000FF;
	Wed, 16 Sep 2026 02:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789524918;
	bh=kV1vDk+raetgZszT92lvlKPPnyCUAhiPe4989g4eTcY=;
	h=From:To:Cc:Subject:Date;
	b=ZqzN8RDfZrC0NvvQRkZTnyMubIDgl2EkozDcM06XtuPZFi+ZPLahkgB7xQQvbTLDm
	 ktKP+d/p/85/eNFryHIrLXh0arUmQzXTVQgLDesNQBie5426kRpd72l8H+GhG/wpW+
	 5A+rDgmYYoqREHbF1nmVzVZB7nZ61cP4paXKNCR6phtBfc6TzJxzdQXeLmn/o+RLhz
	 shoaq1T+CXXgPbFspWB80PBvtDNDInYR2kZssWdRgH+2uz3YUQUTWdH2WXDHRNHmXN
	 DUuME+LCDUJSuiYx4sCq5SmNnTa65Hys+YmC+ErqIcRD/1M3xcZMQGCySmv/UYaqpE
	 c9jgvj9k7Q71g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/2] netlink: specs: nlctrl: fix the policy attribute numbering
Date: Tue, 15 Sep 2026 19:15:15 -0700
Message-ID: <20260916021516.1701760-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mask and pad are declared the wrong way round, giving mask 11 and
pad 12, while enum netlink_policy_type_attr has
NL_POLICY_TYPE_ATTR_PAD at 11 and NL_POLICY_TYPE_ATTR_MASK at 12.

The kernel emits the mask for every NLA_POLICY_MASK() attribute, so a
Python YNL client parsing a policy dump maps it onto pad and throws it
away - 30 of them in ethtool's policy alone.  In the other direction the
64-bit alignment padding, which the kernel does emit on architectures
without efficient unaligned access, is decoded as a u64 mask and blows
up the whole dump. But those architectures are rare.

The generated C parser is not affected, it keys the attributes off the
uAPI symbol names rather than off the values the spec derives.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/nlctrl.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/nlctrl.yaml b/Documentation/netlink/specs/nlctrl.yaml
index 7e7c158e3e73..6acac4aeab03 100644
--- a/Documentation/netlink/specs/nlctrl.yaml
+++ b/Documentation/netlink/specs/nlctrl.yaml
@@ -156,12 +156,12 @@ doc: |
       -
         name: bitfield32-mask
         type: u32
-      -
-        name: mask
-        type: u64
       -
         name: pad
         type: pad
+      -
+        name: mask
+        type: u64
       -
         name: byte-order
         doc: Byte order of the attribute, absent means host byte order.
-- 
2.55.0

