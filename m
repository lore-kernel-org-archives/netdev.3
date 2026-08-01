Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398D82652A2
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785589943; cv=none; b=s13VsoxZXvkcc1gcKrkLAZb37K3oaEtqxidPh/tzlimgNYsBY5BhdljnLdiZw1vs7ljZ52+NdSGTH5PKfJgwjONnXBo2viQmOkDezHO7R4OBp81pQqbxIIT/wHYRCi3ulNtYMgQi2MBFQKi0s4H2MEFY/e7+QMuDlVVrz5IP4cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785589943; c=relaxed/simple;
	bh=Jwhl61kBPcWHcrWGP9ed5EM5DNox3IfkjZYxA57+8Dw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=T9ygSh67miXFH4jaNrU391eHivhsVqHE9czb0IMiOcSQk6NafwkWQV7fb9nYP+RBPvUQaCI455q/GA1FM0mfXh73RlrSjwom8IjbYfyoBhnprZwM0ryu4RNE0fnRedofOizYOARedcwPjEt0iC1fxSZq9sOj2LUtEFD4EJ5u6GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dm0gRVGF; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dm0gRVGF"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d04908139bso25057245ad.2
        for <netdev@vger.kernel.org>; Sat, 01 Aug 2026 06:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785589941; x=1786194741; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6RppEaYP0Ab3EDNRnjLFTs8JBEizKeLue9DyTxW4168=;
        b=dm0gRVGFp5FeckQWXkwOxH0ZH7o4QZv2XURCzA10kXF6TgjjkDMERFDCOLvEZO3Lrt
         EpV72OseGqsXKsHKKd3cApLN3Ld58HDugEmFyoeK7xYwuta95DII676uoZSrV5K4n5Gx
         oJreTHkRihWFEhlG3xD6ON/6gpYbNDTcauJduA3PdRHEGwLMJqszvIrRqq4LtBR5d2/M
         MDBEqY0ndJUkFLCFTTvH/0fgZQQkiRQT+gNcqg/X6hXk2+0EqXUu6kY4d8+1QPWgP97A
         9g+mpSiR1L1oQ6v+4UcvEHViIihoZg8jHkVErOSx/CPJAS32V7Mht9OwUeF7Q/lmqy9i
         0UUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785589941; x=1786194741;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6RppEaYP0Ab3EDNRnjLFTs8JBEizKeLue9DyTxW4168=;
        b=pIkHejRmTm3XzVbqZWodw/mpY7NAMZDuNIoLo09Q1I3/5utHOCZZlpdMinkz2Fk+Ub
         7zsc32M1Z05gs2mpPlCGlLkqZwPmSiTi4jau53KSH/0yzrSv0LToTnzjt9oFPK/TnWqp
         1iow6L5g+vHqZR1EPjEHbnNd4C3CY3yWBDZznCEmlh0OBB0lChm5h8JeAN7JFBR28dTL
         LRfW56Tv3Y56DyWKM/xA3+FzkmC8mmpWQ7iAEJyPchLTJisVWM8Jf9XlOVDx/38/UaZ7
         DN/ALJwWOz21mLQTSEYSGTTlx5+lDaz5Yn60fQ7PJGZx1W6iCQKM2V/5FU8HRrkxv64U
         TfQg==
X-Gm-Message-State: AOJu0YxEniYqostna62UisFNP1g2r7FuCl6h6Hun9+nbz73it6FMFhEX
	yUdYrlojnz7DmOKlsGq41dKB/5gv36hUTMuhMRzGqLBVW1lgFJPANIxtM8p4d0Vn5Su6uKbRrhI
	yyITuw/4KyVXDIbWSKuPsCVrb+tu5GNAGTO0/13P3wtu5aa1WD5ftkMNS71zWjb9SZlKPwud+VC
	DTSvi49ONVydx/wk7lrY4QUmhtOm3jKrno1yrBaDwcnwYZjuGvhYG7XzenCP/vUFg=
X-Received: from dyff25.prod.google.com ([2002:a05:693c:8059:b0:313:d014:d248])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:37ce:b0:2ca:1479:d9dc with SMTP id d9443c01a7336-2d05221d3bbmr34491815ad.12.1785589941151;
 Sat, 01 Aug 2026 06:12:21 -0700 (PDT)
Date: Sat,  1 Aug 2026 13:11:52 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260801131220.1367229-1-almasrymina@google.com>
Subject: [PATCH net-next v1 1/2] selftests: drv-net: devmem: fix 5-tuple flow steering
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

When configuring traffic for the devmem tests, 5-tuple flow steering may
be required if the environment does not provide network namespaces.
Pass the correct remote address parameter and fall back to 5-tuple flow
steering if netns is not available.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 tools/testing/selftests/drivers/net/hw/devmem_lib.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devmem_lib.py b/tools/testing/selftests/drivers/net/hw/devmem_lib.py
index 0921ff03eb81c..3ede6fd426929 100644
--- a/tools/testing/selftests/drivers/net/hw/devmem_lib.py
+++ b/tools/testing/selftests/drivers/net/hw/devmem_lib.py
@@ -111,7 +111,7 @@ def ncdevmem_tx(cfg, port, chunk_size=0):
     else:
         ifname = cfg.ifname
         addr = cfg.remote_addr
-        extras = []
+        extras = [f"-c {cfg.addr}"]
 
     if chunk_size:
         extras.append(f"-z {chunk_size}")
@@ -212,7 +212,7 @@ def run_rx_hds(cfg):
         port = rand_port()
 
         listen_cmd = ncdevmem_rx(cfg, port, verify=False,
-                                 fail_on_linear=True)
+                                 fail_on_linear=True, flow_steer=not hasattr(cfg, 'netns'))
         socat = socat_send(cfg, port, buf_size=size)
 
         with bkg(listen_cmd, exit_wait=True, ns=netns) as ncdevmem:
-- 
2.55.0.571.g244d577d93-goog

