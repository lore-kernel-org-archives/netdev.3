Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FE137CD32
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 22:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785017156; cv=pass; b=BLdDfHotodmrMV0FLVJGJ1la4dQapRNIlUyapMPOqPucLSNOvYmEAre09OOn0EFeyVImgZ5ibHWQPa7elB6Ph4UkSQfqelWv6fz0OkDf2udevvxFQzPv02IwtTAjC++EQWHtm1Yz6164XaUHL6mue0ioRmDMkduN+rbqJtSXJQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785017156; c=relaxed/simple;
	bh=/glHZqWRbLjboTflmjVi2Jb0FjvvGY5sjwDLILzbZQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DLUJvxCZdg7cADT4ZZQ8oj2A252dEDkZmnw83vtTFA2mOx0rnNj/6pcYWwpzYAhlOJj891QgU3Mo1aRKl40tGbIVv/40dhZVn/McW2Fn+55K/Zda00jVvH5ea/nbGldKwtLSx6QEg88V+dxTOxV1Kmyso2VA+XTYhMe4rqWsLAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=TjBEa10s; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="TjBEa10s"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso14448255ad.3
        for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 15:05:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785017151; cv=none;
        d=google.com; s=arc-20260327;
        b=X2B1y+VvGsundOsrCniBB56eiMbgKn/bXH+m2nKdhiqGAmtSsEQM8rdAgL8cAuyLcI
         mttt38sIb48Sfi9mF/qYqvoJlTP++14xzyIQfK0Oz1gOagHn3OZGJli4pyKUM9JqYFR0
         xmX/lv2YVhvyCKeqvhHcUYFV0R11AZHLK1msN614uhOU/DTXkGq/fmBMEA918nHZJYKJ
         VxKI3tcnW/ft9TNunh8EWXP9a2jaKYrDcxvxdupJjNZRjJLWrfRuRS+w2IGHDfnBkrX6
         eBGSUpYdel1BGX4TbEbSy36U1LwdnhysSx2501wijygB2i6obDaB2tmLMxTJDb5Ziu1J
         yV7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/glHZqWRbLjboTflmjVi2Jb0FjvvGY5sjwDLILzbZQ0=;
        fh=QrTJJQT8vXewTmt+lUHUi1JEvIanxKl5oaIRhg9P6BU=;
        b=dToppYAEisdYdelfKlUS/6KrJzewhNFN8z0Np5QvL6CB+p0tToKUIPcrtcqNFdzyf5
         jq9fP7ihKpy8q25JM1sQlxxtM8E/b94Mr125A2CdQVrYZFZKPdWpIR9Jl0socQ4Y0Mnw
         StyMGOIMv8fKqATWRBCnqEhugZDT8SUxb64PUTG0SLvBFJvMW43zaSiYavXDimIKpsQE
         KSVX/KBUN2Lks1w5Y9RoOVEY2Ad23eADF0V55QnHTGlXWydqtnfUL4pDBpwtN19zaVWV
         c3YKGrdHGpG71ocmyLrxkZGw3ZUZN0V1jb82EYZRTvctbPaNH8EEFKQxKLmBMfC2EOLj
         OkYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1785017151; x=1785621951; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/glHZqWRbLjboTflmjVi2Jb0FjvvGY5sjwDLILzbZQ0=;
        b=TjBEa10sg0sluPTM+zEeyjwQ6jJIhpqP+wOAfpJQNUz6RqH35CjQSQcLhFSclmIh85
         gZTi86bVIBqgzFmI2QhLK8adFcWr9SuYIQ4myfSbaIYOCcxjsYiC2sy77rwR52x6jSDt
         bgIhxuAk0wRpP8xMJkQGiHIUFbUoUcDjuQBGIHlYHz/TpT2XxDWVI1go0nIZPJpjsjRz
         yc+4/g40ls3GAGs6cz4GOU+lZ0kfm/nnKUTrU1EmzbMDZVMDebKPqAGjG0pCg5ecmHzr
         HoBF1yFz2z/dQ9pi9n304DvWK5WzM8DG0mEdiDWta1PWzu4CwLXCNtZCO332vfgz+9AJ
         gfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785017151; x=1785621951;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/glHZqWRbLjboTflmjVi2Jb0FjvvGY5sjwDLILzbZQ0=;
        b=jj7qtGuqPrJZYD+3eE/gRNrhreKF82vBljzHKBl2BTWYU+TsGNQbP+XT2cS6STOGDc
         vqZDkS9L+gXFMqdQq1ZruvmymRatH5MxTEvwzwY+Ad87AKSSRxsXBilEtMwtibuyGq1R
         UbvGR4UCmdwEFtNHcLHE1VL1AOSNyDnBsxI7gNk+ZqZLi82HWmrDDW2RBpZ/bEIdZsIP
         brc1PpHGGSuYWPGjoRXTgQG4vVSQ4rYwpK+e78f2rFktAQs3HsNnB9cvn+Xd1IhlbkNf
         7eHPH4MDL0votiARAGA1W9J15/IanHc3m3JH2oU2UTqYO4bw0adZ/nS4ccvByxEdbQmK
         OLgQ==
X-Forwarded-Encrypted: i=1; AHgh+Roa1coUr5NfcOgzKP09f8Q1qDGd7tvhDJOVxBjqIycwPS+4eab2KO+B/5Hy3AeRabJmLjT4vU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKeINyGmoWAfkez5KMqCDJU9xhZlZ8lciGfH1xRoXmr3az0nOi
	d+H2ZS17H1HV5Ky+dfPXQ1AFX9yETkw9eakkIWixBSIAK1IgVBqju4/tbotEAiopoP5dlCxAYll
	fpAadQLvw0PiGUEPFC7Qyi1YZ3m1AIK4SOm58P5Ma
X-Gm-Gg: AR+sD11eGbeXEWSNBViCEx+KEwqvtxZEhKM7dbaKzPMnBNvWiM0w0DhZl9vKNLaTCRd
	PY4JQUCCMAf3DEWnPCAi0uWe8c9qGh+mTJVG44BduMy8IzJuY+CB/MPpq0i6gWMrqQwrk8C2hrI
	OOXvC1W8pXMlzWDrsFkdnRTGV8o1iMedcioSYe+FDKipeXPrhuiwRA5uJebQv4n4M0WIyazYphV
	qwnl/VNas1BjZjESTS4CBKV1KG38qXl4bXhOrZFXlb4jCDyilSLmQ09xIdQP5wHFXUDYZkn9dUh
	8PHPv2RkhIEcYQuRXQ==
X-Received: by 2002:a17:90b:3f0c:b0:38e:485c:ebd3 with SMTP id
 98e67ed59e1d1-38f294ea2e2mr3687429a91.15.1785017151516; Sat, 25 Jul 2026
 15:05:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706212556.3199234-1-xmei5@asu.edu> <OS4P279MB0403BDB88C2B7F4D4939DCC4EAF12@OS4P279MB0403.NORP279.PROD.OUTLOOK.COM>
 <CAPpSM+QjiZxUOqK6Aor6gLehVj=xGQ0uAcuPm089EuSNRFeynA@mail.gmail.com>
 <OS4P279MB04037D97A6ECD2021F1675C9EAF12@OS4P279MB0403.NORP279.PROD.OUTLOOK.COM>
 <20260725135239.30427-1-doruk@0sec.ai>
In-Reply-To: <20260725135239.30427-1-doruk@0sec.ai>
From: Xiang Mei <xmei5@asu.edu>
Date: Sat, 25 Jul 2026 15:05:40 -0700
X-Gm-Features: AUfX_mxWSEabtVTBlq9zxaL6-yN6-fKXVFfXl36XY4ST95-C8XzK4FYaza4pI4w
Message-ID: <CAPpSM+Q3cEAds6x5QcJU6xGEC08rgveZthyvyN-1Ts+G5UsQJw@mail.gmail.com>
Subject: Re: [PATCH net] macvlan: cap IFLA_MACVLAN_BC_QUEUE_LEN to bound
 broadcast backlog
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: Thomas Karlsson <thomas.karlsson@paneda.se>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com, 
	tgopinath@linux.microsoft.com, kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 25, 2026 at 6:52=E2=80=AFAM Doruk Tan Ozturk <doruk@0sec.ai> wr=
ote:
>
> > Like I said, we use 100k today and are currently running our
> > workload extremely stable with that.
>
> I independently looked at this path, and I think checking authority
> over the lower device may avoid needing an arbitrary queue limit.
>
> A macvlan moved into a child user and network namespace can change
> BC_QUEUE_LEN and BC_CUTOFF even though both affect the shared
> macvlan_port attached to the lower device. The child can also create a
> nested macvlan that resolves back to the same lower device.
>
> I reproduced both paths. Changing BC_QUEUE_LEN from the child changed
> the value reported on a host sibling from 1000 to 65535. Creating a
> nested macvlan changed it to 131072.
>
> IPvlan handles the same namespace arrangement by requiring
> CAP_NET_ADMIN in the physical device's namespace for changelink and
> nested newlink operations. I have a small patch applying the analogous
> check to macvlan, while leaving queue lengths unrestricted for callers
> that administer the lower device.
>
> Xiang, I am happy to send the patch or pass it to you for a v2,
> whichever you prefer. I would preserve the report credit from your
> original patch.
>
> -Doruk

Hi Doruk,

Good catch, and this is entirely your finding, so please send it as your
own patch. It stands on its own and deserves its own authorship and its
own Fixes: tag rather than being folded into my v2.

I am still testing a valid configure uplimit to ensure the
functionality and avoid OOM.
Please let me know if you find a way that makes my v2 unnecessary.

Thanks,
Xiang
