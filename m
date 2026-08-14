Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EACA37F31B
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 20:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786739276; cv=none; b=aoIPo/wz74niuryPzaKPRE8pqqqOlClI73pVHWMFqhIIOWHMqlmXHuP61tamjuOCmSPyxD2euu3LqQxr1A4cLZTvMAeeIwbTJjqeYkEKg9lJBruncbu1XzENy8RRxL9F9Wl5WHk3chBHwbUXKn/cmnZMGlHWEK43NAMQfqrh7CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786739276; c=relaxed/simple;
	bh=HFXSVOgmCdmw3rAs3NeHiZ5PVmxyIWzkuC2DG3r9bQc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Qy5B1997jLNpBWPEkJD7yMBlNZ+kasUBjoS0bdFQRjo8ohUkqNu/+04VRBHP9l+oVP4cNZ6FeNkRKMn72xzcz1JIXeyy2PCp2ZLvSO+/CsA8RHrcyjSDugxuwKqPaIvkxKYIwcPww/Re128IiRdidG+1sa8nH0MIbcHSs3xtz8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kr43rJDC; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kr43rJDC"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c9fe4c5eb39so963517a12.1
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 13:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786739275; x=1787344075; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UPJWlKjLv6ZDAjliELzzhodIr3XvyErgyPYy/hwtGcA=;
        b=Kr43rJDC5eXIUi9SV0IMcFOocXgllX/ht+gOXq9asjegVngmv1/VPC1XbY3vZ2Y8M5
         WhFICzvLszHUh+1bjrN2I6eExM/n/XcPnKU0YdGDlfSKkw5hdaC44MyVL2cxFKTe6niD
         +52GwQE6pFByRyDRxuuQRfUSZgQRtX5QQraBtc+Pfa/B7NouepT+uyMvnUkpgul34BJo
         vX3eyk/tetWa4T0rcuSIvYV/iCHFOZwzgJQt/egHKOCsVF5osY5CCkheWr7D8rftqbw8
         s6Ukppsan5SCXVwzctPZyEg3ug7sGLQZENV/XsVXm7dJo8DgiX0EwkvCYez1/oeFOSgt
         CFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786739275; x=1787344075;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UPJWlKjLv6ZDAjliELzzhodIr3XvyErgyPYy/hwtGcA=;
        b=bYfFAM71lFp5+65rUt5a+SQr7zjOYtsKHXVWqxCwQKPHIp6gmEPKwM3J3HhHV3Ki/0
         we/wOeHSFOgvppLHu0KlEVe+CrE5OX1JpeD851JQdErll5i1cPtmHD8VRcNSEfp2GGcp
         H0eKp+i36qkmdZ8JbQb4p3+KsBb9djDeRc/QJ4wdvMPEeZWots+PAhh5lVsZTkmm0nqj
         y34c/PwNy3gIcAEupdvC4fLh8WMiBR9/1OenUp5xHbdSlERTFXvrQXQ32dw4qoG7r+yH
         egqRvcnqGMhaB4ZI+IZASfrpQMLHZMNN1APRVRY2LPieSm4ecmH2YBxrszMqZL6WD0H1
         qudA==
X-Gm-Message-State: AOJu0Yz+QClEIsEVfEREVOW7N7g2ZJZNRrFc/Hh2tONpG1jMWL2DdO6x
	X6No+k9lajfMpf9xENLdeel8s7HqcFGplGnd/dg59ajmtsfYAc4QA8Cx6SCn1pgNRSNl8VwI17a
	ntxwDhv9BkbFups+6d5FQ6uYjF2SIlFvb4RUhVjdSliF+44TRJ4vC3qgKlywhEBmwOt6H2X0pnh
	/koCqtKWGnCFICWX/Ztld/vGJUA0wssPGxcDvUfOwYMrnOsWTRvfvVny7E9pQWea8=
X-Received: from dys15.prod.google.com ([2002:a05:693c:800f:b0:30c:5c4a:b8b1])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:728a:b0:3cc:51ff:c2e7 with SMTP id adf61e73a8af0-3cc71dd8814mr8340939637.10.1786739274588;
 Fri, 14 Aug 2026 13:27:54 -0700 (PDT)
Date: Fri, 14 Aug 2026 20:27:32 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814202754.433725-1-almasrymina@google.com>
Subject: [PATCH net-next v3] selftests: drv-net: devmem: fix 5-tuple flow steering
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Breno Leitao <leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"

`check_rx` sets the `flow_steer=not hasattr(cfg, 'netns')` kwarg,
which signals `ncdevmem` to attach the client IP as a param (enabling
5-tuple flow steering) when running on the host. However,
`check_rx_hds` currently omits this kwarg, forcing `ncdevmem` to only
support 3-tuple flow steering.

If tests are run on a real NIC that requires 5-tuple steering (e.g.
`gve`), `check_rx_hds` unconditionally fails because `ethtool` rejects
the 3-tuple rule.

Testing on `gve` with `devmem` enabled shows the failure is rectified
when parity is restored to `check_rx_hds`.

Test results before this change:
 # ./devmem.py
 ok 1 devmem.check_rx
 ok 2 devmem.check_tx
 ok 3 devmem.check_tx_chunks
 # Exception| CMD: /usr/src/kernel/tools/testing/selftests/drivers/net/hw/ncdevmem -l -f eth1 -s 192.168.1.89 -p 39105 -L
 # Exception|           Running: ethtool -N eth1 flow-type tcp4 dst-ip 192.168.1.89 dst-port 39105 queue 15
 # Exception|           rmgr: Cannot insert RX class rule: Invalid argument
 # Exception|           ncdevmem: Failed to configure flow steering
 not ok 4 devmem.check_rx_hds

Test results after this change:
 # ./devmem.py
 ok 1 devmem.check_rx
 ok 2 devmem.check_tx
 ok 3 devmem.check_tx_chunks
 ok 4 devmem.check_rx_hds

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
v3:
- Sent as a standalone patch. Dropped Patch 2 (gracefully retry bind)
  from the series as it is no longer needed.
- Dropped the 'extras = [f"-c {cfg.addr}"]' addition to ncdevmem_tx
  as it was unnecessary.
v2: https://lore.kernel.org/all/20260803181852.491437-1-almasrymina@google.com/
---
 tools/testing/selftests/drivers/net/hw/devmem_lib.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devmem_lib.py b/tools/testing/selftests/drivers/net/hw/devmem_lib.py
index 3554954a6691b..5a519713b2769 100644
--- a/tools/testing/selftests/drivers/net/hw/devmem_lib.py
+++ b/tools/testing/selftests/drivers/net/hw/devmem_lib.py
@@ -306,7 +306,7 @@ def run_rx_hds(cfg):
         port = rand_port()
 
         listen_cmd = ncdevmem_rx(cfg, port, verify=False,
-                                 fail_on_linear=True)
+                                 fail_on_linear=True, flow_steer=not hasattr(cfg, 'netns'))
         socat = socat_send(cfg, port, buf_size=size)
 
         with bkg(listen_cmd, exit_wait=True, ns=netns) as ncdevmem:

base-commit: 9958e69b98930834a576e156f6458166d1db1c02
-- 
2.55.0.691.gc56d675ccc-goog

