Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794077103;
	b=ZsmpHwtx4wprdNQD1YMmZ9UVdZe9D5a3Ehtrz5L40XN+/s7pSmqZ8wPYy9vbZUC7DQN2
	 2wloNZNYfseZvmwlo0zjqQtGs3ajBi1UEmE/FFnI6D/JfFE4HElEJnTAuftYKkzwReBAq
	 dRFe2ZuoiPEcmQtoXNSAJru0FW4789p7qvgS2lnSLGWFtF32IGtBo+9c06wNayvIMrZxe
	 E7OZUzOcPCTSlN8w7ILVIRWh2LiqjUI3ydGVDs3OuipzXW7bE3hX3aYxAjlB708VgFlLW
	 f30517xNpxTwAnXn6auGKmGOV0qkaGPoEulCEsSjZeyBQVSrlpovUWDFaP3m2ATjzbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794077103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fhdhbpDGmd7gIfxOVLBlem2mFmloT/DJ5ctenjojXQM=;
	b=jlzSqeQZeR/Q1lqw4yLp2UBfsahf+iQDrTcPvEwpyk9oIlC60xj+sG0XLQeVaB6KpKVU
	 Rn2TKF3VlGhluRJhAh1LAFhzF2/ZakmGfFkjmMEC4s3hkVPW42cL9YeeyByfp6KNMkbpX
	 gRHYrSsCNrIPylx4is0lMNVYyJEoucWN0ewFxGOotoIVEEck7H2Lq5gEjmh7mepGrvsJm
	 P0g9nosExxgKs411G1mPCkEwHIr4GOuak7baXHVGXsFA+Qiym8I1q5+xMbG0zJiY4HWsm
	 4BnbNE1ZgcfiU2oLmkLRiKa+7F8B88ZWNZAKAz0gvhos1mlvLwiJQwz2s8iAP+hb2jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=GkNciejQ;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108846082BC0
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 18:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 108846082BC0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=GkNciejQ
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-15ea896ddc8so2964957c88.0
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 10:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1794077102; x=1794681902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fhdhbpDGmd7gIfxOVLBlem2mFmloT/DJ5ctenjojXQM=;
        b=GkNciejQJ/Z72Y1u1tTkdWG7r+DlIGafrtg6x1vnSUWnbKDtUfo4oXs8nuXxWCrwuE
         1Dy4hbpxEU32Af0gjzGbD0e2A0xxeEkRgrPUDg8BceJKkqVQ35gtFLG1aIZabKzUWEuL
         yD6pG/+159wzmKJ09bBLUlbQEO7IJQtnE1BpCAw2aE0oIMYk76pwDRK+tIO/8hSm1fO9
         b55XlHUryrYD7WHEQdA9L3ffKEBDpFwDpkdSZd0y90CIVoUyKP6MD75ClHAiwVraWrMh
         R1qBZx9fKz9+Vktmacea83L8gsjhpaWjMn8w941CjassP+0a7V9D2Jnw91zbdqUkRSgk
         7/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794077102; x=1794681902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fhdhbpDGmd7gIfxOVLBlem2mFmloT/DJ5ctenjojXQM=;
        b=yJZlzv6TA2mMppMbysHJQHI0tShYr7f62sqBek6egGwS1P8rNI7GSSq9FjiizmKugu
         DkS9S1Fi/3V+k/wx2ALyAADNQCxm5P64+FDXmq3TTY28R7Z0B+ayU/pN+zbImFKZ+soJ
         NoPzuxuOIibGvbnVYI5VwU2wl0VMqEBWV+xDM9HpI6Rxw/yQwehzEVxwRU8F6P7HD1mO
         XcDhfbyGCCdko8BDREY6zfir0i2cj0uZPl8kijP31OL9uFBosVTfxjKJOMvPhhhNiMzF
         n0sZOIZx2sCVTBHj3ZsZIJCY8Um2H9jlcEm0+ahHflg9Hsmrji4txi2EN7++oAZo+pU0
         0Ppg==
X-Gm-Message-State: APuU4Z+Yl+mOuonWW1yFS933T5gKWsRD1BVC73B+e27EUBvswBY0ZCGS
	eH/fAx4YhqMmEQPaqe397Ty9QihFmWkZ2liec+ifPKFQYcuM2eBIt8UYhBcHjhYuEKA=
X-Gm-Gg: AYBFou0UmSq2fzlJ9G2Q49bAqd8qed3vavJ8NxbVcIioC3kAmZjZ84cuZ3g97Z9oVrS
	PAVkUGL8fyWIXWo0unsEIV8YA2WCZzTlNjjLE38P7o2rc7s5o725Sl/sS3iTzutL3WyyYGnA4Z7
	5BlpW4/ciw8Jl3YQJSgotJiJtOOue0ufvi467KoqFuHDRyGi58wVToH5GHVB7lKCYvOvE9rBy9c
	ZrGMBtK1X10wJeXZWTSSEnoaocujhdLrhSPC33uUpZ/VWyPnpR4G2mTAtenrd4jOSe28jyO7sVF
	UVJ0/+PT5gBue8gXKp3qkbU/9Cseo5mpsnYisW0vb+6OU5tZDkYtmU3TwLdvhXRTL86ogUfSCJS
	f2IK7fcgsSmy0heLUfXGSsPUZ4mGMqzLLyOTE+3hXHq333l5G0llG/pDWFZv4WmznEbYkEEgrOc
	L/7iYrBOHDI+OKCbbKP8RNIYbFXMgKQjtijsSsfmHR0B4OvUcPJkwVDJU2xfxtPWE26knEgDAao
	HL6Mth2PcluGt2/CsaGF0lPv14cDML41m3lXPgRLo9TB6o2wk5pTu1C/otkba6XwqQhx4w82Yid
	jDN250e0zBLWUbUBN8COhIEeIRQuBfZDEE2wSyMAlpENl1+ArPd4HI49RDOs7CdEOsq/Im4=
X-Received: by 2002:a05:7301:1601:b0:36e:dd5:fb08 with SMTP id 5a478bee46e88-36f773f7c7fmr8246456eec.40.1794077102206;
        Sat, 07 Nov 2026 10:45:02 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa8c4f28dsm17286897eec.9.2026.11.07.10.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 10:45:01 -0800 (PST)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	brett.creeley@amd.com,
	sgoutham@marvell.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org,
	Ido Schimmel <idosch@nvidia.com>,
	Satish Kharat <satishkh@cisco.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [RFC PATCH net-next 9/9] MAINTAINERS: amt: cover the offload header and netdevsim provider
Date: Sat,  7 Nov 2026 18:44:37 +0000
Message-ID: <20261107184437.2783174-10-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107184437.2783174-1-omar@blockcast.net>
References: <20261107184437.2783174-1-omar@blockcast.net>
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

The AMT entry does not list include/net/amt_offload.h or the netdevsim
reference provider drivers/net/netdevsim/amt.c, so get_maintainer.pl
does not find the AMT maintainer for changes to either. Add both.
tools/testing/selftests/net/amt_offload.sh is covered by the entry's
amt*.sh pattern, which the IPv6 outer transport series adds.

drivers/net/netdevsim/amt.c stays under the NETDEVSIM entry as well,
through its existing drivers/net/netdevsim/* pattern, so the netdevsim
maintainer is still found for it.

Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b01fdeee6..f6d5b471f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1404,6 +1404,8 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
 F:	drivers/net/amt.c
+F:	drivers/net/netdevsim/amt.c
+F:	include/net/amt_offload.h
 F:	tools/testing/selftests/net/amt*.sh
 
 ANALOG DEVICES INC AD3530R DRIVER
-- 
2.43.0

