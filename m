Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3744F4195DC
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 21:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786482052; cv=none; b=uAIK+FeqPML7BYlJwRxAUwh1PdLoZi3ZwKGb0+HcctAhNOGlXo/ebBF1nb03eSrg7LshvVr1Vn9DNUs+ZlYrtu5rlTgTbXDqWBho0enCsR0TbxYwXrdl08XRLtT7SU9XZySJIIrkfoMgJTXPiOy606Vy9QlcGjNS0henC/tG8vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786482052; c=relaxed/simple;
	bh=DHZeUSZTTSX7z32SiH+oih8p4TW3kYdEqSl1SPBOCc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNM6ElyyAxnlm6cXvBWtsKyWLJI/NJ0sQC5UyNjzMj3+OOiY1pHaEG8YIr3L5UaMXB2aFOvUk+CAFC1OYPc3p2fwARjbqW+H8PGE0QLk56tkO8hF9R+hKFYX/Gvm/92T65UkLZOB+9tV/oVNvtYOK/QLSai1f3sG6uypE6/UBSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Av4x1dfq; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Av4x1dfq"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cbedf433a99so202774a12.2
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 14:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786482050; x=1787086850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zdl3WKJSZaIAl32/kPw7PkLAafvF1qJSXITcCb18upg=;
        b=Av4x1dfqVUu5MH7gQ38hcrBwbCm9ZrZl9ZQRFGyD9T+YbxPRSEtVUKrXUBIpfW0Jx9
         U6O7wUZGi85JMy968/usBUrRrR8pji1elP1vqfnIPAxRRkMcVvxBE4Awj1P6e/JZmf5F
         JUZ3Ez92WgDPVhrSlWoP5dVQGi778Ich90I+LL6m7RpKGt3+uLdyq+C4tO8c5SC9cnqL
         Z+GrisGaztw6wPQaeTCCclEQFWPK6AnhlGUv9PYN6PpmdF3G6l8BCr6y8TuKj4JRkPN2
         jdGuBOyUWQoJYyJ/b89RLCCHXrOxpJecnM4ZuiwMaVuI4C8hofc1z8XKVmIYPUCRbqPB
         t0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786482050; x=1787086850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zdl3WKJSZaIAl32/kPw7PkLAafvF1qJSXITcCb18upg=;
        b=i69KH6ALXaS4xJ7guia29QOjub4icN4MiOSF39yGCd8tXjNc3DCfbmhWn5jqkmRzR0
         m7ZaDClVHcXLHHQ8ITWJ7AViLg0BadIuJMPJkqQ+L2/2F2E8XNhlIM3C5YcktoS9p3+Y
         BgdbWJ1nd2fWbsf3mB/vuhsAWsX73JX8SppQnpj4e5ji0+EXYetL3c6CZ8W72T+N+neB
         GmqkY0F9FIoIWrSCsF3HMN5oBoBm02FIj1GtmiyCSyEzarERxHAkpHgnE1l7/9mEfrlD
         wpzeYcGKa3jDTnjeudms89YC8NmQqFF3a3OET37rKEitJEPl+9AlREJl+anQgjJjjhCn
         hCTw==
X-Forwarded-Encrypted: i=1; AHgh+RojI92afKNOCJmnamkiCYaLxErBMu4jsVHg/8k4601bOaNUcEK1lBOeTazXCdasmwTnhR7FlNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Y4yU0q0jlrkwtJahHb2bE/0W1icQF7uY7VnidWU02Bp3o5QG
	eLAI1nPKP35xEg18gUJycmEid1TYsL9tR2k7FfagrCoLhzv28irJhvktvi5kVd2hph4SRA==
X-Gm-Gg: AR+sD13NvRgNvCTVYNJ1dm6DcUmnweXlNS+KDE8WgdYonXX03h6tscCOCdq8fwdM8lT
	7+5jBkd3JDyF75RTNo+cGGdYmHgaNTIOqeAVzfbQLzHJpmpDGCkA0HmuLyh14I/mEV7I6J8jcB2
	gIXvEKsi72YQMFKrXCO5wPIqrrS/UW5jp5wh+AGpG4ldQAUbKC9xYG1O/+9q3U3y31RyLuK3ccM
	x1usLRy6ZeoE97IYhj/5fc8Rr72tAXVAF1AtK9yHckNpK8bXWy8CvXb+FjkLS5FAyzz9MM6bdWI
	7XftEf7Q/7C0Wtg85BtvwgJ1qfJcI0ebc028U929p8aZYc2eM8cPXuWl9QdZ0mSzZ1V6lsbWtid
	DmPzsKgErtHxxfhpuKTV+yLlC2RXLcdnioNcgRXG8MZP8tM6bkYpBiCz0NocphswN2J+gwy4+Qt
	5EOIM76Yk85j+oQ04ZKpMczIU/3N660kDzgZlPV2VMJAZjTOaogCK0LqD6Z9ZxaB/1ABN+KL/tC
	0lvrjRiF4w8yFBP23PMI5Ko/l40qsio7Poj0DgjxmaQMrhS7RGH4Or+T8odiLD/poQKu1IGHar1
	1q+c
X-Received: by 2002:a05:6a20:cf8d:b0:3c3:935a:af2c with SMTP id adf61e73a8af0-3cc2b77f0cemr8795497637.3.1786482050220;
        Tue, 11 Aug 2026 14:00:50 -0700 (PDT)
Received: from nixos ([2405:201:c40d:9039:4f8b:4d:f8c2:8f50])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf628e42asm3322246eec.15.2026.08.11.14.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 14:00:49 -0700 (PDT)
From: Ayushman Rout <ayushmanrout27@gmail.com>
To: syzbot+f1ba58d6b55abd13239e@syzkaller.appspotmail.com
Cc: johannes@sipsolutions.net,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Ayushman Rout <ayushmanrout27@gmail.com>
Subject: [PATCH] wifi: mac80211: guard drv_net_setup_tc() against unbound AP_VLAN sdata
Date: Wed, 12 Aug 2026 02:29:27 +0530
Message-ID: <20260811205927.11228-1-ayushmanrout27@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <6a6d39e6.f794c993.27aeb.0008.GAE@google.com>
References: <6a6d39e6.f794c993.27aeb.0008.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

syzbot reports a NULL/invalid pointer dereference in
trace_event_raw_event_drv_net_setup_tc(), reached via
ieee80211_netdev_setup_tc() -> drv_net_setup_tc().

drv_net_setup_tc() calls get_bss_sdata(sdata) unconditionally. For an
NL80211_IFTYPE_AP_VLAN interface this does
container_of(sdata->bss, ...), but sdata->bss is only linked
opportunistically at interface-add time when a matching same-address
AP interface exists - it is not enforced, so an AP_VLAN interface can
be fully created and registered with sdata->bss left NULL.
container_of() on NULL yields a small invalid pointer rather than
NULL, which the trace_drv_net_setup_tc tracepoint then dereferences
to read the interface name.

Guard against an unbound AP_VLAN sdata before calling
get_bss_sdata(), matching the WARN_ON_ONCE(!bss) precondition already
used for this same relationship in sta_info.c. Also add
check_sdata_in_driver(), used by the neighboring
drv_net_fill_forward_path() but missing here.

The underlying gap in ieee80211_if_add() - AP_VLAN creation not
requiring a bound bss - is not fixed here; other get_bss_sdata()
callers may share the exposure.

Fixes: 61587f1556fe ("wifi: mac80211: add support for letting drivers register tc offload support")
Reported-by: syzbot+f1ba58d6b55abd13239e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f1ba58d6b55abd13239e
Signed-off-by: Ayushman Rout <ayushmanrout27@gmail.com>
---
 net/mac80211/driver-ops.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index f1c0b87fddd5..ecfdb51152f4 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1702,7 +1702,23 @@ static inline int drv_net_setup_tc(struct ieee80211_local *local,
 
 	might_sleep();
 
+	/*
+	 * An AP_VLAN interface created without a matching, same-address
+	 * AP interface present never gets sdata->bss populated (see the
+	 * interface-add validation in iface.c, which links bss only
+	 * opportunistically and does not require it). Such an sdata is
+	 * not safe to pass through get_bss_sdata(): container_of() on a
+	 * NULL sdata->bss yields a small invalid pointer, which the
+	 * tracepoint below then dereferences to read the interface name,
+	 * causing a crash.
+	 */
+	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN && !sdata->bss)
+		return -EIO;
+
 	sdata = get_bss_sdata(sdata);
+	if (!check_sdata_in_driver(sdata))
+		return -EIO;
+
 	trace_drv_net_setup_tc(local, sdata, type);
 	if (local->ops->net_setup_tc)
 		ret = local->ops->net_setup_tc(&local->hw, &sdata->vif, dev,
-- 
2.54.0

