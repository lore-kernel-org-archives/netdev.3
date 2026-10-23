Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792734955;
	b=k8fDgoanBjYd7ucw9mR0ebFIdmQZG9HzavPZSzcUBX37m9hrAV+8JwF+AEecjdeJN4x3
	 qbjKojEpX77+E/6tzTj4j3QEc6NJt034IeT8vx9Fba9G7gYauzicrxjKssZeuFfFETRmO
	 MBIaFjtoIFl/mtdpiN6dWMlrjjn9+dBVjM4OWq6hd1iDgAweP7EVRYQLY5xkpPmoNu53w
	 AKj+4pkGdUrqAvbB+iX8aTjVtvIB66kEcCSSxAzb62a46Nj7bLBgQ9iizjcMLs8+2KCKF
	 31nu/81GDd84p0IW2f26DN77FJz8KryHpTdf9x/gaCJsBVr8R5CIqZBX4a7MK9GWRdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792734955;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NFgSsKZG0b+cmNubhqNj8B4xxbWSVMf6JHmk4Yh78t0=;
	b=vrTy6IiYR09OM8HUV6pBPtQi4bGAJq0K26dTCSmcLNzkRpI9XaFNWqtdMjn21Yn0YoAb
	 V91M6AHDSaG1kziDd72wDYv8s24juYdT1Wzywu/UyJH0/V6/PzeW0+S8ACHzaugzyqZDO
	 0Oi+hhsxptU5j9KCMiAvZvYR6nHuWz6V0tUVuDcHW16h7JUgm/vR4EewSCuACfOtDkHg/
	 7PoBf/mUuO4zxaAKh/aQn2e60zrUcStpF9bx4sXCVqTOxeS8D141drcpP7/bybh4nMQ5D
	 Dk6oVxTukw3UoZhpyGrMCEi6Z9a7+TIgJDOzlcwsM8U+5kmy3I7jl0WHX3o7padnkPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=b3uaYkOx;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D373606A32C
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 05:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D373606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=b3uaYkOx
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso841071eec.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 22:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792734954; x=1793339754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NFgSsKZG0b+cmNubhqNj8B4xxbWSVMf6JHmk4Yh78t0=;
        b=b3uaYkOxX+iPbBgbC/Mb48Lhc0WU3s/eKaDhvW8/cAhsbMf3yC+nMf1K3Zxgvp9XWx
         Z5eb2a7fhCJ7e27Th0eJwHmRne8qPuKR0WgyDd3IXs/04rzhnVHGFCSX4Wrt0Y5p3cFP
         eTigq59dYymy3jIS3QXtrxqYOgPpM0horoChC9+s0xvkjIgeX4Kz5xcPus0OuKop7lFG
         42LkWCxKIXaH10aCGCJVhfWUunxX1e7H21zPszKE3USgvMM+y4ZDB0Fv8kmExyB9h5lF
         G18Pzy3NGcEsZ0SZvaIpCIw5V3JzD/Qz4DhnpP1E52KMU/ZdzaMepGVdwSmBa7T5/tou
         j7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792734954; x=1793339754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NFgSsKZG0b+cmNubhqNj8B4xxbWSVMf6JHmk4Yh78t0=;
        b=lpu7R9Bm3xzkc1S/qF1/9kdwZ4z/7+Uu05wSd90kYNgHPfblwtLYMXOo4Yrj/qlghG
         VRmKe0ZRaaHoIXfxf5m7jMAOZZe6zjgRepgIdBHx7seVRROArJedWfzTYnfMlw+wd1aq
         7hAKJNN12P0rSXS1/28GdpP3EgVW1YZSV+2u0vPXNNr7KWcNUQmjYku8JgVvJHdMaYap
         gyjNYFQuyNi5GXgjsY1gXL5jCPfRNu6lNyPBXn7phTgkY7yFzevxYDRdNaLdNeIH/ONp
         SndsCZ77Tn9r/oxv3rRG+2IkGDOgKNMeYPMr3I6Wc0D8GFZo0MJLTBx46tG1tVPVfhqP
         oZLQ==
X-Forwarded-Encrypted: i=1; AKwUvBywtpF2NnQ2aBIeVNgWgGQppRvYqK6KpQi22qpq33bbsL8z96vP7R3/fMtnincNYGmFqn+jnB4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIRJB1pNc8+xQtCaKKypeCFBewZINfkQvJFvs65yuUCyEXNxD4U
	dHEjL/MUz3P7s2ze+m40qAYzIU9ZAWIbUkuurVKzMVzPAacG9FIWZHZo5kwKp14FHkM0
X-Gm-Gg: AYBFou2kQM4w+0kEkxDwZVhL+pQcu2NL2VLwQVDBjv1bBbdGTis6mk0kQx4BNUhyQH8
	KWzAFsOyWFtW1/xZs20FtwNEMQ58Hdm8cQ/cuaHRPaMSCuppdJizoDXoTI/ptNBVS0OUyCe84Bh
	CXg+j6kpTzLgJAcCsh4dZEMz/mJpDMtSTCPvVGEJRFJb+EVICTD0gmlhav1Col+Sipw7JC2Er38
	+2TJhTrrplWrgW5nJxeUhKM2cjex2yj2Ah6hIPyBW0gcl1ZdI1JhBvCZYecMkAZrGlbtEb50ajg
	8fg6vs6q+RegMuGOgrl+sOHIXxXGcZ3dCZ8pqaHuilozYPMv3bXA3Lt1JaBPu5LmKpMOce/BIey
	aRLFKctNFDb5sVPJHkgHp8hzJQJXYQUAxv4Ro8KEykTVL23odbcQ5uNu4O6L6xkamu1nyflH08B
	jUO4P12dBQwNYipEHIVYQAt78OQ9GWrgXGSFXO5C+zKm8ySPJPMpKoejF/W+aDcGEMkw5E1qjQ/
	dgXn/f0+M/1a26qxdA86nEZe2jr9hFmY0m/UuECMxo19uhAbIuT7askxXGKIjDtPe19it3glxMK
	3MSTuEUkr6tENR0C
X-Received: by 2002:a05:693c:894c:20b0:368:5750:9869 with SMTP id 5a478bee46e88-369d96dd67bmr1580957eec.8.1792734953544;
        Thu, 22 Oct 2026 22:55:53 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([203.175.14.54])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9def334sm3656543eec.24.2026.10.22.22.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 22:55:53 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org
Cc: trondmy@kernel.org,
	anna@kernel.org,
	cel@kernel.org,
	jlayton@kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 1/1] SUNRPC: reject AUTH_TLS on backchannel requests
Date: Fri, 23 Oct 2026 13:55:35 +0800
Message-ID: <1106d411594bbf7d4ee8deb7f3a0281475c258c4.1792734713.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792734713.git.zhilinz@nebusec.ai>
References: <cover.1792734713.git.zhilinz@nebusec.ai>
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

svc_process_bc() processes reverse-direction calls with rqstp->rq_xprt
set to NULL. A backchannel caller can supply RPC_AUTH_TLS, which selects
svcauth_tls_accept(). That handler dereferences rq_xprt while checking
for transport handshake support, causing a NULL pointer dereference
before the RPC program can reject the request.

Reject AUTH_TLS credentials when no service transport is present. The
backchannel request is then denied without accessing rq_xprt.

Fixes: 74aaf96feaca ("SUNRPC: Teach server to recognize RPC_AUTH_TLS")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
 net/sunrpc/svcauth_unix.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
index 31a1bc60a5f6d..bac38f3ce9a6c 100644
--- a/net/sunrpc/svcauth_unix.c
+++ b/net/sunrpc/svcauth_unix.c
@@ -1128,6 +1128,11 @@ svcauth_tls_accept(struct svc_rqst *rqstp)
 		rqstp->rq_auth_stat = rpc_autherr_badcred;
 		return SVC_DENIED;
 	}
+	if (unlikely(!xprt)) {
+		/* Backchannel requests do not have a service transport. */
+		rqstp->rq_auth_stat = rpc_autherr_badcred;
+		return SVC_DENIED;
+	}
 
 	/* Signal that mapping to nobody uid/gid is required */
 	cred->cr_uid = INVALID_UID;
-- 
2.55.0

