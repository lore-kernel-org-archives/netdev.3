Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105923E5EC6;
	Thu, 23 Apr 2026 09:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776937318; cv=none; b=WMtcokPOLZilxAxlTmcYHZSqTXrkfhdT+HWjhDwPPYqaMD8MeqZew9r+qksWv09nuLkTy8gqqlj1Za6bmYXcX5Vn9C0Tf2Aihl//alV3Mr2fEOO68Fo4J0yrXN03jbO0CgCS4bN69Dp8SohVTdHmQin/J0wGNYIzKkAsz66mw+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776937318; c=relaxed/simple;
	bh=3COiEshc7gTyW6DMFD5MNIcpreAuljSpeRgtW9AY7C4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FINTt9a1u9kXJ0rSVaFPWwL4DX8PzewkyWqIp26cBoBJKBqNkTnwmhNnyGy0+qdGCafVtRPbslv87/aZgv4/c4Fn/P3ONULoXBAKTyqHwY+5lolAFIbIoNbrTzhEcOp4j+SxipYMkOb6NFQo8b7aUcECNAxv7I8ggG6tSSZwqEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=emrACOhv; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="emrACOhv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=wpdPe9XhOX5V5gSK77+eeohi2elXFk0ijT4NFwGJpWk=; b=emrACOhvp8bS6Zzl31nEZlwfMH
	9l9r9/W5GIwC9X/lamfBUab/2PgSUFIiU+TJavdsM1jLAgcVcuq+GqFqN+GsrB3P1Vaj0lr5mmG2o
	ZFpgMVIPIJuFSyz9iZViqct2qtwaihMERFS3T4IfYKQGkTCv4o3fIwXlH0RHxAMCd2yiyf1L8j6ic
	eN/zRv6RvAqMW836aoozmJtjenN2pPgoyK0ofuzh0urQSGStXzobbkig+30B6dUP2YdTPZxoHijZB
	1x7N4phQCvaAt77G0uaGseOvDELckMdWvJ7IiSEfLkQfkYmkrwQm2/Acr/rzaWWlbPlnD/T4zS1Wg
	JJPWk2pA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wFqZH-002J3s-0L;
	Thu, 23 Apr 2026 09:41:55 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 23 Apr 2026 02:41:16 -0700
Subject: [PATCH net 2/3] netconsole: avoid clobbering userdatum value on
 truncated write
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-netconsole_ai_fixes-v1-2-92b8b7de9a2c@debian.org>
References: <20260423-netconsole_ai_fixes-v1-0-92b8b7de9a2c@debian.org>
In-Reply-To: <20260423-netconsole_ai_fixes-v1-0-92b8b7de9a2c@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Keiichi Kii <k-keiichi@bx.jp.nec.com>, Satyam Sharma <satyam@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Matthew Wood <thepacketgeek@gmail.com>, asantostc@gmail.com, 
 gustavold@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=2000; i=leitao@debian.org;
 h=from:subject:message-id; bh=3COiEshc7gTyW6DMFD5MNIcpreAuljSpeRgtW9AY7C4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp6elUA6o589/R/toys8m8U5tU9wH7ykF1gDTMB
 Ec09kwP/QyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaenpVAAKCRA1o5Of/Hh3
 bQKTD/9K4+NaDDl4xWsyLchSrx39pTsyKgoygnNMAEPFGhXkzjoGAfkPqUaUMUHPFW+YeYTbSXy
 rZP3dGQGmiAiYg1NsYq+zRXVlHFnerhmsPfXRgxY545ZHFx1jjtUw9s4RVTP2Od5roH/duJbVqn
 JiAqA37P5dMT+vSWHFk69eSxrwEKLuHq+VXzzMby0hfzHixDtz7goULVid3x1KJZ/H/VsYbNCJy
 E8eqmf7ldkaLD7yQCjnnW5aIHYJZws1yGLWRpz6GLGTAiNM4LdtOv3YSEPRvUZqNPeUInUHQ/bb
 rW09y1rx+KNvNJmBqjQkqHqJ6AXT79tJ4Z76jtNgi5h56OWbTEm3L7aPycbki+WuGi3DPFGkghc
 SL55ukgft5aEIS2ah9H+dlzHkJApybbRglri0i4uFuxkcPMolUyjTMZweWiV7txLFDbcXCCuEE9
 HK6N5DCLYEgFCIOejLOuA7U0/C+lNMkXZ5xb5TBCcHcTRKALe0OkGC5gUu4U9ACFc0uixWVzlAa
 qWodQ1iozHHUrYyhL43qinkgO8K2O7O6iEWSsEmgDxj+hShyB43QEU3fPvv+YzudEhS69kOZ0bB
 NC+37fdLooISoxNvoxMgrE8MKYFJjCy/VyUu1WjE7Q2RcYQheCYjhDma4T5xiyESl3iFOz/Xyib
 4tLI2JxwIWT6A2g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

userdatum_value_store() bounds count by MAX_EXTRADATA_VALUE_LEN (200)
and then copies straight into udm->value, which is itself 200 bytes:

	if (count > MAX_EXTRADATA_VALUE_LEN)
		return -EMSGSIZE;
	...
	ret = strscpy(udm->value, buf, sizeof(udm->value));
	if (ret < 0)
		goto out_unlock;

If userspace writes exactly MAX_EXTRADATA_VALUE_LEN bytes with no NUL
within them, strscpy() copies 199 bytes plus a NUL into udm->value and
returns -E2BIG. The function jumps to out_unlock and reports the error
to userspace, but udm->value has already been overwritten with the
truncated string and update_userdata() is skipped, so the corruption
is not yet visible on the wire.

The next successful write to any userdatum entry under the same target
calls update_userdata(), which packs udm->value into the active
netconsole payload. From that point on, every netconsole message
carries the silently truncated value, and userspace has no indication
that a previous, error-returning write left state behind.

Tighten the entry check from "count > MAX_EXTRADATA_VALUE_LEN" to
"count >= MAX_EXTRADATA_VALUE_LEN". With count strictly less than
sizeof(udm->value), strscpy() can no longer return -E2BIG here, so
the corrupting truncation path is removed entirely.

Fixes: 8a6d5fec6c7f ("net: netconsole: add a userdata config_group member to netconsole_target")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 5713cb3783ef2..4bef003d9df64 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1074,7 +1074,7 @@ static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
 	struct userdata *ud;
 	ssize_t ret;
 
-	if (count > MAX_EXTRADATA_VALUE_LEN)
+	if (count >= MAX_EXTRADATA_VALUE_LEN)
 		return -EMSGSIZE;
 
 	mutex_lock(&netconsole_subsys.su_mutex);

-- 
2.52.0

