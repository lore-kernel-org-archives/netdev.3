Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EFB32E743
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 05:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783054872; cv=none; b=bi9cqMj6amh6MRMUs5g4zsPASzgImiquvnP86d579fV7lz7J85JAx6F5mxhb4CbL/+fmgDhPwag1cBwfOBFSDNIV87oqtabKFVHNN10c0KeqUygUVVUjhV63twK/OFQQcRTGSRO4rsNP3QFKdfGHtHiMUwWKyfLUS2lVxQEQn80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783054872; c=relaxed/simple;
	bh=lvsRQxYA/4Aj86xF+a0ZvMPMqRuKaUvNmA8BkrGGf8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l0uEmspaMkowUjGKoUTptnOx48IBVhzh7b3mmBG4VzhUgB1EnxpjwyrUksq0+2m+cZr2bM65XKCFsPd7QGJ+WTc8ILO7Ge8dNPXn3ZkyemmzmUHsR5jazfAaziwA3aCGQwE6vmEt+6XlSRrqUWZd5ZqYjV+/ZY5yWeKNSNN71TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nD6UmefJ; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nD6UmefJ"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8f2509d6becso1428506d6.2
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 22:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783054859; x=1783659659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXaOhXKFNzha/+UZgRF1nlZyqJvtz4uRe3j6zG6TsZY=;
        b=nD6UmefJX+ukBfZgrRQVNuIIKVu7R4jhETCefk0whkbHzLpJBA11/qkqfk6hrR/ZEp
         fn+1/olJv2LMlyXsrdeVB07lCSbZraxLVXUN9tEG9Tr6At2zt3X0wvpKcrmrWchdhCOC
         M+yR79V7uShAWj/PJ3EolzYDCx4Ylty5U7K6Awkb5ZtSmputLSY8ZMhFf07ZJBmwhHNA
         WwZgOAJ0oY0zrW1LzGpV+OLbJSNRBN7WpWQ2azlDnt89bgkQokQ48CNkGW3eZL+iRexI
         CWb+MoJYq11TxSKwITt3i4JF30Sg2/LWROqS1dks8enfp2rfQmvL7sPVzKxdcxFdgy4c
         tGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783054859; x=1783659659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXaOhXKFNzha/+UZgRF1nlZyqJvtz4uRe3j6zG6TsZY=;
        b=FIeDi5EM649oZ//MLjsf7HaHemF9Ho3azqfoo5w9tFJU03lR2dXSXZWlx5Z8QYdKns
         DuhCF0foU3EifnAyUQKslP10BWZciW6FPRfiBXIocPUVCbyV3z4DBxT8N4prE3Bph+Eb
         JkIhAtSiRB7fhC3qns9iA/gLnH9h4346049sMs3edo6TnJdLJq/pzXEAD5rdYnw70Sbf
         cJ9Ei3EK6IfKN8HKwnduttG5jPvvm/scdY4knaqt4l9zI0Xa4jBZyvtxyIn/jYFEZOp3
         yYIR/OjKR1foISKnj7Y6Os2zakXQzO4zH8Iwq0dY8767tc+dEqCr2xY6OMdBC61v+6sc
         stow==
X-Forwarded-Encrypted: i=1; AHgh+Roor+UZXSgttecl0qpD6qOU+VaXXABdLqRSnEpb6eIGak0/i4K6dwSMOuJv9cn0S6tEUSIY76E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2hnvg9JwoczCS60csOme6goBvSqiLYpH/QLKefjCpf+ujph+U
	iGnYCkfeMV2FHFch1JVeS8W+IwMMIQwLdW+x+z8o6QPq/RtSrEX873wa
X-Gm-Gg: AfdE7cl7r2LWn8NOK6IfiuuA4x0sPv75W7SlP1kOUWDedo19zgNLVy7j0ittPpCRAWk
	eUYHNwcSdaEoXBttuVVy3snhePTmkeXsDxyiSIu13tDd2T+i9BOcBQENVsuKCTTZNNYh3t4IFU8
	g2ldRDgRwqjgEjleLb+knNDvKkzIVn3NhlHaq1rlGlGkQUt5wPQToV7B0r9Se2KZCswO+Kbsjp3
	onYx/uuTLVDfbm9sUNKNfxA5U0HCJFHwSrSfweg15gW4WBK7LLz1UhziTrZ6l1cvPFF9gi7N9Ey
	XxiQf9xzOEUYXvcNtm52vLW8gb72Kjf5hmsFHd5c3pjZcUOgWLaycG+hwh0qKaBJdO3vSYKROc5
	zB/BYPA7kSfJdRSwNMwWydoAf+eWfSwWzbBFj85rlL7yuYdA4t0NLzac8nXON7OYe47gsGPoZq4
	xcV7f6GPMrojjDpFH5sP/CMKwdwI9HJRoru5vLJEJfB8fFQdu0h1iJ+MrA3ByCE4n3gZiBug/Lu
	laRfVAzM0mX7tjfkDJBKSS8Bg==
X-Received: by 2002:a05:6214:588f:b0:8e9:f5de:d636 with SMTP id 6a1803df08f44-8f3c9cb3057mr119943406d6.55.1783054858547;
        Thu, 02 Jul 2026 22:00:58 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46e27d54asm46420096d6.3.2026.07.02.22.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 22:00:57 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v1] idpf: Fix mailbox IRQ name leak on request failure
Date: Fri,  3 Jul 2026 01:00:53 -0400
Message-ID: <20260703050053.120851-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

idpf_mb_intr_req_irq() allocates the mailbox IRQ name before calling
request_irq(). On success, the name is released later through
kfree(free_irq()), but request_irq() failure returns without freeing it.

Free the allocated name on the request_irq() failure path.

Fixes: 4930fbf419a7 ("idpf: add core init and interrupt request")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index cf966fe6c759..bb81e620c5c8 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -139,7 +139,7 @@ static int idpf_mb_intr_req_irq(struct idpf_adapter *adapter)
 	if (err) {
 		dev_err(&adapter->pdev->dev,
 			"IRQ request for mailbox failed, error: %d\n", err);
-
+		kfree(name);
 		return err;
 	}
 
-- 
2.43.0

