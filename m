Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2485E4D6C4E
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 12:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548693; cv=none; b=iwSisxMTCO+wtPUWanQFftPal+o4BoeIuGKIcM7TOSA0CpbP6JK7rD1vPJhvACVuyn6XSMj0POq+VnmcwuVQNq/k7NNWGIxPRptSJNIMeNJyhIQRYVoPWcgJCpY40ao/uopXNXGPkeoj5iAVDMHDClZfy4y6AIrSg3k7ThgqfMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548693; c=relaxed/simple;
	bh=75pu/VqDz0I5UvTLjr/ZyRljXF69cAISXm2ZGIjzB6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EXnV988lpBh5VpL7o25xTTiq02+k+7jBipCFUXoiUVI3l6hJujbtmlFGQq3YRTSSx46lbNGfjcS19nDepaJ0/fBGCr3tcu8LftZxhmqqFU/cG+nVOG0R/1drTreZKWgNc/t03BgM+/cWePaRZJ2ulB1ESdq7AcEsTJEud6kI4hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=MhVtR5kY; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="MhVtR5kY"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d577so818612a91.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 05:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1791548680; x=1792153480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zExdM9noMaMug6ygrgHma4FvQk9d0LjUHaAr85Brhzs=;
        b=MhVtR5kYLx9DfWBR4GDyJH50JUG8RRMWF4XTAyAvLVtNl2e2jzm14PiWqjNimdDi6T
         R+AzyjwkiVmCEAzAi7I1IMAGm3DlhVh6MHkXWkCz2+WY2PxwPWr39r5YlbJkskFBLdE9
         81peaEmC4Eb9TcAXQES3CcWHveAyCycHWO90bF5Iz8h3+HU/EV+2It1z1lWY2W/PsiXo
         1kKqX0ebR6ChfN+0uCdXPNsMN7+xRFoxDh1lveAAuLX2VvDyrmMgx+SXhzw1heCzRxgu
         E9L6Y1ka+EwP60vVul9I+ugqWxrJnrIFgEmP2VCjtTS4S4o38XAML+iUDnZFt3yS0mM5
         rFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791548680; x=1792153480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zExdM9noMaMug6ygrgHma4FvQk9d0LjUHaAr85Brhzs=;
        b=WOaTycq7+tXt64RFMz7fHmw9RLSMWD9BGLc7NLHjR7gTydFRxMtLQKYGtCnOjy3L6X
         /D+fnhNca1guk1fvorpBlJTLNHGBymrWq8FZNSuJghqnrynIto+fBt5kxSKshWOUNrQh
         eogfcSSkVgclfySKevFAECqq6vnEyNH9AVrEty23rik/hZAL6hTcetqrDFNzV7sqLhSL
         R2AliACWVYhCOdS2D0SUdWVPUCmow+LMXsBAmxE8NjhXSzpytZcfSrEVLCnJX8ixkbZi
         jgEiCIrn4ZmcGQ7p4Ql4lLZJFymm5r/TCxzui5fu7wVxPJiASpgGAfdeMR71lAoyHk7y
         YVyA==
X-Forwarded-Encrypted: i=1; AKwUvBxoi0WlyN7EgTp8gG1cWeucMHhopNGWeJGU4JfhJD0O2TtDlinBX4GbljVx/ZHDb7rSQmJnZH4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIKWWhY4v6duj2L7a/4/TdP71rG+qPcf8wHyTbwHp3Qv5DcS5f/
	VH11EL2SkL5j7tQVX3wp8OAJxeNRQZbDNHl/nS0r0X4QnGBPRYTcrlSyxRKN0wRillM=
X-Gm-Gg: AYBFou2ekyCZ1ZxX1yJ5tPJ7DaoTH2oqCPDyyj55k7QLeJ9K3S02AypatkDVsyAJhHQ
	z2krXMLvHFt/vo6DRG6533/E/4c9mJShk1MPZbuMZW3ZWVIgbBfgrcYj3Gf50xUUEvw8/CgRBRI
	2xIWqrcClOQeh40fbphSqf4DwYF5IYGVgTcgoNznWoBpPx6opU9Sgy0bKaf62thnk/O0I2s+UOR
	33aaO2ZkdJ4+3TmtzLnweN3eh/eHML75fhTWPjXnT1rZk3Pe1MoCoON/vNNby//Ml2yXogqvNyE
	JVBNzq63ATKDzYvAAAbxT80uhts3m8KoirxtWXEtLGUZW/Ukp0lpZ9e0jO+HxCPueDGklFDDuzo
	fmyZG8oXV4L/UM8fh50tCTzJmkcVhm6tmO6xbr57m4UAaH3CuaHJpMcOIeN7pnHOdSm9T034wWn
	lka0W42r99pENQGKkd0vYoDDrsHjqW0k9p8jU9xEomveHtFZeTF35h6Z3MDqMTQoSaxFxqW/Tbf
	D9FMfu86Y5XX4Pka1AppjQf6Q227hRCr0hyo17H
X-Received: by 2002:a17:90b:1d4f:b0:3a8:211b:6c8c with SMTP id 98e67ed59e1d1-3ab3a955e15mr1746334a91.22.1791548680373;
        Fri, 09 Oct 2026 05:24:40 -0700 (PDT)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab55e41eefsm1660502a91.10.2026.10.09.05.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 05:24:38 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 05/13] amt: match the Membership Update tunnel by outer family
Date: Fri,  9 Oct 2026 12:24:18 +0000
Message-ID: <20261009122426.551178-6-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009122426.551178-1-omar@blockcast.net>
References: <20261009122426.551178-1-omar@blockcast.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

amt_update_handler() finds the gateway's tunnel by comparing
tunnel->addr.ip4 with ip_hdr(skb)->saddr, which on an IPv6 outer header
reads bytes 4-7 of the source address as an IPv4 address, so an IPv6
relay never accepts a Membership Update.

Take the outer source with amt_outer_saddr() on entry, by value, before
pskb_may_pull() and iptunnel_pull_header() can reallocate the header.
Match the tunnel with amt_addr_equal(), as amt_request_handler() does,
so the tunnel a Request created is the one its Updates find in both
families. The inner report parsing is unchanged.

Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 5e8a74c..b977b00 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -2620,14 +2620,14 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 {
 	struct amt_header_membership_update *amtmu;
 	struct amt_tunnel_list *tunnel;
+	union amt_addr saddr;
 	struct ethhdr *eth;
 	struct iphdr *iph;
 	int len, hdr_size;
 	u64 response_mac;
-	__be32 saddr;
 	__be32 nonce;
 
-	saddr = ip_hdr(skb)->saddr;
+	amt_outer_saddr(amt, skb, &saddr);
 
 	hdr_size = sizeof(*amtmu) + sizeof(struct udphdr);
 	if (!pskb_may_pull(skb, hdr_size))
@@ -2646,7 +2646,7 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 	skb_reset_network_header(skb);
 
 	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list) {
-		if (tunnel->addr.ip4 == saddr) {
+		if (amt_addr_equal(&tunnel->addr, &saddr)) {
 			if ((nonce == tunnel->nonce &&
 			     response_mac == tunnel->mac)) {
 				mod_delayed_work(amt_wq, &tunnel->gc_wq,
-- 
2.43.0

