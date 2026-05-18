Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA4A37F8AD
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 03:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779074499; cv=none; b=NDB5eNpcyXkJuYCWHHjC8A3RlAN2hupZfL4bwguzoLjrli4PgGTw9oydMZxX20WvTE/Tl4+Cg4l+WS42y3GurlimzloQdr27vjQ9297lU2HNZUZ+75X93yQB9IPRlnyXht38cANa00GND1Rw6iDrYEpiEgcVdXUvlvABhgZ0udQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779074499; c=relaxed/simple;
	bh=8bCQ/Iq0u1Lc/T7EX5SaevBnrMvazcgDznT+azAO2vA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=laMeV8prFbJFodZ9TUhK6WfMmbjlFUGHe8BBWc9yyBKcrb5WM+3aq+COi/FESV8kP+H/IRxZFPMpNBtyIJEpFWgb0n2/fHBIsif8Ma2GdLG33B6VSH5opj+TZFpla9COzH0Fv7xJR3BpD80DOcT0CMirU9AAj8pVrvLQnneu6Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcEMbVA9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcEMbVA9"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b9a1896db5so4135205ad.3
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 20:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779074497; x=1779679297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RAFWkpA8YXLduhYX0RXRsoHuIKAwG9yvc6tBTptmV1U=;
        b=OcEMbVA9i5Ix8g8UOdkXYaZOmwDXtRS0zUElvzVEiVOA5iXzodmwlm2Du0J2rtXUSG
         s9whm08U5l6/63IGVll7mxhzjnC0gzmfGnrANzUzHe/68eK4c/nplABqbw5ibSuMpbsg
         /GhSpDkrllAyRBWQKBODQFjTu/zR87T9enS4HfpSSWuxn9w3wcGJ2eOPFgJSt+hOpLr3
         lxZ6iSacZ4d0CNg+DZHQdN2GWLk4h2gIRTJivFxV0eJOhLP+mhGzGbu/cWzYfYEHrLWR
         t2b4M7kgWjsUo7ic1tz5QDI2ggiW48hRNVk0CV5iXuvF6644xz/fS1itatnCydxRPjd+
         gtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779074497; x=1779679297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAFWkpA8YXLduhYX0RXRsoHuIKAwG9yvc6tBTptmV1U=;
        b=ijd6cTDwX6YFzYmPCqwwP57DNM9J+tB2tnkwsYO7coZssaH1FaKOZBKUuKjSRNjfRL
         I6XoNEFpWP4qFFfF9jc3n+WF8b3bs4sI8Mw7GKD6OpQHsEapj/1Z6CsuFkUV69RgBWIO
         BZPhyxHgWmW88XR9YsHniRFSsnfnXZ98fpKdQ7dzVm0Xo7JVD+NN4gWlc5FPEee1eQYH
         +bxh+XVKsFIdXV/+dCMgzU9ows1LKLD2m/eaeja8IYkuhb8z0DD3cHGuuuhBrb6t6oQ4
         EhL2CwmMc+1jdJbZS5rAIJ4i1QWylniqwoebS/5+TS66XMLYkbND/54JFmoc9J2T3pNg
         5RwQ==
X-Gm-Message-State: AOJu0Ywy55zub5KkMr6oCkoXuvrD5+TO1OAQAMtCGpr48jitdKctsPRp
	felDgu4KXnyY78Usiep1PeJ/XJawn4FOEl10qcgGDZ7lZi2oqLP+6Kws5TF4nl/gaCk=
X-Gm-Gg: Acq92OFTPNGM+RGU4u5B66PW0g/fEjsEg8kmWms/HWKQfBzjsI725WooW3oT/ZTtFy4
	SHz4fhGjEo9yUkm557Wo62vlGN5JdQFB/Rz81MGN+Dq9E4ST4xs4QoFE1nqhWBzhIRjMV1wvjv8
	ZpJd0pxO4Ih1135OkwSEQrCsIEAWZP0IOHuFnt9JrU2i/rt88Flc1uGdTR4Jm1h0xvrJ0msgO38
	kn5mucMpdST8E185wjv8zTVqecsZDhtZzM1hCHKa/4BO3BMVrJ5W9jzGCW26KWbqzMthSE9eh8x
	n2ibIB+2MIZoNHZyfA2QVElB6CgoE0A0cnNs7907TuUhmTNn6yKA8jY0k+XZIVuPYEdpwBic3SU
	TurprzhpVXaAXcsjzyb6BgjOBy3hwdJopHMwGdYjhfwLq2RYYzPXXHNqOSMHcxW6BUEFO9k6aPQ
	veFLqco/B5VyIM4289ycBIVClWWi6LNkiWDi7pKS3AMcW3W3+ExrS3hHZXlMqRwge4r1h8sqYxf
	N5lOcE0IJDhPz26tnx9p2kdpoR5DHFz2w==
X-Received: by 2002:a17:903:3c4b:b0:2bd:612b:9124 with SMTP id d9443c01a7336-2bd7e23f084mr76532925ad.0.1779074496732;
        Sun, 17 May 2026 20:21:36 -0700 (PDT)
Received: from localhost ([240d:f:a5c:fb00:b9d0:5976:9793:153b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe6b8fsm136391305ad.46.2026.05.17.20.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 20:21:36 -0700 (PDT)
From: Aaron Esau <aaron1esau@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	"David S . Miller" <davem@davemloft.net>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Aaron Esau <aaron1esau@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] xfrm: espintcp: fix sg.size corruption on partial send error
Date: Mon, 18 May 2026 12:21:09 +0900
Message-ID: <20260518032109.616327-1-aaron1esau@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

espintcp_sendskmsg_locked() calls put_page() and sk_mem_uncharge() for
each scatterlist element it successfully sends, but never decrements
sg.size. If tcp_sendmsg_locked() then fails partway through, the error
path advances sg.start past the freed elements while sg.size still
accounts for them. A subsequent sk_msg_free() in espintcp_close() loops
until sg.size reaches zero, overshoots sg.end, hits zeroed entries with
NULL pages, and crashes in put_page().

Fix this by decrementing sg.size as each element is freed. Also use
sk_msg_iter_var_next() instead of raw addition for sg.start, so it
wraps at NR_MSG_FRAG_IDS.

Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Cc: stable@vger.kernel.org
Signed-off-by: Aaron Esau <aaron1esau@gmail.com>
---
 net/xfrm/espintcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index e1b11ab59..6755f6df6 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -237,7 +237,8 @@ static int espintcp_sendskmsg_locked(struct sock *sk,
 		ret = tcp_sendmsg_locked(sk, &msghdr, size);
 		if (ret < 0) {
 			emsg->offset = offset - sg->offset;
-			skmsg->sg.start += done;
+			while (done--)
+				sk_msg_iter_var_next(skmsg->sg.start);
 			return ret;
 		}
 
@@ -250,6 +251,7 @@ static int espintcp_sendskmsg_locked(struct sock *sk,
 		done++;
 		put_page(p);
 		sk_mem_uncharge(sk, sg->length);
+		skmsg->sg.size -= sg->length;
 		sg = sg_next(sg);
 	} while (sg);
 
-- 
2.54.0

