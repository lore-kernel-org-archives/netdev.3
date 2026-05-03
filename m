Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0D53B27CA;
	Sun,  3 May 2026 12:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777811007; cv=none; b=W3xKUbotZSjZ2FtLxpYXDVEspQ15wnINuo588NjxVa8asPqriVZza+A/XDRrgi8QEy1VN9z1nc0IuN22Cn0ohGtGKiuQv+GkGnloNnaNQglt+p0jrh8/7U4RWqwI+NFTwm0k7URuUJQ+RmNNk+X6D9+Yh2TyAGOTiM8GcvrCz9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777811007; c=relaxed/simple;
	bh=y4nW4Zch5/hoZ2XdmEqtSl1jLFkK3EBjUlFTE85Qak8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ijcX3hRTosP2vOkSWT+3UkEjSc/DEcgXnc22B1MIbKAJRVxYi31cpg6Zomx5DidyGgFHn3jBYMJa7rIPOTZ85hFXnFp2Aot7xgyMZE0B4jsM63PqvwsVJSijBEXmfjaWu5AOhz2KuEWLNd35x+kP/uJRUHinHjbrSxC3e2J4b3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=TXnTugjs; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="TXnTugjs"
Received: by dvalin.narfation.org (Postfix) id C87531FF1D;
	Sun, 03 May 2026 12:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1777811002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uf3A8ZlDl5176O66f9kBFMAsj3J5yTzZmJ++kvL/4Xk=;
	b=TXnTugjsCtjqpgblZC72+BQV0r4JUoLe5zisPxAnqE70oZdfrgvwyUsDhDv5ou3CYZz/b6
	ry4whvlcMFG3NxfqTT6HO0srATnN2mhAP35H8GAOaDLumF8fQjJIjbSslr08C2Ojq1Lb4w
	5ySQMfiqZhpQnQgm1nDKoK/1cepspLg=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 03 May 2026 14:22:37 +0200
Subject: [PATCH batadv 4/8] batman-adv: tt: fix negative tt_buff_len
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260503-fixes-followup-v1-4-4313278918d3@narfation.org>
References: <20260503-fixes-followup-v1-0-4313278918d3@narfation.org>
In-Reply-To: <20260503-fixes-followup-v1-0-4313278918d3@narfation.org>
To: Marek Lindner <marek.lindner@mailbox.org>, 
 Simon Wunderlich <sw@simonwunderlich.de>, 
 Antonio Quartulli <antonio@mandelbit.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ao Zhou <n05ec@lzu.edu.cn>, 
 Haoze Xie <royenheart@gmail.com>, Jiexun Wang <wangjiexun2025@gmail.com>, 
 Juefei Pu <tomapufckgml@gmail.com>, Luxing Yin <tr0jan@lzu.edu.cn>, 
 Ren Wei <n05ec@lzu.edu.cn>, Ruide Cao <caoruide123@gmail.com>, 
 Xin Liu <bird@lzu.edu.cn>, Yifan Wu <yifanwucs@gmail.com>, 
 Yuan Tan <yuantan098@gmail.com>, Sven Eckelmann <sven@narfation.org>, 
 stable@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1380; i=sven@narfation.org;
 h=from:subject:message-id; bh=y4nW4Zch5/hoZ2XdmEqtSl1jLFkK3EBjUlFTE85Qak8=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJnf7WQPqr574xO82ODYZeWFrLv33s18r+byNsoj6wvP8
 beLpO60dpSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAmspWH4X8c66XqyCO7Y6w+
 5uqp6nsqKdSqH9S+nGZ82/2di/PRidIM/5Mj1qb8vxYwvUb0e9i0gk6739+rA5crRN+QtXjseNv
 gLg8A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF

batadv_orig_node::tt_buff_len was declared as s16, but the field is never
intended to hold a negative value. When a value greater than 32767 is
assigned, it wraps to a negative signed integer.

In batadv_send_other_tt_response(), tt_buff_len is temporarily widened to
s32. The incorrectly negative s16 value propagates into the s32, causing
batadv_tt_prepare_tvlv_global_data() to allocate a full sized buffer but
populates only a small portion of it with the collected changeset. All
remaining bits are kept uninitialized.

Using an u16 avoids this type confusion and ensures that no (negative) sign
extension is performed in batadv_send_other_tt_response().

Cc: stable@kernel.org
Fixes: a73105b8d4c7 ("batman-adv: improved client announcement mechanism")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index daa06f421154..0f3814b458cc 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -452,7 +452,7 @@ struct batadv_orig_node {
 	 * @tt_buff_len: length of the last tt changeset this node received
 	 *  from the orig node
 	 */
-	s16 tt_buff_len;
+	u16 tt_buff_len;
 
 	/** @tt_buff_lock: lock that protects tt_buff and tt_buff_len */
 	spinlock_t tt_buff_lock;

-- 
2.47.3

