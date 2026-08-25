Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBC23B4EAF
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 18:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787684004; cv=none; b=ftmMpJ+Yr+U5eNTcPtWTtx5EYarFArUvbPyD7Vjwgq58cttgRya/xCyo3gdogxQEvD90BGeTK48JVawUnECBZZFVArKpsiocRZz62B3Px9zvE7MpjPHQDFuZFxKk0oVJeWTYOrxdDp6F9TmP10tEBRvAyGqjtbwAyuyz9XWfCTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787684004; c=relaxed/simple;
	bh=aAVBYmWDKzQyPtJpDqMLmrUli+6U4NVx+Ps/DKCFp8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KThWb+zjoS3Hw1zOavaohy8dxq/XXXNeD1pa3BAFAVQxFXxXDd5hKLGVFMWLJijJr2WwNCq3gY+21lBSZpgb8POVSqBJ/oGtv1Wcz4gc7rj9mBlkCD/qSTisuhI5HGlvvTg/xg0k+HqgWnDXGo39klg2zBSnNIZuCbNZhx/BhB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bhg9cjde; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bhg9cjde"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-660a40aac63so24066d50.0
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 11:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787684001; x=1788288801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BaPeOY/TuEwXg+e5P1fM+g796mk8OMGlmSwtQME1M38=;
        b=Bhg9cjde7Lmj/KOep6QpRzBVgqLw3dn9wo3esE7CkgT3i0h9tNg3dvxZSCuOnwl5pi
         Gh6mqbGR/4QFCqYyL2ioipbcmAOy/HuOWqa3H6eudcfLME83dlqDGy4e6rTlACdpfIjt
         6HVFTcjERW/o3siKF6WJPls9f1Ci9tXn+A+JegyLuIkeBqQXELLSTf+k4X6apBg2bqHu
         1xO4Mb4C/SMK8TXcwtgnRhqpKbOZdPB5Spc5QdWr83ZGJHXcnJbpLrm4r6u0IrNxF9pm
         ybPFQLLybtgOQ+oltAbDpqgQ8dLlD8T+Up4UqRChUKSblqwnbVHr4zpRNgcTaDz5EpMh
         yZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787684001; x=1788288801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BaPeOY/TuEwXg+e5P1fM+g796mk8OMGlmSwtQME1M38=;
        b=ftt5SYQrTKAn+YbdrZ2rt83E9iID2/Kf5nEi430sIt07xvPh1M88mXmbgwOaL6vU7q
         mxuyptGCrWMjhNuySifZN/jr5ZsVxVa6gyd1v7xgD3DIFf/9WpW7A/r4e/9wDYa1Wkp6
         xfvg5ahZTIsgem02JPbWjo6/jd4Sp1xNYTBsOrJz5rnHKK9q4Ll1o3KJf9KaRwMqx+ip
         qoCi6qGn9igfHm6h8Y6wdp6D6gCSronkSz/ePXHctzwbPbuLnkV3LH/vPhjxc78ibMwi
         zvCEts4CjSbCiMgh46Z0gdjgkEyCc2h9wW0GyfjFYM+bAyfpKyW6eoVWYlNqlfVcHiAZ
         3oFQ==
X-Gm-Message-State: AFuF++mRlyiAi3LYOweuhv5zlVHfufNHFcQuFdH5f5mOwV2GvS90GcTS
	Xm8PbQvg7axvquoknR/vsNfKBe+dKXdqNbVZV6UsEomv9K1oWz2Dfl6A
X-Gm-Gg: AR+sD11SJbnbSoHZCQHsf3TYUEBvjBJyXjza5yu+DEKMaa24SCbZWxi/k0+ZcEJfcek
	P86PAKo0ZTED1ry1bsBfMr6e70JUch3SY23QndyCHw7OdeknX/OQHe8B9mYRqKSyrFHD14cEEWB
	gbsiIfpU6Qupq17mjR5Oc3gq73COOJ3MFBBIZZwMkOCqffTvsTQDVGyDtutaW4+qVIlCU2LfNHf
	8jH3yzXMemz1adK0iQjTKBtfAtKtsTAspSjK4SkzkTGO+qWIDtSXk+7tqFTKGNYRKLQOGKcLXWt
	AwNjbVxfWlXz5iEcaM9Gjd0qWGKEKLUO98cRrXXDPIvI0vcjZ+g3rv1xOi18Cs3JAT7J9pggkVq
	6kY6Y/azD4r1r53EtJpDDxzri3tWeteU1eIiSmKkwA5hPe8RT3JQe0zr7XrWCfh38LfLVuaKJdp
	TwNuNUykRe1Q1e0/U8SJS4/+wgUigzAo7qslOXIEMvjnqtIJBiHR0PT1Mm5OkRceMWRVPOLz6eh
	C3YK9bd5ep3CW0HnmdmKbsy88zHBLdhmeeINo6TwU7v3Bg9WnqksI9yK6UdL+OLWaUz4Q==
X-Received: by 2002:a05:690e:488f:10b0:668:25a5:d4b0 with SMTP id 956f58d0204a3-66d255192a1mr316064d50.0.1787684000422;
        Tue, 25 Aug 2026 11:53:20 -0700 (PDT)
Received: from localhost.localdomain (45.78.64.189.16clouds.com. [45.78.64.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66d247487c6sm382013d50.15.2026.08.25.11.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 11:53:20 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>
Subject: [PATCH net-next] net: pktgen: return bool from __pktgen_NN_threads()
Date: Wed, 26 Aug 2026 02:53:13 +0800
Message-ID: <20260825185313.239861-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824152331.216494-1-nicoyip.dev@gmail.com>
References: <20260824152331.216494-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Callers of __pktgen_NN_threads() only check whether a pktgen_dev was
found. After the RCU lookup they never dereference the returned
pointer, so returning it past rcu_read_unlock() is confusing.

Return bool instead and keep the pktgen_dev pointer local to the
RCU critical section.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
This is a net-next follow-up to
https://lore.kernel.org/netdev/20260824152331.216494-1-nicoyip.dev@gmail.com/

 net/core/pktgen.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 4fb1853589b3..9985b30c5a42 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -2024,11 +2024,11 @@ static const struct proc_ops pktgen_thread_proc_ops = {
 };
 
 /* Think find or remove for NN */
-static struct pktgen_dev *__pktgen_NN_threads(const struct pktgen_net *pn,
-					      const char *ifname, int remove)
+static bool __pktgen_NN_threads(const struct pktgen_net *pn,
+				const char *ifname, int remove)
 {
 	struct pktgen_thread *t;
-	struct pktgen_dev *pkt_dev = NULL;
+	struct pktgen_dev *pkt_dev;
 	bool exact = (remove == FIND);
 
 	list_for_each_entry(t, &pn->pktgen_threads, th_list) {
@@ -2042,9 +2042,9 @@ static struct pktgen_dev *__pktgen_NN_threads(const struct pktgen_net *pn,
 		}
 		rcu_read_unlock();
 		if (pkt_dev)
-			break;
+			return true;
 	}
-	return pkt_dev;
+	return false;
 }
 
 /*
@@ -2052,7 +2052,6 @@ static struct pktgen_dev *__pktgen_NN_threads(const struct pktgen_net *pn,
  */
 static void pktgen_mark_device(const struct pktgen_net *pn, const char *ifname)
 {
-	struct pktgen_dev *pkt_dev = NULL;
 	const int max_tries = 10, msec_per_try = 125;
 	int i = 0;
 
@@ -2061,8 +2060,7 @@ static void pktgen_mark_device(const struct pktgen_net *pn, const char *ifname)
 
 	while (1) {
 
-		pkt_dev = __pktgen_NN_threads(pn, ifname, REMOVE);
-		if (pkt_dev == NULL)
+		if (!__pktgen_NN_threads(pn, ifname, REMOVE))
 			break;	/* success */
 
 		mutex_unlock(&pktgen_thread_lock);
@@ -3836,8 +3834,7 @@ static int pktgen_add_device(struct pktgen_thread *t, const char *ifname)
 
 	/* We don't allow a device to be on several threads */
 
-	pkt_dev = __pktgen_NN_threads(t->net, ifname, FIND);
-	if (pkt_dev) {
+	if (__pktgen_NN_threads(t->net, ifname, FIND)) {
 		pr_err("ERROR: interface already used\n");
 		return -EBUSY;
 	}
-- 
2.43.0

