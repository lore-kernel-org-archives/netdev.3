Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E9D3F104F
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 21:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788902067; cv=none; b=lPgrqc1fIU24jecpcwvqc5lCsHtna2cQ+8EjL9ubWm7Rdvjse0okrs90JqqEg0plI0CorESaq81Y3+H+r2hHJgZgySZKwUWC96aNnRlT8LyYsnYmEH1wl6EwqDxUMh6Jpvq2iEtrwrfbx9Jcc/Y3KEWDVnc3Yn6HQcVtd0z+ekA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788902067; c=relaxed/simple;
	bh=Y8AQPi/TGjAZLl3OY0ovA2Q60/csx6QG02Amny09PXA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aaO1puvaAMfAZourbmdVrhU++T0IZAIWzGmqI/mA56L3NZjcAVn+Tz0QXLrDFnslkYDx7hqjX6k6z8wV4zF08HXwfTPJ4Mic7Yn0t8x48G4eAnN98+Zp2CILeK3V4GKZenUWscfHHzGfkL36Tl4A5Q8uDjx2EB7/XuO1iOyWXZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LwRSVGOL; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LwRSVGOL"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-85321e37104so5318592b3a.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 14:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788902065; x=1789506865; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dYz+iWBBIDMB1Ze9ZKdjAsZuBd2+bxi/DM65aoj1Apg=;
        b=LwRSVGOLLNk91hFFEfKAsR0Up5y+9TCPxE7iqHhQRgUG++Sg7ENT/rA+0QIWInlmkE
         NmlOogSqG5n8qWbhjVDkFsK0K2Ce11i8EWtspdzDKyegI8Vqa64qqDxgYhcdGOWrY9Qq
         hORze9mak6BardVXfuubzXFUUlABJaDUpV7yp12SnhOqzEA/daDTdOGfI5A7uwSaViXN
         ycoEO6cFHZZQlH4SQeqLK7fz1PSajUep/M/YUerMOOYCEwHZxVJamTxCBHCkvfkLg7Uq
         CQkP2mxRory7A70tOFmzpbRo2o5Qp2Aq4L10T886XvJ84g0grWHswI6a8urSNokyMPp3
         VMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788902065; x=1789506865;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dYz+iWBBIDMB1Ze9ZKdjAsZuBd2+bxi/DM65aoj1Apg=;
        b=DMW0aAKF9NyTQnMs+/a87kJWvL0R1NvlInzsXrspJev7AjsY94f+6/cXwUrjrlpasC
         CzyXi3FpV+Yqt1YWX9mGVnzf75efzqWrUeqjklC7+jlc7jCDQJqkz71dQ9rrtLM1nI7g
         DWimY0PmaO4V+LjCt5oOhBVTfEl7q53b0cMUymSjd3r46eSoUf0LnAPebg+Vg4pKV5TQ
         VeousJp+H+9SzXcWg9P6JqjUvDWkax/rmP/dLn1U/Jy9eMzOgdcAgTum/GqtO274xkOr
         UnIQSb2LKcwC8HzFOPOeOVo0/wbkCPFZGo7g/qxYcQT8CTfCxkE/Qr3LAVDiY2+knp4z
         6EiQ==
X-Forwarded-Encrypted: i=1; AKwUvBymxCfuX8USIrmYQJKtsOIeRjNSb+BYdjPZnr0W6s2kAV/YaW3RMCFRGHLgadeE8kWv0OMhM0g=@vger.kernel.org
X-Gm-Message-State: AFuF++lSQtxjIUquwQGzROFw6KygbHGfWyEieDaZocTRG3pfGn4q9zXG
	vCKELHUG5war09L/0zl2B3Imkt2sB9/45HVVJA2oHsx17mZMX1wYjc+I3OJgv9SEjS0v0yH513N
	fK7fYGg==
X-Received: from pgkb16.prod.google.com ([2002:a63:eb50:0:b0:cc1:ca15:6d9e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7109:b0:3d0:d933:af97
 with SMTP id adf61e73a8af0-3da3a0aa8b2mr48566378637.15.1788902065055; Tue, 08
 Sep 2026 14:14:25 -0700 (PDT)
Date: Tue,  8 Sep 2026 21:12:48 +0000
In-Reply-To: <20260908211419.882954-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260908211419.882954-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260908211419.882954-5-kuniyu@google.com>
Subject: [PATCH v2 net 4/4] neighbour: Skip default parms when resumed in neightbl_dump_info().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Thomas Graf <tgraf@suug.ch>
Content-Type: text/plain; charset="UTF-8"

neightbl_dump_info() calls neightbl_fill_info() in each loop
to render the default parms.

If there are many devices and neightbl_fill_param_info() failed,
neightbl_fill_info() is called again when the dump resumes:

  # ynl --family rt-neigh --dump getneightbl --output-json |
    jq '.[] | {name: .name, ifindex: .parms.ifindex}'
  ...
  {
    "name": "ndisc_cache",
    "ifindex": null
  }
  ...
  {
    "name": "ndisc_cache",
    "ifindex": 6
  }
  {
    "name": "ndisc_cache",
    "ifindex": null
  }
  {
    "name": "ndisc_cache",
    "ifindex": 5
  }

Let's skip neightbl_fill_info() if it is already called in
neightbl_dump_info().

Note that we cannot use !neigh_skip instead of !default_skip
because default_skip == 1 && neigh_skip == 0 could be true
if the first neightbl_fill_param_info() fails.

Fixes: c7fb64db001f ("[NETLINK]: Neighbour table configuration and statistics via rtnetlink")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
Cc: Thomas Graf <tgraf@suug.ch>
---
 net/core/neighbour.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 02bf940ce00a..7448320f7ad5 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2587,9 +2587,10 @@ static int neightbl_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	const struct nlmsghdr *nlh = cb->nlh;
 	struct net *net = sock_net(skb->sk);
+	int default_skip = cb->args[2];
+	int neigh_skip = cb->args[1];
 	int family, tidx, nidx = 0;
 	int tbl_skip = cb->args[0];
-	int neigh_skip = cb->args[1];
 	struct neigh_table *tbl;
 
 	if (cb->strict_check) {
@@ -2613,12 +2614,13 @@ static int neightbl_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 		if (tidx < tbl_skip || (family && tbl->family != family))
 			continue;
 
-		if (neightbl_fill_info(skb, tbl, NETLINK_CB(cb->skb).portid,
+		if (!default_skip &&
+		    neightbl_fill_info(skb, tbl, NETLINK_CB(cb->skb).portid,
 				       nlh->nlmsg_seq, RTM_NEWNEIGHTBL,
 				       NLM_F_MULTI) < 0)
 			break;
 
-		nidx = 0;
+		default_skip = 1;
 
 		list_for_each_entry_rcu(p, &tbl->parms_list, list) {
 			if (!net_eq(neigh_parms_net(p), net))
@@ -2641,12 +2643,15 @@ static int neightbl_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 		}
 
 		neigh_skip = 0;
+		nidx = 0;
+		default_skip = 0;
 	}
 out:
 	rcu_read_unlock();
 
 	cb->args[0] = tidx;
 	cb->args[1] = nidx;
+	cb->args[2] = default_skip;
 
 	return skb->len;
 }
-- 
2.55.0.979.g7e5102b832-goog

