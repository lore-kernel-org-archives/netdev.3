Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D56F2765E2
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 23:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781393863; cv=none; b=twEODnCbQ/4bZWiWFB/lIqrPzZ2aSlqUET7HaphPOX1F2OJfoyLcPvDp45rnLRXgRKu7564Tn5kqH8set+QFwcB/IwW11Dl1JxhiAerl+mvE4vvqvnZVZH/6yQ4ifg4YG3DyrfLucyFnvkaYMf+2z80MVrDA6nS+w+ZVXZSiZh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781393863; c=relaxed/simple;
	bh=hz6zYyFk7HQyfq1WKk7VOLFoK6b6E5XOC2nsqH+EwAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RQtSpP45B9tfS2f6iDpOejypdhIDiw5LJqI23aHQYgt6zUFv0qgBTry4N+Ke+TdBwk6gtUWh715SeVjm1tWWeWhvkwJMElyIdMwo7sKvMy827slKnXHjniGxjmxCRSovj607nCSqmLCobHIb6YX5CmQPhx+qEUXRo4++O1NcMlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLRXuij3; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLRXuij3"
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-30759632453so1977336eec.1
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 16:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781393861; x=1781998661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fwbr30/uVIOuFvTEW39sce956F6NZBmS5KEMVuOXVwM=;
        b=OLRXuij34kkqHzz7cUECYOOw2f6+/t7+zH2c1crODhh0PyOVKqNIAU+lUYjMlKsX+u
         CI/esC+gCtbRC7zgh3FgzbOgZbl/GzlNGiB+xYz0/OaiH5bCCu0hyU/Is53hE676qckS
         jRfT+sJBO6Lq76wsi7Jqyq+Y3ENhw8JHHBc+vkVCpm77fRMN9Btld8M5bAvMBQvp42kh
         eBLfzXe6XCLHhpZFycnFfdCbUQTSZbGSBXdEfQ4LwanXKreQZoWm+wlVTFSuDeeIm1a7
         85MZdj9ENdDrjADeA787cKqOWJM6exbVkQ9gqWSddnKDZTUU8C8N1/AVsJ70lpb+Z2uu
         ph+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781393861; x=1781998661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fwbr30/uVIOuFvTEW39sce956F6NZBmS5KEMVuOXVwM=;
        b=eMJzU3pUXRUsvrvK7nqwy8cjL7djBUsBTuI4+fkdOd5e0WrCJB9/NtTxum4s2wW2JF
         3lzMu6CoeoDnzG/Xw9uEKWSt6Run3exLAnZuAKXdxXmRZ6ZQ5Lh+4VC9OKF0TNa9tCt8
         tDC9yav0uoGSAZABmwRvtiXYiBsC8cCPDH4b617VFMO8ZikHzkYUV9HoqMNfFWfT2/qb
         dMdvCGbXNtKqY4VX64jYPWKt8/1LqpKBgc3lfBfPOkf5Q37ZUyxTTO1Fjw4nf4DYRu5h
         NkLQxmxKGxEbl7QN+JfwcdIZPCRJaCcT0/cXcbnGCdmEQgAaN2NVgRtqE2GFznk61Y62
         4hcw==
X-Forwarded-Encrypted: i=1; AFNElJ9dhYas4B3M/zHGPD76CMWpF0P1ERvMbqEz7l0vQuuPy4WKEfvFGdyC4vrXK0bfezC82I4+Myw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUA4HSrRcztcyLSX00F6L0FBfBTDH8rCC3U+gz9jpmsu8VK35P
	AgvHBYdV/oH7qvHuOQsL23ZP2XGX95WkD1cHtP0iF8B/DHKIR9kik1fg
X-Gm-Gg: Acq92OH4NmCgMYrebVE+ENM4OoY5JVSHRHenPB6RcAruvFpf/CYktcvn0oqkZy0lmkL
	kQ3wqTVQvWCLg4Y20xia/aMPpHje/XkRvd/iwuocmUnrDd+8SP3QXqdsW30FdDy9k5AXgEqpYjK
	Tp/FEDR+WPhf7XtsRXj9uICM2u1Z4mPuohlR8BU2tTcOCYfGoAwD2PaCbnZnvm4WZaP+ba+TTJS
	3gfzHc1SXmDjuZ9Ktrwq2Ee8E8Ss7lqCaP0cePdB/Wv9P0iAPL8oi81Cysh8UAk0+lwNGIrAXz3
	vJG/Qe51HLH3lDxqYYKYhClFo4ZAprh3xXMcjX8L2fl5VvnrrpxkZ1cJ9gL5rIt3w0+TmNMAszG
	R94zuaruB2851a21QuGgjUcK3Fq8eguiwh/m6dVVwMR0r0DZGNqK5NcXJiu8Zp1nhKxU4le0eH1
	w8tPBZ21wZpYzDWXQHRlIYGU3c1NdsFD4WUAdP6dF3hBU6nSulQIRtsrpPxCV3BflGkw14pfFcO
	VT2btRlLBLBxXezmwsJ6wK4fyZiaziq5oR8Hm2H8YGdVAmRhrOIq1NLBo0Fjrskw5XK67sTirOD
	7gdpngKTzIll7EyvkUnwL5nt4ZCU
X-Received: by 2002:a05:7300:a599:b0:304:dddb:f8 with SMTP id 5a478bee46e88-3082026a517mr5088995eec.35.1781393860695;
        Sat, 13 Jun 2026 16:37:40 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e4898c0sm9453982eec.3.2026.06.13.16.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 16:37:40 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] sctp: correct CONFIG_SCTP_DBG_OBJCNT macro name in comment
Date: Sat, 13 Jun 2026 16:37:25 -0700
Message-ID: <20260613233725.162470-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A comment in <net/sctp/sctp.h> incorrectly refers to
CONFIG_SCTP_DBG_OBJCOUNT instead of CONFIG_SCTP_DBG_OBJCNT. Correct it.

Discovered while searching for CONFIG_* symbols referenced in code but
not defined in any Kconfig file.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 include/net/sctp/sctp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
index 58242b37b47a..60b073fd3ed8 100644
--- a/include/net/sctp/sctp.h
+++ b/include/net/sctp/sctp.h
@@ -303,7 +303,7 @@ void sctp_dbg_objcnt_init(struct net *);
 
 static inline void sctp_dbg_objcnt_init(struct net *net) { return; }
 
-#endif /* CONFIG_SCTP_DBG_OBJCOUNT */
+#endif /* CONFIG_SCTP_DBG_OBJCNT */
 
 #if defined CONFIG_SYSCTL
 void sctp_sysctl_register(void);
-- 
2.43.0

