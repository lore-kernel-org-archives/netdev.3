Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF93D59B680
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 13:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184303; cv=none; b=kIsqEHkW/7o263NHs+q8/mQPxLdod9MZkvQruziIpBmxfOPeqkSqDo4RtRTEJwA67iO2BqgmyK/Dd3K87jrBD9KA4IG8j0Dmx1no+SGJ1unmJcCyCsbUhkkIYxiq8MSqQ50OzuH6GHwsoXARHWZKpjLvis1AE/KgzhQWnhvfrq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184303; c=relaxed/simple;
	bh=C/jWwzns/cSri7bZ6oRLyVSvJITbn+XeP+Wxcjevo1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aS8Eq3wFKQ6vZtq3CCr5NXs4SIOqN8zZLhu1VMBr2e+wDYaYo3N2GkCS659xtFu0rf5u6RZ9ONZP8t7oKP7DdtZFmaByKntlkiH7hPYjds06JOpWJcCPLyZWg6InXbXAcqv+hY3K/IEqTmpB2AnD2qGaTJBYlraKlej5wJU79n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=boLFwmrE; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="boLFwmrE"
Received: from kero.packetmixer.de (p200300c5970EEDD85f51F1FAA919d7a5.dip0.t-ipconnect.de [IPv6:2003:c5:970e:edd8:5f51:f1fa:a919:d7a5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 0C532FA6B9;
	Mon, 31 Aug 2026 15:51:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788184297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3YwemhihDz78tssD/CM0RujokvKpevMf6NjoVdOs20k=;
	b=boLFwmrETPQPIfBECwlkvC1PNMriapkBGPLmxM2n3EPJAz89gZ6ic3M42vVdJ2OrIyOBlF
	f+mCRWayi9L/aDYuEdApMg1kTkmi/pLIMEQCEcdP/HvUpsBEeeGMJ+cxpm929fPG20Vlxs
	ydY0P+VQfau35NVlclIqagcrwcd+4LFxbjzEA/SL1jbv0Cv25OiUWX0Gx4BjBBe2viT74w
	AVCzww8B+POaH3G+3GVLub6/v6lFdysdExWEJuzagk+7835Xz+C5KauHQZj3MEMingRkIV
	9xdAjV7rivFxhVk1NCYjMsILEihy65RmuUdr13Isbh6cVk0vhA4NILTBgwYktw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 14/15] batman-adv: tt: don't uncount never committed clients on pending purge
Date: Mon, 31 Aug 2026 15:51:16 +0200
Message-ID: <20260831135117.574836-15-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831135117.574836-1-sw@simonwunderlich.de>
References: <20260831135117.574836-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

batadv_tt_local_purge_pending_clients() decreases vlan->tt.num_entries for
every entry it unlinks, but an entry which still carries
BATADV_TT_CLIENT_NEW was never counted by batadv_tt_local_transition_new().

batadv_tt_local_resize_to_mtu() calls batadv_tt_local_purge() and
batadv_tt_local_purge_pending_clients() directly, without committing in
between, and it halves its timeout down towards zero. Once the timeout is
short enough, batadv_tt_local_purge_list() marks even freshly added clients
as pending. And each of them decreases a counter it never increased.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index a870d9a97e329..794692170b611 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -349,6 +349,10 @@ static void batadv_tt_local_size_inc(struct batadv_priv *bat_priv,
  *  given vid
  * @bat_priv: the bat priv with all the mesh interface information
  * @vid: the VLAN identifier
+ *
+ * It must only be called after a batadv_tt_local_entry without NEW flag
+ * was removed from bat_priv->tt.local_hash (under the specific
+ * list_locks[i]).
  */
 static void batadv_tt_local_size_dec(struct batadv_priv *bat_priv,
 				     unsigned short vid)
@@ -4019,8 +4023,13 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 					   tt_common->addr,
 					   batadv_print_vid(tt_common->vid));
 
-				batadv_tt_local_size_dec(bat_priv, tt_common->vid);
 				hlist_del_rcu(&tt_common->hash_entry);
+
+				/* An entry which still carries BATADV_TT_CLIENT_NEW was
+				 * never counted and must not be uncounted here.
+				 */
+				if (!(tt_common->flags & BATADV_TT_CLIENT_NEW))
+					batadv_tt_local_size_dec(bat_priv, tt_common->vid);
 			}
 
 			if (cont)
-- 
2.47.3

