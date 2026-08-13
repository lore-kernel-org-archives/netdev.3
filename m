Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55C538BF8D
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786642536; cv=none; b=PekCnDpb2S82t4dZYH2HR1RKKS6tRUBOZYVEbiOCA3EearLxLvYSaYkL9Q1qyXCj2ItcReLJ9UbhGRZC9hOdVkVWvz8/YDEgxcrsWP0wJKFeAJ37piRQe2HcJUTa0NyrFu4HAOO9W/a7/yr/GybKKyrb8zqScvBnSApaFKeHULo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786642536; c=relaxed/simple;
	bh=SDL1BOncGMiI4twGaAB7fz5vw+QNk2TwVXGWgpM5z5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M4H+DnybRERWFWigJ+qGE3rBLOp2KCZvzeT4mBPuCfZbvddJ+aylR5mBIMTCeodk1rirG4ohCN4yfXh1rHUPsJHMZ+2Jg+Vljg1424QdksXaJ2v2fOhOTdywI4BNAkIHmqUEHNO9gBsBnqfokzsAwyPnyAs4AalkY0EzlsHe8oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=f3QFUs5M; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="f3QFUs5M"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cc97653887so3668475ad.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 10:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786642535; x=1787247335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IiVPGOxJZE1G0Xem2Ig7DqOWCAoYKMvo5rpVz8uJBjA=;
        b=f3QFUs5MnWzy3dLSvbDjL8+OC4c2BN2+TZLRHxjNKhPHaS4CzJC4WiC6cFayJOyQ+W
         wq+Aiy15rq4R7RWRU96KXfPrP44pxSswbFMMM6Lc/UfgQuyZB1439u5Qn9fAQoRcZqYT
         TA1lfCvUxHDTohkXKdJcoHQ/Dr3u/zFWFD6bZjvaDERUwx1RnZBqk/O1Fcp1gWll7iV7
         17RzR7lsLTJDiKcwH9NfUKKkibvGxYiT7UvElw6K3kSp6xB8VOJyIM75FM9/ix1NRO+6
         nddHmPl1s74qaJGAC4O9aSji/Nj2o1ke61V23xvOPsvrY2LZJmufbVmhXue9bS8fadgq
         kflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786642535; x=1787247335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IiVPGOxJZE1G0Xem2Ig7DqOWCAoYKMvo5rpVz8uJBjA=;
        b=nGV/jlJIO/OB2IgZBgDeWwDWBqnvfR6Nc/vFG+3caRQYpO0giYcXi/9Fr9iKfVivX7
         9Hs2lApPjkFCi8cvJqWEVtCFBtUnjo0MHyAj3G0f+CXkhiHKpzd5Y9lLkUq1JdBQwX6c
         HDtkmQAlWSFGBDMDB1EoSL54J9e0Qco4Hi3v9qBwUaW/JNO1ZR6sisoZQ+tLJraNFAkU
         uSRldbhaFUuPvIy4wu+VIwFtVB7CDMVWsqZ7MJWp4ePNXDt0hHyl+11qpWaf4f4z2CrR
         bXuPezZ+92FWL6aKTGBddxLVjQNB7bdrQWk9HzN3Hq6raVD9iAS9TZ0xX69yrR4K1us7
         J8ew==
X-Gm-Message-State: AOJu0YxUPum/F2liTDaKSraxICgRMOXIz2N2fyGs9puGegSumi2NZDgv
	mfsrqAUU6F+nE388aHgGwFH9+be6MJE2UT9asgycVR1GbDG7tMwHD+RhYVnJ6TuoCZWukDFvuLI
	Sn4iMt0rY
X-Gm-Gg: AR+sD11VoJGcrCOTadRQArOfm9aVNbNGHZN0dBLn3/Yk8jAOUAClVxGuN9xQRAnkWl2
	2YIo3PTYHU3srFD2ZT4XClRaWXsA86E/4yKrZuRTlIryNqHMC+iD+h0s78l7SHapibusOd0shAB
	rKE8Ca31Zqyas6io7lQlPGnhOJ5QGYyzACq3tRtFCgwPJ3n+Vj8OnJdd2/3UaNV9SSZllKWftuk
	DN2DDm768GBmE8lxFHOkXEjmOzVaGMFEk+56wij6CECsO8c8EIm98lQ/CUcTf3TlwEG7mxqJDWt
	pdB/dg8C0OFNuhIbR+TEktRRz8tuwVHYlZcIsEFi7FPkeetq7WmCYNRpA2AJgBP42RYMSI29R75
	pPwpZbDxhp1Af4oGe1/0O5PAfF19DkIa32ja0FfpDvLA0w1seG3kEfbmlU3ZnlqShaoHCadmCPl
	/ZZMz5JRTytTSgbHuJSrwHYs3YYRCnLJVGiQIrub8MlXHZaEa8yxmOLdnMZJBk+PpX6qxd3NfZJ
	S1QbppSFA==
X-Received: by 2002:a17:90b:28ce:b0:38f:23d6:b4a9 with SMTP id 98e67ed59e1d1-3931e345ab1mr9378721a91.21.1786642534695;
        Thu, 13 Aug 2026 10:35:34 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39339eca063sm204504a91.1.2026.08.13.10.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 10:35:34 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	edragain@163.com,
	weir@nebusec.ai
Subject: [PATCH net v2 1/1] ipv4: reject undersized MTUs in ip_do_fragment()
Date: Fri, 14 Aug 2026 01:35:26 +0800
Message-ID: <8809ef6314b98913681b0b370a05a85c2b6cd579.1786599079.git.edragain@163.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1786599079.git.edragain@163.com>
References: <cover.1786599079.git.edragain@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yong Wang <edragain@163.com>

ip_do_fragment() subtracts the IPv4 header length from the effective
MTU and passes the resulting payload MTU to ip_frag_next().

If the effective MTU is smaller than hlen + 8, ip_frag_next() rounds
the fragment payload length down to zero. The fragmentation state then
never makes forward progress: state->left, state->ptr and state->offset
stay unchanged while ip_do_fragment() keeps allocating and transmitting
header-only fragments until the softlockup detector fires.

This is reproducible with a route installed using "mtu lock 20", but it
is also reproducible without route MTU lock, for example by forwarding a
packet to a device whose MTU is 20.

Fix it in ip_do_fragment() by rejecting mtu < hlen + 8 with -EMSGSIZE,
matching the existing IPv6 fragmentation check.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Yong Wang <edragain@163.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 net/ipv4/ip_output.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index e6dd1e5b8c32..74e095b6b7ca 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -790,6 +790,10 @@ int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	 */
 
 	hlen = iph->ihl * 4;
+	if (mtu < hlen + 8) {
+		err = -EMSGSIZE;
+		goto fail;
+	}
 	mtu = mtu - hlen;	/* Size of data space */
 	IPCB(skb)->flags |= IPSKB_FRAG_COMPLETE;
 	ll_rs = LL_RESERVED_SPACE(rt->dst.dev);
-- 
2.53.0
