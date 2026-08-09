Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C40F30F81A
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 21:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786310511; cv=none; b=W0bME8dMkhF8NKWD96Y74oFGHB3gWFTUNMr8hCdGXjjZPQvISCz2mA2ak+rRhwmjzz0ZBA0ujr7OV/WQMxkItUhU3WDV8gpGGluOKGqWHAy7EXV0ShQ3WLcnPF5+JizrnrrHIsISzfmqFsdjdzQNt02vOW+L0VyAZx+hwj8V7s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786310511; c=relaxed/simple;
	bh=yJ926pB36lkq5TlPvA2++4dKlwRY3XVrKLKFAQs/p0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+MemtrJPQJM2XM6WIBaU4Gj4fMkT8GKzosokcww9lyEHRwa++DOddrUbBWfVpxbbJxO7eoGpHCzusnooIq7soIXlliOKc2uJwpFLKLH6BA+Yu3UeOuHQySSyiI05b75TNiy21O/EAjUaFVMz3ipW+zyfFhO9dt6e96b+kIJoQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=FA/GgDzD; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="FA/GgDzD"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48000c5d6d3so471074f8f.1
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 14:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1786310507; x=1786915307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4CL1PkVLiXwXBmBYxZNWWHnqpPdt0wLpAwCkWqVFLKo=;
        b=FA/GgDzDfIoT5DA3mY2l1Cf7VRBjk9JtwpKL9liPskUwY9W5qy8LQqhIa9u9r/XaKz
         xqaEBnE/fjcBWQummSlLXPEn7bK84twg+CT1q00tNaEDX6sMnYCWmMh7JMXbZMt4YHdh
         Tax/4rzO0699KqwBiodGnIjFPeDwmEC4R/h/vnikToZk+vSvGN46ssRh5Brvls06dTJU
         B4qWDgLtZWhF+LwG6EPU29jJSYlLUBhec39aw5EAbXa/TQ06umhfjwabPrT7VeAPkmU7
         I62CTdcQTxdI12650a5SZWTYJ4BMSciWlJQD5alhrCBWtQ95cKrzd9s4X60PodHzo7Xv
         XX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786310507; x=1786915307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4CL1PkVLiXwXBmBYxZNWWHnqpPdt0wLpAwCkWqVFLKo=;
        b=NK1kLkjKb7VBRG6PGWdI2c42WWMqIQcNQSCTwbkVBzAJOKs7l4Rqj5lwenzKrIVPI6
         AB9EDX6hSu0hzxRykTJi4I4CvsXdtuHeAwVNxc7AimHJBs2Zj4sY23QGJPceFU7jpcsY
         WYM2rEPNQZ6KS3AuyfLJGmRW3ryaMcCFculS9Zxe/sWMM5F1HGObhkmG02u6twA2Jog1
         NswR6TWr7+vYcVgEDXaLilqJ5mgCt6MLbmCZYAHtLAIBaKkW9o8SXveB+8KC+ARiiSBR
         xFaCI8cyEGvgLD3nI1uiHnFjf2b4CFoaDUd+1pX7l2zcfOvS4nWx/TxTmn//OVRT9TfM
         34rA==
X-Gm-Message-State: AOJu0YznYOfL0vwKmnckrOunidRtZSsYoxQTRQ4Qxnm0+5SOCfkUrjSI
	a/aXJFjIXWhvPjpPFg+wK/cYSqiDcA6AaQBxhDO2FOBqHx0j8EPXjZJdW6U1k3TOhhRxbxqnAH0
	3E+C0YdIsLGdpRsaGmUiKM/WUs1bN5ufp0hO3yoJidzgNWXJ9k14KI+ZVZs0jB6nf
X-Gm-Gg: AR+sD10UpMGXxH3VTpYWfyTx8eHQRFiv0yPHBN7pAmwF4noLBuXqn5l/L6vXpOFbOAM
	bIhOG8AY8RAoGpywotD/zKxkohG/qZCntItot9XPZR14nDO5wxSq5SW3XQjqeRtd7REvewOe/Zn
	RadkhHLlbhyfsAdkd1m0l7T2cTWqC94MBWz7s259WIjHkZiw86LC2TAt0IUjMQjOzhH+67ZVr3A
	L1sr7qQ+LA8nsWbpW9UTm4ZdZ3kukv4nm1tyGHIfxiOB6wpmvPsNyYMLOe1ud497lPNX9dp+nrj
	gzoMIJnja84OF5dMN7CG/BDbwveNbq7FcyvOKPdJ5OZxdoE8QBPwb6POIU4VIeXhgFV6eKI4KmH
	Se71po335yu09WKndzioriOiTSfISL0G6F7P7AWByIjT+nzk02Us/Pre86qYVaDEz4L9i4vP7Gt
	KC6WLEjgvRurmI0w5gg2U1X8EuxXrF3HU7oZYFve54lXLAejFPQ1Fe3u89QDSw+NCkGmjMDpyZK
	/KSULsDxABY
X-Received: by 2002:a05:6000:46cb:b0:47f:826c:7422 with SMTP id ffacd0b85a97d-480026c92b5mr18806571f8f.17.1786310507621;
        Sun, 09 Aug 2026 14:21:47 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:58c9:fa0e:8293:9eba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002206effsm24976651f8f.32.2026.08.09.14.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 14:21:47 -0700 (PDT)
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
Date: Sun,  9 Aug 2026 23:21:26 +0200
Message-ID: <20260809212142.2249027-2-antonio@openvpn.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260809212142.2249027-1-antonio@openvpn.net>
References: <20260809212142.2249027-1-antonio@openvpn.net>
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

