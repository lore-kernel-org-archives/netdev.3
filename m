Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8BE353A82
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 21:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789853799; cv=none; b=tsX8ZmRtvvK4Ln1k4lJhwCvBuFKS5Wh2r2T3HwCG6l947Ubplmqcedcq1sBU/wLJsQnTw5pOvUmYafayr27rWN2TxoRGdRumx1M1UkUr8CqY902XPCF5wk6dp9S51LS+RkeQcfBYxZ5R6DM7MVHfhWbQ+belQDOwqdQTMoSiH8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789853799; c=relaxed/simple;
	bh=bMfllS2RYCeR0IwhWUFdoERnpYtUYbtX7V1i9njrQ8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E97UwEis9vCAquri/pmo7teB7mWi2FucYSjic38dSA7h3lDY84khZM2nTo9yI88AWpZ1EhFGZjWbfwRufHHbT6erf55CV/8kpuwKxj5ivPuHjVF54Ua5o+LDhixgFs6KsjE3MrmDv84Kf5525wWU0sFdR7DshLETvfSnW91fpdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmH4vtmS; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmH4vtmS"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2caced6038eso15900085ad.0
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 14:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789853793; x=1790458593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mNEBb3BmdvWSvN0iF1avI37h7OoCf9PVvmj/ZWnj+vc=;
        b=BmH4vtmSPsAH0K7IGsnjNo8agE9ilFK8RDfx71IOBlqTsMByFBTaAvwd/PqeAnIvGn
         c4JGlujpkIOz9yCjjZQj1a4t0Z1Z1TcyNKRkZbZrZLzXK9tlN/q7pGLH6nDm426ZdiFo
         mhnZLW+JVVDLbjaYfdEHLyJ8DrYbeiVmDmDFtUFdOzvt6QvSzU9/YgCE1ZJUYz/r8Wnd
         MTrt//ce74GRD6sQSYTGp3/LBv/GaTqt5ZRLJbKyl+6BoYK/Er41VFkGoUX6u7L3Pv9u
         Ar9wJA6NzvMUITc0T83NmdkXSuOpfEGifzhdcVvaeoiiHZ1W37RZ9nmr91Tx7UrkX53T
         yZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789853793; x=1790458593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mNEBb3BmdvWSvN0iF1avI37h7OoCf9PVvmj/ZWnj+vc=;
        b=m2+YIG7vD02hKq3HzjLAtkzybDdBlHCxzsMwVBHrm5M/+qXbZUYC9m3qR2JWixfXli
         kjBBA2v+5gK8221KeGCl80vH5HXXfiFE6wQFHNPkDV0gEnKDXkkyUwl1v4cQbFFie1a/
         4jqJUCoo5tu+Y85VlZYCA1xbclBG3g2lQnVwJokQNwvMlLTwelfA12bOPRY4kpMMz0B9
         97axPBBAJedJMzahx9NNMRvAYgUH+KbfLLvt0do/VqveVyqp0Uqio/dRig+QNH1g4sm+
         MgRxqMYP00ttaWWMACLKu4W8GBro2u1veOdUxQ2T8qRhyU2wKCC62eOHCjm5Ed1lr75y
         J8hg==
X-Gm-Message-State: AFuF++kvw9EW7Higp+HeELOP9XQ22c5XL/XEzVr0sH4SraXICRMtAUD9
	JPPA6GOf2tT3QDfDL1mDzcHDDvopJbvfKeRXm1Sa90LvV8iEzgUXvcgi
X-Gm-Gg: AYBFou0IwATlw1zuLk2nNARVU9eumYvX1xiiUMCzDfnP6HXxI7fnVVF3R5IY64qU62G
	ni0PAVWjq84f6kriXc7EqNVoB+8cebwNcvGrGnV+L4xciUaCd4c3jOJPieirJu2V4hgFZ/hwzqO
	HxwLtE5SIBoZbcyIUCiIZXlLC9rb1PTW0KwYeFnqYVewZEgTIs4QXRnYA9VD1U9Jbq1AWMQBWe/
	E+uaKN0uGVu/eiiB6Ua6NRKt6o81plfg7mEEbvEaghfp97wikOH98y3jex/kweJ3s43tlXM6SHs
	rz6o+5l1FJUQozeq9zqssxPhLTP5EoqjOOPb77ik21odIVSQNMZuuII2902+lsYXTC6HNYqzQJU
	QjEwXUS1By8SXHbEDn86uOvkkdhti8FXvgYyPqDAMx+A2RWksd3htVNUz5/h9GEGWud4TW7PHlX
	HWgn39ywlBHuO1GQwah02+Vreu0b2ALFX+CxoKbJrrcrA52bzk00fOGrZsEKqYLBbfvdh7fg/qm
	ZtsDMmwDdg5qZQrmcwMM11t3aXsV2SYrn2WjDFGktGQYoRGCLoMTUFHcTMEx6XezWiSaqWsqVbx
	6DgDKQIl9sdPUzoP2tih
X-Received: by 2002:a17:903:1a4e:b0:2d8:d4d2:d13a with SMTP id d9443c01a7336-2dd9ca3f373mr130521785ad.22.1789853792359;
        Sat, 19 Sep 2026 14:36:32 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc17a04afsm12964215ad.42.2026.09.19.14.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:36:32 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net/tcp: check rnext_key for NULL in tcp_ao_prepare_reset()
Date: Sat, 19 Sep 2026 21:36:30 +0000
Message-ID: <20260919213630.3313360-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In `tcp_ao_prepare_reset()`, when an active reset is sent on a TCP-AO
socket (when `skb` is NULL, such as `tcp_send_active_reset()` during
`tcp_disconnect()`), `rnext_key` is read via
`READ_ONCE(ao_info->rnext_key)` and immediately dereferenced at
`rnext_key->rcvid` without checking whether `rnext_key` is NULL.

When a TCP-AO socket uses `TCP_FASTOPEN_CONNECT` (or disconnects before
a peer `rnext_key` is selected), `ao_info->rnext_key` can be NULL while
`ao_info->current_key` is set, causing a kernel NULL pointer dereference
in `tcp_ao_prepare_reset()`.

Return `-ENOENT` if `rnext_key` is NULL in `tcp_ao_prepare_reset()`.

Fixes: 06b22ef29591 ("net/tcp: Wire TCP-AO to request sockets")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>

---
 net/ipv4/tcp_ao.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index bb7bbc20ba3f..18aca0dd5252 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -857,6 +857,8 @@ int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
 			return -ENOENT;
 		*traffic_key = snd_other_key(*key);
 		rnext_key = READ_ONCE(ao_info->rnext_key);
+		if (!rnext_key)
+			return -ENOENT;
 		*keyid = rnext_key->rcvid;
 		*sne = tcp_ao_compute_sne(READ_ONCE(ao_info->snd_sne),
 					  snd_basis, seq);
-- 
2.55.0.1082.g2b9226bbc0-goog

