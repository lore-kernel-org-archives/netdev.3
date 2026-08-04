Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3253F12C6
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 06:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785823843; cv=none; b=MU3uo5JMoo2ggxliErV+FDYeFY2hBJzGz7k3uB5YmVK4lav05TaO0GU37i4IC9v0/wyK17GzKc6SuI4yFVVI//1QIolMIQ/t6YGAZC1EbiTaiMQOWOo106qlGL7jwZZyDdOEEdtal/OWcS6EeKdHE58DJk0cfXFJ9thb4LnJT/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785823843; c=relaxed/simple;
	bh=2ssuQ+04nuLTDZGNqzMTsPtwevqZk/aT3YoTKb0B1Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IIWg4XNhlfN6GCmYIeMZDBkX4ce4fOlhiq6eXCUrrh7YP9sPt9SaIwTCW/DuZU1+AusOOrKKdTt/keb7X2bAWf6Nq1TVHVZt8UzclW3fl9FKZ0vOHeypI3SR6MtzuD/uXQlvYiUdNq2G65khbAtSIhQnnNFbACkT+s2lM6TxgwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=AZXORupP; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="AZXORupP"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e5b048375so204956785a.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 23:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1785823839; x=1786428639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2xu34PAC/Hx6+EVv4uPY0+/AxgtysgEZZSu+zkxMA6E=;
        b=AZXORupPXEyW5UejGOB/TBTu9UB61VS2/mol9se+DJP7mOUzR7oqCkDiTh93sjEQFG
         f68nRRihEJLXmmvrGCf998NYVwA6HJj3eHEd57dBKETkJAbFYE6NNDqPIlYXx3/ZUrbS
         x550maXC+Zd2SNAF4omT1gJLNymP7N3pFPNONQJzitbaGZrW7DBX8GpO+YxjgKHxALiH
         nvH7fFEY/yh2AuRBgpQtO+UnvaBUjBTi+S5pKAkGKIXe64e+QsmnnTjaMCh4reRKm64e
         84jMhEVSS2VE57Nnhqwb6vc4tCq+uViwbWkLJeSX5hh4bMK2cWmYEX7WnqqMjcd6gmpl
         P+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785823839; x=1786428639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2xu34PAC/Hx6+EVv4uPY0+/AxgtysgEZZSu+zkxMA6E=;
        b=UigEzfLCcSUIKy6B/SdjQ7pgS25OXXcQH0wppkyO9fzzXMCJ/SJwVcTuiddSusNV28
         nY6u3JozkI2rsSHJEjiYj4nI1geU8e4cZcF2U3pE7GgnNYdhvc9X6ex/QmHoC+fO2JT/
         9r8e37ula4FOBr/NieoEJNhNL/I9A3K3zO0i4SMP0bexuJvl6i6YvQEmhSNv1SZmSM/t
         jBEoZIhd51PktqWpBOhIOcSptrb8yXTAjkfBwHFyJPvIU2U2MFE3tGETosIe9tINMNl7
         d+IKULNcMbEm8bo8X1M4YsuzKASnQHP/XLp22pUvZ5DLUGJ4lnthKrmeSlSfqadJqPqE
         Xy7g==
X-Forwarded-Encrypted: i=1; AHgh+Roe5GpSlTp7CUBZ6+IGwBQ9mkHBvkGl15g28ibKAhGNWmVGv4kfpasD4x/kJJMsEkP/qRlSOyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPAhVRPd4/QKMBdfTGqkNLNSv1x3U4Zpy06+sALfhdYWJfQWCZ
	l9jJMcuoI4ejv85znC1izC3FmVH0QuwQckBPzCvVMpRQxObVMrY6+/uI60aF9alvImA=
X-Gm-Gg: AR+sD12nErVpaUuGRapT2OxwZRV+mU7pNQpTHnLHDvWgU+tpnvoibG4uK8CvqsjoE0Y
	w1pB5Oa5f04Yi8aPpYIE78uE/7tAbMjEnIohwRnU+9Dm2BUk8yjVswyonvFAmKF+fENnfYDcUBv
	Y1HdodvUQmpeKRQc9kciiLsJePDQThJ+oO8OcTcHNk8sVdXOvv3pQ4umLeW1JvY2bqflb6WwLR7
	/91Ux9nw78Fja9BqkjnbdloeF85yahJZfZM6oNxXPXwRdbWYEzbBJ4y4cyJUe7YiIXoCTFdGCg4
	4ZhWRqyH8Rc4Ifjn9HcW304mc9/bq/XrMJbRrHv97HKh5Q5hpIPQxffigHEVXlguCozkEW34zZD
	Gmn0uLOhwW6aGxbQfUC/T+dxtHKWRtGL8SRhboDu8ULRZ06L/zHt4EJ196lcn+RGWlkFH1qELGC
	CPKkFw77tKjz7WorW5ioaBmJXHuO1IasQY4zXNR0cH5YfBpZtBvQA0+U272CrWzp/L7g==
X-Received: by 2002:a05:620a:890a:b0:92e:eeb6:b879 with SMTP id af79cd13be357-934a0aa8aa1mr2755397885a.41.1785823839294;
        Mon, 03 Aug 2026 23:10:39 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-936418ae7b9sm3848785a.28.2026.08.03.23.10.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 23:10:39 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Kyle Zeng <kylebot@openai.com>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	Sven Eckelmann <sven@narfation.org>,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Lee <david.lee@trailofbits.com>
Subject: [PATCH ipsec v2] xfrm: fix compat ALLOCSPI request use-after-free
Date: Tue,  4 Aug 2026 06:10:37 +0000
Message-ID: <20260804061038.711373-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

xfrm_state_netlink() builds the ALLOCSPI response with
dump_one_state(), which already calls alloc_compat() with the response
skb and header.

xfrm_alloc_userspi() then calls alloc_compat() again, but passes the
original request skb and its header. For a compat request, the
translator therefore interprets the 228-byte compat xfrm_userspi_info
as the 232-byte native layout and reads four bytes past the declared
payload. It also publishes the translated child through the request's
frag_list.

A multicast clone of the request shares skb_shared_info and can observe
that child. xfrm_user_rcv_msg() frees it after the request handler
returns, racing a compat receiver which may still be copying from it and
resulting in a use-after-free.

Remove the redundant conversion. The response keeps its correct compat
translation from dump_one_state(), and no child is attached to the
inbound request.

Fixes: 5f3eea6b7e8f ("xfrm/compat: Attach xfrm dumps to 64=>32 bit translator")
Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Co-developed-by: David Lee <david.lee@trailofbits.com>
Signed-off-by: David Lee <david.lee@trailofbits.com>
---
Changes in v2:
- Add the ipsec tree prefix to the subject.
- Restore Kyle Zeng as the patch author and correct the sign-off chain.
- Move the research credit below the commit-message separator.

v1: https://lore.kernel.org/netdev/20260731140658.566571-1-david.lee@trailofbits.com/

Bug found and triaged by OpenAI Security Research and
validated by Trail of Bits.

Trail of Bits has a reproducer for this bug that triggers a
KASAN use-after-free and can share if needed.

 net/xfrm/xfrm_user.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index d6db63304ba6bd5bbd9c09c665170936e1107ced..a7f35a123648d3946aae88674c7bead5666c9eb3 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1877,7 +1877,6 @@ static int xfrm_alloc_userspi(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct net *net = sock_net(skb->sk);
 	struct xfrm_state *x;
 	struct xfrm_userspi_info *p;
-	struct xfrm_translator *xtr;
 	struct sk_buff *resp_skb;
 	xfrm_address_t *daddr;
 	int family;
@@ -1943,17 +1942,6 @@ static int xfrm_alloc_userspi(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto out;
 	}
 
-	xtr = xfrm_get_translator();
-	if (xtr) {
-		err = xtr->alloc_compat(skb, nlmsg_hdr(skb));
-
-		xfrm_put_translator(xtr);
-		if (err) {
-			kfree_skb(resp_skb);
-			goto out;
-		}
-	}
-
 	err = nlmsg_unicast(xfrm_net_nlsk(net, skb), resp_skb, NETLINK_CB(skb).portid);
 
 out:
-- 
2.53.0
