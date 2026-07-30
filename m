Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7D93E5A29
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 08:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785401714; cv=none; b=gZ2N4P47JmCKf7DsPd3Fp7v/kf8Fq5oGkzVIjxMnTWiJdeRQpk/wucFvTkY3CKLM3AGb4+V6dZPEnCYC5fKbYLnEriZv2cpvTIDbc9aakb+sNM41D7b/pfzUKYG0QWByYwV3Cg77y5dveYMUrTKVc2bFUMJ1AWMKcRfBRF1r0Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785401714; c=relaxed/simple;
	bh=/hJ5olAvAx0uV1rwuovUPTJ1SnI6Aj4YLn57VuK1kto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D+pi/8FaafpjlgbW0jgGa3TagD4pE5j//ZDVWOJATaPHan6uvHNy4qG5qQYBZYJ7SCNOb3laCdkVbM/XU2EH3u/L5kujqz29drPxotqcpyXnsKUsJd7zT/Zpo2Y3MVDi1N1cnXA0pLmmGEjhDeCwlfPzEPCF9MLJAyEPW8xXXpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=bhp76XHV; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="bhp76XHV"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38f620399a0so1570934a91.2
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 01:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1785401701; x=1786006501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UNk4YOk3eZRjmLcRDAdV40PWt98EGHOTM+Fzmg8W+V4=;
        b=bhp76XHV0PhFUYSdVjXQIcIN8wadf3n+fda20auxrL46krfIhU444n6Lo/kE17ClmW
         tij3/J75pfXhU+g+3iYJpavwsFmKhWjgOo3cZHKpxOB+Rike7YOMYQk+3oLQ/tcreeyB
         LQew+ZGVeY7xCM9CoVOLWMnrOCAWfvZyYBdCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785401701; x=1786006501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UNk4YOk3eZRjmLcRDAdV40PWt98EGHOTM+Fzmg8W+V4=;
        b=a8F5zcN1D9Pi7UlA/RebXy1gP0QpqwU60Jc7RrKzwvIENRfcZNHEF3EL+cs4vhwcCs
         DODsYZeE/pOl2XSymZi3bvJ0bRMlX3s2Kb8F6x8gn4kZ13j3uf/i70UqO7bylk5NnRiF
         zmdfajaUDea+92MzgUxOAt441TCpxQFvkktljytbJ/GMRggBKhMLKASEcJERk71DBxrJ
         /6HuZ0GyQyY4DfKBX0ZtnKbcZJEY2ziff05mRSPDzg57fCOT90JRrxmQyzB9NNoUWN+2
         WqFNs5rg5kv2e9/Ikv8NbCN4fI3owS2ftaBawrsNJCOFHj74SeH+kvmSXpGnY0IN//iy
         8BBA==
X-Gm-Message-State: AOJu0YycTO/D75EaiNiZ7aJ518/uztoC3aeOrrW43vPQBDdoNTkbrUJz
	f5G2XL+YeNBBMnHA4aPjU2NJMris/kJ5iCW6YE20NXqWvTxGiJb7VgCmyF0s5qDZg9pmWlGC4Pf
	fNPu7HlY=
X-Gm-Gg: AR+sD10Ssf3zsq0RPMZjTOqY7YB8Sd30akK2cHHn2VoHcQINWh8WPqujtfZGrtq+OGA
	ihUV0yRslqtJcMpyfwIkca8z6lQ+bsk2SBEJ+wd1fSKcKcrUalhwFXW++FdvLn7oEOjcvj7NoK0
	1ODPGqutL5NLLpIdDSHwZ3vINZ5Nhmo6WshXGOySaNy4JWA1f0vSUcy49/rpWoC3EXgPZHdtceB
	soTnDyQPpAsbqVjcfB4MjNSLaNHZuI0XIGdUe/T2ZIg0TA6v1kXBzUG7H6hsAW7PxCr0sblJfO/
	XT7orL970IAz6CSREgOJz+9WTADBd4YVJnnbvo1fmGkd46Cepcuw3Y7by2Fk3HfajUgGVGMyCkA
	yWP2sZuA9c6K6vjsunb4iCV17BDj22xTpcXVfPzaelBmAeNBg6Hi7ZZeyfvefxqKH7kYWGbUpXn
	s6eDd73mvQhlhRj3Xd1M0jOK6TxCuqdghMQy+Cdq3BAf2QGvFFKX3c6xmpFGXG1yKsC7GQBA==
X-Received: by 2002:a17:90b:1c86:b0:38e:4cb:51f with SMTP id 98e67ed59e1d1-38f9bd5545fmr1595019a91.11.1785401700893;
        Thu, 30 Jul 2026 01:55:00 -0700 (PDT)
Received: from desktop ([147.46.174.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f9babf9f8sm683119a91.15.2026.07.30.01.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 01:55:00 -0700 (PDT)
From: Kenneth Lee <kennethbwlee@snu.ac.kr>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	rhkrqnwk98@gmail.com
Subject: [PATCH net] net: ip_gre: use checksum-aware trim for ERSPAN
Date: Thu, 30 Jul 2026 17:52:20 +0900
Message-ID: <20260730085220.985948-1-kennethbwlee@snu.ac.kr>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ERSPAN currently uses pskb_trim() when truncating packets to the device
MTU.  For a CHECKSUM_PARTIAL skb, that helper can leave csum_start and
csum_offset pointing at a checksum field outside the new packet length.
The skb can then reach skb_checksum_help() during transmit validation,
which warns when the checksum offset is beyond skb_headlen().

Use pskb_trim_rcsum() in both ERSPAN transmit paths.  It rejects a
CHECKSUM_PARTIAL skb whose checksum field is no longer in the trimmed
linear data and returns -EINVAL.  The existing error paths then free the
skb instead of transmitting inconsistent checksum metadata.

Fixes: f192970de860 ("ip_gre: check packet length and mtu correctly in erspan tx")

Found-by: Sechang Lim <rhkrqnwk98@gmail.com>
Signed-off-by: Kenneth Lee <kennethbwlee@snu.ac.kr>
---
 net/ipv4/ip_gre.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 169e2921a851..16f80620f6d1 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -576,7 +576,7 @@ static void erspan_fb_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto err_free_skb;
 
 	if (skb->len > dev->mtu + dev->hard_header_len) {
-		if (pskb_trim(skb, dev->mtu + dev->hard_header_len))
+		if (pskb_trim_rcsum(skb, dev->mtu + dev->hard_header_len))
 			goto err_free_skb;
 		truncate = true;
 	}
@@ -723,7 +723,7 @@ static netdev_tx_t erspan_xmit(struct sk_buff *skb,
 		goto free_skb;
 
 	if (skb->len > dev->mtu + dev->hard_header_len) {
-		if (pskb_trim(skb, dev->mtu + dev->hard_header_len))
+		if (pskb_trim_rcsum(skb, dev->mtu + dev->hard_header_len))
 			goto free_skb;
 		truncate = true;
 	}
-- 
2.53.0

