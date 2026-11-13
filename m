Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794529315;
	b=1pFNfQIJzdU5risAFb5N5gRQLR16sh+ajfSUHVeudOI5ZicLDs9LpGrItF+AgA5qETUA
	 2l7RmhKZ5b7MV3j8kSCXnchAiqMwzpYbHxF73rBdG8ubrho3bKe7WArLvbx9RcOT29iiU
	 cEqF4Q7Y5fwYax0/FkI7C8MswpBbctUUpZ5ebdDt44xfF/D/ShLLXNkNqKVvkHeKfVSc2
	 P9XO9zfPD8/0PZkBgYDejpl7KYHO5pbWiriG5ucS38gJ1vzTgUaeuIbMUR4a+jrOxKrJK
	 QvLjnafkAnePLhjmG0yEl3EMZnpt5VULf1CuV/snxgi7Nhon+EX+nA496VuvMLvLKfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794529315;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=TP6+U2d+mrammhup6FRWKD3OhyHz7UhDzo+r1lCuEEc=;
	b=c17J3bylOMq2HwtergnsyjN/A3LTo9okfNBTLTmoqUPxgXa5FyEkmCgu490eMbSFB4n5
	 4PaGHsRygG61X2PlgpVsrBZQl6NkJmXhIEHHe8ybx6S4RzNXg+PwKIPh9RUpvRV3zLfWH
	 437LjNnF98Lt+1dLV2lns3XkDPwnwK1dHRdwMgGhjX98nH/Q2FrTOqncJUII6CHKz/UdX
	 y951CoMaBbrFR9i0Bbs1FdkERS3usg2DhzRiqAAvxEwNjPUP98z+Yzjkr7TuteuwLNZLy
	 gHVgTZEXTn5Zr81OgseuMUCnsQXvxvHL6JlKpq2EK+2NOLstBFZJ08suYkdUhdSMJKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=AQhv8Xe1;
	arc=none smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD579606A331
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 00:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD579606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=AQhv8Xe1
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93f20b304c0so48804585a.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1794529314; x=1795134114; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TP6+U2d+mrammhup6FRWKD3OhyHz7UhDzo+r1lCuEEc=;
        b=AQhv8Xe11ce6tMX1BB+GHgwwTQgwSukSvPno5tkLcl7aptZC3Q3q82EJpqNCqJhGm0
         sIcjNKQj1PH1oJBtbcc1tXqJqDxjWxjYtCDjVIdLkAF1d58D+3A+JWryPwrm9ufFA8jm
         WQg+M3NPYpT/iZKuz58HeeqZSe6eJlX5n6eXYSzlgnU/YJH5yyeWrjB5mE4mvIW0sGIX
         sqSk+JgRyTOWvA2J/ek2CkmabaAefO43PUBP6yF/C7/e+igFqyMdb6tfDm0J6IoiFzG5
         LMx1Q9p3rL2Y8btitvaXScgXLZUg6dbzj1lZtqWv/2qsNr9D7btQdLjvPrlRmZPeTy7b
         OI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794529314; x=1795134114;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TP6+U2d+mrammhup6FRWKD3OhyHz7UhDzo+r1lCuEEc=;
        b=XMxiFPPLTKcTTIUR4WlY40HSeOVt2UF3zEEmq+62E1ESkBXK48FNVgFePhWfHzjg70
         VYzrsz6iMKDqtIW2HBwz3Opsa9GGGOdCol5MW/f/EJBMuWXsbh0KatoJGZKat9QeTEaL
         smqZyf5i5kyzb2yKhu8FyeY6Fsiz9XfQgXGg3E13SWy3VHPxfekkgCoCfyCtTSG1WiwG
         jWGBAMNl3UIOMqDzuLhVA32tUeCPmv+xfCbC9sENMxtbkf2YmSQg3Mjit5jOL3awueaB
         ahKZXOmwGljt+Xk7Lkvnfvqg0up6WAKw/gm4x2+JJWN/hcyBL2A2jzInQbI31axdN6Fs
         +V1w==
X-Forwarded-Encrypted: i=1; AL+hErGnS1+iGJFvieMHiwq/Q6TLCaXiIUFPg9PE/87lx33B/53xuDbBA0uf9WVROF+kp3ZjtSZrw3I=@vger.kernel.org
X-Gm-Message-State: APuU4Z/NaB8+lbmn48DF7rdIlmVg0N/e+NdRxJarAmzStEjloyJLLwBN
	nWAm5dKqwZFtYFKhiAcbqrSQIfsvmaz5TS7J/PUmjuJHg1w5Gozg83ztThwiI7SrHPA=
X-Gm-Gg: AYBFou0p3CjHK5yMm8FkmahKmymqVTdUfd3X6rh50QioT/3e52Ljo9kUWZyASmWLwkq
	ThfeKwuwoULQpaF/Es8JjpD49FeDrA3/0InJn9l2PAyGBjRZKGYBI+HrQnRYMuuFAsoJVdvCPHy
	laKfbAY7ivDu8lSJ4Kd60qaAc1gzI/im0gB92QTWvAQH3fGU6xVPNmZ6C2K55W9UK35DhagPmqO
	JAWXcsx0xuWTZ6Vnm4o3GPRnfvpKERdNr2Mzfe7UIruYIUU9iIeg+kDbT/7jYFeqq3X1rCB67BY
	YeZdE/MIXOoN9KMl3Uq9HCZU8olltR94iOXnh+xsXRz7VGBOT++88aedbEc5XqbBum7uygQeHcP
	zhuV7/6cYqA7AmEVBvH8OP55SxyNtcV2aqJqSCMnrhV49F7BwQXFschR84HGkxYCM3kEAMMmqun
	Dtg3HlG1QRX1DCLtLWeRyxAJKuu2qOr1INR2MvQQJe1tCb3+prhPImHOSYVNcTCDGaB6k9ngMic
	1qnY/CALCZ5vMWh5UGHfXUkGS0iwpruKrTRTSQocNuCmR4Wm+o/ovmzyWk+UOvKpFUAbZLDFPgq
	/GNrdGLx5EIkNdydgtFkccA6SM4VsJY+j8756Jti0nsJuw==
X-Received: by 2002:a05:620a:2812:b0:93f:265a:c609 with SMTP id af79cd13be357-9494bc99526mr173440785a.69.1794529313750;
        Thu, 12 Nov 2026 16:21:53 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.246])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c836156sm58647085a.19.2026.11.12.16.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:21:52 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 13 Nov 2026 00:21:28 +0000
Subject: [PATCH net-next 1/4] net: skbuff: don't clone a nested frag_list
 member
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-b4-skb-segment-clone-fixes-v1-1-f777fb06f3e7@toxicpanda.com>
References: <20261113-b4-skb-segment-clone-fixes-v1-0-f777fb06f3e7@toxicpanda.com>
In-Reply-To: <20261113-b4-skb-segment-clone-fixes-v1-0-f777fb06f3e7@toxicpanda.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Fernando Fernandez Mancera <fmancera@suse.de>, 
 Mina Almasry <almasrymina@google.com>, 
 David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1794529294; l=2194;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=RrsjJ8rFxliJGlCscfCTi8A0hpikum+/JC2mml4KyZU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QELiu1KI0u2h/o9raJqqHq+qRV6S48trr+KkWHPqexgRmLhayJPiyOJR3ApYFkzKhLVEm8cYkDi
 UoKtGjQNMMA8=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

skb_segment() clones a frag_list member whose linear part fills the
segment.  pskb_trim() drops a nested frag_list from the clone, and the
walk moves on to the next member while head_skb->len still counts the
nested bytes.

With SG the walk then runs out of members and the segmentation fails.
Without SG the segments that aren't clones are copied out of head_skb by
offset, so the nested bytes are dropped and a later member goes out
twice.  Take a gso_size of 1000, a head of 1000 bytes, a member A of
1000 bytes with a nested frag_list of 1000, a member B of 1000 bytes,
and a member C with 200 linear bytes and a frag of 100.  The segments
come out as head, A, B, B, C.  Without C this was a NULL pointer
dereference before commit e447e46ce976 ("net: skbuff: don't run off
frag_list in skb_segment()"), and B goes out twice since then.

Don't clone a member that has a frag_list.  Without SG the segment is
then copied by offset, and the copy recurses into the nested frag_list.
With SG the segmentation still fails with -EINVAL.  Nothing in the tree
is known to build such an skb.

Found by the Sashiko AI review of that commit.

Fixes: dbd50f238dec ("net: move the hsize check to the else block in skb_segment")
Fixes: e447e46ce976 ("net: skbuff: don't run off frag_list in skb_segment()")
Link: https://sashiko.dev/#/patchset/20261104-b4-skbuff-bug-on-followups-v4-0-b7ffeb364f5d%40toxicpanda.com
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 457d57d49fc0..7c232c5c8883 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5247,8 +5247,9 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 
 		hsize = skb_headlen(head_skb) - offset;
 
+		/* pskb_trim() would drop a nested frag_list from the clone */
 		if (hsize <= 0 && i >= nfrags && list_skb &&
-		    skb_headlen(list_skb) &&
+		    skb_headlen(list_skb) && !skb_has_frag_list(list_skb) &&
 		    (skb_headlen(list_skb) == len || sg)) {
 			if (unlikely(skb_headlen(list_skb) > len)) {
 				DEBUG_NET_WARN_ON_ONCE(1);

-- 
2.55.0

