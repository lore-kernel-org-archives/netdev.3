Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36C43FE667
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 22:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783550494; cv=none; b=TZUnzbqYlvaNUiPg+yYzjmhPM7H1NlxErwnvo9PUHKVY62dYa38ejI5Pf7V9eBVlZu7GGzVTRIre/JmYLTyicWIqvD6jCnoXEadyTIZo2WlPD9GDQ6FQ2GziaQwJZ8GAgjB7Qbg9DGwo/obWwrj/lvn2AvTPNJr5BJyuT1ty/No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783550494; c=relaxed/simple;
	bh=/kStx5+MYKNi3KU6QuXQqfe4BGwqSzXw0I0j4GJLc04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9SqWa2sJGxEqxERdQ3k1YPapzXczNByKJ25IWLRO8j9ysmhA3BjOx86DhmF614qNzguqUpw2dl25AOrXypwJSj+u3lVb2EUyNT+b+ro9WmuBnhr2VZXQoYse0aIkdpxgCXQQYz/3hdM5pD4Dx2PY8rTrVebNambVSYyeek0kQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUsEbV58; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUsEbV58"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-847a5528b33so777665b3a.3
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 15:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783550493; x=1784155293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/kStx5+MYKNi3KU6QuXQqfe4BGwqSzXw0I0j4GJLc04=;
        b=dUsEbV58RFYQtOnOqSykJgsFXQXJ3m4fmnexmalX14kwAKRoAT/be7GJbAZ3CTlBWJ
         n80Q1V4GJ8A8SOHcUJd3vZaNSzX/IZ8s4p6VhkNw9eLbmM2qtUPoTAWenc/TbKDh9XEJ
         PJuknoNx9S6gwfpiHTD2UxmAIEQEH/NTXzcMNOFLVn9zjzlMoUwFfgWNYGQRvN/ULgPV
         tTc25APXjf3ftjPB1MXgCdM8UOoqVn9L0poNom9/c0I3TGNXIARH0F5xcTyQIp0V5x8j
         e1QN2dV4xpKte+CYIFLcanRqILsbgjZuxVl++LSkkjJpiZeqX55KXf/vjyLWGsZrefbF
         +NHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783550493; x=1784155293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/kStx5+MYKNi3KU6QuXQqfe4BGwqSzXw0I0j4GJLc04=;
        b=c/VCJtb7NkM+WwIrcQR0a7XBNHMn6l1/ThDAve1Xywg99eoey0ibuJF4I4FOMwxZlk
         a8dEFK0tP9QVe7etoA8E7HLBxpksLF/eYhWKhhNWwrhzb64/0Ok9QN1o4S/t62XzXvJO
         mL/7AARRuQb0ZXOmeUrvRCX6x2RemZxYExc7Yav/jxNIu0VvR/MeoR0GJoNd49mTN9lZ
         Z8YqBJhn+1qmPwq5d4houo1s3YPVSor8nT1tEWCRqRpzYFzmLFJUKiLmTAdnJ4z5Lez4
         LqbnHlUB7ki6tvEa4R1648Cf5FUn/XdIv8OtohIi7/ZqWqhVafnbvOUbC0TPnzguZJLf
         2uEA==
X-Forwarded-Encrypted: i=1; AHgh+Rq9xJW59VCF+FKW88G4njP0uIOoQLIiaPIbB6joXzc/5xC6DoaNdVzF2n8mcLoWqJxPQHLTOt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA9HJ1R17FILMvzo6tt7khrPCligayEu5JvBCG1SZjNlg2MlOW
	x8KBYoGosOrVf5p5tL1oYJlv7MpWpE0sLJvHfkHw1Z1iZn7bBlqBeAzO
X-Gm-Gg: AfdE7cmCDWsftJNMJM9wlIMXvyBp9yyyCyTZaImWXTFRIzExygTyrhUg9Y3o4UblSmW
	mPU9cjZ0Hul6y5lkuO4C5GxYXTgfojvy1ZGe+S9TDj44MiiynJD3Rl8LR8U+sWGpnq8DjGOqg3f
	VjXoo97ZKPBONL8Tm1nqZ0XsZ40817kpCMxPCHmCsl+vxgOP9bFkRIk2qGm0OKiTKw6bdnSKUoV
	wWPz2iY/f0YnH0VwpTgxcABNyCJTwg7aP4dRyH/32aC0xfFHTTZq6vFtlidM+6JCATih4/JQvH4
	ewm1ke1MRWGFIUdU6tX6j1dgzEaoFhINbC/q0UXJr8v0T8yBTxYOa26lDrMXT5tj1wHVRbZGYDx
	7FGwwGqfJRReH3Tx5LDdjbDugdnoFYWHCD1aVEOmpF4BjaiiSs4yf5WecYnv91TmeQ+Pi+pZ4VT
	gR0/roO+SLfXrpxayNBu5T08ar10TEiQ==
X-Received: by 2002:a05:6a00:2288:b0:848:3bee:f1b4 with SMTP id d2e1a72fcca58-8484368f2c4mr4175660b3a.64.1783550493193;
        Wed, 08 Jul 2026 15:41:33 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.localdomain ([167.220.148.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3a2e420sm2936348a12.29.2026.07.08.15.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 15:41:32 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: vadim.fedorenko@linux.dev
Cc: AutonomousCodeSecurity@microsoft.com,
	blbllhy@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jmaloy@redhat.com,
	kuba@kernel.org,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	tgopinath@linux.microsoft.com,
	tipc-discussion@lists.sourceforge.net,
	tung.quang.nguyen@est.tech
Subject: Re: [PATCH net v3] tipc: fix u16 MTU truncation in media and bearer MTU validation
Date: Wed,  8 Jul 2026 18:41:29 -0400
Message-ID: <20260708224129.3722-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <7a6d7de8-7c33-42fd-a0f3-68bc1911b0e5@linux.dev>
References: <7a6d7de8-7c33-42fd-a0f3-68bc1911b0e5@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sadly NLA_POLICY_MAX() cannot be used here -- its .max field
is s16 instead of u16 in struct nla_policy, which will
overflow to -1 during my testing.

Please let me know if we have any other better choices.
Otherwise, I'll prepare a patch adding .min check (
TIPC_MIN_BEARER_MTU).
