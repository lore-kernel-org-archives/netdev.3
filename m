Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7F539768D
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 21:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789851986; cv=none; b=ocNuqeX9IKo4i9eKWfURDQoMHuEa2qkGbgz9Yr2KEktwDEQC3t4WVHP9jp4GYOfO1h4Y+sh5+Uz0IefdhyRnpQUAT6OQtmYBiMoSbYhM0xPznjzjs+w33XX97Irns6MnQLcyHOG2Y2tJgJL2/UywkO3K4/ptgKxmuH0rmDSe3S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789851986; c=relaxed/simple;
	bh=YpFXCcWC+f8zfq50jLpqo2PhwT5q/u9qcZiP7EW/z5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u+WVoB4AreHoodAiFXfXnsE9d/fruxQ9htDdSe/scPWTKhUD5LNE2vfW7iZPbw1KtAEc9hMK2ITUo2I01tIOh+g8GXBjdVtX53aXPcXibCJSbgzJkE57LDLwzNQd6J9c+R3E7sFbHEXpEDkW6aNKMjqoTvXXTylMi6Pknrnh8EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GF45jw8s; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GF45jw8s"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469f204f6so1225612b3a.2
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 14:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789851985; x=1790456785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=esxfXy5+ZI00ZmVTGFChQhsw5tJgHXOLHzaPDUlQPf4=;
        b=GF45jw8sXIIhEY1CVoWh8USyC+mDrhXjY1qRn4XjAoKWnFSieopFFysDUfhXRKwulX
         +d13DCtxlgewFf3ZOwD/rB7zCbumxS9njOYTrOSTQBbnY67zy8TXs8mXKDJhzIZYLEY3
         h/0zUCaUnzTSta1O4m6hg+LNHwLu1+eaGeSb9xtr0ErXBMkuiwGfz8Y+plMYuJYdNqXF
         1DAHa/73neij5A3W56bp6tjApLTwjeDr0l6h+7iQtq6pRFsZSVT/WT2YgS308d+BXtvj
         F9p3nN9JgqUoQhmRng7iVMhDpTJ6VDGA4WggqmkVbPtnoYAlkyizXM5U2AkzK/sYe5r8
         Z28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789851985; x=1790456785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=esxfXy5+ZI00ZmVTGFChQhsw5tJgHXOLHzaPDUlQPf4=;
        b=zchxzPUgsekv6f1Q4xXxLjEIY6m4D9cIQZYXvThzhjt2Wu553bfyKvphcpAWshGMg2
         y3WNtBekjuNU70VZsa2q6ZAuUQlsE7xvjvKbYFu2NiFS0k6+e14w5fUQtabzr8F1qqva
         HvUyXuDeCmTRFZor/K1fXT//Y7/wQWRd9xM7FCOlCQf5kmRnmyWmTHfluI2XoBvLi9mO
         uWyx2BrS6k/ArVNuibrC98W5a6UQXHmkh9KRcGjaM2D4FZqpBlzpkE6IVZb3WMen52M7
         Xufl6Gka9Y39UfaOVd6UeRpd+bauoCnWJ7l41GUpDWu9SIAeXvns3GIbVVXXS5+zddbs
         +zPQ==
X-Forwarded-Encrypted: i=1; AKwUvBx+EzA/n5ymkJLGJSMQ8d4A9nXj2ouo7+z1+r4WQm9gfgu6ms12vFKKCLHSGRV3C1KsyLUEyo8=@vger.kernel.org
X-Gm-Message-State: AFuF++kSmnvbpbisXHKD17scE5xLw6YlzCPNGxg8kLCSqoYgKEDZmMKa
	u6G0aTHKXaoPZ1XV8K57B2ZnRFTSvwQu6U2aU4cHVLSoJmxrcZkpralU
X-Gm-Gg: AYBFou1zWHVxf7IzqOXLFm3iqllbOXXZ7d09qdSVWrkXkiL0j7DCW2QObfcLPhxASUF
	XmsXZm5KFz9DA0GujWpD+g25RsbzYODd+WH2vD03yYX662h15k0DvASyaz5jmr4KduL0mj2fmRT
	nrb8POju7dW7l+7722iFg1fwp6LXxnmkdzoW6T48dsoDNfHTD9fmrkCZqeclpEeq2M0M4nuZuVI
	uYuwESVxOsCbtf4StAUsst5lYBd+LP7G4Spq/6z/wQ3tHTYpr1b6f8S8kD9UZmupJSWcFPT/44X
	+jr2mLAiOKpNLzkWRzfKHlDtc5EEhLTK/Bo0P8xhrUJC0Nu9fxhnJsOHAQ9Jon5oBxHqJXt/WLt
	Cpwj2sNS6aSgOfBHQDoJpv8BGfh/OgvzIl8NAvh1+C4vmUteq+D/p7KVbkBaMKi0Nc+E0rWCBog
	+aibKUaZajWtEi89/rkmyjE5JAeyVqb4Ulq+nGin6Z7kK3WutE37g725bmjrd4lB0JDPoOywy/8
	bxT8mZHU3SSElbRZ1NOlaBhmYBuu6FrnPs24Zwqv3EVG6Y0coT8lam4DouZ0sUCIs1E1xP5y/NJ
	lXgaz4uou2rkmOtK/5Lw
X-Received: by 2002:a05:6a00:37c1:b0:878:391d:b217 with SMTP id d2e1a72fcca58-878391dc1e0mr1745784b3a.60.1789851984644;
        Sat, 19 Sep 2026 14:06:24 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a8dfe20dsm1341051b3a.19.2026.09.19.14.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:06:24 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] xfrm: reject sub-32-bit or unaligned alg_trunc_len in attach_auth_trunc()
Date: Sat, 19 Sep 2026 21:06:23 +0000
Message-ID: <20260919210623.3030144-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In attach_auth_trunc(), userspace supplies `ualg->alg_trunc_len` (in
bits) via XFRMA_ALG_AUTH_TRUNC, and attach_auth_trunc() only checks that
`ualg->alg_trunc_len <= algo->uinfo.auth.icv_fullbits`.

However, ESP and AH convert `alg_trunc_len` to bytes via `esp_authsize =
ALIGN(x->aalg->alg_trunc_len, 8) >> 3` or `ah_authsize =
x->aalg->alg_trunc_len >> 3`, and pass `authsize` to
`crypto_aead_setauthsize()` or `ah_init_state()`. If `alg_trunc_len` is
not a multiple of 8 bits (or is between 1 and 31 bits), integer division
by 8 truncates the requested bit length (for example, `alg_trunc_len ==
7` yields a 0-byte ICV in AH, or `alg_trunc_len` not divisible by 8
mismatches the ICV byte length between AH and ESP).

Reject `alg_trunc_len` values that are not a multiple of 8 bits
(`ualg->alg_trunc_len & 7`) or non-zero values smaller than 32 bits
(`ualg->alg_trunc_len > 0 && ualg->alg_trunc_len < 32`) with `-EINVAL`.

Fixes: 4447bb33f094 ("xfrm: Store aalg in xfrm_state with a user specified truncation length")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>

---
 net/xfrm/xfrm_user.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index a2587c7e796b..d56a0095113b 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -698,7 +698,9 @@ static int attach_auth_trunc(struct xfrm_algo_auth **algpp, u8 *props,
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
-- 
2.55.0.1082.g2b9226bbc0-goog

