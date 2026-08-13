Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F395D3A9D80
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 18:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786646073; cv=none; b=XCDHsowhqER7KY/WXtBB5Xg+EVYONTZEffwfsMdebVq2PqbK008Utsmj9HiPW75EEbtAGqaMv26bZwn4eItkVgZxuRelRcC1upA3z2uG5CAFROHa/DTXnMhq4J1WOzzdGk9J/K9i4WIv+0So3mxOSpcyC8tf93EFxLiUwDN2Gvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786646073; c=relaxed/simple;
	bh=mqYEFzcu9adlmzMlbAGBlaKC7RKZhOj1IPYoG0xJLLg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xtx91GIao8f6qNA9LNffTPVeHW/Nn/voFA/QtphkI69s8ZYA/eFdHxQ2bcYhq11B9iJFOuF0LTFFw8+bvigxX2wkqVEM+HoS/CxR9iJsOLcATbZAXF53syKvIshVx3cZFsfohIOpQigBCqVfk8ZCK4Iv8AUePdCLlcU/k1fAiI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p/OKSJRx; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/OKSJRx"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ced3386430so3054465ad.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 11:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786646071; x=1787250871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7YHG5aECJfFEafyUES+0YBuoUGPDTuM9lTTdzyRLjcg=;
        b=p/OKSJRxf7ptWC2hVbg2/OknYjufxh+QBNiirT0t5UCmjXMaoc5hnAAvmr2Dd2R4+M
         4EtJjpqTS/xccoolIpkN2S0Z6vD14kfL6i8/AT/BLY5KgQiHCDaymj5d3sB6S0oooHP3
         /MLB8CxWqNshYxTs+GPzVnlIK3RptOtj6enNt5e3biUZJZUJj/MkIle5jadep0o8tyh9
         vuT49udVZdeEl1l5D/CWW1mj12JN8VSaTuk8M1UFgYhIrqFo0478G3QvD/pCjOIsRX1h
         iqLxC8pRLyq3qHoNX1kesGVk6dnbEyCPp+lp1fKoKNmjNMMPEAqVodPD7+He9wGKcIa4
         92rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786646071; x=1787250871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7YHG5aECJfFEafyUES+0YBuoUGPDTuM9lTTdzyRLjcg=;
        b=hgUbEzr87/lbxAhthNPZXI4jZPbLWCXjpz0BC8UAiZ41hR929NPv/p2IsrFMrT/ll7
         LtXvXccobTMPNW1VWzgfrOMkWael5S9VU0zEv5FgvKzP0x3GbcAPLvl6UROoOwq1kxrm
         sD8ATMyByDTZCcavgqvySmK6WjIEVpZ2pnUkqyhZt938OTyisXGh7lwr1F+Jb0WMvoqk
         HuOtSbtfTh/bQRMA7nOqKpSOm75QHASg8lsBbPpKlDxIkHHc3pnRQmCssTHz2jGc0pHb
         vkKfrXg9LFzdFUGPhWrohgGAi7eoxhm6ExlZYZCIBxI6qpr9VJjX0urct+how3c5vVhu
         ghDw==
X-Gm-Message-State: AOJu0YyBfMx+ozh4kVl3jGzbCkHIgCPTqpaPuzLUoTcDYVIpkeZLwEfs
	xRXcmVULYSSTWhkIJEeKvQlizsm/26TTQclyFiUVR1SgK08MQ7tXQ/wq
X-Gm-Gg: AR+sD132qGVOHkxIPjpiim9yKUHIB7sYPlizWr9h1HlKOo2A47/Sg3VSNpO/5c1+2eK
	XGOYu70488B277jh61MkDz7H2d9x2VXg338w3UIMyvFs2E2xKIG2yhJLU06rumF41JlwWC1hVtP
	7Y1GL0eoXd4PdhU9UFKVblATsNWsCS18R8fJIbTp1qC1V8+dyzmA5zTUPm3NRoZ48aLGqEoi+l/
	tBsYBIGJNQVH4pcj55IHwV+ZPR+qVRSGmyj26aOs9F4HM2qJzQQgMdLpWMQV/ABpilXuEm4ODXV
	fl9V72Bjhg6yh5v6+lj1CKReSkU0t+liDaE7hjeJTz9MlhWHVZpbFHYh/pw3NaYmNyTS2nMT1bV
	IstFzW+mULfcN4/mTniWdEiP2rv1T5SvGBgEzeb7CisSUAfX4UFaKeBqaP92yrLWX+9P04MIi3z
	A8Bae5qmJYIj52Eqi0em6YckYhLlIRLGCHXy/9YeaYtB1lf06rgoeCLiGoX6joDK12Y9iiurUX7
	V8Fxd5nHdmtWT5rWrBYbuZX/rAgtUEVRTy+115gIzoHrVKvHRjL4MBeP7c=
X-Received: by 2002:a05:6a21:398:b0:3c4:1493:6822 with SMTP id adf61e73a8af0-3cc5527de3dmr10298362637.18.1786646071025;
        Thu, 13 Aug 2026 11:34:31 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f0:b103:29aa:a46e:b8bb:4db6:5c63])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ebfc3ca41sm10226567eec.21.2026.08.13.11.34.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Aug 2026 11:34:30 -0700 (PDT)
From: Joas Antonio <joasantonio108@gmail.com>
To: horms@verge.net.au,
	ja@ssi.bg,
	pablo@netfilter.org,
	fw@strlen.de
Cc: netdev@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kernel@vger.kernel.org,
	Joas Antonio dos Santos <joasantonio108@gmail.com>
Subject: [PATCH v2 ipvs] ipvs: fix integer overflow in ftp helper port/address parsing
Date: Thu, 13 Aug 2026 15:34:24 -0300
Message-Id: <20260813183424.47522-1-joasantonio108@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joas Antonio dos Santos <joasantonio108@gmail.com>

ip_vs_ftp_get_addrport() accumulates decimal digits into a __u16
(hport) and into unsigned char (p[]) without checking for overflow.
A crafted FTP PASV/EPSV response with an over-long port or address
octet wraps the value, so the helper configures the data connection
with a truncated port/address.

The netfilter conntrack FTP helper had the same defect, fixed in
commit 2b413fc689ba ("netfilter: nf_conntrack_ftp: avoid u16
overflows"). Apply the equivalent fix here: widen the port accumulator
to u32 and reject values above 65535, and reject address octets above
255.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
---
v2: use real name in Signed-off-by, add subsystem tag to subject (per
    Pablo Neira Ayuso)

 net/netfilter/ipvs/ip_vs_ftp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_ftp.c b/net/netfilter/ipvs/ip_vs_ftp.c
index b315c608f..9e3e005a8 100644
--- a/net/netfilter/ipvs/ip_vs_ftp.c
+++ b/net/netfilter/ipvs/ip_vs_ftp.c
@@ -102,7 +102,7 @@ static int ip_vs_ftp_get_addrport(char *data, char *data_limit,
 	char *s, c;
 	unsigned char p[6];
 	char edelim;
-	__u16 hport;
+	__u32 hport;
 	int i = 0;
 
 	if (data_limit - data < plen) {
@@ -144,7 +144,11 @@ static int ip_vs_ftp_get_addrport(char *data, char *data_limit,
 				return -1;
 			c = *data;
 			if (isdigit(c)) {
-				p[i] = p[i]*10 + c - '0';
+				unsigned int val = p[i] * 10 + c - '0';
+
+				if (val > 255)
+					return -1;
+				p[i] = val;
 			} else if (c == ',' && i < 5) {
 				i++;
 				p[i] = 0;
@@ -222,6 +226,8 @@ static int ip_vs_ftp_get_addrport(char *data, char *data_limit,
 		if (!isdigit(*s))
 			break;
 		hport = hport * 10 + *s - '0';
+		if (hport > 65535)
+			return -1;
 	}
 	if (s == data_limit || !hport || *s != edelim)
 		return -1;
-- 
2.39.5 (Apple Git-154)

