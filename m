Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF507081E;
	Tue, 25 Aug 2026 09:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787650972; cv=none; b=jmQSx8EbtAvwOUaNzPZ5KaCIp1Pkz7Vbs/UOatlJUMZS232S1A71fCEnHcBHobz8ELM7mEvRYA9RUCxGjaXdL590njHrp5axe/QHS9fFxznF8SVSkztucjQT3hG58N85LTQg/NxWVO2VTljZ68sa8uhLoH3tV4MryDEHqkNWs9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787650972; c=relaxed/simple;
	bh=pVxHGA3zqXHOGXSpnd7EmIhXkG4JE9cyZe3/+cQPCAI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=cVzUJFjLO3h7m7CqKj1h4sSgWdFABQb/uVTPnPYks7BQU6vaPfDsgsMVmQ6q6fv4dTAD1EkEop3WEbdqaD5HNfrYfT08KKLy0Vv5BeuMdqs+vYsQ4BmZYh2MyoZY2eXNxw74kUlMad0ipatr1ev3Q+ZMpC0VAfjgKzCGLEqZIWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=nKGLCJAm; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="nKGLCJAm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1787650965; bh=pVxHGA3zqXHOGXSpnd7EmIhXkG4JE9cyZe3/+cQPCAI=;
	h=Date:To:Cc:From:Subject;
	b=nKGLCJAmcrS4K0lTJzqKGBwUVtqWX3W6gFpsxBwBXQ1upt9zSobSVr6FH1VSeu+tQ
	 zisWly4SPk2NXcuZEO5dyslPGo4aH89pWMs1qnoBlc18dHnkOTr7jzsWYi8KH5fPdt
	 i55VtfB7LCZyNDmc/xtgU9J75A4rU2W80Zd3JgyY=
Received: from [192.168.255.10] ([111.206.145.19])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id AAB28466; Tue, 25 Aug 2026 17:42:43 +0800
X-QQ-mid: xmsmtpt1787650963t0rnkclvu
Message-ID: <tencent_A16FB6B3A899F3D4CBEC0F2F5531DD502807@qq.com>
X-QQ-XMAILINFO: NHgT31LhP5vDsyt4Ui9nWbQDlS5nVfXQvp1HzMcrnlabBA2ai7jWD/FsgQTlmR
	 sGwqyxz+x+DV+5Qv6wazafsC76K7972FBdjZG1WUagDHewKYgBUAHzGylRiMloqLvPvEuD7gQX6U
	 QixqLJe+5n0J4dFF1lfopUYWYt6S079/eOhdAvwLmCznHArugPs6wMEgTIKCak41TwJ8kqF12EJV
	 jsdLTthPUiFQhK10NxY2acssSVTGnbb33xYevZBpoUuk9qFxJgbO9cBzf7nx5XnF2EQd5UML7ayQ
	 eRSdekiiDl14fFtOrr6MWvXHsttMDHFzsrs2yFJ6gllxRgiPo5CDzPlbMKsdHWEGi4lwoqKiXinN
	 K9rAHdRCEqZV/ZDUOOntEosdOMHYHIIx7awgAcBkULC6pfDanzPNPPRNaRbdcXJjfJvMS8rol26U
	 rvi8bXqHPOb0q8w9P26Qb3h37X4WeSvgRnbUfhf4o1PRqZhX7uYR0+TLD52/m8g4vBiGhJMbGtBB
	 ZPeIqwmmH7vH2zZLrEIl2i8yB6ObqaNU4jupgHLFZEB39RkgES3/atjVW4SKX4efyT/8ERMH/f5I
	 ucDvEX8zPqoByTJPquQbL2H7EYaFqt27kny+Hty1759idisbLjDr7KwwDfb2tN8ntq1rwL4D8F86
	 9VtM+XP1v3R2xrypPzGi97vTOKs2lI1U2KAfsUbh49spA87Se+siMkCy303LkzP1bapoOTLgBIBt
	 v3Cl16nDNsNIRIAr0+z9qwJlLxpuOBsAPqXu2EpI1uT9RttwUomiVOmEQfjoCbZBnVmj/Pk0RDE4
	 ZRqHuUpEZbepCg90jMpeJzK1VUTbKNF2TlgW3leu5/dZcqxHYX83NwoMg+IuCv5FuR4nik1QUtAf
	 L+xpZmUfZJVyWaGKFyyvSNOJvbYZyYRO80ytO0co8JXs2FJNdvgD9KfxdB1Dq8HPy1DEe3ywK6X1
	 HLK240NUhG1MZPDyrqM+jZI+VTxMqMrlSPGwammu9T3LAikItXO04L7EEkzdd3Bb4YO3iX6680OD
	 hrOdlKuENhmwF9KLbQnlclqPkKsBzIpdoexYw3OLgYTwnmoNNdko0oD0t6rUvGjlAqmNZVpHxSRI
	 OlTDMpD8Xv5JgL+Ewzs/l1IPFHsaq3JqrbrbQY
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-OQ-MSGID: <c2ddc98c-5041-4003-98c8-2ce69c4854f5@qq.com>
Date: Tue, 25 Aug 2026 17:42:42 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
From: Yang Zi <2959243019@qq.com>
Subject: [PATCH] niu: validate num_ports against NIU_MAX_PORTS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

niu_get_and_validate_port() obtains parent->num_ports from hardware
(nr64(ESPC_NUM_PORTS_MACS) & ESPC_NUM_PORTS_MACS_VAL), an 8-bit value that
can range from 0 to 255, with no upper-bound check.  The driver's per-port
arrays (rxchan_per_port[], txchan_per_port[], rdc_group_cfg[]) are only
NIU_MAX_PORTS (4) entries, so niu_divide_channels() and
niu_divide_rdc_groups() iterate num_ports times and write out of bounds
whenever num_ports is greater than 4.

Reject num_ports > NIU_MAX_PORTS with -EINVAL so the probe aborts before any
of these arrays are written.

Covers fuzzing bug IDs 321, 322, 323 and 324 (same root cause).

Signed-off-by: Yang Zi <2959243019@qq.com>
---
diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index 54dd7281191d..d33c87489bd9 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -8586,6 +8586,14 @@ static int niu_get_and_validate_port(struct niu *np)
         }
     }
 
+    /* num_ports may come from an 8-bit hardware field (ESPC_NUM_PORTS_MACS),
+     * so validate it against the fixed per-port array sizes (NIU_MAX_PORTS)
+     * to avoid out-of-bounds accesses in niu_divide_channels() and
+     * niu_divide_rdc_groups().
+     */
+    if (parent->num_ports > NIU_MAX_PORTS)
+        return -EINVAL;
+
     if (np->port >= parent->num_ports)
         return -ENODEV;
 

