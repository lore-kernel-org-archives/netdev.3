Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB533AE6E9;
	Tue, 26 May 2026 16:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811331; cv=none; b=IyUTPXk+PAqGpTqPwaSjrQozC3E3dJOhgF0CghYCV/qbS6X5REZS/poG8l5uPXig2UBuqdT4lI+hK3kU+E3yUiQWrE+yYNUhbOzSspxgvQDdriAnL4GcLXmBuCI2vhBfX1tGyXINJOt/jwPdwvQziC5yn5KKZP1mZNvoBztZRlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811331; c=relaxed/simple;
	bh=yF5Ouo5V0w74GBgjJ93fm7GVaovIwzJ/HUp/9S8Oe1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DEeMgBFJhXPzWVU5xP8iiXhYrQaVdVfjwTRgF8jYBpGCZM+zg2uBm7KkM5e1ElkmNJiWDH2iPqTLAyWTkIZq8kfaVK2yT5JaApzrrcBaQXbiK4vz9hW/OxHID/Y5MEKLMwL0SbyjStV/GrFaFQKS+fhsLUVkn52xxVfsf31H8Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPGYJuQ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPGYJuQ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4C21F000E9;
	Tue, 26 May 2026 16:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779811329;
	bh=/0Bln09qq+9LAApaz7NNy/eKWdcCAf1xpBDrpxWTIhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bPGYJuQ2hVRytunCNKu8E8OfnrnJ3NEzYMs0D06nV20jBSzr7t64zpesrDe+Nqud2
	 XeizOskXvsOgfmPMog/Gn23YcRuWA8lnYJMdZoN25oDbBq60yQ5wpyf8qu3kSAI9a5
	 0m7xrhJWANB1cqMj7Qz3YZ5adYEwhS7IK0RjAxVJtxCe3+lQefZ2QFaBNMzOUMgfhL
	 rXm9t79E75sjEAc1Ybulax1PXsb7VV1CW4KoQWurK8yNpcU6p82dFL1YBgsRSSmQIN
	 H59YrNiNEKW2NhVdSXatYMAZOZPmZOVenxAG1yhuiZakP0gl6/KkI0mN1+PIbLsUzK
	 hkIB1yeg4ps/A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	corbet@lwn.net,
	vladimir.oltean@nxp.com,
	willemb@google.com,
	sdf.kernel@gmail.com,
	ecree.xilinx@gmail.com,
	jesse.brandeburg@intel.com,
	linux-doc@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 05/10] docs: net: fix minor issues with the NAPI guide
Date: Tue, 26 May 2026 09:01:46 -0700
Message-ID: <20260526160151.2793354-6-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526160151.2793354-1-kuba@kernel.org>
References: <20260526160151.2793354-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the NAPI documentation to match current API behavior:

- repeated napi_disable() calls hang waiting for ownership, rather
  than deadlock
- NAPI IDs are exposed through SO_INCOMING_NAPI_ID and netdev Netlink
- epoll uses the maxevents parameter spelling
- add that drivers holding the netdev instance lock may need _locked()
  variants

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/networking/napi.rst | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/napi.rst b/Documentation/networking/napi.rst
index 4e008efebb35..c719924f36ce 100644
--- a/Documentation/networking/napi.rst
+++ b/Documentation/networking/napi.rst
@@ -49,7 +49,11 @@ instance to be released.
 The control APIs are not idempotent. Control API calls are safe against
 concurrent use of datapath APIs but an incorrect sequence of control API
 calls may result in crashes, deadlocks, or race conditions. For example,
-calling napi_disable() multiple times in a row will deadlock.
+calling napi_disable() multiple times in a row will hang waiting for
+ownership of the NAPI instance to be released.
+
+Drivers using the netdev instance lock may need to use the ``_locked()``
+variants of the control APIs when that lock is already held.
 
 Datapath API
 ------------
@@ -190,7 +194,8 @@ User API
 ========
 
 User interactions with NAPI depend on NAPI instance ID. The instance IDs
-are only visible to the user thru the ``SO_INCOMING_NAPI_ID`` socket option.
+are visible to the user through the ``SO_INCOMING_NAPI_ID`` socket option
+and the netdev Netlink API.
 
 Users can query NAPI IDs for a device or device queue using netlink. This can
 be done programmatically in a user application or by using a script included in
@@ -371,7 +376,7 @@ efficiency.
      the application has stalled. This value should be chosen so that it covers
      the amount of time the user application needs to process data from its
      call to epoll_wait, noting that applications can control how much data
-     they retrieve by setting ``max_events`` when calling epoll_wait.
+     they retrieve by setting ``maxevents`` when calling epoll_wait.
 
   2. The sysfs parameter or per-NAPI config parameters ``gro_flush_timeout``
      and ``napi_defer_hard_irqs`` can be set to low values. They will be used
-- 
2.54.0

