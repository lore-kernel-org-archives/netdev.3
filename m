Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F8F44BCB8;
	Tue, 16 Jun 2026 16:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626385; cv=none; b=bHnizwBd4vTl1fxMDDZ0SDk9CJmCq3Z7hnQOnxQshAf9Xf2wVH/CoBkaLwTdzxD/HNHHB6WV1QBmkvEJIeLSC7R5/Z0zeF6A+Sp0T0uGFpIJDJx9pvptlarruW79bhahu2Hwq3hubXUEuAApryECmr58LbCGf82Nptqw3GLyBG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626385; c=relaxed/simple;
	bh=Rzr0teClqHVGIgTKa2SjL/rTJ0Pgys1zgYVSRiRYIxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dQw6boQRpRsHuYrjRyEx/hRMxLJoN4gbrK3SgJ8BwRKXNQLwIWPMxI2Ht2D43FE4qkpiHhKx3xeUodWUwWwxf0noEjcDEbEtcGBXxOyIsxhCGsTGNhouM3z7JJu0q1wN4rJjtkzGX7qRBPqmQQLcpTuQjHYIIIgeimVm5N3410g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=FC5mOlFS; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="FC5mOlFS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=8FfOzm9e3P0FRx2FSqYMKY7LFYF+7iCjjydnhlodSKk=; b=FC5mOlFSEcQWn0P/LetqeNlu+P
	bDV9dTZoPcdBRsPf01iQ+Bw4xnQDBSGNloKhXO3g/fA9J3H0Osu+3a0QpI01eia9JwQWKBO6Gkrkg
	XvldhYXIlFoRoU0Ym9ATzo2vFsoJsp3zPIKCAt/OysOpeG98HDh+BiEeA0EbEj3blm75jg23lVZvh
	CifqPw0+JxeE5P+nWpHz+7XBmyKN0aCy+lx+3XywEdAvCrSM2Gm35FLmyNXIackLO/J4CRSkY8OKu
	nKrNFH6FC6tj8R2uXI7Bxo5dd4kZaafK8EH5HUk6HV/6obZktJptpP49PAgsYBl1bG+Kk33oyu8x+
	d1jUqVcw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wZWPH-00Dy4f-37;
	Tue, 16 Jun 2026 16:12:56 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 16 Jun 2026 09:09:52 -0700
Subject: [PATCH net] netconsole: don't drop the last byte of a full-sized
 message
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-max_print_chunk-v1-1-8dc125d67083@debian.org>
X-B4-Tracking: v=1; b=H4sIAE91MWoC/x3MwQmEMBAF0FaGfzaQeIiSVhaRGEcdZEdJ3EUQe
 xd8BbwLhbNwQaALmf9SZFMEchUhLVFnNjIiEGpbe+udN9949nsWPfq0/HQ1NraJoxscjw0qwp5
 5kvMdP1A+0N33A1N2jVNmAAAA
X-Change-ID: 20260616-max_print_chunk-0a8cea1b1ed7
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asantostc@gmail.com, gustavold@gmail.com, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2435; i=leitao@debian.org;
 h=from:subject:message-id; bh=Rzr0teClqHVGIgTKa2SjL/rTJ0Pgys1zgYVSRiRYIxw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqMXYD6geUvKbRapyTEkXciDiyeVVM3S4AJ+cda
 UPnYFrR5SKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCajF2AwAKCRA1o5Of/Hh3
 bRMjEACSBrF7kK6TejsV8rD9AditbyclnCwZhFXPLoLv1aG+R+CilVUCIJqrbWUXdZTGUIHugxA
 7BzCytcA6/X7F7nAfyPRSz4+5zWJvpvhzQ37zsZFkqqUyID0hxDTbcP01eImnZa1vYq387zAiyz
 kdxhbAyp52AKH2qufB/v6PygN3ZGb+xrUx3nO+lXfUhwzdeoyfI9pSg5zZq30Lcs8CprRWx823S
 itt6wAu1LZl0VKOe8qnIJ6YloCMVgJrX1RXSTDIXTAs2aI4nnpbQvYItPv2ZnYhlLZONl+KDKKF
 E97bOhc+XvwngBRG1he/EOoMMT3Vr4wLOnnCK6d0wD3ZuL3xZnJjKy+46x8+1Ua9j2smrxjK0h/
 XZoSASoMNDxuq25oCW7odM8oH1vZALgMM/51QxOjRXB/FLydSFoNtBLqMySBYOb4ZWDmuL8FEmk
 7aPbsZUTyqvMtWEWmX7QA14IkN0A1Bb4hkYMYnfM8wxLNwGKu2xp+Tai66lOSGqPXe2+6AprkmA
 BK8wkigyWTTJ1nnwgNesDIu/S0aPWkE+MWjCAPCZBPZcMIdHdGI0pu1Z5zkjmYDQKCH3Tn7dKW3
 nAGv3CdpnDfzDiiApgEAmgkbnR7JrSxthwVXNzNHFzqMPF3WoyhL6k5MmLUP8UM8+vj2r2Z30D/
 RrJEw5pepOsc6vg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

nt->buf is exactly MAX_PRINT_CHUNK bytes, but scnprintf() reserves one
byte for its NUL terminator, so a non-fragmented payload of exactly
MAX_PRINT_CHUNK loses its last byte (emitted as a stray NUL in the
release path). Grow nt->buf to MAX_PRINT_CHUNK + 1 and bound the
scnprintf() calls with sizeof(nt->buf); the transmitted length stays
capped at MAX_PRINT_CHUNK.

Alternatively, nt->buf could be left at MAX_PRINT_CHUNK and the NUL byte
reserved by routing exactly-MAX_PRINT_CHUNK payloads to fragmentation
('len < MAX_PRINT_CHUNK'), at the cost of fragmenting those messages.
But it would look less sane, thus the current approach.

Fixes: c62c0a17f9b7 ("netconsole: Append kernel version to message")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 57dd6821a8aa9..bfab0a47678c9 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -184,8 +184,10 @@ struct netconsole_target {
 	bool			extended;
 	bool			release;
 	struct netpoll		np;
-	/* protected by target_list_lock */
-	char			buf[MAX_PRINT_CHUNK];
+	/* protected by target_list_lock; +1 gives scnprintf() room for its
+	 * NUL terminator so a full MAX_PRINT_CHUNK payload is not truncated
+	 */
+	char			buf[MAX_PRINT_CHUNK + 1];
 	struct work_struct	resume_wq;
 };
 
@@ -1692,7 +1694,7 @@ static void send_msg_no_fragmentation(struct netconsole_target *nt,
 	if (release_len) {
 		release = init_utsname()->release;
 
-		scnprintf(nt->buf, MAX_PRINT_CHUNK, "%s,%.*s", release,
+		scnprintf(nt->buf, sizeof(nt->buf), "%s,%.*s", release,
 			  msg_len, msg);
 		msg_len += release_len;
 	} else {
@@ -1701,12 +1703,12 @@ static void send_msg_no_fragmentation(struct netconsole_target *nt,
 
 	if (userdata)
 		msg_len += scnprintf(&nt->buf[msg_len],
-				     MAX_PRINT_CHUNK - msg_len, "%s",
+				     sizeof(nt->buf) - msg_len, "%s",
 				     userdata);
 
 	if (sysdata)
 		msg_len += scnprintf(&nt->buf[msg_len],
-				     MAX_PRINT_CHUNK - msg_len, "%s",
+				     sizeof(nt->buf) - msg_len, "%s",
 				     sysdata);
 
 	send_udp(nt, nt->buf, msg_len);

---
base-commit: fbc6a80cb5d3fd4ac4b56e8c9d791dd17be890c4
change-id: 20260616-max_print_chunk-0a8cea1b1ed7

Best regards,
-- 
Breno Leitao <leitao@debian.org>

