Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F7932720C
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 14:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075173; cv=none; b=l3a/FYeunDc47am5g08qFnVZqF5Ct6Tu7yT4nfRGvn+XL2rmYdsq8UYp53V1+lAG16lQHjpAwEeoT1T8/Q82dugwDLKiGfjZ9eBeVu9z6mwOsqDLycQN2x6FMU43Ss5XRv6pLWM6V75xgJig62MUrKJDXYMgUa1V856XRAcaRmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075173; c=relaxed/simple;
	bh=W1wodTpL7lhoNUJmZuZL2Bx3zPH3Cd5qy18LqLi+Bbs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SlUURYCCXiw5yHhHxmqZx2vrMIUkypOSPna0+r+wFBV5po3CqcE3YJXtKLcg3V56ws9CtCTOkaiMm0E4ovCSkPvUH5xdqqVj/TZVVR/GpMNcbyZC7vJDuyiTs0dWU7MuU5brLrtHjKDP/MED1fYnnwngDLWh1Ks/gQaOuLs6/dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d47RKeD3; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d47RKeD3"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ac7842c17dso1051307a91.3
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 07:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792075171; x=1792679971; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LOxqF5LKZfh9qAvCEeNs0eU4LzOogSFcT8wEusw7IS8=;
        b=d47RKeD3YUjLnLzqdQCEzJX428PMV5CnNX7hNk1hMqlJJHouwM6+D9maaAzrRcdlQu
         qCDJikxt+//BoTAh3uIn8eZRNWLbIUwvN6nYY+18ACmy4Ll7Jjss+X0qirJmTGeApA6a
         agMYZuJ/p6aYu2P22RX0RznI5FYRR9Mw4TT+XAZ4L+xWIUeoqvwt4MCg0vgFqiH77PsI
         UyHUK3FXABncQxb496L3oeF7CmTjI8W/F3BTOgXs7OlUf+e0Y2k+yeuIVMMzZuSkDJpu
         itx1poS7epIJ0avFSovbWxfPWLpKOqt280ATGpukHSoCdHwU4zXTplShXgYj9X6Ug3Db
         0dRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792075171; x=1792679971;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LOxqF5LKZfh9qAvCEeNs0eU4LzOogSFcT8wEusw7IS8=;
        b=GhGY8aFRMy0NUafkaOQJc6HaRhTmfvyWOiF1SdJshSTkSP5jxSPj9734oC1WlLHwOk
         ckfXjASV2yvemP3mKr3GHbqOLQ2jnjy3bccfdSdU64PnJmaWXz4KC40nVYWNlPRAvUKx
         eYsNIR8xX/vSB7xTJppD4oX6tNXYyPsSj+xdj4qYLQA4aJBhYoijqvQsIfjLfJIKaqFW
         HMJZO6miL9jkWFtfiF5aXotwjpCnIUZEn6I1kayLh8qRQ9miy3SvO75eyrF3YRzeVSb+
         zAByOLuFru2F/luXwmcbJP39rmezMLpH501OGk8nKvcZLL3zH4y5/8T/+7t8bfw1mz0Z
         AP7g==
X-Gm-Message-State: AFq9FYKgvB64U5gYdBTCaKJb4+951gw/JNZgNXlPSlsqRgTBqQeGR00z
	JLjojS42MsZT+soBx++np2XAn5IPEwLhtRC5LxMcOLfIngY5z9AE+sB0
X-Gm-Gg: AYBFou0Nv7BjXx3Hq9e57C/Y5mfE+8i6qTCxWC7+lHLhPmfB+UgmKIWeIhkD1UovSk5
	2CJwF6HZ15fbi/WFV5PrNYi9iy0x12rg84aK02XBAXy96Ln5F1CHNTCVvt6ldCwsRwrIKtatdvv
	FWZNfjTFVpj6rTKAFrmvnXhAcP/FSGIduKTxotQjHnlfcs+gv0jMRN89juJ2sSeHBd6B2FTpLDT
	tH6oWBwERSUP0U6OkzkLqc72Y+tyWSUSNDtH13xEJGmUUgJdfRIsOsP6N71k1WL/E04dw7yDPL0
	1uVD39bcaAQiymx8m06T+JYt55ooM71oTevgQnjYP/SWdHh8CKH9kLkgcAZ328+3RjnGEEDxqif
	5ZKCYZ/nHieKChaRXaWudX/w5tY+aLxNFWID01JgOCMWs/FohVO2X8G6mkLK+/jzDSdHRmQbUnl
	vMILvmCNoIIvBM8i56hR20CkDCdzf3+FN9Hn0zqdqI5wnFj6WpQyMxQrshf09VkHwpo0Ja6dlW
X-Received: by 2002:a17:90b:2e08:b0:3a7:ecab:c4c7 with SMTP id 98e67ed59e1d1-3ab3a748058mr17498873a91.34.1792075171265;
        Thu, 15 Oct 2026 07:39:31 -0700 (PDT)
Received: from dev.local ([163.43.243.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac9377fe6esm2583465a91.3.2026.10.15.07.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:39:30 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Subject: [PATCH net-next v3 0/2] seg6: skip route refcounts in seg6local
 lookups
Date: Thu, 15 Oct 2026 23:39:26 +0900
Message-Id: <20261015-seg6-lookup-noref-v3-0-6d51a60a67d3@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ7l0GoC/23Nyw6CMBAF0F8hXVszreVRV/6HcQF0hCq0pAWCI
 fy7BV2wYDmPe+5MPDqNnlyjmTgctdfWhOFyikhZ56ZCqlWYCQeeMABBPVYJbax9Dx011uGTIrB
 EyLhIABUJuS4s9bSZd2Kwpwannjx+Fz8ULyz7lVx/a+176z5b/ci2xL8pPmgaGQUKkmMm0lRgB
 reqzXVzLm27+SPfCQyOBB6EmJUglZIZk+leWJblC8mNa9YQAQAA
X-Change-ID: 20261004-seg6-lookup-noref-e016495b60ed
To: Andrea Mayer <andrea.mayer@uniroma2.it>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabriel Goller <g.goller@proxmox.com>, 
 Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1488;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=W1wodTpL7lhoNUJmZuZL2Bx3zPH3Cd5qy18LqLi+Bbs=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBq0OWfbK2NYzw84bXQ2OFuANgXGa73rgUAYOznk
 LQf5YSYq0aJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCatDlnwAKCRAq19F1Kl0b
 TS96EAC5b9oqsq/iCdjheRdXb7UvofTsEoT6ESTpGrgKZNije5Ocfm5LgUmZsRXhWBvn6F4qC5L
 tgUQ4wRJVTCbmNmr18nSNxsWdA0hRb39SCgiXe9Ae0O98tdPiyXnSkAPN+MCCzf2xblK63/Dqbw
 xJoBkoVdhYlSkaUotW95zvOX/S4teDP1USYEWiRx7wpxbekh2+FOTBkBwvbuFkO8AZHY1pGQN2K
 r1asAn2O23e1VxHkodEvBlpqBUAZ/vkb81ScKX8lpf3mrtxg02rzvUIgfKYHzf9ElJYLn8aZ+Np
 WoZ3uHYac/uZwZiaKLxtQ79+vWzKAh0KMug7F+6u/HR5j8ai2D/Fv21K128ZMDb6gK92d+AAdci
 udZ8skffoc5b0QK5sY0SQIvBKnO/x+z46BttTofzKSscn2XIoBXHeBNXFTQxcfqhbZJfqObc7lO
 DS+btVGE5pf7ET8yj6199GyjD+AW31N/BxO6DyUaK+4s3Ji2sh1HFmcndM2tNCLJkuCICapv+Ey
 wJxDh9wDHdtTbnPLISkBhzmI2y26/B5DaIVj35kXBB1MZEUgOFMwDXo8gnL3TR0c/8dM8aTUvj/
 1WmEsuy/eiF4+i6Sd4RJZt4ImX2i2EsRwfOGwS4DMjJIRqmjjA75RSQKPP8zO8sArwT0dXxPcaQ
 2FthErHYNkmaqFw==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D

seg6local looks up the nexthop of its IPv6 and IPv4 behaviors from the
RCU read-side section of the receive path, yet takes and drops a route
reference for every packet.  Skip the reference, as ip6_route_input()
and ip_rcv_finish() do.

---
Changes in v3:
- Keep the refcounted lookup in seg6_lookup_nexthop() and give
  seg6_lookup_any_nexthop() a noref argument instead, so the BPF LWT
  helpers see no change while a route is released (Andrea Mayer,
  Gabriel Goller, Sashiko).
- Mention NFQUEUE reinjection and the release race in the commit
  messages (Andrea Mayer).
- Link to v2: https://patch.msgid.link/20261010-seg6-lookup-noref-v2-0-51c09dd98197@gmail.com

Changes in v2:
- Split the lookup into a noref primitive for the seg6local input
  actions and a refcounted seg6_lookup_nexthop() wrapper, which the BPF
  LWT helpers also call (Andrea Mayer, Sashiko).
- Rebase onto net-next and re-measure.
- Link to v1: https://patch.msgid.link/20261005-seg6-lookup-noref-v1-0-092e84774e80@gmail.com

---
Yuya Kusakabe (2):
      seg6: skip the route refcount in seg6local IPv6 lookups
      seg6: skip the route refcount in seg6local IPv4 lookups

 net/ipv6/seg6_local.c | 52 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 15 deletions(-)
---
base-commit: 758fe10f83a655bed0f7b98fcfacdfc3556fb9a1
change-id: 20261004-seg6-lookup-noref-e016495b60ed

Best regards,
--  
Yuya Kusakabe <yuya.kusakabe@gmail.com>

