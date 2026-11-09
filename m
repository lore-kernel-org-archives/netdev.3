Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794221590;
	b=xEDtMcCWhmfAzu6soto4826IpxANJZQDcY0S0TAsgzaKpfNxNOSwfcmghLGslyrC7fK8
	 eJV1UBu4NjFeN9PZglLpiiI0EbKTbglkSiaNxs3dEfOAQILZnvXIXNQtzBt0nrBswzVMn
	 5C0BWypWK7UrhsSwuGhKVAGWOQlWSsW+UOfYiwYNBerYaldA1gg1Ehhhz9dVkPDuGzQo6
	 9ofAcOAUYdX0JylSBDBTA4xUdJB5P56nDCWxt0kPpv3xxflmRZGTITrWCxtFPYXx2bjB8
	 fm7tknVVqCb3Tfy4EyO1bYABOzI55478uZbGtENtT4+bLfL7YmuMr1DSFmClANuQN0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794221590;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=B8wcRySJd/dlTtht6qCP4yFXYl/Td0vFc8lSf/i1WTo=;
	b=sC4pW8QroC/QrdwqTFvXwxciPBErWtQsQMxrbBLrXGlFDrLplUu60yVh68hAApAPttQl
	 QMHqu4nsq3GyWtohJpvb6+414Pi+9MPAEePq/LqA92BObC5xcBYiFOXePlh21ExCJUPY6
	 ZU0qT9c8Ef2Fm+zM4P514h0vcuF37+S+3TLPVrHlV6sAjazvImyV0YZ5CAYvT0lsakNGB
	 BwNjENwFvWGFCuFZmpLQxOFo+aXys1otWvd2yhlqG1FPwjHSeWjGP6TIfBzuRTaFEGjxf
	 Gp6C3Vk9nUsRHI06Jko+uoLurxsAvG8xFKycj6kbp+4pjXGHPSHQtSW5ed0h7AX+mrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=is.s.u-tokyo.ac.jp;
	spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp;
	dkim=pass header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=ag8s8wnN;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D903606A332
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 10:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D903606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=ag8s8wnN
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-15ea896ddc8so1347290c88.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 02:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=is.s.u-tokyo.ac.jp; s=google; t=1794221589; x=1794826389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B8wcRySJd/dlTtht6qCP4yFXYl/Td0vFc8lSf/i1WTo=;
        b=ag8s8wnNbir+9Lof0homx1DDFO7cebbc0V5YP8kmlt9OiSkDrztC71N+5LloWADaSB
         MIREdddFLzjBCDaU0rAYi4jtosvgp8pMYdFoMEU1ZNPxC2goflR2DxIb3I9Cx+gb8a9n
         JVE5kUuWlyy1Pf24t6JML2CRYGzkC77vA3Q0zTWoy4dHb8TELmrSXj0P6SBBTQ8CqBx2
         dmAWpkESG9SEXIpJJYKsap5/hJgXdaMdE7I69eWpbbm3+ww6WEfftwIVKPOxXSJ3eRSe
         WDQDkcbTey3ZsEiVlEaOdKz3mo7VVHjP51GUND/XC0H0BWt1eztty6c0/ddDZCK6DL0n
         VXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794221589; x=1794826389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B8wcRySJd/dlTtht6qCP4yFXYl/Td0vFc8lSf/i1WTo=;
        b=ip9JJGbRwbYpaIIC6DT8lpp39MMn0NE6LUprMq3W8JGh3pEEp437XkzXNbKHjaKSLk
         /x2MwJ+Zqfhv1o9kB4DjLdbzC+3CBayQlMOdfFbGDftxIEmZDuvexmySj5/ETIwodZXY
         MC2GlHESVTzN9Sn5uM3TedSQ8Czl9dWTIefEmIx2eJtUB6rUfHc11ZVfp0+k8I6vMmMC
         zJp5qqIMOEN8lWkI11KqHc6by/0xuWOOfVZRlTKSqC0YLjuDPVSgG1LQ8DmAmeUahZvo
         7V7zafrA3syXYUaWyvy4gIOH1iCpGxxn9KI2auQleAdIfhpPrr/Ca8nYBd+xiStXDdMR
         6m+A==
X-Forwarded-Encrypted: i=1; AL+hErE0qludv7c+wF4fCTH2zyCYqW9bWGR2CPxt4HCkTGktH37Ey9HvNYmZ5LMlzy/K/tAwrGhbOh8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/mtE2UfHd1RzeJQAp5A5WOnDKN7N5RUmEMEdmABfLceaWSSn9y
	QGalTSIQNecgTP+GbGyFQzqoq9UyCL7F/Ik782xRvxHFkc7iqNlrJemrWo34hDDzKw==
X-Gm-Gg: AYBFou1zJwfFw7eXNcctPBFCovNS1/cjaD+R2CgkvsWs14OC+KDFGWjJWU6Dwis7iw2
	XboAsO2750JXW/XLpjzExYg80faxGE9y0wEjctpGn7x9fujzUXnHRc8BTzHjLNcRi9ayY/Bg270
	3jSauO5n7VrFWBeGR96XuQhI8sUQKR97ePDHYXby2XQajCviHpR5ex7aXfBbwILIAZrZRgeLKor
	lMxjuw6/kuvzd+wUsD530sHytDdtBot+vyI/mLGFifBmSU6bNBw5TeAZ4aiOGIQgCjV7MAREtMC
	ViIjQIeHz8ZI+Gt7uFHYI60p/hSmrwA+DxcRC6xZXgPaUP6sBYqOBl0ROhMLKLvaCSLA4CkjGi9
	X+BE3n0Csn8JzYKJUslxbim26Ozaxgg0CqEmqy63McsNgAFmvH1bF4bOTuehpjl1UD83dC0aHg6
	6ZvIsnPRGXlaepb09UWur0AeAteIzzswFrBz+H50a3lCc2w5xF/97/YQ5llQKAIsTXrkCyAX7jg
	Kji37LrVb3JsQlZT5J3xrXofvB0ONMfMC6DFC1mbC5UAZDyaVEIbSKoOQAeI1/ICDIp1u4wh1B/
	xCpNj6L4v7ask0XcWqb3eOweEDSTVXydc1kr3g==
X-Received: by 2002:a05:7022:150e:b0:151:6e80:baa9 with SMTP id a92af1059eb24-1b39fe7f403mr6653083c88.12.1794221589238;
        Mon, 09 Nov 2026 02:53:09 -0800 (PST)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b375726fd1sm12228744c88.14.2026.11.09.02.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 02:53:08 -0800 (PST)
From: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Simon Horman <horms@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Tomas Bortoli <tomasbortoli@gmail.com>,
	Chirantan Ekbote <chirantan@chromium.org>,
	Greg Kurz <groug@kaod.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	v9fs@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Takahiro Shinagawa <shina@is.s.u-tokyo.ac.jp>,
	stable@vger.kernel.org
Subject: [PATCH 4/5] 9p: take the tag of a flushed request from the request
Date: Mon,  9 Nov 2026 19:52:50 +0900
Message-ID: <20261109105251.2545764-5-lian@is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109105251.2545764-1-lian@is.s.u-tokyo.ac.jp>
References: <20261109105251.2545764-1-lian@is.s.u-tokyo.ac.jp>
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

p9_client_flush() finds the tag of the request to cancel by parsing the
header of oldreq->tc. For a zero-copy TWRITE, however,
p9_virtio_zc_request() adds the payload length to the size in the header
after marshalling, so p9_parse_header() fails on the mismatch with
tc.size and no TFLUSH is sent. As a result, a zero-copy write
interrupted by a fatal signal returns without waiting for the RFLUSH,
and the server can still write the data after the writer is killed,
overwriting a later write to the same file.

Use the tag in oldreq->tc.tag and drop the parse, so a TFLUSH is sent.

This patch is assisted by Claude Opus 5.5.

Fixes: d28c756caee6 ("9p/net: Fix zero-copy path in the 9p virtio transport")
Cc: stable@vger.kernel.org
Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
---
 net/9p/client.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 66980ad52bca8..15bb939087165 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -477,12 +477,7 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...);
 static int p9_client_flush(struct p9_client *c, struct p9_req_t *oldreq)
 {
 	struct p9_req_t *req;
-	s16 oldtag;
-	int err;
-
-	err = p9_parse_header(&oldreq->tc, NULL, NULL, &oldtag, 1);
-	if (err)
-		return err;
+	s16 oldtag = oldreq->tc.tag;
 
 	p9_debug(P9_DEBUG_9P, ">>> TFLUSH tag %d\n", oldtag);
 
-- 
2.56.0

