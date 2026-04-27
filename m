Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2936428CF6F;
	Mon, 27 Apr 2026 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777300266; cv=none; b=nlD45PR9uQ1zxXPUcpXF6/rRtLIAZDQnYyQpOiXSbGh+Mk/l06TdpHlJzduWkQsz9gzbpkIpURWYst6XTq9LMj/LuBDSNwXh7W9Lb6IUqoD5ofqnizQ8Ju3cjtkppEsAWJUj9XWz/w7ExVWDHajto7v9ddnD4MWRMCLE80395D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777300266; c=relaxed/simple;
	bh=bLVkfGlE+4YnYdZzUHD5T0aMLExjNa75wtaMKlYgH+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SZuSgMBs91NjHP6KzsUqJ66WEpkvbHp4imjG8l9jACqg1zQPr9vvJuPCsbvFMfwdpAj22Ghk7lW/gLvQtfd4+XC5PEz1A+NEGwyIbixeWHVTeOY/qksHE9fpJ1j3Ro+0ve0ByBABMT9uEjkbyqi21Uy7tAPyHXq5k3GaZKTgcgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=uKVhUxMT; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="uKVhUxMT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=Y9dLqnTcJyOaORD2CtNejwcCJpl079ntYSyxySX/GqQ=; b=uKVhUxMTYsG0kPf0o/8N5nor6s
	qegt1xD8XSE6FxOQqKKJ57yc75104LjuC4NJCjzW8q8sXV7lEdygGXdiHSupYfuoPqfRTTyuEchDe
	3zcul+vP/1TDY7IEseegSJhj0mwzpMxN3+Zfhl/Y8xBvR3cbEqpBLXg7ZGHvFCDQYexnbVwMa5waP
	amyGyafelY377gWqZrKVdN2iRcr+C2JaJeVaczjca8M+T9ilXoysVMcPbZeIqEL1D6KjjVKghVUrE
	GY0ZqRrrXm08hTc5H+Z40Uskkni17g1ZIZIPVhcQyKMkHQKCqabAVfH7YU1/TmRr9k1MGpH0S/YRe
	hpqRzv6g==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wHMzG-005Xx9-2f;
	Mon, 27 Apr 2026 14:31:03 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 27 Apr 2026 07:30:37 -0700
Subject: [PATCH net v2 3/4] netconsole: propagate device name truncation in
 dev_name_store()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-netconsole_ai_fixes-v2-3-59965f29d9cc@debian.org>
References: <20260427-netconsole_ai_fixes-v2-0-59965f29d9cc@debian.org>
In-Reply-To: <20260427-netconsole_ai_fixes-v2-0-59965f29d9cc@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1603; i=leitao@debian.org;
 h=from:subject:message-id; bh=bLVkfGlE+4YnYdZzUHD5T0aMLExjNa75wtaMKlYgH+E=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp73MSFszut1Lpo2zCapNDG9M3iQndsKrCygjbK
 PScv+xJwJyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCae9zEgAKCRA1o5Of/Hh3
 bQXBD/451tess8Xs1KHdYImSlyuZAJQFvQPOIcGoVYUJv5MSrgjzEWhmt5zpUStCCTeAMm1c0/D
 LArN4l71soNakDgGcWcz20Hbpv5SKjnRlahxl+rnGkM1p3LSEK1w7yMxar/OFiSirEFUlFkgbMF
 qlOFCTuY24b60Pc3ftcZm8Z+z2VRcdDrOuIdo5uYjuJamrDb+5rMvOEjD+L1SpMCpekjd6JU0r6
 /nTXvWwWJAos2OUABm+OIC3OFH+sFFCLlTfMT98qU5ev+v7aQJom0MmFtrGrw8I7tBqovbuVHqf
 Vy9UvtagRjM2Diz1kzLMHjGkax7/ObBjr6myHOeycRadAvWBgrpH8qW6kPNpt9nwdD533EAsBhd
 O3olWn+MthXcir4JgOvWSTZSiHiU46mFy3UD4/JTIFEnSzqVb7dummAVqwQJCuOrIS3puVwOMgn
 1d85A72e7B2Yt4lnpIh1qIfdAUE2FtjjX8tB5Nx7nKqMXMTuowFKx6yk92KQ73wcKJAJttphIN3
 coNGdBhyGgCrJEhrbHUxgAkS/a/jgudEJldu4opNr4LeY3TIx/7vI5igHXoEt0OixeQDeXcZc0f
 s2uynD1a7VuJiPpkR9I58VmJhR6bEn2Sakcp6BfDoPl2/92QHvBDxSyjPleivGbGl1O0990Usmk
 hX3jznfCWYR9Zaw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

dev_name_store() calls strscpy(nt->np.dev_name, buf, IFNAMSIZ) without
checking the return value. If userspace writes an interface name longer
than IFNAMSIZ - 1, strscpy() silently truncates and returns -E2BIG, but
the function ignores it and reports a fully successful write back to
userspace.

If a real interface happens to match the truncated name, netconsole will
bind to the wrong device on the next enable, sending kernel logs and
panic output to an unintended network segment with no indication to
userspace that anything was rewritten.

Reject writes whose length cannot fit in nt->np.dev_name up front:

	if (count >= IFNAMSIZ)
		return -ENAMETOOLONG;

This is not a big deal of a problem, but, it is still the correct
approach.

Fixes: 0bcc1816188e57 ("[NET] netconsole: Support dynamic reconfiguration using configfs")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 595e09bd1ccfc..b3b36e3ddd03d 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -817,6 +817,13 @@ static ssize_t dev_name_store(struct config_item *item, const char *buf,
 		size_t count)
 {
 	struct netconsole_target *nt = to_target(item);
+	size_t len = count;
+
+	/* Account for a trailing newline appended by tools like echo */
+	if (len && buf[len - 1] == '\n')
+		len--;
+	if (len >= IFNAMSIZ)
+		return -ENAMETOOLONG;
 
 	dynamic_netconsole_mutex_lock();
 	if (nt->state == STATE_ENABLED) {

-- 
2.52.0

