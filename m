Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4822A40E8D6
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823589; cv=pass; b=LOdZpvGjKjI/U+slUGeCwaylpl4WUcKgodo8EORT4WT/PVnV03tiGQUlogQOpMD2ldWn1QAoXB7P53AO3Dels3O5G66KNYkcd3HzKXs9QUmbVN79JbAkcmuE2hcyyctJf1C3OXOJDniUB+iQMymtxSOv7xq0E1ygxK3c/DitxMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823589; c=relaxed/simple;
	bh=wh+IO83KQv+PW9qYrhitQ6PvmR93iwz2rI91a2YZLhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zt0ZAULxCYd3ueMKweIwFcjkbzcHMO9Nn+GD0OeZWSb1H1VWyYlYOpI9TzW0E5vUFbNjrE6AcEnvSBu7f3Wz8KLsM2+AjQSBhEvraS1H3Qp/NG4eZEpQSNq5oAGDivoOSUfdSzVMqX0SOI+sDP/po4yvgnVWEhOsIpwK9Fn/H+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=boYSunRG; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boYSunRG"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c08acccf4a4so618804066b.3
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 05:46:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782823587; cv=none;
        d=google.com; s=arc-20260327;
        b=ksGZ23Etq3EbsUrNSEIs7681ZCo+UeNEfmR07z3wkous7V7Es+4UOeDv8LssEGvj4n
         fkOlXuQYmGGgZWZGkcm+1TsPtYhMZtubFFTDtpK5XNM7v2m69h9CJlwBZVEPI2UIBdP/
         ShrA0F0SRryoXzZng7iNbHy4px0DEOdIZMsI2XpcptaM5Nacvj2x4v0cNZflvAZid0nb
         hO3WKyx7FIaaA9tajpRkwG25l55bEOjxb7j/PLry9Aj2C8uBJh9M5f2eSKCvQ70tMI6p
         FWaemTN4dfcGMXLp3vJGeyWPL2gzpkRkmPQ7xJaSmMzNiEneKIiPMslNHir9Oy0Fc2MG
         rHfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wh+IO83KQv+PW9qYrhitQ6PvmR93iwz2rI91a2YZLhM=;
        fh=Ui1noCTQU7rJSTLMNlCLQf3YgNxrS/BQWHRvWjvyxVA=;
        b=AQ5RsvK+gihLVEa6REQj3IdWG9OtLoEUEvylzWZ3+tlvQmk9yVG9t0X3w1OslD/OOJ
         nk18ROaCjDBvg3huAHpnP/kuk1M6bVTQt1p5l5cWefdXns5LxsIMUJOl4XpdsNj3kv9K
         VGwNfBfbMQ55zEQpbznqzsmI3KlD7vW8SyE64HcOcRhlm0FNxBNUxjBvfeL91eE9Wt6S
         FD7vtN4YvuqB++lV8eVqCCJLNsJ6CHZp5POVRwvkMgCfaJ2VYFJ1l8sCDVhQz6aDgBwm
         Uh6+68+mlXX62WnGBGy+p/7nYf3Bg7znj0HHe43KSxuguvODIlQN+2pybFET8FrQLIaf
         EqzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782823587; x=1783428387; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wh+IO83KQv+PW9qYrhitQ6PvmR93iwz2rI91a2YZLhM=;
        b=boYSunRGPo7CwEeA2Z0NIVk4hP7utv7eg7TTpbAWlcUohi5w9BmqqUu/SrlhkhvcZ4
         teEUNreOIrtzjWGBZDkprmMcqthY3KtSBkx9925gKSVzQxaJym7sQLIM7/Ik36VnsEmg
         kNPJAlq+1AAFsX0Qz+TZ82ggvaWNOfvwnYj5jz2c/gZEub5BvVXyilpi+xYMufvcAdza
         iKH08j02gBfa7anrTpxvZH5dwY6CFO66qOXDMyUUO8wx7tYcaaQR6XTfX1k/hcWdvBRR
         kwMDH2rEcylTdYsmixsJPw9sbBjdejghJ5riO9zADRSCJxOmTGdneFju1V4vzhEyaKR4
         Mo9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782823587; x=1783428387;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wh+IO83KQv+PW9qYrhitQ6PvmR93iwz2rI91a2YZLhM=;
        b=O6BmcoWjs//0B44TrdqgjRJSn2VO8rpkAGPMgNVn8Pj5zC0rTiEt3Ju60wVU6NiTUT
         BKS9byVUL+zybr7yQO+AE2x9nOzx49OALoO6gGDaeEDx8Z/1pagsdsjDishscogSS/6W
         eBRXNd4GR3hby8rXtBZGV3COnc9HbW621ws6ebguVus015VWQhbXy8AkXDXKEe+ABFHU
         JoDxU/yVle70JKaReIHcDyB9d8j4wT30Bg9ZK4PdX+Rg6SDCildpQyKx4QJQXHARuPhV
         fuzPfmPo437QNt4fzXbok5vcGRiSNWbZ9WpzDL16ER4/I138lL3Rr05XLsTmZgXsEAqQ
         HF/A==
X-Forwarded-Encrypted: i=1; AHgh+RpVx0M9xvg5FhJXjkvHxdSsrCu+BiU8GY0pf9s2XjoYOPUK0ncCvQM6zbpTmy7daeQwL2ZD99c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJDDOtgRtBtszEMfmcI54aRFlaWbz3om6Z3YBFqMUWtgNr9Zck
	a9TCM1aLnS8M3Z+oftdgjxJIwya+xi2Ke6GAnDVEaImMNm/04IZgWd8YGKeim+ADCARu1EB9y82
	aUNaFNy2GRWGouheeriiCC0YSa+ATDB4=
X-Gm-Gg: AfdE7clSUWGYs2V2zuRbOVXHcxLCwugOTkhohZJ8YjBPKGoHqzJVuR6k0fHvYdWm1p+
	zUxwME5q2gLfLKgUf/d4i1la1CRDEdH8sQ/tBEkaAwOcr9zqzMKbT0O6WpNcF6lwPT99b5429ne
	3QxHo/TgrI9PKc3TdQVGlvEE6pW8zCGw4GTKB6tKlPnXOxbDhDrI8nQCsZTHPlicxtwzbA2K1GZ
	3MdgwSVuncTcR/dnOikPAburdVChWsbO4Icp9inR8t1bhnjrZWqaLrk+Ze70hJjRJ3p/ru1Ow==
X-Received: by 2002:a17:906:fe43:b0:c12:34ed:da11 with SMTP id
 a640c23a62f3a-c12873872afmr146790966b.61.1782823586478; Tue, 30 Jun 2026
 05:46:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618125848.93550-1-running910@gmail.com> <akNRQFx9fmi2DK0w@strlen.de>
In-Reply-To: <akNRQFx9fmi2DK0w@strlen.de>
From: Zhixing Chen <running910@gmail.com>
Date: Tue, 30 Jun 2026 20:46:14 +0800
X-Gm-Features: AVVi8Cc6zr8eey41iEMKq_9uJ6bV9rfcrW_UKBAjGWWLZP7XvRwERlL2YGq_QB8
Message-ID: <CAMyuFdW+LR8YczR70gaoz-R0hAkxm8w0pvn_vf9S_9yM7B+8BQ@mail.gmail.com>
Subject: Re: [PATCH nf] netfilter: ip6t_ah: validate AH header length
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> We should not return false in matches for malformed packets without
> also setting ->hotdrop = true.

Thanks a lot for taking a careful look, I really appreciate it.

I agree. Returning false makes the packet a rule mismatch, while this
condition means the packet is malformed. I will send a v2 that sets
->hotdrop before returning false in ah, and applies the same
malformed-header handling to hbh and rt as well.
