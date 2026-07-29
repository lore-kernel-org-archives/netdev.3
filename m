Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AF930C158
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 19:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352514; cv=none; b=hvdJ/Fc4tWnX3Gxac4dXY1zhygCpxTRUJLe8GnqvluVVO8Ojp94mkxKJyDDCyH4E45TcuYSEQn6JMrmhLJq0sly9ZKREVf8qVlpGoUkHTMdWsmEkLE3IofeDA2mpHQs8Y0OEFnugQU0/Fh+KT2F5J/QuWhWdNKldHHR1l3BbiL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352514; c=relaxed/simple;
	bh=+PiGRgFdIvaZyo5iGFaGyF/dQaJ6ZD9yl9XrzuWEFe0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VQZBQkiUeS0LerNnoqqmXm+q3vbYioOn03MO/YGX8CLHkR5YmUXGoJ6V7P3kSJkuslUxTL5u8GNf2MbuupwdoWZRM8uu4wjWQ1eOH/CNJrWExxhfRnF4FOSH7rdsbCfJQwgAYPhs9+1s/o37CEtkyzNF4cEMHGSaXNZn/KrGdZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>
Cc: Zhiling Zou <zhilinz@nebusec.ai>,
	Ren Wei <enjou1224z@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	cake@lists.bufferbloat.net,
	netdev@vger.kernel.org
Subject: [PATCH net] net/sched: sch_cake: drop WARN_ON(1) for malformed packets in ACK filter
Date: Wed, 29 Jul 2026 21:14:16 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <20260729191417.45665-1-toke@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The sch_cake ACK filter parses packets to find the TCP header and filter
duplicated ACKs if the flow is backlogged. The parsing code contains a
WARN_ON(1) which can be triggered by a malformed IP header in certain
cases. Depending on the system configuration, this leads either to
either spamming dmesg with warnings, or a panic if panic_on_warn is set.

The code already correctly skips the offending packet in the branch that
triggers the warning, so the WARN_ON itself doesn't really serve any
purpose. So just drop it altogether to avoid the inconvenient side
effects.

Fixes: 8b7138814f29 ("sch_cake: Add optional ACK filter")
Reported-by: Zhiling Zou <zhilinz@nebusec.ai>
Reported-by: Ren Wei <enjou1224z@gmail.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@toke.dk>
---
 net/sched/sch_cake.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index f64be54ead49..f25f60978631 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1287,7 +1287,6 @@ static struct sk_buff *cake_ack_filter(struct cake_sched_data *q,
 
 			seglen = ipv6_payload_len(skb, ipv6h_check);
 		} else {
-			WARN_ON(1);  /* shouldn't happen */
 			continue;
 		}
 
-- 
2.55.0

