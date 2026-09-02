Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9809E42FCAF
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 23:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788390465; cv=none; b=hKT/DcG+KjiGsx+P7STBNV0suoHRlQtTit3OQWkEjegTNwgoyDh/XYh3hqIDQnUztOlmYiv5ZrSSmNPJOz9s4t550oOEH1QPMMHK27f6hrF0zLSl5jwEQv8xzMcxxTCZQOuhEAsu/ByRsMAWq9YrVYcWLiQ2dvy1Ss1Qw3G20Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788390465; c=relaxed/simple;
	bh=FPw2qoCAygOuelzzT6s8wm4xFHg/CUJYc/1xU7eQQtY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vDaN7gmCeCGCHWDxdJQv8X1IDIgojfKOb9tMTq2iC1OzoQFEkE+I5SQjdPxyXbeAmmvWjDux+q6WMKnHle8CkgSOLvij9Vfr10+lTQOSRXsGCiwBO7vcyCo+l46GW6VK0heE7i4/FYlnl8l4I9ln49cPPq7/aNEFr4PuVnfr+hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sJuR0dPQ; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJuR0dPQ"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7f432ac553fso1260198a34.3
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 16:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788390462; x=1788995262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GVDrQQS/kyn4zom0Jc2UbkP56M2CKMIeurl55CIFbqA=;
        b=sJuR0dPQqGcgqgO4h2YvzpQHdHYBCYW17Qt3zuZZ27PTkzGPrrke0/6dVOFLvGAemF
         Q0/+7YOCM1/d1bVZ0yBpKFszVCr6HkK7iohdq03y5qKP7sQDkWyWXGDKBfK2pfv5AbCC
         G8VCyZtetDMUvh2YrJnhyLC/J8wsjtm0vEwnnVaQEC02hQx2wDxJYqhZxfwsOQIrVWLl
         K4YwSUWz+aD5/DKzdbU+HtrFDP4bl1KGQkKuwSny+JloEDV8WrLGx6G9ERnPYtTeLa69
         8KOjkmPd8Bbu+5hLLJXIPGvVWvWErr88I5WWUoc0eb686IHAHsx4D/7+DqC1aicYgHsQ
         Ynxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788390462; x=1788995262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GVDrQQS/kyn4zom0Jc2UbkP56M2CKMIeurl55CIFbqA=;
        b=iDnrIG1ZugyodGEGFDiO80yBi24jm8gyyJnQTp5H9VG5YiQl+5HGkrpdaG7SmbQbrZ
         /TvqxAa8pqbpPeofTM+GLojCP05MCULfGuv/mxc/syLyO8WzzDGTNG+FK0t/IDhLlkL9
         Tax22+QHPZQGrQHXcV1ENxIDRrIqwww4qKsKt6PfPq8TcWhBYwB2ftESHHXpIi7Pts65
         o+jWQG2EBHx9AHz4NnBalWL2dRgzFvOT3iACFAd26yN/2BhHdeDejudRA92iA7EV9T7Z
         Ds3L2sjRy5sdg6IvbGQakUPXOAdvOz9JcSZ1VqiU49qT0ZFRmQICyn3rprgzUaNnvkCR
         sbyA==
X-Gm-Message-State: AFuF++lzt0UbOCYbSdMwouaqY97fHAXoCwp061CzN08UEgLKRV1kwpRx
	o1nIr5jJvY4WZorIlst+N82Jew7/is0tWuF5/vqiuQ6QUO2lcUgLMwmI
X-Gm-Gg: AYBFou0aQZVVjbye+ie29M06uZYHpdTQvJ7Rckr34q7ZgfD23qqRArZqN6Bvsv2qKWo
	5WR00N9NEbRrIk9iMNWsY+L51Flbwiu/GMJIhxEBli7R9U7DhSpHEZDfetZ1QB4N/G5Ge+CFr6v
	q9kyHpcer7pZyICyRUxlLBO5RhbLKwrdVvWQ5DLmhVkwrDA7gzdNElTHaSgF0GbaQX5dLLuUFPE
	kFjwSSDQ9c79ZVVh3Ek1Jon1GB2lMyXWXKqnmePBQJkXXP6s6jL7gA155KAM/EZgWHS8A2LFvAW
	4YiO//5anG2RQfQ2sixiIEZ/4uncfQlhRLAr006L7DpVJM348OW0W5ADC8TNTDkZZvs90V5HsD9
	CAzihfH7JmKMyIc3/4nherzTIPyc9csa9E9meMt1g8nW3Hy7X3jm/kRUClaX2pasTD5m6S5YJ2G
	of8DqmXdUwOnALTnjwHy6xgalQOw2ppHhuKWAqcUDZR033ziSQLfgHTMU2KhBYBdM25uEr0A==
X-Received: by 2002:a05:6830:6a8b:b0:7e6:fa37:9797 with SMTP id 46e09a7af769-7f77fc1e1c8mr9042031a34.6.1788390462538;
        Wed, 02 Sep 2026 16:07:42 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:2a::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f74f3e8580sm3569638a34.15.2026.09.02.16.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 16:07:41 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: mkubecek@suse.cz
Cc: netdev@vger.kernel.org,
	kuba@kernel.org,
	mohsin.bashr@gmail.com
Subject: [PATCH ethtool 0/3] ethtool: fbnic: Fix register dump parser
Date: Wed,  2 Sep 2026 16:07:36 -0700
Message-ID: <20260902230739.2241212-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohsin Bashir <hmohsin@meta.com>

The fbnic register-dump parser is out-of-sync with the dump layout in various
places. As a result the values of some of the CSRs are displayed using the
name and bitfield definition of a neighboring CSRs.

This series fixes the affected CSR definitions so that each value is
associated with the correct register and its fields have correct masks.

Mohsin Bashir (3):
  ethtool: fbnic: fix off-by-one shift in reg dump parser
  ethtool: fbnic: Fix various TX and RX CSR fields decoding
  ethtool: fbnic: Fix register dump names and bit labels

 fbnic.c | 165 ++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 113 insertions(+), 52 deletions(-)

-- 
2.53.0-Meta

