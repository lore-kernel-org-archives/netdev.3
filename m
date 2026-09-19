Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077B63955FA
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 21:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789854768; cv=none; b=ceWrE8c9+XuywQcjzAUoiS96FYZDljaN0W4eBlFsqxYlkmCHMZQ+0C/6sxzKYSal5uOf3CiAANdSg2XC2pqdO4bt7IpWW4LHRS9HOSjK/YzO21cSqRMx3uQPBCkqeSN2hX7iLGQR5P/grkOfIOppvnPs5/yLsYI/N7fd4ov2RX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789854768; c=relaxed/simple;
	bh=Xbiwc9bTp1EkEubv1D0ViMYzOvjn+Eu93wu8+NPZq3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=in459W/UfQa3WZqSi33+8umyr33mbbgHv9/jqW6+FkNqLsJ+rYRqa42Ok8rEPFclBxojR2DyhGkTBiUi0q/CkzlOfmRtQcv0cwuvVXJDxbd9I0dOQfAA/rPf8ynA0K/Z3MDWlm4IS2dwOmmBZcDBMNEAwLwimYNM12EvU5oDDqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c84LeiK5; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c84LeiK5"
Received: by mail-pz2-f41.google.com with SMTP id 41be03b00d2f7-cc50d1b048eso1584161a12.1
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 14:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789854761; x=1790459561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2znhlPEKl5shf6DZQhAnyPMd22p0ZtJVE0FQV7SgyoE=;
        b=c84LeiK5KeMz8Nlq7quRXgYSoeZRjIoeoGwJHNzTTOeEM+sGoYGKZKPC9tQBq00N9g
         tWssRvqiVzlTRAES7PzgE8AkmcQ+mpVvkMIbO06MNKQS3ZF93D4TK8tmeY2KA+qTFSL9
         GxpLnTgDSJatWGqVWsnSqerZAQwBm/oCK5k/70qoBRplMhGZjIVftLB9pAagTWeq2iG0
         36o2ahUzCuFX6xfoNBZ5K26cd7/l+C+c1+Hvw9dzKW9OBT7Fglu92hZJ9LYV3Cu1exgO
         zyBt+akCov6HpJ+ppy5zssB8b0KbIiGMoyOqrjibRqM9TNdoS+H3xTNXeIK1qA6qoqMd
         V00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789854761; x=1790459561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2znhlPEKl5shf6DZQhAnyPMd22p0ZtJVE0FQV7SgyoE=;
        b=Y8p+HmLBIV4roHrmmdDSGb8RPTk+ZQx6dZM1GNqWX+y8s5ecczAn18T6u9ovSEzrUM
         WKrNGi3igqIhAK/9ltWrrrJ4D9Fh7w40lgxRo0KCSBrppCclCkEZBh3CESRsOMaWs3Jj
         wPRpWBwKvCq4fHEFdOBW1tpNr/LzhgwOZUH4n7O3IHUp6qNwQm6WXoKJ/8xr9MDebUTD
         Vv/+Tt45FzK5NSyg2Lfpitq+xcWDKDSMJShWH7HtydxRMsk6222fIcySAVpj3v/2VY9B
         OGdmNcx+JVPOybm6YYA6/oBBloChlbjvzvL6vIWbF/QQ7p5QMGedCBZOTkKL+hsRGsga
         f5JQ==
X-Gm-Message-State: AFuF++lQRwgeZX++j50BaS1hBg+BRVePVS74f3gR1ujrnTn+lnJQ+H/e
	3xMHQ4f6vn5UVYauZs3Xn6U/A8XjODi64h/sgCGzbfJZgP0U9OvJhJ62
X-Gm-Gg: AYBFou1+fFlfWlHiOczXGLRT808y82ah3j+/h7rr+V5hoaSStrSu0kXkYm3TL8Tsb3D
	jzebDk0UOFWxtZqWK64WS7V7lSpzE2DmneBcKrspf1zPeM9AB3mD50p2B4RSHfEEBhM+Emd4RzW
	xtShxFsf99CUjM0rjEJz+NA4jsk7kWb1LFJ2bD/RB5QWsLaTvhTHmApLNGpPnGEHYgTXnqnYJuW
	YlpUrZo2qFPp8Z3DtbMK20evkiR+ctRwjp1atyMhB0e8FGLTXocNur02DU8sn/x82OWJNjkL0QB
	XNN2ED9RZrLHQsOAs+kaB7QhfSrOG9LdUTWxYvExt7Aq62pUIHV0c+na+M5JIz8SCq9+nEkMEfk
	lUntHXKQNwiifLOIEa8jhT4m+4zi8zC+wclXgVnNz67yicvOWgO4KESgZlGZwJulgQQHGxEp9zj
	/o/shMA7YiduxLIaq2OYMCsYRjdNJ53g20SS14CNyYtwqcSZrUQau6PviBBCOkvL/xcobE66hYV
	0Bz2VMzQcZXtns0OrBTg7NdDhxFPcJeSkwPZ5PKUcZl/MgSh/dnsnuFSjNprM7BDEs+5l48Z33H
	UAuyxHmiXiA=
X-Received: by 2002:a05:6a21:32a2:b0:3db:4e0a:df51 with SMTP id adf61e73a8af0-3dd8c5297d4mr12663880637.22.1789854760987;
        Sat, 19 Sep 2026 14:52:40 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc72ae8bf29sm1329321a12.12.2026.09.19.14.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:52:40 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] xfrm: validate protocol for XFRM_MODE_ROUTEOPTIMIZATION in verify_newsa_info()
Date: Sat, 19 Sep 2026 21:52:39 +0000
Message-ID: <20260919215239.3471352-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In verify_newsa_info(), XFRM_MODE_ROUTEOPTIMIZATION skips the protocol
switch validation, allowing IPPROTO_ESP, IPPROTO_AH, or IPPROTO_COMP states
to be created with XFRM_MODE_ROUTEOPTIMIZATION even though only
IPPROTO_DSTOPTS and IPPROTO_ROUTING are valid IPv6 route optimization
protocols. Enforce that XFRM_MODE_ROUTEOPTIMIZATION is only used with
AF_INET6 and IPPROTO_DSTOPTS or IPPROTO_ROUTING.

Fixes: 060f02a3bdd4 ("[XFRM] STATE: Introduce care-of address.")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index a2587c7e796b..2be800232847 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -698,7 +705,9 @@ static int attach_auth_trunc(struct xfrm_algo_auth **algpp, u8 *props,
 		NL_SET_ERR_MSG(extack, "Requested AUTH_TRUNC algorithm not found");
 		return -ENOSYS;
 	}
-	if (ualg->alg_trunc_len > algo->uinfo.auth.icv_fullbits) {
+	if (ualg->alg_trunc_len > algo->uinfo.auth.icv_fullbits ||
+	    (ualg->alg_trunc_len & 7) ||
+	    (ualg->alg_trunc_len > 0 && ualg->alg_trunc_len < 32)) {
 		NL_SET_ERR_MSG(extack, "Invalid length requested for truncated ICV");
 		return -EINVAL;
 	}
