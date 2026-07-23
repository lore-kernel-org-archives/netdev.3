Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9502470EA2
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 01:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784768940; cv=none; b=sLa+JZYAlIZLWFdDW7u82R3SHPNy+1pD8DmNHgG16jjWfv/RnCQ3D2KnOmr6/1B6L7PEV9WOnbQPUV+usX3SwNGpZhii8QNgTwHMaX2dgOYOj7wsIbG3niUETOQyvx4JtMV5weHgSQQ5Bx8rtruDmy9LlKmWLqwiJc4rVEJivcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784768940; c=relaxed/simple;
	bh=iXUuvJeZUbnAHSQ0/JdYKQmMD9hx4+UAYjmrTdSZrWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JJ38tmQOZ2z23c2xKnANjnYzs+oFphrUNtteoXBTwYbb7Zvk0Y52624iZ/8ck1WrFEj52IC1xeSWtS599X45JHvYJlvKru8Z8o6aTmnPYAwFM0Oly1+ITduJrXHO1QE6slyvs7Gr9LaMuCUYkSV4ocH3/760ERrbwjxvxkm3Go8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=PGTLEAZj; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="PGTLEAZj"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso58084a91.1
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 18:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1784768937; x=1785373737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fZ7X6+icMEjia70EzX8AwOSl7Wvo6R7yS+bSyCVqIVY=;
        b=PGTLEAZj7+cgt8q5PQg3CG6GY6lwXjmENaT4lqDfudQE8iO6ZIHjuML1NrczF/MSZe
         UGx4jb5ayI9sEVqSEXdk/PICqfiM1U3vroYQR40ixSWYRgziJKo0p6g0O0PTEfnHbhDe
         SmKYahPY1Eh0wPaJ2me3oUANJFTHN/8rG07ueNjkpboDDgaFKqnN86hy53ZoTqFzdLjH
         6DQv6YjCvFMqDaIgrc9hBari5TNH8fN+irxh9QDxz7mxMTBNJdeYtlpfNr4F38Kis/M7
         dUUSmVu8nz4JqDF0OxdPwUHWMOy6NQ9AB/IlDEdZUnICH12Em7n11Wotpe5ufdfCEX/p
         6XYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784768937; x=1785373737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fZ7X6+icMEjia70EzX8AwOSl7Wvo6R7yS+bSyCVqIVY=;
        b=fP/24LByHzGZ+Qx9HVKswIPm9NWLtUkGzGegpBytJ6vnb0YgcMnS72cdBT0D+tcxqf
         Q1hZrHz7qQsmveJ0ga1caKz94rnK2lGCjFhkROD48bwAJTuJESE76BAZZvq7okWdbb2P
         Sh5wRSAK24HX1qwM3ze+jHY8NFBYTcvFlTOwqAYq38iX7QIJJp0c35l5Ch3EVyLaddJY
         0nM/xPX9R4cyR/fcPPpZxjuLgpTPzevnfrAuTxsXEK3pHSdvHGLsM8GO7SOFXayztvTh
         G0x8SEP3jCQ/myeLJfJWMjM0KJPFL0S1ROnM4meeuahN+msraVaxMwP9wyrVg1ClQdvS
         +ZLg==
X-Forwarded-Encrypted: i=1; AHgh+RpUIk2qb7pmpcU6w/XlK4qS/OsOen1UgRXR3fFG9purOiK5tHTf321A9ZParTAQqznRSPIqh0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1twDSbiv6HS25rO8RANcyT0mAG9MI1dSjypz8kxUJPsQx3vtQ
	qvyTL6AVtDnV2lv36F9pMtAy6gyblu22VG0jBeObTk9d5qf6xwuszR5ddVAuDShupi8=
X-Gm-Gg: AR+sD10fqaDzSmZJJt5Meeaam16lGX3/kcdppBP1FoTotyGMvKKlm8hgCi3EZOSgARo
	9zFWOPfCOecM7ZJklcVCXvbOCmXVYBg/f9ueQFw2fvMUNtS1HJBjTQa8NgGQIhXLpctDYzItHpE
	6Rk2jHmWFfzc55jc2dbzTTKlL5i9ZLBE659quYKSWwO1ESxhr4qnTs0bBd1spLrkDlSh+5mROEG
	fp0P4Y4QHcW2YA9dtBTsF6qo2MfSJnF3md36ooZQiI9To6vTB5b7EcHp7H0EN8tSt0WWJU+PnhR
	aaszH6ep2LxwPyT/oO+suqcXwZWGX7mswVlk0YGy2gcOqz44OhIu4brdcf8/sRfJrZwt8zqe7Ir
	ACkBLen1J/VTAJX6x/t9j/I+aI9YnF8Xi6cBh+CIBaFwTABTQwfIeOfKZDsItRnx+qST2dv/Y0m
	2HRIoo/aWDEIrGCE9CoZI9
X-Received: by 2002:a17:90b:3c42:b0:38e:5c6:4db9 with SMTP id 98e67ed59e1d1-38ec64f0739mr1010747a91.11.1784768936738;
        Wed, 22 Jul 2026 18:08:56 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38eca7361b4sm37828a91.0.2026.07.22.18.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 18:08:56 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>
Cc: Roopa Prabhu <roopa@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: [PATCH net] net: mpls: initialize rtm_tos in mpls_getroute()
Date: Thu, 23 Jul 2026 10:08:29 +0900
Message-ID: <20260723010830.289917-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mpls_getroute() builds the RTM_NEWROUTE reply to an RTM_GETROUTE
request by filling a struct rtmsg allocated from an skb whose data
area is not zeroed (alloc_skb(NLMSG_GOODSIZE, ...)). It sets every
field of the header except rtm_tos:

	r = nlmsg_data(nlh);
	r->rtm_family	 = AF_MPLS;
	r->rtm_dst_len	= 20;
	r->rtm_src_len	= 0;
	r->rtm_table	= RT_TABLE_MAIN;
	r->rtm_type	= RTN_UNICAST;
	r->rtm_scope	= RT_SCOPE_UNIVERSE;
	r->rtm_protocol = rt->rt_protocol;
	r->rtm_flags	= 0;

struct rtmsg has no padding, so the one uninitialised byte rtm_tos
(offset 3) is copied straight to user space on recvmsg(), leaking a
byte of uninitialised heap memory. This is in contrast to
mpls_dump_route(), which fills the very same header and does set
rtm_tos = 0.

Initialize rtm_tos to 0, matching mpls_dump_route().

Reproduced with KMSAN by adding an MPLS route and issuing a
non-RTM_F_FIB_MATCH RTM_GETROUTE for its label:

  BUG: KMSAN: kernel-infoleak in _copy_to_iter+0x36c/0x33f0
   _copy_to_iter+0x36c/0x33f0
   __skb_datagram_iter+0x196/0x12c0
   skb_copy_datagram_iter+0x5b/0x210
   netlink_recvmsg+0x37b/0xef0
   ...
  Uninit was created at:
   __alloc_skb+0x8ca/0x10e0
   mpls_getroute+0x1280/0x3a40
   rtnetlink_rcv_msg+0x1138/0x15a0
   ...
  Byte 19 of 64 is uninitialized

(byte 19 = nlmsghdr(16) + rtmsg offset 3 = rtm_tos)

Fixes: 397fc9e5cefe ("mpls: route get support")
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 net/mpls/af_mpls.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index 318cb7e2ac5f..f1c9fc8504e1 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -2537,6 +2537,7 @@ static int mpls_getroute(struct sk_buff *in_skb, struct nlmsghdr *in_nlh,
 	r->rtm_family	 = AF_MPLS;
 	r->rtm_dst_len	= 20;
 	r->rtm_src_len	= 0;
+	r->rtm_tos	= 0;
 	r->rtm_table	= RT_TABLE_MAIN;
 	r->rtm_type	= RTN_UNICAST;
 	r->rtm_scope	= RT_SCOPE_UNIVERSE;
-- 
2.43.0

