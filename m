Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3488D33555F
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 06:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785823802; cv=none; b=cJ4El7AycHaZ9S/ATIkiiilHJp/EmmdudDZjyHUIEcbL+JrWTOjoBtjV3ZPQWga32NCMuKydrtuAqQL3LyQBcnxvFowdLx3Qqjt8SyjOj6iZemXlZq5nGTuUYZ6rqG2/LB6Wci7jQ7zKaJRsLbyhEYEoQiJb88aNYIrFxHKoU8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785823802; c=relaxed/simple;
	bh=hoBcQLufPj2/EG+NglGciSArXHLoJN4T/RIwQYNKVmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BkVedZnYYGh/wBSjTorr1DGWS0Q2qvMCbxGSc7mL8AMJZlvEyL+uAMhPL3YlXFkL8kihpdrTRzAKjAmGF3x8F1xuSegde2VUXKrieGCnSgj/dsxxlpV/d8FPvBhmTHReP0Xv6ck8AeMXUY+5xd8L1z9GRvYv3DbfsYAou8+CggE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=kPlDBj90; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="kPlDBj90"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-930f618435cso232948685a.3
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 23:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1785823800; x=1786428600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=C9tpyP4DZI5UiWip+9VyOdslieTAF/jyWhJQO7HCZHE=;
        b=kPlDBj90P3bbhP5+hnQjotXEoVzY65HhP+a1ZX2RHToahUmoRON5fyq+/1ma9Dweti
         LRWeoKY5K7vyJirBK3XNBhXOdTWdRx3ONh4eeVjx3meCpo1iJxOTbrA+SRqyhe96f9Eq
         xw43oX0bfaq96PtJxvvszcg3Fve8f+JzTvleAnyRgofwyKDXC30yJW14e+4b3ev1yZF0
         +Qskbn7natNW4PVq+ZnWvZKhXe1jGGkewPrLQC9KCMTjYYzhVHnxf4PxRYhu6jQLh87i
         72rDqa+NmgeNWXM78de103TIt3T8i0meMTYQ6g4slVagrcictYgDOH+pDHt/DSOCyyYY
         6Jkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785823800; x=1786428600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C9tpyP4DZI5UiWip+9VyOdslieTAF/jyWhJQO7HCZHE=;
        b=CFR+5mbyNE08kcQCFuuvEx+U4bNNfT8Ci2l3W0zfCW05tX6cxDzYYMQorwsnwW/z+X
         Q0SVkBPs/Ue749GOrPufMpO++p5igRl7QR6XldJ7YP4fnGO5EtGtSFtfwbpRaAZOL1P3
         z0kpWa2JGcFHZY7xZmK/0+c4so3xTO68+m3ozETqQvie8IdwVeYL/HHJIYEG4Eze+G9p
         ixWff/antfdkqev/Oi5OgYfDjb7Ly2HN3X0Li3c5VeWQpsgRjsb8b4zWnRFexfA6iIjA
         PNTKDi6QUrDhOZ0k6Py4yJilqrTqA3DsLBqZkMlSnOYqEQX1H93+niGPWV0lsKt4UZaK
         /1Xw==
X-Forwarded-Encrypted: i=1; AHgh+RrKVdaYWJarTq3bftqg8Wiur+EWZTILd/E8v0fBRBIGsDSbNMy94eiZz6rFxXdsvCAkEdpbCQY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1lIVFz65t8aCSmisHSRP7e5ESTCo9AputKXS/FZTZW9WEE6HJ
	/0z0jCFoH+6ILuD15GLivBqpjGyPERexZL2YbvYnFGc/JLlP8lVXcViLKslja4ejmpY=
X-Gm-Gg: AR+sD13DIqFT019pCwgKq32VOcqCpFoiBPH5wZfqehcd2HohaKOlpo8kOicLWcqVB2b
	Xb9LwUMhoQbuXhQlArfasKHP6a7I0vce5Ff/FEgqStUHirEKauSiG3uS/vrk/X63oGQhEKiwR59
	rKnQiUGXiHX/bQarj4AniVEIBaNiXmeYMvF8QxXirAqHcGsAlVTo1Xh3tUzeqK29RPrvtcENng4
	n8VU5VLOdEvOPmWriFo5F7zmnWURQwWInY4MJYUMkXWs2UZaXW5pA3N5Llj4gxrgEwm3qL5WNr1
	2hZmgJJ65SIC9Q6G8IXPL6rC4j7y/PtP8xnw+M/t2ehyhNTRqcmtFzOt7tbcHhqqLKfySx1vSbu
	ENN+Eh56sWM1MLumQekwSgLMfcC/w/xkGSj6yvBZYMBDQmgHtLj6br3oDljFct6dSIJAh6lOBqC
	uudLFKSYmfzkRs/IsOllJQXbm2YsNihwelfWDLBDR/D+wpLy+p9mCN2BswX27Q2B8qRQ==
X-Received: by 2002:a05:620a:2792:b0:92e:e125:55bb with SMTP id af79cd13be357-934a0750096mr2572674085a.4.1785823800003;
        Mon, 03 Aug 2026 23:10:00 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-908432a0cb9sm93059666d6.7.2026.08.03.23.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 23:09:59 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Kyle Zeng <kylebot@openai.com>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	Sven Eckelmann <sven@narfation.org>,
	Petr Machata <petrm@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Lee <david.lee@trailofbits.com>
Subject: [PATCH net v2] vxlan: keep the last remote linked during FDB flush
Date: Tue,  4 Aug 2026 06:09:58 +0000
Message-ID: <20260804060958.711335-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

A non-nexthop FDB entry is expected to have at least one remote while it
remains reachable through the FDB hash table. A filtered bulk flush
violates this invariant when every remote matches: It unlinks the last
remote in vxlan_fdb_dst_destroy() and only afterwards tells vxlan_flush()
to destroy the parent FDB entry.

An RCU reader can find the parent during this interval.
first_remote_rcu() then applies list_entry_rcu() to the empty list head,
producing an invalid remote pointer that the receive learning path can
read from and write to.

When a matching remote is the sole remaining remote, leave it linked and
ask the caller to destroy the entire FDB entry. vxlan_fdb_destroy() keeps
the remote attached while sending the deletion notification and removing
the parent from the lookup structures.

Fixes: c499fccb71cb ("vxlan: vxlan_core: Support FDB flushing by destination VNI")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Co-developed-by: David Lee <david.lee@trailofbits.com>
Signed-off-by: David Lee <david.lee@trailofbits.com>
---
Changes in v2:
- Add the net tree prefix to the subject.
- Restore Kyle Zeng as the patch author and correct the sign-off chain.
- Move the research credit below the commit-message separator.
- Add the recipients reported by netdev CI.

v1: https://lore.kernel.org/all/20260731141311.570187-1-david.lee@trailofbits.com/

Bug found and triaged by OpenAI Security Research and
validated by Trail of Bits.

Trail of Bits has a reproducer for this bug that triggers a
KASAN slab-out-of-bounds read in vxlan_snoop() and can share if needed.

 drivers/net/vxlan/vxlan_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index d834a4865..a00df127d 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3058,6 +3058,11 @@ vxlan_fdb_flush_match_remotes(struct vxlan_fdb *f, struct vxlan_dev *vxlan,
 		if (!vxlan_fdb_flush_remote_matches(desc, rd))
 			continue;
 
+		if (list_is_singular(&f->remotes)) {
+			*p_destroy_fdb = true;
+			return;
+		}
+
 		vxlan_fdb_dst_destroy(vxlan, f, rd, true);
 		remotes_flushed = true;
 	}
-- 
2.53.0
