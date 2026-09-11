Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEAC44604E
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 16:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789144564; cv=none; b=fTgu0G1aJqZz4udYsuf2ablQiGBHbq4PDbLUvrJmcfxbt6ZigkyPUEXouj5cJoE3S1AfhEWI5y+lP1p+Md7z+UCbAhlHVSJ+s+h/usuAq/vDZH+1dFvgw9ym8NnsAaistIr/UmTbdviLxGbs53uvb5KltzmHE8PuK0B6a8PtwQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789144564; c=relaxed/simple;
	bh=R0XhzVxGIplG0TMthud7LnfIleUzn/+uQRtVxWfuhLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPHzSiRYZN+ZrXs55A0Xvwhg6Mg0c5dLEcWWY6WZUf3q0VB1UWUkeMXJTkVx3I76p8bqqH0oSHlqQTORlbxN/GP0yvGtXOVX+vIuzL1GXhUSrPf33kwmZqX+2VnwZkm0is9FdV+Ulj9EaCXXNH1wuQFNKllZBbiqxbnmVQpwZWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HaSEYsfh; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaSEYsfh"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a3156692e3so273891fa.0
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 09:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789144555; x=1789749355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uvtkVCglXTkIsJQIDmLubwTL07uM5Au39JyN8CJCMdA=;
        b=HaSEYsfhVGSfTSwoOcoGNR02FaQSKc56lWE1Nt75mzsAKE9OFMs3c2XWySUkh0qWNz
         48i6iWxz6qDDBR1VPHb4RvXJddL1WNzeUyFeThEsbKR53vjAbMhnkIH5cniRHOVcLCUK
         B0e41pO9tgulhIhw5pW8sUHujF+PkRTI771p8vXEzFBIm3DsUqzmAKJeF8/Lu/zkzYhF
         lPm0OwTy6lmAuecqlVN5kOZNU7US86Z3pxEbN5KCNLqgu7WywlzeMdCAam3t7B8Rt1HP
         PE8uRtW02VikInPgrvZO2jRMB4BTS5PsxDjvJT0a7PwtOMrCYRgrL2lB+/dDOcbzm+km
         roEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789144555; x=1789749355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uvtkVCglXTkIsJQIDmLubwTL07uM5Au39JyN8CJCMdA=;
        b=ILUPpG7kaEi5PRWb2ZRxKPrH9qeBnpaYG5Wl1DzIDMFRvRTV/XzFU9MITMrG1xlLjH
         5XMtNbs4EoW31kshCnbQcF761rK3HldiI+Ze8fWZHXpf+YVx4Qb9rLSuVnSMJxhI0q54
         thxs09sUZs3EGJBJUdVdlfefK5YKxuCVyTf7gyGCFUL86gHl9Emdffo8+KmOw1G7xpzk
         omjpL9F6xmHJ+wQL7Lsw4oxpaYhulY/eZxJMK86zX7cMFP1cZlF3SNnlL4sKJxrmqzA8
         QpB/uoNq2eRKs6BahxdXrFLSzHhYorlEfpur1UiJInFdTtXdr5/ioRkD55Bjhlzwhos9
         yKJg==
X-Forwarded-Encrypted: i=1; AKwUvBxGPayrlkYxsK4V8fyNytFuuNjChcR1s7Qi8c7Oc5dJrxGl6AEhv9W/rHVhtZm5lVJW5gq2b7k=@vger.kernel.org
X-Gm-Message-State: AFuF++kdFrl5gA99FLO7l/RFlms8ivHWBOJezWM7U3EQ1UMgyWgLqVEP
	WuYU/axECzXIR3JuHUzUQwIk1fSlZZAcJbBoYmUw+QGxLI1afHsJtZg1
X-Gm-Gg: AYBFou22iW8oH/1o4CvLb4Uvgd25CsOpyQbaxTqV5mQWtBG2R/iI02Cwyoh5k+dVmIg
	AthNYwyAVmj06O7cZo6QRrPuHB5q4sngX6wkiTRN/QnkHluFCPh6Qzv36HxtlUlJZWexYpkO+JR
	6ztWi36aEL478JCgXXba/x0sbLW9Ozn/BYYLldJjgtOiRAMpGbnr+6Rwh4M9Zc16dmCYI1tCL0N
	hfeLK1Y36AJF26+D0W+PATbP+xcGMPQSwn1dnVpI3JL+Q3sMekpE/SEAK4BahBrljRVSZa2HqQ1
	f6hnvhzeLBXH5ev1puHfVlO+V/+XulnbuM9li9+ZfkTltEdZn87nAr698TFQw//qtI8Ku3aSfBc
	E3paxcsHGEURHpWK9I1lHtGbH9Wl5aQZZsqS3sPQXRWJUignP5HYa94lkkYUQ4NI+YeIREWU9jk
	SiT+oeZC4odhMtL/Ggefdhn9MYLv9XEVCZmNjNsyASqopHKl/a5Dh5hCPkbMSTNs0yjl3nG80UW
	r69ZOUaFPvm11F9NWaY4utNLHsYlpKnvzSM5NMiqUEp+XGglukUG2U=
X-Received: by 2002:a2e:be95:0:b0:3a3:61ec:7db9 with SMTP id 38308e7fff4ca-3a5a3eb96a1mr6335341fa.15.1789144554984;
        Fri, 11 Sep 2026 09:35:54 -0700 (PDT)
Received: from pc.tail250202.ts.net ([87.110.86.243])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a5a33262c2sm8524061fa.20.2026.09.11.09.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 09:35:52 -0700 (PDT)
From: Janis Edvarts Lacis <janislacis06@gmail.com>
To: pabeni@redhat.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	janislacis06@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	liuhangbin@kylinos.cn
Subject: Re: [PATCH net] net: vlan: fix vlan name truncation
Date: Fri, 11 Sep 2026 19:35:43 +0300
Message-ID: <20260911163543.204203-1-janislacis06@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <bb5eeef9-a78d-44c2-a8f5-2cddd274d3ab@redhat.com>
References: <bb5eeef9-a78d-44c2-a8f5-2cddd274d3ab@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Sep 10, 2026 at 10:56 AM, Paolo Abeni wrote:
> I'm sorry, but I don't think we can accept this patch: this change an
> user-space visible behavior: ...

Okay, I see the issue. How about a 'solution' like this: we use scnprintf() 
instead of snprintf() in two branches that can have the name truncated? From 
what I see, the only difference between snprintf() and scnprintf() is the 
return value so there should be no functional change visible to the user. I 
tested the W=1 build, the warning is gone if scnprintf() is used.


