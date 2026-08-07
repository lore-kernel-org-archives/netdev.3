Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D11F476053
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786117393; cv=none; b=OUe4prDLKTMcr4qfkgIAmEdV7ZXcU7kru1bo53zBMzIhbNSAjE6jZbaIjtUfwF2dPcTo2RIBnvV8a0FhyzhHSzeol1sOleUFDWEAxBbxSdUQqBQa139Je3q9BOkqmHlzvi1amofmz3oprAJlxXQ5Jn9U+fIqm3VR55qj2eN6/IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786117393; c=relaxed/simple;
	bh=ZFTHGgGkU9rlx6TOHTE1gumlcIsK/aMPZ3BOdvx2fkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RqHSkvtCHamzBrGcebSAJ/aYqyLPFgxpovC2jloyNbAxf4iPtdrZIej0W87O8ifmSn/lF33u2dAbwlt01q2194yCZStBP/FRk9OHDEFmt5rFpHX0qNkKR3tKxanjYyavJoMMuJm32N3cM/cUNIeS8l4VOUqXODiw2j/+y0TTUm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=bMSsvsoV; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="bMSsvsoV"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c9aea40d799so2047704a12.0
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 08:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786117391; x=1786722191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g7S/UVHcq0v5DCqTaABl2lRpZe35jIUxPsNvTEDp+Zw=;
        b=bMSsvsoVd+Zeh2Z9yzPkY5kgE9FpN/FARoCkZc1J74AqsYnPm2PzALUM01qk/ZY8un
         q5kEp3A3kjuqE2cZ5Ge8pw0TMgPuckN4to1N95LrccVNGyKVqxRGjKAtnxTB4Gp2Quke
         fBz/rMwQkY4lnQfaHggEtlT5mtS35iDhJ/iBLGSLbKOOmE4zCc6TBkBVIOjan7A+70t4
         0knjSrU3MyDJDseb4mCg1OijziKwHcqolO6XiM40NFPsGbF//CCtREn6xv42aha0UHPL
         S5KF/2TjQAQimVMUSdSmo8iARag8Xx1WaHscWthSRRrd2p1Wn8zNCEdIWpXuN6xDj/1I
         i74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786117391; x=1786722191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g7S/UVHcq0v5DCqTaABl2lRpZe35jIUxPsNvTEDp+Zw=;
        b=qtaoLAhKtrdfPDLs1vX1BUK/M9+CrSXwjC1L2A+aZGasBXLnu8nrZOpy6J20mnoVt9
         dJ29TlHi8t2785/rlZo03jT03TiWH4kwV3f8Cjb7IVtfugprTfKgveBG7q4wS+9sH7v7
         98Yf1X0ToaGpNHNZqOh0IpDDpw5+ehqOkFakAtCyVv1YJM8B2EGiETM86+D46NWvj6FY
         iwS0hodbxGX0H3o9nXgO0ONqlzmVeljP4bL7bu3yK97numlYJ6qGq79vAlQCcjQ9Jn9W
         YqTolcV+d/ZXyVUSsfk32ZedeeUJOf8DPv8G0/63gRWfmN4MY2YfewNLEizaUknbsFtm
         jkIg==
X-Gm-Message-State: AOJu0Yz+I1fqdySyaQjejk03rh98KVKvy37A1gSwE/kNmME5miO/0bd0
	Ad6ZYNajVlUWb24O0ecIvfyqx5Gq2pGQhOyfLHKAZCngm9gb2lyqJh/5UzTHCKCWyW43xeUIMv1
	IziiL
X-Gm-Gg: AR+sD11uKqWTXMZTfC7CE+AayPg4hxvaYhx/7JDKH12eWXAVAKiAM4Fm5YUy37kxaRB
	bFwS+LSlhM5bIfa9PNOwEEc1Mx0qiE8a5R3iLWRV2NG5kwaZWfSbg5fjeuCY4IaGV1Pyr3kNz6g
	SXr13ozGHZnysWWDbazpTjWrnjdH5fSV3ASC3R4j/OKZaROgQ23FWKEMDMTBladxzls9NTuxKfW
	M7QAtNNbHfbABsTcnd33oczzMLq+I5yvL5M9Yz7pn3eBfAtu//jd/u6l2GoruTli8ZFI6PXGx5L
	4tAudCY23EKBzIXAm+dAK1uBsxc2BeYsjaRpOfIxIVAkHb1OLJXc3Ga0AmGOZUEvGhrkkqufJpK
	bxEIFZ1jwLtZVhlSTYXQ0vFATVjeia7Ija3yVmwNMa2Ff7ghGSLdCfLJ8PIrIHoDJ17JM1+lINR
	f1yyyt1ZycugDTZPI+A9UBIRMMsudR4Ol4K08yyf/58jp06JpfylfVufiJOe5cMYk8ZgsjDQuuq
	OacqBec6do/GmtdoCxP+kkBDqltnBqGeHrT5A==
X-Received: by 2002:a05:6a21:6f17:b0:3c3:a20f:f720 with SMTP id adf61e73a8af0-3cbcea2fed2mr1794246637.36.1786117391459;
        Fri, 07 Aug 2026 08:43:11 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141019a0528sm8213083c88.1.2026.08.07.08.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 08:43:11 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next 2/7] ip/routel: follow help vs usage convention
Date: Fri,  7 Aug 2026 08:42:25 -0700
Message-ID: <20260807154306.111200-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807154306.111200-1-stephen@networkplumber.org>
References: <20260807154306.111200-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to update to ip, put help on stdout and usage
on stderr.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 ip/routel | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/ip/routel b/ip/routel
index 09a90126..defe738c 100755
--- a/ip/routel
+++ b/ip/routel
@@ -11,10 +11,11 @@ import getopt
 import subprocess
 
 
-def usage():
+def usage(help=False):
     '''Print usage and exit'''
-    print("Usage: {} [tablenr [raw ip args...]]".format(sys.argv[0]))
-    sys.exit(64)
+    print("Usage: {} [tablenr [raw ip args...]]".format(sys.argv[0]),
+          file=sys.stdout if help else sys.stderr)
+    sys.exit(0 if help else 1)
 
 
 def main():
@@ -23,12 +24,12 @@ def main():
     try:
         opts, args = getopt.getopt(sys.argv[1:], "h46f:", ["help", "family="])
     except getopt.GetoptError as err:
-        print(err)
+        print(err, file=sys.stderr)
         usage()
 
     for opt, arg in opts:
         if opt in ["-h", "--help"]:
-            usage()
+            usage(True)
         elif opt == '-6':
             family = 'inet6'
         elif opt == "-4":
-- 
2.53.0

