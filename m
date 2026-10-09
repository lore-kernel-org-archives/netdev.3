Received: from mail-yx2-f3.google.com (mail-yx2-f3.google.com [74.125.224.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ACA45C6FF
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553965; cv=none; b=c/+IAzaDvJi+RaqTK3FaIqREh38nySQccaozZVcMoVVR32T8iCbYXcZLBv4NXQUo+OJ4cR4e+1hDp/QdhqkEV9eQSlGNRgKdL6Ze2T3LXjCt4tJ1otFu3GorslQUUtRHllB30Vj6/L9tMtT+bPnu+o18QkkOSq6SolEo4Xpw9vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553965; c=relaxed/simple;
	bh=DXe+yl/758ldn4COJlrHngabU2zRVDG8V3eMr1W9CDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DSGpQL/WU5n2Hqu4VpD40lYdnZb5AAc0jrf6WAFcCnGbQ3a7XQ7q9UP8u+V1XEnMEpEnGdY7zYb1MwpQw5UYZcQ2O0WfjiS4sDKffEHMJ9B6PY7WM2KYjm8EbMt+TCCVtswFli2AkAjXfV2XKOLY7zJhW7ihr9VlMMgXhADdsG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sy15pmZC; arc=none smtp.client-ip=74.125.224.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sy15pmZC"
Received: by mail-yx2-f3.google.com with SMTP id 956f58d0204a3-677d9c68d21so850092d50.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 06:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791553963; x=1792158763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F7NrTWWsqXS9lZm+YxHOiLKgxHz++wuXFJ1PI/C24fY=;
        b=Sy15pmZCjqzmiCnxqRkCfiOOHXjVjJzO73p5KQbGVIfOiGLEJM6mrvCOTNj9hFkhbR
         0npvggm4tHe0Q34HTIRNtCaCILOuFJ+tIgy3GoJB1KuAnRu2pqJGzUUkoxkrDWyZWQ5w
         WNoVtGICI1H4d8yRKPbU03bAJs8Fqk3FhQyD6/s0QkYb72jN7tG+m4IdRDD2sSEmE4hc
         2U42HFRHH337Idlb1UpieqHUJF+tdKk1/bhUdUejYQHoGHB6l8y/xwm9/N8eHYeW/BSA
         6RIALxcFc8sJtCQYg8hRUXropcUYH61MjqNQcPY4EeOxc0K4uHlZTXPjjMaL+juye3RI
         9Sdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791553963; x=1792158763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F7NrTWWsqXS9lZm+YxHOiLKgxHz++wuXFJ1PI/C24fY=;
        b=ydKcZPGDgFTZWqt/PY/ddV2RrLRwpbyowBedmkjb+KggXSD7Wi4iE1hmXPSl5Bil3X
         PdoljpRluWRf4eS30aDzEU+QK9aFxcwqtUd/fgopJ+OWwSxovQRuyEn5MYzCw1oLzTeq
         CG+Q5QItyk7XS9VFknSAR/X37YpuwZ55zJIlgUACmfNQmQsR+TSUOXLWqbjRq00lvcg4
         bkLS0lZc/1T+Ln0H+38zRBQgX1E3uIKxsv0cSBpHogI1lVpJWYN93FOFVNl8/JRhPwZ4
         SKuPo/ZX7KBAR6iNcCJwOgXOASGKSSy1i63kFNf8Awcmi0tUsDv3J0AzSwzY913Lv/jh
         W8PQ==
X-Gm-Message-State: AFq9FYJ+BP7Gzp+apBHOF+mjrKH9+ctHK3/1570XagEp397/N7KyRvAS
	Tzl+hoqViwwCl95p7JDhsMWRRj17zi9kXmpi3fR05VUl6ja9HYdo0fzV
X-Gm-Gg: AYBFou36FTXIWHfsjQKVDj3rwomBGRAXgQV+HyhImkQ/8QbRfmSmXCKom1s1+DQATAs
	kgDGx/6Mr0x1mF+uLqsxSrSpyEh93RtJXZQ1/YkgPIRjdE029WTLxkyQSwkieB4OKsiaNt4F+Ii
	RJ2H+XGoIONLreebLFRfwu/Ln9r95ykLLUXY5kjZ2UaFpWlNpCngTGPchj7C1h5lcm8DdADJpgr
	nrPLzS2dZReAeMUKZKA+qi1hSRcC2Go9OgmWGn0m21q9KPucEdDyi6ZOQLDw1YMlUKtF4qwChkA
	071n5GmLwUTbq83pUgzWC0e7YwDxAT2SNxGQiiJCnvM9CQEfW8NvgqQOYVij6gbCkw5kz9FAPKR
	AiFJcMaw3boN9+rsDatGNqlUnKB6FJeRbw/7nN8Flc7gWLZCwqVOkMM7ar+INGLJ8ujPXv5L/GN
	gFJWnfXdbGTK07jmFw0Yhy1ENUaRU+cwLfZ5IMHI1RttxJod3lz0Ww6W7XtwOdGKmutlhCMqrCC
	/Skcovstyl/9ftCy0qjseKz8wQBgOfO+psnUg==
X-Received: by 2002:a05:690e:4594:10b0:678:3418:8cef with SMTP id 956f58d0204a3-6793629e1e6mr401658d50.100.1791553962890;
        Fri, 09 Oct 2026 06:52:42 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.40])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6794057ac87sm111053d50.1.2026.10.09.06.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 06:52:40 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH net] esp: fix out-of-bounds transport-header read after exthdr walk
Date: Fri,  9 Oct 2026 21:52:32 +0800
Message-ID: <20261009135233.4084239-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

esp6_input_done2() computes the transport header offset with
ipv6_skip_exthdr(), which walks the extension header chain using the
packet's self-reported header lengths without ever comparing the
running offset against skb->len, so it can return an offset past the
end of the packet.  esp6_input_done2() then reads the 2-byte source
port at skb->data + offset out of bounds.

esp4's esp_input_done2() has the same class of problem from a
different direction: ihl is taken from the decrypted inner packet and
is not re-validated after esp_remove_trailer() shrank the skb, so the
2-byte source port read at skb_network_header + ihl can land past the
new end of the packet.

Reject the packet with -EINVAL when there is no room for the port at
the computed offset.

This issue was discovered by Tencent CodeBuddy Security.

Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 net/ipv4/esp4.c | 12 ++++++++++++
 net/ipv6/esp6.c | 11 +++++++++++
 2 files changed, 23 insertions(+)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index e76db5817e78e..aaff5a2b659db 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -744,6 +744,18 @@ int esp_input_done2(struct sk_buff *skb, int err)
 		struct udphdr *uh = (void *)(skb_network_header(skb) + ihl);
 		__be16 source;

+		/*
+		 * ihl is taken from the decrypted inner packet and is not
+		 * re-validated after esp_remove_trailer() shrank the skb;
+		 * make sure the 2-byte source port we read below is within
+		 * the packet.
+		 */
+		if (skb_network_offset(skb) + ihl + sizeof(__be16) >
+		    skb->len) {
+			err = -EINVAL;
+			goto out;
+		}
+
 		switch (x->encap->encap_type) {
 		case TCP_ENCAP_ESPINTCP:
 			source = th->source;
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index b1c9b36f76dc4..89e8cdf5a26b2 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -782,6 +782,17 @@ int esp6_input_done2(struct sk_buff *skb, int err)
 			goto out;
 		}

+		/*
+		 * ipv6_skip_exthdr() can advance past the packet end when the
+		 * last extension header claims an oversized length; the
+		 * transport header below would then be read out of bounds.
+		 * Make sure there is room for the 2-byte source port we read.
+		 */
+		if (offset + sizeof(__be16) > skb->len) {
+			err = -EINVAL;
+			goto out;
+		}
+
 		uh = (void *)(skb->data + offset);
 		th = (void *)(skb->data + offset);
 		hdr_len += offset;
--
2.43.7
