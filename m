Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EA935B64C
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 23:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787529157; cv=none; b=k3Rf2JPaFriuOUEa8ubRcPi3nDhw+pqlaQYJ0c/85L14EVJGzKKNMT6yHotmdHSyOMRaxbyj2PMewP/Dg6OhrtAQ1ya3JF1L2doE12mBKoCzAWq7Q8p7uiMZFghW33QCtNpALXeLKNzDk/88aVyVdDTyJr/ImNuLdOTsxCgKPN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787529157; c=relaxed/simple;
	bh=x4k9CP9TpsLmRLKpfaZMPTALVzrVkOLIsPdgjspLy28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bX1VV88UnXRYzA/kFoyNX0xWb9SSIDJhYdFL5Y2iR/9HWRwVwzdvsVvJrip3p3fT3pyhj36SZFgqOaeXnwaW21IqkykLdyTIMkopHqOBLvQvPnmFANenvNO7CrrT3MOvUFOPGI//GqPMuseHZ6cY9SZl5E7hS5saBhse+B2Vf2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=zk8/9isT; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="zk8/9isT"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84e0688b7e8so1988943b3a.1
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 16:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787529155; x=1788133955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZMNA8OtcDEWvt7S9xzrUJvj/xAZNp6XdxOFdtqOdn34=;
        b=zk8/9isTK1z1YKy21GGmn2QY3VakaMFIlvfVYc9bgd0z3F5k3NR82YqyFTf2qsaZ/7
         VC9UvVdkb3/1c/xhldHPJWkrzGJOxeaPGR5BfTpGCLu42i9j7MOSaYCgXohvk0r4OSWu
         q45rFoReS4ifP9ndD3f3mpJ02PNAQlZtBqr5HJTRuZt9/k+GYPugVbP/PNoVtr/5p7To
         Fa0gIvq9EDhJjk2A6VKXAh5fUAmCAI6d2WAMUpC4WT58MVlQZENWTNSupqcPQRfQ4qWn
         9E5DgmQgnjdfNOIsfrOfq7lvAii+GUi+EHqz2pDRoJc6/Q3n66lBsCjAEMIBVrl5WGH8
         cinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787529155; x=1788133955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZMNA8OtcDEWvt7S9xzrUJvj/xAZNp6XdxOFdtqOdn34=;
        b=gQ58s59iOTdU34d3scoMwN4dYJZC8eGIoVK3q44KUv0ATDeFdNTp3/CNih6qwwE5Bh
         ZMGH8DVUj5/jtSDka884DbinVBGLW9ixCTLgw4VA5jhlv5Vr++dbvFfEFmh9qqoVy5Bz
         /n4CWPzykqapg8ten1Q6y/FMSSaYodQJPN/4xhRjn83SXbXLtb+lYLH05TFnBNl59CUM
         8xF+/0RxOewGDXJxNjhVX7GHs/Vjmce4sr5ukwWouRN7BYJgvfYZlfRbgMmIcGMnT0b6
         wFcOKd0xF9QYpwp+e4SoRhE6iC82Ok1TY1Q/59PBYawl8hWw4JSG3SD9nKzLTthhwODA
         t/Zg==
X-Gm-Message-State: AFuF++nZ4aO+KQfGRSMZXCJTKBZwFpjdstDuL6k9nj1bKU6xPnyeykmi
	ah2grZ6iM+S7xF5F1x3NJGPjPq+3vX8VyKAXCbPmIVGGzs4vb0ZN6KfHDWKiVjbU3PkhXBgjoQh
	d1sul
X-Gm-Gg: AR+sD10HeDe81MOU1Uoxt+Fnt2Wt/GiXp9MhH+7QayIsfC2eFl/PRYnVwR1r7N4XDqp
	lSjmOxKgFeMQs0cYSOX2zxUWjLF+TnZ911lKy2E30HPtlLPwIYqzAfrj4/f+ik7qZmajeE9bf08
	VKlAHsW5ZMPeMEF2iXi+vgX+hzbtE+gjhxGHCRnVZAfMQj3IKrbs8qxJ//avqDf/Fun+NjnylmH
	zANbt24coH/3tH5t9OFwwiHyegMy25BFlzQA3546MP0u+QdMU4EGA39OHmkB++d47QnINgtoC09
	BV5Y/JW04ilXHalzA44xduPLcRk+poGBumHQApmCWCAbMwJ9DBpSEgjsHZu9KUwNFr3QpZDJssO
	Lr4z16W2C9Akxc3M5Q83eSwzfVYmzRuosRYiTW7mik4hmC00ccCHE5qXGuNOJI6qEk1sfCS83EH
	3DrFK5KfnlQr5Ny2ZCw86k1udZ3jTazU1q7ZcGXaQJiRYyuY0DaFn836fuAp6CraSofbNbfZfrT
	RQaWUsntd/CujhRxqeGkQhZ3tk=
X-Received: by 2002:a05:6a00:2989:b0:848:34ad:3d6c with SMTP id d2e1a72fcca58-8520ba61e48mr25134819b3a.15.1787529155551;
        Sun, 23 Aug 2026 16:52:35 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520eed243csm1387573b3a.12.2026.08.23.16.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 16:52:35 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 3/3] tc/f_u32: fix const strchr() warning
Date: Sun, 23 Aug 2026 16:51:33 -0700
Message-ID: <20260823235220.79790-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260823235220.79790-1-stephen@networkplumber.org>
References: <20260823235220.79790-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Newer GCC propogates const char across strchr() which
requires spliting temp variable.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 tc/f_u32.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tc/f_u32.c b/tc/f_u32.c
index 088d744e..ae285146 100644
--- a/tc/f_u32.c
+++ b/tc/f_u32.c
@@ -41,13 +41,15 @@ static void explain(void)
 static int get_u32_handle(__u32 *handle, const char *str)
 {
 	__u32 htid = 0, hash = 0, nodeid = 0;
-	char *tmp = strchr(str, ':');
+	const char *colon = strchr(str, ':');
+	char *tmp;
 
-	if (tmp == NULL) {
+	if (colon == NULL) {
 		if (memcmp("0x", str, 2) == 0)
 			return get_u32(handle, str, 16);
 		return -1;
 	}
+
 	htid = strtoul(str, &tmp, 16);
 	if (tmp == str && *str != ':' && *str != 0)
 		return -1;
-- 
2.53.0

