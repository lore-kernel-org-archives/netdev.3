Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B11746F498
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 13:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785935697; cv=none; b=Wz1bmzjigNSWsjIbHFhaPDhTa0poWDUkL1ILMKnfuGV1f24AQ+TR1WF9FuINAaEzAWFYQus5psb39JJEpFfuTgdUfT0ImpIxojx5edUOi4RQy+4fABUQldcA1bdsWf80FEcTkwCXUklbi9lPjLc81YeyDIXFOq94NIhsFrB8iSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785935697; c=relaxed/simple;
	bh=ZokoVdp8dvwEP12aZUt+4rB79hewCz7GQRU5XuzFW2Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HE4SrBf/LAt6Qx8SVBdnuMHtO5YHnj9QNQk8s9bwXdsUTYvNP3ZWeHPtgXzAJYEhzWewPMrcUzixRVEyHoQEecx4rBGjmFen8Lk94FnT5S+NcmKqmmKzVukgrqchJLa6Q6gwoVYh9zABaDh2wse4F6evytDit5nfqDOsE88pGFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--thaisonphan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RPEl0CWf; arc=none smtp.client-ip=209.85.217.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--thaisonphan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RPEl0CWf"
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-74583ddca14so173348137.1
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 06:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785935695; x=1786540495; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZokoVdp8dvwEP12aZUt+4rB79hewCz7GQRU5XuzFW2Q=;
        b=RPEl0CWfye40iLr5bWqwuHYYwRLDKcFaAnrEcmpv6O8WJARVD9qdVviXcGRtnmDchN
         wdEvDBhCjoh/LNZknC3f7JRcnjcSLxVbbPitMsb5Y3qfusHrTEoSSXtoIlna9VL0FxHM
         GWJjICrNJSYm6A19peX1fEhoSjtEOHffuG93XesIhzHclRii5YwomYN/YxIZnqmJo9w7
         uOo4Yzr3941EamIGH1/QKD6bBSVDRDf/RprewfXir58z8jzB0cm8zkJefVIRX7QT9VKq
         W0W721/JdsUMzJr1yqiapU691VGcax63DqYrJUClE3bpbJPlIYH/Cw/mv+mLxwCIATE3
         Axxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785935695; x=1786540495;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZokoVdp8dvwEP12aZUt+4rB79hewCz7GQRU5XuzFW2Q=;
        b=idaSJA2y/AvESwMqxZQv4d1Ve8AE3yr4ROJiaVKyYHD++d77Feis9dnoytjnr9fylC
         YD0yAktIDSxEpRraIgQxODp002/Ooi51++147ggwOm1cDwG91xZ5rFn1rOqjOA+pD4zI
         sM82PcjIbgXx4QNdvklFA7nXD204MpLC1R7RQyFJO4af2OOq2OmtwHj+j7hLK379M8wV
         sVMIqOlivF5RKDA6e+O7FVs/HQsHvIIndbV2pW5KJM8cc+hpEwKTzicvXfHAXIUAsjdT
         Gkxlv0R9RCL/R6Wy/FtAYl8gZFdR6V8s5V4n6IXDJ4bph9nuJFCBVBrzdayVAtrpNQEs
         Pd4A==
X-Forwarded-Encrypted: i=1; AHgh+Rq2TL49jA0PHchhHpdXtzrhxQZQdEZoG/aKYD6sowQBOcEB2BlVZj74sXomTcm9KK9kxPr662k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMOLPrhC5b6RYnFhS1foaB9ZLjMROqJtSeyQIHjgww4T2NohkR
	YD2eo+R+Y9enrX0WswKi5TK96GHMZLp3rOxO03LdBxanxwfC6yYOQO35mKkT9I73/FowZ6xXSAS
	rrR5dJe9byVuPNgW5xLNIyqD9Sw==
X-Received: from uat5.prod.google.com ([2002:a05:6130:80c5:b0:977:3247:5473])
 (user=thaisonphan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:2c01:b0:631:23fa:38d7 with SMTP id ada2fe7eead31-760ed28ccf5mr1502921137.14.1785935694856;
 Wed, 05 Aug 2026 06:14:54 -0700 (PDT)
Date: Wed,  5 Aug 2026 13:14:54 +0000
In-Reply-To: <20260804142553.6a67fff0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804142553.6a67fff0@kernel.org>
X-Mailer: git-send-email 2.55.0.629.g250fe7f194-goog
Message-ID: <20260805131454.3364094-1-thaisonphan@google.com>
Subject: Re: [PATCH net-next 1/2] tools: ynl: check for null ptr on dump free
From: Thaison Phan <thaisonphan@google.com>
To: kuba@kernel.org
Cc: ast@fiberby.net, davem@davemloft.net, donald.hunter@gmail.com, 
	edumazet@google.com, gfengyuan@google.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org, matttbe@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, stani@google.com, thaisonphan@google.com
Content-Type: text/plain; charset="UTF-8"

Thanks for looking through this.

> What's the tool?

Sashiko (LLM) reported the issue. The path it reported was based on code
output by print_dump() where since the dump state is zero initialized
struct ynl_dump_state yds = {}, yds.first would be NULL. It then pointed
out that in the call to ynl_exec_dump() that there could be a failure in
ynl_msg_end() or send() that would result in `yds.first` staying as NULL,
and the code going to the free_list label where the dump list free would
get passed NULL. I may be misunderstanding the code, but it seemed
legitimate.

> I guess we can do this but I'd factor it out to a separate check at the
> start of the function. Otherwise it reads as if there could be a NULL on
> the list itself.

Factoring out the NULL to be a separate check makes more sense to me and
better shows the intent of the check. I'll update that in v2.

Thanks,
Thaison
