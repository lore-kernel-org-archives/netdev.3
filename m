Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A741F1304
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 00:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791766144; cv=none; b=Dg89AcvKnPRqHPbDXV7OGqH+Ig+2JoZeXeqt+V7VJja+rU7Rm38Yk6mseGoJ3SastKAsjmzVxMYrAmebuMGftFRxeohyAHR619rg7XQAyQwlx4XR5MIufWyjg5hh3l1PMVJ/oqCsWVegovFBmUFIsxo0fVQ6Hyq5KBWx4eVX+rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791766144; c=relaxed/simple;
	bh=B8Iqo2n2gFKPdXvU74FYTYllWxQE/TCw3uR+VIrd5JY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RdLAmLqj4o6/axoqkigf9fRNfFlteLvkrLI7VWDcyHWY4wvVTq2LxvlJkgGl6is4vTmh2N4voty2z3nF8BBO9YlMAsREnKo+ZRD7LVlZv0oyoZtXSjMVxajVESo2TrJrLbn7mOd0g1Kps0JqPrVXQ24iOp8aRNBIbfTfo9lvLNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=HFZBuolN; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="HFZBuolN"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3a4b9732d5aso974104a91.3
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 17:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1791766143; x=1792370943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G2ef+Te90BfoRSK6y6c1uYPZF7eCsf1KZDpG57Mozj8=;
        b=HFZBuolNFo4a4jxuSmjOcqTdkA/LuX2rilA+4l7NMJDiUkiD9U8uxojYK4QzM/09LZ
         8SZDEjpnySIDR4DlYXNKB/xyE5z6atOsVvy/FDBpwuBq0O4uPb8ygXM6ToZq68YbAnqL
         wwbbxEZo+Qq5LPXa/a2q1pFCOuf1qGK57bECqvyuzWjQD8ATJFasnHpFzVb4q2SSjQIM
         rmp9dhyXKYMbAI8fMsK0SXZNIuBFKevpg63X9TYDA0teuqblHcmrqs34lJSWyX3BLrh7
         YxFvN1dkA2yu1qHvSdHGMNM/UvsBmN/2o559Mei9WY4L1JZxWXQoRp9fSax5f9TZbxw3
         iTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791766143; x=1792370943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G2ef+Te90BfoRSK6y6c1uYPZF7eCsf1KZDpG57Mozj8=;
        b=gBT5Zmq3cMNWeFZjCrw6DIwACdLWp87PJCZx+pnETfaoeFYADBBvWIiii3Fqd8we2z
         slE3klRo4ekOVRKAEz+UtLIjLizl0dyoc2jRqyr3LTQBvMojmnB7ltisBZ7ldz2hF9dW
         GMabrGxZ0JRthk/ixL6ROU1M99h0jcX3I+FcmWAmn5+iDipmHjbyxJvEOCuzTGjNX9ir
         vbjAJPMWO5+7H4ae5f0d0ZOoJJbfBGsS6wSLDDDWyYC2+E++j2yH8kwBlMB8yMymLVqP
         L0V4Ey/yibc/vbjW3/NIqENX3QXiRTK+1snP9Iv1vlRA9JnEW56uQuc0iKms23Ii7WTM
         z9yg==
X-Gm-Message-State: AFq9FYLdOsYKfYPZPHLvVM0C3h9/gDHAlmO2jU9+zXN0hgyUdoaMZGhP
	E8KMxMKsXGaQ1mdS/EK33vuHjO24xeorkem52WWdHcmCWs9+ZfajgIlEA1fQhKYQ+/ZlbzIXR8Y
	f18ZH/0lO
X-Gm-Gg: AYBFou3PJipaRXcEGmtHdzOsUFe7KkmvnhNIsLa1HH7VIVJA07q7n2TQRlqciZti5Vt
	l10K76AVez8e7CsIcVq/oxL/HZA3Gge0PTejdCfd92ScZDhvVyUqcwIh6GbV0Y0PBVu3HSQtJ4R
	tV58lSybNC3UerlAFYOchywmHDC12j+wdamoB4Ba23qMgoNjDXxtCDrFtzBlrssuQGtlpUe8a5S
	OgW4IVxsVS5BA+bhKbH/W7w0+cQwN6IQhlWbf7iQBQTFXStKm4jvHiQJwCaOqBbi+26oEhoNfX7
	/hRN8Wr98BROcvGc75sgu3nbOMi5QmhN7VEAImMXhry/KRIlpCZhcVNqqbHf19NfRwfooho3P+O
	sW4PFGhc8DHN9hpRukiPQGD/wvXRpjraQiolkDbyX/MJcLTXRIDVLTRCpiue6bdhEOfh21a2It6
	H33etK1S+fbqQ37C918mhO2K3Vt1DxuyW2ggRr5jO11tcBEMuvGIi8QvB9WHHDWDr+7YnurYXdm
	KgZD5RU
X-Received: by 2002:a17:90b:5845:b0:3ab:c80:936c with SMTP id 98e67ed59e1d1-3ab3a98f7ebmr6539690a91.33.1791766142616;
        Sun, 11 Oct 2026 17:49:02 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([191.222.220.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36f8277bsm13815171a91.11.2026.10.11.17.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 17:49:02 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org
Cc: courmisch@gmail.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	remi.denis-courmont@nokia.com,
	vega@nebusec.ai,
	rakukuip@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net 1/1] net: phonet: ensure headroom for aligned GPRS TX
Date: Mon, 12 Oct 2026 08:48:51 +0800
Message-ID: <eeacc6bb1a121b6161c38898441997ea4641e5c0.1791616268.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1791616268.git.rakukuip@gmail.com>
References: <cover.1791616268.git.rakukuip@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luxiao Xu <rakukuip@gmail.com>

gprs_xmit() forwards the incoming L3 skb directly to pep_write().
When a server-side pipe has negotiated PN_PIPE_SB_ALIGNED_DATA,
pep_write() skips the wrapper skb allocation and calls pipe_skb_send()
on the original skb.

pipe_skb_send() prepends the pipe header with skb_push(), and pn_send()
prepends the Phonet header with skb_push() as well. However, the GPRS
netdev advertises hard_header_len = 0 and does not set needed_headroom.
If an skb with insufficient headroom (such as one redirected from a veth
interface) is transmitted on an aligned GPRS pipe, skb_push() underflows
the skb headroom and triggers a kernel BUG via skb_under_panic().

Ensure sufficient headroom in pep_write() using skb_cow_head() before
sending the skb on an aligned pipe. If reallocation fails, drop the skb
and return -ENOMEM.

Fixes: fea93ecef619 ("Phonet: zero-copy GPRS TX")
Cc: stable@vger.kernel.org
Reported-by: VEGA <vega@nebusec.ai>
Closes: https://bugtracker.nebusec.ai/f/1935
Assisted-by: LLM
Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 net/phonet/pep.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/phonet/pep.c b/net/phonet/pep.c
index bd1cdd00edfa..9d24b370fb7c 100644
--- a/net/phonet/pep.c
+++ b/net/phonet/pep.c
@@ -1259,8 +1259,13 @@ int pep_write(struct sock *sk, struct sk_buff *skb)
 	struct sk_buff *rskb, *fs;
 	int flen = 0;
 
-	if (pep_sk(sk)->aligned)
+	if (pep_sk(sk)->aligned) {
+		if (skb_cow_head(skb, MAX_PNPIPE_HEADER)) {
+			kfree_skb(skb);
+			return -ENOMEM;
+		}
 		return pipe_skb_send(sk, skb);
+	}
 
 	rskb = alloc_skb(MAX_PNPIPE_HEADER, GFP_ATOMIC);
 	if (!rskb) {
-- 
2.43.0

