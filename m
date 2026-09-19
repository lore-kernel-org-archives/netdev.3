Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21DD324B0A
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 21:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789853334; cv=none; b=ePXhDS1RKObQ/0JtwzKI996quCU/0Ah6tt1XjjolJC+61MAUUI/t0hfnRfOBtg37PvGrUoZFTo08GbTv41woKnqRSw7Nt/ALi0A1kh2JWFg5La5WdpjbUWcsCFgKeNHwcM0IHRQ/KLetzieGeG5A3pONyQ03W4OukzQtm4naHIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789853334; c=relaxed/simple;
	bh=GqV5Tydl3LPYKVJViJEcI+2HDXlD6WG5Df2m4/J8E28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FrX/FfVxCw1YSYCgYLVO8y8L+HKX/kjtFX/ZghFnVzbVr8xEw3vMGyuQH2R2w7CEQRGwNdx4xOMyf2B+8tRhNcnG+kF0HjhUXAyvZd8U/iMllvfUhs3upGrqnpNq88BSXpNYvPrXAaXe5KoGZciy0nM5mE9YYx2dd5A8dPQLtAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ko56Urlo; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ko56Urlo"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea34ef3so1538281a12.0
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 14:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789853332; x=1790458132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fOBLndiHTILxWCu+KMp+/nYLqNdqp9uqdVWKAPhjT7A=;
        b=ko56UrlooRB+GlYTjSJf43+JDfXBc62w3xfUZjhzqevLZGPAXNq2/aG2p06xOB1oEY
         0C2MPB//BSutUnYn8pT/L6VO2gBS78+GMMOUIWlkjAxZtdfhGEUY0k3dRxTzzBWwTasC
         zI/8zjsgyJ17I0pnBgorpb86ylbvgTXwVozPyAGqLBQne8WvtHfNKLqcW1aBuYAoc84/
         K/1mx5jfJGlpOZ0vdneanEo7G5G3J3RQ0eYJMzfwIXlY6I3XIKRMAqQaWpkIkV3J6Zan
         0y9ApoUSFoH2218W7DwIEUXsrZ+w7uODePL7C5ZfNoaVMq8g6qbGPFBwKVHlW51THF7K
         s6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789853332; x=1790458132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fOBLndiHTILxWCu+KMp+/nYLqNdqp9uqdVWKAPhjT7A=;
        b=PhAdhG045JR3dUky8AnzEsI2Z2S5UQwPyh0Awk0BnEt4MtYaY5c3lESwttrbxZupXo
         /dh7PuULzNPvjB+tDThCgnpAKvD7T0rK/km/ErZ0dYy1CgGeiQ6ZdAbpu/1ZE5VrVd0n
         VyTBAgy0voKe+C1O0goqr8sUpzHpTWte4tZO/jVzQeH4wFHJymQcp4cGVcUVOOxnmgwn
         kOSdAGoM8vAnDVku89S3ETfx9tKsyfk+io1/VYk1OAM9aYcd6v5r9RGLmcCdbtINNxqZ
         sVUKfAzJas8qr6CImtaXeiwOsIoygRqPqN3Cs3EMk0PdM03VAGgy14w1TUBg7S7XWh4U
         A9+g==
X-Forwarded-Encrypted: i=1; AKwUvBxf5Fl1PZuTeXmUg1SjDEALX5389am7dJ+bbDYkE4sQls6pEvkSeOy+0X/g8ogvMbmWxSqs0ZI=@vger.kernel.org
X-Gm-Message-State: AFuF++lLh00N0PvxwNFRH5+6NxkRENot1IbuE7NDEUMlHFoRTdMHceHM
	CaKiIvHmK+WT+KtMcPXyYtW7lP560nZv6mDW7Zr+Zxkt4bnRSPxFo5lT
X-Gm-Gg: AYBFou0nIfwmLVOCTg5FKsYkdbR98M/ACrX8NFfdMVZL4nm6qk2YjbXHOZIeF+w1dKO
	2hcB1tg3lbPzQzeAUFPF0qu1UPl99UWIKkR3GUH+Jyy9CHW7wYD8TDzZOuZmXAirOwu9X9H+3dn
	FXnTBXhAso1DS55AJFg1gqW6k6JEnNzYSXxW8xcYY5X2n5V1tWpLRHvoF6mvhN5flgN7ERS2eyt
	hlKNr57xNxGyBaS2pPXdHKMzeILWIq5qFby7vV+PqKFCLt3qn0odDalN7T+QOhfTcIh/RtEc3yH
	REiIkGKFPtjPFRG0uVaQpWn3+RGpsIQ4fyq8pToKTPRaK5fJEnS5g9IPTYWyxsz6QNCVRC+ea1w
	DLPyctInYyYONmt6aK9ZU76VcE1bNaBP/tzM1dLOcXZkla+saO2EKvvg5mfR7hCk08hiYGqoEni
	7HaSnbpNjIekUr6Hgf+HArcQhZ+W56ahy3cCl5BjSdGrogDJCw5ETl2IzAo86JqSwt6wltESr6J
	fT4UYDjG9UFZ8bLuPg/cVFLV0g3/CAUF1WeTvgrTCeTh4q17K81Sqlb/NU7UcjbbJVsLGB95ljQ
	idAByf1oKY/0v1PzZyjF
X-Received: by 2002:a17:90a:d40f:b0:39e:6c69:9b8c with SMTP id 98e67ed59e1d1-39e6c69b291mr5170268a91.49.1789853331817;
        Sat, 19 Sep 2026 14:28:51 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a023cf10bbsm1950956a91.3.2026.09.19.14.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:28:51 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: jk@codeconstruct.com.au,
	matt@codeconstruct.com.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mctp: route: verify socket ownership in mctp_lookup_prealloc_tag()
Date: Sat, 19 Sep 2026 21:28:51 +0000
Message-ID: <20260919212851.3240598-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a socket transmits a packet with `MCTP_TAG_PREALLOC` set,
mctp_lookup_prealloc_tag() iterates over the per-netns `&mns->keys` list
and matches `netid`, `req_tag`, `peer_addr`, and `manual_alloc`, but
omits checking whether `tmp->sk == &msk->sk`.

Because all preallocated tags (`0..7`) reside in the shared per-netns
`&mns->keys` list, any local `AF_MCTP` socket can specify another
socket's preallocated tag and cause incoming replies to be matched
against the victim socket's `mctp_sk_key` or reset its expiry state.

Verify `tmp->sk == &msk->sk` in `mctp_lookup_prealloc_tag()`.

Fixes: 63ed1aab3d40 ("mctp: Add SIOCMCTP{ALLOC,DROP}TAG ioctls for tag control")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>

---
 net/mctp/route.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mctp/route.c b/net/mctp/route.c
index a2c1517ff447..e411ebeca631 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -826,6 +826,9 @@ static struct mctp_sk_key *mctp_lookup_prealloc_tag(struct mctp_sock *msk,
 	spin_lock_irqsave(&mns->keys_lock, flags);
 
 	hlist_for_each_entry(tmp, &mns->keys, hlist) {
+		if (tmp->sk != &msk->sk)
+			continue;
+
 		if (tmp->net != netid)
 			continue;
 
-- 
2.55.0.1082.g2b9226bbc0-goog

