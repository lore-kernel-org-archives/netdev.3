Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B2D48B397
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 12:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788525406; cv=none; b=nGhZxUKUqz2QJYfqdf0CJQ4Y3LxAqoAUXZpdOb9u4RIvh+oGUhyNZ2VFXwDYlj58hpaOxhNjK19/UMaI2bvm15L0nLgEzQzWqpoacB9u9w5jBvk8Zb37JcRsOkt9QsG6dcC/aVOvQ+LmPB3Ao3Z0lJoIBryKpw4yXtZZF3XJOKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788525406; c=relaxed/simple;
	bh=khisnwFFvN/2OJ2FVddAOC2MAXCpJGTfJKAU4o+fUSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZtYoOLQCJq8fz6IRsI4s8BR0/aXvyDCxruyYynTeKKVUAY4H3nM4qVq0VhcqPRUOL+axR6/xZ9m+l76sr/7xnDCKFUEOuXa3/3pfjULDWnwgiIBsSOR6vnNkTt3oB1od6SLRd6AjEDyDj0OYInCfrppZK7b8LZiVToNICdxADjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWv/XYCD; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWv/XYCD"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6aa9606ddadso685994eaf.0
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 05:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788525403; x=1789130203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KDcVHRiCcWITb5IJ0zmLWKIunogWiUsp5pyOEBRgLns=;
        b=FWv/XYCDTi2pJO23fuwwwUHKAafFGTh7KjHSoeeLXZN5ky06zxvfC1E6HFNDp5hRT4
         LvP4Duea1HH//tR1Ya/dHiEArbc+tja03zLW32uCjg7Wlt7OEMUBE7vDTFT4aHIIeU5U
         jq+bkSmcdloEaWjweU5xnzPI6DKbNwrtG7dv1MtKrD1UIB+TTdvNYf/VX67K3WxnGYaG
         usT1nVk8yW77gUlBamHXkO8UKvM5E1yciU9ecx1syBBfCRnbjGdwXf9TdSr+vSS4dE/M
         RwmPz9J7pR6rejCOV2KiMHWI0SGEoZ/E3lFVNgsRqFRSQegI7aA5uCxtbkl4odbT155Z
         775A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788525403; x=1789130203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KDcVHRiCcWITb5IJ0zmLWKIunogWiUsp5pyOEBRgLns=;
        b=Kg7OQ155pcR+zyPEGyUHigEVVAbn1Phr9seT3r9JrCUh16VOyuTyBfjPEr0gPDxLrC
         a1fd68CdahI85gZbts4sVpFCuZfbFKnysu/eHk0wDin1XsaKugE5nGR8qvIXFPSMytE6
         Ne+pTrNYHqF5MYQqWbMG9ZYwj1qJK6VXDUp3O0GbkdkzxwgFK91L5Z07LwO+G9uf3Rp3
         2vc0IWfOf3wl+VJQOo++aeMV/IMKnreLX4YpVqnGi/7Gvkz47c5UlHVs6i8rv4s3G1kp
         YnseArMKrKS9Trqxlp6yNJf0suhbROGeXZ8RrBZisMSlVYBbD3tKezAhDdL2t5EnfOcj
         qigQ==
X-Forwarded-Encrypted: i=1; AKwUvByxQ3rHxsmrx1vWTCNRuBWAHUZn3AHeem3jT5Q1UGda3vEizk7lE2+2p+PD1lCVmZ50wknSZuo=@vger.kernel.org
X-Gm-Message-State: AFuF++lvJtqgYgpkNFoL5W2fra1GlssZ45edA19UWYkSJd+YcPwHGurR
	wjHeuJo77dPGPdiru7lxpAI1XuavJ66R0ENavwHnoBISZMftmZveLhtF
X-Gm-Gg: AYBFou06FEkkTS2h3y/dHh316+jwPvU4qqd7Y8INBon6QtK8D2Awg0NgIz+qKD/jLqn
	mUJKrlS02FqHnwaVMdm5nkU4eY5CSkV9sEtS6DQlPZXJCklAk9oorYgts44OlbbhGmgYycjpAq9
	W290vSWOWdAOP2Eze2QyHLnkB+9EUpjgYyhiP2cfFXOvT+mY+mdFlB2mSEGzSLribBASPwupx59
	OY3+cCfCZNQytBBSp/g1uYVOOr1QSkkHnqrQENZyz1QHdNxt2s3yR5p0jzXci7hz9XRA51CH74M
	1WtkDgq5KWtLaBwMM3/Li/Uo6QN1yoCgUokOLX0PQKrSOCXjiAXylbCeEnuNgrBYe+PoYvywGR6
	EADYIA2ExKPSO275yCXtpCJWBDnmybBXC1qI5OwQs2AErwbuk51zCnraQPhwqdWUGMxA25588PF
	+ei2DTOWZjLJDj5RQnnHX9Kts02QR8CvuYNSSUP2MBe7QJjUz3NV1fEW8XUoI8aKGbO2/GVqks0
	1fmtq3YecRYCCU=
X-Received: by 2002:a05:6820:340c:20b0:6b7:8415:d79a with SMTP id 006d021491bc7-6b78415d92bmr1050204eaf.69.1788525403582;
        Fri, 04 Sep 2026 05:36:43 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243a9388sm6480730c88.10.2026.09.04.05.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 05:36:42 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Chas Williams <3chas3@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org
Subject: [PATCH] atm: fix typo "protcol" in comment
Date: Fri,  4 Sep 2026 18:06:37 +0530
Message-ID: <20260904123638.39273-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "protcol" to "protocol", reported by scripts/checkpatch.pl using
the misspelling list in scripts/spelling.txt.  Only touches comments, no
code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 include/uapi/linux/atm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/atm.h b/include/uapi/linux/atm.h
index 95ebdcf4fe88..7a3789f39f52 100644
--- a/include/uapi/linux/atm.h
+++ b/include/uapi/linux/atm.h
@@ -39,7 +39,7 @@
 #define ATM_MAX_VCI		 65535	/* maximum VCI */
 
 
-/* "protcol" values for the socket system call */
+/* "protocol" values for the socket system call */
 #define ATM_NO_AAL	0		/* AAL not specified */
 #define ATM_AAL0	13		/* "raw" ATM cells */
 #define ATM_AAL1	1		/* AAL1 (CBR) */
-- 
2.48.1

