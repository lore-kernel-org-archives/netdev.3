Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793278733;
	b=CnEy2cDWj03AmDj0j45KcOijLl4K7VipnA/ka6i8IF0siSK3VgeU1DYbwTnxu1LizsMn
	 dl4MtCelIQOAU9g9jpPpdT8Wmpa0L54KYEhXkLCBt17RDM2nODb7VBvoY7Ro5uEKt5WsD
	 s+NUVahw2gzFBAWbmFGqFPnqQDaDmhlDkR0GZiOWYfYDtvGdCWldK+S7akXuhBtvp27T3
	 P8r8AcTqnaKl3B47cPMd1rvaujGhsQG+QPH0DLQ54Zv4eO2Tzxxs7rmBcqRoWwfL+yGJd
	 f8FHChQlL3ce0DFO26Xldw6dhlz308xYp5532mwyy+BsxbLj3Uj2zZlcDyeDY4m2Blg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278733;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=tQgQ+G0h0FFJlo7h0nDEWPps1fXYqGMjaMK2CkDcgXQ=;
	b=tg/wPhLPiDQkWb2CeEI1HxNSS0V/ncD6Std1qf6RAV9/jrg50AG470iJGrjt1CxXuxXp
	 381gpz5hW5X0jowkBARCq3+0BZW5CDyBjcguW0Ao6Ul2tLJe5QrAyguv7d/K0z/d0hhrd
	 r5ZsrGvBL/R6hzdMkxKgHlcnazd8oYfJpLlOYBgo5ofJbYY/8DSFCXA8TaRnRxrzWw4pi
	 U/NwjwGtQd4j6WCD7AT+Ci2NSv8GRBtJOwih6DHC979kaDZ+0UIfuZCvS62+utzsgykaA
	 VSD0zjISsOY605nWp8llMDJGExgeObXpEbPAnmWvASfevvZKzooHwhZGkGkbAlW9Pcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="dxS1O/DH";
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A662606A31D
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 12:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A662606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=dxS1O/DH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=tQ
	gQ+G0h0FFJlo7h0nDEWPps1fXYqGMjaMK2CkDcgXQ=; b=dxS1O/DHY0AhcQ7Kgz
	ZdFlmgoMwyIXn5XuHn6nGaSYwoRmI+jstHNOBl03+/DdfjxhcHPwUI36HV+F1qiT
	GtNYAZXHLO52IdzU9kFleQiaqreQ66UFzINtGv1DB1TL9NddwEFZwI8vr2i4YEiD
	yWNl/4EhkFB/7lMQy/QMK62gw=
Received: from shaos.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgAnynXSQuNqnN38CQ--.14706S2;
	Thu, 29 Oct 2026 20:57:55 +0800 (CST)
From: shaos <shawnq1@163.com>
To: jhs@mojatatu.com
Cc: Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH net] net/sched: act_csum: guard skb pull length overflow
Date: Thu, 29 Oct 2026 12:57:54 +0000
Message-Id: <20261029125754.3835541-1-shawnq1@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAM0EoMnP3VkEV6fOAMdZ9ma9egUpV4AFfB+44k4VD7jx2dHPNA@mail.gmail.com>
References: <CAM0EoMnP3VkEV6fOAMdZ9ma9egUpV4AFfB+44k4VD7jx2dHPNA@mail.gmail.com>
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
X-CM-TRANSID:PCgvCgAnynXSQuNqnN38CQ--.14706S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw1kZw1DuFWxGrW8Zw1rtFb_yoW8uF18pF
	ZIgw4j9rWkGr12qrs7tw4kJw1rGwsxGa43WFn7Wr4UCF98Ww1FgrW0gwsFgay0kr4rCa4S
	vFs0vrWxJF4UZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j4uWdUUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbC8RVZZ2rjQtVHbgAA3t

Hi Jamal,

Thanks for offering to reproduce this. I have a fix below.

The length passed to pskb_may_pull() is computed from ipl and the
network header offset. With an IPv6 jumbogram, that unsigned addition
can wrap, allowing the helper to accept a short skb before the
checksum path uses the original length.

The patch computes the pull length in s64 and checks it against
skb->len before calling pskb_may_pull().

I tested this on c339f4010dea8 with the posted reproducer. The
unpatched kernel matched the root-seeded checksum in 45/512 trials.
With the patch, the malformed packet was dropped (tc action stats:
dropped 1). A normal IPv6 UDP-Lite packet still had its checksum
updated.

net/sched: act_csum: guard skb pull length overflow

An IPv6 Jumbo Payload option can provide a length close to UINT_MAX.
Adding the network-header offset before the pskb_may_pull() check can
wrap the requested length to zero or another short value. The checksum
code then uses the original length and may read beyond skb->len.

Calculate the pull length in s64, reject negative values and values
past skb->len, then narrow the value for pskb_may_pull().

Fixes: eb4d40654505 ("net/sched: add ACT_CSUM action to update packets checksums")
Link: https://lkml.iu.edu/hypermail/linux/kernel/2610.2/16452.html
Link: https://lists.openwall.net/netdev/2026/08/24/344
Signed-off-by: shaos <shawnq1@163.com>
---
 net/sched/act_csum.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sched/act_csum.c b/net/sched/act_csum.c
index 5fff52a8ca90d..196b940cd6230 100644
--- a/net/sched/act_csum.c
+++ b/net/sched/act_csum.c
@@ -137,8 +137,10 @@ static void *tcf_csum_skb_nextlayer(struct sk_buff *skb,
 {
 	int ntkoff = skb_network_offset(skb);
 	int hl = ihl + jhl;
+	s64 pull_len = (s64)ipl + ntkoff;
 
-	if (!pskb_may_pull(skb, ipl + ntkoff) || (ipl < hl) ||
+	if (ipl < hl || pull_len < 0 || pull_len > (s64)skb->len ||
+	    !pskb_may_pull(skb, (unsigned int)pull_len) ||
 	    skb_try_make_writable(skb, hl + ntkoff))
 		return NULL;
 	else
-- 
2.34.1

