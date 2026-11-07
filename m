Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794023313;
	b=4d1yFGlgPExgQUHISq5N01IOI7iI0ccvE2INUK7xz8rPFm6ip40Oansru8fvfLJllzfW
	 sSV1j6ZFEXw7IHbcYD/7vYSvE6r7J+30z2Gvh07oMUJVcuF+zZw7F71QefSHfuA846Ogk
	 u4q/LjsQFwOH3fr7EC8qzVk9qKBu2C8wQYsRZ1U3s4p0eWfys0XXKkMh+qGL2KTF15C+r
	 4iUFRR4RCXJ5GzKNNw7oj6dWjL0VNX0fLCDTK5xN8k1oTEOooakQj0W0nryMLFB5N7Fvf
	 mwIbwhLQx1SBFHnO0qhGg3zm8n/TvB0L4/uCo0w1We/0mSQHpmNU49u/uOcC7HlgDvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794023313;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pngyWx+Vw/q6WDMhlC8hKG9FFVyC3ObnnkppHB+fbfM=;
	b=gjKJh0C6xOQUOGinIC25xtuOHvnkMw7DeJz6p/OTkeVBJnkyeFyLt5Ij05hHBhsG6QkC
	 rtiRF50XFWJByW8FpzUuWUj4mAnJy4sGQmF5MM5/wKSM8N6bBl9gec0WFa5rayor+PA5U
	 RrIgzN9+s2YTMNncHxSMoLfr/n3fZZMAhbMoX4YU3ajevpgO2g4p/WR8Y9emUNDTR28lb
	 XchVRGT98m8+pSXDoi/LcjygcBvL6pIvoke15cRGljSSuBhjzdcy603RIPpfT3l7AzKhx
	 9otu/qQEdSY8k6uvXxT7v1ntSlK6y5/z85jmoRZunnBbIYRCyuBzyNAJ1sL0Q9DtIFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=KRedtpY+;
	arc=none smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177E3606A326
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 03:48:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 177E3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=KRedtpY+
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b566cf56c1so1382011a12.2
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 19:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794023311; x=1794628111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pngyWx+Vw/q6WDMhlC8hKG9FFVyC3ObnnkppHB+fbfM=;
        b=KRedtpY+ht9Ty/2EQxLl7XKw6PFEdVunTmVOIk1jlBvUcT47kOK/fFE2NsJsuy+CKX
         yLeShbU+37ozgouqwjJR/NZ7Hf64nb5Q7ufhCGQAJPAkP+0w/jJTPlhF/G9OD95ihn0K
         oNhuRSJHGcUCth/WiEJUqOM8qGRpnQVJkfba8N8iJGHX5HIGJEkl6wry0aG/mcNZwFqS
         T3A08SykC3Wtyyl4e3xkaVWtRgtftuYHOHGI853jr41GriZVfr7YWuoyip0g6EaULi7d
         hRkA6nRHUfBmPumeNCxx3QnZd0zRhdNi0UBLJjcEH+YOz8SOo4iIqrI4sAEL+dDlrAkt
         JuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794023311; x=1794628111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pngyWx+Vw/q6WDMhlC8hKG9FFVyC3ObnnkppHB+fbfM=;
        b=CHpHn+l1QaW+J6dJZCQIy8TwHnZKg0oeJtWCrD4EZDjMWgIFgKHQBowLoyKQcKpMm8
         oC/lCxO/+sJykC7TusZan1FR9PEkYavHRBirqseJH6i0+9tN+3p8Lpy+3KDOr/M3GnVM
         wuifYFJ2j1bWECxO/wOdHruFFr9vdb9t0bts/418xdmr+8AbviNM6YG5z8KwF2rYvwON
         7Y/Mzjj5tT0PdOMmiHdBUAQprSRrtrWJ5nO+L7IIwE6j0PMAyHctKN/9jVz2hNRUw6Ax
         7M4XE5batqKqYReD2TeLn8+L9/B2XICWrKFtHBxzohGfX5eG9PhZVgRtN9i2jMtxOpOE
         0QVQ==
X-Gm-Message-State: APuU4Z+PLZ1s3NdTCB+iQQNMg3JPHniaRCStjhVIi4FvxBAaxLU9JAC7
	Gyagml4UowJavfFQbE4mRzrEn0GGasSrtZTHfob1HMkACE25ADbBUf5A14u4RU372l+vqsqn6pt
	IS0j33ew=
X-Gm-Gg: AYBFou3UDwXTQgtiVBhwgpId0d+7KDsYda9Ps9q6zagoneVv+JkZsz01qco/Rf1eFU4
	o38jc6nk2PQ+nAoSdricdjBKLoqhyGH2YLfFr2+9w+rexoJ3iJN2TBzG46dVS02FjMQzGI9Rhkq
	XW01Mk/ucvxTDlKagsYw4/v6GCYekTUzODjcWdpgYkt5c7JYqXsGZf4+YakTvIR/52AEneoJcoN
	odgWXH3ipFdSgMuPQT2EXDlUGjm9GhkEfKy9pkRwdE5SV2FwDB1CQegopGxk0cb14uFs4/OmSwg
	7+fz57z9EgsRU7vaXpVpYP073FfKGBWfob0b6JjaTJC+cUUe5cVy3p018VX6iZcAJmjYVpuAymF
	4IR/HA1pdCYAjKBcPtYl0XG7XyL8z5B1s3FNnlNbZQvXgzi/us9AgHaWbczU8YAj8cpd5KzAKLW
	PxbnARRuvElkyAURMb50nXI3v/fjkJW39+raIScJjoXznedwlH8qeKzqPmgtVIQJkdlCpNmnuIM
	d032gAUE5R2sDRrY+halIYrxIAJwfoMkcK2ZIagQwmoeESG/aBAzah8ant2YVE6AWNWyJWbI0jT
	Uv4iKTs04/l9pZnSNBtoe4IVUA6AT8y0h1pAub7nKer9yfsjm1tPeEsT3jyw0VBlWY3a3IWTvTK
	rnJdysOf8
X-Received: by 2002:a05:6402:158c:b0:6b5:8cd0:4046 with SMTP id 4fb4d7f45d1cf-6b5977f036bmr2951893a12.16.1794023311422;
        Fri, 06 Nov 2026 19:48:31 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b664afe901sm1403428a12.24.2026.11.06.19.48.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 19:48:30 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Keogh <dkeogh@amazon.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	kernel-team@cloudflare.com,
	nh-open-source@amazon.com,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH iproute2-next 1/2] uapi: add IFLA_TX_EXTRA_HEADROOM
Date: Sat,  7 Nov 2026 03:48:19 +0000
Message-ID: <deeffaef603f01d006bda581677f0d8ba27b9876.1794022936.git.tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794022936.git.tianyi@cloudflare.com>
References: <cover.1794022936.git.tianyi@cloudflare.com>
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

Add IFLA_TX_EXTRA_HEADROOM from the net-next series "net: configurable
extra TX headroom for local egress".

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
 include/uapi/linux/if_link.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 7ce01d81..21a26dc6 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -382,6 +382,7 @@ enum {
 	IFLA_HEADROOM,
 	IFLA_TAILROOM,
 	IFLA_PACING_OFFLOAD,
+	IFLA_TX_EXTRA_HEADROOM,
 	__IFLA_MAX
 };
 
-- 
2.56.0

