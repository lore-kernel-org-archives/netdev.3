Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CB54457D8
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 08:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788424526; cv=none; b=Z73VfmRLeJmhVjCiIUhRmZ4y5WhfsiiOdOxocp9U2uB/wjd51d+2HGO+84XA+ppLNzNB/boXTVSE20FLQpiyyfJInpl1feYwOuypx9962ixFOPRB1H+v6hBgw9P4sW+owjSd95GkAUe01VYJ2VnXmdolo/5GX/KxQMV+jOzjoW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788424526; c=relaxed/simple;
	bh=/MjYt2ta9mFvbu69n1CKfGpTEP3/Cm6uJX62W/imdDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b7a3FAPay3rtWYkPpsN5D6Q5D1GkTTOqz6Aa2R3XYkiKekKo0Z5/hjFOQda9rbEI5/O0TlT0McePrzkRS9avtucMgF82qiTmzPpUyrOGg78AySclHxT25uzK2/n6myIoHf4qoIv/1dtTibR4MwEifkzZxp/IVeH7wBIIKjLxVd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mISsdnk1; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mISsdnk1"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49b965570d7so19280095e9.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 01:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788424522; x=1789029322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=66m0kEzVw0wUaLA90qEFlh+4kl2dF1iPNWHMpLLgPYk=;
        b=mISsdnk1YY0+ldzoPogWGOc6F4mxcxV64grlq/F0zjzxKJTbPbX88Up4uF2BK09NYY
         P1E12TKBvM7BjsEPlo8cvfnnLsYbjmp/tmZaq00SujVJvmS51ZzdA95hH7qkmImA2nvc
         updZxhje0S5zBgx3aXD1jJJ+zRmzQYdb2Bf7veyevz51UOSC2pwp4/yPyDeUQxbeiE3y
         OJiBgRk3F6fw4XuMIICM4DFX+Zl0E5t8ilfUck9UoZCoFQsA/24KLBDdJlK04zD6OmYg
         DMJB52nS4ILaBfRqny/o/mQ6afFhTd3ThCrFY8NkylSglmR65/qZkxalDaWkjmPnJ/I5
         SOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788424522; x=1789029322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=66m0kEzVw0wUaLA90qEFlh+4kl2dF1iPNWHMpLLgPYk=;
        b=ZI5Jz4GnF+mZPFL151h0ldykb6ITvug9O5LvjrseHNS3AB2kTqbCyiihMVYhRBlesU
         tCiddU7Wu1/55KDUTjmfWp1kX6sJbgGYSLvZfBxPbStYMaS3pihMiwdW60I/BeAcEJOT
         9nIYbENoNXLlInKvEJrNSBiS6DSjeNGl8tzYBi7LR5oVb3GEVXQkf34zATkh58iDio9N
         ppj9qPkEoik5IQsLEPFygy+hWeGpifpvMBUsPVeEHW7AhHBPx9NrgiKodMgyv+tPxVlf
         vPzNx77dwRWAM+DWg0XLiwIn48sTJjMCWpexQJuBX5y6kQFNvSvUoxUcw7Fp08Uve6Lw
         E/Gg==
X-Forwarded-Encrypted: i=1; AKwUvByoMGrzz2jonjXg7a3y1QYxoo5jQoWdoD8AWON+txh2yNo8+urVsMwnci6CAFww4jS3jXbLIkA=@vger.kernel.org
X-Gm-Message-State: AFuF++m3jQPCLv1MssZRrAK06Kh9Y54JlY638JCKKbZo+rF9iX1Yg4O0
	H1OiKW+Vy+kTqD49ZYZMm0JokHr00XXm/ehA7oiGoTw8h1nvoB+x2rYA
X-Gm-Gg: AYBFou0pBr87lFWG8EP5zTS2MbNCm32SXkdXsbLtv7u2OcqpnmNz+qaKlUDCxbejdDm
	THomMU7MVukBz1kUNRXEPLcPmruUvzxYuzcVZYZPv6sWNms1/wiUbNmOrf4RFFHZXVt7zTuTcUs
	WcQMArtQaYBFmuh6prbrzo1S3e8h4GSPmUcYPhkMMeipYdCyMb4mMxnD/m+zjJl1YGpJnbKti3S
	/P29wnM603w+v+N6ZHT4MVIbRTa+7clA/GFrnRmPsrm5jOMRxjYL9P2kjlWEPDJtGnGN4s1gI5r
	iU60951MI6HNm9GbrWgaTGozceWStPkEBgNkTf58A31AhM3kkJVS0evixIigUSt0rGabv23w9vD
	/lntkQ17szPVLTMcnUm+AlyiX0dfiAas3n8KpqMnt/FbjnVb5LBLlrlPDwHBWFI169I6FuAaXpJ
	k4gjww61vDLONhHR4hL72tb2sIjK727yCO/LFafEGFhP1+rLbwrU6dPzmMIZsRqSYezipFQfH17
	tKOhn/iDH24ZZMOX16xboVPnZfmJVVuWmeCJSbhfpnonXsj/1pPCbz7aMaBFA36W7pEHnVbLw0Z
	J5aKgm0VBt+8gh1tJCSlLo65zJHvxqlKvJwkCcpEXnkQi2G4kdjP1xmhfb+SSLq4lTW6aDMnFd3
	je3cF
X-Received: by 2002:a7b:ca42:0:b0:49b:92df:87be with SMTP id 5b1f17b1804b1-49ce55fbdbemr129735745e9.4.1788424521705;
        Thu, 03 Sep 2026 01:35:21 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a979-9501-3df6-d7fa-8a5a-06c5.310.pool.telefonica.de. [2a02:3100:a979:9501:3df6:d7fa:8a5a:6c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce58da3acsm228357425e9.0.2026.09.03.01.35.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Sep 2026 01:35:21 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: stable@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.10.y 1/2] mptcp: pm: ADD_ADDR rtx: always decrease sk refcount
Date: Thu,  3 Sep 2026 10:35:11 +0200
Message-Id: <20260903083512.99864-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260903083512.99864-1-kmehltretter@gmail.com>
References: <20260903083512.99864-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthieu Baerts (NGI0) <matttbe@kernel.org>

[ Upstream commit 9634cb35af17019baec21ca648516ce376fa10e6 ]

When an ADD_ADDR is retransmitted, the sk is held in sk_reset_timer().
It should then be released in all cases at the end.

Some (unlikely) checks were returning directly instead of calling
sock_put() to decrease the refcount. Jump to a new 'exit' label to call
__sock_put() (which will become sock_put() in the next commit) to fix
this potential leak.

While at it, drop the '!msk' check which cannot happen because it is
never reset, and explicitly mark the remaining one as "unlikely".

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260505-net-mptcp-pm-fixes-7-1-rc3-v1-4-fca8091060a4@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Karl Mehltretter: applied to pm_netlink.c; retained v5.10's ID 0 guard
  and routed it through the common refcount drop. ]
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 net/mptcp/pm_netlink.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d4d56f0af3e0a..aee3a8dd9287a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -217,14 +217,11 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 	pr_debug("msk=%p\n", msk);
 
-	if (!msk)
-		return;
-
-	if (inet_sk_state_load(sk) == TCP_CLOSE)
-		return;
+	if (unlikely(inet_sk_state_load(sk) == TCP_CLOSE))
+		goto exit;
 
 	if (!entry->addr.id)
-		return;
+		goto exit;
 
 	bh_lock_sock(sk);
 	if (sock_owned_by_user(sk)) {
@@ -253,6 +250,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 out:
 	bh_unlock_sock(sk);
+exit:
 	__sock_put(sk);
 }
 
-- 
2.53.0

