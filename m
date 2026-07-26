Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A36280018
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 05:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785044021; cv=none; b=DLUFGbV4t35/LiJ9RF3cf2AUgCAcszfiKVYPkvHxRyW8ixIUs1xi4/EmBIFX/a3s2D8E/DQOqpe642wVF8vvip1uY8fAXt2y1J963uJ4ulgrJ23VdAMkdsXwI8664dfZd32bevTstkxqJ48P8M6QqfJ0zZsNT/wJ8s+0sbwnPck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785044021; c=relaxed/simple;
	bh=47i/YXfixIt7e5t5Gu6byp5P4Erdmj27ukrh+PELRgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n2MVm5lzfJYST4/OdEi5eDXrK4XknxviZcHtSxb5IaesP1B2u7G2ydCR/nwS+pnlIGcoP0XE6oBT+VlCucHWN10KiL/0l04R6oox4kiUMPis9HMXmXIc57UCtQTVeIGx+Kk9sFqKYAaWCbR9EAz2GnGmFNkgLWRj913ciNcdQ3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=Z76QKIgA; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="Z76QKIgA"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cbb662575d3so978402a12.0
        for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 22:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1785044018; x=1785648818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l0FA1kd0s14T0zTfOo2W1mWfRhLmW66jk1mDOW/wW+k=;
        b=Z76QKIgA/3IQ7HqQIWiW4cqgSw5gRhmVSii5njgmmoOGd3s940gamvQ4IhRbLcqzSW
         p9FqyA3/Q4fP5M/kccC3S20lli8TOKFNOAXS6D8tq3iX7LyvUEjbBpzwDtjrMMvgLFPa
         5VBG2AeAFrQgo7/jUf+AgcxkJKR324D4kALqZ+733XXTddki6A+VNjR+KQPf8JEAC0Vt
         0GixLe5eOvdWrH7iVBMdd6bp8jpySdvATHdY6XSSHWfV9qzavcDGO4p2Oo0aY7xx7z6b
         0mGa1dfTNygGqIFyUngR/TuvO3DLCf1FNMwRxsV6tJCdQvMTMebrVoEiqJORnrlZuZlj
         1y5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785044018; x=1785648818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l0FA1kd0s14T0zTfOo2W1mWfRhLmW66jk1mDOW/wW+k=;
        b=oZVAxH4qat5VGLQjOCXwr2ju7kLmHL3wfapz5BmDvKgKOFQn7eWAT1+qzbI38Ofnjz
         /I5FR8s/KAPLziGaL4ZGayTADC+Fn7J2kskVwHMV6m4G6tpUc4yH82QgC6mVcB2NXYnO
         HGUcns2VsorYVInIAbEHFi2vYAdhMFymptp4xBAXbdV7dqvSMFFTNozvUyiz3DT1X1IC
         cn/iJeSP4NXvL5hnIvkskE1mTAp7vlFeLXzBUHqeaGlirBDvg6VaFZK87gdGBAo8xV1v
         EO/SjSzrxtIWgNLSRcS4+NlQjkwXdGMMdNjWs82g53kz6iD+fFaa3mpCvcc7iM9yrtw3
         eg5A==
X-Gm-Message-State: AOJu0Ywz/jqT8KHsxQh/euOzhXlQ4CJvVkZeeqSo2ON6mt16RZcBlKf5
	fMPkIaZ5qAfdJnehLONDQox1hU1IgQGi5aUpxkeKc8mkS+wLPA1LTxNLdbr9fMCnzjHv8v9oUk5
	1S+x8dOU=
X-Gm-Gg: AR+sD11QdOGDPzPK0L0EX4zUD17sZrS1KDZ7ByB6MdPbPW9/AZyQnO773wyu/BsSWq0
	FOSkw7ZECFS0fKI0dIX34WdfYS0fxGN3trpLmnK1SGDUHZ4hxizedD/bhmTCedqtbhThNcpYRTK
	f/4q2TFARx4a+8wll+mRANWun3fawd5stNuQaGCm7OUAvCqcgB3c2rkX2fhVrPtyCA205EHsVwc
	vAPEbAg96WR9EXJaftuWZPqFg3Jblfzb57G0SNuDkPeON6Im2vXvjaD6xHZPQZ8BnV1/Vtd6Yiq
	c1/R1Tz3KHxp3STkDgjJKYfcqXDBeEvFjMuvD20ZhhhJAPD4uAXHw5FKrEDBRHkeSoF5K/hOqaE
	I2UqqlveOOG4rbL69clWVTwE4kVxouquHblfRePfCbHDTEeDozfobptDcYXnxzOsTP9+9ysjnyf
	9wk5GGTnt1F6d5z9b3fLHF3HYS2Fotqa20IB308wqJr18wc5YW18iXvyiTcNioKyZGfh66kPE=
X-Received: by 2002:a05:6a21:a347:b0:3c3:bee9:8eec with SMTP id adf61e73a8af0-3c67da2e421mr3837000637.19.1785044017923;
        Sat, 25 Jul 2026 22:33:37 -0700 (PDT)
Received: from localhost.localdomain ([125.128.148.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb66c9dd2sm1785092a12.27.2026.07.25.22.33.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 25 Jul 2026 22:33:36 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: netdev@vger.kernel.org
Cc: ms@dev.tdt.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	federico.kirschbaum@xbow.com,
	Baul Lee <baul.lee@xbow.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net/x25: fix use-after-free in x25_kill_by_neigh()
Date: Sun, 26 Jul 2026 14:33:30 +0900
Message-ID: <20260726053330.41736-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

x25_kill_by_neigh() walks x25_list under x25_list_lock and, for every
socket bound to the dying neighbour, drops the lock to call lock_sock() /
x25_disconnect() / release_sock() before re-acquiring it and continuing
the iteration.  It holds no reference on the socket across this window.

A concurrent x25_release() on the same socket can therefore
sk_del_node() and free it while the lock is dropped, so the following
lock_sock(s) operates on freed memory; the sk_for_each() cursor can also
be advanced through the freed node once the lock is re-acquired.  Either
way an X.25 device going down races a socket close into a slab
use-after-free.

Take a reference with sock_hold() before dropping the lock so the socket
stays alive across lock_sock()/x25_disconnect()/release_sock(), and drop
it with sock_put() after the lock is re-acquired.  Because the socket may
have been unlinked from x25_list during the window, restart the walk from
the head instead of advancing from the (possibly unlinked) cursor;
x25_disconnect() clears x25_sk(s)->neighbour, so an already-handled
socket no longer matches and the walk terminates.  This mirrors the
reference-holding list walkers already used elsewhere in this file.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
Reported privately to the maintainers on 2026-07-09 with root-cause
analysis, a PoC, a KASAN log and this fix; posting to the list was
requested as the follow-up.

Fixes: 7781607938c8 ("net/x25: Fix null-ptr-deref caused by x25_disconnect")
Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
Reported-by: Baul Lee <baul.lee@xbow.com>
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
 net/x25/af_x25.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index c31d2af5dd22..68c396dc4307 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -1770,13 +1770,17 @@ void x25_kill_by_neigh(struct x25_neigh *nb)
 
 	write_lock_bh(&x25_list_lock);
 
+restart:
 	sk_for_each(s, &x25_list) {
 		if (x25_sk(s)->neighbour == nb) {
+			sock_hold(s);
 			write_unlock_bh(&x25_list_lock);
 			lock_sock(s);
 			x25_disconnect(s, ENETUNREACH, 0, 0);
 			release_sock(s);
 			write_lock_bh(&x25_list_lock);
+			sock_put(s);
+			goto restart;
 		}
 	}
 	write_unlock_bh(&x25_list_lock);
-- 
2.50.1 (Apple Git-155)

