Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C60F395AF2
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 06:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785737575; cv=none; b=l20Bts3GckjXaeUqOyYlCYZMkvaBtPZDQqY/YAQyE/hRQacdkuBpwA+U7z6FDwCQocFvs3XxrOQOcd+1L7hjVXcb/hw9mBEzyOOC0Y/KW+gx/hMO1aRtMF/8mgvjIAMZqjyFzrIe2/n8bwUdSAGQme5gT1ST+OmFy/+J5p8VOcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785737575; c=relaxed/simple;
	bh=tZI3Ds6xOc08DKAOcpQLlKvUuRx/5If7Zqjk25XCXs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W0tHE/uLTLlbtbOgGDYAbgzTFLCIaZbUpXsj5D5dR3vg8Y5t8tfR54H+jN5BUvnDgROiFFG0uE+5rEXWSKBQMSHuoXkaJ0SSefQ1P7/4Lpldjb4hPjmIm092KLLhn2tz1JXXYsOZ/bibxfWSusQ8hBg35hj2gTBREB0+ag5FnHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=CmqeAAGg; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="CmqeAAGg"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cf52d15d88so24244615ad.2
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 23:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785737572; x=1786342372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v6LvFUDQPsdI5v2+mReyWwgac4AW8ESmzXpcefRIX7I=;
        b=CmqeAAGgg7ZwWwyuZSUcU55pumzCIIkliTAytlWzaXU79k5ZWHAR5RFby0r2Z1bQgk
         ZLm1RCNwFCu6/8g4gKnyB2cJOdee5nItyg3vChqVVY3b4Fc/7B3xIsY9zvTC6OPdSnYh
         CgjeQarSeDIGEAIGavPXAdvPz6kD7kRpoM6srhPwcL+LzADjCbrj4/UYZxkm5Rx42D17
         VVBJC+wy3CSyyIZ3ddbMdlMHAlnPHaoVKEE6jpL9LMm3W7PZphtRwTebYBrdxiZYttYS
         US1P4OnnS/MxlEdiyxLLuf8kwCysPbSGb97aX8Cz9hmpGeayDTUtPwnx7bc2g3pFDZpt
         ycYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785737572; x=1786342372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v6LvFUDQPsdI5v2+mReyWwgac4AW8ESmzXpcefRIX7I=;
        b=HOgEtsxZJK/fosYN05dSZpnyIXeRjUsLnqPgDL/SeErGOY76YyfrZl28xy2AZHUutY
         SyBtIJ9gZ+QZbXDEnS2bUBHc2veL8cpJHfwlp4p3UzbCtkFS9pjC9TPBocG+aeYLrTom
         bCNtfqrEylrjmrpq9QojS3czWF1raN5aGmBunfqY0Oq5R/66hFVVM6tc5k7KTOSvi2tX
         P0KD7CnsKQgDpKv4O0xwuYvyMoZwoW6pENAEOskgFRFpdgCFxarU/wgaMmk4YFwJiaY4
         Uq14ogTPPAiNna2r1YZldqlSwgzgUPFVjm45fV3uErgbS7A7MKkCEXfP58B5+BZP2vZm
         IfmA==
X-Gm-Message-State: AOJu0Yy9ioaTpjzn60p2OwpHrhY9CeGBpnn1hOkpxy4C6M4hCuNq8OJC
	w/VIQnC5cvste0eaaWyDvLi3h/Jk09tAjlCf8G0fIC9jzmVGQYeJaVLRhFe5NN1g5+zEDeJ9SeB
	7vl6ez2FtzYfHXg==
X-Gm-Gg: AR+sD1045YHzE4xnBFeX7kbVYED0zjL/Y5fzyQd3Y8Knbsauen2lxx91reIzun6iGHi
	/g9rjJ/lQjfRb4b1CiaIdA5NCwHZyOD/OXrffyx8wMEzXhSOy4UuMCsjgdNs6eMUk6l+9cW9vwQ
	JabDyOpMk1Plh/KWbYDjFtL/MoNHXLyFxTRjAvne13eN7/Ek2HJAxU9OoBzo7NC6kDsKe0IkARi
	5kQ5dbWHPK1sw4GLtrqCBvsCLsfXpX8mFQ8IUxVK/MGGUDLTQE5s7F9XSfqgLgoyqOidORG8N9y
	h7+CHfM0j4ufK0eiU4dEmIZwa653jFg8L1BkanrZfZgJ8HfQjaRKxRC3aycmZ8VKQzLyvy0wco/
	9OOBJSmi0NQmTCQGsYlEmKPIipnTlBCHZXd6b3ugEAt/LoeDEGqMR9EjXYUQE3M2Jg5WIjTgATV
	ZjnonjUIWncwvo2pcFAHEGGcnOlGEPPlsy/jjbiSEb4crMKvY4bnrt3F+Q8CxJW4fbXWydvS60q
	nUBOPmtKZy/
X-Received: by 2002:a17:903:2442:b0:2ce:d34a:5963 with SMTP id d9443c01a7336-2d05229870amr82440095ad.24.1785737571680;
        Sun, 02 Aug 2026 23:12:51 -0700 (PDT)
Received: from Roxy.localdomain ([202.8.9.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae18934sm32543905ad.11.2026.08.02.23.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 23:12:50 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	yoshfuji@linux-ipv6.org,
	yasuyuki.kozakai@toshiba.co.jp,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 1/1] ip6_tunnel: clear skb2->cb[] in ip6ip6_err()
Date: Mon,  3 Aug 2026 14:12:33 +0800
Message-ID: <fe1a5e765fbca88d69391887f0ed26a19e3e4d39.1785736562.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785736562.git.zhilinz@nebusec.ai>
References: <cover.1785736562.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip6ip6_err() clones an outer IPv6 ICMP error skb, pulls it to the
quoted inner IPv6 packet, and then passes the clone to icmpv6_send().
The clone still carries the outer packet's inet6_skb_parm in skb->cb.

If the outer packet had a Home Address Option, IP6CB(skb2)->dsthao
remains non-zero after skb_pull(). icmpv6_send() later calls
mip6_addr_swap(), which uses that stale dsthao offset against the quoted
inner packet. A malformed inner destination-options header can then make
the HAO lookup and address swap run past the end of the quoted packet
and corrupt skb_shared_info.

Clear skb2->cb[] before pulling the quoted inner IPv6 packet so the
reply path does not reuse metadata left by the outer IPv6 stack.

Fixes: e490d1d85cf5 ("[IPV6] IP6TUNNEL: Split out generic routine in ip6ip6_err().")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
 net/ipv6/ip6_tunnel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index bf8e40af60b08..ebf83f090376c 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -684,6 +684,9 @@ ip6ip6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 		if (!skb2)
 			return 0;
 
+		/* Remove debris left by outer IPv6 stack. */
+		memset(IP6CB(skb2), 0, sizeof(*IP6CB(skb2)));
+
 		skb_dst_drop(skb2);
 		skb_pull(skb2, offset);
 		skb_reset_network_header(skb2);
-- 
2.43.0

