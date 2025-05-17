Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A327B4AEE0
	for <netdev@vger.kernel.org>; Sat, 17 May 2025 00:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747440816; cv=none; b=oh2KdwYGf4LUDGhaLtkVxinNQkkfl3Q3hVRxGgPhco9bdW9yB9ZntxCBBsqNGVZxSwCuXfWahZNI9cuWuij/ZJkex+POrwuOo6am8xRxY0cpoTCymdIV3SqoWvh8p+ftBEthBueATDGsnOpZA0IS3mmYUUnwAbqxER09aXK7VV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747440816; c=relaxed/simple;
	bh=dE/tbmS+m80x0CgiaSdwIQNylnraQqUOYL9rUAuTH6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T00BtGjAZzPrqcWgFLg9D8smyJRSY5bBrrjhAbVRRfNR/Sn4zVdf3v/jI6EZQnWedDVujs8VLEnzu+xZ4gtBpR/4OHvSHX6GzZdJ1OWvFGNNEteWHS6XoQO3BrGf3/P9v9dYYO6ZIImDY+FAuvNmk8L9qMljMuH+JSp0MbGUDtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nD0FXNrU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nD0FXNrU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E644C4CEF1;
	Sat, 17 May 2025 00:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747440816;
	bh=dE/tbmS+m80x0CgiaSdwIQNylnraQqUOYL9rUAuTH6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nD0FXNrUnTqxuqea5ap8BxLw9DgXvTjtQyunN1MHUk6QEYevx3WNX85ZRZ+ngWh7L
	 yrKg8xhtU6mDvFY/geXYtWBdWtCokDzQrDcJ0QUHt2zAdJoQKWw8frRmaLS9nOs16I
	 0LkrszWhYQL+wIyR9qpUWkvvo06FrEMpJKYjDjroGN3PEfwWElcnjzh7CgrZ22EkHT
	 3MdmshzDNiUBtwJ79CxnH30aa1fJYY7Bta3s2RnlR7GnzZLm69p85qIkui0SmcMDf+
	 QQQbHzaWJkg1wrSRY5cDUiMI0IpbBOu/TztC5ZOPEF7/sVUssJHtTyqxjtTIVLbXLa
	 jSCGJFevSZRCg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	sdf@fomichev.me,
	jstancek@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 10/11] netlink: specs: tc: add qdisc dump to TC spec
Date: Fri, 16 May 2025 17:13:17 -0700
Message-ID: <20250517001318.285800-11-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250517001318.285800-1-kuba@kernel.org>
References: <20250517001318.285800-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hook TC qdisc dump in the TC qdisc get, it only supported doit
until now and dumping will be used by the sample code.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/tc.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index 6e8db7adde3c..cb7ea7d62e56 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -3929,7 +3929,7 @@ protonum: 0
       doc: Get / dump tc qdisc information.
       attribute-set: attrs
       fixed-header: tcmsg
-      do:
+      do: &getqdisc-do
         request:
           value: 38
           attributes:
@@ -3948,6 +3948,7 @@ protonum: 0
             - chain
             - ingress-block
             - egress-block
+      dump: *getqdisc-do
     -
       name: newtclass
       doc: Get / dump tc traffic class information.
-- 
2.49.0

