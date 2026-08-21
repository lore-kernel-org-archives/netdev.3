Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2FA32E696
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 02:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787278001; cv=pass; b=T9qVkn1KN4siNuZeGsPS/hmG3k9uQxvqFa+dseVZdjCIZiLWGjTArkIG0XumCAhrHSiAIVDwOY1EI4ZYHZXnX6RFPdzLJ3YfGmcjqe9YZqSQZoX4JUKyc71ITh8/w9L7cC9H/VHk0Wzs4f7BXn+LIzor4jTvJEDq6SLzyicTQpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787278001; c=relaxed/simple;
	bh=LDGs7iHuvWx16GAbGUBVr9LGT5oNTmjXUgYrOb8exzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GKsEG/RFqYPwIxJg8NpNRUzH6GkmOGGjquZIuAYZC9TXv/g0mMgKEQ+o45MA3cdThThF3CYfCatH2V2wOLGsmnfcd3nuLQMqoRxzJ+0kGx5zHO7QnqX2rKWntlHfBic64j2b9/NUs3jW+K3qwMitZ7akeF1xf6g4b8nk++6+mpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jey4xw/M; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jey4xw/M"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ccf2360620so4247895ad.3
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 19:06:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787277999; cv=none;
        d=google.com; s=arc-20260327;
        b=gEXmyQxb9zFEIgcjt2w63ITVvfqOZxwW+Lwf20raveU21OcbE1+V2RD6hU9YVrLUr9
         Wazq23TFNuJU/kQRkKLsahhkidn156TGrvoZYibLXwtCMs0azMSqpTsKPlqrwUsog0ya
         q1Sxt56TmLTK8gHAtz3XiycA5Gseqa6MMqkWxnHcMYiUHjnBQa758NQkUWkAgvaOeo3B
         hhYr3kk+XQVrExVi8omatRsFbLBcmsp+sCiG0703Hb1xf4Go3J/WHeDbh3nJPbaQwz/A
         LaGqwiPW6nV4A7fBPbN9135j+qWVFPjmaGmkci/mBYdv02XlelFZ4GOy33UOifniMipu
         TkeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LDGs7iHuvWx16GAbGUBVr9LGT5oNTmjXUgYrOb8exzU=;
        fh=9RSmP1LbwCHQE6B7fUBg3w2otgsa1O/ac7MEvx93ack=;
        b=kHu+yRICojoR8CxLB+UFeb6pK+BZmhrJ/0SUhe2y2z/OXqPprpYPcyq6SDNxUdQ/Gt
         qWapyqXj+5HdE1AAWQZCgNXhhx54ACTcNiSbF2HfHwkpeuumSZmHxu/PE60peV34TLWZ
         e/pXKFbsA3CFrvRvAw4n68D31iX0xKv03wS0k8zoqJZAdmAnBPnqYb1FoMvkEduE/WB1
         5JBWIWFtkeGUt/vtE6ohaPxza/7lsfB/e5hm1dfMSUhLzu7aB8ms1i2Yam1TfQFy8tVY
         0zPLIK61Nvx6Virns0o2Aqicx0wKbi/dLdws1vLtjrcjQlxlEcEp+sqDEa96X805OYNP
         u2Mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787277999; x=1787882799; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LDGs7iHuvWx16GAbGUBVr9LGT5oNTmjXUgYrOb8exzU=;
        b=jey4xw/MP89kQIeYDZewh9e61kfA/mtOVvKQC3vPrIp7XG1aVAYhlkIq6OB3IDbpwC
         YNxOX3GQdVXcVzubI5pTgyUkLnXpa24b9Y5dGo7nOY6IjhjtXCSfVC4a2gxoH9SFAph0
         ariE+ZTBMtvxdoMc99GRfTq2rYRP6ZN+1XOl+EBgsoWxo1arxH1QYiOL0zq/9oSMUcEG
         T8BXfRLp9uEiCERdS2sylC/xIbP+5Us3W/ObaKq0wSnh+TCKLTjMrZSUpod23LC2+I0w
         y5Eb3mS/rTYOhGhBGDDURPeceIApEmTuqoealebjFNnZeMI8+0gIKRZJHXPH4Dx/rGxU
         jk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787277999; x=1787882799;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LDGs7iHuvWx16GAbGUBVr9LGT5oNTmjXUgYrOb8exzU=;
        b=FX0yFRlGjpuctTGppFAQisvX8paQ+XVjsdWvAhc2HH3n+nAzBdxnUo4+Qua7zocXQH
         jYG9UzA7FhjuiAXIkQwEflmuTDImSNCpHsnyjlIiyrqp6gyIuG69wvfXxAM44RLnNX6V
         Lu6FIWXooZnY6wdeAKBPW0hhVbe5wiEVjnCHjGJwEKmzOgpB789hjwGpEx8iZIwtGYdT
         r9R4npGY58ng9V717GBB6Trq9Yq293UDPDBjYQgWBtjZHFv45yI5J6dBy4/vSYU0w9+5
         n1usJzLfifaisPPtj1Xiql0J662agje7BJdbEYWBeN3/4FuTnea6FeYSsegMD6gdLH7R
         nhVg==
X-Forwarded-Encrypted: i=1; AHgh+RpMLZLMVWdhc6i03VOYVgRZTX5SR7D6NO9+B98V7vvtOL0haPjeq43h4CdxyxCj2GPKmRtqM+s=@vger.kernel.org
X-Gm-Message-State: AFuF++n13DP4SwXT0X0Rq4XGGUzUEsAC5GB0E4ssLtqDKAKjtb6elY2Z
	sSlegByl8kcUKe9D3BF4nbN/9Wo4DV6rMV1wMZrMDpOCEU93x3/BYTy4J+ZJWmoN1PBfumLpd5J
	TxMpERaEBSWGXgN/wflbYolItL4obCag=
X-Gm-Gg: AR+sD13UFeRTmVRBe2NETJfJWun4rc6akVaV3zizWaHfjV9Q7VKOCrG/cuOEDe75XQA
	ISlb2991xWoG/1L1odUyFDA4LRNKeX+w3rEWQmxLhFinO0FwqdSifcEq5tSqvGHWiPYsGTh0Kil
	pqRf5y3W2sx6GhntFlF/R0z/oXVCNrZy7+Kq/sPShtlxQGNU4CfXlzFQTLMOr3FM1AIb5Pv9h7T
	et82SSa4BH7r/ORZRBV4UdugR2i/BwA8kt7c17fFPkYInb5olTpwjw/o5Te9mpKedR5/SCqDX22
	bxnXa1jDGBt0ntet986ZH++2VQI+7/a2KJVSnZYYgQPbv53tQDmq+lPmnbgXqKt4xe+HRgCNUu0
	NxYqlqwnN+WyOAF1E2cSYqPgssnFV0jmd2MYIBCMwZ7q2zG1LLGBso58GIJm4GwLOUJ8=
X-Received: by 2002:a17:903:354b:b0:2ca:f21a:a6c5 with SMTP id
 d9443c01a7336-2d64ada70cemr56183285ad.1.1787277999331; Thu, 20 Aug 2026
 19:06:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820111456.97947-1-phucduc.bui@gmail.com> <a618bdba-c370-4f16-ac09-0f7ceb742d42@redhat.com>
In-Reply-To: <a618bdba-c370-4f16-ac09-0f7ceb742d42@redhat.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Fri, 21 Aug 2026 09:06:27 +0700
X-Gm-Features: AcwNN1WvdLHJsQSoNHIIcYaNRkxxiGKCfaxmYG2z7kaRiXSm_SzVyXh_3D7dOT0
Message-ID: <CAABR9nHVk+D1uV18-Fz-+Fd4tdAi1n2+-4e5091e0X3C96cw9A@mail.gmail.com>
Subject: Re: [PATCH 0/4] net: broadcom: Improve IRQ error handling
To: Paolo Abeni <pabeni@redhat.com>
Cc: Justin Chen <justin.chen@broadcom.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Doug Berger <opendmb@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Paolo,

> ## Form letter - net-next-closed
>
> We have already submitted our pull request with net-next material for v7.3,
> and therefore net-next is closed for new drivers, features, code refactoring
> and optimizations. We are currently accepting bug fixes only.
>
> Please repost when net-next reopens after Aug 31st.
>
> RFC patches sent for review only are obviously welcome at any time.
>
> See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
>

Thanks for clarifying this.
I wasn't aware of this process and only knew that patches could be
sent for review.
I may send the patches as RFCs for now, in line with the guidelines.

Best regards,
Phuc
