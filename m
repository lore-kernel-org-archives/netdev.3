Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725159;
	b=Vra8li041MwTQiQhiCFFuClAKLB8CfQOYt0/N9k/ChCjpARc3LurxRZ80nUzyO4W224g
	 mqh6ziOb+xw9SHkRuyEltELKUbc0A4i3wmOTk8IRXAXh84VsZXA+1lim9FJaAqW1E/Cj7
	 0Uh7BgkLHP91zHzy4qqolPK/wtMlXvb+XQ+Hu7OLXhMCpETMmOAsaKucKh20X+pDZxQe6
	 mlaf6KMlZ9VOneA4c6NTVN64gUR53lRe8h71KKGAC03Ln+6xp2TLIeL2bnuDrLxphGwjU
	 xw30ikTo7cZTJGiIb+vd8WeL1Tf1xVIygmq1APDG8HubbIBWIoEE84Js6FUhDe9gWMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725159;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qyie3lp94voMetIz4ZK0UyMQldPElbkTK8vbvrxDQEs=;
	b=Wos7v8MBU7iFNMsANIJWUVAo+Y4/eltvRdMqc6a0Tqas4p3ZST+syAPXEkQHeeriwxek
	 w0rok6QytMSOc5bMx57ZDw/cfU3sY3tZY02Ehq5bRTkEMh8v3DhnoYpAIGMQ1sicm6a/I
	 nQeej901ksycY8UMSeQVazY43I0VrdA90HABV6zKFx75wI1JaSihttYVFaWRfgUsHzZHS
	 z3Xphs8rdpTLZj0cyijZ1S637RQiseXUujfTzzrMXYTCBkwJCIjf9RzXU44+R1AUipSFH
	 ZpCvIsyWLPEqYF1EhK3MVu+KWJYT4L5Pfyjrxeflk+meAdLq+fmsHekg1S+f+YZJ6UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1password.com;
	spf=pass smtp.mailfrom=agilebits.com;
	dkim=pass header.d=1password.com header.i=@1password.com header.a=rsa-sha256 header.s=google header.b=e2u4H5ji;
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0571606A32E
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 16:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0571606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1password.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=agilebits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=1password.com header.i=@1password.com header.a=rsa-sha256 header.s=google header.b=e2u4H5ji
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93a40a9a01aso114643485a.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 08:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1password.com; s=google; t=1793725158; x=1794329958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qyie3lp94voMetIz4ZK0UyMQldPElbkTK8vbvrxDQEs=;
        b=e2u4H5jiGKGo9r6gEd2se4tGTZwmdU5p9nRdnHtOCSYXWlvFZj83tcGAwxxRpJ9zAV
         Mro8wC0WTq2rpRb1Ji8FduryNwdXihHaxmOaRYFBF1Tw8cmDMDaeaikwpbhBcj0Ovq4t
         1zp7PeTOuJVNUfTKrkm+Y2EsfuDAtAvurwlTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793725158; x=1794329958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qyie3lp94voMetIz4ZK0UyMQldPElbkTK8vbvrxDQEs=;
        b=Yt+D4aDnDQci8T2MIHpJ8iBSe46CubGnGIC94aP8HOL99Av+fHy0wJdGwKbhQ9OHCK
         Xh9zTRun8Jklgl5gsFYAteRsFJMeVAaeiLez/7I3V/109GJgfoowiX7IWSgJDXiLYEZ9
         ZySVFLJqI4ofObHIeCYB7XmiJJJJwXTZlxY+Jkx3s5LBkWjyjALUrXqkYIkfxsHlpnrx
         se6CItnqNF6O2773UFf11KGqyoRCj1iecRS1ZPUVaBvAK1Nb7KhJzwC6WYUtqfiakbtl
         JJF2WwZcxFqtsQMUWIcXIFtOaYLLDk4f7dbQ7z80aG0um6pxq7ls/N7RbsflkIbjNQRK
         D42g==
X-Forwarded-Encrypted: i=1; AKwUvBykZA8FByKSjd3/vF7P8C+IJhHjGJTOl77F6pzml2gInw9lWr01XFNrXAOF3iMXzmKN4imG2gg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/l6tlTBft4ie9KdhnL8YJtMigARITS83uqFeyDCXvFgqOsuq2o
	tvdKFduxuTpC1PDjgtkzMODCkuuCYf96MZwgY4pcwqanoQA9u9KUBplfEoohmVVGPCc=
X-Gm-Gg: AYBFou1ylavaNSbkhJHs2cr033Ai55hy+batoRq7Z6h4Bn4MTV8pfjRkWxU03ORR4WO
	BFx+v8mjME+w22KRnmA5TEyHzezMLNpOKEOmy4bgmCJY8tO+O7gdy9mneY26L0sY1J7cpVYp5ab
	YKyQGx56MpQCs5lIS/DCwxFNtt8jbMIuH2GX5FG7Q1LVCrKNzJY1Piz2/+2BjPyERHA0AIRrXmt
	R4a+RIbJtbfHt/ozrx9jBMWV3T0JLrnfmRAuO2tjaXVfvJNkIuGbHHKTpLH4HcrmGwq47mOhU9n
	4GGV9pZLjvJ2JHejG2wFCOdKmNfNHDs05bfF2ciWt/8ccHs5z8J4Oj6EEQKynEHcVZjKyepoNKi
	3M9Y9Jdyo1lP+98RQfGrohrNKUV3vhypInPBqLTsr1od2y4YZk6tCuDMz527TRS2TYdqXI06iWU
	mTwWbrRUDYnaLNJyEOXkuJbOGCv5J+2Ck9mpljyYMeTsw1qBXacFK+eDqc+HkBQhDTasvnXJ45q
	HJCGXhZ+bypgQWyKMJgIU6YwMZyYAu5Qr9E8UYbYyRBUA6/gUyOzIpp+R9CVIO3gV4X/1NbozOI
	qV9oVqJUZ6lQ95fuMTml5vWhAvAyJyXwX/Oys6Rc3ZpJ5Tplm6ORUdvBaD2qV4JCBte7GX20Cdc
	DHxMojQ==
X-Received: by 2002:a05:620a:4613:b0:93f:1789:8359 with SMTP id af79cd13be357-944133bf945mr2719600885a.31.1793725157802;
        Tue, 03 Nov 2026 08:59:17 -0800 (PST)
Received: from localhost ([2600:4041:59c3:300:a850:2af1:eb93:4121])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d3410ae4sm5514285a.26.2026.11.03.08.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:59:17 -0800 (PST)
From: Axel Mierczuk <axel.mierczuk@1password.com>
To: ja@ssi.bg,
	horms@verge.net.au,
	pablo@netfilter.org
Cc: fw@strlen.de,
	phil@nwl.cc,
	netfilter-devel@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	w@1wt.eu,
	Axel Mierczuk <axel.mierczuk@1password.com>,
	stable@vger.kernel.org
Subject: [PATCH nf v2 1/2] ipvs: validate cport in received sync records
Date: Tue,  3 Nov 2026 11:57:45 -0500
Message-ID: <20261103165746.39516-2-axel.mierczuk@1password.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261103165746.39516-1-axel.mierczuk@1password.com>
References: <20261103165746.39516-1-axel.mierczuk@1password.com>
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

Local templates have cport 0 and IP_VS_CONN_F_NO_CPORT clear, so
ip_vs_conn_in_get() cannot match them. A template received over the
unauthenticated sync protocol with a nonzero cport can reach the
protocol state machine. Before template state validation, this
could cause out-of-bounds reads, crashes and kernel data leaks.

Ordinary records with cport 0 and IP_VS_CONN_F_NO_CPORT clear, or
with a nonzero cport and IP_VS_CONN_F_NO_CPORT set, create connections
that incoming lookups cannot match. The latter also keeps the
cport-zero fallback in ip_vs_conn_in_get() enabled.

Reject all three cases. Continue accepting ordinary connections
with cport 0 and IP_VS_CONN_F_NO_CPORT. The companion patch
"ipvs: filter some flags received in the backup server" rejects
template records carrying IP_VS_CONN_F_NO_CPORT.

Fixes: 87375ab47cd0 ("[IPVS]: ip_vs_ftp breaks connections using persistence")
Cc: stable@vger.kernel.org
Suggested-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: Axel Mierczuk <axel.mierczuk@1password.com>
Acked-by: Julian Anastasov <ja@ssi.bg>
---
 net/netfilter/ipvs/ip_vs_sync.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index 157f5c8361ab..a85dc95e29cc 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -853,6 +853,25 @@ static void ip_vs_proc_conn(struct netns_ipvs *ipvs, struct ip_vs_conn_param *pa
 	struct ip_vs_dest *dest;
 	struct ip_vs_conn *cp;
 
+	/* Templates require cport 0. Ordinary connections require
+	 * NO_CPORT exactly when cport is 0.
+	 */
+	if (flags & IP_VS_CONN_F_TEMPLATE) {
+		if (param->cport) {
+			IP_VS_DBG(2, "BACKUP, template with cport dropped\n");
+			kfree(param->pe_data);
+			return;
+		}
+	} else if (!param->cport && !(flags & IP_VS_CONN_F_NO_CPORT)) {
+		IP_VS_DBG(2, "BACKUP, conn without cport dropped\n");
+		kfree(param->pe_data);
+		return;
+	} else if (param->cport && (flags & IP_VS_CONN_F_NO_CPORT)) {
+		IP_VS_DBG(2, "BACKUP, conn with cport and NO_CPORT dropped\n");
+		kfree(param->pe_data);
+		return;
+	}
+
 	if (!(flags & IP_VS_CONN_F_TEMPLATE)) {
 		cp = ip_vs_conn_in_get(param);
 		if (cp && ((cp->dport != dport) ||
-- 
2.50.1 (Apple Git-155)

