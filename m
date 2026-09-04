Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D34548C40B
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 12:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788524527; cv=none; b=oV/LwsG03ScobKkOC/RYNQIDm65oAtfnv7SLt1Kf1ySZr9iay8t2OrgN7zSUNVFJQGSg8l38/IX6yWxn549H4rUVtXZejgPBUGXtCA9gIF/aGGU38ekZqoXZTTGPSkazlLqtw9tnfkkWS93FZxF72IIcbIWKyUSD5ev3fnSSrs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788524527; c=relaxed/simple;
	bh=SPanqEVaN3IgvDMJt3AE+/QAjR+ZhnRjJ6TnwhhAHFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e7EIiI6sVPGB7pXXQ1GbMB1m+0NeNp+4ZWAtksuUfmhpj3rC4kmDH2iC6IXACA+KIQkTEp9pfRGJHU15tQdL2MktYVwmifHNOLG8+TcEbQcUAhph/MWyiNowoB3PzjsROxXPd4jI9KeTObSTTSjMjqBCWWDSBPOgFklyEqW2rKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D80gPO8c; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D80gPO8c"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7f4b94d72acso877825a34.1
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 05:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788524524; x=1789129324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XMyLx7ZGwyvU+g1cPFDlQXdQySr6WmMfAZQG5/qrTCI=;
        b=D80gPO8cY6Ojv29ucOkNdqJ40f58l/Uyf/9F5coYi3fvnNTSGPFAYIGLHfncLajKIT
         jNaTX+otw/AnZRGmsAbGIelbszQtKJzY7HlRjf09FZXklUzuPUPqw65lVMkP1g9IRYYc
         lYbU53JLK/5P77UmrYwrSbsijRqAwFplS+vQtdPB9LSwvNrw3Y8j4ayFPnQS2W28Aiso
         JGQoW+1zjqJR66RzJPPqZuEQkE9hBS5/97qroQ1Ay8cT9V2PlxO5lrk95n0IAkdNdzFT
         s62Pdum565ohtEoz0RQhqV9WpUFhBx8gbO4XlVCkb2Ck0OcJZD9tvXpwB2fXo4QzHPw7
         97BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788524524; x=1789129324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XMyLx7ZGwyvU+g1cPFDlQXdQySr6WmMfAZQG5/qrTCI=;
        b=MQliAaKTa3x4ctV4si/D4Mst7tXb8SGlTFmUnyazQ/StCAjD3sDT+TI0aOO7lo0LRi
         pW6wCXLzsBkWEdAgqkC9645nQ6eO6VdbNLfa8F6LhEswQRN9NBA2BtF3JcqQHktAeL2q
         2B9Iw5vY0Y5fN8VfoPPaNXg9jBbXA6lrLW6eiV97Me+h/fCIV9F83RkA/8StXUo+y9aL
         rpKeZb1Zx/1c30RbBocOjJLbKGl2exY3dVZ1GSv5UR2LUJB/rrm5f9K9tx0SglK9xWnz
         3neXU8Q1aS1JtPoEj/p19gjO/QsIrV8+MVCjhZadJ8keIeVU8gKde3y+/6x4vxM7Vvnb
         pCKw==
X-Forwarded-Encrypted: i=1; AKwUvByFLql1BkFYimuG0NR4FNLWAdV1zMNOm8yXfqb2Xw0tqpUu4GWXCsCs4QMyintbIsTK9NZtVa4=@vger.kernel.org
X-Gm-Message-State: AFuF++k0PBSyOxq6p0HonXJqw0P3IiBSKPB2MIq1KSqVw3m+XM4IIFT+
	1FONN3XUDR5RjJv0yUV488kuqgU21HvrE3numhP80WjHdIcN6uMpTzCc
X-Gm-Gg: AYBFou1Xh/Tx8UszCuwJ8f05uxFH0DwKvquyfy/hbHg71D9q71gAwjq9yIySbkYJzuo
	M/ICeL/28gWiGOAxflQr5keXy5rAWP25WWMksphirJHtbSW6uy96hdCsj3ogg/ySm++bE2IjLiu
	Uy+pvnBPR3EwLL4q7Va/OVKvfOZIK1gJF8Jx8HNHItLvuIbCrYBvILDAyKGbq318kNue11E+Eyl
	s9L+tuzYEHWgTS7IZuVKxtyg7gF6Qtmw/XeY4fkwo29KZH8g389giqksfHjy5qVs9hjI6jZHUdq
	NUoxecl0PetH7t2N0DBqoHmALca1VpXX9Z/FIzCYUx1kM89b5ZdjZI88dqKqVVWvsljwe5PjA5A
	HBUjor0uAseRtjNS4qgKfASjceUKE93Ie2BAIKGASd14sNmawnR7Pmdoc6TKL3hHxsAisCAb8qL
	XE3+HB0RpSUDBq8VtONaxUimvxatljWLaAaUc6Z286L0FTf4kYJlawuHzzWOpEHScS6e2F/k+xt
	A9WWwyycc1FyY9Y4GAP4o13hKE=
X-Received: by 2002:a05:6820:2912:b0:6b7:46fc:1c5 with SMTP id 006d021491bc7-6b746fc0332mr2392300eaf.36.1788524524068;
        Fri, 04 Sep 2026 05:22:04 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432423f99fsm6139397c88.1.2026.09.04.05.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 05:22:03 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH] net: ipv6: fix typos in comments
Date: Fri,  4 Sep 2026 17:51:56 +0530
Message-ID: <20260904122157.29281-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 net/ipv6/ah6.c     | 2 +-
 net/ipv6/ip6_vti.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ah6.c b/net/ipv6/ah6.c
index c96f7e0d0a48..ec9aba2bc6e4 100644
--- a/net/ipv6/ah6.c
+++ b/net/ipv6/ah6.c
@@ -169,7 +169,7 @@ static bool zero_out_mutable_opts(struct ipv6_opt_hdr *opthdr)
 /**
  *	ipv6_rearrange_destopt - rearrange IPv6 destination options header
  *	@iph: IPv6 header
- *	@destopt: destionation options header
+ *	@destopt: destination options header
  */
 static void ipv6_rearrange_destopt(struct ipv6hdr *iph, struct ipv6_opt_hdr *destopt)
 {
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index ab94b3a4ba9c..c79027839151 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -437,7 +437,7 @@ static bool vti6_state_check(const struct xfrm_state *x,
  * vti6_xmit - send a packet
  *   @skb: the outgoing socket buffer
  *   @dev: the outgoing tunnel device
- *   @fl: the flow informations for the xfrm_lookup
+ *   @fl: the flow information for the xfrm_lookup
  **/
 static int
 vti6_xmit(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
-- 
2.48.1

