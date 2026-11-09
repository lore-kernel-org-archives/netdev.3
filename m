Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.59.229
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794211418;
	b=bBPJprUgBtY6KGsY6+RawUgikLxRrPP3ikrKFDOeHLOgjVRp3ey3T2OhqyeE4A2CTfkH
	 /EOLwmFadPw9zAKew148AG+Baz0kTd9DIxL7psvcFl6Ub5+KoZU4N4USED/ucc5DrMZTH
	 YWqET+Ma2AQQSU0LN6WN8xXRIJjnHlNOUwcwKMvLnTJ02Ow1hhvjUZXbDO3rNrutsUzUB
	 HSoydyOId2r4wT69gsTh8P1bEJuex9CVslTvBx1au8wlpRi1RVR3o0+KdHedipp/G9SgO
	 XKd74ErQHRxwsKthTvMI+PcZvzPP8ZdYwcP+Z3YDSuKSN+tIu1EuNT1T4esRo941RRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211418;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nCwei3yxV3B2umLK1h2qgJbCXfxvzK2XX8vQpRVad2g=;
	b=QFJOnG2spAMdPz3JafRfIweDZoNXbDX0+DL0jrIdGBkjOUT/0JnMh2joi85GZ+KnzFw3
	 VYgjEjRUxt3C1DmLt2D3zQc6veKNtpX5Zf0nm1QMV0UHObpaRE7YurwQF+/G/EEyR3/3b
	 kX0StpW46PQj8qvEbd0Xax/4G1PhBjN6MgUHZI0K0+eSI64O7q6xyMFzarMayFeZBwWZ2
	 U2HhbGDG4esAcLQp4wNQSHpqJmToTXQ+LfyGPGOLh6OCMapB0JP7TGs2tZB0XAbc6ePVj
	 D+FIntgFFAUMUivGA6VWM3RrLE23gH5LBmf+4QIjTvK2VnlmAH+uLTlIZxBwjycMS7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1wt.eu;
	spf=pass smtp.mailfrom=1wt.eu;
	dkim=pass header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=n3eIxTdT;
	arc=none smtp.remote-ip=51.159.59.229
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6381B606A323;
	Mon,  9 Nov 2026 08:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6381B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=n3eIxTdT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1794211413; bh=nCwei3yxV3B2umLK1h2qgJbCXfxvzK2XX8vQpRVad2g=;
	h=From:Message-ID:From;
	b=n3eIxTdTwnvTAZJ2goCeFbsaKIDk3nIpbd7Bu7wPyIpf3X+CoH9sndrKsdt23PTx+
	 Jl3PU8O+PLTNJ1gniCafXwTB2v3pHYEX9/xsah86ryjNXKKmdOI22NAoH8RdRKJDEE
	 kM/cLgKoyReqFinxfJi4CsMDsiV5Az12gcFYicQ4=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id DA936C095B;
	Mon, 09 Nov 2026 09:03:33 +0100 (CET)
From: Willy Tarreau <w@1wt.eu>
To: Jonathan Corbet <corbet@lwn.net>
Cc: skhan@linuxfoundation.org, Randy Dunlap <rdunlap@infradead.org>,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        gregkh@linuxfoundation.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH 04/14] docs: threat-model: clarify the case of automatically mounted file systems
Date: Mon,  9 Nov 2026 09:02:30 +0100
Message-ID: <20261109080240.29444-5-w@1wt.eu>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261109080240.29444-1-w@1wt.eu>
References: <20261109080240.29444-1-w@1wt.eu>
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

Bugs triggered by crafted file system images are among the most
frequently reported non-security issues, often with the argument that
some desktop environments automatically mount removable media without
checking them.

Let's state that automatic mounting of unchecked file systems does not
change the analysis: an automounter is expected to check a file system
before mounting it, otherwise it is at fault, and if the check does not
detect the issue, the file system checker is at fault (this doesn't void
the need to handle the kernel side of the report). Fixes should then be
directed to these tools. The only exception remains drivers specifically
documented as being hardened against hostile inputs, as already stated
for non-conforming devices and media.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 Documentation/process/threat-model.rst | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/process/threat-model.rst b/Documentation/process/threat-model.rst
index 72cb36dd383d6..b82d5d168b4c3 100644
--- a/Documentation/process/threat-model.rst
+++ b/Documentation/process/threat-model.rst
@@ -234,7 +234,12 @@ The following classes of problems are not considered as vulnerabilities:
     image: mounting a block device is a privileged operation (see above), and
     the administrator is responsible for the media they mount. This includes
     issues that are resolved, mitigated, or detected by running a filesystem
-    consistency check (fsck) on the image prior to mounting.
+    consistency check (fsck) on the image prior to mounting. Automatic
+    mounting of unchecked file systems (e.g. removable media mounted by a
+    desktop environment) does not change this: an automounter is expected to
+    check a file system before mounting it, otherwise it is at fault, and if
+    the check does not detect the issue, the file system checker is at fault.
+    In such cases, fixes should be directed to these tools.
 
   * bugs whose reproduction requires hardware modification or emulation,
     including fake USB devices that pretend to be another one, or devices
-- 
2.52.0

