Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5F84156C6
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 19:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788808918; cv=none; b=JT/hrMo85bZUiw7yUxhQipMQ2CiJMGl3XIz534zDrqpO1EMMr0uCHcrya1iBiRz28UtqBt2gbZs/7tlAlaxniqdJtLqD3R5o1ToeFJup/PVxMCms4W7R4d2Rlln3MetYFuvUQH1a3L62Haqafptprf+ndDHXHRYHlZFXjIKOUoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788808918; c=relaxed/simple;
	bh=oCdgMeY+A+gVCl9ZVenKNuNHWGlSLN1BAkOFY7nJ9FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/Eb26y9jZppiYM9Xj96CvKAIA32+T98dtjE3zHEoxX6Nc9iM85hYfSZrhZJbvHu3HJh/1XDrnKYrqPHp6bn3rRaJwUVPUYUS1UvQJbq5jhPx44Yky6EjAPOgzk6BjdUbFDw84ezrfa0w6U5Ut3zGtywfGEgHw6z1fBUfrRah2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=XH5NtxKu; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="XH5NtxKu"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8726acc5eadso25888887b3.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 12:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788808915; x=1789413715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AYtUHypHM6jlkHJd700jNxu0HmiM6jK8Bx9hrtnd7tI=;
        b=XH5NtxKucDs9UJKHZyevK6JdHg6UH3NcfSwTd7VJZfoEL8nqst38XUf1Jw4rJoPyrc
         tSxg7X/1NhR0kl0dhxevaUepw/Av901JviUg1IB9AV39+5814jW8WSUSYjVntl2zJpPX
         D2MgzIoXBAdvIXDEY9OcSebRRKDQx675/o8/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788808915; x=1789413715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AYtUHypHM6jlkHJd700jNxu0HmiM6jK8Bx9hrtnd7tI=;
        b=X0OFQ24S5UQaP77JNvUe/jD4OqKLaJkajp7roEKW6o/4ue2crUX+QCG/bZGfp5AuO4
         jHlzJRRvTdxqGvQX8EfBwqeRbYEKM4kCdmuS4XQxGTDR8VUkNDuWFkJ4x9lAqkL+MH5b
         uBJ9Lyj0jbpOLz4Ibx8m5d76YXOsscP48hOUJynz1gkuPT9aJ2maI8YCFDZ6/UczkWYK
         zO/608uk7OJ16lp1iE/4PFEuCJ49zBEg8nHigdpZs4HPaPv753DUhrwEsc+przSWCSXl
         h3p21iRcjS1JAGmPsHFwaJEu/Ntu7fquA/LH8Faq5EohvTg+Tqrx4SGU+9RSMXFtWTzq
         I8yw==
X-Forwarded-Encrypted: i=1; AKwUvBw3CqLO5Gs+7Dp7tMPvokntSeir8EqbSc3gqvfjma821BqA3BMMG5BcZ5kzi0Z/eRUcjrk+kgk=@vger.kernel.org
X-Gm-Message-State: AFuF++nFcZzWKgXttxo9huy6KIrDI/l8ipsyl0CLyS0NYn1uiE5+jmZQ
	Tla/rdpL1132u6oS12giWfe3ZYPTrc6Y/7CB9/1uW/l6XCJUIgnfE4jHnft7yp2AtQ==
X-Gm-Gg: AYBFou0RXLmWk1vDb3OaX8F1it8M/SG+2Jsuh728yqXWX6s7yLvDLJNVtWj9mhvxvmx
	0KJ1smzMwZJaYt2CUobLQtEojF6YWQKyM+yVSrvbpO1Gr7qFUQ/lYSvKnAplmluWFo6gttJzmln
	3Rax1FHchrh+jqN4xUXuq+tHqp6iFzzDWOkHaPZU7WKi+EVxbhMUFMlkkaGPa5teE1QNuCOSkyP
	RP5088JQDM51Pf2qMmvlriUTynrbGzoTdEdwCPSDhu//p5aBPxhimREYDTW1nN7LCvl9cU5V+7h
	bVauAOqpsqu83+Qznyrvo3AXvXamdukbRwImoJyuFBkJ+9t7r0TMecPyg9EDokaxZjcddxP13Lj
	u/kW3Kku8LjkO1Syf5xYhz6LyLYIZVC66SxZs7tbqpLjHnk4y+dzqATSsFuH/KO8emY63WuIBmy
	yhdokCbI1+kWCrdJzfugEvUFOKmXmcyBWiNLGYc+CpyxkH9tGcs8H8Xg==
X-Received: by 2002:a05:690c:60c7:b0:81e:6bd6:39a5 with SMTP id 00721157ae682-87124c7bda5mr96789167b3.1.1788808910799;
        Mon, 07 Sep 2026 12:21:50 -0700 (PDT)
Received: from exu-caveira ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714b62bc77sm76546097b3.39.2026.09.07.12.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 12:21:50 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us
Cc: horms@kernel.org,
	vega@nebusec.ai,
	netdev@vger.kernel.org
Subject: [PATCH net v2 3/4] net/sched: cls_route: Fix in-place replace
Date: Mon,  7 Sep 2026 16:21:32 -0300
Message-ID: <20260907192133.2639067-4-victor@mojatatu.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907192133.2639067-1-victor@mojatatu.com>
References: <20260907192133.2639067-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Building on the previous patch, route4_set_parms rejects a duplicate by
scanning the destination chain for nhandle, but the scan doesn't exclude
the older version it is replacing, so an in-place replace will match
the older version's handle and fail.

Fix this by passing the older filter as a parameter to route4_set_parms
(replacing "new") and skipping it in the scan.

Excluding the older version is not enough on its own. nhandle is built
out of TCA_ROUTE4_TO, TCA_ROUTE4_FROM and TCA_ROUTE4_IIF alone, while the
0x7F00 bits, which only tell apart filters sharing one key, are folded in
on the create path. Letting the replace through would therefore rename
the filter it replaces: replacing handle 0x10101 stored it back as
0x10001, and a sibling at 0x10201 could then no longer be replaced at
all, since its own nhandle collided with the renamed filter.

	tc filter add ... handle 0x10101 route from 1 to 1 classid 1:1
	tc filter add ... handle 0x10201 route from 1 to 1 classid 1:2
	tc filter replace ... handle 0x10101 route from 1 to 1 classid 1:9
	... fh 0x00010001 flowid 1:9 to 1 from 1
	... fh 0x00010201 flowid 1:2 to 1 from 1
	tc filter replace ... handle 0x10201 route from 1 to 1 classid 1:8
	Error: Handle 10001 is already in use.

So carry those bits over when the key the request builds is the key the
older filter already has. An in-place replace then keeps the handle
userspace named the filter by, while a request that does change the key
still renames it, as it did before.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260829205422.854785-1-victor%40mojatatu.com
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/cls_route.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
index 9710b77d379c..0f211f030fd9 100644
--- a/net/sched/cls_route.c
+++ b/net/sched/cls_route.c
@@ -393,8 +393,9 @@ static const struct nla_policy route4_policy[TCA_ROUTE4_MAX + 1] = {
 static int route4_set_parms(struct net *net, struct tcf_proto *tp,
 			    unsigned long base, struct route4_filter *f,
 			    u32 handle, struct route4_head *head,
-			    struct nlattr **tb, struct nlattr *est, int new,
-			    u32 flags, struct netlink_ext_ack *extack)
+			    struct nlattr **tb, struct nlattr *est,
+			    struct route4_filter *fold, u32 flags,
+			    struct netlink_ext_ack *extack)
 {
 	u32 id = 0, to = 0, nhandle = 0x8000;
 	struct route4_filter *fp;
@@ -407,7 +408,7 @@ static int route4_set_parms(struct net *net, struct tcf_proto *tp,
 		return err;
 
 	if (tb[TCA_ROUTE4_TO]) {
-		if (new && handle & 0x8000) {
+		if (!fold && handle & 0x8000) {
 			NL_SET_ERR_MSG(extack, "Invalid handle");
 			return -EINVAL;
 		}
@@ -430,14 +431,14 @@ static int route4_set_parms(struct net *net, struct tcf_proto *tp,
 	} else
 		nhandle |= 0xFFFF << 16;
 
-	if (handle && new) {
+	if (handle && (!fold || nhandle == (handle & ~0x7F00)))
 		nhandle |= handle & 0x7F00;
-		if (nhandle != handle) {
-			NL_SET_ERR_MSG_FMT(extack,
-					   "Handle mismatch constructed: %x (expected: %x)",
-					   handle, nhandle);
-			return -EINVAL;
-		}
+
+	if (handle && !fold && nhandle != handle) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "Handle mismatch constructed: %x (expected: %x)",
+				   handle, nhandle);
+		return -EINVAL;
 	}
 
 	if (!nhandle) {
@@ -460,7 +461,7 @@ static int route4_set_parms(struct net *net, struct tcf_proto *tp,
 		for (fp = rtnl_dereference(b->ht[h2]);
 		     fp;
 		     fp = rtnl_dereference(fp->next))
-			if (fp->handle == nhandle) {
+			if (fp != fold && fp->handle == nhandle) {
 				NL_SET_ERR_MSG_FMT(extack,
 						   "Handle %x is already in use",
 						   nhandle);
@@ -502,7 +503,6 @@ static int route4_change(struct net *net, struct sk_buff *in_skb,
 	struct nlattr *tb[TCA_ROUTE4_MAX + 1];
 	unsigned int h;
 	int err;
-	bool new = true;
 
 	if (!handle) {
 		NL_SET_ERR_MSG(extack, "Creating with handle of 0 is invalid");
@@ -539,11 +539,10 @@ static int route4_change(struct net *net, struct sk_buff *in_skb,
 
 		f->tp = fold->tp;
 		f->bkt = fold->bkt;
-		new = false;
 	}
 
 	err = route4_set_parms(net, tp, base, f, handle, head, tb,
-			       tca[TCA_RATE], new, flags, extack);
+			       tca[TCA_RATE], fold, flags, extack);
 	if (err < 0)
 		goto errout;
 
-- 
2.55.0

