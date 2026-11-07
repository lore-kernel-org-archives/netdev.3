Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794057663;
	b=Z35muBjd1XU1JpHcbfDrLIe8e1jftEgQyEYf0iMv7amqm3r5Xa4E1ZNAyuKwTmqa2da7
	 7KV/LeHqfH7T+8PHCy7hbKOOhrKXg93yw+luONhXtdRG+sp0dAX1J2owiEM6ZVjpy10kf
	 SufC8V7PKH2rfYTdMBJq40qZR7kOcApDe27v7G18Pmqi9H07MQhTdixV4Wuuq7n5Cj8yR
	 NSnoWsGroMIKtEkq9B7hp1SEOMvinqoAJ7QJ9AAhaRh5ydi9p2OnLpOxMadbajYWDqasP
	 3Jtia+Vu8s/0V9WyaAHFpMyne6zgRcpJaHXrFFzXTqk9lvkZMBHzgq/ylgvmCLcY1Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794057663;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KIiaF2zkqraRDaGzuBJLS8MFpCqmAqCaUnqld6tkcbs=;
	b=BtsE+OAsgZX914iIFHVecxUnjwajLSwwZD6gjedsKNJeLRsuyZNoM42COuWntKbxBnEN
	 bb00KEiRoMlMScG/JU+bbtzFTUUC9NK+ItPz40IKe9bONeYSHmVtsId5/f5zpP0PuGbku
	 BbWKa2xwz/oI3XGS0y5lkewNuASqgN101hA+36viLll0tkuhTHJC5bDuc/A0oJ5R95KbT
	 XqeW6/humzi9t4X4pvGcl5oohlHL+5Iiep45+GumFHmOrYrHN+jfxTyhg/mVeJpqD4iiu
	 /3s7m4U01HvtpbkpU0QJp+T4ZDthZIsiVaU+hXVZ2vYx+eVpzH7Kir2ktD8tv0vPPLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zuRUFPIB;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D92B606A334
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 13:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D92B606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zuRUFPIB
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ae1da332bcso672299a91.2
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 05:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794057663; x=1794662463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KIiaF2zkqraRDaGzuBJLS8MFpCqmAqCaUnqld6tkcbs=;
        b=zuRUFPIBURw5fma4XvmlZA110QqjHir5dvDOtsVdk1SnAPOE/dpyFbLYrL2J7oYxGB
         Irm5an5jBmBDZoXU/LWxYSU49zezFCuZSGV2RYr5H7LaAVApbMGe0giR8U3/9Tw3Bv72
         3reMDgC//9/WxWVQEZRmvtxx4BmruyPm39XR+vZtBsmY5Xi2xH4MFlb/PTAXdfzEVtAh
         ZBaVBkTSjxNrYN3SDIDEZDaw1bdX8BBaxFM2aGqip1LYSmm8NPm/ulZmraFuBZepX7oR
         9L2KIFuRAKrKJ1xRFYqLFUjpGB8sbGqi85tF8XiZZzB2tYUPgQxl04cIwTFJtejjUWzW
         PtKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794057663; x=1794662463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KIiaF2zkqraRDaGzuBJLS8MFpCqmAqCaUnqld6tkcbs=;
        b=TyyLjUftV2zJdLKDAPzOIjL1Vzq5t9JQ8EYx82tR4Dkj0/SkDjZ8PBJ1BUYtSeKNpC
         IspfqK/xvtbHLrYkS22uOnPn870Z7KQShm/VBOGK7dscZfY2u+/bWtak4+ol7bUC60zo
         6cdCThWyftaGBf4ZPIxsMV1m1oUwPGiQXY4Y8+66J0tgAzH/slzw8a/sxXeWW6dmFBJ4
         Ph+KOB/9mZw1WlNG6VwwFzpsVZdk/Xi5XUAGwHRpaUR1d8l4xvw2C2YMjJl5G6dFU18R
         XpuK9s5st8ZTDqWaNLtlFC5UAzjR7uERjKVCApnf7mCuCMwCTT2SYdJXyQEQleVYLqke
         5acA==
X-Gm-Message-State: APuU4Z83t6myGcOxTjYhO60f3wH2/xvfxWGPUqKk81GjmEy6yb1Ql1JX
	O0GPRCT9AQaKWpsfu6uCEn7iW6E57WvCCBfspXHn1cOkRivbPV8i4ne46zTuxg==
X-Gm-Gg: AYBFou2lcB6bxeJapp/ABSgrOlNmyqZokD2Gyo+STgIocPl5dpdFP0JO57IKSQfRSkA
	cXptAF6vIie4pM0gBvHnrXfM4/IW5vHhTKDqbtAKN+knLgdI94ayvLJjxDUzeKKVnvpobp83ScJ
	miRMD2KjReQwNOoZ5vaCEf0TcZx+nCbC1Rfz1LOQFeKdxA1MkLerG0GtaUpzVtaXVjJkwxtN0eT
	0aseovKfJI5Vzig7t45HxPG/A6/rZ34G5KQqn61GcKlFD3CwmXsfyq5W/h40uHS6FrupfuwMxWN
	Rhn8k6yMr5WAtH1k/e1UPuEs9cekytM64vE1WuS2HoHoL0AUnZQ6vUrcxW0DmyjzyxBfW9qT6N2
	myqwTtp0CB9XZJvfhhzH5GIItrB2IGaLeIDgbug8aQqwMpTrh0z9YVLXDOqK0f8CnpbmV1XOEzb
	dxdDChCdhPYytBYdJ4tFS/lY3MRZpyzPes+D0Pd6F48sTU2dGEG6U1gj0XozfwCPhmXo+nfzmCn
	KjgsgkwW+CVDE54NCFv3e3pjYpN+ONLXGqS4rArJyDXGLtlpcny+00oaNbyHkLVBUV1jgVo6aac
	Or7OZXM7tv52KeJtRGK6uIFE17B8NLuk7q1w3MHA4low0CuT+GTpAt7BCltJLRWOZNNq2jxtCso
	=
X-Received: by 2002:a17:90b:5307:b0:3ae:898e:a123 with SMTP id 98e67ed59e1d1-3b0db6c9909mr5456999a91.14.1794057662730;
        Sat, 07 Nov 2026 05:21:02 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b101d3d0e8sm1626521a91.3.2026.11.07.05.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 05:21:02 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/4] net: dsa: motorcomm: Fix RMON fragments stat
Date: Sat,  7 Nov 2026 21:20:34 +0800
Message-ID: <20261107132040.1066996-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107132040.1066996-1-mmyangfl@gmail.com>
References: <20261107132040.1066996-1-mmyangfl@gmail.com>
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

etherStatsFragments counts frames with a bad FCS due to fragmentation;
report the dedicated RX fragment error counter instead of the alignment
error one, which is already exported as AlignmentErrors and
rx_frame_errors.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/mib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/motorcomm/mib.c b/drivers/net/dsa/motorcomm/mib.c
index 5c027edb71e3..90b0ef670aa3 100644
--- a/drivers/net/dsa/motorcomm/mib.c
+++ b/drivers/net/dsa/motorcomm/mib.c
@@ -336,7 +336,7 @@ yt921x_dsa_get_rmon_stats(struct dsa_switch *ds, int port,
 
 	rmon_stats->undersize_pkts = u64_stats_read(&mib->rx_undersize_errors);
 	rmon_stats->oversize_pkts = u64_stats_read(&mib->rx_oversize_errors);
-	rmon_stats->fragments = u64_stats_read(&mib->rx_alignment_errors);
+	rmon_stats->fragments = u64_stats_read(&mib->rx_fragment_errors);
 	/* rmon_stats->jabbers */
 
 	rmon_stats->hist[0] = u64_stats_read(&mib->rx_64byte);
-- 
2.53.0

