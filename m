Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793291730;
	b=GjIaQQwjkJREqvr5XQ3T9OFHnuUmJ103g4PG6LjZ9eQrGP9z4Kvo/G04YrmxYWzOO45A
	 GT9BZvoK8bN+NkhFIQ07z1ejXHwvBcrvMtiVI5UqXSrySkcVlNkFDGWnjjKrXpHR8+oti
	 M2/cC2w3sGX7B40D8kEO1kDudq9pL1wTXg1JzYSXmMje5e01UeA8fbPuTuMYxx5TrkoF1
	 V/J/1JOTyCrDWaQDPpW9E/56Monc3o1hDTOO0gdaUqF1Mdn6KKikVCOCMv/haqHr0Fk3b
	 dkWx2QGR4pl70KAR/yU8wLt/+k1J+P6nqDZq3fKVZldlJ4FKeJ2/QaSceYwhhFbUhmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793291730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LjpmfPa02oFewXlsIf8j68q6+knr6ZZYk1Rx2rngfoc=;
	b=173DvX24qZ+H3ONRdLQXtLq5BUvCBJ5UuHJ7oBM2CXbBepj+E+F+aY0szJchD9Q42T0A
	 vOahSSvJjLHEeluRjXlh7uk6tI8O5Rh4YTUwGWychZz7WHk2ky4qdhZc9VbM9UnkPKmp1
	 I4ysDe0TGQSI88G8jMU8ONkY+G5bIogP+rTbwljM2NN8gdlMCzkZG4Xal9lgJgv9DRXpw
	 NwS6AanLoVU68OqjbiVsQGceLMa3lvq/h33jUmK9S6cdBYiUAQJrg7RZgtRYFp2qHBvM3
	 NoluZvcJg2fzn8jfUYio8TDSE2fg9BVyen52IL0i7n5w6c4ZowFQb2mSYKCFtqJNmew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a+HrVonC;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6598606A31D
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 16:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6598606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a+HrVonC
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3550c917fd3so3311964eec.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 09:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793291729; x=1793896529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LjpmfPa02oFewXlsIf8j68q6+knr6ZZYk1Rx2rngfoc=;
        b=a+HrVonC+ueltPtJX/RKfwzScxcTZsAOlTxYT6UHflrSCP1NyNoO608Z9cAAmJ4MKJ
         3iJQc7XG7LEWHVTphTHdhRKs86nCQP9iu4f4JEYSC1rNVaPvnt3TcdVWLK0qrwZpQkY+
         i/kR5dw2uW9UIq9DBKZyypbpUo3BBj726Lueo011Jn8dxajGWG3YsJeV0od1tVekZLdS
         qTB1w08YCDsugrAAOxwi2kMPpxHWGzrJZxeQ6D11aVGh7vLNOBrgGPfbtbehX9bDSuTN
         U0aTLeC289yZgfShVodZcXDybakZasyKqGeMjvDlwPMKj5YV6KFKgAhRqDyMqZL3wq+d
         SHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793291729; x=1793896529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LjpmfPa02oFewXlsIf8j68q6+knr6ZZYk1Rx2rngfoc=;
        b=O/2gPL0kWWqiRLgy8mDsshzMNQ4pN2qBynJY5x+2uOrwbHNUKihAhNcMYDCDZIo//a
         QmrJjdjmKiwf4xO6saA13xbwcpuR3dqLr/gxi+ekvBiH+EoY0C6VrdLSx1U2LHrRIBVH
         GC+mYKgdn5Geg0D+bTbJ/Lnf/BoD1jPtrllDlFnrISVlmY+7rZ8Ri8d/Vxd0+gpNLXr3
         IsH/1H2m008J7y1RiQq1yM8AoxMO0PEBf/D+wpSw4bd/rWnMRE28RuTlqdXw7G6pnadM
         /G0Bzinca7kTG2SdmU3l6Ndhdo4QgUeTWTv6tq7nzHXbTCbpz9VFBfqzMvvw1Q/PEZYk
         PCcQ==
X-Forwarded-Encrypted: i=1; AKwUvBwd821+WqojrGY3xEPEwwVsqab/a/aak7zNLJgVJ4VxRp/dcr2fEz8wpnRVo0LWjo1hcZ5vFiU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLy29AKNlq98SolJEA0/lYtGUlfFtL9RmCI9kSHToOS+zYSByDR
	jb/it33LVQCclq7+iScluve1NQnZFCWORnOkuFJDmtgN/0CZRaIPsVOR
X-Gm-Gg: AYBFou3JyD7cczz99DDaqPhSCp4hDZZkydLEy5yR2Tn9zOWJRuUAxbX5GbDsCNrGKRw
	pDD8Rg5jSiAtw/7aCLsXb8Gsg2j+j5hMNedxxa5XMwhiiGY3jBYIgnXq30QiwKxZYibo24rQnKQ
	rJLBzhYTRoz9y4smYT63dEEZGMysCbjJ0SwfhdmtSluh9E4u34wuP1p1e8ypzaMOHZqxuC578kv
	/tccSpTEH1/w+NX450RccmauZnL2/frjhlHLMDVjobQLwE/8GWYjMIopmDHTUXutMA4SOpZx+1B
	bVe8GJge9gm9zZcjmCaHy73KsNdsVJvwMoJEWGwoP5Hc8qG6hlJp8sdshfxs6e0rMs4YcwlWVqB
	YRC4E20bl8eiO/41mlnf44LKPnsbFy2qkk0h2gRPhfxc2za9qFtI+X59o8dVD0eSLg4y8Qe1oFd
	k5HYd8+15KuYj6vnGpA28PnQb882zC9yD8UGyfOIhTIV7p+1YhrNZq666WdPN07UM2FH7tTfD4h
	6gEwiOxNw/VnsV473K1YrI9waCCWlc9OFRPmyR9Wv9kj2x+ficrOnLpNzo628NhLc9qxgxvLriN
	1zIhiWZY+5m+hDtrtmJS7wr+ozvyQVg/ejy7jgFnXpxbsoo7
X-Received: by 2002:a05:693c:2510:b0:34b:4b99:24ab with SMTP id 5a478bee46e88-36a203d426amr7788717eec.22.1793291728260;
        Thu, 29 Oct 2026 09:35:28 -0700 (PDT)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a40fff7d9sm302071eec.6.2026.10.29.09.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 09:35:27 -0700 (PDT)
From: hyunjungg <hj351016@gmail.com>
To: jhs@mojatatu.com,
	jiri@resnulli.us
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net/sched: em_ipt: reject hook values >= NF_INET_NUMHOOKS
Date: Fri, 30 Oct 2026 01:35:16 +0900
Message-ID: <20261029163516.2476127-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Hyunjung Ko <hj351016@gmail.com>

em_ipt_change() reads the TCA_EM_IPT_HOOK netlink attribute into im->hook
as an unbounded u32, and check_match() later uses it as a shift amount:

	im->hook = nla_get_u32(tb[TCA_EM_IPT_HOOK]);
	...
	mtpar.hook_mask = 1 << im->hook;

TCA_EM_IPT_HOOK has no nla_policy range (it is a bare NLA_U32), and the
only range check on the hook lives in policy_validate_match_data(), which
rejects hook != NF_INET_PRE_ROUTING. That validator runs only for the
"policy" match; the "addrtype" match added by commit 0c4231c784b4 ("net:
sched: em_ipt: add support for addrtype matching") has its own validator
which does not look at the hook at all. A filter using match_name
"addrtype" can therefore carry an arbitrary hook value.

For hook >= 32 the "1 << im->hook" in check_match() is a shift that is
out of range for the 32-bit int, i.e. undefined behaviour; im->hook is
also passed unchecked to nf_hook_state_init() on the match path. Valid
hooks are only NF_INET_PRE_ROUTING..NF_INET_POST_ROUTING, so reject
anything >= NF_INET_NUMHOOKS when the attribute is parsed.

Reproduced on v7.3-rc3 (CONFIG_UBSAN=y) by adding a "basic" classifier
carrying an em_ipt "addrtype" ematch (match revision 1, nfproto AF_INET)
with TCA_EM_IPT_HOOK = 32:

  UBSAN: shift-out-of-bounds in net/sched/em_ipt.c:52:17
  shift exponent 32 is too large for 32-bit type 'int'

It requires CAP_NET_ADMIN (a tc filter add in a netns the caller controls).

Fixes: 0c4231c784b4 ("net: sched: em_ipt: add support for addrtype matching")
Cc: stable@vger.kernel.org # v5.3+
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 net/sched/em_ipt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/sched/em_ipt.c b/net/sched/em_ipt.c
index 3650117da47f..c16469fb3e92 100644
--- a/net/sched/em_ipt.c
+++ b/net/sched/em_ipt.c
@@ -165,6 +165,11 @@ static int em_ipt_change(struct net *net, void *data, int data_len,
 
 	im->match = match;
 	im->hook = nla_get_u32(tb[TCA_EM_IPT_HOOK]);
+	if (im->hook >= NF_INET_NUMHOOKS) {
+		ret = -EINVAL;
+		goto err;
+	}
+
 	im->nfproto = nfproto;
 	nla_memcpy(im->match_data, tb[TCA_EM_IPT_MATCH_DATA], mdata_len);
 
-- 
2.43.0

