Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794475293;
	b=FAXMVcS2SDCsqOjA66vOBD7dL4HOq2FS1q2FK/cwnvS5YmuB2QVlc8C7M5WxWK0abLKC
	 AAWebP2Re2NFVW1hhivlCtvGsMYD+/QDdxRGcIcz1sSuy8fcGh25GoCch0IDN/x8fp3or
	 Um9vggdAR+cMhRWUUMGiwLk+wmjBM3LcYJDktyO2dKWwMiK83ujja/KLnBEOJFbwrQ7kp
	 JzBlj0TOALfIFv+FwcUAJKw20twZzMujJhzxjU6o28ZzQCygr9aFHrju7UTH5JRUSpTD4
	 BtAouz73KG2RFWZtwn4lncHFx6SSlusjfhTQEkKVzNE7Ol2TZWoMtK0pVqyjpiL2vVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794475293;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=WWgmljf7p+9w5O022U38G+2AIVWKoqElpuvWzSOA914=;
	b=2zlMIunL0rKT6qxk46nRsh/rYycBE2SfflzjVxul3da0daSIHP2VVEwfXywO3wi2nMnI
	 QLytGw+1FWg59me/pI/xQq98C6ramfOxMiegJSjXQ3o4OYjPqKBuVZXx07z78ostudJ2G
	 NeF7fhAZmUROHhXgelDtdP3xkVqNMlbtWbkk10MkNx/7U24STJL71OuZyZEF4u3fKa8Sl
	 pEixsKgkV0z8Qv5DP5z6xoMXJz9JrxhyF3pZc/Rjt2orzTtRjgfCZwKLh/rJsgpYuWDm1
	 x9lV7Hgi+Q0fLCAOsgEKDazPVbgo+W9PP8j5COPHnkQ9EpWU5lUdXK+QLL+Zfe7VWRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uCLbTb0r;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899B5606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 09:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 899B5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uCLbTb0r
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8b5c3288e6cso1792573b3a.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 01:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794475292; x=1795080092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WWgmljf7p+9w5O022U38G+2AIVWKoqElpuvWzSOA914=;
        b=uCLbTb0rB83bwv9iDuS+LxIdVmXsAEqbZalNHgCMW9hYO09rz9Bd82xt1MY/+a7ipU
         Ph9/ItVXahyPYEPiUhLnothPXdEa3DmzRP468PqaETZ+1nIdHeTcguQ2DV3yakaUitrk
         LE4J2DXpB2C7uS2qBfUbJ9jkB6F6yLgZ9yUDoEJUbxLAtWq+qMiO+fP/uFoSyvICafIC
         SeSkbuIYpxPANwSS985Jer97vYYJx7f/nUg9POhhaQkH6xN1IKcAsxhMfXY9hxrgAm4n
         2ZmYffJHUWXBKOMCdMj3IukJ5K+cv7J3fRxSgpukR9zmN09xhtXGSqjPjZlRocobEjgE
         HspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794475292; x=1795080092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WWgmljf7p+9w5O022U38G+2AIVWKoqElpuvWzSOA914=;
        b=lhz7PlxmRC4TMDLqiqe0AmwwOOb1d1HQt91+EAaBvYu5LuY7xYvQbficwJbwVdnMOf
         DB93mPtpevK3lFaKpA65IgovffUgsFkmWveTBLYst/aYhmfEpULZTKkKuUGHE2v4VETK
         yDnHzxOOAdPkXYaFbOvBOOI+hx7+43WUW1zbJG7358GvkXyBp2wFzSIHPdWhaH6lIMiE
         oJhLaovR1bE5aKCPsgFRDWkSiEvblYR0yF6s8d5ES+5CDq7Gx+h5aHA0x5iOUqIItIjf
         jL4cmzw2i5csNQgg16WGjboGsyFJ+y4YLLAyXmIA5cgFIaZ5dP2jx2HztnHurR2NLhNx
         gIvw==
X-Gm-Message-State: APuU4Z8h52r2UmU93It2WQqQrpG5ZrsLj7/+tNgYaTrYq9K8whvFVn2Z
	YIwvgz18fp0MRQq/OyBExIVyzAGdRcwgZjz49IvVK/b3LzkbfIHOdD+H3whO5Tzi
X-Gm-Gg: AYBFou3jNyMetEw3z9HRlgAj8UIZC8QV7HiU3OyrFZMcBfc+nAONZnvh7oJiGKHAVMQ
	XzFQtMYJ3Q7/+/LwLOr4uePtvrmo5Yps5OljbuKHDcV2z2EKcgnjfNeLiuy1lfgQy/r6cJfygWe
	/IegFTqVE9m9XMgj+lS4W4eTIkkwiuLfjwfrNQgTnBQ1g45U2LUsou7rGIpGR/rPWoMA9CaZ8ml
	B1bnrXFrhOtr3j9YnDBhQinsCoeVsblX//gTex6HFOtp30tnD8ks7D0b9xHGQ4ko+zow1Ag6hhk
	NvFAkgzcd2cJUoF1321ZlNgY0fe1ovWk31jlrRF11/Y48KAByuW403NeALc42u/A0wJk72RnC0Q
	PXZtlSAD5Bis8evw16OSmryKm2afjZNodSLXkhHJqm5T2fjs/IExto8Of3zBSRHcdmkM9sVOmMt
	yYb5CRt+Rl+INF+aPo2W710p1LcuKnUeyzqQ6/+K7gXJs09cAaVS75I4S4thKLU97wmma3tuOB7
	IcybbVX3mjCuLa4pXESKensJBAgWXunmJaT6JK7mPPLlFOIlCSWdsif/E6b/ikmsI3yZAOwfRzK
	P/So8DFzUzvVue2m6/E/qVSDwWwF1lVrsfIIP5ymMdAbDqkRErstUGlIXtF8vFj14FIQX0ZdNA=
	=
X-Received: by 2002:a05:6a00:b86:b0:89e:c324:958a with SMTP id d2e1a72fcca58-8bc1d148d9emr4997745b3a.34.1794475291667;
        Thu, 12 Nov 2026 01:21:31 -0800 (PST)
Received: from JIAPENGLIN-MC0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaa2a6d79sm3214881b3a.10.2026.11.12.01.21.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Nov 2026 01:21:31 -0800 (PST)
From: Lin Jiapeng <ljp1205831794@gmail.com>
To: netdev@vger.kernel.org
Cc: Lin Jiapeng <jiapenglin@tencent.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vlad Yasevich <vladislav.yasevich@hp.com>,
	linux-sctp@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] sctp: preserve the last transport during INIT error cleanup
Date: Thu, 12 Nov 2026 17:20:58 +0800
Message-ID: <20261112092114.12458-1-ljp1205831794@gmail.com>
X-Mailer: git-send-email 2.55.0
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

From: Lin Jiapeng <jiapenglin@tencent.com>

On failure, sctp_process_init() removes all non-ACTIVE peer transports.
An existing UNCONFIRMED transport is not promoted to ACTIVE by
sctp_assoc_add_peer(), so cleanup can remove the last transport.

sctp_assoc_rm_peer() assumes another transport remains after removal.
If the list becomes empty, it interprets the list head as a transport
and passes the invalid replacement to sctp_assoc_set_primary() when
removing the primary path, causing a NULL pointer dereference:

	Oops: general protection fault, probably for non-canonical address 0xdffffc0000000045: 0000 [#1] SMP KASAN NOPTI
	KASAN: null-ptr-deref in range [0x0000000000000228-0x000000000000022f]
	RIP: 0010:sctp_ulpevent_notify_peer_addr_change+0x73/0xba0
	Call Trace:
	 <IRQ>
	 sctp_assoc_rm_peer+0x186/0x9b0
	 sctp_process_init+0x1ff4/0x2810
	 sctp_do_sm+0x1c97/0x4560
	 sctp_assoc_bh_rcv+0x30b/0x630
	 sctp_rcv+0xb63/0x1220
	Kernel panic - not syncing: Fatal exception in interrupt

Keep the last transport during cleanup so sctp_assoc_rm_peer() has a
valid replacement. The retained transport is freed when the association
is destroyed.

Fixes: add52379dde2 ("sctp: Fix oops when INIT-ACK indicates that peer doesn't support AUTH")
Cc: stable@vger.kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Signed-off-by: Lin Jiapeng <jiapenglin@tencent.com>
---
 net/sctp/sm_make_chunk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index 15c2d87575a8..e4b7dacf174e 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -2528,7 +2528,8 @@ int sctp_process_init(struct sctp_association *asoc, struct sctp_chunk *chunk,
 	/* Release the transport structures. */
 	list_for_each_safe(pos, temp, &asoc->peer.transport_addr_list) {
 		transport = list_entry(pos, struct sctp_transport, transports);
-		if (transport->state != SCTP_ACTIVE)
+		if (transport->state != SCTP_ACTIVE &&
+		    !list_is_singular(&asoc->peer.transport_addr_list))
 			sctp_assoc_rm_peer(asoc, transport);
 	}
 

base-commit: 145480b28ca82e9fae789427cc4569e596515a32
-- 
2.55.0

