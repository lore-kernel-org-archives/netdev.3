Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E84372ED5
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 20:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786565596; cv=none; b=cfVOsp17kWatHrSi5r4RGHL241IyZuJtTs+mhD4SgwMbkxLdPJ4Y6xomB96SdOAXcWej8TPG1G42TzLiuSsyi/HgbKkh2rbY6bSZtUo9KiNZQifQ9OlKSLbhDo+UtyLE4FXQXEStpi1ax3Ok56SS6//XEs1LIlB8TX7oPEklHHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786565596; c=relaxed/simple;
	bh=atcv5mB75yvrhGDP+UBiVutUbuMq+/hDkVgOZSQoEek=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qvg8ftrSmCLsCltMPvOJIWRtCPPZBGo4xs0Sd56GTVvSoeLmH6Vdmg3yv76jBaL2UTAoXp+gWlOvpdv7BmLQTm2qFBtMPvoUoLYtct81iaU+Gk2Nhlf5QQB+UWnRwQkjdrb3T3fhMq8CLTlQohggskqRmwBOyWHalyaild/q07k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eW92Cw9n; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eW92Cw9n"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38101f85591so271705a91.1
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 13:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786565594; x=1787170394; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=50/tctT413AwEP9BINIhVKAqs22RAZ6gO6ugPDW/HS8=;
        b=eW92Cw9nLdvHulM6dGRHLmuNX/tgrppuXfrPzYBvHpRnCeq2UQ/sq4B9WRyE+SnM/e
         mILtn8GDVKqK3GoVFp55EJR3D02ptDDwVQcVF5lt2FQtkApNQqFABf6PJ5/vNJNPMjrL
         d04+zDbEAF/VZYSTE9cqzjNtRt8HQKvEme/YrRDXHHnm6O8ZqWO4cB185vJZq7//+FK1
         FUTtiR/Afwx1SZlfWrA+ajKpDtHSxCgeecDpUjPZg7Ol8XP1ZKHqA+3ivIkryoMsFe58
         CIyQ/YVc8BM6mbYvMOtxJyg0G4PPnPtT9Gl7aKXrO4a4BDlTmPZrlyCU44D4YflDzGWv
         E7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786565594; x=1787170394;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=50/tctT413AwEP9BINIhVKAqs22RAZ6gO6ugPDW/HS8=;
        b=plJLu+2gufaOfh4CMe7NM+8TWqsOnh5mL5o4KKdgCsTAR1nkpZybWG/3rYuja67q9h
         SjkSVapKfTeeQGIRnO8Bx+e6V/yOmuLJlwh1aJ2iMx3fiRRPx16HLBN3fq6rYocDV2Nb
         721e7mx0elOXQW9QMzBTcIuzLoebqUfpNeq6T2YvaJ00a/yD87Ox0aPm6n920cVnImnv
         YFeFJFpkuFv9p3qdYKAsqy2QEcQiMip4foPgTUKDdck3BP6Rgx6GrkUlk4XVQICoR848
         Px0fAb3cBRYNZ5sJNL9iHa4dsMKSKy3DdVR/qu+1jA7jM1KWznDICowTZp6hP/cYmivt
         dHZw==
X-Forwarded-Encrypted: i=1; AHgh+RquzRygS4Yr1l/eWjT6QbzoRTRMyMC9/pou947Iqc/Lc4DGfZJ4L5W0SBK5NVIdoz6uhFSka0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyT+8TFaI4BETnflFFLYjR/ZzcdiS/8KxHwIkLahHj4ys85HVO
	T0DR0NteQK4TVbYecQqnHIsscfHpSQTIJkhv7cY2EymBuleHdQ/CfBxu
X-Gm-Gg: AR+sD10qP3g7uAmcqIhhHJr+S54nBcYMaejsv7YARW1pdTd9xoWwV9aRI3oTAKbWH+S
	csnrNS1Vt8mqZe1c2hCjJEcLHaV5eqjXaiSozVe2d7/okypcYJu3CM9A+O8GYexOP+3ek9L8NzY
	2WvA+xHa0hkKPbyO+Gy87yLoJrq28jRj3GFlkT1wBEcerWP5loJKq/SoCt226RbN0ESlvtE99AK
	UvcV1Er0X6ywU8OWHkPqGI7kqt2AHUhiVramdSGcyrm19elWJH/1yw/Mp9f/6UHf8TdZqOoH8pl
	pLbx1mW50ePkulqgFjDn6oxVm9tS7VBTkHTFP7HoQJV4jRr+/5ZPLvvUgVZrDHEMjO0kqyOWlTZ
	SaCdigxsHSMj3Q9ngVqpfLkx55qVFPeM/Q/BDj4cRoPYCqlVsWkh09VCBty35lrVeHT0EVrTQVU
	BL/WwOD2gZpGMI8BShb7ObPTmqkcoX+LKdcuz2d00mnoB/TAWeuPZlUpm8S1C/aawc391jEJtZi
	YGPu+cg
X-Received: by 2002:a17:90b:35d2:b0:38f:1a29:7a82 with SMTP id 98e67ed59e1d1-3931f89bb03mr72845a91.6.1786565593913;
        Wed, 12 Aug 2026 13:13:13 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931f44dcbbsm183267a91.16.2026.08.12.13.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 13:13:13 -0700 (PDT)
Date: Thu, 13 Aug 2026 05:13:09 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, mhal@rbox.co,
	leonardi@redhat.com, bobbyeshleman@meta.com, stefanha@redhat.com,
	mst@redhat.com
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
	imv4bel@gmail.com
Subject: [PATCH net] vsock: do not reset a socket in connect() once it has
 connected
Message-ID: <anzT1fREOSyHT99k@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

commit 002541ef650b ("vsock: Ignore signal/timeout on connect() if
already established") stopped connect() from resetting an established
socket. The check only looks at whether sk_state is TCP_ESTABLISHED at
that moment, and the state can change while connect() sleeps.

A peer RST moves the socket to TCP_CLOSING, and it is not removed from
vsock_connected_table on that path. connect() then wakes up, fails the
check, and resets a socket that had actually connected to TCP_CLOSE and
SS_UNCONNECTED.

The socket can now be connected again while it is still on the table.
Reconnecting to an address served by a different transport makes
vsock_assign_transport() drop the transport from a live socket and free
vsk->trans, even if skbs it already sent are still in flight.
Reconnecting to the same address inserts a node that is already on the
table, provided shutdown() has cleared SOCK_DONE in between.

sock->state cannot be used for the check either. shutdown() overwrites
SS_CONNECTED with SS_DISCONNECTING.

Record on the socket that the connection completed, and check that
instead. The sk_err path after the loop does the same reset, so guard it
as well.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 include/net/af_vsock.h   |  2 ++
 net/vmw_vsock/af_vsock.c | 12 ++++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 30046a3c20f735..d7ec976ed6e272 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -63,6 +63,8 @@ struct vsock_sock {
 	struct delayed_work pending_work;
 	struct delayed_work close_work;
 	bool close_work_scheduled;
+	/* Set once the connection completed; never cleared. */
+	bool ever_connected;
 	u32 peer_shutdown;
 	bool sent_request;
 	bool ignore_connecting_rst;
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 622dbd04679944..735c91bb762242 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -351,6 +351,8 @@ void vsock_insert_connected(struct vsock_sock *vsk)
 	struct list_head *list = vsock_connected_sockets(
 		&vsk->remote_addr, &vsk->local_addr);
 
+	vsk->ever_connected = true;
+
 	spin_lock_bh(&vsock_table_lock);
 	__vsock_insert_connected(list, vsk);
 	spin_unlock_bh(&vsock_table_lock);
@@ -1814,14 +1816,14 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 		 * Note that allowing to "reset" an already established socket
 		 * here is racy and insecure.
 		 */
-		if (sk->sk_state == TCP_ESTABLISHED)
+		if (vsk->ever_connected)
 			break;
 
 		/* If connection was _not_ established and a signal/timeout came
 		 * to be, we want the socket's state reset. User space may want
 		 * to retry.
 		 *
-		 * sk_state != TCP_ESTABLISHED implies that socket is not on
+		 * !ever_connected implies that socket is not on
 		 * vsock_connected_table. We keep the binding and the transport
 		 * assigned.
 		 */
@@ -1849,8 +1851,10 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 
 	if (sk->sk_err) {
 		err = -sk->sk_err;
-		sk->sk_state = TCP_CLOSE;
-		sock->state = SS_UNCONNECTED;
+		if (!vsk->ever_connected) {
+			sk->sk_state = TCP_CLOSE;
+			sock->state = SS_UNCONNECTED;
+		}
 	} else {
 		err = 0;
 	}
-- 
2.43.0

