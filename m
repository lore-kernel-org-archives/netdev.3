Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F18F47CA62
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 09:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789983696; cv=none; b=A4SIOiqfGX2TmJvqLFezHXz0mwYC2jk8SFQIL+g7GSHn7mBHn5SS0qIHnejq3qvIg4N2wNcaKija5jcumnmsXL4ishtk8EcQt0eawhLrWVwlAXOk6DdsFFaRQEUgUMl/MVMpr+KI63Z+O63PmNXNmyUYpyrpY8Zk8o+7ugg3vPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789983696; c=relaxed/simple;
	bh=ozu5/SZuYmOj7l/+TcTNUYCFkfrJn6H80xQ/szzuqj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1ATj6UDTud+gajTmzYxxkyi+s1ytgTVP7LyptXVsmkQjA8ZmBuc08dnZ/R6zazh0GqZnysaVap2+q6nBnE41UDtco3u8gsjZMljCKxDkxnQZ/GXvA+3DkNzUcuTsU4fguSy6NzRYkGoA7Ow5iQlB3XELI9k9wleGh0y4M19pT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbZCAa+5; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbZCAa+5"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebad4afso1929382a12.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 02:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789983692; x=1790588492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pJ8HiLAEu0EI7hAaBs+acvitqX1WjD8B529R9qokT7o=;
        b=cbZCAa+5cVog9asM1kucgkDgEirPKJf2FWMUurtmxxfBMpWniHsQWfyNDa+wcPBYG2
         nW3ZrKoCTcs1VPCDC1AYpSOBMW9SKUX2eRZ9Ru1BITSBMJctVM8NxRwe1SjmZyImwCXO
         ufrmjkUinPi9UscH3XLZsnPP6pUazuzRr6+hWO+33QnhyBppGyxvK7bBj2LmbNbVnTZE
         L2fvPXARJx2IHY67edo4wGBlnGasZXFga2i0086duAcP0E5tN9ZwPWRVpyQv3qXRB/rS
         mc6KFejXmtCLykbNqJx4k/3xyu1bNn9Xzsh/kmdeZyYsG96m/1CoLS6OYcgTtqOpXNuT
         T3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789983692; x=1790588492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pJ8HiLAEu0EI7hAaBs+acvitqX1WjD8B529R9qokT7o=;
        b=bVNytvP8av6cMgkreShCuUCqMJADEtX1ESjKNzy0+LQwaZ/e4/Z9FTayeSu8uqpze5
         lWN/KEdxxz+3i3iDzefr1OARALI3lbHpKo/ZQQFtbJriUOiMKRgN8d2ZU3WwvgitU+EG
         8Mq0I/S096pRb/Oq6HQNfkVhE0UbovaYaFgx86zY5ctmXdMg34SkU9NKlqOhsYUR+bLM
         NF0x8UHSwaRFTFm9QlHX17mT9xEOPMQkAbK/9TpFnmSvQ+8TsJx0Bfa0wQ56X9PNOeYa
         DIMd5OA/NUwz+K6P211hcHu2yeNoPZOwtNQ7KzkWdbWU8UFH3xT3+S+79IoLTeG69M9z
         Rxaw==
X-Gm-Message-State: AFuF++n5zsBMHMigqV8ORFmr441x6Lo01NX+wAHv9s/qKncjaqirsqE6
	wOOSp7smvABNNZoWWAw1vR19xbwAleTGH12sTlKptLqrgnbCJ1uPCwBl/Lw2y4WcY9nYCA==
X-Gm-Gg: AYBFou0BpAdgiQiJYaGr8cta3wRH7MN9mCBdIJmWCUO/1Kwy6mcFD4+lNrRRNFdB+wh
	QRyJWU/xfLJFMrWRhx64KJFUMcxb41ybPuoQELP/Q2wRYNLoXI8pyqIefpseDybpCyEl+/lWdVV
	w1duZVvepQSt9cHlCyx/ulTsAj1HdAbFioXwzeYeJ1OSpJJBULxJ9CQ3pZkv0bB7cSvLuxkYw6S
	c+GMzP48rbQvuTmvl2Kps75qiLuTs9oOzzPuga1esOaPkIbq4FkibOR3A6TPNGmiehQArlsGoc8
	Ixc8iYwJ5YcENcxEPBQg7rjxQGJeNRFkFoWfHtuxencfBLvzishtfvA9+TSDNIOUNuT+3Ph+FkG
	iwLklcxKu6jan9Cr+k0/38JG3wXvKmfa0FDeyQBffzRphfk4rv6RUrutO/oq211MI/QB5PYi4AT
	dqLHGE5XwT3nev0zNBSBbUhQvibhtRd+OJyfKbfxM601A1KmgM3S3v0/BEIRn7L/XYksLzhSY2E
	ji0SlNPM5Aa9N3yvhaU/fVavoWFiwMg8KAhFgFsT8bOdiJty95tg/bvu2yQXF9Q1wmJY7rbgKZV
	tnDb
X-Received: by 2002:a17:903:2c0e:b0:2dd:c100:7cc3 with SMTP id d9443c01a7336-2ddc1007e21mr89901765ad.63.1789983692380;
        Mon, 21 Sep 2026 02:41:32 -0700 (PDT)
Received: from lenovo-thinkbook.lenovo.com (n112120123178.netvigator.com. [112.120.123.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc17a04afsm31053665ad.42.2026.09.21.02.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 02:41:31 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: netdev@vger.kernel.org,
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ying Xue <ying.xue@windriver.com>,
	Parthasarathy Bhuvaragan <parthasarathy.bhuvaragan@ericsson.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	xuyq21@lenovo.com
Subject: [PATCH net v2 2/2] tipc: make conn_idr teardown safe
Date: Mon, 21 Sep 2026 17:41:15 +0800
Message-ID: <91e85c3211fd31d24b231e8def5755c0f18b71f4.1789960909.git.xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789960909.git.xuyuqiabc@gmail.com>
References: <cover.1789960909.git.xuyuqiabc@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The teardown walk iterated conn_idr by incrementing a numeric ID while
holding idr_lock, so it could scan a large range of unused IDs without
letting a connection's final reference release make progress. An entry
whose last reference had already been dropped could also be resurrected
by the unconditional conn_get() while its release callback was blocked
on the same lock.

Walk conn_idr with idr_get_next(), release the lock and reschedule when
no entry can be taken, and use kref_get_unless_zero() so a connection
that is already being released cannot be revived.

Fixes: 35e22e49a5d6 ("tipc: fix cleanup at module unload")
Fixes: 667eeab4999e ("tipc: Fix use-after-free in tipc_conn_close().")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
Reviewed-by: Ren Wei <weir@nebusec.ai>
---
Changes in v2:
 - Rebased onto the current net/main tip; patch content unchanged.

 net/tipc/topsrv.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c
index 908622a3d0fc..9333e36a74de 100644
--- a/net/tipc/topsrv.c
+++ b/net/tipc/topsrv.c
@@ -710,15 +710,20 @@ static void tipc_topsrv_stop(struct net *net)
 	cancel_work_sync(&srv->awork);
 
 	spin_lock_bh(&srv->idr_lock);
-	for (id = 0; srv->idr_in_use; id++) {
-		con = idr_find(&srv->conn_idr, id);
-		if (con) {
-			conn_get(con);
+	for (id = 0; srv->idr_in_use;) {
+		con = idr_get_next(&srv->conn_idr, &id);
+		if (!con || !kref_get_unless_zero(&con->kref)) {
 			spin_unlock_bh(&srv->idr_lock);
-			tipc_conn_close(con);
-			conn_put(con);
+			cond_resched();
 			spin_lock_bh(&srv->idr_lock);
+			id = 0;
+			continue;
 		}
+		id++;
+		spin_unlock_bh(&srv->idr_lock);
+		tipc_conn_close(con);
+		conn_put(con);
+		spin_lock_bh(&srv->idr_lock);
 	}
 	__module_get(lsock->ops->owner);
 	__module_get(lsock->sk->sk_prot_creator->owner);
-- 
2.55.0

