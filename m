Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB2C3A4508
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 22:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788300575; cv=none; b=KB4O8nzH1h/uPm9Nstgi4eT0sRN2nm1Wn+7aA7EXkNscAlXuEiDpV4MvtWvd6L5KN+D2qEs2BGNO4dR0MVnVKNFMg0p8kuHeAlFXML8dQLoGqBNqGxhY4ZVyYAyRM8hMEj/C9RbWbfgIgVMIUV6Lp5RQnlnVvAN7lktTYzWLtyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788300575; c=relaxed/simple;
	bh=c0RoRvOyXoGlMeyjHxpVX5G3m95wLcC4hwXm5d4DCwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnTfr9FvJm87Q5sFYDtDpHzyuVF1UcedaSCczi8H5dCDsE9vW7FI7ynC+VSs4PO6o6uAzJh8GjFPUR0cZf/Opp9Jb1GKc4Ljv+HZCAIfRTdgUY7fZ1w6FiPpS+r5yuAQkuDuBq+lmbRzjmE8VVBMc5HcH2nf2Q/yIZ+Z+isBv+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=bxh/zt8A; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="bxh/zt8A"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d53197d8b5so2901695ad.3
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 15:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1788300573; x=1788905373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7avKWLpQVpmeu58t4HDpchLQhCx3sNlG+NpEC3zTEJI=;
        b=bxh/zt8ANXr849B5HT+JHUmd9GWGPFQh3eUvp/8dBkexCdRZhb1+C5GXksV5l5VAKz
         ZGk8E1LbcWnY9V5XLx7WjLB4ovOLJ+kgzlL8HyhuqTfuqnZgEwHOj5IjVi9Q7elQKS1i
         4+uwLLSBL8MeU6fA8OQ2cYrGMeJSQ8bpcJZ5GQsGYRDMtIojkn6NfNzRRyfNJmpI86Pi
         BLmN1hMmqZd1RkmCXwZCcJDKlhOJjC00A5MIKTBdBXrHUy1tYGzwj7dLc8C3Yeh2fD7p
         ef8h39E3xvVfELNiR3wdP5ChWtlVV20YGEdWWX2z1L2vEHxFNNAaXJTkp3B1KqlhlX6M
         UenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788300573; x=1788905373;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7avKWLpQVpmeu58t4HDpchLQhCx3sNlG+NpEC3zTEJI=;
        b=kQR1kHZNEyQoLuc8UGQhCFFYtflVyFihP+vt23YFIKxMyGL0QtztYX5gnxSsBrpUgl
         SXR5N0nsLEoWdFEmj9BB7zevtKZKw190ya1tX3rXuTP4/0s+s4aIij57SiMYog/yA6Cq
         n8bjBslVSf41YKo9dteFHPHyyMpq1l8ouOsvI+8LpjGNINMt+cT1WmrRLJ33JN9yiAlQ
         x5g35Uie3n34YN1Ik5Y5CsyfU+9+TIQRd++x2gXFwQ3EOfx1WUIis0mpSuL4VciXAXvD
         /cbCYzmcPYcGVendQ1vY+hp2qTw66l024UCUwI58d/jGZ+ke5Bi0vFZ0CkZpeMWrJEtt
         0onw==
X-Forwarded-Encrypted: i=1; AKwUvBxu12aTJbHD4K1Vfom8w6sG4mmzLMiVK1yEqQFEfOEeuIS4FpF6SQJxIkm3wkW81Z0LKUSGgiQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lv5NFqX17ViRmW9ciYGMovEWgpPlbnclECv6ePodVLgHJ/k7W7
	lAzchXPgLRXVWxzVba5o16Ze1KNdI11FLece6fjig6GrSCtdlG3a5+UvReMlfptH6L4=
X-Gm-Gg: AYBFou29KPxcy1F2uNR4rpbvQjlCjBIetf9K+VipKmwilGAKbsPxhy1KL+IPsXGCxYn
	i/O+enENPItUMdHgYNwp80LmKxE1YbnO8Ne0MGn5lDDmzWDm1KG8YLB/IwXaQ56uCwLmJGzIiQ6
	QDS0dD4wIUUjA0ofy4JxqXcwhS5TzAPD+dpOsug6nlbky7HVDDQF500KYFxXjbsA8Vm+vBcGIDx
	1qYYLMMqmBwtgI2Gzo7RDXqMjREVUmAMGkJL93715L0KJ+QI7iPjAjqsevGs36SCaRWYshRVDyX
	adbKSW3xyq0l6dwTaZcrceoKMkF4/O5bBOjtZiL5Kzvg5XHffrW9dE4DZrC+iNSkbuj0lio+YER
	dvx0fD4SfQdmWLXU2gDyodMDyOUbb2JLiipTxdtN11slRK2ilntxkzPNuQeN0JSOqagaZgrYiS2
	f60/MVqnm6GDvlFmPb+IqxKqIyrvCh9dmDzEaFoC9e4sTP6RLzKuI=
X-Received: by 2002:a17:902:cf05:b0:2d7:107c:917b with SMTP id d9443c01a7336-2daec4477e9mr6344645ad.0.1788300573313;
        Tue, 01 Sep 2026 15:09:33 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dae62ed4a2sm1341905ad.22.2026.09.01.15.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 15:09:32 -0700 (PDT)
Date: Tue, 1 Sep 2026 15:09:32 -0700
From: Joe Damato <joe@dama.to>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: Re: [PATCH net 2/4] bnxt_en: Add bnxt_clear_bars() helper
Message-ID: <apdNHMehUnnW5VXk@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
References: <20260831024342.2161156-1-michael.chan@broadcom.com>
 <20260831024342.2161156-3-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831024342.2161156-3-michael.chan@broadcom.com>

On Sun, Aug 30, 2026 at 07:43:40PM -0700, Michael Chan wrote:
> In bnxt_io_slot_reset(), we clear the 6 BAR registers.  Add a helper
> function to do that.  The helper will be used again in the next 2
> patches.
> 
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>
