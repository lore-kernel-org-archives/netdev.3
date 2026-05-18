Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E329248C41D
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779122454; cv=none; b=ZgT1NM4sAu5pXk44LguUPhOF9nO66BRB9dNheITaKG3KagrQIU1tjp8++QtF8FcWK6tt5WJnrhEM00iO1DT2qEREPUm616W0zJxyz/IKi/1vXpTQuVBDTUbzGmXfSmbN8cqaa4vFLm+q983X6OG9tpCPZ05p53FryHwi30oeCI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779122454; c=relaxed/simple;
	bh=TmJGcAWVQo5UOmOu/tga5NoZgiH9iADZIX64dMCrfWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJ2ivrcjPk1g1AYo1GxEffg1J5jIeAl2sWcI9TXB/DX918E+MDj1RzsOkHlcwi0rNN0SSNvBttDeccN3A8xrEPpL8Ay6aj8rBWAA1cBLkiSM4keFd1bPkoz995+G5HJMZ0CMilOg/XbGue+zrL5K7BxYSGVA/lVSfMBDetAmW0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HI1dDOuO; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HI1dDOuO"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-40974bf7781so3020037fac.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 09:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779122451; x=1779727251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9rzbyO0L/UEGnlo5xdTOZwQ03g+59F1TZtYxaJ1Kbk=;
        b=HI1dDOuO9iM29lQ/IF/PhDwjl+HWxNrkpb1TeC6mQM/cub5Nk+TBDQ81jNhbWJDjjt
         X8MLLqFG/QPKkc2E/un+0TqR4wVGLU+rAXG3brdMfV3Aqft1jP+gAL931UkPdoWympeM
         C20WWZbM8UL7XM7YtVTU5Ynr24vkwxuij7FepEjlyuO+c53mKzewewQLl1ErOVei7GDp
         zEo3BITmnZ8cNoYVeVHJG08F/rLh+u1Mn1oCTcM115fhY8MtwIF58t+Nbkmh00vjkizz
         tEABTbJqhrHcSQkFpGxDwiZvZfLuK5yIbDqEq+fUcZql5jzs51kW3Fy2PZKdkKZNor/J
         68Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779122451; x=1779727251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m9rzbyO0L/UEGnlo5xdTOZwQ03g+59F1TZtYxaJ1Kbk=;
        b=gxzkqbpNcPp4la1ee5STdXWJLG5gU3Jwl2JGHa8W4W5+NO8aj0Jf0h09lL1U+H6rBe
         mmS/PLwyBX5ZZhmP38PgdzX8JQ5YDBmm0byPnaBQu3MHcSjNLCioAAkRq2v1MMQGoFfG
         5LebPWySfECiCV8GvOmj0b6cJjbGdRLw/UQQ9GUTL9dHvBKLlf6jcI0Q4pz1nPfeZ/rG
         ZajDBchMHQCdv7xWPIVZHo4V3GNABVOjz4CN2Na6z+KRPB1k/nnoT1U8jIG0oBB2JjEn
         a6YpV9qOxuS2rCsb5gKRMeuRrq695tWKa8P9rZsfgT+E0fHv2pBYTMKT2XZwkAHrjuU1
         4gjw==
X-Gm-Message-State: AOJu0Yydi7iHUlHyJHe6bGlLKd/5HmLCFf64z9s1pwjg31pPLgTDkpUc
	Lqx2dIvNXOONt00EQey9CHICHu7AD8e3Qj/yNde+p4fXN8rMvPFjGNi+1dfEPEYk
X-Gm-Gg: Acq92OHxC0EPdCkmQflilnaNgVKOIZ1+2qZEIR0Nknk1jj3DXGn7p29wO46O0ojCnPB
	aYZB+M5u3ZNmMvrIdL5Zz+6HGsSfnhTUXhDTVYHkZfq/IfOHP2cLaBtDX6c6FjkoDdGLaKxUy9Q
	0uf3f3D6AZZyWCnvZ6ZVAdelpSmSWJ/+e+SCWGaZnFVubLJRUIFAC/yNbWqdvtZpHNOOZ7SI+5u
	VEqk8GJ13Q3T/FmLKmkD4FtOgCqOTJwnot7lu7eOxck1qG/kqqE0z8eJkQljxYLQ4FtgojpyR1i
	279Y3Tx96ZsRu2z9MsOZmSGeZjubhT8tBf09objnPU8TDOTRobvGe48049karptKmWtsPvtMKhb
	IysAn9e+ZcKTKkzx2d6zMgGoNL+TvWvUc004FUCH7q+6lDjqnCTCQLUmj2ylI1FCb5qkCCHUaf6
	YknN+7wQ2/77HOkpdhVsWbVCk7wQ==
X-Received: by 2002:a05:6870:e0c7:b0:42f:eaec:414f with SMTP id 586e51a60fabf-43a2ddebacemr8597301fac.19.1779122451466;
        Mon, 18 May 2026 09:40:51 -0700 (PDT)
Received: from houminxi ([72.244.37.221])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43a94fc2cdbsm4593877fac.6.2026.05.18.09.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:40:51 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: donald.hunter@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	aconole@redhat.com,
	linux-kernel@vger.kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH v2 2/2] tools: ynl: add unicast notification receive support
Date: Tue, 19 May 2026 00:40:28 +0800
Message-ID: <20260518164029.439928-3-houminxi@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518164029.439928-1-houminxi@gmail.com>
References: <20260518164029.439928-1-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ntf_listen() method to YnlFamily for binding the netlink
socket without joining a multicast group. This enables receiving
unicast notifications through the existing poll_ntf/check_ntf
path.

The OVS packet family sends MISS and ACTION upcalls via
genlmsg_unicast() to a per-vport PID rather than through a
multicast group. The existing ntf_subscribe() couples bind()
with setsockopt(ADD_MEMBERSHIP), which does not fit the unicast
case. ntf_listen() provides the bind-only alternative.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 tools/net/ynl/pyynl/lib/ynl.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index f63c6f828735..04743a79a7a3 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -680,6 +680,7 @@ class YnlFamily(SpecFamily):
     Notification API:
 
       ynl.ntf_subscribe(mcast_name)      -- join a multicast group
+      ynl.ntf_listen()                   -- bind socket for unicast notifications
       ynl.check_ntf()                    -- drain pending notifications
       ynl.poll_ntf(duration=None)        -- yield notifications
 
@@ -748,6 +749,10 @@ class YnlFamily(SpecFamily):
         self.sock.setsockopt(Netlink.SOL_NETLINK, Netlink.NETLINK_ADD_MEMBERSHIP,
                              mcast_id)
 
+    def ntf_listen(self):
+        """Bind socket for receiving unicast notifications."""
+        self.sock.bind((0, 0))
+
     def set_recv_dbg(self, enabled):
         self._recv_dbg = enabled
 
-- 
2.54.0

