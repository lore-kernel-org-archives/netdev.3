Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9F83A75B9
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 19:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777838035; cv=none; b=Zh0SMuL6uZIUh2Jj9S1r9HMJhzm9UPkQvpPR8HY0SAMD0robEd7LyUgIXWuXsQOiVdceQpR4VjZ43dKW8kfgnba8AsZA+UOnlNBHk7KwGpHVqYqwNIKcH2jBv9z3UXwWtdVf+SVvJFohTo3qJh6OH+0H2uBqFC2JjO10EY8jJ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777838035; c=relaxed/simple;
	bh=81DV3vOOW/ZYued261SAg6BbMfOBMoW+ILCjhv+3094=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zh8KXqH+OaL8bYYZpLu235+mlnuL6AGkQynoD6tqgwIZPnFZko2VR94g+ov7tDVDWlXOzpolRwcg7fnh+K+AbS1PINQjVTR1rVMlnDyQSADytZNfwUlfap1Ro7ggEcLp1Etv41oAEYX/b1YGOxF/ufTH1RQf2ZHH072mXxfupHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=t6K7Zzf5; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="t6K7Zzf5"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2dee127b3c5so8403985eec.1
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 12:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777838033; x=1778442833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+SHBsCOw7VI7tu7TQ8E11dBIA+qtG1EQFQ9pVsPXkwA=;
        b=t6K7Zzf5robIJXbfQiPoETZUh0gI09F5PWVrj8cP8BqL8yp3Pb4uUOXbW9rebCaPR8
         9fpVdhQPb8XM2qFFqMEyt8y5Y7vv7Fh3T0YCsrtfAD6r0xjMi+1fujkhip4MHYAu5An4
         uo1fwur8SKxw/wgRLwE1NUC0we5v3Vb8isXv9wt80fLnbYVvQH+O/n3IslCkKE2dCG1c
         ghg9VB2oLDWFItDo0xBOp4YGM16P7VQQq9LdyCT3F7vXeJ+ygnWBae24+wP2W2/fbl8W
         n+XSGYOjIevyeBdyhSDoH80PCAbxHJ2Ygc85DM6K67ypAxZXYLhyCRmPunPFXulXk9g6
         2eGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777838033; x=1778442833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SHBsCOw7VI7tu7TQ8E11dBIA+qtG1EQFQ9pVsPXkwA=;
        b=stNpkMqUw/W1P4zciy4Z09TegpiXhwZ9rf6K92Z4goAO+HCgE4ySfwQpgkQzY30YV8
         OTw8DCzOlpv13F3dcan7RuujH06JL1tVUwagvXLT0uy22dJSVtAN3ih6nsaJnBhUCBN1
         tVLVvDUnwdK7l7itTzl80e0m/4HN/00SRDXRWMHcXNYUvMkzeTyHmdoeKI5RL6FFDMQL
         g/V27MYbyxeWTLkLgXTa6T2vlyUt1Vix8QGBtJtqcYXLIie6hwUf3VdfvuEYRvIT2obv
         ZBomINrN/RykNPWy5RmjzSMwq9s1sOwE+u5ZtNkNfHGqMoQo31iHhApItPnWGbkeg+Wu
         gsJw==
X-Gm-Message-State: AOJu0Yy0zm3oK+wQC6Sb1LxBxWHNlXRd8FR1D1dRR8uq31aPDnJksP6X
	oc/5dL8pMbHgbLBFdMgaQ9SJdeR1sSdUre8sxhEkwAWIWTQERWtqmQVNrTsJkGJqz76wGchSByF
	MWe04
X-Gm-Gg: AeBDieszjt82Ock3uxwreyynwV36DDXp1n94E3YJUXslVuTevEgrWzT1/MVcM6o0XCQ
	wkaryBic7chWeBwGqdiWAn1GjKHa1+HIdXZjAIc2EtXy3a8lCi07zigIyDigCaiUIx6Bw34oCht
	DEgsXwU39DRbn3zn8+rjk2fIAHWMz+7IQXg8HQPTefFwZbmF8YGdmHNrw/Bc9eNQgVEGQOWNZKR
	UMmTTXgSvwf3EvMoy5ThbRiHDKmJAZmIbjT/aIef4phwf1AEFkZh+Bu4WPKYLkyEHcZW1EYlCX5
	1FLYnx2K9fqY9NmsHc/t/4b4dsbQuddPisBDu9nhnDjAUlAoEF7zHw/BeZLJ/RUylAQQ/YeptQZ
	UYWi+AqtvBV/YBu/+6ff0DRGcBi4Vq2NBpyMJlFiiF8RQIIgXoZeL+fpDQ28mjm/ZKgiIJ5aq2V
	popYpFjurSuHY2xNRIHkZaq55fKxDpY42ioOJBEyfMoPhhivhajmoQ9Q==
X-Received: by 2002:a05:693c:6081:b0:2f2:6dde:df67 with SMTP id 5a478bee46e88-2f26ddee15fmr238887eec.22.1777838032176;
        Sun, 03 May 2026 12:53:52 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3c24e738sm12834365eec.31.2026.05.03.12.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 12:53:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH net-next v2 0/5] net/sched: netem: fixes and improvements
Date: Sun,  3 May 2026 12:51:58 -0700
Message-ID: <20260503195348.521225-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a collection of improvements to netem found while
investigating the fixes now in net tree.

v2 - incorporate AI suggestions
   - rearrange netem_sched_data
   - add multi-segment corruption improvement

Stephen Hemminger (5):
  net/sched: netem: reorder struct netem_sched_data
  net/sched: netem: remove useless VERSION
  net/sched: netem: replace pr_info with netlink extack error messages
  net/sched: netem: add per-impairment extended statistics
  net/sched: netem: handle multi-segment skb in corruption

 include/uapi/linux/pkt_sched.h |   9 ++
 net/sched/sch_netem.c          | 212 ++++++++++++++++++++-------------
 2 files changed, 136 insertions(+), 85 deletions(-)

-- 
2.53.0

