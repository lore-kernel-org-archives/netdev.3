Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B040C285060
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 01:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787104144; cv=none; b=OpGnOcl/fBF4uSrReoOKfGzKCFRIw2aolAb3gxqbFNlylHgiok87qJkjKA3gaM7cghWmSjkxpK6k/ec+IgZPh/Ykjtd89VHcJ/uHGA8I3DzU3BRYLm84wUf0AI/JM66Kn0DgPL/dRn4vHCZPg+swpzjkpJlEv0tSv5ECmMpeZXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787104144; c=relaxed/simple;
	bh=EfZl991DxxzWp4Vdk3Ifm5w4z88KDCHFkedFl7PFTwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mwt/qffm4AUzKfC8qf4k2/XZzmcYvrbVZh5vnjtQRU+Dyb0njqAP+QXHXVQe3z9bvF74RhIh4Fk8ncT0FhfUdGiZ4NpGPAZAZWJ+Bx1+uZzK5VrFC5ifoAXv/OvB3RXzyUv4nBMuFkG9IPQbVQIGUB5Gly9xIQmFiSdvs3mgyvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aj2MAtwT; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aj2MAtwT"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-836cbcd0a48so8492207b3.1
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 18:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787104141; x=1787708941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YXD//4YNkkxyIkb6wqjP8t3iz79+20/kYGvfIfnI6Gc=;
        b=Aj2MAtwTN8tMTKyWUupZGg9jEl+DuSJp85C7ZeZYBvWrv2/oqji05ihTfmrj2RwCyp
         JMmB+UT7agrnapQfLuA9Mk+pu684nx5+rZ1tD7iCf8M1T/fissxsbDGkjIK6JJ3CSeFG
         NWxoDHMk9FRw19CWnF++pqa6cY239ap0Gk4rEMXAxSl97CClcY3SORZJs7x7eDbWbqx6
         XLGxcqrLnJ8ViRfdVmzm5wkjTt429RVJBFoi6jQhgtsm6iFye54dZzuZ/EnodJpOs81w
         sT959huldoJGZJlBl6d9ELFkH43CbdrrlqFsrmLfujy9rfMdaExocSp3FrBb6fXYbiHH
         fthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787104141; x=1787708941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YXD//4YNkkxyIkb6wqjP8t3iz79+20/kYGvfIfnI6Gc=;
        b=WtA44qnZaC+NfSjV4n3h8Y4mw6pSKAbfrMcLb25pkzx565kEy7eVd5VOVB5r1FDCVx
         YDfyfs1hx9LKYUIHeRYIWuM6sP8rgDApoWbV2XenImO7lSvpudfd6kj+XddGXMhNnN7O
         uPTClIHVbUQvpPT1vjqClrUXNDvSVVN7rne3Y3Nk+t/uCB46Jl4xhTtdUxMlp2MCYUwE
         HE32ND/IRBBVDepOtFgpWE3FxMFdmPiKE7xk5MIzlunbKxrC5dCJ+no8M9Xm//6G+xuA
         9cIHVPma5+ZQnFAhLFOYquBMEtgEaI4W4SLz4RGHttm/mVbq3wjhQreBw7RaqPGIJJFI
         xO6g==
X-Forwarded-Encrypted: i=1; AHgh+RqhzjZvN905PA2feya+n3X+jtCR24NSzlv+OBxMD6UkFf2r9q7zJ/12SZq9OewMk0Oi7hmGTkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+HRlDiWyi5XvF42ojyuHWl86fFWGbcv0kNFVbGlGUozdRHUrz
	bFKVLmSvEmX4dKvfST3gb25F/gmopoc4oSLwJ7ju0oBU6DBAk+0u7rZX
X-Gm-Gg: AR+sD10NLXOdU2pF/E7h072nFh1ceXiECCy+nPbroyWWGTQfpf6fsF6CcQCGGV0AFlo
	YytiviunoENYPeelA8XQs3H4pszMkdDBT0nW1bG64Swb83I99k49+afmK7k5EJ7t/cMABAy6dYb
	E6s/5Oiaka5A9SXZ/rIYiEbZN77wtTvmZHXNIRgq/DKRYeSF59U0JJf/a0hF4is4rfDlZj2hzcc
	1VW2ZYXiPmFYLYlQ/wZ7SaTLUMO8P6oU7cjY+0LJz72DNQH5sG36KLfJLfiwhWaQA2YUd0jPiyp
	NFFHMtdGDTjTuCVjXkR9N2wvy/wC67suCv8lUXuOZFpln43pfKiU+6NYicDqIVlSuPwYphpBvDJ
	oYgx3vEL2nggcVaqPHHXWl3nONRkVnXsul5+sKno7FnBrFYfDpSuJsI+v+Z/eNegA/rczt80ycY
	pXPd4q8KcpA+UuwvTBOS9ISOOTZefIgP4G1ecRiTLA4GwJkulxiC090Cb758WVklM+Lq7s
X-Received: by 2002:a05:690c:e20f:20b0:81e:98d3:cac7 with SMTP id 00721157ae682-844de3bc1ccmr6528037b3.12.1787104141356;
        Tue, 18 Aug 2026 18:49:01 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8451275df9fsm1975047b3.14.2026.08.18.18.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 18:49:00 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: pablo@netfilter.org,
	laforge@gnumonks.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	xmei5@asu.edu,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com
Subject: [PATCH] gtp: add synchronize_net() in gtp_newlink() error path to prevent use-after-free
Date: Tue, 18 Aug 2026 21:48:58 -0400
Message-ID: <20260819014858.76707-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gtp_newlink()'s error path frees tid_hash and addr_hash without
waiting for an RCU grace period after clearing sk_user_data. A
concurrent gtp_encap_recv() in softirq may still hold the gtp_dev
pointer obtained via rcu_dereference_sk_user_data() and access the
freed memory.

  BUG: KASAN: slab-use-after-free in gtp0_pdp_find+0x1f6/0x200 (gtp.c:152)
  Call Trace:
   <IRQ>
   gtp0_pdp_find+0x1f6/0x200
   gtp_encap_recv+0x527/0x24b0
   udp_queue_rcv_one_skb+0x75f/0xc10

Add synchronize_net() before the kfree calls in out_hashtable, which
covers all error paths from both gtp_encap_enable() and
gtp_create_sockets().

Fixes: 459aa660eb1d8ce6 ("gtp: add initial driver for datapath of GPRS Tunneling Protocol (GTP-U)")
Reported-by: AutonomousCodeSecurity@microsoft.com
Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
Reported-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
 drivers/net/gtp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 9a12cc53da00..f11bcc0c0ac4 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1543,6 +1543,8 @@ static int gtp_newlink(struct net_device *dev,
 out_encap:
 	gtp_encap_disable(gtp);
 out_hashtable:
+	/* Wait for RCU readers that may still reference this gtp_dev. */
+	synchronize_net();
 	kfree(gtp->addr_hash);
 	kfree(gtp->tid_hash);
 	return err;
-- 
2.52.0

