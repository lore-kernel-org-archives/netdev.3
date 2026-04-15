Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA723D412E
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 14:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776263310; cv=none; b=ZICb0H2QAi1nEqFTa8YshrzRWwWnD5J8l/Ncn7lRL8qMSNNkZ/RQRtQX/QLXv7vRaYaaCZ8MgZ27IleuTjovkb1j2hPlc2ZqznZXpI10xOF2OHwmFxzpaIzE4N4IYZoRNnDniC+RikP7/qz3n5YF4xArP0YlpolFIqi+/e6HvlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776263310; c=relaxed/simple;
	bh=KRFbZ8e8NoHIOWPL3KDgmYq2vaa/ItF3b70/29KtNxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T1JCx9d4XhDic+DSp0nfpxSzEaJC9qkhvsI0RHNUcTk8KU205RGERBvq2eUu5DYw/ngxmYK630HtIQez4pTOGSi1jfUnH6UgCd6XFN4si8ZVPxXFIDwknZNQkcNCK6D7rc/t1d9AHpCceYUsFo6TE/K3THEs6q0KXK71CbmSlpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=C+RPl/o0; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="C+RPl/o0"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b6b0500e06so12937641eec.1
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 07:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776263308; x=1776868108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YY5iV7l6gxlqPZikCEp9TEV+FDZFJ5bzFc737a8jc5c=;
        b=C+RPl/o0erbqo5fTXeQrZPMhBpbIQrZ648VYY0VIJfM39lIctcnz+jTV5NvIRSPF1I
         2g118F8zeFEf8hw8NOTvs98WZXnVkZJTG2uxlGqRBLUbiNcZVfQcyFIZ/s4gn4NQsPFk
         e9g4qSGpHcMSN3+MgynnRT/5DHSsmQmvgFdH1xT30U4GHP5neRHRx4joeNzNNb98m+ZM
         6MPMcbqXcnhwcPKowSyQJq7QS3lo/lbIgihv2JK7EvorzvSKylJcE0wWtAcNTuhzEsdj
         c5XNARERnT2xq+qf+j/FvE6SNkV5xwdstGMaSYxG/3QCt4nuTC3YQOrVPAgmCpm14Og5
         hAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776263308; x=1776868108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YY5iV7l6gxlqPZikCEp9TEV+FDZFJ5bzFc737a8jc5c=;
        b=i9fn5F/Kh0v6/+g7FKqbf59Rslfwi0ZrBBmK3BlZWc+GmNiF+Qmqney9wo1DGn3shh
         sQCDZ6jJEq2WJ8s4+SYMA55LtkcAOGuc9AtjmQwEJWO74syD3RvJKyhe39/uS2uF8LcP
         TfqTqMs2BmKphru6Fw8cjgeydm8q0Qm4Y1y2+ujerDk02vm9FRDyQagfpCHsF5dVLwmt
         0pG/h/8JIGA/Lt9s+8hiET7j/X7gE+YXFnqMpmkqgfTpqnt1LhFKKYUxpi67FMT9fTJl
         zLZGWqHMZIC7WJrCFB0ie6gCPcbO8P3zsRGRKoSlQFO5Ear6FuSRdhGPVZRqS1KBnFqD
         Livw==
X-Gm-Message-State: AOJu0YwEdRQDSFtCb5MaJvDcyCsISB+jvGteMo+AgaC2qOoVd6RvM1B6
	KoJcsJ8OEiQM4o5Iu9Gajf1y4zDgt6VAaW00NEhVk9HjvYSWPJJjn/bEU+6N632nhDYGhEwQBee
	qUu13
X-Gm-Gg: AeBDievOqoXoXIzAZt2oxqJ+pLehmggDk17Ki+p/YVhb9dJoAY3u5gJwuw3u5TRRdm4
	Q1iXm8AAV5cwc3+FwEDbD5akzU7bYL954geSAfHeL2SY1jHUe2iVnIYzz1DqBj8z59qXBWEeLMF
	QUCMznVXmFIpnPKSeBA0udTsyxG6/uFWR0n5c4rnHL5J2JMbtYD6IJWPuK2zEv9JFrZw9nf3r0v
	fAeTaAaBSJhSm0VONC7zgQ/rcpFZPfvKb5WhIXi4Tmwyf43m918UPJzq7y4C8rlqgvnVrfc3p53
	wGddGS0p3hw5Vz6dhh89gJdns5uDwJhrYQBVjNOijWafTNcmx0LcQJRLpCnp9GV/RCJuRkVjVS5
	VA5D9WZElpxFRoMqArdfk7ehZdQhBxnxETsm504JTgIO1KlDTfmYHSQH721dyD8Ihj6lJGsjkur
	jVyeFrobsMuz63AJRvcsGo/ZAsvLPFX3DfcsP5E/8+lD7AUtiVuZAK1w==
X-Received: by 2002:a05:7022:6982:b0:12a:7181:2f1a with SMTP id a92af1059eb24-12c34e6913amr12925966c88.5.1776263308186;
        Wed, 15 Apr 2026 07:28:28 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8eb84813sm2751347eec.18.2026.04.15.07.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 07:28:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Martin Ottens <martin.ottens@fau.de>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 2/5] net/sched: netem: fix queue limit check to include reordered packets
Date: Wed, 15 Apr 2026 07:27:05 -0700
Message-ID: <20260415142822.133241-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415142822.133241-1-stephen@networkplumber.org>
References: <20260415142822.133241-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The queue limit check in netem_enqueue() uses q->t_len which only
counts packets in the internal tfifo. Packets placed in sch->q by
the reorder path (__qdisc_enqueue_head) are not counted, allowing
the total queue occupancy to exceed sch->limit under reordering.

Include sch->q.qlen in the limit check.

Fixes: f8d4bc455047 ("net/sched: netem: account for backlog updates from child qdisc")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/sched/sch_netem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 8ee72cac1faf..d400a730eadd 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -524,7 +524,7 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 				1 << get_random_u32_below(8);
 	}
 
-	if (unlikely(q->t_len >= sch->limit)) {
+	if (unlikely(sch->q.qlen >= sch->limit)) {
 		/* re-link segs, so that qdisc_drop_all() frees them all */
 		skb->next = segs;
 		qdisc_drop_all(skb, sch, to_free);
-- 
2.53.0

