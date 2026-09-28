Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566BF4F3929
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 17:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790615345; cv=none; b=NuMkQoILOnTcgwT6cw8LEyBGh4Yk2ZStczerf/wm9kyjv8OPDq1JGQ/L17hhe3J3F4kHkqWz3pbYJi8ePcfmkKWfTzSshJrLh4jd3ikC7NM5OJk6C5iwNU4+Ii3NkqnB7MSG+siequ+4fc2mjqSvxouyy5672rwbalRsy9PLrb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790615345; c=relaxed/simple;
	bh=FOfyznfJ2I/vomdjPJ2GT3QatQvztwc9D//G3n37QkI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=LF0awJd55+aqIh66LaJF+xebH4qh6XNVPFmuHPI61EDDZfebxld12RqQuYHQdZYzOfmQUt0/41VQ2r6fWyqEsk6G2qTE/NzlEhxsaqZzmRhv+2eLwv1077VEAK+9q42XNL5IbGH7ZEENdAg2vcEvK+Yyj4kHI/T56sI0LjCmcCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRlhqQiC; arc=none smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRlhqQiC"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-86382f10801so15655977b3.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 10:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790615342; x=1791220142; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=M3NKplF+PpVk9qApo2SlPFNSD/uutcAtE+AxjuZEnTM=;
        b=lRlhqQiC0cRbMKx3Q0niG83ORUBaYcm9AbcjgBgvj1wWi9bowjEWhlHNw1zYVQIveq
         qg4oWP+OL55Sz1UPlMJl9NCCW8bMsufKhYqiKE0I425WtX5/1cGfMwqAirnVnNmlWaup
         MftFFlbi82ktHJyvh3WDCXEDi6CgikAk7xAtR9y8LqI+lyk21IP5wQ7T6GaNwDnLLYls
         RW546soDQc0j13PtQ5ZgkqlzbQIW8QkAdygFqaBlHbN5gD1uG9xLCAtNhFKefeZ6O1X0
         FOvunW9MmaI+kguYoHylm/bwx5qJXcIj0A2pJhklVzcnuu23EiTJCNaqBRa0uCLghcTe
         VMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790615342; x=1791220142;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M3NKplF+PpVk9qApo2SlPFNSD/uutcAtE+AxjuZEnTM=;
        b=W0KTeVvWL4Wej2oIS7GYC1K5ZUddOjeER+9rRzKTR5UPBArIEmcU/7EVlKINL3xZ4q
         QrKaHOygcNt2FOI6xO0PQ2R5Fr/DSU4XPlkVqNWD/ZGMrqtra0QE8thWeiX6uvCrH65+
         ZE7ETVC8erwrz9pjZLpzy3VvFkW50OnrF9LlJqMPGoBAhpZZystvffA2aiOBp+fX7NoI
         E/HSmf55JvYVNDD4zN0RbJHm++sYbCJnrvbQtO0tO6rIGVbg09+uaiImN0339nQe15HK
         NFw3OYL78fThCZ9OdkbvxQzYzNQyUshPCXuaFm6PbbCpSQ4OMIJxq7dDRQzIxjyAgsXe
         170A==
X-Gm-Message-State: AFq9FYK3EamkveZKirp53Rk1eDY5AQniuklXlb77i2enWbAhxxWcu4aE
	cUc8p9BxaYuBe1JGteqx71g5RU8fHWxpGbYItO0J03ozDU4Rchrv67DGYJf89w==
X-Gm-Gg: AYBFou2YD2UpHA7/j+rVpiIlgMdaVCBj4ok+MR3igJT7sWUjaaRymX8EggzTZICGzD4
	U8++B4ukh/si+xsJrM85eSk7O38jIdWDiySRTK1+JN34Nw9/pC9hebtGYY6fpOK4a9acrSHMx0j
	vlznHxCZxduSXqidzzOLqaUimYBrRjG+Rv1SWRuy2b/ZbvVHKJYC2xW/npITjD7fLTBoyCaFbhn
	p/uI8EyAhkJZ1nyRl6a+PflWhJuytTQidmG5Y0kfknurwyTAlwdGL4thRIOFztndNdRweezVlwO
	yzJigLMPuBpkZVVK+mGRggx1x4+k1NyjYbUky42mV6pS3fMlGZgig55/NJo2pD7ifxYodBX/hGX
	isO4G4+a+e8o24Rf3jjF6VHLlTSmV2XYXYOSGBiRs+95IDnwEXO9FGGYkI3QOL5N4kngSsvBdqj
	fSHB6djqss+sWf7V+Ci7fBOEsbHUUSGc1ugLAyw7KAQQf1Z+ZDjcqtIIgOhLsgx/zaCPM2v/gy3
	I99Yzdlo6jw/W6WgsdbZ2V2W4CIuXQf+ycDbJ1fZVVr/MGuPpY3+KIzV3KMi70=
X-Received: by 2002:a05:690c:85:b0:8ab:36db:e30e with SMTP id 00721157ae682-8ab3ca8b28bmr321877b3.18.1790615327211;
        Mon, 28 Sep 2026 10:08:47 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a86100b564sm47786087b3.36.2026.09.28.10.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:08:46 -0700 (PDT)
Date: Mon, 28 Sep 2026 13:08:46 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, 
 horms@kernel.org, 
 pabeni@redhat.com, 
 edumazet@google.com, 
 davem@davemloft.net
Message-ID: <willemdebruijn.kernel.736256d759b9@gmail.com>
In-Reply-To: <5d1557c8-6e0b-42cb-9132-b150f211444a@suse.de>
References: <20260910144914.8025-1-fmancera@suse.de>
 <20260914172459.04db43b2@kernel.org>
 <5d1557c8-6e0b-42cb-9132-b150f211444a@suse.de>
Subject: Re: [PATCH 00/13 net-next] Allow compiling an IPv6-only kernel
 network stack
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Fernando Fernandez Mancera wrote:
> On 9/15/26 2:24 AM, Jakub Kicinski wrote:
> > On Thu, 10 Sep 2026 16:48:25 +0200 Fernando Fernandez Mancera wrote:
> >> The primary goal of this patch series is to enable the compilation of an
> >> IPv6-only kernel by decoupling the core networking infrastructure from the IPv4
> >> protocol.
> > 
> > Could you useful to know for example how many of the recent CVEs were
> > IPv4 specific, if you have enough token budget to get such data?
> > 
> 
> Hi Jakub I will include the numbers in the v2 cover letter but in essence:
> 
> 0.3% (32) of the released CVEs since 2025. FWIW, this only includes 
> strictly IPv4-only code. The percentage is also stable over time if we 
> extend the search up to 2020, 0.3% (57) of the released CVEs.
> 
> > High level, I don't have must to say beyond what you already know -
> > the code movement may be too painful for backports. There are too
> > many ifdefs (as Stan pointed out).
> > 
> 
> Yes, the code movement is the biggest pain. Regarding the ifdefs, they 
> are being reduced greatly in the v2 as I have decided to rely on DCE 
> (Dead Code Elimination) to avoid using them. The code looks much better 
> this way.

On code movement: are the large code block movements into separate ipv4
files needed, or could those just as well stay in place, behind an if
enabled check?

