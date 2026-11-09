Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187282;
	b=LIG8MPbloxZ4+a6SQoXxDgcaSrmZfA7v0ZVUoOAwNcY5wVqmymTJvsnSRi2fACycl/k8
	 PXOlKJZi1HJK0RCVvjjVGS1C2oOYRmkVpKDIQ+KeRwCjBxwNFq0ZfRCN3psRNxXRdxOzb
	 FJyYOTA61/MYUa1ILLopJCwsIISuw2giJ570Fsm5mV64PRoMZ4WLI7cH39xWqJzpOtlW6
	 RInrSJS0ZjONXsCeFigoS9npgi6Is76xbKzdFlbyrTofY5O8HRDPaKqIBIuyuFNT5Uu2p
	 GblzSCZbJSkMMm2gt25ubeS3eYwMZw9qM4TmG/QlyOwf/2WfySMo9C/mfnBBSt7z7lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JbaGCvN2cTvM37NE17BDipBUuFaHtKV8fH8i8HWWLkY=;
	b=JxeP84hLLfUdhUq2rEg+havM9jmqBqRg30A6Q7vH4HRGy8c1eqLcthzyg8zi5nkcJzew
	 7r4brSi4hT6jTKFINofExLElzrvkKP9DaapZRL6b9UF3IrfqHscH5DM5h94DUQfHW56kr
	 z1lwtXoD2kt/V9v8wuvi8QoIDQHRBssAgXoKrJh9gjcVRe1e74aQsIsSqHiT6H8NazvsS
	 wekbEYu4htJMaNkrM3bAlu3YXDI2wwhx3vHiU9UhO4yZIZ9isryN67TK32A9YkhawJaHu
	 uQ8JM+Z6Eqoyz41GvwrtFij18r2UdZRSkKCpnixrOdiC0miZ1zoeLcmh3NVNI+Q1xRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ZhUe0uCS;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65DF606D832
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 01:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E65DF606D832
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ZhUe0uCS
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b094e649d3so228650a91.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 17:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794187281; x=1794792081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JbaGCvN2cTvM37NE17BDipBUuFaHtKV8fH8i8HWWLkY=;
        b=ZhUe0uCSDNhuZ+9kVOhTRmUbH68NzwI72Us2qWegQ8cxGqa/QFhKcnVYWamSHE1bCG
         evu1nvplRDDAd0s+udWtXyPl1cp4klrvrOagVDIO+tWRb0Gty0xU2peaoG5mTjT8U4M6
         hbN+v2u6JrnoDyCCH5HEoOM7tKzLBc9pG3NyFkkhjmjd9Lis/TyD5Plx6SOyfdTicQ4O
         Uvz/q57pmSsUzh7FXmRF5tq3f/QFnfqXf+SF1SWBYHg43fr4g2XMna/UKEBGEMC1xwIO
         MaHlzRKZNvfIjtdenizWqwzr5WWycRvsjP1HG2F/F7Pfg2Zd4hdCd5HYlz9brCiLeuDv
         AY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794187281; x=1794792081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JbaGCvN2cTvM37NE17BDipBUuFaHtKV8fH8i8HWWLkY=;
        b=tyHeg0ZPS0KNFBK8X6fiJN+EZDpSfYWoJaQ3AoBmX5XH1ZaH+hCoklw9mohLsjFGvG
         yn6WR/hBrlBns2MS78avPBqj94972fJmp1gaPpkVTAxBnz3bcUHJcHdWHePfYVCckQB8
         VMX57EhWP9nDaCa+dqThclbYvFrvgEyJLt6NcSS7ON+Mo77vXV4K1imd2X/lB491Goxu
         sIC50pM/i3bzOUSJdF1wPHwZ+iZkY0gvWs5fdpvyrt/Zz9pKoV9cdiYTzk2kvCHRKujC
         NwunWIglWNZYZf6LWAwKK/BLW66cNKU8rL+s+UiLVyxGRV1A3bB/J5L8TCDj/uJ5IzJl
         yR3w==
X-Gm-Message-State: APuU4Z+0UcOGtfqte9yO4s+gN2XV0bSXiyUdze7Gb0h9aAlpXXHzLh0I
	H/24+TQJy/Srsw5ldXMsUIvkljKpvpuOYx/aUcEW0Qn38dHbAVdxwRd9jVOptFgIK8E5uC5eYQS
	Oaige
X-Gm-Gg: AYBFou0GO1hlWkZYQ1nJRRwOPyv1IfhF20sOd8jdhkvU8cZuWXf0HJc66Kd/Z63c2jv
	1wbSx6oeaC8qmp+7QduCQ+W/DYHgTBXSKkeCCTfeSC+vCV4YaFmgRnwHD8UtHjxFPtl2+G/9dpd
	XBJwd25cdmIO2zBGFuAvbB5Lp0/A+eYJXYSbtAQTt+hauq+ZeBfFuWJh9p2eMaXQOPFMMZ575vy
	aWHVqfthSU7rl0nighMMW6aNzUrbeeR48JScRgl5AUeOdOSBg5YlYoZWOC+MXNhRyWYvAxOUmMi
	NPCP/96EomSFdbMmNQHqKVcfC6gNeYplcUE+t15q8crH4/MNszzyqKxaDug/CMbgw24haV0h16x
	u6y5sMLfA8b3fj3L0qsvjDmvXZUlZ+hIkGKdfPYa0ITk3lqK6RDz8Mn86duxS4b+myUgZqwXUWW
	MGnzzTkwDCxlQDtcOQJdCDkXJwcGY3hcpuNdpq+nCpysA8bih3ikp2vp6dqi891P5fQh9vIhr8n
	M5BHEeRviS549y8Oae175l5dDTmU9wLepNm8u/Xm1vVLFwTiwxguKYwWiUqxvcPpC9cg9qpIIpM
	57OVue+9/ZU3xdsZTk9OLrt0QnxWh180Teile2I7BZ7HcOGDFjq/nkmussK9SkwhTdEwMRZ/3Ne
	hzQnImmz03GA0AOKF
X-Received: by 2002:a17:90b:2648:b0:3ad:b7d1:8631 with SMTP id 98e67ed59e1d1-3b12d3e7092mr2210079a91.17.1794187281287;
        Sun, 08 Nov 2026 17:21:21 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b103432e26sm4883217a91.3.2026.11.08.17.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 17:21:20 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] ipv6: return EMSGSIZE when first route in dump does not fit
Date: Sun,  8 Nov 2026 17:13:13 -0800
Message-ID: <20261109012115.11898-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109012115.11898-1-stephen@networkplumber.org>
References: <20261109012115.11898-1-stephen@networkplumber.org>
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

If a route does not fit in an empty dump skb, fib6_dump_node()
suspends the walker and inet6_dump_fib() returns 1. rtnl_dumpit()
then returns skb->len, which is 0, and the dump ends with NLMSG_DONE
and status 0, silently dropping the route and those after it.

This became reachable when multipath routes started being dumped as a
single message with an RTA_MULTIPATH attribute; a wide enough route no
longer fits.

Return -EMSGSIZE in this case, as IPv4 does. This depends on the
rtnl_dumpit() fix in the previous patch.

Fixes: beb1afac518d ("net: ipv6: Add support to dump multipath routes via RTA_MULTIPATH attribute")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/ipv6/ip6_fib.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index e1d49897d6ab..1025267992f0 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -755,6 +755,12 @@ static int inet6_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 
 unlock:
 	rcu_read_unlock();
+	/* The walker stopped before adding anything, so the next route
+	 * is too large for this skb. Report that instead of letting an
+	 * empty skb look like the end of the dump.
+	 */
+	if (err > 0 && !skb->len)
+		err = -EMSGSIZE;
 	if (err <= 0)
 		fib6_dump_end(cb);
 	return err;
-- 
2.53.0

