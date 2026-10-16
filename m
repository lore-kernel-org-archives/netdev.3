Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D303C3F67
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792156841; cv=none; b=Q4D9s85QvJkEcFUr5eDEwPga+OnO+R+rsCIQ+HGInzWjXE8Wz54W6nt4NaMPMXyzLdtm1jpPBCP47A1oGqI3c8Fy8V/xwnosCrJAmebHcjSZzgrBlpHnBkoUPYrcScrpIunoCY7pymWetUdfvPH9TbVqlOLjcXs+K5CK07PInNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792156841; c=relaxed/simple;
	bh=8LZRcG4RAXDCcewy5ZGkTw4K/dxAa6eoPk3+1qnhNgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GcMGIN+yB5TYS5PJQDbr22ji3nH7HAscwjRnzTS0TQNyefo6K4ujBUPOCIRERYyYfCuQ6BybJwfOkvTaa1lxdwy+gFz2IAUXQ0018fgY83NKr8+HRS795XtOMVg/m9EUxJKcDTHHdrc0odA5+6NhKaNlkpy4artIPo2VlhgTf4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZervzatF; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZervzatF"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc4aa0246b7so2922668a12.3
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 06:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792156839; x=1792761639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8LZRcG4RAXDCcewy5ZGkTw4K/dxAa6eoPk3+1qnhNgs=;
        b=ZervzatFkoo2sXjhZ1M4J+7RUPhjB20lIDF0+czu65Gjrr9NrUEmc51GmMWp5zbm2x
         HhdULtZrHnurc2nJtN9M11X4rRFICm+1nhuggXWKHZy8K/t4wp4HYusiCw0LSjXXIRLw
         +0zpn2VClUnOQW0t5gDM2gdBhZONmtLeNvctPIeGXJXzvB73Vg+mohA8D6BV6lkXm89M
         rtF5P4OTnQKSpGQ8Ofxri8bxU86XUrfKEOlwcEYK+06njysL8IDVgpxkfFnUdarMGlaz
         ddExseChODmoo++5Ie9apti65rLv0VvOOuviKi7nznOysmcYJ1aYtCgxRweNEK+bwe14
         libQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792156839; x=1792761639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8LZRcG4RAXDCcewy5ZGkTw4K/dxAa6eoPk3+1qnhNgs=;
        b=ePdoMaJ33f9S3q0beAgKz56OhO26C1c9SHBHZ1xSaKGQxIu2P+mE/a4RJsTfxOkEpE
         2eGgXx+G7KdiaR8YnpKynBBTm5MScPCMmQoiH1ZBSPjMdtDp/NPuR1Qmd2JMgHTlNtQn
         WKvq0pwhInoOSj6Cs4est+YcYnXYu/Kx+8Fh9BsZ5RISrX8MbbarMQy+EnjpnalUUa8K
         hqQ61BXuK6w20vP4K0f3uupwdPhW00OyCgaNVw+5OAIkZ/hNTeMF48oxfa1ISg6zWdey
         oAF6VjSDkm4o7NpB+C12nY2fUAJehZt7U+TZpnvC90KWPwV4I8bx90jbvUBWOThevNfb
         +6Rg==
X-Forwarded-Encrypted: i=1; AKwUvBxd2Nt2zhoKURPKFFQdWKeZ0H99e342ad0GIuUiEL+YrljL0uXJkht2ZVUFUYM5BEE+DUpBEjw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIjrLgBinbD7Q8XIPPgVGdMj3b6WnJwgoZb7LPOysdd8ZyRphgs
	277SFN8vpJPxQ217p3DVkwWPN37wPlQnEHp34HJaZLG8r0hr+RbjWHem
X-Gm-Gg: AYBFou0bXa3FWVEzNLpWFQAxaVJpZ0ES/K06q0IqicpeN9Kef0OKsn0CqgxYe94tlRM
	7FVfOrohIc7TZD2GGs21tw5v5CcXIAU4Y32qAgSd+VJHGUUU0YZP4HO/ZbZSexBfDeBTLrNr1R0
	DHdJzoeM2dCdpOupghz8AjdCERbMgxBVGog/dOY+RjG28f7qaEURjhP8mlXweS/AXnZmfL1lKLI
	xObCxNGr888Lo3s8rn2Y3ADRrNlEJAKTVsl929ajoGrDFNQaaN+1fNDnqeDFtj7uu1Fc6yNNetn
	T99EZ9+ecY0cWzCzJdg1Joi++6zZxcKTLiTpB2WFRjh+tzzyvfWSrpk2AUxou+YQPd59Iu5jvZH
	OSSAtBYCYwaY7EM0KkNWTpa+f5T1l9nrKK8/39ssdLO2o/pvAVXIRDipJRejFgRBli8G6P1+bek
	YRnvE+bAL9aB2CHD3Na0pT8uUr7IIq268DlHLBcTSwW7c8A/nd7qiou7jthNe19t3r6Mu4Ve79S
	QpSKaRe2Jviag==
X-Received: by 2002:a17:902:ea0a:b0:2e9:492e:1688 with SMTP id d9443c01a7336-2e9492e1786mr75900865ad.8.1792156839354;
        Fri, 16 Oct 2026 06:20:39 -0700 (PDT)
Received: from DESKTOP-NM9EKIA ([125.134.240.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8997edsm10013245ad.63.2026.10.16.06.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 06:20:38 -0700 (PDT)
From: Joonhoe Kim <26rote@gmail.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: mani@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	christopher.lew@oss.qualcomm.com,
	deepak.singh@oss.qualcomm.com,
	pranav.phansalkar@oss.qualcomm.com,
	andersson@kernel.org,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: qrtr: ns: retry service announcements on -EAGAIN
Date: Fri, 16 Oct 2026 22:20:33 +0900
Message-ID: <20261016132034.711-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <bbdaabf7-ffdb-433d-91fb-f6ca03b0747c@oss.qualcomm.com>
References: <20261016124600.31-1-26rote@gmail.com> <bbdaabf7-ffdb-433d-91fb-f6ca03b0747c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 10/16/26 3:14 PM, Konrad Dybcio wrote:
> Please remember about Assisted-by tags if they apply in your case

It does apply: I used an LLM for the analysis and for writing the
patch. I left the tag off after "docs: remove Assisted-by references"
was queued in docs-next, but I can add it back in v2 or note it below
the "---", whichever you prefer.

Thanks,
Joonhoe Kim
