Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBD447604E
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 22:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788300933; cv=none; b=eYxhen4BDIfJI4QtHK57PtqAmVuZJxP4Kmbqqu/kv0CI0YjRbURt3er1zDKoQJauADSZzusCwJoQFhf8a01jwoX1olCIkGTwZ/ELKqg911l6RrMUBlsuWloRzWLxbqNCr3Evzl1bhJCratnLcf3qZ0fR5dC6JjHuKWWqZ0U9fdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788300933; c=relaxed/simple;
	bh=s+AEJXNthTet5crClQU/YZAxQNUtZxQ4lks28CixbDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbtk7rNJThrkl4qtLZz0V4j9nSZlJEyiwLOquJdEPHCD2TEGzPVm8QUAVAG92t/PD263khtlot6vjeDhydg1dSrt2ndn0V+aOHQLUG+BwvOBAvVeEm6z4DQQkFmXbaMDpd0nlaldZd37ENi4A12wOkBNauQi55NNNuuugPaN7FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=PI1YrEqC; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="PI1YrEqC"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc1cf287ef8so386234a12.3
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 15:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1788300925; x=1788905725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y59gjfWF0Gtrpmai7ev8pjcC/UXVsu5BYu5GqNSxgDw=;
        b=PI1YrEqCEaWIfkgl8AnCBWl9CKmp1Nep4GTUsiUAwtluPB3c8cuyJzMjBmqn9XJb1D
         R8FZv/4ibJ3bDBz1h4tc8IRtNwUYZSWEozP6/cogcLlzrpYWSMNA0bcnVp/Li/Ytzls7
         6VcMyohfc+5TAho+9JjjOqOKiZfJrlhcXQVkWxSC3Yh8v5rnbgp9W/oBv7HAfulle+zS
         mVrj4dAk5zSHFJYbi7S/JCDF+W01MFIfi0GVc7rA3oTPGhecsnPNvfFp413gz7SNiIfC
         DtVKS3CJzdmMGNE/MP81IPNFIFzaLiAa8aFNSQGaZ/uQhDnsZ97lbRilW7f6LJbtu1vQ
         ZAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788300925; x=1788905725;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=y59gjfWF0Gtrpmai7ev8pjcC/UXVsu5BYu5GqNSxgDw=;
        b=DOUJUcPL2ZJs5D7sSDSvGpPGBduThGVijNRmctHf/IKqJUNPQY/KBOpywN+9fIxLuT
         D15TXa8pHP2kP79IZ0kHXQvQemgLI3+tpK6p7dW4oSlU5KF17edrd6dWcNLi+YcUALMH
         NFekZDa45UX42I6T5AH4PQHRo5e4TIJ7HTtMHN2aXUjmC56FLSLKa07RuS5E+pXWdBRN
         BuPIPsf6KfUaOOW+uF7QLolirHE9XNnc0iwMSEsZCNEO2gQvkAiH21IvPNUY9lqIWMXJ
         zO4PrMZrzFHveaHyroDlPfkuEbFwxA+6mU9Fx81NsnK5WRHH9bKAy34my5qHDb6gibri
         ySlw==
X-Forwarded-Encrypted: i=1; AKwUvBz2w5fyaMPXK/9vi3/hrbl8sKJ5V7uvfdDQM0gYfM76RYY9tbAApP4sPDjU4aqLtT6TOgnpSAk=@vger.kernel.org
X-Gm-Message-State: AFuF++nUnn0r4UZICVtJEI0m1T5/CdtqEALwp5RKsE5LASFBS+L/HzyU
	zZJkXqg6RUEdjTVZpRTpafd22D63m/W0JFuWqaK3UlYbV8iCmwBZwllWsG0qW2jiZiw=
X-Gm-Gg: AYBFou3876+8cvr/M6MfpEcW9xZ2qA+azLnF10VnHzQtj12lzmWzhzbxfyFCDCi5SPV
	UNj/eHGld2208xxTeI43uht8G3/9dq09soz2TBzyrvekV51zXa6PEPvz2msXuDiMzCrOctVo1lt
	UbsGY6m4MUkVXIzVGALK8+CeJ/agTV8DdCu5US1Rtxxjf5J4o73/wXAHx1UjMQZJhwO1afS0tCc
	TrwjO9LFdeu5AGnR/nIZOVCSz2blYwuuAA1X6PjUfX+fRHRpp85gVRhBHzqd3C/NxNUbREV0NqL
	68CtravCU3U6NCAekLqyfL2Z/JCVxtfepScWSdnYnP6gxSGDITpXH9KHDrchNvlSjgBOkTYaLzD
	UhEkIj1mu/8ql2LlfHRByefrmtJqVl12Clbu2QltE6aU9nQ+i10YMVy4+/a1F3PTddNILevARq9
	nYKoJnHi1IEBe9XraB+mgBnX2jqQ8o1QXZr3Nw9gNazA==
X-Received: by 2002:a17:90a:e7cb:b0:396:65dd:4093 with SMTP id 98e67ed59e1d1-39aee153a7amr99404a91.14.1788300925348;
        Tue, 01 Sep 2026 15:15:25 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4b::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae62bd7acsm252462a91.1.2026.09.01.15.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 15:15:24 -0700 (PDT)
Date: Tue, 1 Sep 2026 15:15:24 -0700
From: Joe Damato <joe@dama.to>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Scott Branden <scott.branden@broadcom.com>
Subject: Re: [PATCH net 4/4] bnxt_en: Re-write the BARs following any type of
 PCIe errors
Message-ID: <apdOfAorHftQpGRJ@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Scott Branden <scott.branden@broadcom.com>
References: <20260831024342.2161156-1-michael.chan@broadcom.com>
 <20260831024342.2161156-5-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831024342.2161156-5-michael.chan@broadcom.com>

On Sun, Aug 30, 2026 at 07:43:42PM -0700, Michael Chan wrote:
> From: Pavan Chebbi <pavan.chebbi@broadcom.com>
> 
> Currently the driver zeroes the BARs only when fatal PCIe errors
> are reported so that pci_restore_state() restores it.  However
> firmware handles both fatal and non-fatal errors the same way when
> it sees the slot reset resulting from the PCI_ERS_RESULT_NEED_RESET
> return code from the driver.  This means that we must re-write the
> BARs post recovery even during non-fatal errors.  Otherwise we will
> see that every MMIO access returns all-ones and the firmware appears
> dead.
> 
> Zero-out the BARs during PCIe error recovery regardless of type of
> PCIe error.
> 
> Fixes: f75d9a0aa967 ("bnxt_en: Re-write PCI BARs after PCI fatal error.")
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>

Reviewed-by: Joe Damato <joe@dama.to>
