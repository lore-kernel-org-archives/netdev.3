Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1AC485CF2
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 11:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519934; cv=none; b=a7ZrxV4e6OOO18iPanEy+XTR8fkf8K3SJLfrwjc9MjLQi+duPb8tco20WxwKH4SmoFOqUOPFkNLtgykLVx2x0ZhIcvCGfL/XLTwtBK/rdT6U9IWclkL2AxFtcNnbdI7lSFxlJtODlpWc3UvDRbv1C/rGmISFgXrTp1/6HF2siuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519934; c=relaxed/simple;
	bh=N0NRuMnQNT4U5LjQKRjWQiu7rFtDq9i7K1NImELSQZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nJkBLZRWMSqSfrhExC4ZreUTcZexdGqF+ueakKA/kH9nlqRg4fEd2y0wwfhQ6VCd4qoU1fVcocIRCtFeSSmFPOlbuWarA8JiXZyl+FoyK/ZvCCAO0cOAMrzoe4PRgk9A8uKxR62F7P7zco8RjIPHDSvXT0IL0BSxe09fLQCKaeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WedIWgxN; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WedIWgxN"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4a46a53abc9so884579b6e.3
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 04:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788519931; x=1789124731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pUAku8kEB1Qfbu/4zomfSevYTVMYvS8FyB0ooNWeIWg=;
        b=WedIWgxNuAwQbSfvNIB/vFwyt2YQvhyhuRpa6+96rvVlaSgnjGfmyvfRNXwrV+hy2j
         ZsAB9+9N8iFi292JM/eMd2M8UpZ5Vi02Zzi0IcZFHUzmSPj/iL1XIt06QHgRwgmAJ33M
         UN7e08JSqXbU7CKWwmlgtv1hRZjfOQmd9/6thHsIJzuJ0H90WIBIFrgbL2nrS7E7lIz2
         DvoBXWsmtOdVUGXr+xr1scFuiXiI9Y0S6E+1DxlqInQGZhU6f8EliEu2I87l5D8hE09S
         BSDRYkF2+uclEIzoq7xhEk5CRfXL/MEJ95Ry4tnoopmSAB+Pg4/FKVi4oviAUZRdt1EE
         nObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788519931; x=1789124731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pUAku8kEB1Qfbu/4zomfSevYTVMYvS8FyB0ooNWeIWg=;
        b=OohbQs5uqkMVU8HaVQ9yjuWGwL88YQydBEJgptrh11gntmbV02rOZyn7qS7nCbClLL
         CdgTETv6TzCJfDqr27uJt5zqmedNLtBCAUWuREUiruyiiOO6m9L5i4M9pPeAdohkImtG
         FBRWXlIZH1qHzfTwp19fkpcUKW1HowlzsBrkI3VPK8sl7BqiwDmVl//XLR3levnd7zyd
         xyP6IW8BOrE+xnKkJjMqlk8oYK0TetVmiVsuDZAeX/TTS7hIgUHb1BTY6+co/5NE1Bth
         7PwWXTLSHsRjCzUS64pdq1KjLPUcprumR8+QLQWxN31IkqSymtdckp91ztFsj6qZAXy+
         Bc0A==
X-Forwarded-Encrypted: i=1; AKwUvBzAMdjaaedT8Gytvru1t7vW8Ln+jROQSo41TeGa18zx4JBSvgXd8+rln5b/TvZb8MUC5XmlcaM=@vger.kernel.org
X-Gm-Message-State: AFuF++mUQXvXwOMQn7va/cpoDUYPIxvfLCkTzfbPGLumS6Q4GGqh34Fv
	4Wen8jlpKNiay5WEZf+RIYhXBHuOZYvlTKEbVdeEMI2H1ROP/wgXwEC0
X-Gm-Gg: AYBFou1lkSnO8o03Wfe+dN18b02xuSjK11DNHABMVzuGV9FuhXwPKq4U0yMAc+7Wdch
	3TvAg7mMwf5Qs+Vdsq+K5NGBepB2/tCMr0517MfZWHYTQ8EYq1GG0RQc8lLpd0IvAnlB4aS1EKP
	seNRebbrQqqd0X+ZYAU8QALJ39yjpeS1mHS13OrR+lJTfHmSClFPgtPTr6IH/dC5Vds4twPPGrf
	C1Bt85e1zx2vnirfcTA5UnHKaR3M+KuSppxT7o4JWsOOwes2o37Dr+yGBHRm5Oswye8ao41LXeB
	ACcBdEWOZuUj2qmiRlnLdGUQ/5WxtZ92f1uYg9wl6HkMYFFsp2PqFe0rOXWg6aNaPyS8vkHJHDI
	p8IaMxR/BF+1wB13ZE/Mn7MKW/D5lpoOllcmfa0jy2iEI6mO7vjBAJQNQKwz51RC9qSw5Re0p16
	zYcQOOEpMqviyaXwNduLO6ga2cwJM27hJa8swJoVo9dG5/9pMjlb3GApVLGLjy37BfIhUbhW5ip
	vwUzNNLHVn7L7k=
X-Received: by 2002:a05:6820:4b88:b0:6b7:8415:d787 with SMTP id 006d021491bc7-6b78415d81emr1080277eaf.50.1788519930706;
        Fri, 04 Sep 2026 04:05:30 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-333c9db92b1sm5220280eec.9.2026.09.04.04.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 04:05:29 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 1/2] net: sunrpc: fix typo "miliseconds" in comment
Date: Fri,  4 Sep 2026 16:35:16 +0530
Message-ID: <20260904110519.15207-2-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904110519.15207-1-hemanth.selam@gmail.com>
References: <20260904110519.15207-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "miliseconds" to "milliseconds", reported by scripts/checkpatch.pl
using the misspelling list in scripts/spelling.txt.  Only touches comments,
no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 net/sunrpc/auth_gss/auth_gss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 8ddc65e894da..8de85da8ee42 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -1468,7 +1468,7 @@ gss_stringify_acceptor(struct rpc_cred *cred)
 
 /*
  * Returns -EACCES if GSS context is NULL or will expire within the
- * timeout (miliseconds)
+ * timeout (milliseconds)
  */
 static int
 gss_key_timeout(struct rpc_cred *rc)
-- 
2.48.1

