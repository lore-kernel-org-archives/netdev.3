Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C956912FF69
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 00:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786062180; cv=none; b=lg2t9kQ6dXEWccUik6zN5tP0CwUiyDcX58UWYfbwtMkXByqBV+qZaVlw9310v+cRSrgLswzZsET7Sh4wZbaBORBRLQgIStCSeq93kKuvCOjBnmzh0cjz9bhviCdgyzlACP4xffJqeSrMgcwCDMCVb06XxIcMbsoslXy7Uh3PmN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786062180; c=relaxed/simple;
	bh=yJ926pB36lkq5TlPvA2++4dKlwRY3XVrKLKFAQs/p0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLMfuYfHdS5ijOsjS3WZP4RIf7U77dlFYmD619NbzUcBrKUU0Gn9moPqYF2yOxQaYJIhJvUW7aimPTQbdNJg5ZzozoI1CevZWJr5NGeM57RRUC5SdMUk3llK3SNAyrfH4S5Ctr05PW00jhsn6n7r3bie18UvmZ7Ir4al+4+OsTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=A+T+310l; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="A+T+310l"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so2161973f8f.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 17:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1786062177; x=1786666977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4CL1PkVLiXwXBmBYxZNWWHnqpPdt0wLpAwCkWqVFLKo=;
        b=A+T+310lg5suOoxoyr5tV2NQaWzeN5x6VyqXUwb+ofzI6nQIJ737/q3JacY+ckt9CJ
         DjPqDRS9yZkpnTCkQFkSE28px4S2FlMhN1fP+HkPRUctLIoupAqBQbUrEZJOmjPxbswQ
         EJ2jNP3uLp0iOCrhldTEtmkpQcIqcM4ah/k/oJKcbRjpAKxhkNq6MtvMBJkH3V84u5rM
         gDF7ijQmuOZJWtiyFZhdYJZJWt9/bo1wIKVs8kyVubconbhdUdxbVBklSjt1n0ZLNKdQ
         5dHbII5oYE5iGU1/td3eBxb6b85tcDbSp8UqM+hLBpBCfLmOR2S6kvLJ3tpru7JZmvnd
         8BJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786062177; x=1786666977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4CL1PkVLiXwXBmBYxZNWWHnqpPdt0wLpAwCkWqVFLKo=;
        b=QFeV60msFxcmYLxri9aIU3viQ9afbEa3hzx+Jz1Aaux4gOEhHduyZHt/WpAH3esQ2r
         eDs8iJNKGblSCy4s4UL2STrm8MfpS+x3oa/0b4P8o+/vt9nxJzsXmD3gBtgTmhW2BSB6
         IcDHKTYIKNDRB5JSvkUE0VGirNbM4Ls54J6NyTxhrjgiFZDpDnD5Vcx3nqpV551l+XaO
         SxdVaTpt3KCX2Et7BkitWHfdY2djgjFdJPyKmvXUH5LZQAMZLETmpBIS6Cmn87sEp235
         H/8bDRrRdF/Akf7PlMFk+c/RhBMADqQKowsEOUMyzwXorA4Zb09l+o66mDsvnGVQ6hWu
         CuTA==
X-Gm-Message-State: AOJu0YxSuOR25afJt8qwWSGvRvEfutmDl/b0C5CUNtfaaD0fDqCPPmu0
	JqMhk9ZNOv8e591C0PiXAhNf9aYOT8ejkBcbQt8KvIOOMRrjwyJNiQYye5fV3Pts0QczMb7euCZ
	tO9RuSbsj3P8iLQo8XIn2so//ncjjFct10HExoPdfpiWha3qZ7QB0hdODke4mC5lm
X-Gm-Gg: AR+sD12N/vfk+UoSRZpOpKiqRXmZmhds+S4AXAYscxDOfGIx/J65QZq7H/E8snEHOdi
	nfH3VajLm0lmCDnMIdx+ee0hbx5jW3zGP96lJ88F7ayjGzdYN83xxDxI5y9enJ4lgKoXxCTWc0r
	Udj4vzAHHH+3jrC5poKxfXupCzXckc+RWXbAPGM4KVty0do4q8+C8zUwnbvCHf6VqEIeeWywToW
	vGQR4BQRyt/ExFUBlagLhisd0PeiP1xR5jP3aD7zjigYo+mxdRiRkQ/sA1C5Cr67FrEsQB1cNQ9
	zLlgIKjfbsGCeJ+5Wp4J8lf6qaItiHg6FaoCXrbXXmDgnxB/GbDahB0OXznYOxDwDsiK7GMo0eI
	Hk/FFeSmkEkS6F9ZV+PPFv5o08gkxDi7C0ByJxqvPYhO0XykwwkS/RlXrnKkBmaPJb+i+oGEhsk
	J+w3oeH2S4a1WlCNRpCV7qBVatTxqPa+0+b2QLXqG4xRUiMXT35xvAhBPE7ocJVR7bdy9pFmPqA
	7qpOIDGGk/hs7hfJVjQ/aU=
X-Received: by 2002:a05:6000:46d7:b0:46a:8fab:eb44 with SMTP id ffacd0b85a97d-47fec501abcmr22640764f8f.1.1786062177016;
        Thu, 06 Aug 2026 17:22:57 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:6db2:29ac:6c1f:5e1f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021ec565sm359215f8f.22.2026.08.06.17.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 17:22:56 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 1/4] ovpn: fix NULL dereference when killing missing key
Date: Fri,  7 Aug 2026 02:22:41 +0200
Message-ID: <20260807002250.1817498-2-antonio@openvpn.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260807002250.1817498-1-antonio@openvpn.net>
References: <20260807002250.1817498-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ralf Lici <ralf@mandelbit.com>

ovpn_crypto_kill_key assumes both crypto slots are populated and
dereferences each slot before checking it. That is not guaranteed: a
peer can have only one installed key, and the kill path may be asked to
remove a key that is not present.

Read each slot once while holding the crypto state lock, check for NULL
before looking at key_id, and only replace the slot that actually
matches.

Fixes: 89d3c0e4612a ("ovpn: kill key and notify userspace in case of IV exhaustion")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/crypto.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ovpn/crypto.c b/drivers/net/ovpn/crypto.c
index 90580e32052f..2e95f29514fc 100644
--- a/drivers/net/ovpn/crypto.c
+++ b/drivers/net/ovpn/crypto.c
@@ -58,15 +58,19 @@ void ovpn_crypto_state_release(struct ovpn_crypto_state *cs)
 bool ovpn_crypto_kill_key(struct ovpn_crypto_state *cs, u8 key_id)
 {
 	struct ovpn_crypto_key_slot *ks = NULL;
+	struct ovpn_crypto_key_slot *tmp;
+	int slot = 0;
 
 	spin_lock_bh(&cs->lock);
-	if (rcu_access_pointer(cs->slots[0])->key_id == key_id) {
-		ks = rcu_replace_pointer(cs->slots[0], NULL,
-					 lockdep_is_held(&cs->lock));
-	} else if (rcu_access_pointer(cs->slots[1])->key_id == key_id) {
-		ks = rcu_replace_pointer(cs->slots[1], NULL,
-					 lockdep_is_held(&cs->lock));
+	tmp = rcu_access_pointer(cs->slots[slot]);
+	if (!tmp || tmp->key_id != key_id) {
+		slot = 1;
+		tmp = rcu_access_pointer(cs->slots[slot]);
 	}
+
+	if (tmp && tmp->key_id == key_id)
+		ks = rcu_replace_pointer(cs->slots[slot], NULL,
+					 lockdep_is_held(&cs->lock));
 	spin_unlock_bh(&cs->lock);
 
 	if (ks)
-- 
2.54.0

