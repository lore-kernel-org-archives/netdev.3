Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794364364;
	b=a25a5kMA/sDudYMoTzc84vZL7HBmImaMhM/06SRVJQTqQfBxt65JHN3aLne1PVbb6I5s
	 iBY8BJdPODmm2ZbMAr1PLN5o7abaoVUSXEW5W8OyGSLIhbR97wKrgtOp8AtaYQCq/bHr9
	 qM1cu+mLcdSfcnjxsSq+K4fyRUepyJVYvRuVRifzsVPpljnlgx5KVRY6XL+0We4MZkefk
	 5NUJGYyZs96AL8H/hISELd6msTxW7ZB3JetIpQOWqdJr98+NywFHWcT8fQz7gtxmOyPv5
	 Mi/ABprdWIBbYrpVe5CWL/hAwF6sPHFdpcvbNecrjmL+I2TGDKPal9K3JzUsCIr814A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794364364;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EQFSFoL8MyPpZNCfc8yudcQ9h0bWkFsE0YoFpZPOjHo=;
	b=EOZRnQDCaBjg8xX8ULEpstNXxwicfBhzsfzEV4Prnij8Qn+OyU7943LWo2YZ/j4/8vGy
	 dsU+HPE8FFAhom+X13XdfWSLejvq8LG/8PMNXrpJABFMi0GVWNHvoR+mz0mcFQZBElmJ9
	 OVH4tvj0kPXaVeWf3ZwUuAI0S0yZdi6jmRcXKAzO2l5DdH4pJ3pBubVuuNrf1PvL8v/wl
	 u9x/eP4xHsJM6s/c8FbIiOnKPUyjTM9i3WbMKrc3MXBHhFgMhkMc8TPEoA0aal4TwWYlG
	 PETWbHJf9LH+dtqeZvIjkCUfYpcqF8SFW6nvDY+ysoALquTov7UxQ6G2EynlUVGCZPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=j2dObdIj;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDB1606A31C;
	Wed, 11 Nov 2026 02:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BDB1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=j2dObdIj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=j2dObdIjzEmi2cx2V6Lpu4VocFbiC/gQTjEEdvRqOkOC0zYGZoHHXa8r0Q5HLh8QT/22rGMxCBGa2
	 NxwcJc8RZTSf3x5kSwJlyJv4Og9YRUIeipEkXdGODLWNLavLMGG9WMXeK1u2rlFZInYEKax+CjyfDC
	 TLWhGiISddvVklsg=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16af3d3c5a2a-aee75;
	Wed, 11 Nov 2026 10:32:41 +0800 (CST)
X-RM-TRANSID:2ee16af3d3c5a2a-aee75
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.net (unknown[112.23.105.204])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56af3d3c7af0-caea1;
	Wed, 11 Nov 2026 10:32:41 +0800 (CST)
X-RM-TRANSID:2ee56af3d3c7af0-caea1
From: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
To: kuniyu@google.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	willemb@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sunwenbo@cmss.chinamobile.com,
	1342116488@qq.com
Subject: [PATCH net] af_unix: Inherit SO_INQ in unix_stream_connect()
Date: Wed, 11 Nov 2026 10:32:22 +0800
Message-Id: <20261111023222.77227-1-sunwenbo@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
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

When SO_INQ is enabled on a listening AF_UNIX SOCK_STREAM socket,
accepted sockets created by unix_stream_connect() do not inherit
u->recvmsg_inq from the listener, unlike TCP_INQ, AF_VSOCK SO_INQ,
and AF_UNIX SO_RIGHTS_NOTRUNC. As a result, recvmsg() on the
accepted socket never puts an SCM_INQ control message unless SO_INQ
is set again after accept().

Copy otheru->recvmsg_inq to newu->recvmsg_inq in
unix_stream_connect() using READ_ONCE() to pair with the lockless
WRITE_ONCE() in unix_setsockopt().

Found during LLM-assisted code review of unix_stream_connect() while
comparing option inheritance between SO_INQ and SO_RIGHTS_NOTRUNC.

Confirmed on UML (x86_64) by enabling SO_INQ on a listening AF_UNIX
SOCK_STREAM socket before listen() and accept(), sending data from a
connected client, and observing that recvmsg() on the accepted socket
returned no SCM_INQ control message.

Tested on UML (x86_64) against the reproducer, verifying that
recvmsg() on the accepted socket now returns the expected SCM_INQ
control message, and ran the tools/testing/selftests/net/af_unix/scm_inq
selftest (all 6 test cases passed).

Fixes: df30285b3670 ("af_unix: Introduce SO_INQ.")
Signed-off-by: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
---
 net/unix/af_unix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 98fcfd7301f6..f847cf1fbeaf 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1750,6 +1750,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr_unsized *uad
 	newu = unix_sk(newsk);
 	otheru = unix_sk(other);
 	newu->listener = other;
+	newu->recvmsg_inq = READ_ONCE(otheru->recvmsg_inq);
 	newu->scm_rights_notrunc = READ_ONCE(otheru->scm_rights_notrunc);
 	RCU_INIT_POINTER(newsk->sk_wq, &newu->peer_wq);
 
-- 
2.33.0



