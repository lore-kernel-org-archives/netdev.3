Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826A82931F1
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 12:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786712157; cv=none; b=dFQRfpzniztPluJcGLZTJqG/rcnDuY7wat18qSrgnovjUXTaDNiKw7Zo2jdy5z8H0xbpRTBnTC6gG4ICMIvkyOehYW9fncAnVADCa/hdQ1p2tTwxJKBxiW/bfcIIW1N99jVmZ/y4APTVevIhVwmSilkMdTDd8/9L7cfAKZOouLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786712157; c=relaxed/simple;
	bh=VOLyJV1YMB6RvEcrxsyVYQqdA4BdqXzTeKLscx7inso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCKW58UU/bU9K4uPCE94Ph5QGJXXnRutsaL7hcz56R3ToXgPHbLvDv0Q+Aa1YyidVw9U3VoIK69ib3bqCdcRsAJ71KSMX2yLawmBF/VB8iETCW3hc/p9ZwVpQyjOUG/DoKx3EWQI8Iqb+YCbL5b5ayVHQDwj+tfe60o34GqFu4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=liba3xSS; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liba3xSS"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c9cf07d2df6so560173a12.2
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 05:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786712156; x=1787316956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gzHTwgGGGJTxkksfQ8obu4C7cz59h4eFFJA17GQX+k0=;
        b=liba3xSSw8K3a+PfgIBkfr9s/QCfTb6UCcjzgcLTW2/R+UOejQl5UOvbisGkJzg6gs
         /W+jUoJR3dBe2Kgq5jn7g+/XFTcUGgWKeDySfGCmOwN4AflyJcwypLzzRmU7/vNdFbXV
         fuXZg6ummXQiW+digGKWLeFN9i7uyxzAxHTPMikScB3rauK5lQR36D4lJPZPWNFnLcU2
         1jmOi0TRBBf21L0LVAKcqzYTD67WgZQZ/J9ylxQHYIFSeByLuOSh2oaFcQEQw+Avjb8y
         fAs4ed7Jc3P+xbeWaLOxwIk3ppONtDM6cHrXe8Spmmbn5we6eieIzwHAecxa6y6mxEyL
         U8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786712156; x=1787316956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gzHTwgGGGJTxkksfQ8obu4C7cz59h4eFFJA17GQX+k0=;
        b=PKSwYZY2Oh8akP8wW3wBqppQFkZaMdzxrEBf2YR9f+bJ+4tM8MwYWcHLLqb3UuScum
         5ShJ6dmTYgACYwgmmdNvaix3k7UYlF+2oT+D3ZAWXkTXWWzVvNapxAGSlulYPRQBXopY
         iyGJe+ws2tQxsQb8nsV7fn3WJSxh8zG9sJ2XvQxl08XfXdALiouUy1HbxjUKaMWAziaV
         vMq+LJpeXpMVJq1BtYJiUBnqWG/xEQxZKWo6f4rnWS7LAKZU/1kVMwVFzb9qVo/xBoZ2
         FRsrxrkMsY2mUzbN97LYjw/+mNqyHO5oyayhAJgDn8euhJpfqOg3hozYDi2thbMeSx+K
         v+FA==
X-Gm-Message-State: AOJu0YwdMZoDaEiDGWoaCglUBg47pYXXVJJDBbx0UHxC6KvMHsifRn4A
	gcLVnlHeAPFZWtyaFy2U5OSiTMpThAuic41hcGTm7JSeESIpooE47ru3
X-Gm-Gg: AR+sD11Elw7SarxSQAxhlN7roC4NjiV6PyjuZ4rYtKFwvdMxvCwRd3zrfgobFAeoTpf
	VuM293byqHl/ITsS+HiJs524MPMytGG7ckPgSUsryP9lz6RdbZVDUQ/RpPJXVvMa5aHXzlwwX9L
	XUMwWE5NhBmd7aLjz7meJls+4WbCyW4X5rO1tRBqKBAQeNNKRO3NxjC1LydWRil/NFODlbEbVHI
	I/dDa6kCnMC1ceiDL0GqdC9CSusjIYDYNBZVXe+1BjNr7CJSh2ask+0+XnBrvWr0xK/AryVZ0Aj
	R3DRItV948KFBZakKggD9L7FhXBOxobRdHhjut+e5+GHryTjeSB9TnBP0l08JpkAov7ToVVUTjv
	sRBZ+C3jUOjcgqd8cQIeyWBY4A7FjJhHbpdiq83FDAQGE7XEnvG5wYaniqE5sMa+Ij7sw106aVw
	u2tfql22NIuD4bzN2m2/x+4jGxRyASmRU8d3pZm/veFNxMI1f831mWX+i5Wbj+CjdBR8UyjOaXv
	ddQfl1YEoRwPw==
X-Received: by 2002:a05:6a21:6b12:b0:3c3:b57b:6459 with SMTP id adf61e73a8af0-3cc719931b7mr6115725637.7.1786712155691;
        Fri, 14 Aug 2026 05:55:55 -0700 (PDT)
Received: from ubuntu.. ([49.205.39.116])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-cc08f3ab9d6sm532293a12.13.2026.08.14.05.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 05:55:55 -0700 (PDT)
From: Ajith P V <ajithpv.linux@gmail.com>
To: tung.quang.nguyen@est.tech,
	jmaloy@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] tipc: replace deprecated strcpy with strscpy in tipc_bearer_get_name()
Date: Fri, 14 Aug 2026 12:55:47 +0000
Message-ID: <20260814125547.325298-1-ajithpv.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <GV1P189MB198852836DD6CF9922258C7AC6DA2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <GV1P189MB198852836DD6CF9922258C7AC6DA2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> It seems your patch is not based on net-next tree:
> "Conflicts with pending/net patches (net-next-2026-08-13--12-00): error: patch failed: net/tipc/bearer.c:209 error: net/tipc/bearer.c: patch does not apply"

> Could you please apply your patch to net-next tree and resubmit ?

First time net contributor and I'm a bit confused here. When I cloned the net-next, it applied the same patch without the error as shown below:
<path of the linux tree >net-next$ ls
arch   certs    CREDITS  Documentation  fs       init      ipc     Kconfig  lib       MAINTAINERS  mm   README  samples  security  tools  virt
block  COPYING  crypto   drivers        include  io_uring  Kbuild  kernel   LICENSES  Makefile     net  rust    scripts  sound     usr
<path of the linux tree/net-next$ git remote -v
origin	https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git (fetch)
origin	https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git (push)
<path of the linux tree/net-next$ git branch
* main
<path of the linux tree/net-next$ git am ../../patches/v3-0001-tipc-replace-deprecated-strcpy-with-strscpy-in-ti.patch
Applying: tipc: replace deprecated strcpy with strscpy in tipc_bearer_get_name()
<path of the linux tree/net-next$

May I know the correct way of getting the latest net-next so that I can reproduce the same error and patch on top of it?
