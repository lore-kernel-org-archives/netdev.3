Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8025C175A8A
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 00:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788655175; cv=none; b=Z5hv899JLTyRV/XFOaCrOCTZN8+OIvYXSucHi6wlkfuCyBReHdCiCdFRlKbhd873m49AGM3trg+kyIsl3fZoikj1nZeLXME5GDq4TJ6MRwAOoglksfFZ2ktTxbD+1qiZe3w6zQzwIw5mFBFJKWDHWNQ9XYNHu3AuP4V9MqtFvP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788655175; c=relaxed/simple;
	bh=X/xRmr4GqSFunc+sX8Q9MZBpCDeItpD08dRwHxnF2ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VWM3eT2DV00eA+wYWgMIx+RCadyZGctJvf4jpUiHQIHFE9a5/qqX9qhTX359ZFgJPNDs8lKTckLLMJO4lQu/gvYfH1RvjzLaI+3EmnidWBgFVWeV7F4tz0Nd/PqQqwwCmRxaClZj3e5c95nLzGiwUYSDnnt5egbhYJCZucaeSuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJiSjcih; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJiSjcih"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48436216a98so1471434f8f.0
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 17:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788655172; x=1789259972; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pcaDcOTwZKz9h65XJ4Y1vvTbk/7+OUqBRO3ySthF/ls=;
        b=NJiSjcihjURX2UzkgQzSq0Pdbs8S80fLRnciuDLxT737lprj4ZgGjIZa7bzMwGQ82F
         06zXPQHhwqKGM0NDJx38lNh66UdxcY5r4vGsrY+ogiLSGJmiRkTtSyV+RYRocHYa+Le1
         ZNVqtgVHjuQ1egvl82b25mhwztHmyyE+sf093KG1lKc/wNi02ZMOoA1Adp+xsbM6CKbu
         RGL6ex+R+AotwU6FoewlBSAAXglfxLpzK4pAOrFE0fUTXd4EjAK8r00nPxBJFxmVgXMo
         4VS/L007rRBlhV+0elvufupfp7EA85gOeb8wRGv4qW20U7Z2IVHD4wz+OckoXWEq6xsK
         +aVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788655172; x=1789259972;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pcaDcOTwZKz9h65XJ4Y1vvTbk/7+OUqBRO3ySthF/ls=;
        b=OOQotmqy1hBjQtQ3IICvp/w9ZtZgrlTxIGMdomZM+7A+kTwUo6dQrdlMflfj5KiCj0
         jAEBWg5tZ/94MaKQl8zpogYv3TB8a0z2Cvd1GWfyJElujhA1/4U2f7eV7V4Oj69rdxEX
         VMJysUzhdrdipEDI8dv+Ln6l9OpvtpRdByz6odrQvJd7V0fANmwlpE4JdrNA+qzJxet5
         6P3cuO6QWnVgqrH0eJP5mmtp7wrAwqaSxoFB/gAztzkhkvvfsWvmY/8j7aHd9BWbwzET
         vNEmEgmF5nJU5duV793bTMNCC6UccAchOjwtzooQtcpHfIxjyFa6b90e+dfiiH/ev0yP
         KH+w==
X-Gm-Message-State: AFuF++mRF48NB2Za7Sp4D6m69kWpiBikqJV/CF5MWK/ByvSa/EtJN0T1
	FRSCXdl4/9UT3qIpRX8Uj/QC+VPQNg+v68UWM0Z1bd/wGcUS8iEaHbS97ShQ65curOQ=
X-Gm-Gg: AYBFou2rxlV4j82eABDn99RHCFt9SyRqH9K4z34bZoHe5itGrOjJGEseO2Xn5P0bXZr
	BbGNb/XVrmpua5xSBjIklRaYcuUr8ZujeZzPhbXGO8FlKCkbacbRhVFpwhP4ADm3VmQswhwyq1X
	cvhGXfbkxhBKXHUk45m8bEnZHZHqo6PPh9NVVR7CrsjzZdE35JivveGlNOomWEVYHqptHTvfL9f
	ClXgntjMHzkWcghcMFnq9qXZNdjVKPteCmN1G+KGPh+KxbeFFMSu2x/lukuQ6U1/27RPR7qIItw
	VDTw6AZcT5fS+sHs/9/vB1Sr441PZX8ylM4z5UE3whw+f0BatcP/sE2PDzevhHvHTBTDQ9pZSRp
	oLjZ3IdWWcLhLNMN9qIJdmKsZLgzl+atjIbly8/g8VGDPjqTJW26wYGHTYZSwAa42VQEQBsHSsk
	3V7cIGF96cxYPco+Q7qN7VD0aoo9QfKK/MkqDjFMNPogvnSgFVS3sBJSXryw==
X-Received: by 2002:a05:6000:18a8:b0:485:8c17:975e with SMTP id ffacd0b85a97d-4858c179915mr11914158f8f.32.1788655171649;
        Sat, 05 Sep 2026 17:39:31 -0700 (PDT)
Received: from metepc ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885b1320sm17088363f8f.27.2026.09.05.17.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 17:39:31 -0700 (PDT)
From: =?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
To: netdev@vger.kernel.org
Cc: david@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>,
	syzbot+1e3df0852e82c21ca418@syzkaller.appspotmail.com
Subject: [PATCH net v3] nfc: llcp: fix slab-out-of-bounds reads when logging service names
Date: Sun,  6 Sep 2026 03:38:08 +0300
Message-ID: <20260906003917.627282-1-omermetekaya0@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260905225211.596366-1-omermetekaya0@gmail.com>
References: <20260905225211.596366-1-omermetekaya0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

nfc_llcp_wks_sap() and nfc_llcp_build_sdreq_tlv() pass non-null-
terminated strings to pr_debug() using the %s format specifier.
The buffers are allocated via kmemdup() or come from netlink
attributes and are not guaranteed to be null-terminated, causing
__dynamic_pr_debug() to read beyond the allocated region:

  KASAN: slab-out-of-bounds Read in __dynamic_pr_debug

Fix both call sites by using %.*s with the explicit length to limit
the output to the actual length of the string.

Reported-by: syzbot+1e3df0852e82c21ca418@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1e3df0852e82c21ca418
Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
---
v3: Also fix identical issue in nfc_llcp_build_sdreq_tlv() as
    suggested by Sashiko review.
 net/nfc/llcp_commands.c | 2 +-
 net/nfc/llcp_core.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
index ca89fe967d6a..1213946ce91f 100644
--- a/net/nfc/llcp_commands.c
+++ b/net/nfc/llcp_commands.c
@@ -135,7 +135,7 @@ struct nfc_llcp_sdp_tlv *nfc_llcp_build_sdreq_tlv(u8 tid, const char *uri,
 {
 	struct nfc_llcp_sdp_tlv *sdreq;
 
-	pr_debug("uri: %s, len: %zu\n", uri, uri_len);
+	pr_debug("uri: %.*s, len: %zu\n", (int)uri_len, uri);
 
 	/* sdreq->tlv_len is u8, takes uri_len, + 3 for header, + 1 for NULL */
 	if (WARN_ON_ONCE(uri_len > U8_MAX - 4))
diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index cac1b5487064..fda236e4d9fd 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -341,7 +341,7 @@ static int nfc_llcp_wks_sap(const char *service_name, size_t service_name_len)
 {
 	int sap, num_wks;
 
-	pr_debug("%s\n", service_name);
+	pr_debug("%.*s\n", (int)service_name_len, service_name);
 
 	if (service_name == NULL)
 		return -EINVAL;
-- 
2.55.0

