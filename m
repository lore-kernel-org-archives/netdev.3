Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794477893;
	b=dJM8ePvX2SLjr9rFw8WuEFwuwuOMmwEip+GIR+tUIUeongUICKSRrPII6VsX9Cib1A8M
	 Zwqh2GuatQz/ZerkGv6D2np+XRpXzxegIooQJNzMpNfh0UFUdMElCKW0ooKdU5krSi9f0
	 TZXo1X4J0DdsDKwfOEo0rTnFYMx6G/idXbPxxMSilC8t0VTa5oe0pmbDjYTtXlasd5Oe+
	 ViaVeE0HbwjJXNnrgLoXx7ORKXi8PnA5rGTVye3K4YlrZAYJ/TT0C4Hw7R3jx4YPnxUd9
	 yEVPHlSTZe0h8rf5HRU69fZNjGU05gd9h+fAhXnYGWKVmorEojZNjj4M/ErQx+UchDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794477893;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=/2P+UzLcAXUaiDKQbFxfB1RtcTN93C+L0+1NR3oo0lQ=;
	b=YIvbkVXMAWjrnIamLwabmpojWiwOrYP+OfY4eoVRRQHUlPCbJzuaO6unGMvVQ91IPK4a
	 WSUhijPvqopXQZTYRM/KlNNIjs8NJEg5L1Aer5sSULeqKutXBK26F0PaK6r+1yEM71w/a
	 0yz44iRX1wBXkvfjNa8A+D7vUQLwAuvI2G6IXYNh4s96v4QwU92/LOwnmlwMrEwGK3WRY
	 rGo4V++sZGRchl+J/AS1+3TfL0fAWEUifNsylBnggzisrYedeXanWBz23dRGJMTSxiKoc
	 yEGaucuRExXBwHyBZbqDdHT3f0J72AOQPghgkfWiWOIfAgIRAkDdGwmxhRvdp0Qszmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B4DXqUiH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B02606A321;
	Thu, 12 Nov 2026 10:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B4DXqUiH
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794477893;
	b=ji1fs0w+xXzAjCUbnGSCVI2/crVgacFpQOHHrGxMFMZuOsY5Crs0ADUltJY9466CWQLH
	 5S+KI43wQsp6he8yVP3fD5w1xHe+5+9r1OvRr69ws/EzgXqtHSoY9NKQf/r0N9/epqztf
	 xHFmNv2j46B+4qBjYIoT5bigaQQjEuZUa4egjFjmSZVsk4MP6Xc8oDBaarD7pXqAmKoUV
	 VUea3DtEVtxWKw0V+LdM3Ruo3X76AwdaxQAJ+aUzbX278pJ7Hk6MR+ExnhMsDrN6Sa5VS
	 zZsPWpFlmY1bZs1L63xACBuYtjwldbdPSR2eeN58MgzmWmxuVjAg9CfNpWN7siMIaTA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794477893;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=/2P+UzLcAXUaiDKQbFxfB1RtcTN93C+L0+1NR3oo0lQ=;
	b=UDfKVGh/ZtztyHlrRiIQYjdG1S0A6UsV1RCr3/QLjTpIgFbpxkf+XAx9Pb3YmBaXb+LY
	 WsiKhDbG7gzI4AJRrNzzYJcZGlBh5F4/WByZ2Apo+WJ2R8yJASljGbn2ovZhWKpmHv44y
	 9g9jdSB8rXvFu1utPggXyXtr0DxoSJnY+g+zV85N16T6sf+sN3z+OwKp88RaXusAALI2T
	 zENZkd3OcGZkkOfmYkEGCATRtoFJEOYfTfeX7G0CL/O8cVtq3KGb49J7fZuQr0NbbBnaX
	 hSOJ5ZUet/B4PjqnwLriICtB3buTn8td5H+d/iJTb67GXzEcFYqDvls0knJjM7m8Wgw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B2BFA1F00A06;
	Thu, 12 Nov 2026 10:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794477893;
	bh=/2P+UzLcAXUaiDKQbFxfB1RtcTN93C+L0+1NR3oo0lQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=B4DXqUiH7eXSB4MN+s6sFWcuSa4wlxfgEOAUiVufJ7MWIngtLxiM+kRp5qzCSfzT8
	 2bsIe72UU4mHIKJ0qEzdN5wZuN6qFN2u02PBgMMkRrPnEVenH6htg7F+NAKz3isc1E
	 Bfi6fPP9rUS4BltLC60IbhrBJwf+IUqlxb23pzaQnh9JBH+T74uXjTAZX4gC14HYDq
	 JP6NG1L0/oSOwOx++7uD8XvsiqkTmXMBBigLyR2cwFWQ9hjrCOAMKQ0qB9z24asNLp
	 A1hrPV3m1s1Hg2YVy+ePfsgbcJws2uZHTPM+Bi2P0ALTiwDDLQJrYWySiK/L0hmH5c
	 qMYFJcq1jkgfA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3F60A4945D;
	Thu, 12 Nov 2026 10:04:52 +0000 (UTC)
From: Suyuan Wang via B4 Relay <devnull+shyckless.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 10:04:48 +0000
Subject: [PATCH net 1/2] nfc: llcp: Clone LSM attributes to newly created
 child sockets
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-nfc-v1-1-ab0ef166f382@gmail.com>
References: <20261112-nfc-v1-0-ab0ef166f382@gmail.com>
In-Reply-To: <20261112-nfc-v1-0-ab0ef166f382@gmail.com>
To: netdev@vger.kernel.org, david@ixit.cz
Cc: edumazet@kernel.org, kuba@kernel.org, horms@kernel.org, 
 oe-linux-nfc@lists.linux.dev, linux-kernel@vger.kernel.org, 
 pabeni@redhat.com, davem@davemloft.net
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794477891; l=2145;
 i=shyckless@gmail.com; s=default; h=from:subject:message-id;
 bh=WtUcNIlZr5Of/JlHVB20yKuPFijC05MSrsd3vsPG3W8=;
 b=zMw8c+OS45UQNMuaqZc67YledF6y0cUGl05rZNtlvgXdt1L5mMoMp6tk96v8l8sV16YCN32KP
 70btJpatg0sDcOKNDDmKNvciQra+NiAFoZKiwGy6Wntc5uvinHafvfu
X-Developer-Key: i=shyckless@gmail.com; a=ed25519;
 pk=pMtccVGiWES3bV+7YBFuBclkvq2n2HBHQ5azaBrK2lY=
X-Endpoint-Received: by B4 Relay for shyckless@gmail.com/default with
 auth_id=1498
X-Original-From: Suyuan Wang <shyckless@gmail.com>
Reply-To: shyckless@gmail.com

From: Suyuan Wang <stevewong@hust.edu.cn>

nfc_llcp_recv_connect() creates the child socket for an incoming
CONNECT and queues it for accept(), but never calls security_sk_clone():

    new_sk = nfc_llcp_sock_alloc(NULL, parent->sk_type, GFP_ATOMIC, 0);
    ...
    new_sock = nfc_llcp_sock(new_sk);

So the accepted socket doesn't inherit the LSM state of the listening
socket. With SELinux, its sock keeps the unlabeled SID. The
sock_has_perm() checks on it (sendmsg, recvmsg and so on) still run,
but against that SID instead of the server's. Depending on the policy,
this can deny a confined server on its own accepted sockets, or allow
something the server's own label wouldn't.

Call security_sk_clone() right after the child is allocated, before it
is set up and queued for accept(). Bluetooth, iucv and vsock fixed the
same problem the same way, in commit 6230c9b4f895 ("bluetooth: Properly
clone LSM attributes to newly created child connections"),
commit 02f06918156b ("iucv: properly clone LSM attributes to newly
created child sockets") and commit 1f935e8e72ec ("selinux: vsock: Set
SID for socket returned by accept()").

Found with a static analysis tool and checked by hand.

Fixes: d646960f7986 ("NFC: Initial LLCP support")
Cc: stable@vger.kernel.org
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>
---
Compile tested only, I haven't tried it with an SELinux policy and a
real LLCP peer.
---
 net/nfc/llcp_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 74bf817007cf..0f54548a47cc 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/nfc.h>
+#include <linux/security.h>
 
 #include "nfc.h"
 #include "llcp.h"
@@ -1006,6 +1007,8 @@ static void nfc_llcp_recv_connect(struct nfc_llcp_local *local,
 		goto fail;
 	}
 
+	security_sk_clone(parent, new_sk);
+
 	new_sock = nfc_llcp_sock(new_sk);
 
 	new_sock->local = nfc_llcp_local_get(local);

-- 
2.34.1


