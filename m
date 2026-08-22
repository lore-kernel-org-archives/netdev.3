Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD6436C581
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 08:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787388123; cv=none; b=rdPMFhxJBcZUp7jRkMAcnMY18Alefrf3buiRu1HqusPKWjlUGgkgpz1TLvcKJv9vUUJp0kZQLUGiI9M6JkUHMHlI1cFbFwIRtjRSKxfHsCT/HKvXlgJT5heFs+hnsD/hbbUaxJNohCdssqmZu6lHe0004qRN9pRVTSMXaktmMWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787388123; c=relaxed/simple;
	bh=YvCl7mCafrFa6IYW+kxzEb7oRRDed1UnwjP9ZNZENbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LNcULO2RA5CSwof5Y6AuCZjPtE9v+nW8zNm+2d8MyCzF46LUlg0PLh4W62EbJjrJk7/a2hUwt1UySpB6PhG1WmILQSPEC34EU5FhD7kY+OJP/Ac0PKfiRBbKsywaII8t2AfeTsHIOMSq5iXyDDdUgo5rbyLhMnz2/kS+Z9tsG84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3900e39d935so1730771a91.0
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 01:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787388121; x=1787992921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2RpbmhhZF816q/d5gHoIu3SpTMn9zkZXAl2vB9OJYsw=;
        b=PHOIdq/F9GLoHNH5fpq22j+fM+tG9w+X9fhZs5eyjtJVAH9CLHfSaAr6pRN6Teifwk
         l2mYwetXM9KNIN+KayEr49Z70j9Te7uRSLjjLfyowMiBorAOWQzaBkzVEvaf7Njkpwp6
         aDrFgVeDR5YXApbCA0T9f9UpFfYOULM4r+WoskuJO/szfsQ8K77uYtPfQ9jC3Jd/cc4N
         pfpG31g0kWLM7jv35HpI9U2bVtQs3l1cKTpggUYDntY5wsiXfr39dgQa8DeaxpRrwpal
         7uY6KQrKGswia71R8VRyqGa3DOPl/xVcrW7hT4zhyfGsU/37DJ7jQanUfcT8T2GD53hB
         OQ0A==
X-Forwarded-Encrypted: i=1; AHgh+RriV04bRsIAvytajrCwkviozx12yyAbh8DR/Y+1QaumIft1JWWUj8Bam63jM3yF2t0ZW3B+51s=@vger.kernel.org
X-Gm-Message-State: AFuF++nuNtF4Y/CuYrSiaJiQyeCnlrRsuEnC6Z0TpKVORmJ9gogGUXy3
	Hddg6QX79Zc06QVeXAfflFf4cFzJ3DWixFiouvfNRXqYO+UuArf6rNSKfvU+HLsLQ0td
X-Gm-Gg: AR+sD109lLgu5z94A/vNeBWZchJO3Ic+kylDBf0oBUB+vmuCmEYjtA1aNiVmcC9fpzL
	roLEKOE9d/tExHLffYZRVgc2aF8OT7XatwpZVF3Qh9PKeK9xvX0jI3hb9JKo6sPNtpIMFrgLp4g
	+PdMla1iYe4lnj3BBYVGfgPYEWstYrQOGT4kooZFYe8D4tcAmhSXv+0o8zDnZ7UiMwe3P3029Vt
	h40oMZbwswlSByrmdz/m3JCUA1BaIRQHBk1deYau6DK8IbLtZpVHQfhKQmfTq3LDtBJVIlR2005
	YPOw5tVvECFxsGxML0DPpF/9r1ADBjbmRlfUN3bDVW3AdvNEEcARC+k43pLUujPm/8vpZd/yT+N
	FCSWW14nWS8nKXQ7rR1FGQsLAMjUuGvSlE9eVVpoWZfslbskIuRs8gdXJyaXRBilyjwVREx6+M4
	SQISbWrZ75ofSN04d5SGJyCYnXnTjwVTSlCbtd2Zx0wn+NPmCUPDwPjil0
X-Received: by 2002:a17:90b:4b89:b0:38e:67e1:15b with SMTP id 98e67ed59e1d1-395deeae6e3mr7664417a91.6.1787388121147;
        Sat, 22 Aug 2026 01:42:01 -0700 (PDT)
Received: from Roxy.localdomain ([2602:feda:30:ae86:2bd:64ff:feda:6b7b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f909adc8sm4843462eec.2.2026.08.22.01.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 01:42:00 -0700 (PDT)
From: Zhiling Zou zhilinz@nebusec.ai
To: pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net v3 1/1] ipv6: flowlabel: cap duplicate leases per socket
Date: Sat, 22 Aug 2026 16:41:42 +0800
Message-ID: <69d00f6ba09b1d1afd9281370cf7ae5e2ce806b6.1787387550.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787387550.git.zhilinz@nebusec.ai>
References: <cover.1787387550.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiling Zou <zhilinz@nebusec.ai>

ipv6_flowlabel_get() allocates an ipv6_fl_socklist entry for every
successful GET. The recheck path for a compatible existing flowlabel
links another lease without applying any lease admission check. Repeated
GET requests for one shareable label can therefore grow a socket's lease
list without bound.

Count the socket's existing leases during the lookup and reject a new
unprivileged lease once the count reaches FL_MAX_PER_SOCK. This matches
mem_check()'s per-socket accounting and also covers leases acquired from
distinct globally interned labels. The IPv6 sockopt lock serializes the
count with fl_link() and PUT, so no global ip6_fl_lock is needed.

Check CAP_NET_ADMIN only when the socket reaches the limit. This avoids a
capability audit on successful unprivileged GET requests below the cap,
while privileged callers remain unrestricted.

Do the admission check before updating linger and expires. A rejected GET
does not refresh the shared label, matching the existing socket-list
allocation failure path.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
changes in v3:
- Count the socket's full lease list instead of only matching leases.
- Defer the CAP_NET_ADMIN check until the lease count reaches the limit.
- v2 Link: https://lore.kernel.org/all/528bc30d301bcf32aca37cda1933b617d2d295f4.1786447968.git.zhilinz@nebusec.ai/

changes in v2:
- Count only leases of the flowlabel being reused.
- Fold the count into the existing socket-list lookup.
- Keep new-label admission under the existing mem_check() policy.
- Stop after the first matching lease for CAP_NET_ADMIN callers.
- Explain why a rejected GET does not refresh linger or expires.
- Correct the reuse-path explanation and trim the Fixes hash.
- v1 Link: https://lore.kernel.org/all/cf4fdc79ae4dc46bd4eb7eeb57e5de2091c13cd3.1785746178.git.zhilinz@nebusec.ai/

 net/ipv6/ip6_flowlabel.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index 1ab5ad0dcf24f..b864dfc87f779 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -617,6 +617,7 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
 	struct ipv6_fl_socklist *sfl, *sfl1 = NULL;
 	struct ip6_flowlabel *fl, *fl1 = NULL;
 	struct net *net = sock_net(sk);
+	int lease_count = 0;
 	int err;
 
 	if (freq->flr_flags & IPV6_FL_F_REFLECT) {
@@ -647,16 +648,20 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
 		err = -EEXIST;
 		rcu_read_lock();
 		for_each_sk_fl_rcu(sk, sfl) {
+			lease_count++;
 			if (sfl->fl->label == freq->flr_label) {
 				if (freq->flr_flags & IPV6_FL_F_EXCL) {
 					rcu_read_unlock();
 					goto done;
 				}
-				fl1 = sfl->fl;
-				if (!atomic_inc_not_zero(&fl1->users))
-					fl1 = NULL;
-				break;
+				if (!fl1) {
+					fl1 = sfl->fl;
+					if (!atomic_inc_not_zero(&fl1->users))
+						fl1 = NULL;
+				}
 			}
+			if (fl1 && lease_count >= FL_MAX_PER_SOCK)
+				break;
 		}
 		rcu_read_unlock();
 
@@ -679,6 +684,11 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
 			err = -ENOMEM;
 			if (!sfl1)
 				goto release;
+			/* sockopt_lock_sock() serializes the count and fl_link(). */
+			err = -ENOBUFS;
+			if (lease_count >= FL_MAX_PER_SOCK &&
+			    !capable(CAP_NET_ADMIN))
+				goto release;
 			if (fl->linger > fl1->linger)
 				fl1->linger = fl->linger;
 			if ((long)(fl->expires - fl1->expires) > 0)
-- 
2.43.0
