Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDA948C8C7
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 21:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780520896; cv=none; b=m08QLxOmTrFepxpaKCTeOCMDDdvsjDwmyQQIMXATULPCuOb4OYaMS7fvdjewZJacFjiEbUyglCoIX8t9gG+7a/Y0ZbeuITMIVVTRkEacR2OfcNC9hCNwAHZGkIlm5a8+PMmdEyLb6/0HhacQXnspywGmY2Z/8iB39iDf5xSgECQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780520896; c=relaxed/simple;
	bh=YGMyGmNMTjdhxo8r4kvS4fGMxAqCGvDAz6+iIFjAqYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lVOBaP2GDpzpCIPg20I/94u76a7RQ5m3xbWOKP639aRo3FhWX2BsQ7zzVCRsWSZGMveBOkjKIk74SHlK3ANUgp5cJ3PtOGqYtJge0ExaH9/ixyqxTilMRjwqOUJUpiUQXtoJiSlf4yITrx6G0aLsCEJ4a2UgmarBY+ftB0BhG58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuSjhXAj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuSjhXAj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D4A1F00893;
	Wed,  3 Jun 2026 21:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780520895;
	bh=FRS7AZfhelwmIshWYRQW5/DDQdKNuyjIFZJfxSgaorc=;
	h=From:To:Cc:Subject:Date;
	b=iuSjhXAjo4NnOnz+nUXOX0wWCwMbh9NMhE73bXfITuOq7RDlfuQIbjI4LcewhVO9O
	 Rrx1j940tY3IGdvkNYcjIM0bQik+KEfd9cdIEO4whGpy4Xb0YrCrWmWGR+7QeR+6wM
	 laQUARCpGFEAYPKLuq7Jhpf1hoC5hVk0W9SCiG1wt28jyIKEPkXOhJ/GNylotuZNX6
	 DILiP87QFem/2f8JZ5QV/wh3OfeZjZ9DL2KEwoju+dZiMBi3/a2+m6Op3mNR2bYJRF
	 uxR+qgzKduwYf7DVsWUGu2R+qbX5g5MlevNKuUaMH2xYCVvObVmAmIJ7I4geRSOmuc
	 efK6ZC/5sp8cw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com
Subject: [PATCH net-next] tools: ynl: try to avoid the very slow YAML loader
Date: Wed,  3 Jun 2026 14:08:10 -0700
Message-ID: <20260603210810.2636193-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Turns out Python YAML defaults to a pure Python loader for YAML
files which is a lot slower than the C loader (using libyaml).
Try to use the C one whenever possible.

The avg time to run:
  $ tools/net/ynl/pyynl/cli.py --family tc --no-schema
drops from 300+ ms to 115 ms with this change (40 samples).

We could drop the load time further to 85 ms if we "compiled"
the specs to JSON. Slightly tricky parts are that we don't
currently install the specs at all on make install, so it's
unclear where to put the conversion. Also JSON has questionable
support for comments and we need an SPDX line.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
---
 tools/net/ynl/pyynl/lib/nlspec.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/pyynl/lib/nlspec.py b/tools/net/ynl/pyynl/lib/nlspec.py
index fcffeb5b7ba3..0469a0e270d0 100644
--- a/tools/net/ynl/pyynl/lib/nlspec.py
+++ b/tools/net/ynl/pyynl/lib/nlspec.py
@@ -439,6 +439,11 @@ import yaml as pyyaml
     # To be loaded dynamically as needed
     jsonschema = None
 
+    try:
+        _yaml_loader = pyyaml.CSafeLoader
+    except AttributeError:
+        _yaml_loader = pyyaml.SafeLoader
+
     def __init__(self, spec_path, schema_path=None, exclude_ops=None):
         with open(spec_path, "r", encoding='utf-8') as stream:
             prefix = '# SPDX-License-Identifier: '
@@ -448,7 +453,7 @@ import yaml as pyyaml
             self.license = first[len(prefix):]
 
             stream.seek(0)
-            spec = pyyaml.safe_load(stream)
+            spec = pyyaml.load(stream, Loader=self._yaml_loader)
 
         self.fixed_header = None
         self._resolution_list = []
@@ -464,7 +469,7 @@ import yaml as pyyaml
             schema_path = os.path.dirname(os.path.dirname(spec_path)) + f'/{self.proto}.yaml'
         if schema_path:
             with open(schema_path, "r", encoding='utf-8') as stream:
-                schema = pyyaml.safe_load(stream)
+                schema = pyyaml.load(stream, Loader=self._yaml_loader)
 
             if SpecFamily.jsonschema is None:
                 SpecFamily.jsonschema = importlib.import_module("jsonschema")
-- 
2.54.0

