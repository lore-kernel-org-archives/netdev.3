Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDDB371889
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 03:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791689353; cv=none; b=jv/6X1ud3JRp+wwPxYLklGEnkjyB3nY+xNk6sKtlOGqHZDmT4030o+MADyp6fXVYSHHNviN4iZKY4AkfW+WFSrHLWANUXCCOLWtI96fngvPOxRTJOwZg42391sE/4LTj0deHa7FkiCFO5I0C9stj7IkrKauvCJaSFh2u0sMd3Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791689353; c=relaxed/simple;
	bh=OLpjUCndCTRr8pEvpIbKaHD6KUCDMaJwYqHR6Ja0Fzk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AM9eO+nZ36vSesLtM3+B6HRUEot6vZSLZgfyq/8axih/1WulZcHqiGmrIdKR0rIb00QVfvTr4V8Au8tGIbZLv2CTq7AukBLf9x4cwfSBO8QVD4DUfaaYioU+WHZCM03A0qJKwYae8m9CiGmXFhp15wgDrKAfrw8GeYQn9U4Uyos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPIYfjcl; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPIYfjcl"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so1461097eec.0
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 20:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791689352; x=1792294152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=csJVJMASzmLhlhzAuZnlIX2GPrJ92gi9w/U6R2936eQ=;
        b=LPIYfjclMEYz1Ae58Lpz7ZePWoqfhQfUHdvGX4/HwDZuMFjPl7AIrDkzfoKpavYsZq
         bNqzsexvV2+C4bQNME/JzTJre1Z7MsfbEThofyU99JmYtei8SM0EhNKKWFeu8KjSSXms
         7zTHBkvFgEWe4dog/0ercsdZzqiA6JAo4+gg/znWY5P9JxuQgbD+B2fYAs0Ua5rAOPJQ
         uPe01PU3Tnuf1qnyhZy0HxTb9LIrzTpAYQ69J4sEJWel+hQ20B5LeNhFOZbyePr6mPs/
         bW56+8JcAumwFMZNOVw5bxbP7jqtndsSbnbe8LW+ohyiCJYInQiRtoS+mQi9knDaJFAt
         Gf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791689352; x=1792294152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=csJVJMASzmLhlhzAuZnlIX2GPrJ92gi9w/U6R2936eQ=;
        b=fmA75/g9wevbyHNPqA65x1amDmH6+cP0CzxMc88PpBjTm10AQjyML0EJLup1dmOWxA
         JxuSE+ZbveFFmxMz3SO40LLTbluNtjpwQyz6xgNlSU0Vwi+7XCyaVHKAP1LJGUOWZt2s
         IQMT98IpREAlyvqPIMOKRp6g35Rm3WPSaoO8sPBYyG0riJbcvwqCk+73R4S+AjRDsAFV
         gO7jtpf6Z3EcXQRCbUQ34DTH/R0WLMVdfdZmX/X96XdDIEjCIKZk9eRDh437SYHCurYt
         dKMiQ4MY+jIrtr7ojJ9WAsHCTVAAPEg7eojnXzcxzmGdcUM9ifz9pS8D5PrQzbRu800t
         12OQ==
X-Forwarded-Encrypted: i=1; AKwUvBw4ylw9osNv0AVPVKEXNPROjuiONpoDWumVq1gzIBO/igBjjeVkw9Q09+AL6qmvXFkdM98Y8Yw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKcnbS72KUNIIThlaBCu7q7NHX7AwB6gNNX9rai0UatETUFtvfL
	URLa767MM7YvyQgMyvXBFCqYWCsj08liw9cK7+7iB/q/I/Pr+2U+ozax
X-Gm-Gg: AYBFou2j4y0pU65ECNacB35WVPQKBzhlQC18m3QvgCFxL7CedZPRCcX1qGQ+LLcxTPq
	A7kWmvjB01OYI/o8M1N0C2SMNiuaE6vsMW5Qct41gLHjFiwMapPkyLnKMcsgr81vgs76Fe92T/L
	VhhN7DhqTQp7hEFA5FkIqveX7UfEK0uICOpZ4AiMSOA2lLm1T4KECdnXgukLf9yVNpcfzrnJ0Dx
	lnE2XixWjizoSMXmUt/hGvsye096TrIEq0ezX39/OGLcnqbnH25SekFGg/GDp1XlaUfFqhcb68a
	KopVngoTi5qDRraeoY+Nt0KDoscKoPfayXKo4TpsfwINQ/SeMTxjcsKzXUgnsot+ROx0dvozLa2
	ZmIW5ekevJYtM+ucIwI+bXR+tReaarKWSFpvbksDhLWG0Tuh/ZAfrcNPkM55ufuzXYZRfDSCRyf
	G5ljgOX4G4PygCjgSKddgI9zByPBNRqKtW3/OH5azueiVGpaOYTeYGjjmkKRXr0cb4CFnntGTD9
	ja3HH8piYlQAOy0IKi4b5N7yQP9+36CNYENQ+rjw6a3S52aQX1EyLGNu2XqIGkAbYC+E/rpOM3b
	ERZOEpz58NFZwBhSxHLAY53GhA==
X-Received: by 2002:a05:7300:87:b0:354:76f8:300f with SMTP id 5a478bee46e88-35476f831efmr7895264eec.27.1791689351545;
        Sat, 10 Oct 2026 20:29:11 -0700 (PDT)
Received: from l ([2603:8002:ea00:6800:4112:f5be:f9b3:803f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cab27d5sm22393297eec.17.2026.10.10.20.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 20:29:10 -0700 (PDT)
From: Dave Seddon <dave.seddon.ca@gmail.com>
To: dave.seddon.ca@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH iproute2 2/3] testsuite: fix test_on_not on multi-line output
Date: Sat, 10 Oct 2026 20:29:05 -0700
Message-ID: <20261011032906.1398174-3-dave.seddon.ca@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261011032906.1398174-1-dave.seddon.ca@gmail.com>
References: <20261011032906.1398174-1-dave.seddon.ca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

grep -vqE succeeds when any line does not match, even if another line
contains the forbidden pattern. It also fails on empty output.

Accept only exit status 1 from a non-inverted grep: the pattern was
not found. A matching line or a grep error must fail the assertion.

Assisted-by: LLM
Signed-off-by: Dave Seddon <dave.seddon.ca@gmail.com>
---
 testsuite/lib/generic.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/testsuite/lib/generic.sh b/testsuite/lib/generic.sh
index 8b339ec1..ac48f023 100644
--- a/testsuite/lib/generic.sh
+++ b/testsuite/lib/generic.sh
@@ -113,8 +113,9 @@ test_on()
 
 test_on_not()
 {
-	echo -n "test on: \"$1\""
-	if cat "$STD_OUT" | grep -vqE "$1"
+	echo -n "test on absence: \"$1\""
+	grep -qE -- "$1" "$STD_OUT"
+	if [ "$?" -eq 1 ]
 	then
 		pr_success
 	else
-- 
2.55.0

