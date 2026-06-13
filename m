Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDE72EA73D;
	Sat, 13 Jun 2026 16:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781369970; cv=none; b=cZjEtxsBdheqLFLut5zsXrbyxDnHfXV8zPYy/ru9VkDw0StvANQaeXv/ntAPjQJRFsWmoFHN95OsqJMvtEC3pjxCPiD7BCW9TvHJopUwVRik+doNqDz7uZP6I5IG7naKXHnQJ9NKf/Ol1iZ1nFEnqyNIvsrj1XaZ/KVA04+KzCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781369970; c=relaxed/simple;
	bh=JXGGKycIp+fSCFoqr7xrpnm2CWfjCbgyn3e9PVlFSdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBF7OavqYhAC1cl60z/HwCBVgmv1oMsxwrJ4JW/m4qSxqWa/exvdyz+5t/tIdZUdG+M3DxtVURuLbyz1o69dvcDPrjjkJbfPiLUhW4S6Qoyzz+tbdg1k9960nn/Cv4JcY4RBbCfDxRtxNmma93nzqJ7OZb7jqw3v2Xr7aCX/dc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiZmX/FA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiZmX/FA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51E71F00A3A;
	Sat, 13 Jun 2026 16:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781369969;
	bh=djlY0cH0+5l0szO48FBrkZeaHrTwq7y36rd6PX9HsBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kiZmX/FAKMbqpEGDNjmZmx0VkmigA4u3rQ+JqT8bLRXR/Fa/aGiOTeRp+aXBNTeHd
	 rhPT0Em8kADLsKePhLGKHUDeVlUTceieJNcNJfjAnE3Ros7RJFw++hkV2UxFcVSBbl
	 PTs3B1JCkoECItzVM1T7qNQaoytXhj/5s+jnDzKLbqbgyEKtqMs+SmnW+N7A1KS/cR
	 os4bi7k4nghWgYb0cEP2k/ga1yvOXtq5ltHIldUKiwukq5Uoa7+7ocPj/c/8wz4NJa
	 H5eHOP1zQvPFetqU3J+iEso2kySxttP4pSdZK9MJ3Hr8m3t/mPiSNfUIXeLqf9OhJ9
	 NVfN9/+C5m3mg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	john.fastabend@gmail.com,
	sd@queasysnail.net,
	jiri@resnulli.us,
	Jakub Kicinski <kuba@kernel.org>,
	skhan@linuxfoundation.org
Subject: [PATCH net-next v2 1/3] docs: net: tls-offload: document tls_dev_del, tls_dev_resync, and rekey
Date: Sat, 13 Jun 2026 09:58:44 -0700
Message-ID: <20260613165846.2913092-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613165846.2913092-1-kuba@kernel.org>
References: <20260613165846.2913092-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fill in some gaps in the TLS offload doc:

- describe the tls_dev_del and tls_dev_resync callbacks
- add a mention of rekeying being out of scope for now

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - add mentions of the callback in resync text
 - Stack -> The stack
v1: https://lore.kernel.org/20260609201224.1191391-1-kuba@kernel.org

CC: john.fastabend@gmail.com
CC: sd@queasysnail.net
CC: corbet@lwn.net
CC: skhan@linuxfoundation.org
CC: linux-doc@vger.kernel.org
---
 Documentation/networking/tls-offload.rst | 45 ++++++++++++++++++++----
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/Documentation/networking/tls-offload.rst b/Documentation/networking/tls-offload.rst
index 25ee8d9f12c9..e5802bcd4d22 100644
--- a/Documentation/networking/tls-offload.rst
+++ b/Documentation/networking/tls-offload.rst
@@ -99,6 +99,29 @@ at the end of kernel structures (see :c:member:`driver_state` members
 in ``include/net/tls.h``) to avoid additional allocations and pointer
 dereferences.
 
+When the offloaded connection is destroyed the core calls
+the :c:member:`tls_dev_del` callback so the driver can release per-direction
+state:
+
+.. code-block:: c
+
+	void (*tls_dev_del)(struct net_device *netdev,
+			    struct tls_context *ctx,
+			    enum tls_offload_ctx_dir direction);
+
+``tls_dev_del`` is mandatory whenever ``tls_dev_add`` is provided.
+
+The third TLS device callback is :c:member:`tls_dev_resync`, called by the core
+to synchronize the TCP stream with the record boundaries:
+
+.. code-block:: c
+
+	int (*tls_dev_resync)(struct net_device *netdev,
+			      struct sock *sk, u32 seq, u8 *rcd_sn,
+			      enum tls_offload_ctx_dir direction);
+
+See the `Resync handling`_ section for details.
+
 TX
 --
 
@@ -250,9 +273,9 @@ sequence number (as it will be updated from a different context).
   bool tls_offload_tx_resync_pending(struct sock *sk)
 
 Next time ``ktls`` pushes a record it will first send its TCP sequence number
-and TLS record number to the driver. Stack will also make sure that
-the new record will start on a segment boundary (like it does when
-the connection is initially added).
+and TLS record number to the driver via the ``tls_dev_resync`` callback.
+The stack will also make sure that the new record will start on a segment
+boundary (like it does when the connection is initially added).
 
 RX
 --
@@ -344,9 +367,10 @@ all TLS record headers that have been logged since the resync request
 started.
 
 The kernel confirms the guessed location was correct and tells the device
-the record sequence number. Meanwhile, the device had been parsing
-and counting all records since the just-confirmed one, it adds the number
-of records it had seen to the record number provided by the kernel.
+the record sequence number via the ``tls_dev_resync`` callback. Meanwhile,
+the device had been parsing and counting all records since the just-confirmed
+one, it adds the number of records it had seen to the record number provided
+by the kernel.
 At this point the device is in sync and can resume decryption at next
 segment boundary.
 
@@ -370,12 +394,19 @@ schedules resynchronization after it has received two completely encrypted
 records.
 
 The stack waits for the socket to drain and informs the device about
-the next expected record number and its TCP sequence number. If the
+the next expected record number and its TCP sequence number via the
+``tls_dev_resync`` callback. If the
 records continue to be received fully encrypted stack retries the
 synchronization with an exponential back off (first after 2 encrypted
 records, then after 4 records, after 8, after 16... up until every
 128 records).
 
+Rekey
+=====
+
+Offload does not currently support TLS 1.3, therefore key rotation
+is not a concern for offloaded connections at this point.
+
 Error handling
 ==============
 
-- 
2.54.0

