Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29D9481ABB
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 10:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792233491; cv=pass; b=GRuF2vfgYgH2w6GDRy78fORqifQtVBWJriICaErSgjdys9YMJ+xTjetsAiHZtwN3CO9p/Ha1V1rQt0XFV7zPuzMpkv8mZ1YrZesZrKhXUzROvr5RfJ01DjoeYXdByjE4gYXqUxiYmutv8jUfumBAdK26zMQsUl5v02/wVsubwAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792233491; c=relaxed/simple;
	bh=OWILE6TJnc+6T9SUFGhHKJWv32QNTH0FJDtYxgA/Iek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TXxUdlEuiMaIG0p5nG+oZWCZh46fomfntZ4Mli17JwFqRaWqYTtgOnyv5gMevH4fZgW1AeS/OixyEXEFYtqn7zYRftJ6Wxs2RxX0mVRuFHADvNursJhbAveFPf0JyRSWvI4MTj7hpTvs5ePTHy6UQsij4R8HnStj3JB98l19hs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=twkK6hQE; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="twkK6hQE"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b0ca1ebc8bso5349937b3.2
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 03:38:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792233488; cv=none;
        d=google.com; s=arc-20260327;
        b=N32dITA/wTz4jLcfn+hdZCF4N2+nWo6qjPkcL0kti5F/3bqmCw0HaQtgWFRzR2Y+/n
         Qd1lF9eiySCWGCrhM2rFwkiCWTn9vpHn9X/q1IPqVeJQ3PPoBZr+dVCpibgYL+nV/E1t
         gXHT1keT+ztGbkkwSkOOrONzuO5LwoDPDhR9uLP961hXA/gqzJe0Qd/9o7ZFtFRxVuPz
         VLD1Y8UzSVKcMt6AYroCfIU0lFLfR/oxSXwMM/9ldJdLJJUll2zM7PtPx3vO3JSmWv0Q
         HPLEpFkM6vwrHWxqOKpMWTphu8tKWl4kTiSqvbmFeBPeJ/HjLZVn4PsXqlo01cKKaULc
         JvIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OWILE6TJnc+6T9SUFGhHKJWv32QNTH0FJDtYxgA/Iek=;
        fh=IsCAAomKrQay2JFdDDpEMJp7bFXdyQvOQGUrOfC7VYA=;
        b=klB1unJZHcsBd9Z+F4h1pDIppTNBWSrkZc4+PsiU/Unkz50mxV7nWWjrJ65i/UQU5B
         9XbNvqNFqhkuEZkKLzZ9wx8v8csfYgtvID1s7k3iMVSkD/0vDTQKROA/CQofsD9XLzuV
         IuDvbN6CSCZbVjwISF/wm+cYp43r0kvHMTWPvWHN7z9ImMutmCiW9VoMy/TFKIUGHZSd
         8hesRrfTFXdUwSr+Z4YWHWaXobRoASUQwe0/9Wa4VQnBDSFxkP8ihEzmwDpa/pCb4k8W
         a9/Sda5v6jOejRvHkGeU5SliO5MRE4M6A7E5MAvPKyS/5h5M6J8dfsait/6rxs/DmIl2
         Zfwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1792233488; x=1792838288; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OWILE6TJnc+6T9SUFGhHKJWv32QNTH0FJDtYxgA/Iek=;
        b=twkK6hQEU1af83Elo0s5cJGQFtomg9cUDJ89V7VVJcW2pC3yDBLo/HEeD0pQu/24Sp
         Ll8C0fJuWRU8odd/H9YH4aUV08VZLJehLdTQZsIGyUtOgy3ZQw7Wsh4MMMUlPrFUvDEW
         Nt0rssAD3uaVAfNuAQy7m4dMWFwgjFHWUAlY0RhdSgzxwTWvZzW+RuhkWxE2TH+3QFNH
         0REL+c/TPybjClq0UjkME+S+nA0lsrccX8DT9dRCntb+y4DGPaJDFYdfJSBmRLWvalt9
         7ocfHR8nQhOQysVVbumw/tQVgucRQWMuCwPlABD8zOqRxNdNPBvI/P0khbLEJpLo8cH2
         QRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792233488; x=1792838288;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OWILE6TJnc+6T9SUFGhHKJWv32QNTH0FJDtYxgA/Iek=;
        b=OGyrJsGn3obtxUPa747we/fLzYtkOMhX9k36GyZG+rxXDpg2K+ZHfmUJ25zqrhAWDS
         p1ey/RuIOjdlglpuwIpxzTX3oVQEOXuY4nY6GUBIm5qelk95O5Q358Bi+rwExMwQHvh9
         4q0AMu4+OtgU8TpjNJZfZHa3C0MZP0oajDQ6mwJCjQ56GRVU9kzazP7wd97R3qjiraMN
         CeNQY6MQ7KMz3bzdoU1JjephkL+DN1ArqGije3RRTHyseeObL0uWtfj/TJ0T7NDn7n+Z
         XsN3y2RTJqyK9xfG2XqXsT4wAzQYSjtZ0pj8Pud/Jx+jfYDAa0m6YHCwsNVjXj53mh5D
         uVzw==
X-Forwarded-Encrypted: i=1; AKwUvBxbrWROAl7mNZf3WfnkkeNG9XUOCeC4YxaXG9Y2XEJMj056LXoxtC3C7YH1gTGA1v9wzv44080=@vger.kernel.org
X-Gm-Message-State: AFq9FYIQl54HHxsDpPRrxoM1pBit5UPX5Yc4wwCYZZTKqHOLfNJBZpxl
	Jf6nmrphYfQ9tEPOVwRtQnWZsrpld5UOac7LuwN79ULbIxYggi2tKyQCGK9im6K1oTar0RwJMcZ
	w9wE30ZyDlC4MXUAdxm4ATEoj7IJ+oJmps04y3kl2
X-Gm-Gg: AYBFou07DuySYomkEOIOIP8zyYu0XCn2WZ0X8L28Jee49xPco305Z+2dIlhkBDwg3kA
	N3jwxsv0Cxeirgy3B68nzGJBXBx8u8b0TxMbnAELTojN9AqyaT2TY7rhiWOcfa+WSFHyV2U+KTo
	fhJs3AwkaKUA2Crg16aetA2S3hHZcWV8pdaTQTTKk3ZfOCryw60Ub+FaxTnVeYMrZhY0rs2S3eW
	CyGGQkscVrUBnOzsQSdsVJyXhV8FiApv/rtUQ/1EIU2tn+McAE+TYcpdMDqkznQ0buE4Ivxz7IO
	Yj7w+4qzDqrzieMCwV9KGOIg1MM5A8X7z1k2I0vNxDtei7Jv6posPMKLA42/rCFHPvadYPn9q2v
	TJznszoZy6e9mfohO7Ax3E8D4ckrTWVnZaNb6vVEoaJcebOka1bCYMZOD+4KE8py/KX7vxwtiC/
	O57LxtN4APPtn1wqLUBzd8nxwwWLhAR7BsMyDDRtLcN/YPCQvzgGPNq8FOkvr4orrw/1ddnKGMd
	/JT0ikRSZbM7ZlrwoC9my9XQvQGhV2Ol9hDPkb+PLxxSMqHTLKVEg2JwRyeIPX8r2Q3wk5gipmM
	xIVbFPD8xSea7g==
X-Received: by 2002:a05:690c:f02:b0:8b0:e9a4:65b3 with SMTP id
 00721157ae682-8b0f219a7a5mr9764157b3.13.1792233487679; Sat, 17 Oct 2026
 03:38:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260913104251.648421-1-julius@bairaktaris.de> <20261004172439.3548490-1-julius@bairaktaris.de>
In-Reply-To: <20261004172439.3548490-1-julius@bairaktaris.de>
From: Julius Bairaktaris <julius@bairaktaris.de>
Date: Sat, 17 Oct 2026 10:37:30 +0000
X-Gm-Features: AclHuK9uOXJa5LQ_fwTpXh6eC6CCQIR7bqWDTaaZHFaPK-RFMqJ9NrsaTLBldJc
Message-ID: <CAC1t37J79N69Q_GWbU9ehf6sTKSB82xT7-7EuOsXvxtEsq7KLg@mail.gmail.com>
Subject: Re: [PATCH nf v2 0/2] netfilter: flowtable: correct and advertise the
 vlan match
To: netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org, fw@strlen.de, phil@nwl.cc, coreteam@netfilter.org, 
	netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com, 
	mbloch@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Hi Pablo, Florian,

another gentle ping on this nf series. If a rebase and resend would
help, I'm happy to do that.

Thanks,
Julius


Am So., 4. Okt. 2026 um 17:24 Uhr schrieb Julius Bairaktaris
<julius@bairaktaris.de>:
>
> Hi Pablo,
>
> friendly ping on this series.
