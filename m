Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4279178C9C
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 20:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789505066; cv=none; b=CyxhcwjYVvVujsrVqPP37oZptlslWIgYNyBc0BHhlR98HXFtuKLj5vKDQkJp+YWGdJw2Zdan6J8f28MO7/4Z/pcjjM0XOmJn0SBJKBD2jGROByYADiNCMrTbVFcakQH7kMool1XwCEy9UBVqKQd0UgPOQFohIbr+HETsqNP+jWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789505066; c=relaxed/simple;
	bh=f50iAKNvxmaK1/KDn1I4sj9qO1XnFJppLd1f0SUOlzk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D2oYvXKmA67PF9uDjOQSOkBB2DQv69/EA4A4ib6itKNUYrl0FfJMrRNJRpeeAMlW3eHkdyTSZi0lUPFzVUuyG1hYcnZaQW34zcL+uvIIgIuTuXr3BIAzjAJYn+HF6OjszSiHhBYkvOHrLsYgIdS1MJPfekNYwedXPNX8JmClK+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=xFQCajrS; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="xFQCajrS"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469d249c5so118721b3a.3
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 13:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789505064; x=1790109864; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LalPA7C7C22kRZ/gAGitbKFO3VdtM3EeEmJYMYM4mFg=;
        b=xFQCajrSSxSgGz3NOB/TutKqdC0kmeNnHVOTZDu+WUzmG9yymlXr24ZZcB6QUGR7HQ
         viyZCe4WwbtWw96JBNHRLeCfWSb8eqza1ar0glgLhRhyLIIy+qjcYyYTDFwJ7/fh7wnG
         5L5QfoLjZP8s6354hTN5XiFB5smgPRneJPFuuPHgZczbylj9O/5VGLJ83+J1VxPXADKf
         /I1eiuxzVUx/cpiDf9Wx5vV6wBe5U7qasvs/BI5P/U833sVuh58f3CqJyLoe1Wx4zuzz
         zy717JpYJMtQJESVUfZtsPQW7I4/ASeEUkeJaQYC5vFfKxsU+HRx7HYBYDpcGgGgpTSv
         52tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789505064; x=1790109864;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LalPA7C7C22kRZ/gAGitbKFO3VdtM3EeEmJYMYM4mFg=;
        b=EgjeVKUABjZnO2FAPpb3w6oVdUXUaiNU8Bir5dVX0jTzTmfCocjcPPN9ynT5ZwPk3P
         b698Ahx0P2jKjm9d9RsaQjSZcnrmG1uzMFqoPjgpmUZ8STdi6nAdilwqPUh+4jc5Xyte
         5SzaTUXjaMz1ZdusD2Yym+G/7WcIwA7AMh2l3MAR4fbOeBmIKQAvn6PLCztaOOQzN/Em
         jPH7BHREKo2Wi/4qG42Ftuv2SQJVMjIZYvtH5ukg49oumyf3HNafQux5eMNDKuP2bL1C
         wzFE99rntZhuQknn8+HM5m2sW05XmLiVFPQbKa+4STC5H57Z8s9EWwtDredUuu1PfCvN
         EB2Q==
X-Gm-Message-State: AFuF++nAYKkYnFKVpuecA2+L5tfYpxg7fC11kBXf8J8nGpRl3UVUgjyc
	ht2kK8kHSxeA0JHDoQ5ARUmJwwT1K/7efAZGaYIMCZLKVX4IOViPRmrrQmLShPTbHeM=
X-Gm-Gg: AYBFou3oPahPWa2E1YGeFc/sNrG5ey/uj6+pw5vflbaY6D3yb1OvBnSq8JyZl7hOPyO
	mPqRlno6je5FyO1uxm5T5C4RqrzHAjZgmLmclgGBpYX9IXU4Kv/cJOHHzbaIiPSEvHaj29b/0j1
	x7BDnX4kMU8m3FFjgw8tFkRWeeOt6PT2wLTpnFbo1Vl4avrybmw7+rYSMC7eTY5pqp807qXiETI
	FFuh/K7D3g/+xr1ftk1hhd5LAq5S734R7OlbSvk1ZCrHWqwmthgodH9vV2gXxhuClzsmpahud/T
	J4KsprkhQlWobqUTj3T0AOixaEJ6rbqiXdNPCXXvQcqFx5sWPEsnLDuXuDKh8sTuRqcQySa/TXw
	sqgcyJkC3ni9bFfkcHs40OrAd65EP5aPPTJuXwQuZHrShR+PciEPy0OmiBx5crJ6Fy8263/fVG5
	mfVBmVVAcK/j8wet0p3crW3ocKYlKa2TSwrVOasRFpfoIeJwrAAZA58mjWl02ZWgAsps7CmWfdr
	tBWYcUJV9SNF5IGv//VcsCw6ycubufZxpIRmfNC
X-Received: by 2002:a05:6a00:22d4:b0:85b:635e:7814 with SMTP id d2e1a72fcca58-86f84d108f0mr15501581b3a.12.1789505064496;
        Tue, 15 Sep 2026 13:44:24 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87200c581fcsm147300b3a.12.2026.09.15.13.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 13:44:24 -0700 (PDT)
Date: Tue, 15 Sep 2026 13:44:17 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Harshith Hari <harshithhari000111@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2] ss: add -P/--process-age option to display
 process runtime
Message-ID: <20260915134417.69b87049@phoenix.local>
In-Reply-To: <20260915183522.63865-1-harshithhari000111@gmail.com>
References: <20260915183522.63865-1-harshithhari000111@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 00:05:22 +0530
Harshith Hari <harshithhari000111@gmail.com> wrote:

> Add a new option (-P/--process-age) to display process uptime/age
> alongside process info inside socket user context output.
> 
> Signed-off-by: Harshith Hari <harshithhari000111@gmail.com>
> ---

Your mailing method is mangling whitespace and the patch will not apply cleanly
to the current iproute2 tree. Suggest fixing your settings and use git send-email.
