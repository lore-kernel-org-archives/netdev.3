Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E87D46EF90
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 17:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791134195; cv=none; b=PzcrkdCygFIoIB/NrfwvCUBXX4ZlmOvjie4nwCoP/Xt2/fYBi8E4MQzcipod4lpaiv5C7h45wEeWVkQFZk0njh3Y/T8Q5QTNzuuNuSOnxW9DD929eusPWI5m6kbr1BzNYEUzrikuWbJSK9Il472vcVUxenmHg53caP8BiTmm8to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791134195; c=relaxed/simple;
	bh=fnDmQBxhOnOzTjP27W0omZjVCFDehhZddO82fJQi+aM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bwLKs8gk1tdCw5MVaiOKenhEjx8gWzj55kWbubjr8iSAU8fT8LnHX7OoXNNHrY5Gt5ugOfX2JvtQsjBC6dK8aLvfDifN30ll+Hia0FE5iYL1VMvs4I2o9mNSE9Oo9trDY+iV8Xyiw+rm2LWBkGTcmnTqipxzvssi+HCHHY7EQ5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=ZoM94L/q; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="ZoM94L/q"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6ae27f06c2fso1642774a12.3
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 10:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1791134190; x=1791738990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MmNComV3+ZHbZ6goXTWe+Pc/3ipzZ4UsXOvFwMxOIvk=;
        b=ZoM94L/qjN2uSSjYUwazhuaiBmf8QQQcHiP9VyB1GA61kr1ONaWGSb4u+ZXY+qTVzk
         9cNHKWrOrZIZzDxBOY7V+2hoH5/PP/6vHKn5Ruksnb8o9Dvk6oU3kTa55Zg6JblmB7g/
         fdX37y/GpeFhU889LbRdUX2hNjqMCpGA//NhtBXYqVtAFnYYqN/O0KZwljrMY3xrn8El
         D/p1Ji6+DCc9axa6Fd/2AwrOZfLXr9QOZJxgcPHvaBrsYF7SXjRLqlyjhVn+xXoAWh+r
         wr7oO/zSv+ah1EFfWywPS6S3Ynme4SzUcmVOODdbS88PtuwuRXl7osa2BlSbpvEnIewT
         nlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791134190; x=1791738990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MmNComV3+ZHbZ6goXTWe+Pc/3ipzZ4UsXOvFwMxOIvk=;
        b=AsJCaj3U6xzjpRAmy9irEgQ3IEWHdyNLVBvFUHaCR3sL8hs/h3zlAZPcYfYDW3wpwL
         IAGxEgSSfLLO6BEe0Wg+A30btSfTTUSwCOjTiQdQZIsNgPmoDOxRVFibs0G0Te/DskUe
         2YklTdGwUsC0tDuBDg/fSuRJEsBprVahkKZuXZjX3COTq3Cy+8YlNUtDYmzjWBhaVZST
         me6gRDGluR6ncX+DR6HKby6r8F6068EFMzeJG1HHNxbhGZpYdfOPxAAoaufhsfmmIELr
         OsZGhTyOypsXBAXEDIp7eSOoukpS/vCPNdWebqnjlhIbqIC2ge5duSSo0vYd1+P7hFSG
         FjUg==
X-Forwarded-Encrypted: i=1; AKwUvByq5newtn4p6vcQFESIyGoSroHDUBO/e8h8lPnIFC5qGDAPS+l51wF629QRKHNyjAGsm3vUwcI=@vger.kernel.org
X-Gm-Message-State: AFuF++mskD8glCkiXMX/VcbI4W9cIN6Rgim9qnGoXSuYH4xSQqRkel25
	qZrcbdzccWOO0PHTSjFe+qM3FNxGH2azwxWxcPRa8RIV968Q8QhkW8RG4oElpz3Msw==
X-Gm-Gg: AYBFou2dtzrbjhrdGRn1fXT+dafDZoS9+FwMnmT+Na8egQbfh4mFS7neuwXSkL8r2ux
	D4i7HUgIWtQ9Ffz53ZoFA9j3FJQyy9+T06uAb7KRzyJgX1vRXEZpWEkfZ/Es//iEe+QVGbpVcMK
	iUlHgUDg1cFfbLoxg+8mJGPFiWnk7eEusVeucwRO29OveKrwXaqySTwmwP7vlgZYhxSjnllt8hV
	A8Gx/4B4IyS83JW/qXPX0J8+xXoogTLP+wtSq0w8QeW53Y+uYJf0mHr1O6IpFvKtYLIFIlA7LQ4
	zKrJyzSu7TqzFb80+y3qRvuoO534/cZ8dReCnw/eC1eab7RsgmlJMuyrzTo1GJJFG8zRWpl2h5u
	blxwmbNcHx1pQQ+FRMKj8n706gNtOdiviK5scGzZ7fAx5kYNnfi5QpEyt2V0KyHjEpYVxs2bgsS
	zcr8f/O69EqsRAi8PoFWxG9FJglR1apmpiQRDEUXA7ghFz8n7c728+KvBJMIEC26srfyoPiTKt2
	2Gp26+AN92BxPdNhJ1u6GZHujd14TfLcBrY62Y+cMbgv7kXAjHuJ7TfIsDPA92xAh4iNqNRUqF1
	7Dm6mwfE+aPKAMBaks9prXgygTq+CVgEkC2CYvHEsaytOqzwsITCUheAulIKuD/vQ87QVkiNqAX
	8r5crnMPfNdENggFD8pL2LVbdOfEdiDfnoWi/u7bZqZmUx4I/HxTG97N5zL4hl60niCGB32mc6G
	/4WD+B1dke+bJmzYwTC1SWIFoc23Mc9FL+cg==
X-Received: by 2002:a17:906:794f:b0:c2e:49b4:ab8b with SMTP id a640c23a62f3a-c2e6ece55e7mr448593666b.8.1791134190462;
        Sun, 04 Oct 2026 10:16:30 -0700 (PDT)
Received: from Desktop (pd9513667.dip0.t-ipconnect.de. [217.81.54.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e4cf9ddbesm317345166b.69.2026.10.04.10.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 10:16:29 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: pablo@netfilter.org,
	netfilter-devel@vger.kernel.org
Cc: kadlec@netfilter.org,
	fw@strlen.de,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	geldot@protonmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH nf-next v2 1/4] netfilter: conntrack: pick up a TCP flow whose SYN was never answered
Date: Sun,  4 Oct 2026 19:16:25 +0200
Message-ID: <20261004171628.3544978-2-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004171628.3544978-1-julius@bairaktaris.de>
References: <20261004171628.3544978-1-julius@bairaktaris.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gary Dotzler <geldot@protonmail.com>

When only one direction of a connection passes the host, conntrack sees
the SYN but not the SYN/ACK. The client's next ACK is invalid in
SYN_SENT, as is every packet after it.

Had the SYN not been seen, the loose pickup in tcp_new() would have
taken that ACK, with window checks off in both directions. Delete the
SYN_SENT entry and look the packet up again so that tcp_new() picks it
up. This applies only with nf_conntrack_tcp_loose, without synproxy,
before any reply, and to an original direction ACK at the expected
sequence number. No TCP state or transition is added.

Signed-off-by: Gary Dotzler <geldot@protonmail.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
 net/netfilter/nf_conntrack_proto_tcp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/netfilter/nf_conntrack_proto_tcp.c b/net/netfilter/nf_conntrack_proto_tcp.c
index ad6f1986d52a..31bd4b926e48 100644
--- a/net/netfilter/nf_conntrack_proto_tcp.c
+++ b/net/netfilter/nf_conntrack_proto_tcp.c
@@ -1173,6 +1173,22 @@ int nf_conntrack_tcp_packet(struct nf_conn *ct,
 			return NF_ACCEPT;
 		}
 
+		/* No reply seen and the client continues after its SYN: the
+		 * reply takes another path. Recreate the entry through the
+		 * loose pickup in tcp_new().
+		 */
+		if (tn->tcp_loose && !nfct_synproxy(ct) &&
+		    old_state == TCP_CONNTRACK_SYN_SENT &&
+		    index == TCP_ACK_SET && dir == IP_CT_DIR_ORIGINAL &&
+		    !test_bit(IPS_SEEN_REPLY_BIT, &ct->status) &&
+		    ntohl(th->seq) == ct->proto.tcp.seen[dir].td_end) {
+			spin_unlock_bh(&ct->lock);
+
+			if (nf_ct_kill(ct))
+				return -NF_REPEAT;
+			return NF_DROP;
+		}
+
 		/* Invalid packet */
 		spin_unlock_bh(&ct->lock);
 		nf_ct_l4proto_log_invalid(skb, ct, state,
-- 
2.53.0

