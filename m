Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4DA400995
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 05:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228288; cv=none; b=UEePCgzuG+EFwa5iK1LSne97DicsBQwOkzr08fKgL9yK+Nq/WkyzltkE6nPFc7bWx0N4mCMsD9yQWT0WlS4LV0rQf+qgPzZrLikn+BnXv207jvWLWyFPY3/VMbpPDQ0RdcrIgC4SWGKgyYDTBBp7eJXfohYCbwkzW5u6MjkufJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228288; c=relaxed/simple;
	bh=cDrYNT/vM3S+F8pDVAtrGqwLC/JY738WsOSLsGzj7qk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ufMytqwrbKwpR5xOoHbDGUxf6AHAHfSrdaEx0liN6qD+OtEVnq0qm8r9KWthpIM1ovewmKOGPoFVnd/DR3MWJdtvTJYmIhTOnVL4tZ63YZdZ9mkKTUW0IHIVf+4nc7Mh9cAMQOgqSf8p9KoVux4weh0wSinJjgVHvQPAvmJjRuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCHI1l5Q; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCHI1l5Q"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-396ccda24afso952192a91.3
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 22:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790228286; x=1790833086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VKLwiiEPAjETYRoUGWduaZyZsJc2x1dKmXcYg2HylBk=;
        b=DCHI1l5QOXDawGvsM5slw7FONXGYAe7aKp1F9BJ7mEP1bHf83aJOvKRTM4033yBQj1
         8yyCasKd38V7ZJa/LFuZT2gp7TewPf+UhqxaY/A+TC5cS0pMvtYR6TlCf3e9Z1xCVBoI
         G4XgolLCC5bMqN9YkJY7NhcCA7ZhS87JwcmmpAAPnOWwSpRoIleybj1nH+r9ho4N32+H
         lzuw48jAkJShZcAQQplIFIXmeRgqjAtErUvHk06br5G4vdYjltp3pO/Cxlnhjm0+Zmxz
         JwOp6ABnegfImNeN+e7HcqHfJB/T42A0ptTvtFVMv/P2HFgJCMylg22fwRk+R+vpo7Jy
         f1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790228286; x=1790833086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VKLwiiEPAjETYRoUGWduaZyZsJc2x1dKmXcYg2HylBk=;
        b=MnBxxJRAQPL6oIZiTGXyAdWyKdLyVKWxxj9Wd561J9lSCXVuB3GwEn2+w7+IhpcYCy
         S/2uG+DZYWSySAEW6FlGNEq9wziQ5kJEo1QnaSeyYZz+g8YKw/dYxOnkerQSslevkoNS
         5u0TJ/gc31UPdx+RNd+2rF1UR4VewxU7t/1sFsSt3CpG5IQw6jMMoNEtOI1ovWdBTeXM
         izPv3EnVgPlo3+5k3jyLn8ujGSnkX8tA1g3MiFS2bIh2oUuQHn0bDiYEkZ2IMH8uHQeg
         e2D/vB42JIstH6bK2HgBEv9l09gkcMpMlpb2cCcUdbDkClviyMOCm8PS1Sxq5MtbaEYc
         1Maw==
X-Forwarded-Encrypted: i=1; AKwUvBxnTeqc/v/qJZ53w5YYOPjGhwTT7rFaYCAkfDqGd5cMYT/VQdzrnRsyZhVRIvGQzeZdEwP5Hl8=@vger.kernel.org
X-Gm-Message-State: AFuF++n+0l/GSLvUNCEjLdPXRVL1qXYToyw6/TfWFhMLaEZxjOUrOoZg
	U+7dpgwgfZIyJL0nW7OqA1cdn20Zn8a1bpR8wltlksMUDn1hmenEnzYg
X-Gm-Gg: AYBFou2prWiaiHGciJ8ccSSOtQVVf1GZUe9vhKjcjFH1uY5nTPtndez7HxXoDcNoa8p
	UEiJWfBJ1vW2EsKc2I2dlXB0+bYqJBp0nvN3Y1HU5Wqn5wU4pO9t58RHvJVb2nuPk/zC4AaKBrM
	X2jGL7UX7iTNCJ0eFZZS0JSN5nC9PtJcgICzROQgFKA+M1Vb/vsc6drcpDvt1FiPsXnpL1q6zNE
	qXSRcCZ/1NFpjwNy2LIjliDo7XJYskpp8czMTXqRGMibceYYr6jfHfp+tjn9hHO+9EP1+X7Su0q
	E0YRndxqXZ1E3NfxfWO7ZoRakZASYqoD6HMRxg7XcERsBL1jxOY3kjrNP+GpR4Ei9OZEuVQryca
	U+vKSBziOzx0iuX40cKC78Oo6ypNyBcRFrKlipDb9LqpcOvKg0gqATt5/f2S+Me61cH8r+qIlL5
	sjI/L7qBfg+Ri+HshZpFUhwataFF/KEGQqfnec2sjDQAL95GIBcyVf64fmny+7fWosD61ZJsnu6
	b5EXCbmhu8=
X-Received: by 2002:a17:90b:4a0a:b0:3a0:7dea:6dcc with SMTP id 98e67ed59e1d1-3a09897055cmr1219917a91.29.1790228286099;
        Wed, 23 Sep 2026 22:38:06 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a09738f2absm2640292a91.14.2026.09.23.22.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 22:38:05 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net] net: pktgen: reject out-of-range node indices
Date: Thu, 24 Sep 2026 14:37:52 +0900
Message-ID: <20260924053752.1442623-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pktgen node command parses up to ten decimal digits into unsigned
long, then passes the value to node_possible(). That helper takes an int
and tests the node bitmap without a bounds check. A value beyond the
bitmap can read the next node-state mask and be accepted; larger values
can narrow to a negative index. On 32-bit, parsing can also wrap.

On v7.2, an initial-namespace UID 65534 task with no effective
capabilities reached pktgen_if_write() through user and network
namespaces. KASAN reported an eight-byte wild read. The read can cause
a crash; the proc result exposes a limited one-bit outcome. No broader
memory disclosure or privilege escalation has been demonstrated.

Parse this command into u64 and reject node >= MAX_NUMNODES before
converting to int. Preserve the existing OK/ERROR proc results. The
fixed v7.2 KASAN VM passed nine input controls without a KASAN report;
the W=1 pktgen object build was warning-free.

Introduced in v2.6.35, the unchecked call remains in v7.2.7 and
v6.12.111 as checked on 2026-09-24. The read needs
CONFIG_NET_PKTGEN and CONFIG_NUMA (MAX_NUMNODES > 1). The unprivileged
path also needs usable CONFIG_USER_NS and CONFIG_NET_NS. Tested
reproducer source is available privately to maintainers on request.

Fixes: e99b99b471c2 ("pktgen node allocation")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---

KASAN excerpt from the unmodified v7.2 VM:
[    1.739189] BUG: KASAN: wild-memory-access in pktgen_if_write+0x66f5/0x6990
[    1.739389] Read of size 8 at addr 1fffffff891bf658 by task pktgen_userns_p/144

 net/core/pktgen.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 7f81aed46672..9e172a101a1f 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -818,6 +818,25 @@ static ssize_t num_arg(const char __user *user_buffer, size_t maxlen,
 	return i;
 }
 
+/* The node command's ten-digit argument also fits in u64 on 32-bit. */
+static ssize_t num_arg_u64(const char __user *user_buffer, size_t maxlen,
+			   u64 *num)
+{
+	size_t i;
+
+	*num = 0;
+	for (i = 0; i < maxlen; i++) {
+		char c;
+
+		if (get_user(c, &user_buffer[i]))
+			return -EFAULT;
+		if (c < '0' || c > '9')
+			break;
+		*num = *num * 10 + c - '0';
+	}
+	return i;
+}
+
 static ssize_t strn_len(const char __user *user_buffer, size_t maxlen)
 {
 	size_t i;
@@ -1304,13 +1323,15 @@ static ssize_t pktgen_if_write(struct file *file,
 		return count;
 	}
 	if (!strcmp(name, "node")) {
+		u64 node;
+
 		max = min(10, count - i);
-		len = num_arg(&user_buffer[i], max, &value);
+		len = num_arg_u64(&user_buffer[i], max, &node);
 		if (len < 0)
 			return len;
 
-		if (node_possible(value)) {
-			pkt_dev->node = value;
+		if (node < MAX_NUMNODES && node_possible((int)node)) {
+			pkt_dev->node = (int)node;
 			sprintf(pg_result, "OK: node=%d", pkt_dev->node);
 			if (pkt_dev->page) {
 				put_page(pkt_dev->page);

base-commit: 90c2e97ff8245092039ab7ab7492b34427412c9b
-- 
2.55.0

