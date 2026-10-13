Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A284E56E7
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 23:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791935021; cv=none; b=hO2jkDf6bnKKCsS4ejxPV9VPhXJbtlhJAf/SBJSSpHyJIiqf7WVaNrnDcGxk9yQbHPDZftqbXgrvdxiK6P/SHSw6tvR0JBrCGNJT7ZuEaVcxrTQcvQJSI7ZXUp7T7S3J6YsjfIOesxVJsYSvO+pqliFqiJeA2ybqyMak/vAiqXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791935021; c=relaxed/simple;
	bh=z9P6KITTwFMPfaZVuYchO3kdrM+2Gnkfl/U6dQlwDDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbNWqEHrIek6SDwBIGzUTq2YUZ9MNK00m/TuI0dcec0CkMItVAUDnzxR9BR5IQTpcKVghDpNmQPB/8s2CB2bwKqOwlIYayBCgO2a34rTMoqs0hklakFWIMGYpFw+CRUCTFh1O5ztPmbd+vMAYl2NXwhl3ebOZsSfrTnEzx4Lyjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rwJtxEzS; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwJtxEzS"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48c14a06c95so2709206f8f.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 16:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791935018; x=1792539818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z8k7tmHDTDUzhs4EZzTfjEgudqhDgAgf4R6Mi8sm3xc=;
        b=rwJtxEzSQF7nZ9Dzi/ctWftjSD0o+ypE53IEqqTI5kT1aKWx6Ib/ifkxS3f7GbYXbN
         prm/h+ipu+pQAEdqMOt+QaiN0ZMm7SjcbDH/YDcI8ntMrAecty8s8TVD0xpJfChe6hih
         7EtLol9ZUg1HBiK6rd9jO4jSgWvI30Dnboaq71555Yq3Pwnl5NEvp/MtKNJ4RQtoBlqH
         9FjySwBUAni0uXUTr037E2tUTsirlw0tXOhHyNgFwDyEMMRTM29u5buLOBWlreYZXY8L
         W3Iokjkhvsmsl/DZYj2rGRq1O5uQuMhK6ygXY3xdEq58b2REoD+3XL1Ztf8L7BdMeKFr
         E+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791935018; x=1792539818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z8k7tmHDTDUzhs4EZzTfjEgudqhDgAgf4R6Mi8sm3xc=;
        b=SqffDZyztCbxyOxk63CTydfRmADDOLKVOwJDeUuvPMLVIX7neuSlzUFlBIA5sCeNMJ
         Xhk4gjgbkj4AYqLurYp4FsBvXVvhzw6fw7t5ZeHH5n4DevbQuu2pvt43xwh3DzFi6U6/
         O+jsJrG5mpDg8SeKwQ1/xIUtPwAnigEDUsVWknHATpCcJuOd09aLaKPXDtJf3G0eyo+v
         wO2UIjXAcX5q7n0Y+dTRGCJ6q7r8Q96aDaKRe0AQLC89WvHGm2du4AQRHfqD+nrXpQtG
         M+fucoV/8MwuP6uaw1m4S2lnygJHZza0j7GL1hkCntdrksfQNLyBWYGu91MvJsjaL0fC
         yFVA==
X-Forwarded-Encrypted: i=1; AKwUvBwHB4ST26M5VOP2eZjQoDwKHZ6jQsUFBvF2/TqHFkI6oqOoKKpU0wWbynrik3yOQRLfU+aZ3ec=@vger.kernel.org
X-Gm-Message-State: AFq9FYIsfJsXA68Fl7PXcMcx5iUCMOuJ01Hi5ct/hohdVGzDaIVk5GG/
	Rp2BEdbpldq89RKFPS+sP12Q549TUGlgtAsCD6IA6gi6/FGNyIb/KHuclnx7
X-Gm-Gg: AYBFou0yPxCoEageeKBRdRtDbvdviNyTIUhFQxhFCnX0kLrT6StW+XI4ped80jalQNt
	/kUcbxxmCiFUlvltvpgpAumTIf3L6k4R2Zoc1TF0KmZZ32LWotXyQ20az47qS4K6Au/ZO4uw7iu
	LSSdbyzCMrRF05luFart7jJ74FebcB+Pfqm0OY6OOV1czKROYHW79QNXnn+LsN+fwfvtdPiUBUU
	KtV+jgKa1qtIp0JiT2QfcdaZQl8Qq3UeMDzBF/3G9RFCnDNffjTgzkMLKeAPsPOS3q9WB3gpiy9
	T8lDaxyjk4vdgufz+Lq3g33NSCQsvAsHmIyk3Pb5LKppv5h4CB+3jcFmDcqp7benJLLWcOUyzf+
	Ab31Bj8HchdT2wujqTxIDWLfwE3EdpadfklElk1MZ8i2ZsgoVJ2Ouk/+hYeCkrUxms9uR1A/fVJ
	oiNfrPntFxIrJ1yF3AJVqhVx0wF/oFvopGq+zizgQ=
X-Received: by 2002:a05:600c:1906:b0:4a1:71ab:63ba with SMTP id 5b1f17b1804b1-4a18e4e5c87mr276940925e9.29.1791935017948;
        Tue, 13 Oct 2026 16:43:37 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf35930sm390372155e9.13.2026.10.13.16.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 16:43:37 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Cc: Phil Sutter <phil@nwl.cc>,
	Christian Brauner <brauner@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH nf 2/5] netfilter: nft_meta: pin file with get_file_rcu() before reading f_cred
Date: Tue, 13 Oct 2026 23:43:25 +0000
Message-ID: <20261013234329.2797868-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261013234329.2797868-1-tristmd@gmail.com>
References: <20261013234329.2797868-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

Since commit 0ede61d8589cc ("file: convert to SLAB_TYPESAFE_BY_RCU"),
struct file objects can have their slab slot reused while RCU readers
still hold pointers to them. The nft_meta skuid/skgid evaluation reads
file->f_cred to extract fsuid/fsgid without pinning the file. If the
file is freed and the slab slot is reused, the credential data may
belong to a different file.

Use get_file_rcu() to take a reference on the file before accessing its
credentials, and fput() to release it afterward.

Fixes: 0ede61d8589cc ("file: convert to SLAB_TYPESAFE_BY_RCU")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 net/netfilter/nft_meta.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index 01cfbaa365250..069c01a71df16 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -135,19 +135,23 @@ nft_meta_get_eval_skugid(enum nft_meta_keys key,
 			 const struct nft_pktinfo *pkt)
 {
 	const struct sock *sk = skb_to_full_sk(pkt->skb);
-	const struct socket *sock;
-	const struct file *file;
+	struct socket *sock;
+	struct file *file;
 
 	if (!sk || !sk_fullsock(sk) || !net_eq(nft_net(pkt), sock_net(sk)))
 		return false;
 
-	/* The sk pointer remains valid as long as the skb is. The sk_socket and
-	 * file pointer may become NULL if the socket is closed. Both structures
-	 * (including file->cred) are RCU freed which means they can be accessed
-	 * within a RCU read section.
+	/* The sk pointer remains valid as long as the skb is. The
+	 * sk_socket and file pointer may become NULL if the socket is
+	 * closed. Since struct file uses SLAB_TYPESAFE_BY_RCU, pin the
+	 * file with get_file_rcu() to ensure f_cred is not from a
+	 * reused slab slot.
 	 */
 	sock = READ_ONCE(sk->sk_socket);
-	file = sock ? READ_ONCE(sock->file) : NULL;
+	if (sock)
+		file = get_file_rcu(&sock->file);
+	else
+		file = NULL;
 	if (!file)
 		return false;
 
@@ -164,6 +168,7 @@ nft_meta_get_eval_skugid(enum nft_meta_keys key,
 		break;
 	}
 
+	fput(file);
 	return true;
 }
 
-- 
2.47.3

