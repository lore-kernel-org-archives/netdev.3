Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76723BB677
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 03:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791604300; cv=none; b=o+Q2Ks0Wd+6pN5+oVys5DEYoVaxCI0Fgu43s+vJx/8MZMKNvdKempC7zitta8PDPnEHmgp4cNImTYpyXAIRTcB03dFMUWOMSIrF7P6zG0lg1DlNTWuaadvhO0uY70Fs8uiaonnct9XQrbNaJTjZ/DWAeqbUkaduk5f1wJlNhvJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791604300; c=relaxed/simple;
	bh=vHsTXZv5TyeF3HX5UW6hnKMqsavvFFm+POrGdkcd3fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBXViFu2kC/nY1GCzXinKMgXzDnLBPPi+Fu4hq11btzdJ+IMvuLPStan4s6xRBevDGNniIGnBEBl5EHMcktZm9pilIxiTGarG1S1jc20cz7yPk6gpChOEpvZ0UsoOaFo2bcTYKyjQdruLHUBWzmD9Ad2Buzhdeu07SWOr0fKLWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XkgJNwsY; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkgJNwsY"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5ba4180a65aso217130e87.2
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 20:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791604296; x=1792209096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t4lwgRqdIBm7UtaWzVpHkZBb7rvpL6UN+PLUcNwF8OI=;
        b=XkgJNwsYTpq7K+5h39+U0hDHyOZ4SFimOtAzhP+CUo1QcItqImglgcudINkIVs5tro
         bpIWpAE133tFXjgvA0csZrZlNERkjixBZ/VrmLjJEp8eduw3rvgHq6AVD3sKmlfkIIMe
         Ihh+oePUhNhpftxcVYU7IRWiMBoT0rtYcKAV3zzA9bYuQ53JoxqkCMd8t+piv5T1QQQr
         +Ftp6msTjzEvCQdhRKbZzNxGTK917rfXeBxXeAfAbz7VKPJ6VSrzyN1DpCOjNCXBH9I/
         pAOxsnLNtggjQqotKwA+5AkY4/nnR8IL4WUyxxZ85/4yFDDHIX+0Q53uVBFxoR0SRhHn
         zuqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791604296; x=1792209096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t4lwgRqdIBm7UtaWzVpHkZBb7rvpL6UN+PLUcNwF8OI=;
        b=ncusXNbSexbHwxS9ZM7ZW/ob/sMLHzax7nMHzSibYxGReGn86b6xjNyVwORlGMHWy5
         Su6j6k9nk2idhqfHvTNo0j6AfYDF/VlanMXLksSutD0h/ME92qO1nhkgvlC4yL2j/6X4
         wKiAP4v5FA++/ex4Cbs8+F1XOoIGxkIJvsM8qkO7AcYXQ0AYK5n0TI/c3EkdqSL87gNe
         BFTcWh2lRE4O5/RIo3NDsh2cZK0gbxkWgfB9IAHtH72ZvjN9u0BaeL2CL539GMWaKK6P
         PvLF9e875/Q9dJDofLiHSHKMNjKTOj2p/Djxh+ZXU68k7XDnjkFn5ftnEm8LVpOrIwjC
         TucA==
X-Forwarded-Encrypted: i=1; AKwUvByCPC0Zrew41ypoKos7LTJdigdkIGv7QTF97moeNg7jwgbbxo9jxv6x0UEQjhQoah4f/jUF2jo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKFSW0YuAvMsdcKv2mNFkuCCpN2+XLDVN6fOQXfiYovR3qCmCjy
	xjXNt1Z5bn6Kmig0SHfoDLrz72aoPuepV4RfkK6kJKPHG64MNEZlRqa+
X-Gm-Gg: AYBFou0gc5ib8q4kZdgkDT8aCuako9JckHMe430BSp41n4vU0wnX2GyBZ7BGIcNOcAM
	bYGXHOTakkCWESNubE9NlWtQ1F36ufVlN+h1pHzCGaXepPJ5fKZnKH/Sgu4yCJgG9pphba9scaC
	9W83GW5VlZmLGctbEyOY/Crit7FG11uISBwfWTFCsl/KRWgLFR4x7LrMXYFS5UfESxUKtkLITvk
	Q9ybHGGdQRy4KqGl1Uk1v+eJzjGc9/w195IPYhmNyJx+JLXNpcuNgFON6bq1FRy9m5XUWa/vOwR
	LD5PyUEHdNwDtCv12alDIWaYP/dXets0m7bkT4OkJUcgzjIFWYSlano+9Vi+34XRpvq33fXCc2m
	+N2xDEHlxzk9y1dgJ+xKW3bRmdo0/yDql9yMfzUgEdR2z0ZNK733M4p92e9UCdGJ2sgpt/oXzSu
	K5qgwqoRj1SSF4ORhk4L7mt2uYn/ktHOzCjl4kIR8hO1U0RQRHSA8x553PIcPWx5xVsCJL5+IN8
	E9P3OUF5CcJJ6iL/0DenZSkDcR4IdJ15o5rh15vy38=
X-Received: by 2002:a05:6512:4011:b0:5bc:ddab:bbba with SMTP id 2adb3069b0e04-5bcde8bc77cmr1309405e87.38.1791604295488;
        Fri, 09 Oct 2026 20:51:35 -0700 (PDT)
Received: from dau-home-pc.. ([95.139.131.22])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bcdde9c924sm1161984e87.36.2026.10.09.20.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 20:51:33 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Remy D. Farley" <one-d-wide@protonmail.com>,
	Rachel Menge <rachelmenge@linux.microsoft.com>,
	netdev@vger.kernel.org
Subject: [PATCH 6.12.y 2/4] tools: ynl-gen: support limits using definitions
Date: Sat, 10 Oct 2026 06:51:14 +0300
Message-ID: <20261010035116.578385-3-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261010035116.578385-1-littlesmilingcloud@gmail.com>
References: <2026060807-egging-prune-a3ae@gregkh>
 <20261010035116.578385-1-littlesmilingcloud@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

commit fa796178e5eb0078a9a6c36f60fd6494cfc3f81d upstream.

Support using defines / constants in integer checks.
Carolina will need this for rate API extensions.

Reported-by: Carolina Jubran <cjubran@nvidia.com>
Link: https://lore.kernel.org/1e886aaf-e1eb-4f1a-b7ef-f63b350a3320@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Link: https://patch.msgid.link/20250203215510.1288728-2-kuba@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Anton: the generator is tools/net/ynl/ynl-gen-c.py in 6.12.y. ]
Assisted-by: LLM
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 Documentation/netlink/genetlink-c.yaml      | 5 +++--
 Documentation/netlink/genetlink-legacy.yaml | 5 +++--
 Documentation/netlink/genetlink.yaml        | 5 +++--
 tools/net/ynl/ynl-gen-c.py                  | 5 ++++-
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index 4f803eaac6d8..12c60a6d88a7 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -14,9 +14,10 @@ $defs:
     pattern: ^[0-9A-Za-z_-]+( - 1)?$
     minimum: 0
   len-or-limit:
-    # literal int or limit based on fixed-width type e.g. u8-min, u16-max, etc.
+    # literal int, const name, or limit based on fixed-width type
+    # e.g. u8-min, u16-max, etc.
     type: [ string, integer ]
-    pattern: ^[su](8|16|32|64)-(min|max)$
+    pattern: ^[0-9A-Za-z_-]+$
     minimum: 0
 
 # Schema for specs
diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 8db0e22fa72c..d2ee1199bdf2 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -14,9 +14,10 @@ $defs:
     pattern: ^[0-9A-Za-z_-]+( - 1)?$
     minimum: 0
   len-or-limit:
-    # literal int or limit based on fixed-width type e.g. u8-min, u16-max, etc.
+    # literal int, const name, or limit based on fixed-width type
+    # e.g. u8-min, u16-max, etc.
     type: [ string, integer ]
-    pattern: ^[su](8|16|32|64)-(min|max)$
+    pattern: ^[0-9A-Za-z_-]+$
     minimum: 0
 
 # Schema for specs
diff --git a/Documentation/netlink/genetlink.yaml b/Documentation/netlink/genetlink.yaml
index b036227b46f1..e43e50dba2e4 100644
--- a/Documentation/netlink/genetlink.yaml
+++ b/Documentation/netlink/genetlink.yaml
@@ -14,9 +14,10 @@ $defs:
     pattern: ^[0-9A-Za-z_-]+( - 1)?$
     minimum: 0
   len-or-limit:
-    # literal int or limit based on fixed-width type e.g. u8-min, u16-max, etc.
+    # literal int, const name, or limit based on fixed-width type
+    # e.g. u8-min, u16-max, etc.
     type: [ string, integer ]
-    pattern: ^[su](8|16|32|64)-(min|max)$
+    pattern: ^[0-9A-Za-z_-]+$
     minimum: 0
 
 # Schema for specs
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 00c05791a669..7e6b38ada78f 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -83,7 +83,7 @@ class Type(SpecAttr):
         if isinstance(value, int):
             return value
         if value in self.family.consts:
-            raise Exception("Resolving family constants not implemented, yet")
+            return self.family.consts[value]["value"]
         return limit_to_number(value)
 
     def get_limit_str(self, limit, default=None, suffix=''):
@@ -93,6 +93,9 @@ class Type(SpecAttr):
         if isinstance(value, int):
             return str(value) + suffix
         if value in self.family.consts:
+            const = self.family.consts[value]
+            if const.get('header'):
+                return c_upper(value)
             return c_upper(f"{self.family['name']}-{value}")
         return c_upper(value)
 
-- 
2.47.3

