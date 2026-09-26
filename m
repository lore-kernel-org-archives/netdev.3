Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B702342538
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 17:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790443570; cv=none; b=MuC+zpJV9YmdIU8u4AknnVUnCtHbBkDD4lIYtnlFquFAutzmamWLXO/abcOfvbZUZvVzVNh0k7ZsBd5jkV6brKAR6k101A/nMtH7bUYIt8lL58iaJkWPaxgooSwpctppa3lK4q5OXD4GedHcRpcr/Cbk048nxLsANb/Vo/vO4gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790443570; c=relaxed/simple;
	bh=YrOLbTb4WC11G1oCe3DzqAF0PEabQll1BC8UXZrUNds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fXNAbk7ycJTtTLKHnZStwgPVqD7mlTJI7m/fcom6eKilluUMe65IkJKvsOI4k5sfZHDBRWKgf/a6T8+kKs5WG7QhtsPr2uV7jRF/kQUqhbYegwpyxSSbX16waiBt/gFE0ihfWZei7UTX3fEYHGcZni8dNK53PyJCbmfyWVMgK+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=erOvpFhA; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erOvpFhA"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-342c9532343so66758eec.0
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 10:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790443568; x=1791048368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jhocdDFq9DeA/HG//FXJunjEWK5CDGAQOC1NTDBHIkU=;
        b=erOvpFhAUyDL+m+/cdpbdJtVZtvKXnwSbCc2Mz6GJOUvZwNsTdmLgBW6CCi7XyCL+3
         xee9+YxHld3IiPmFmMdELSZ2jiO/WbhuCcYsvlSLkBChSe4fTU1QXmxSCc0r8iLPuV6t
         CiwZnxZ2DfX8en9kTxrr7vFLOpBsax6kyduBQoXGs3BYkq6A9povu8Sad12+qgoXgLaf
         WNWNC0B89gVyGlegJsO/+PxZqeGchSPkmmkYY9UDf7lSq1Eb/kPuvP/YE7s3d1wynJHa
         dy59pm4GBynBEkBqx/LYmBYo3B51JWNhDVAHbhyO12qOLRltJDPX1RBMS6Vt/RviImEw
         5B4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790443568; x=1791048368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jhocdDFq9DeA/HG//FXJunjEWK5CDGAQOC1NTDBHIkU=;
        b=BCcaA2eAch8uJD4R+qjh/GPMviRZcBkPRh7A3DBlhdWDCmHSfwJxdZgUmNc7b0wz0D
         PVptYNFtJ7kU+5bURTH5OOQI8WH1BnzzZClFe0oDgiQ+uJICxP4AZOC//O/uItUQwhx2
         qY3GICttqIxIMnxZmGAOSt9WpBOSOt08iTX2gTl/sUtqb4o8noEaXh2Lq94Y4KhCQ7A6
         odV/qjYmfVzG8h8FtRilggAO2Zc+8WBq77l23kwqY4XdctCtY9OcLQxW0iuwW+SxQ5Ur
         3knnA713R/7XHjHOlep92eu2rxx1Sg29WqvWhDemqlpeObQci/5iROIwW5/+MyOP4rwQ
         Th5w==
X-Forwarded-Encrypted: i=1; AKwUvBwpVKjXiZ8+jciPyqTcop1yOtIE1Pvyd20NgUv/WK9C1+pqfI6ZtzEFxVC6T+pzByYhKYUwJvM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIg/KhKLTDvI4bRgdEWDNcK6AoJBDyz4xFB8//xLtUhi/ZxgV46
	PJwpjmKDLydrEgOMA3RCCZ+gabG6ot329Z5STYu1xN4fvMh54S7pBWlK
X-Gm-Gg: AYBFou0iJWz6AUrXGUuasdOwL820W49VYWgPKxMAFZXJRUcwcptopZ5aXwh++fSZbRw
	7l3BqHnS+sEsHLJvIePKZsQgmAC1akd7YGys7oU04gTJZQzsUsy8EWhnSWutrBVRPfrY/9dF1l5
	h0e9aLi+tffeu0J5dJQf75pcPmlqkudfuxypMrrV+L5dwW/Ejl6mZPHunpdGbwwXyVIypXcfqce
	RZ7CtzTSDBAIW3FR9s0myJsEsTSgxOZn0BTmlHTIki2Mr+vDEBCC4ElXKbgYTX0YzF2btvZz2R4
	xSTbuXuJ+g0JvyonJbMhQcnuWu4LoY8uXXkmx5pQTRyhCBHNjF+4gqw+g9sDM2Wz2t5QDJ+erAF
	1sKtppy6kYXVytlD09hSlY/8dhPhYmR/WXI6ppR1MdZNZrHDofbQnkiPuauobFwVoG5Sk5uzQvC
	F3Rda1PGpts3AYxuI/16COJ2t0LolfqXhk8W4D/THZxJCv5vH88F33X4p4dEvs0i2lTyGvDCkhZ
	aynvjUyuzJJvJ6MoxVKQRYpjAR5bHlnYYk2Ccx7V8TW1Wly6KK+fE6a+GASymSUWiEEmUg=
X-Received: by 2002:a05:7300:de0b:b0:341:f4d6:d9a5 with SMTP id 5a478bee46e88-3427169be76mr5652722eec.1.1790443567319;
        Sat, 26 Sep 2026 10:26:07 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34145d0fc9fsm16943267eec.25.2026.09.26.10.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 10:26:06 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Marek Lindner <marek.lindner@mailbox.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] batman-adv: Close OGM aggregation before transmission
Date: Sun, 27 Sep 2026 01:26:00 +0800
Message-ID: <20260926172600.2394088-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The OGM send worker leaves its forwarding packet on forw_bat_list until
after batadv_iv_ogm_emit() returns. Aggregation holds forw_bat_list_lock,
but emission reads and clones the packet without that lock.

CPU 0 can therefore start emitting a queued packet while CPU 1 takes the
list lock, finds the same packet and appends another OGM. The sender can
observe the new packet length before the corresponding direct-link flag
is set, or clone the skb while its length and payload are being updated.
This can transmit an OGM with incorrect flags or inconsistent data.

KCSAN reported:

  BUG: KCSAN: data-race in batadv_iv_ogm_queue_add / batadv_iv_send_outstanding_bat_ogm_packet
  write to 0xffff888100fedcf8 of 2 bytes by interrupt on cpu 1:
  read to 0xffff888100fedcf8 of 2 bytes by task 70 on cpu 2:
  value changed: 0x00c0 -> 0x00d8

Set num_packets to BATADV_MAX_AGGREGATION_PACKETS under the list lock
before emission. This waits for any ongoing append and makes the existing
aggregation limit check reject further appends before inspecting mutable
OGM flags. Emission walks packet_len rather than num_packets, so the
queued contents are still sent normally. Keep the packet on the list so
interface purging can still wait for the worker and retain its existing
ownership of the packet when freeing it.

Backports before Linux 6.15 need count-handling adaptation.

Fixes: 9b4aec647a92 ("batman-adv: fix rare race conditions on interface removal")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/batman-adv/bat_iv_ogm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 53fbdbbe8f4f..59847299a123 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1909,6 +1909,10 @@ static void batadv_iv_send_outstanding_bat_ogm_packet(struct work_struct *work)
 		goto out;
 	}
 
+	spin_lock_bh(&bat_priv->forw_bat_list_lock);
+	forw_packet->num_packets = BATADV_MAX_AGGREGATION_PACKETS;
+	spin_unlock_bh(&bat_priv->forw_bat_list_lock);
+
 	batadv_iv_ogm_emit(forw_packet);
 
 	/* we have to have at least one packet in the queue to determine the

base-commit: 165768bb70265b5c38cf0b73fafd75be235f8b14
-- 
2.43.0
