Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE7F439326
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 22:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786487027; cv=none; b=rc+81pv6JtB9zSzcQwa0g4yeL5oUIbLg2gmqTGGj5GAx0Jos0arFN3PzhvKAb7kdUpfcXrU1ubTP9GBNQVRrUTjoKCZLvERdwabSzlwTwLxKTfdd82icCObHr+PyOVtQTXMDkXA8ZnR96cjvqTZVSqmU4eiKWSbZlnbT7uQmYzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786487027; c=relaxed/simple;
	bh=lY641tFyHpBRQd0na4wBTsNmbvRy38ZNd54FPFLtTH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uT6VBUoSA3qHKPHvxT4FpZUPm4YM+a2Hgr6AMhG2/LxoHBG+oBRG/wX+bnMLeupgrH6amsqOMAUmV06eeoLJNh5ku74Y296W5IRauT4caNKQ7HhRsvkLMXrkW9yYSEqWLQxlUz5S86ImQWKaHSmKghQtMhVSHEUw00tNY6Lx478=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UidK6OMy; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UidK6OMy"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8486ac3f347so1507172b3a.1
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 15:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786487025; x=1787091825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MMwqR/LUP0gNSxcJeMskNNfCCj4bDOzY7cV13z/jryo=;
        b=UidK6OMyh6kxzHc1Ut16lyeGAJWXAKVVL6tvRS5AQWJZmpGiiVtfyYit1TC2fL+m66
         K+LsH4akN1TAXZmTGXN1y1DrX3i6bKAsmZrQYHdfTqInJ7xNNceS6FRdxtiw56BiVMLD
         x2yCC6PWIq4g0VWCeUACzA+5t4I1HGl0Oro9S3kVDC/GjdDhUv0NoamgPZREq21q0YV6
         FOC8OLHnoOW4aR4C6htLBajJEgzNuyKW+cy/XY0v7jqFalkXJ286cOQr74EYmKEm4CV+
         Ta6GtFDoztX+rHjmaPi6xwWFtJgAPFqKFNJvEQU3znoIx75JtEigfYz3fCw83xMuDBHx
         bFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786487025; x=1787091825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MMwqR/LUP0gNSxcJeMskNNfCCj4bDOzY7cV13z/jryo=;
        b=c4f5hNcy7SEwsoNLdF7v16OxnEhl/X60qxSqMnN+6T36dmV9TkfZU6MEG5bltars/O
         BymG0EswsAF5kHnihkY1w12PyN0nzmwHqigTHHvJCAtdGzpKs3S3iPARrbwMmvGe8n2g
         SKaZAbvPUJXDTH53TgoSyPzi/cW0x+CwxPRk4TkEWkECv+sEPcUyq5tPUoOr4wQgFBaD
         PavtG5ZmUSLWrouOZBwvXn0VKxr2ljelnYBrvNA046J61VciFB4gLjkCUjYFj0GFqEPv
         yfplIFtS+wUkN/mQ2qnoqwTvMbh+RmYiKFQU4WQurxq21n/GqgOLwSHd3TcljQ/haNCI
         Kiog==
X-Gm-Message-State: AOJu0YxeDqRQ4+LtgmjwCRTKacpPfIx1eixr/UBnXIftF2fxcLCriDUJ
	Zp8ijRQzE2BQxEkZiPxsY5Z2ToSn1YoSP40L6a/9Nln841Vldc/SFu1wbHjXTK9jDHTUgw==
X-Gm-Gg: AR+sD12mOMlHHO61ZYogr46utPVa7654m3tm86xYLeLS2xvxthYDK7JMU5PP1aYS1Yy
	XQB6wU0YyO8ZNIxQFH7yk5RlEA0x5+PTghOdbm0FHt7GI1uimcY9Fjmm7aCrr1tbKdEHM4TVuYf
	PQkuPCwQTsNk+CjqClA0Gjj2MpL+TIpo0B6ZBoqCObxzziTeo1Zw9SI77zGPxsOUNexauXGH2Jp
	ejfoenhSQR0DR9rp7azLbqpQ6R4pDCjADQ8QCR5PMGARcKq4rLIJqIsKE6fySmPugWugb5uQfP2
	hBr6l+fhq9Mbks+tgKYzCYUgjN3B89oBlA7i4fbuu706DWDfxFOoPdpPuUPruStxY+EEvyo9N2I
	XgfQ/dS4lKPs5+o2AW65cOKAk7lpD45R6gpETJWDKHkbeQzqshgsgxfsJz2iKFjNYC5v8KLd0Sc
	F3sQLRtDo++++7udsv/Zi7Exlr0bxO1bDwqYPYcLy3sIQ6QV4ejWuTCbdGKV0VcP4k57zBNl9Fa
	MQEhkE+WmwqaVX7VF8UR55FLuWED6Q8x+Hr9MKr/0fg9sU7GZ409+fFYw==
X-Received: by 2002:a05:6a20:488:b0:3bf:a517:cdcd with SMTP id adf61e73a8af0-3cc379514c4mr4582561637.12.1786487025287;
        Tue, 11 Aug 2026 15:23:45 -0700 (PDT)
Received: from LAPTOP-N5EO9J2L.localdomain ([106.202.115.11])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141244a9669sm3326808c88.8.2026.08.11.15.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 15:23:44 -0700 (PDT)
From: Harshit Varu <harshitvaru666@gmail.com>
To: netdev@vger.kernel.org
Cc: mptcp@lists.linux.dev,
	matttbe@kernel.org,
	martineau@kernel.org,
	security@kernel.org,
	Harshit Varu <harshitvaru666@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH mptcp v2] mptcp: restore full join state in syncookie MP_JOIN reconstruction
Date: Wed, 12 Aug 2026 03:53:25 +0530
Message-ID: <20260811222325.90426-1-harshitvaru666@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811215135.87756-1-harshitvaru666@gmail.com>
References: <20260811215135.87756-1-harshitvaru666@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mptcp_token_join_cookie_init_state() rebuilds the request socket for a
MP_JOIN 4th-ACK that was handled under SYN cookies, but it only restores
remote_nonce, local_nonce, backup, join_id, token and msk from the saved
cookie entry. local_id, request_bkup and thmac are never restored, even
though the SYN path saves local_id and computes the other two.

subflow_ulp_clone() then reads those three fields and copies them into the
joined subflow context (local_id, request_bkup, thmac). Because the
request-sock slab is SLAB_TYPESAFE_BY_RCU and not zeroed on allocation, the
values are stale bytes of previously freed request sockets, which an
off-path peer can influence by sending concurrent MP_JOIN SYNs. A corrupted
local_id breaks id-based path-manager bookkeeping, and a corrupted
request_bkup misclassifies the subflow in the packet scheduler's
backup/active selection.

Save and restore request_bkup and thmac as well, completing the state
restore.

Fixes: 9466a1ccebbe ("mptcp: enable JOIN requests even if cookies are in use")
Cc: stable@vger.kernel.org
Assisted-by: opencode:deepseek-v4-flash
Signed-off-by: Harshit Varu <harshitvaru666@gmail.com>
---
 net/mptcp/syncookies.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mptcp/syncookies.c b/net/mptcp/syncookies.c
index 7f2252634..3c25ff627 100644
--- a/net/mptcp/syncookies.c
+++ b/net/mptcp/syncookies.c
@@ -27,7 +27,9 @@ struct join_entry {
 	u8 join_id;
 	u8 local_id;
 	u8 backup;
+	u8 request_bkup;
 	u8 valid;
+	u64 thmac;
 };
 
 #define COOKIE_JOIN_SLOTS	1024
@@ -63,8 +65,10 @@ static void mptcp_join_store_state(struct join_entry *entry,
 	entry->remote_nonce = subflow_req->remote_nonce;
 	entry->local_nonce = subflow_req->local_nonce;
 	entry->backup = subflow_req->backup;
+	entry->request_bkup = subflow_req->request_bkup;
 	entry->join_id = subflow_req->remote_id;
 	entry->local_id = subflow_req->local_id;
+	entry->thmac = subflow_req->thmac;
 	entry->valid = 1;
 }
 
@@ -117,8 +121,11 @@ bool mptcp_token_join_cookie_init_state(struct mptcp_subflow_request_sock *subfl
 	subflow_req->remote_nonce = e->remote_nonce;
 	subflow_req->local_nonce = e->local_nonce;
 	subflow_req->backup = e->backup;
+	subflow_req->request_bkup = e->request_bkup;
 	subflow_req->remote_id = e->join_id;
+	subflow_req->local_id = e->local_id;
 	subflow_req->token = e->token;
+	subflow_req->thmac = e->thmac;
 	subflow_req->msk = msk;
 	spin_unlock_bh(&join_entry_locks[i]);
 	return true;
-- 
2.53.0

