Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA9831DDBF
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 05:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791178325; cv=none; b=AMHw/SGec2WDcOZ4iEOfHhzX8i0fk2/QkA4Ho1ekInl/BuL+mc1wHffSQQmo0yadOLb1QVMrBTklaSzvdhEPgTUkWm19J4srs7N9/IrRuFp7EQ5oqa/lcXC0Jf47AOFsF3/A/iTjXubIVX1qE8Khx/0m7AUW0ibzDz7/659xIAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791178325; c=relaxed/simple;
	bh=or6kptWS8ieCk37SYcCOsoau2hAvubR3NnSxD2KCWOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fJkdkiHXfSBNyXRkS8mOv8IUFLa9OD3BDsOGzwPEn5QRUZ7BtKajSSkeLp3nsmcoNhqJzg9dpu/IkieH5j958Z14/NFILKuIhIHLUqPNT3Xyuf/o3CcuI/8FJcq2TebOCfma2oMU9iBrb/E23cmerqPMHzcext7Rk54rzodSGqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPtukUyE; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPtukUyE"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a6f8525bfbso731724a91.0
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 22:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791178321; x=1791783121; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YDUpOextJDj0XgDM94YvS93fc0ORlq6SlP5AmYi24pQ=;
        b=QPtukUyErpttvbHPvIUAIdqLJK4PBUWsj2ceizhoPlMgXwndya3ttxCGkTRfGJBvQ/
         aisZ0ow9iuUQ7wcsfCzMnnlgYSwyie5DDm7KYY8a943MJIbt25oAmTtl+9FeUJ10FAgp
         aJaFwQHgyWm6+Gj8t40CMqh6ovukBaDihI/cioah9/jM5zR+3J2oRhKZL0Vx1l6iV+bG
         uKTVOBSONuFbGrQvTvQlHFTeu1y4m2OixVAbALisN2Fwd3AAqcM6u1ckiTvslhAxGhl6
         nZnMker/LNgHcndBCyc2af0nYvW6f+7jYIOeSymjbn4Bz1Ghr8iNU9STXmGbEjto7gnk
         v1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791178321; x=1791783121;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YDUpOextJDj0XgDM94YvS93fc0ORlq6SlP5AmYi24pQ=;
        b=bvfo/R3H5+HsV0YM+uhhoQFl8inToBiXDBKR0H9AEGSQBCRWEMTS/fvZIlY40uNGTv
         UWgEGRTBp1kBMjKTQwmiuqFnXsPbGVSSfIfPm6pVAXpoCEz7JM9PW20dNY+tV6OqLtWq
         yieBLuweK9pPy2Pk0uq7U14wiUNCrUrGENbrZz6iSI0WrryNrBtAjaZ8bXQYYXwkjJpX
         g/x+C4Ft73CG6RyNyFI4ymeu7Ajh5qPaoTnAZpS9S9ouqoviSc04MM24Ce+90FdCPgNL
         x+5MJvxfvnmGUM6bg3eYhvXhO2LN3LEFIktZMCpc6/Pk4ZtEaSPCFkH4q01SeT8OwCBc
         RPHA==
X-Gm-Message-State: AFq9FYKf7gmkCRQ4TZ9s9jVqxTvMX6qWrTLeH7Rirhe4MrOrwcFjZSno
	GIsvb359JpwQA9E8n1zfkQ2JtfHsx2kJm8QY8vSchKk/Gaa72fQE6z43
X-Gm-Gg: AYBFou1gfSWZ2b5njgs18gejldgirLGB1qVbGBVY+dphmrAvvgzu2MDJjd5rVRh0rDj
	1efh537XJebXrp7T7UqxwtovKcAvXwr2TiEO4hOkwhFTbJRrzhQeVZLXNhTuqK+J+VWrzsQE/In
	szKyAYX10eucnU+s0oTJ0mBWzLZEsyKKRY2oImd6gey/jJuQZKdyPZROUAOEsD9xS5qAzukj/iZ
	qzIMqzbxKLtFSbUva6nop2Ep07a0nxYnIEg+gr8cLDSzVZ/SvURrT4wth7iZPar2aZ87XnKZJHo
	Whz75KLPCJHUflAfCdiDi5pieYLVITWhe6U9laoiePrHxE5ySAU0AStWuhjYLcKz2OJtvIDZD4Z
	Ybp5gUhN02MAQ4jQUyADqswrio1r30TezV0uscfhZFrd4nTc5cvZgyiWLCb61q7LwfLLdXm3Loe
	U179n5RSOfqZDCFNH1TQuBkTws8ntcZnkom6y11/tAw8GJLDQ0gxiSLZiyeHhDdV+XY4BQ8tFLk
	k/h77kq
X-Received: by 2002:a17:90b:4f4a:b0:3a4:ffa0:23f3 with SMTP id 98e67ed59e1d1-3a6cec2c05fmr4109837a91.31.1791178320738;
        Sun, 04 Oct 2026 22:32:00 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78d59f1cdsm9419306a91.0.2026.10.04.22.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 22:32:00 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Mon, 05 Oct 2026 14:31:54 +0900
Subject: [PATCH net-next 2/2] seg6: skip the route refcount in seg6local
 IPv4 lookups
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-seg6-lookup-noref-v1-2-092e84774e80@gmail.com>
References: <20261005-seg6-lookup-noref-v1-0-092e84774e80@gmail.com>
In-Reply-To: <20261005-seg6-lookup-noref-v1-0-092e84774e80@gmail.com>
To: Andrea Mayer <andrea.mayer@uniroma2.it>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2363;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=or6kptWS8ieCk37SYcCOsoau2hAvubR3NnSxD2KCWOQ=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBqwzZKwJhiDQGDZL+jjnpixKpu1xGjKXBLYSLC1
 cneziBwb4SJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCasM2SgAKCRAq19F1Kl0b
 TVXsEACoPWjxtfqpUJcSCkqXCdEddQlDdK0Ip7INzPD+B3Xd6UWluRYdu4albT+HSaHm4DlGOk9
 7so0vBUT/KgQGOnqkpj6kUmZW3YCEYJ6DmurDzqPlVMzXWXnHeLLzbolfVhvABY3034lc7gMPzh
 +P7mYALiNIGuxoQIX1mJcaKUADcMqsXP1KrKxJlN/LQO+3BEvLowW87HcGFBrKqNZoOYALQBJvk
 93/JuDArIAZvqWB0SqIi64SsdvXkgQ+mkpeDwc63Kq3/3PI42Z7yzqTvxDUX7sekrnAVpjghCcG
 pOvMeu/msHXmh4yAgsKdi5XSxWaLP3BSk49gq6vM2JV9t8Dyh/6JXJfC47g8Zn72/NWaiTsjp0V
 6xW8aDqURTsow36GVcS+5pLcRosgG2NgIAzSUvhcNrugcR4lQbvlf8T3ec/jY9BWVLi+hUMgZeZ
 x2Ux112UPh6XmSucRopHPl+185ls4HZ5Rg7V9b9VT5iLvcpyfcIZMAiIff1/3VykWQV46riLkBk
 dAA50JTCBzDNnNhQ3HTiMiqWaVnavZjCRKeU0e0yhbftbocGnQi2ty4r9T0915o7YVOl2tGZOly
 NFe6gMwg3q8ihTqststosIqF+MRO9xlI6kv3021yTTNoF4vtGo6+sl9EAGIM9n98kdoMc6LeRgY
 qkybudEC1LiIfCg==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D

ip_route_input() looks the input route up with ip_route_input_noref()
and then forces a reference on it, which is dropped again when the
packet is transmitted.  End.DX4 and End.DT4 call it from the RCU
read-side section of the receive path, either directly from the
seg6local input handler or from a netfilter okfn, and hand the skb to
dst_input() before leaving that section.

Use ip_route_input_noref(), as ip_rcv_finish() does.

Throughput at 0.5% packet loss of 82-byte IPv4-in-IPv6 UDP packets
(no SRH), spread by RSS on an ixgbe 82599ES across two 10-core Xeon
E5-2650 v3, offered by TRex over 10 runs of 10 s, in Mpps:

  End.DX4
  queues  cores                   before   after
  1       1                        0.816   0.837  (+2.6%)
  10      10 on the NIC's socket   6.534   7.621  (+16.6%)
  16      10 + 6 on two sockets    3.369  10.208  (+203.0%)

  End.DT4
  queues  cores                   before   after
  1       1                        0.497   0.501  (+0.8%)
  10      10 on the NIC's socket   4.410   4.679  (+6.1%)
  16      10 + 6 on two sockets    3.259   7.431  (+128.0%)

Every CPU takes and drops a reference on the same input route, the
one cached on the nexthop.  At 16 queues that cache line bounces
between the sockets, and skb_dst_force() and dst_release() together
take about 60% of the cycles for End.DX4 and over 40% for End.DT4.

Assisted-by: LLM
Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
 net/ipv6/seg6_local.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 4bde3669d0dd..1dfe20b365b7 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -1079,7 +1079,7 @@ static int input_action_end_dx4_finish(struct net *net, struct sock *sk,
 
 	skb_dst_drop(skb);
 
-	reason = ip_route_input(skb, nhaddr, iph->saddr, 0, skb->dev);
+	reason = ip_route_input_noref(skb, nhaddr, iph->saddr, 0, skb->dev);
 	if (reason) {
 		kfree_skb_reason(skb, reason);
 		return -EINVAL;
@@ -1305,7 +1305,7 @@ static int input_action_end_dt4(struct sk_buff *skb,
 
 	iph = ip_hdr(skb);
 
-	reason = ip_route_input(skb, iph->daddr, iph->saddr, 0, skb->dev);
+	reason = ip_route_input_noref(skb, iph->daddr, iph->saddr, 0, skb->dev);
 	if (unlikely(reason))
 		goto drop;
 

-- 
2.50.1

