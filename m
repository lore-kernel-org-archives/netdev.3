Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAD644A718
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778838960; cv=none; b=IbVYQjcuv4agtJi9fQAFAHCFmGbYFadFevCe7lEJSKiSNhlCd/GqayWOGL1DOCn/8/Fbi0I3Cw2ZX2FmEmBUcgLJHcGT5qdq7C3XfF98CGyeWsSx6+YotA+FiLQLkPDVjATH9uXc0lt1y5dnJ8D1HhHG5SDo85qoa5LcdQtYA0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778838960; c=relaxed/simple;
	bh=VOBjNS2eP4Hzj91Jjbmr/usVAho9tPIKHwgkQ6UgkWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sp+Cwf+15wLONg3UHbhkiPkTq6oT3nI9Sij4JhDl7cnIW8S1/O/qltDsFBenpnNYMa55W/TfHSjqxpXAkqyiin+ifqXpx7u4dGnXjdzOS+bRMNdLIZrfuJlrcSHFk5pcJgxwdvw+OOlGlJh1kkq7A08USiF9Ew3y4jz9Zd8lbxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=0N2lOlnx; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="0N2lOlnx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1778838951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oT/G9+Zz9YlSVEJ/eFHA+Bgj5aclyRHbfRtU5iwzmRQ=;
	b=0N2lOlnxd5O0KTE7O9focD8AsoIu80ISUws5w2c72OgQUPTEU9OY0h2DT9jbXD45KHga+a
	U7Hj1kzRW80/SWsqwCyCuFzZc9yyT69h1zkMY9lpItD0ClK9e/Y4DqUU3liUVnSGpGp2zg
	Clo5pkOcppsPUMt4PHb/LpFjdurqJ+lItO2MB5TgOuG9OyVGcchj9DsPBmznV5kXw15ZfP
	y8HTFwKsyaJsnSsEPy4wYvUY6fyx9vg/LMxSVkgnrI8jEm0zmfBzUd1I016kbrnGoGBhUS
	FKlxKCxpKrHsa7WjknsC32DjD9Dgkbyk7bBJuzYyjBvJCeBP+BeCNfyt5paFCg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 05/14] batman-adv: tt: fix negative last_changeset_len
Date: Fri, 15 May 2026 11:55:30 +0200
Message-ID: <20260515095540.325586-6-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515095540.325586-1-sw@simonwunderlich.de>
References: <20260515095540.325586-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

batadv_piv_tt::last_changeset_len len was declared as s16, but the field is
never intended to hold a negative value. When a value greater than 32767 is
assigned, it wraps to a negative signed integer.

In batadv_send_my_tt_response(), last_changeset_len is temporarily widened
to s32. The incorrectly negative s16 value propagates into the s32, causing
batadv_tt_prepare_tvlv_local_data() to allocate a full sized buffer but
populates only a small portion of it with the collected changeset. All
remaining bits are kept uninitialized.

Using an u16 avoids this type confusion and ensures that no (negative) sign
extension is performed in batadv_send_my_tt_response().

Cc: stable@kernel.org
Fixes: a73105b8d4c7 ("batman-adv: improved client announcement mechanism")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 888f337a194bf..739439e2b2350 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -993,7 +993,7 @@ struct batadv_priv_tt {
 	 * @last_changeset_len: length of last tt changeset this host has
 	 *  generated
 	 */
-	s16 last_changeset_len;
+	u16 last_changeset_len;
 
 	/**
 	 * @last_changeset_lock: lock protecting last_changeset &
-- 
2.47.3

