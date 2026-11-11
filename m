Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440638;
	b=JybAcRTEreoDhUF6kkkZr0GkQ/KqAjsnoBUowov/wEKYCOtO6wusbYPfYyHgasC4JFUv
	 Sexp1TBLFvoqsFUPxA7RrLRmPKGvj5LFgcTYUQKzsOvGYrAbgTxevOck097xjmNvO+FS+
	 YhBEDZlhnypJentt64qGYlOXvylX7fT1Mgk5iaEaL7c3bL1IVu0xklN3Vf2mcOVrclX97
	 NWAMOP/Ji786Syh7oyvcboBsurwLWkZ+L4xCaIUPqBZXlL2MKhin0lf2nMyFEjwHk/nO5
	 ENKxweHNbSmnlzeSXJiFFBDwZjXi5imw+8xkdOAw/EaYwkEMU0orfXy3kEsa6ABp53A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sIRtnQY6OYL4CdVr5QBsATLuOwtuGGYXItFUdt59r9I=;
	b=wzaT5Bi2vRz/9qj4HiVFnSlhYNa6SDMOPZhXClP4m7PaX9pX6D+QoMk6VrvAmZy60fv2
	 peg4Yu4ql/kjKqyPPcKIA5PRT2VgTiHDixaWjN43vbiDujc+eW4M4hNPr8NfMorP8uVu2
	 yomZR/k9LuPxBE8MNW4qBCvmAOgh8KIdyoMnagiBG/aZdbcIWfD166FhUDeoLa+tSUuoL
	 ZGSdDqlB/hPeAyE0ZCL8O/0mIQcS87P/ohx95s/Ae3JI4a5QTaBonv5SqDHwUm0SVARSD
	 3C9MiZbM2MC+LCmyqgt4As+7trwbl4/Mcn7brseBfPfD+kFAD7Bi6xzKnRjf5dcO9/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wumiYdvE;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8211606A334
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 23:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8211606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wumiYdvE
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cdadf7e248aso1424900a12.3
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 15:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794440637; x=1795045437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sIRtnQY6OYL4CdVr5QBsATLuOwtuGGYXItFUdt59r9I=;
        b=wumiYdvExrs1or930LW68S8u5NK+ZxaYW2ViW8HsYtynyheiOzLAm3MNhASmB59rQ6
         ODpX6tH+Yle9ldStJWtqWnyIIHdbcrInNq8ySuanPjqp9YfyJ+DrXSYjNKdYj7LRZJ/8
         YdOUk0t/8hzOxJEA1RgEvO2kGh2W92zVe9FSjx/o7+LwSdmVcFgws/n4TzMbu3we132R
         m2RAn/p250s2RZIsa/G+9cJv2e9RBDKpTHy7l8QXacqydu0yvWYd2Z84HJLmx29vOhPs
         gfmbmNUZVZVXfB+gVkUsRB1DYpY6AxCEOtBvRuLEakwT9lQRyAe+JlhO6rW6QN7nJr/n
         P3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794440637; x=1795045437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sIRtnQY6OYL4CdVr5QBsATLuOwtuGGYXItFUdt59r9I=;
        b=Pm5vxwkUpPrDyKCx07oaRx5L/CpOhNzGVENchoRxqnKbdOiCb/X4A8Ibzt1EmYKbV/
         Fda8w1VtPQFw1ILcGvk8bGs8C9BfPCnCpjWCR60P5Jm6BAOq678QA1KzsXiP/1qCsFnq
         IgDj5DEIOyL0pVHFMxWNNW85D+ynbBfoqxdg23vQBUFO3xnqVaFG4F811j7bdCdOPZup
         IE8eiwCdV4NvfXDZ8JdL8sI++e+2acfBTKSIlsWpKUOwCyi5gvHROxxJg/+Y2Bto40uA
         OaHxuplrErQ9iB++NzEVEvtLMTJgISs/s74uWF/8sEcdXfZ/7AKPPLflvLoxS3TNZeng
         zaUA==
X-Gm-Message-State: APuU4Z/LMpqkK/5hTdPJvgVzGo4phhsGue0lf0U1BsDW0jAkh/tQCzUV
	lhwIcL0MPx3eyZmnyT7TnSv6itFdS7Qrnz5rZ5euRVWVPjwTivxARDJ6/8IPBg==
X-Gm-Gg: AYBFou10SQVynSj01qYnpW0DldSgPsZWADamvTXXDI15Y2LLiflUzorzvsiKb3csnJM
	tA9gVMQyGlrnn/XtDc1SKilPIuk893iKm8vllYV5+iKpfmegpVw8RnCDiUD8eDBQs642S7evlGN
	tWZaDDpNZWqvpgL8CzDqLlGrFSM1wE97uG08HkjtnVl+u8FNHLgqbrTxzRDZhKU+Y2BmZuXsLav
	D88SoXBBCuDh+3wX69ntFCvM6SWTpYNiYs/lLRTmbXNWwVKWXxyv+i8J6yhc8L2xd1ndQXMBgml
	eKkmNjfvs9PX6kAlwANTFBokgOJF3d8A4tKnXz0WbSyUPKeKBhyql35GsUuEHCA9lGx1aoUG5y1
	j06ktUfDdUZ5iYepBhdmi2pgh35EJ97f/i2lJ6K0KPwJoOvb4z/fkvqWrkaIB0bmBCAhTeAf309
	VDj5y8ziOOS2q0TGfm0jaZzF93yY475fbeIhJdPTYBnGQnzyOnpYHtbGydqOnceW6i2MNOY3O/a
	ws6QfsUfiijH7yIxV0GpaYGKCKUvZ5s4TlAHQUfODCCkH7a+NptdE/xMF0ZU2x3v3tOgcIwFJaS
	F2WFtDlaVLZCpGIhqKwt+2kVhqY58MUGaKuO6Rjk13IEqMOji7KAbg==
X-Received: by 2002:a17:90a:c2ce:b0:3ae:5572:c4d1 with SMTP id 98e67ed59e1d1-3b182fdb069mr3832423a91.62.1794440636866;
        Wed, 11 Nov 2026 15:43:56 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:6e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c74bf3sm1328794a91.10.2026.11.11.15.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 15:43:56 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/3] net: dsa: motorcomm: Do not inherit ports from dynamic FDB entries
Date: Thu, 12 Nov 2026 07:41:04 +0800
Message-ID: <20261111234110.1449602-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111234110.1449602-1-mmyangfl@gmail.com>
References: <20261111234110.1449602-1-mmyangfl@gmail.com>
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

When adding an fdb/mdb entry whose (address, VID) key already exists in
hardware, the existing egress ports were silently merged into the new
static entry. Ports learned by hardware are untracked by DSA and can
never be deleted. Replace the port mask instead of merging when the
existing entry is not static.

Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 33e5fc127244..150c51f1aa35 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -799,7 +799,10 @@ yt921x_fdb_join(struct yt921x_priv *priv, const unsigned char *addr, u16 vid,
 
 	ctrl1 = val1 & ~YT921X_FDB_IO1_STATUS_M;
 	ctrl1 |= YT921X_FDB_IO1_STATUS_STATIC;
-	ctrl2 = val2 | YT921X_FDB_IO2_EGR_PORTS(ports_mask);
+	ctrl2 = val2;
+	if (ctrl1 != val1)
+		ctrl2 &= ~YT921X_FDB_IO2_EGR_PORTS_M;
+	ctrl2 |= YT921X_FDB_IO2_EGR_PORTS(ports_mask);
 	if (ctrl1 == val1 && ctrl2 == val2)
 		return 0;
 
-- 
2.53.0

