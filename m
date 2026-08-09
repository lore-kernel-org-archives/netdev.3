Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E083C1D77
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786268580; cv=none; b=GkLriAmZG4bEOfZMGtFqQN8XtmbxRX3zeopU6vdO9tc2u1kJu5/PmiK6XnxA4McSGh2ottaCkbuE8AsYS2+kFf0sKUZW3RuNAVwJbnN3PC3bX9LcZdzom1yB6HvwWCxoGvdmOk0JwTRXIATyXqqsCaP4Qe77/KI+xRbKrILLJgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786268580; c=relaxed/simple;
	bh=YFtlLngdvCDKxznwW0KFwwqo5LsMIr5V1JdUsdpWzWk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NlwYCsaGC8fsa3ldc7EEqu7Wm7AAUV0P0ZEhW4W4rJ1/zkTMKQTDkc0GJ+j+nWf3nOzxcMSDn4i4AMVFq/LHSXiIsi3vm4YeJknYaANrp8Az0R3hihZmWTf9nRnH/fRPNFkzWyFPrU0GfdHbmVtDgA1lMc8aITIWBOy2RcnNU6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pb18o9tR; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pb18o9tR"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9eefcf9175so814547a12.3
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 02:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786268579; x=1786873379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5vhVP2gwsOdEitAqeBQ2V+u61oT/f5wQ296ftm0EiMs=;
        b=pb18o9tRybnkrPGAam/bPg6Z/2VTapgxIxyPUN+VKxNzFvlAAmzp0RtYNwFqajuL+b
         AMJ3cI1ruaWkw5gYMYJGMLGeGG38EBbNMnHQvMe0wnjrBRhlTOVPTbtzVAs2PQh70lR1
         s7DoXqbGannCnObLjsS9b/JySF0kkEjWrFIl+pGA+f0McenqTquGWs6PRWFchvP1xm1K
         jTYPKjYEWCcoGJy5UxmWfAqsIjvq8LJZtngQIPncTAp3s5OMaSIQLU1/zZ8DO23YtJ1o
         n2gv0G58YHUNwmW3VRZTlWo99kjSVsgJhg2RO+D9W1HljiReYU5jR7FdckpdrQbABaF/
         JyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786268579; x=1786873379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5vhVP2gwsOdEitAqeBQ2V+u61oT/f5wQ296ftm0EiMs=;
        b=BCX5Mvk/TJBNr9rVUmrAkHEfAtDch19ZVnh74shI7+i6zL/eIOS072KX6vfNcY6WV5
         v9wqnC57A6ITjT6TCTMbVj5fmbNcMjzpxdqrgvOvrSS+KSp9Enhmz7KhhQHv/EnHOTv6
         FyRbyZCAm0TOmOhAxzDuTeCJMceowVjo7R+9BU7c8nh2foCkbDlI8A6rV/Z4ZugT87v9
         fnaPbr2sn0DfvX8rw9qYt0qtDh2oW5EpJox6PHq3bXjevIfOGds4j5GrtakEM/GVIp6E
         gDvzkEJX4dRIjbiLKSfNTW3wW+PzKeaFxjooP6NUtykWAA+FQJAzc1CzlR0gDsmfjtca
         dkAA==
X-Forwarded-Encrypted: i=1; AHgh+Ro8chcuZxPO3WRp/Z9UMzMr4dGib2IIrWFZjIUNEwuK3A0yK/6EX9ga7tAOD4Q3alxowjT4jzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7lEi7eGhSciS68gMNMG1y9U8WO2YKfwlfMuSBuaEtIBLfpguO
	BmQ1ECWVkrVtP4J9v+q77kAKuPCoVOV/bVAlbYaGwdwvinqNal2AVB2F
X-Gm-Gg: AR+sD12Aua+BbIAyPE/b7FP0EylMvvzvYObPozMueELtsA4sCJ+7PBTqvNjfREE+UUW
	F7a63Jy8/iX6MYrtvXSJ8+ddEpNWVLML6hMhaDs8kK6btZR3gdweE4eTrt5rBKQFVbtXBIdqry6
	eohDXUSDjZini+g8UU3TJe+2/tjf/NBcvqcEoUEVTDPPnvkfrorOMeWkbXOc3PAZVcVpkW8Pbuk
	3sfEYsjxf0QKxqOCKHxkGv64Z7goML0mRtpSdF4F6zNMzKPs4Zmb6cT/nF+Z+ZrWA+RX2YJobkY
	BFj7tLGl38+VsA/lFvdu1/ojZ/5RT0BwcmJoWLDrjP/y+iKBflGpNOSzNleA/v6dkJ07zvekTFF
	a1/2e6Dr09mTxhtzSRP5O6b60OBwqZl34mMEuNbRRxgW7vKKpwhfioO+iPTIm9uRRIMvjvsr3JX
	Bnr9hqUY/xHZ67KqlAu8lxEpnh5LUft1iPzUG0D6tvUawQzmjlUpkVNqH1e+ziut9mk0QFGbQIL
	GmBun7EuOhFPg==
X-Received: by 2002:a05:6a21:6f17:b0:3c3:724d:ae7a with SMTP id adf61e73a8af0-3cbc0175426mr21235402637.9.1786268578350;
        Sun, 09 Aug 2026 02:42:58 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be8d60f4sm29364303eec.13.2026.08.09.02.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 02:42:57 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: James Chapman <jchapman@katalix.com>,
	Tom Parkin <tparkin@katalix.com>,
	Guillaume Nault <gnault@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] l2tp: send netlink notifications in the tunnel's net namespace
Date: Sun,  9 Aug 2026 17:42:52 +0800
Message-Id: <20260809094252.2107242-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2tp_tunnel_notify() and l2tp_session_notify() use
genlmsg_multicast_allns(), which delivers to listeners in every network
namespace. l2tp is per-namespace, and a tunnel records the namespace it
belongs to in tunnel->l2tp_net. Each event concerns one namespace, yet
every namespace is told about it. A tunnel event carries the tunnel and
peer tunnel ids, plus the socket's addresses with both ports for a UDP
tunnel. A session event carries the session and peer session ids, the
interface name, plus the L2TP cookies where those are set. A listener
needs no privilege for any of this, because l2tp_multicast_group[]
carries no flags and genl_bind() asks for no capability.

The fix is to send to the tunnel's namespace with
genlmsg_multicast_netns(). Commit 134e63756d5f ("genetlink: make netns
aware") added both helpers and drew the line between them. The netns
variant is for an object that lives in a namespace.

I found this by auditing the tree's six genlmsg_multicast_allns() call
sites for objects that live in a network namespace. Only the two l2tp
ones do.

I reproduced it on net at dd057113ac7b, in a virtual machine, with no
real hardware involved. A process in the initial namespace, running as
an ordinary user with an empty capability set, receives the create and
delete events of a tunnel. The tunnel was set up inside an unprivileged
user and network namespace. tools/testing/selftests/net/l2tp.sh passes
before and after.

On a container host, any local user and every other tenant can read a
tenant's tunnel parameters.

Fixes: 33f72e6f0c67 ("l2tp : multicast notification to the registered listeners")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 net/l2tp/l2tp_netlink.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/l2tp/l2tp_netlink.c b/net/l2tp/l2tp_netlink.c
index 59457c0c14aab..c0c4d1ebc7a3e 100644
--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -116,7 +116,8 @@ static int l2tp_tunnel_notify(struct genl_family *family,
 				  NLM_F_ACK, tunnel, cmd);
 
 	if (ret >= 0) {
-		ret = genlmsg_multicast_allns(family, msg, 0, 0);
+		ret = genlmsg_multicast_netns(family, tunnel->l2tp_net, msg,
+					      0, 0, GFP_KERNEL);
 		/* We don't care if no one is listening */
 		if (ret == -ESRCH)
 			ret = 0;
@@ -144,7 +145,9 @@ static int l2tp_session_notify(struct genl_family *family,
 				   NLM_F_ACK, session, cmd);
 
 	if (ret >= 0) {
-		ret = genlmsg_multicast_allns(family, msg, 0, 0);
+		ret = genlmsg_multicast_netns(family,
+					      session->tunnel->l2tp_net, msg,
+					      0, 0, GFP_KERNEL);
 		/* We don't care if no one is listening */
 		if (ret == -ESRCH)
 			ret = 0;
