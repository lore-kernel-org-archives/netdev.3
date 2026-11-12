Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.76.5.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794483801;
	b=0Rm3aQlQNaRrUUjwMTQ4ehJQzofT3Bbe5sFdMNOVMv1p8l9Z8a4DL7xUAlygfEcBUwDI
	 Zh7KiNAGnVN13Bhp0RamU+SauJkjmAM/KzSW4aE1ppAPYOmwirO3cL9JkVVr3QfSlkey5
	 9Y5NXugkmBnLLAwhtp5GBpdAk1YNS7Yr6bQrqC5FacJHpippur4CXvo/+UXO8SAIVYeLT
	 qWOCdegROliptLkeyfSDabZeubLgIY62HiGTuv2ldk1BtKWjN4LqA8uJpSuLaQEpNHIuv
	 TgdiD6OvykdxUqHwWz+m/MLHkXL6xug0Ath4mXQmGViml55I/fehF0glWX6gv+NNqaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794483801;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:DKIM-Signature;
	bh=hjU+jspvdHfTYvJLdsfJKahfE+jp6uBbXgAHpYf6tVU=;
	b=SiB6/gDJvfWrXUiNfEGiMbiDVi1ejRJtjaKM3cSeLpucsbS1AIK+k8V42OpkokNeOXcV
	 Ktje4duTEt4BHn0ggAU2mszlsFfSI5PEyWPxkMkX8x4kh7UxQtAiBT8+wk/BY7BE0/eOE
	 p9bsC4D47Ns7Asn+xDveep+cUy2YaPAfV9YphTRuxrNLZt4YPcAVKFv5yNczjqzObiBt1
	 QtwnAeWp39x6TiFd+DkhTwD6NhBujeFErv7F+i2A3m+dZTv6aaKN0Um+MkYKMBYdyoigb
	 Ps24bePL1Bo+0kHLxaEjclnxDj1YPlaSDCLZAWW8QjKcB+Eem9g2+98SHAY5udTzX1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=S+NEjD62;
	arc=none smtp.remote-ip=180.76.5.236
Received: from outbound.baidu.com (outbound.baidu.com [180.76.5.236])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 3223F606A89E;
	Thu, 12 Nov 2026 11:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3223F606A89E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=S+NEjD62
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: David Howells <dhowells@redhat.com>, Marc Dionne
	<marc.dionne@auristor.com>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<linux-afs@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH net] rxrpc: rxgk: Fix uninitialised stack byte leaked via RXRPC_CHALLENGED
Date: Thu, 12 Nov 2026 19:43:05 +0800
Message-ID: <20261112114305.2340-1-lirongqing@baidu.com>
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
X-ClientProxiedBy: bjhj-exc3.internal.baidu.com (172.31.3.13) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1794483796;
	bh=hjU+jspvdHfTYvJLdsfJKahfE+jp6uBbXgAHpYf6tVU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=S+NEjD62cu3StR2FZBhcquOhl5pKl1hUGJPEcspgCxEAzFoZ6wfrUkVVHuXdjDxeV
	 4U/2ofFTTw4a0TE/+p3SkZtuwU0hSY9krrNOxxuH9Z0/sPjCh+xQ6nGrMRIqSrk3kZ
	 M10a7AWDKdSi53jUSB2i7BHBWk5CRN1/K2tzOOF9JINjaKidqJnIPG9+AgrG91qMnm
	 glo4Ezo5WT+bpJx5g2s7TimwcCWOud+K+tAAbsPKXQvsBqZq5ZfNy+Hy3iarcS2l/M
	 Jxpl/C/DIuH+QfWlvJfB/1SzREsdBroRSiPkWEcvjvsaOTZcGLrHIezHkv+B2YBk+H
	 U56djrIrP9KVA==

From: Li RongQing <lirongqing@baidu.com>

rxgk_challenge_to_recvmsg() builds struct rxgk_challenge on the stack
and passes all 8 bytes to put_cmsg() via RXRPC_CHALLENGED, but never
initialises base.pad at offset 3. The struct has no implicit padding,
so this byte contain leftover kernel stack data and be exposed to
userspace. This issue was identified by code inspection.

Zero-initialise the structure to prevent the potential information leak.

Fixes: 9d1d2b59341f ("rxrpc: rxgk: Implement the yfs-rxgk security class (GSSAPI)")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 net/rxrpc/rxgk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/rxgk.c b/net/rxrpc/rxgk.c
index 77a67ac..15533f4 100644
--- a/net/rxrpc/rxgk.c
+++ b/net/rxrpc/rxgk.c
@@ -756,7 +756,7 @@ static int rxgk_challenge_to_recvmsg(struct rxrpc_connection *conn,
 				     struct sk_buff *challenge,
 				     struct msghdr *msg)
 {
-	struct rxgk_challenge chall;
+	struct rxgk_challenge chall = { };
 
 	chall.base.service_id		= conn->service_id;
 	chall.base.security_index	= conn->security_ix;
-- 
2.9.4

