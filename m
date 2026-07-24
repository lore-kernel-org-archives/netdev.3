Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A1B3CFF4F
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 21:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784927472; cv=none; b=mASH08lYfm7f3MWougSzgJswIcg2iXfc5NurS0sLcRN2/ijyny8QljlTUUBntNBmLRDLNn275vn6NhEbTuf++RouTEcB15XWMzAFo0jXdh230Engg9lXejHmVL0HG6/2KCRb5zl5Oj50q7zjUHJv6BPgpN6Yp3UuNRSrh5Hs64o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784927472; c=relaxed/simple;
	bh=RirywIIvCMGl+AmhsxILpmh/0g1v2KM8NX5F8TG1gsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2r/VtAwtaD5hp0GLxpPHZlr23G5Bqg2S0rLEiT6AudXu3uEZ6XdtfDOy9s1JCWpebh6eR4NbS8Zp2mRL1F5nwYQcyqPrfE8sJgd/rSnbfVU10E4wJ5lYc0JLTbyryCscs4TPpiyvsMD4yc8F5UC9ba6NUU0CR9OHgBKm3JmnSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esC3Tvda; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esC3Tvda"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2caced6038eso12497335ad.0
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 14:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784927470; x=1785532270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bWQIrK7yeLWM4ZB3OW1av571sFujM5GYrF90hFF5FZs=;
        b=esC3TvdaGQ5JtUReZ++og6DtbrdHuKcXJhZmz4iBdZhnEAQ9k608wM5RKPHsc7/opv
         5Fw4SMz3FQQVDLYW1cjKS07dT1TnnJmU6o1cfPkVPAcMQRiqAy36+jZYcT4rpeSiOgTR
         2mi27NPqvefFxR54y3zfs+qVzU0ZH6mC8ZLhYg/hV9tiwuzQOV5oZV1WvpRATqz2syJn
         g98ZCUBPy7bxidFYTmyjtCZhqhN4w2tEoaeA0Y3OSPUfUCWWDMubcptsxytC1r0x6zeY
         3PDM7svt3VRn9rz5NlKO39QmLGcMzf/5XDbkDrX9c3wms+p/eaa0ntDtP0ZuFTQ1/I0d
         mkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784927470; x=1785532270;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bWQIrK7yeLWM4ZB3OW1av571sFujM5GYrF90hFF5FZs=;
        b=fkdDUC1B5BYEuYa/FzMdvsJ3uDe6kkwbw1rkmrBCkV22oCbOS8/hautETZRGjUV6kZ
         L+PbtyPgeJ6160ioHhX4CRYy6auOFc7zcNBqj2RA+Sk+VNkgcIfYo0MkpT015gpBpIAt
         4fVG0ZHysL50CKKf2yAboUi4DgLjn5UxF3i+BvaJejQytcqJM+llJ9CF2T7vvKtvLfRm
         P7D1FiG6sNZvJ+3VEHVDdHbmaMcP+GeVXSkFajeNguri1WY37dCmhKxDprBfV8DwDEop
         VMhj9PGj0KuNi8c4TlYoLroYnmpbeySTEPQRt/Xjb8BBGkZvk2Jqm4KHhRNY3VSx/Imt
         yTqA==
X-Forwarded-Encrypted: i=1; AHgh+Roj/6ffMAgdsfyV17Et9lVGhk5t+uKqvay7R2HimLnk7E8zUMHRWHA2F2lpim00Nps9V+NXGN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxanMj35nosdefrrBaXZaQyLvVyV/sZa+V9efYiiFEsJbaT1QpY
	hGPBRJfO6iwyIQmkoyb0iismWYfC860JUAadbAkK8ms/XQa4kalbg4IU
X-Gm-Gg: AR+sD10cB8R5065Qk3TEi6fYHDNebV5mdWOPZgk068/GxAY9hi7rpU0fSmwcQ+HQGYi
	sHgax7Jt7BgdGbY6NMLtNPLujfxWprHOTohR0cKPZEZXGXtVHw7Hw/i/1tQhnIB60P/eeGZifyh
	rMWcHYMJzH3V5FwjL64ScbeTfwHL/iG+IHgJ3zUHx9wvjppzFnzqubCT/pDrwBiUG0xczrmmNLr
	196gHJRGpQmDslPxscOnUC9kCkc/e34C4tbrwpFb8Lvmww1JgCm1PALQM4rIriumk1OrpxVYGTc
	FiSPQcUPql86dbvm3j9P41++4R7tqZDOnLC9zKuD8Ss7rvodf7J8f61652ail1iHl78Mf0UOBIB
	u9hQNqE9lZYcXCqMjIyx17221jH1nOUtRXp24nuUL+jWrO/EreouCZI8xaNjWea+RfdBy6EVJEH
	Dhxqcga4/+DWUtgi/UgiONDQ==
X-Received: by 2002:a17:903:1c2:b0:2bc:e299:4b3f with SMTP id d9443c01a7336-2cfd7953a96mr18549685ad.10.1784927470019;
        Fri, 24 Jul 2026 14:11:10 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7f48f8sm242665ad.70.2026.07.24.14.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 14:11:09 -0700 (PDT)
Date: Fri, 24 Jul 2026 14:11:07 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
	linux-kselftest@vger.kernel.org, sdf@fomichev.me,
	razor@blackwall.org, daniel@iogearbox.net, almasrymina@google.com,
	matttbe@kernel.org, skhawaja@google.com, dw@davidwei.uk,
	Joe Damato <joe@dama.to>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v5 1/3] net: devmem: allow rx-buf-size >
 PAGE_SIZE per dmabuf binding
Message-ID: <amPU683HyCt3TJNG@devvm29614.prn0.facebook.com>
References: <20260708-tcpdm-large-niovs-v5-0-34bf6fac941b@meta.com>
 <20260708-tcpdm-large-niovs-v5-1-34bf6fac941b@meta.com>
 <20260721110713.325d36ba@kernel.org>
 <amKqlqgfZipKjrii@devvm29614.prn0.facebook.com>
 <20260724072419.62778bbe@kernel.org>
 <amOVWgJ3BAJ8I/4+@devvm29614.prn0.facebook.com>
 <20260724125817.4495a7d4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724125817.4495a7d4@kernel.org>

On Fri, Jul 24, 2026 at 12:58:17PM -0700, Jakub Kicinski wrote:
> On Fri, 24 Jul 2026 09:39:54 -0700 Bobby Eshleman wrote:
> > > BTW did you add both min and max checks? Cause the only risk with using
> > > a dummy value would be that the policy will be rendered inline, and
> > > inline policy is u16 so 64k wouldn't fit. But your sample above has a
> > > max of u32_max which forces the out-of-line policy, which is what we
> > > want.  
> > 
> > Yep, u32_max:
> > 
> > +	 name: rx-page-size
> > ...
> > +        checks:
> > +          min: page-size
> > +          max: u32-max
> > 
> > Sorry, probably should have just sent the whole patch instead of
> > replying hunk-by-hunk.
> 
> Ack, LG, just double checking.
> 
> > BTW, how expressive do we want these policies? For example, would
> > absorbing the power_of_2 check into a policy be valid in the future? or
> > is that too bespoke?
> 
> Power-of-2 could be useful (it's implicitly one bit set, which is also
> potentially useful for validating one-hot flags). The trickiness is
> combining power-of-2 and the min check :S We have one validation per
> field. I was wondering if we would be better off defining the field
> as a shift instead, then we only have to check min. But I thought
> that it'd be a little unusual for uAPI and possibly maybe one day
> we will want the non-power of 2? So I figured checking min using
> the existing facilities and open coding power of two check is good
> enough for now.

SGTM.
