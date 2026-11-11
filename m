Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419260;
	b=jovwq0mq1RZLMGe86g3UcOqtxetYF8hH1pqZN0VgN8TSRtdirGlr8Q9BdCSmVcFo64rW
	 5v7qJBQMqulHUxGwDWWGZoV0+cGJ76f9khBoM3WkhQgidtWzBb7DoGAxjx5U89FBJSfGj
	 3HJHuXJk5lFzEMaaXbG44JjWsyk3oN+pKPi7yahiQO94983CmBjwX9GyJAhEnGb9A/VmE
	 Y05q4zpNyEPLBKfWv9x9MCex4lkO1zHi6B6cd3jSNN1nkD2DlphvUhz4nPTAHg/y6aPz3
	 5uaiV92D36v2HFrg01mzW6lv6kywxN61wMXwvEP285RK+9hEftRsvwNxU5k10iF7Tqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419260;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4MaTdFGm3iwJfcX3VGdFborPM6URWf3gTu0u7KO9Lxw=;
	b=qZX7rfWF3ERiqfYc3jh/JIAQvwBApZRZ10T/+n8rW79+phk3SLkcGLS/cgmQnZFhuLl3
	 XpOcg7+lvNI/1QLOoC/ksermNpWi+B32lyc27IbLz4zFO6cN59pCG9qDjNMIQVYLZbE2U
	 CHuWMshjzwOrOfGmZgL8ljB/JqIVx3jF2DTw+ZKzhfpY5vFdXXr4xsCpKHptrx+1OnU2g
	 eDuMQP6kbw2ErjJebqfmTLjeUwTjSd0aCAFrQ7qQ1LLPrE87k29fS4fQIjhWfrkZ5L+cG
	 pwII6YzsOv3EWDETsOirfTfY4PkNx5vdhIhCG+zhbVZ49dw0igGZ2WX5Z+h1/JTXVBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X9iQQDXK;
	arc=none smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EBE606A324
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 17:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7EBE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X9iQQDXK
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-67c0ffaae1dso86573d50.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 09:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794419259; x=1795024059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4MaTdFGm3iwJfcX3VGdFborPM6URWf3gTu0u7KO9Lxw=;
        b=X9iQQDXKuNjq+myrwm8V4PXdcRhRXJAvcHYei6UT/AUaVZFNEBxcYcvMm86gIAU9sp
         9fiv5DnqAq4z5pG4pFLxxnLrVyiKu7DkyjkiZx9kEWM3cBVIz495kFM5maT2g9nuweDC
         b72QIY86lc9LZwtjGAC2uYkst3x4CwQzwWb1nGOpDOEATGbdtF6jp18tvNljPOKs4e+O
         WW5cNYpzFY8lrKExK3+jIhhthMlMGOIWh28yvumgj5zqcB6L77liKuiOLthogauVjPAq
         P/0go/3r66tFxEICnaM12TEa4SgzEBr+7jQkMyBdU0xO6uXRzzVAgeyDQA8pMG6ZqNu6
         5KSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794419259; x=1795024059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4MaTdFGm3iwJfcX3VGdFborPM6URWf3gTu0u7KO9Lxw=;
        b=AmzEacAKOFbxER5yDbRz8xUi7+h39TUDSgOG87u/lxrBkwitEDfeFgsjLH9r+j5Cfa
         dmo8CSFDLgmZxV5LXZGdxynGgpjn+pU5VYkkmu58EUr4NU4D946Z8gjpeusiBODtn3a0
         CWfWOvA8hMk0AEzWzV0IlAhhXCeZM4UqBVj6liqguT+qTQIvkWoJYSSy3kScteO6Qqm+
         SNQPYE8i68SG1v5/wxfYSVGlhdy+t2qHFcfbqRrjkMpkekS2uxvKhFugqXHZ/jY4mfAr
         qig8Ryz37WGA2M9uEdBAptSO0/nqoyH3R203drBMLCVe6t185c20zR2dcOIA4tzRIoAG
         R1zg==
X-Forwarded-Encrypted: i=1; AL+hErHoRJe4WYkf7vD7pEPWSCad+TaQaGz0HBgJ1e7B/+P18ICVP58T/RgMOOKYqhb/hCOeX20di6k=@vger.kernel.org
X-Gm-Message-State: APuU4Z+8zAXwEF0AZSDiv3LEfkcfF1xTYtZZ3Sn5JmNa0w2b+TWQ1FM5
	SMWZWgyo1HoPJ6dC3WPBupa9xbIFWJV99lgbypIpNFrqFDjmbPwb21Fg
X-Gm-Gg: AYBFou2eL/gBSs1aSGPiVB4vqrkfiRR8AZuRK64hOPFYk79cArpKqebFiEQzzk56iT/
	65Ekch+yWL0Vf8n2cFhlUbc+Oq94sNLuxe9jiedfGtQtpLmKbbzutHf3wS3ot9MO2ORe1M+jqvt
	GSKdFXOMwtohUIGvuOZEIAvnDNiYrWn4Mg91nhJiY/ixzhdse8mJb+pvQ0Vo1q3B+8rFjy5fpri
	AMwMfAZ1AY6LNflWhjpef+slBFa4yxR4Q+ELrIF8VlHjUvdNFABlmadMzFUNYOx3gW9hpxyYcUF
	/ej5ACmmbS0vcXCvsDfyiuv7n+GMMuiwbJq1jJHaEc5ZQvbiKFA+KY2MPT8m1GXP6whNFjN3VbX
	6ZdfMRtbpJir4oUOGjuqWByl+uoh4Le7m/tzNslxjJLVIpa+pLBlM0CRZbKeUpW1yBkxTTwhj9J
	snk+Iu+9iXoHhJPNkIl3pCjZTUqDC9nPPnFf4pwnUnXrHFSas0vXx0t3PqLl+taEwtI1GdvOUPB
	vbY7IJczop1e/rj8Y0WEg8BURTmdA9ibBgPbLtCaaMtr25wlHjeWxlZUWfNqOgRHKCpgEZdA/yT
	puJ5U1EnYp1aqHh2uP2BgY2VOUmXcN/RtUZbMAPVJPzLMji+b3UdMw==
X-Received: by 2002:a05:690e:dcf:b0:67c:1fba:b450 with SMTP id 956f58d0204a3-67c788aaf25mr106177d50.16.1794419257699;
        Wed, 11 Nov 2026 09:47:37 -0800 (PST)
Received: from VPN-156-197.vpn.usf.edu ([2607:fe50:0:f802::4046])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c589c6f24sm5077708d50.12.2026.11.11.09.47.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 09:47:37 -0800 (PST)
From: Juan Agustin Niccolini <juanagusnicco@gmail.com>
To: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	josef@toxicpanda.com,
	jbacik@fb.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Juan Agustin Niccolini <juanagusnicco@gmail.com>
Subject: [PATCH net v2 0/2] tcp: Fix the SO_REUSEPORT bind cache admitting a conflicting socket
Date: Wed, 11 Nov 2026 12:47:02 -0500
Message-ID: <20261111174704.24312-1-juanagusnicco@gmail.com>
X-Mailer: git-send-email 2.53.0
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

The SO_REUSEPORT bind cache (tb->fast_*) can let a socket skip a bind
conflict check that it would fail, so an unprivileged user can bind and
listen on a port that another user is listening on.

Patch 1 fixes it. Patch 2 adds the reproducer as a selftest.

v2:
 - Shorten the changelog (Eric Dumazet)
 - Add reproducer as selftest (Eric Dumazet)
v1: https://lore.kernel.org/all/20261110080008.26112-1-juanagusnicco@gmail.com/

Juan Agustin Niccolini (2):
  tcp: Fix the SO_REUSEPORT bind cache admitting a conflicting socket
  selftests: net: Add SO_REUSEPORT bind cache test to bind_wildcard.c

 include/net/inet_hashtables.h               |  2 +
 net/ipv4/inet_connection_sock.c             | 15 ++++--
 tools/testing/selftests/net/bind_wildcard.c | 54 +++++++++++++++++++++
 3 files changed, 68 insertions(+), 3 deletions(-)


base-commit: 19a227903e65c7a9c179156485660a4e017575fe
-- 
2.43.0

