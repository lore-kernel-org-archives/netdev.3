Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.76.5.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793996316;
	b=5p0P99XHCIwqM8Jvu9IEevfdbgAQbwL4ZP1DBeXCy4xkknnP6O3m/eZcIkfbG4TYEjQz
	 39u2VChszMDbqeeuY/MqgzMy9sVRcjx6MJGba+Agy54ANdQlCN9JdEZAowhNT3LWD/HCb
	 pv7Jds7JlHrdmiqRd+jejzkQ2lCP9CzB8LIZymsrP6pNq9+MAoMP0oLHNJ15GU4SB2l5b
	 JLPfhivjsQwZ2B1caOpd5B3jUn43fvtLpE6F614cCvbtVSbB+l7Hcljco20bO+Qq5H9gK
	 x9YMH0RYzoahyCHVpwFgJXn7p/qU2MHyC5raka0Kg62zWhGKIQ9fV3ut5mHPMhS5g5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793996316;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:DKIM-Signature;
	bh=aqswEJUPN6JEnCBsn8xRQ+S2uAcacA8NEkUmGUTdheA=;
	b=S/Cd8KQgBErcfvV2mdMTGRWeKsRZE6V2S5MOoEwWRXs8/F91t96aPPfWYroZD0b01fih
	 9YgADpU35fo5Qbz7ZNu5V1pj3M3L0meLJf8pIfYzWsrW4Zqet9+nHz/vuTvcmH5sL9QDm
	 y2VRGTyuN1Hq/trFCp4LstBUlM/39H4dZgbqK/1vxrY3svbdXlPsP00XSo3/dl8iJsbbj
	 T1CCYk/ohqf97GsqcOnij7gwff2reGuy83eb9mqynDgNEcDwb59k7v0hfRaMsefeHo74k
	 CVZTOZ77OFqKRGhVv2+MODSpfbnIYmvTmwLd0oAOc0vnM1vAqJPTSB1exZrm4API6tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=Zs2s4WWH;
	arc=none smtp.remote-ip=180.76.5.236
Received: from outbound.baidu.com (outbound.baidu.com [180.76.5.236])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 29554606A326;
	Fri,  6 Nov 2026 20:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29554606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=Zs2s4WWH
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] af_unix: Fix wrong socket tested in the symmetric half of unix_state_lock_cmp_fn().
Date: Sat, 7 Nov 2026 04:18:22 +0800
Message-ID: <20261106201822.1734-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc7.internal.baidu.com (172.31.50.51) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1793996311;
	bh=aqswEJUPN6JEnCBsn8xRQ+S2uAcacA8NEkUmGUTdheA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=Zs2s4WWHxB2L8nfgAvdkbBpDq3t5MnsEYV+PlUxKcMmhh0ZEsDvU/Kj+8+nypdhqS
	 jGZR1QX4VliyXQxYQ/aTI0lKi0eKQ7lDKrwdktM9+skpZF9lT8iqXUv47ajSAmkbf7
	 9c50tS0lvGjXhiUr54onXfwENojbo5dytVBuzmJOjh4zhAZwghRGiiIuW2CXN1k0bY
	 VMEJfqPx9nTcitYOUCBpHGN+/zRXqKtlMJaeQT2xiHbydH3XPBemcTtn/cS+ULzK1a
	 sTuzRxP0fasCxXyfvP3/ltSz3gbAhQeIQVrmyK4b3mtVYuIrP5p3sKKB0+v+ZUgGby
	 zURXlmlq8/ObQ==

From: Li RongQing <lirongqing@baidu.com>

The second half of unix_state_lock_cmp_fn() is meant to mirror the
first one with the roles of a and b swapped, but it switches on b's
state again:

	if (b->sk.sk_state == TCP_LISTEN) {
		switch (b->sk.sk_state) {
		case TCP_CLOSE:
		case TCP_ESTABLISHED:
			return 1;

The enclosing if already established that b is TCP_LISTEN, so the
switch can only reach the default label and the branch always returns
0, "no order known", instead of the intended 1.

Test a's state, as the first half does.  The code is only compiled with
CONFIG_PROVE_LOCKING, so there is no runtime memory-safety impact; the
effect is that lockdep cannot validate this nesting order of
unix_state_lock().

Fixes: 98f706de445b ("af_unix: Define locking order for U_LOCK_SECOND in unix_stream_connect().")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 net/unix/af_unix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index e7a0582..501e693 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -163,7 +163,7 @@ static int unix_state_lock_cmp_fn(const struct lockdep_map *_a,
 
 	/* Should never happen.  Just to be symmetric. */
 	if (b->sk.sk_state == TCP_LISTEN) {
-		switch (b->sk.sk_state) {
+		switch (a->sk.sk_state) {
 		case TCP_CLOSE:
 		case TCP_ESTABLISHED:
 			return 1;
-- 
2.9.4

