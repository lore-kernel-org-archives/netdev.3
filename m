Received: from mail-qv2-f32.google.com (mail-qv2-f32.google.com [74.125.230.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52A03812DB
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 18:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790447024; cv=none; b=RsWxo3bgrVkk/pKcM4e93+axUKOOLDgXpFcy7ELXDWkfvkgtQBTianSiPx6jgAhNagMysLTD/3uZZ2M57S5BcETVHJXJiTPAyJW1Qn0vgCce7nqKNyBWnrKf0f3Q94bV7kgyCPnq4buYK3K9VgST4oW1Mz91jRr35Os0qS2h1uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790447024; c=relaxed/simple;
	bh=zEw7me8P3uqKeLMBl0v4oUiu0tHnIlcW6TfpiGPVY5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldTTK4r68gNLOV9fLQZCqbUhZoiiZmBRJMI2Hx7G136WY43VjbbeGW6IKWx9rmSipufUFGrW0oIAuGNJSvvyIv3zaJKEyZsq2mip29lGJaw27Kwsb5P3tEqGH9UOI7ddfnEjf/eJ05E1oFVH74F3WbUAXMn4iDig3z0grQfbUUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=pBl4IICm; arc=none smtp.client-ip=74.125.230.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="pBl4IICm"
Received: by mail-qv2-f32.google.com with SMTP id 6a1803df08f44-90ce6d5271dso10547016d6.1
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 11:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790447022; x=1791051822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Nq+R4e0Gpg6AZgDlzqSYdzoZZv1eDetTkzkwCKLwXU=;
        b=pBl4IICmUfBoQeL8kWxZsbcKAakbXvkYWlxyLzJyo3SnTIW9TVE13lSw53k9ik66zF
         UjsFD3kcZ58y0Pvr/Po+WhMbTk+LvjlI0YtUCf9B+CdBpGY0pOyqZpHrQX+UpSSq4csV
         K7kDVlksi/Idxw3xsvLYClO+GuSUrIP+KPh9Xr3Jsl3+l1mMLRQUM2wBkwEmyxEjrE0s
         D/XdWUF5jsn9t/YTaWEg12CBEBgKW5naYOVvXB++9Que9cyQ7v9eQUKktblc+LmzPAv6
         ciWniv/gnl7UWh+CeHka0wdYqWNarR0Nkws7+V2/i/HXd+MB3E+utVP0szjbb6Ajm/+X
         bY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790447022; x=1791051822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Nq+R4e0Gpg6AZgDlzqSYdzoZZv1eDetTkzkwCKLwXU=;
        b=tBPEFWZIjoq429kkKWHMVJlz45P5XnRbvxZT0Z4GuitzlLN2YMBWxvWl2c3YnZFAMO
         wcjXfg4VAvRN0o91f6JNXUTXLjE/BQVPQevfV2O7ULXxRbyfC5MTBNIklGARe3zW5tE4
         A7Be7nNTAQy10MtgjWokUYFhAX77UGLB+b//Fob56Z1BfwsfATkHjW1IBurAt7SyIcbR
         JZ/oyY0OU07BnLOoHPDjmnKAMd8i4x9yTsnzzgHv7n4fqvIWRqPn2DjuAPY8Sakl1GCw
         dRMqvOhqOvZRjBKr2ybklLFCeuXX/TAPPRVvHoiCsAJ63LCs+7ZiYfhBY4wB6Y3TH7J8
         XqVA==
X-Gm-Message-State: AFuF++mMfO3XYA4T3b+oa+b3yD6f1HIceWSOt3ciIZKgLfQK4iphXQlw
	UDFTGWAMlZ9GyNaUrp+t/MpaEOqNH5lHLcUm2ttEC2C/lSFDdIRicFwfzNlhJ/GxkTLPayx0pTh
	yB7Ea+cEn
X-Gm-Gg: AYBFou2QWR04H1AyrltJpmU/hUUkHTkOHibBze/v7/y36sdR5Z3/xqSencii2Vez7Yv
	T/P2C5o4W3LTYmaiGW1DMccHA6K94C6XS+uz9yYeSyVBW+f3qoN/SF2uMYdHDYaU9MAjN4VBnFP
	e0gQCw0boPDsy9r7FJLr9IMSVDqt99o0N6LQcULceNQ8n9DjnoNoGYJMaTqh4MW0sFUXU1GkvZG
	asJjcG6zXdppu8dpBPWdx5JocW5E5Um4ZflELyzJvZH77sZTrDu1XP9s2VmRsHVvwHWsoBh+8FZ
	6ShSGiUSlf9ZC4LgOo5lVuOr3VUprz5Xfg957fmxTjOqrzPvaTRqqZi2G7/9n5Y6qbBWSy5kV4G
	ODN4cTGtudf5aW7nJ7Zqri72LDg+846+kfcM5GZ4Il1eO04io3LWePOfBaEUE0FCeEUu+1eZL/f
	kDdFF2PFBOq4Kypg7rMFpcMietkcSYIBExHLkVU6TLCrJ37lFExzIt/C/ZS+P1TLDNrQTGONKua
	60fV7o=
X-Received: by 2002:a05:6214:e89:b0:90c:a989:a68a with SMTP id 6a1803df08f44-9142f8bee20mr108894156d6.11.1790447021515;
        Sat, 26 Sep 2026 11:23:41 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([202.8.105.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91430ec87e3sm43970006d6.47.2026.09.26.11.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 11:23:40 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	lucien.xin@gmail.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jbrandeb@kernel.org,
	sln@onemain.com,
	fw@strlen.de,
	petalzu987@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net v1 2/2] i40e: validate TCP header before ATR access
Date: Sun, 27 Sep 2026 02:23:09 +0800
Message-ID: <79c2c81b7c61c61b242dbe1cc9b2db9860524a3f.1790082243.git.petalzu987@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790082243.git.petalzu987@gmail.com>
References: <cover.1790082243.git.petalzu987@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zixuan Chai <petalzu987@gmail.com>

i40e_atr() uses ipv6_find_hdr() to locate the TCP header. A successful
protocol match does not verify that the complete TCP header is present in
the skb, so dereferencing the result can access data beyond the packet.

Check that the complete TCP header is available before inspecting it.

Fixes: fd0a05ce74ef ("i40e: transmit, receive, and NAPI")
Cc: stable@vger.kernel.org
Reported-by: Florian Westphal <fw@strlen.de>
Closes: https://lore.kernel.org/netfilter-devel/aq1HaYS96SNn7HJY@strlen.de/
Assisted-by: LLM
Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index ef5e657816f0..cdac279b8aed 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2911,6 +2911,9 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 
 	if (l4_proto != IPPROTO_TCP)
 		return;
+	if (unlikely(skb_tail_pointer(skb) < hdr.network + hlen +
+			     sizeof(struct tcphdr)))
+		return;
 
 	th = (struct tcphdr *)(hdr.network + hlen);
 
-- 
2.34.1
