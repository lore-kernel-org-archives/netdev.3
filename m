Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411078;
	b=Eor4BvZ6qBeIDX9j/k6Aca8MW1Cg8oyeBtyWJOSNz2XkBZbiTARs3VJXbMwk2GKdaMCH
	 mmBtgv50dXJciGJ46bNilTakTgnDB6ud6goRGrpqc3/zFTqNQR/Rr8Q1WDIx1omI3edut
	 Ko9eTr1ASB2LpIq+ULCXi/g7OqL4WwuW/OEARouiF0tFd/AyX7ZVJwMD3L5cMEeBl6USc
	 8FhnGbq2CWXu4GOzSqoklJAWrXzWwLdo/9bQMQDcrFkZqRobonaBF/JwFrJPwmbe3Ewzf
	 S7TvMwSyucQgPMlWGzfU3GJ0/3mUrY/qZ1uk57fkDHZKUHvQ/xFIc5sfcyx/AmsFEbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411078;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jMbE98rH640PDimDt/5oPcA8BfJO9FWfDPET1eqatTE=;
	b=AF+6ERuWZ4cRjSYeq0lBzj7kJKpG9/2kkuc722jnrKqEJz5LjA3HBrhMdHo4lXcX96cB
	 1s6xQjrSwtL8aZjPUMKJfRbQosr48S3xNwsl+cIdrTQ/AeAjmalbcJzkAspE6W0ecZgBE
	 BKcdm9SQ/W7hql+xkG7zm3WFKgcrO8gUU2dbq/zIrjcxy5qQGXRD0gXgizGtNtg0/dPr8
	 DTSD49+IHAWiUiOpZkyuvfTAUxSJ7AniHWmkFo80UdZde0SVrqsqo+EzeXRpscP1MNJnt
	 zYOh6ralnW0qqxPOjd5viXmEWY3+Xym8BRxq9dEM95FzUgiNguAySw/pHyChenmnnsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QwZFkqnk;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651E8606A334
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 15:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 651E8606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QwZFkqnk
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso33148595e9.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 07:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794411077; x=1795015877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jMbE98rH640PDimDt/5oPcA8BfJO9FWfDPET1eqatTE=;
        b=QwZFkqnkqQgmKMaucvqUUEhBhCr0CHfKdRo56wmiBm1nt1B06ewHmhGQFcN1McJkGi
         Y/h/HgWV5gvyg000piSpcg7wedMpZsjEd0iTLO+PD30VerIoqP9qIeSPzs/jGZpZAAWl
         p3YkVlhx22iVP4VgqJXKfdnOtzciiHM5NqJO5vHBstLl/najug9+sUBetrRtwIFoufl5
         JQJGDf20tM/YDaiCXhIvherz/n7N6yUNO8dsm59dUOnRPnhMWvVQgCm2Xg0jmnmKH5fy
         vB5OHjhNq00CTpz2vuPlCSMcqs12L90cc4QJi2Rxbh4lE18kbfkYVfn4K0CY/Gds6XLg
         89YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794411077; x=1795015877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jMbE98rH640PDimDt/5oPcA8BfJO9FWfDPET1eqatTE=;
        b=QGg+rzyZr/OCZ0KDhM7ecv3IxJ8MgRX8ju0ygpS+OxXJ1g0uqEr0oImsv11TbyUf29
         FAeKNg2i2eMH19Z5KWngD1mvRruQLxF5AmCDUughNlU/CWmvVRe1G5GNOWpt17yjfjfG
         EGM/u82X2X19AfTeeSM0H1C4fwvYwfd1G3f2SB13xyJsNhI3eaifru2SV+Fme6NbnRz+
         97D9USyurACNzz/E8eKn6I0sbLiR4gmfh4YxGKoUGoYtAndxKKobYb3n2C05bMlzZMvN
         WHLaKF7lqAm0X4KbrV+7+619vjQ2JL14CazIcyf9et1USq3Z8szaAvIlcPkqFjmGH++Q
         y/YQ==
X-Forwarded-Encrypted: i=1; AL+hErFkdGVblyTgXRxWz5fSTlnQsbYLAhQUJKdbAE+FGAcsGLS70c3JvE9LGVOn17BVBOzbFEXepZk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/mHOtUPrXcmlbtjYrZVBv4c2k/gHJd+dkd9Q54CZQL8vbMPKhI
	hGpk6WOTJAYprT1o85qBJIMGR/65iheM2idedK4pWEqkBV+R5qwaXFR2Jom7
X-Gm-Gg: AYBFou0rPM8zG1I5cz9fUG9HyTSqMtxC22S8BrTYg0ndd+cWpFfvB8RCMd2eFDPh5ik
	Vda5WX7j7qpDji42t26LLfVykCitWsZybKMrQWaupooL3W4duMUYDLZ8pGaeVLUNA7FtGJBuVsr
	q9hxpHi39m8VE8tcI7UhjsA98owH8Qp1jtWite1Whf3dLofS+TUM2R1m8MaQEqSsAu8/lWRDqzr
	HJWQJv7S965+3KYWavytYyEcb8IH5KBeM7En1MrnPMCRnZfcEiLJiqdxj6mCAeY8WUuDQaXWCC4
	E2KF41RHstrSmcfleFezAV+z4HCNcxLrgc6hFy6ybvBlqt5eo4jxBzBiv0jcBS/rZ8HRPKhKGLD
	xy+vQhjN/N4xI89KcHDM+G+qbjM/1v1cOCRVLowv/5OfHwcKr8pv2kpZ575qRw/VSBI1pgCTupg
	ZN1wZJMvh5ia8EXjFoAMmhN7qTXleMrDKWIdogM86qDPwuy825Ho+AkMq4t4zQDRZU8ceyuypX6
	WTpzdrF4Chb0k56OgbGzOSxz+f+ViJrSBlakv8r/dQJ+UO4AQnG5Bk77IykWRnF0o50oXtxFUPM
	4hE0rDHqXL8yEXY=
X-Received: by 2002:a05:600c:1986:b0:4ba:eb:eb9b with SMTP id 5b1f17b1804b1-4ba0935dad6mr50320995e9.8.1794411076662;
        Wed, 11 Nov 2026 07:31:16 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4c5e2fd6sm2261365e9.10.2026.11.11.07.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 07:31:15 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH net] net/sched: cls_flow: pin file with get_file_rcu before reading f_cred
Date: Wed, 11 Nov 2026 15:31:06 +0000
Message-ID: <20261111153106.580776-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

flow_get_skuid() and flow_get_skgid() read sk->sk_socket->file->f_cred
without holding a reference to the file. Since the file slab uses
SLAB_TYPESAFE_BY_RCU, a concurrent close() may free and recycle the file
object, causing stale credential data to be read through f_cred.

Pin the file with get_file_rcu() before accessing its credentials and
release with fput() afterwards.

Fixes: 0ede61d8589cc ("file: convert to SLAB_TYPESAFE_BY_RCU")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 net/sched/cls_flow.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/net/sched/cls_flow.c b/net/sched/cls_flow.c
index a9ac3acf6eda0..233ca13299930 100644
--- a/net/sched/cls_flow.c
+++ b/net/sched/cls_flow.c
@@ -17,6 +17,7 @@
 #include <linux/ipv6.h>
 #include <linux/if_vlan.h>
 #include <linux/slab.h>
+#include <linux/fs.h>
 #include <linux/module.h>
 #include <net/inet_sock.h>
 
@@ -208,10 +209,16 @@ static u32 flow_get_rtclassid(const struct sk_buff *skb)
 static u32 flow_get_skuid(const struct sk_buff *skb)
 {
 	struct sock *sk = skb_to_full_sk(skb);
+	struct file *filp;
 
-	if (sk && sk->sk_socket && sk->sk_socket->file) {
-		kuid_t skuid = sk->sk_socket->file->f_cred->fsuid;
+	if (!sk || !sk->sk_socket)
+		return 0;
+
+	filp = get_file_rcu(&sk->sk_socket->file);
+	if (filp) {
+		kuid_t skuid = filp->f_cred->fsuid;
 
+		fput(filp);
 		return from_kuid(&init_user_ns, skuid);
 	}
 	return 0;
@@ -220,10 +227,16 @@ static u32 flow_get_skuid(const struct sk_buff *skb)
 static u32 flow_get_skgid(const struct sk_buff *skb)
 {
 	struct sock *sk = skb_to_full_sk(skb);
+	struct file *filp;
+
+	if (!sk || !sk->sk_socket)
+		return 0;
 
-	if (sk && sk->sk_socket && sk->sk_socket->file) {
-		kgid_t skgid = sk->sk_socket->file->f_cred->fsgid;
+	filp = get_file_rcu(&sk->sk_socket->file);
+	if (filp) {
+		kgid_t skgid = filp->f_cred->fsgid;
 
+		fput(filp);
 		return from_kgid(&init_user_ns, skgid);
 	}
 	return 0;
-- 
2.47.3

