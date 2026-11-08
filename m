Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794131168;
	b=Q7esyWZv1qF/FAyY9z7dW2qfcHSm7C4EsgUUe5oE+q79PPDnF+ZXzNu3QkFolWcg2AWu
	 fvxRm4Im0MpKLFcM3H3qKNQa+lJQqDtSRhAv758wDbs2NJquz6rgKjQ5+oVHS53kRP6kH
	 aPR6hWDamgH0J+5iaY4TOAMcNFUkH28tOrBy5ac6LEfUeblZN6bHyK5OdeRm3s1w02vFl
	 syFOFwfAsGp4oB9wxenXZ7YD7BEdgofCRJNgFp1c1MpvqmLdUr/jFvKJ7MHOTjIidt6bz
	 uMMQiZO3bT8gpvOuZe/7UR1nN0i/Lf5ilqIUfqDrAxluOQ920bcJu41ePTLyhfmnNpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794131168;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ynuj/xgzrPH7t0ZbRGi449rxxjP3Hij7LmmtRUcxIcQ=;
	b=BGaSCQL90f1cck5qRZITYTe1yyET9PksdgZTfpzf1uDI9nPPdVwCEaYlkmkNKcU1SC3T
	 Oz5USrmhkRB02hkqVP37fpb5IKSw0sNKp0yIPrGIR6bHlevFsx1aSU5sOIQd4dyfeY2kN
	 vPVCE9JTG4RPXkU0yt/pYMyri8zLFNmtFH09TBTt93tEGTfIv31DWifDGc88AIU6GnJ6U
	 aZjY2yGGyZnhoZxrfvbh46+agdu6K5SrZRtuF8WeKdp37bde/lnnnJStZAKaTevgdLlSZ
	 yxZ6g4fwOIfIwoLCmjkO+NMp+kXBwh/InvSK7Xz8JrnJiPRDzCUfBFdDAZJy6DVShEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DOGKrQlI;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C6B606D806
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 09:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4C6B606D806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DOGKrQlI
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ed28bac8d7so213385ad.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 01:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794131167; x=1794735967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ynuj/xgzrPH7t0ZbRGi449rxxjP3Hij7LmmtRUcxIcQ=;
        b=DOGKrQlIBTYA87kY5J1wQsBCfRInJmoUiX8QdoKBmZILX8dNfjwt30s67dySgBYgtQ
         g2as6iZS+ORyTOb/0FiMVLM7CTe1JI/TWgApFHGZlvEvls/GTEaabpZHOGJYfMyZH1Sy
         ufT61Aw7Tp8g08OeZ/C13SSKCiP4G+ht2lMJTuiOpSNKuZCcYNOjh/AXD1hEvAR0RpfI
         LwxaaimOFaP+6miHtGoEsi0emjWvud4I6Nbf52Tdeo+2ha/beaPS97UoPYl++Vyl9d5x
         P2tBp3B39z9zSBi9pd+YTIU6NLSxXcLg1VijSBLOnGWClJb3nc6q11rAjzZVRH9GzQpq
         wBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794131167; x=1794735967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ynuj/xgzrPH7t0ZbRGi449rxxjP3Hij7LmmtRUcxIcQ=;
        b=yGp2QvNuUOAACCML2hql+T5MJ8B6R5EeRIgXMi64HvMkc+MAUFwrQKqhARXHZQQgIM
         Q4NWz70lCKPoLDykqca7EHgmeGal7v/ymmszQDpitOXiZIE/WN05q99pv3XPuPrJROvS
         B/XEqGFgB1QPOnW6kFWe29Woa6Ce4t1WtwJxSHIZ1xd5CHxd1RCYZBREAwiDrZuer9EN
         yXZUQ4C+om82UJ/f4EIEc4vSpxK+Nn9RerdoYcwLfo+1KApKgW78LyCbojHpQd3HGr6K
         rRFsJfr//kQeu3NEW/qNunEqxbe4zQBXW3wLc1Yk2RCOnT8RheTdr4zwUkoZegJQbr2n
         nojQ==
X-Gm-Message-State: APuU4Z88dUUAsQZD4GJzvzyrgUGGEgNX3iAOIItPqE6kky3cAokK3xHQ
	ItZ/lof4jtDFiY7fqFuWcjr5o7QhuSqpilaoI30+wWcGeZXAQOffi/kBsPSBaA==
X-Gm-Gg: AYBFou1pFD6rdKijPaaMZdA4qtQVja/e9sVWmAEeKwyNW1C4EEfXMlDdXtIaZx27co6
	5j694khv63Dfv5we4SgwRjQA8fEHqwm2vLUokktgzsENRBP+VLdykSgLGqft3q3gWQw8RQLbZVG
	hs0Hs85teE3onu7FyCcYai4XwZ5RUfa3gZXwYRoaDuj0boDvmnmVLXM/d7/z2XtP86KwkFd7/s+
	lK/htBnzxOVI1yy+pjoXptPkccgTqm9Yhr/xc9BByuLgigq9ymHt0AtVuei9Q6I2ShUyNb89cRq
	HB+s2kDDAhpQfO3s/Gh9RiEHeTr/AEhm1pgR6/YkM5oho01rhBU6YQA0AScL+k9+yAXmpYgy9Wg
	xrQ/ADth5E6oeGREbUu1g0RZ7YPN2fs0bIamKqoUcvx/eRBYNZ80ppG85S0Fi1nJch1R9vZkV16
	A+BDw7eUsNKpOZxTvDVURMsO72f4CJUlw9jibf6SxzWFC2inooJfcC6rFf6qe9+YdS621zsP4Jm
	fUx7WNf+4p2pqmubxOXAYEJK24+5SfHMjF2FlKNxsyFre/gEuK7iJmICMeIJpefDh69Der5hIGz
	uH6EGiqxeHREEbJcXAC6lUzRKiLyJqD/nBHRLVOsHN/5AoMq9pR22g==
X-Received: by 2002:a17:903:46c7:b0:2e9:95b9:4bcb with SMTP id d9443c01a7336-2ed83741285mr6916135ad.14.1794131167148;
        Sun, 08 Nov 2026 01:46:07 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed813af834sm3222715ad.0.2026.11.08.01.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 01:46:06 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/2] net: dsa: motorcomm: Report error when FDB fails to add
Date: Sun,  8 Nov 2026 17:45:09 +0800
Message-ID: <20261108094512.1285796-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108094512.1285796-1-mmyangfl@gmail.com>
References: <20261108094512.1285796-1-mmyangfl@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fdb_add() ignored any errors returned by the hardware. Return error for
that case.

In practice the 4096-entry table is hardly ever filled, and since
fdb_add() will automatically expel dynamic entries, something bad will
definitively happen before you fill it up with static entries. This,
however, is in preparation for the upcoming static entry counters.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 33e5fc127244..a7a9a7439304 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -725,7 +725,13 @@ yt921x_fdb_add(struct yt921x_priv *priv, const unsigned char *addr, u16 vid,
 	if (res)
 		return res;
 
-	return yt921x_fdb_wait(priv, &val);
+	res = yt921x_fdb_wait(priv, &val);
+	if (res)
+		return res;
+	if (val & YT921X_FDB_RESULT_NOTFOUND)
+		return -ENOSPC;
+
+	return 0;
 }
 
 static int
-- 
2.53.0

