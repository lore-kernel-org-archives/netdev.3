Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20CC39020C
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 16:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551779; cv=none; b=C6YbKO8rwlWGZgRSyTIGVKvgPckBgZw4stLoAMryrEE1nRrDj19SXC5JGztGBL221VRva8oYTEDa7Pww2+tZI8PqsWnSTJODoFGwfiw8Kafhxd5GXiM9CTTB8wCOs6WXJWCKPjFEK+1k5WRHExmia72OOiQTNsyYBKGA5pagp5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551779; c=relaxed/simple;
	bh=KmEkukV0KACxCgadHIKEyyq9tbd/y3+LudT6YHNmwy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzONowGuwyN1C3xdCBIAmEH+NKOsuqUVPeB3o1UfK7JzGQEm+WoloDlUaNdVIBDIjfNpDxo8SJl17Xx4ERQHIRbl082snaJlNjknAx1PBfjpshCL9k6utenMnokqjPAaIZkZbmuISs6UoM54BQSHo4cKffiwo/enCKqqmsVmlUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=BGYdUdwS; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="BGYdUdwS"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso1975649a91.1
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 09:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786551777; x=1787156577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8kg9mC59jD4uDou6vIGripc9007zddgtHMt5e3/3xao=;
        b=BGYdUdwS7z4wonNKLweVLn1slUxSxNPe3EKB2VinSlgGuaSnFrR5mUgMH4MGVkPbyz
         huWquTOeJ75Zpexw2+GHqkwXUUXvIbd0CW1wqldW9cdzuO5JxapP9JQzexDmM9RBUhsw
         MWewWuhTth2DGPWM8DMs3/uLLICNkkPTfkDVpI9fM0gdiOPex4xCj5WrNPA1ctg8jGkH
         s/7AoYUXT3MRUPE083Q0a3dA3PwY8AGgaEXEVQEf/UAL4QDxRGY5z0xdRD87urUL+kEB
         lAHFw1A74EUFCcsf5uK4nks9w2b3Wo89x03tG33M/ffpZh7zmZwpZdlRSKzAsOzBgVvD
         6QyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786551777; x=1787156577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8kg9mC59jD4uDou6vIGripc9007zddgtHMt5e3/3xao=;
        b=FRUww5uZcUJTI9LoCEdbu+VFlHczeY0/uLhroEE7mOPSBytWieq5lyVY9i8SZkene5
         K/WUWj3JMvpHmsY+ufxx1wuwPGQuazGI1lCjHTuH/fg4CEm7Kf/cQK9MPIIhjLFf0I82
         5WLlCqxF6Af0Kf6R/xGvxdV+Kwzy13OKnrrRkDXa/pP1kISDnE96irrppeX6zN+a4i4Z
         pL1WlCaKmLhObqerqaEdT0j4oovwJARM2WwtrumFL0Td0q6B4JsSqB0jqRBkV297fJjy
         B/tp7oCmIzZnNEniJUGH+PvzjTZIKUFAQaz++oIJbKnrH9+O8T30CkjJNXGBwWizKRA5
         jw+g==
X-Forwarded-Encrypted: i=1; AHgh+RoNdvu4MVY40yrYxiGWklRz3z3qhNbZBdcGCw1W0SiK9TM46e4NoZSbCJqVeCggvV2acYzmj1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YztTob93+TpBHOweyxq1RdF2FqWuT45HNiz2v440/IX5vtnaskw
	XmjHnGJvj3YvqJE32hWGmhFpY2Duv8U7IHKSYrhxd6w26DMmPZVoFFxhhTAtlpOXJYov
X-Gm-Gg: AR+sD13/hRAwTUaZvANGO5DPU4l8hlTI955L+UQkhaWEMB8uwojvVi+uXwgN4DOfOL3
	YTLqBSBE8+tNE6zAyeBKyzIDF0GazrP9KFtI8y7Xee2DqJ+EXd4PMxD/DTTEO3RaqJl/thfNzQd
	njvuewCWf1tVUhAQO9ssbfSnE5615MZZF+K2MxmNd8YopzoYc3XxnJC8rms2xTZE/4yZQ6rG4HG
	wtnXo5e1Vu5FDdeVcZYOSwqQTmC+UF43UnZSM71JfIa0KrUNHT8OchjtKUI+p7qYentQSGt3FYJ
	QgvMPMqNXN2NHXBOt+19iYe2ZFwRawxDUnKw52j9R1szpzEXqTGhx4234A5A31+hOOsdKvP92+V
	uDVSH+/zDCaE1lZjbZmBaylN3S2W7qHy+HdyrVm9Sa0MaNUI9MW2VLb6R6o68YpDINSPaEoFOVJ
	23bexzzE5X7Uy0uBCcOP3gQIvE+l86JL3xNxZKgj6somg2SSYkcWAlDlLea69M2Z9Cpan7whkht
	kTJkB4CCbWzXCM=
X-Received: by 2002:a17:90b:1b43:b0:38d:ef48:b04 with SMTP id 98e67ed59e1d1-393013e58e1mr6693835a91.10.1786551777178;
        Wed, 12 Aug 2026 09:22:57 -0700 (PDT)
Received: from Roxy.localdomain ([203.175.14.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392fe44ebecsm1466974a91.2.2026.08.12.09.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 09:22:56 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: idosch@nvidia.com,
	netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	atenart@kernel.org,
	yuehaibing@huawei.com,
	kuniyu@google.com,
	kees@kernel.org,
	kylebot@openai.com,
	thorsten.blum@linux.dev,
	maoyixie.tju@gmail.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net v4 1/2] ip6_gre: fix hardware header length for NBMA tunnels
Date: Thu, 13 Aug 2026 00:22:34 +0800
Message-ID: <64b46542bbe1701f07702aaa50273e2a87903db5.1786542637.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1786542637.git.zhilinz@nebusec.ai>
References: <cover.1786542637.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip6gre_tnl_link_config_route() accumulates the lower device's hardware
header length into dev->hard_header_len whenever header_ops is set. This
is incorrect for both users of header_ops.

ip6gretap and ip6erspan have a fixed Ethernet hardware header length.
For an NBMA ip6gre tunnel, ip6gre_header() creates only the GRE header,
the optional FOU or GUE header, and the outer IPv6 header. The lower
device header is headroom needed later, not part of the tunnel device's
hardware header.

Keep the lower device header in needed_headroom. Set hard_header_len to
the tunnel header length only for ARPHRD_IP6GRE devices with header_ops,
and leave the fixed Ethernet header length unchanged for tap and erspan
devices.

Fixes: 832ba596494b ("net: ip6_gre: set dev->hard_header_len when using header_ops")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
 net/ipv6/ip6_gre.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index b843116e9b703..70c1710910203 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1137,13 +1137,8 @@ static void ip6gre_tnl_link_config_route(struct ip6_tnl *t, int set_mtu,
 			return;
 
 		if (rt->dst.dev) {
-			unsigned short dst_len = rt->dst.dev->hard_header_len +
-						 t_hlen;
-
-			if (t->dev->header_ops)
-				dev->hard_header_len = dst_len;
-			else
-				dev->needed_headroom = dst_len;
+			dev->needed_headroom = rt->dst.dev->hard_header_len +
+					       t_hlen;
 
 			if (set_mtu) {
 				int mtu = rt->dst.dev->mtu - t_hlen;
@@ -1171,8 +1166,8 @@ static int ip6gre_calc_hlen(struct ip6_tnl *tunnel)
 
 	t_hlen = tunnel->hlen + sizeof(struct ipv6hdr);
 
-	if (tunnel->dev->header_ops)
-		tunnel->dev->hard_header_len = LL_MAX_HEADER + t_hlen;
+	if (tunnel->dev->header_ops && tunnel->dev->type == ARPHRD_IP6GRE)
+		tunnel->dev->hard_header_len = t_hlen;
 	else
 		tunnel->dev->needed_headroom = LL_MAX_HEADER + t_hlen;
 
-- 
2.43.0

