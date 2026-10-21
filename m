Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792596440;
	b=AB39nS2XgEKXItmXnnRQ+mMnxXyBt54X6z5WpxhBucwkHanUn9nCn0/X0Aw/BKMcrPme
	 hW730IA49jAeD2Yj4bGDZhTGdk5zJkFkBe7j6f0P01AQMC9DyHYOTwANlX34Mkx1Z/3yn
	 ekIV8t1ceroknygUSPpShY65+95Wtos1rvvtOvF2KoZEaqdgEW53bmtfMvjvkUKbvDDuJ
	 6psdZo07r1XKzE6M9rbm7LovrrCOUKR9Xa97bPSEDgOWwNpVk4jGBkFEAjnnpj+5Fkyvy
	 vlJgnyODjLNn5MNq0z8j3Sp2m6Axxk8B75AzEdDLBKRDRlW688dw+0VJL0HZax1iD7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596440;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=jgAnNPRw4bl7KLoUTwKbk6oRViEcdsIxPyek4/jTHZc=;
	b=uGD+SL902l8q01GI9KTbHwqJERwfTJwSf9vpAQRTgzAW8EXqt52Q39+yvqpRlEcmOuRu
	 wdIFScBpmyt9gzSSKe65dmS7AZd4jd2TGHfUQJDkhKbW4XVe58XVQqt5nTsHcDXjX3mZu
	 zvWJLeL95IRlcJiO1NY1CathCkY2Rlpv5t9YJRo5zcF4ek4lMYdakTFdJRuAX9nm1TJW0
	 Dw9LDq6baLY0kw/y2RH24yldGzeFfm45KYAZtxElYShwh9e3ql9sPT4KHGidRF3GrSQCk
	 XinJuTgpj/yfpPsDewMrp7t+WpC3BGEwMNgtZb9gz95jR9Hq/aMNh0GNyjoKBColk/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--gthelen.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RWx0T6jq;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C8C606A320
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 15:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64C8C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gthelen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RWx0T6jq
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3510d0baf63so2015202eec.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 08:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792596438; x=1793201238; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jgAnNPRw4bl7KLoUTwKbk6oRViEcdsIxPyek4/jTHZc=;
        b=RWx0T6jqAP4HmT2K09lvjwGaIFrNgspwI+GiEccvd37c5EIofQ2Z90i2VF0eV+9EtW
         QNuan04bsuIV5lePSClR20Yf54OtGxfL0UNC+1+iheIhH0M5Qv5EBYDmJ6C8S9St0NfV
         wQDR/4VN+ylTCPqz1GJKvI2H+gchcDZETgzsXeJzL6a2rKrM3lsTkbxRZEUopeuCnzdO
         +YeaVdSfb3opdL8y9vnYKrSoLD+KUp4X49ruFZOYhcXq+DrJVrgi/LWtkQ86F/296Z9I
         FvnVC2aJhOKeHwyRNjfNtDNCu84/oj60zWLdKJeGupNojRFVl7Rye1eL3NLIM+LEVunE
         zuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792596438; x=1793201238;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jgAnNPRw4bl7KLoUTwKbk6oRViEcdsIxPyek4/jTHZc=;
        b=mbV7Sj2aKIj1LNHWGfWO7DmyWDPuorSP2CxbriF11bN9SvTRyrVbp/dJgdSpkZnM3/
         YqOtuQk6vAop0Az7RThxIu1c9duiQw2A7A1qNWRvlM4KzR2ZKxhqs/wiWLEsxZ/IJ0uG
         1xD0IegpQpL0hpoZL+pZwAux9kDITvE715ziHx2kS2rfsrhS4BsNZPzOy8aE0PaDklNg
         juvlRhZQ7b2sEGJypJeK2FdRqxwywAwAK9xsVT8ytQmBEuIGYi5mlXYkh2IJBfklaGm9
         HCrph8uU/MMNdK7tKbxSKeq7hh12EynFp4xyBCg9yq1pDFv2sRUGpf/gjHGsG37UGKeT
         Inpw==
X-Forwarded-Encrypted: i=1; AKwUvBxR4hZ+Ii+WTG1fwEpELN0GWZbp2y3anmFT9nFVNWmDF3wqf/w5UFoi/6sF4IZiiu46DutZsoA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLia9bC9FxKmvdEVR2/lOmX2iysGghZsiNEFkkVU4vuebHG/ExU
	DvSxVe5aq/lQs+aSrzgYZh+B6yhAr6tDE9r0ivROWDLuLJjaYGKm2wnaVwlqEjwLiCbyBaet8TP
	tUVVVFIQOGA==
X-Received: from dycpq4.prod.google.com ([2002:a05:7301:fd04:b0:34d:46b2:7513])
 (user=gthelen job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d185:b0:359:a6ed:41ab
 with SMTP id 5a478bee46e88-3674db50cd0mr3750142eec.36.1792596438073; Wed, 21
 Oct 2026 08:27:18 -0700 (PDT)
Date: Wed, 21 Oct 2026 08:26:58 -0700
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261021152658.2618709-1-gthelen@google.com>
Subject: [PATCH net] selftests/net: tcp_mmap: remove unused -k option and keepflag
From: Greg Thelen <gthelen@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Soheil Hassas Yeganeh <soheil@google.com>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit aacb0c2e524c ("selftests: net: tcp_mmap must use
TCP_ZEROCOPY_RECEIVE") removed the only read of keepflag in child_thread(),
leaving the file-scope keepflag variable set by the -k option in main() but
never read. This triggers a Clang 23 warning:

  tcp_mmap.c:91:12: error: variable 'keepflag' set but not used
  [-Werror,-Wunused-but-set-global]

Remove the unused keepflag variable and the dead -k getopt option.

Fixes: aacb0c2e524c ("selftests: net: tcp_mmap must use TCP_ZEROCOPY_RECEIVE")
Signed-off-by: Greg Thelen <gthelen@google.com>
---
 tools/testing/selftests/net/tcp_mmap.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_mmap.c b/tools/testing/selftests/net/tcp_mmap.c
index 487ae659a1f1..86241bed7f08 100644
--- a/tools/testing/selftests/net/tcp_mmap.c
+++ b/tools/testing/selftests/net/tcp_mmap.c
@@ -85,7 +85,6 @@ static int rcvbuf; /* Default: autotuning.  Can be set with -r <integer> option
 static int sndbuf; /* Default: autotuning.  Can be set with -w <integer> option */
 static int zflg; /* zero copy option. (MSG_ZEROCOPY for sender, mmap() for receiver */
 static int xflg; /* hash received data (simple xor) (-h option) */
-static int keepflag; /* -k option: receiver shall keep all received file in memory (no munmap() calls) */
 static int integrity; /* -i option: sender and receiver compute sha256 over the data.*/
 
 static size_t chunk_size  = 512*1024;
@@ -456,7 +455,7 @@ int main(int argc, char *argv[])
 	int sflg = 0;
 	int mss = 0;
 
-	while ((c = getopt(argc, argv, "46p:svr:w:H:zxkP:M:C:a:i")) != -1) {
+	while ((c = getopt(argc, argv, "46p:svr:w:H:zxP:M:C:a:i")) != -1) {
 		switch (c) {
 		case '4':
 			cfg_family = PF_INET;
@@ -490,9 +489,6 @@ int main(int argc, char *argv[])
 		case 'x':
 			xflg = 1;
 			break;
-		case 'k':
-			keepflag = 1;
-			break;
 		case 'P':
 			max_pacing_rate = atoi(optarg) ;
 			break;
-- 
2.56.0.212.g129ede20d9-goog

