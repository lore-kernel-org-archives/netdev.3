Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AEE3DDDAA
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 10:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784284748; cv=none; b=j+g4CHt+JuWQRq9y6ni2wydp+PfTF9iDEklg05QCLct5d2cV1kwRQXCPXBqcd7NR/0fHvM3NBL7gRwkNL4VuYjIBwP5LbdjGBFgjPQSo17UgXVDbJdYkf6OT/eXVouUGRHEMtf6LkW57etiTRVKtLS8KwZz27LVreUAGKiP9I2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784284748; c=relaxed/simple;
	bh=+zLMKrES4StXAGONdQ/PirqGxPFtSlajROJvN8za6Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uztYaoUYqkXUkOF8CUdgsG7Ijp07aKiOUjspZWavOaPNc64TJK+PL/sT1RT4EOeot+ZHUr+ZPtuepgDbM0Sax7KTdj8Tf9ye5vm0VqSXjvMqPTR6ki3PVdy0Vd1CdEMSDD2IC0FqTFoHCcqtcs4lampGeUPi8KJzbdBUA8KidTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=JXRX0R1h; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="JXRX0R1h"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-902fc790cd5so74630476d6.1
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 03:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1784284745; x=1784889545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3riQ9T4y5IQhg/VW8hsSvvb11bNPX91gfNywMrlwLaM=;
        b=JXRX0R1hWBnuUNDgPDFURiJJoOyuEOAV5yRsFXdM/4HtQ63/EMXGSU+ukIBOyCraMM
         dBAS6OWQxdMxrAlpKqu8yd8uLyhp+GyMgK9Rd81/w3gyqnYSVt4iYu6cLoG2RdAadjrl
         KKLuKO5kU/1YjSnZLYia2dBmXoI28j8G194C4MgGYUtmHreZoAeLA/CLAexRcaLIaZlM
         +VinD6JtuSWEdNHdg5A+Wg9T7wI15LAX9OH1F2XOh0Rwp8gJS3jIyL1JdVU7XVRbK9VX
         m0msFHXzFOCwNrqRrX47+XuyKEOMGJZHNgTX5QMXcPHOq3BPVkdXfSP7CIyOusuhuebd
         roMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784284745; x=1784889545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3riQ9T4y5IQhg/VW8hsSvvb11bNPX91gfNywMrlwLaM=;
        b=kOosF6shzdW0YeUhMl1X8DdpJhNufQ3KvQUZQlQdNgYHZgR2chjOswPiPcp/zV6e2l
         7fiRZK7UldjHcgzOfl4kZ9C7OSfpQYWyrVSFJJcv1+3s92DdUkTE502+xM4Bjsxc7Kwq
         Jp5t3daSCDxpIsc8k5xt85mnV0uxKxJZQDSGYMSP0rw5SNF9OmTWOu8P1oZSCLNQ2nbh
         ij/hacQynJEvv0vgsmaqutFkPb2l3/6TZDZG0+p709FD3yFy2s5x6mB1DumXm28MvMzh
         Qu6JaDxlT1mXL0FCcVI0cmiIvGapd7DhrLNvxMkATPaVnGD1cDRUHiESE/3FvLODBmQr
         gCjw==
X-Forwarded-Encrypted: i=1; AHgh+RqMZba7BD/qTDj15N1yle1oJALHd000lqk3vGz3v5wpDcCcdJeGqZ0NaCBjhGC9uXOkT2nr4RM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjPlgU23mVJeBvDo3DqD7uqmS8IPUJE8f4t+XTl3tXCekopVl0
	IDEtiA5glIj1cIkVtfXSSy/+DgmdNftEIFPEXEpqGwh4+pkxZz19cC+Q/tpy83QLriY=
X-Gm-Gg: AfdE7ckv072xpf3O3NGSIBjX5SI/cIv0LRJ9qDqGUU5Xu2zlC7+0aECLApi3egloalc
	cE+Y9FzVMLzg7FUOiZ9DwfyifosUtoEAGXvDDG+f8Hom05TTi1kac8sfBp3jq1wdEvuSRdCyjzU
	dsWs/7C3yPgvRXEAqrQQpRM8gZ4/tnIUrQZNPTTHsZCw7AmBz9HKeFMPbdsXcoNtd8XbArs8iUb
	42U9bLbF1uk2Y9H/jxRTmLNUA5kSSYqP0hPlUUQ5FOg1jO31Jwu6q/cba6pz+zEN/3fUGM4fPwU
	HkgVHaB0BogSZwtReCbmHMKJzSr03x4soyWr7wWi0BkH39rg9ADMJZ3tiDpu1LIRk2q3lyAycvg
	bDnnMzi/rF7Tb6OeVfjNaW3AsX9hh8tXDeNtpWb2X3reS4kF05YtaHQZt0e7VxlB4KI5MME8Oa6
	D8I7Y50Ts=
X-Received: by 2002:a05:6214:29c9:b0:8f0:c969:596a with SMTP id 6a1803df08f44-907784e237bmr22510666d6.56.1784284745483;
        Fri, 17 Jul 2026 03:39:05 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-9077853fa7dsm14597306d6.7.2026.07.17.03.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 03:39:05 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: Breno Leitao <leitao@debian.org>
Cc: David Lee <david.lee@trailofbits.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] netconsole configfs target release NULL dereference
Date: Fri, 17 Jul 2026 10:39:02 +0000
Message-ID: <20260717103903.38514-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

configfs target release can call netpoll cleanup with missing netpoll state.

Mark targets as disabled before releasing their netpoll state and skip
cleanup when no netpoll device is present. This prevents teardown races
from reaching netpoll cleanup after nt->np.dev has already been cleared.

Fixes: 97714695ef90 ("net: netconsole: Defer netpoll cleanup to avoid lock release during list traversal")
Signed-off-by: David Lee <david.lee@trailofbits.com>
Assisted-by: Codex:gpt-5.5
---

drivers/net/netconsole.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 862001d..ad30e2e 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -287,6 +287,8 @@ static bool bound_by_mac(struct netconsole_target *nt)
 
 static void netcons_release_dev(struct netconsole_target *nt)
 {
+	if (!nt->np.dev)
+		return;
 	do_netpoll_cleanup(&nt->np);
 	if (bound_by_mac(nt))
 		memset(&nt->np.dev_name, 0, IFNAMSIZ);
@@ -1490,10 +1492,12 @@ static void drop_netconsole_target(struct config_group *group,
 	 */
 	needs_cleanup = nt->state == STATE_ENABLED ||
 			nt->state == STATE_DEACTIVATED;
-	/* Disable deactivated target to prevent races between resume attempt
-	 * and target removal.
+	/* Disable targets that still own netpoll state before removal. This
+	 * prevents races between open configfs writers, resume attempts, and
+	 * target removal from observing STATE_ENABLED after netpoll_cleanup()
+	 * has cleared nt->np.dev.
 	 */
-	if (nt->state == STATE_DEACTIVATED)
+	if (needs_cleanup)
 		nt->state = STATE_DISABLED;
 	list_del(&nt->list);
 	spin_unlock_irqrestore(&target_list_lock, flags);
