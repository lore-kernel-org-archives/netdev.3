Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D999349CD8
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 08:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784707775; cv=none; b=K8SwHgekH0/Y0R1i5pAawtZT1PDFOeAwWKUVgjCr2zzZ0XOYG80wdhuzAt9mONq1vdMXd+Kjt2MfEZ6/BEA2K+BTiPfwXOIDSXFK0ArHv39GlbVSuYgDH+PPbzpMKpJ2VU2LUXZYH0ZJl9dh7QI4JOvdVAMuMwPJ9cGhfppstZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784707775; c=relaxed/simple;
	bh=yu2Z977Y2S4w7pLWvx2O/Sd/fRiibvucr/nZF3MlpQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rl9aemM4QP/Bq/9cwuv7XglGMF+o2GBJmxMxwM2U06Ifizx1UX0memejOPA48DAHSdmH+yPMNnsRlUOrj1wFiCevlTwTESoNN4J0MT5RNKUiUp5LVGAhGEqENgT8mwdqJRTACR8kk71V5Rjra2sCSFHxgS4I3vGAc31S0/LfH3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=apSLClL2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RHiDyVWA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="apSLClL2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RHiDyVWA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784707773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KY9sPu/C/THo3xiawdObT/bqV/O7V7jMNcoBv3ENB4Y=;
	b=apSLClL2FFJw6G8woYUBxbOXGIHaIW9fTauu4TEH/IEI8B8ns2VDVKtELjbUiwBPbHYSkA
	kfZJDRAikC38LtuW4t8km2nJt1NFJujK+qSDm0K5MYVRg8wQrtBEAop69h2ddpw9teHEXA
	jmyyYvut+cI+SPDzk9akdI5FMp32ZPU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-8BSNPBQkNh-wKbVQddYhaw-1; Wed, 22 Jul 2026 04:09:31 -0400
X-MC-Unique: 8BSNPBQkNh-wKbVQddYhaw-1
X-Mimecast-MFC-AGG-ID: 8BSNPBQkNh-wKbVQddYhaw_1784707770
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-492488f8583so159989265e9.2
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 01:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784707770; x=1785312570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KY9sPu/C/THo3xiawdObT/bqV/O7V7jMNcoBv3ENB4Y=;
        b=RHiDyVWAuN4fzzmprSU8Kqv3e6crSoQ3jO6mIlV9lpGs54Evmyd9DJiKsKk3vs1i09
         +uxOOYLnEydhLhk3dVuCMwfF2KwSaTOxoK1e+G1b9D/OBKQVY93rwjRaadurq2/QKeDR
         MgCCHwh+w85tBG54SniG9zQLw9e4orT1vmi5cPrpkoh69Omkqh6p3MWnrdPlwnOEXi7n
         DFli6fjnGddVpOSpCTLagbDz7OgA3Jz+AUj0ib7MrrbCmXhY0XR7kA8UvJUnCM2eI4Kf
         fxcVLIoXvSXsSg1JLDQ+rPebsnQMKhcO1faPyogvyRh6uhoomnw9KzRaypLIHf1NQz9f
         /eEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784707770; x=1785312570;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KY9sPu/C/THo3xiawdObT/bqV/O7V7jMNcoBv3ENB4Y=;
        b=G+RsGKVtOmFTi+RVxKXZNHNNNao3Ert5QjT9IitOTSjdGNPfgno+Tdw3zippvQhv9J
         fOc75qLaCMtpujjJwPA4Q9kjiNEjEe5+Z2z9IJhUDMhoDIaC6RKVlIEY8CRgT3LitsIi
         4SSZyMcyzlUECH94ey7wq7JMOzVF6SF4l7exjzg5CDrIFLWvvc7VuW3WxoB8Lhk2dtV8
         Z4oXhNQnJ+Jl62iszad1T8ULyOB3rypuhW2NRhQfCsYAH5olrVrSmyfLo7iXujCBzm3s
         sHP99PQJ5YDbo2SUMZ3NH9mU1A2OfVT8CC70yFYKmxUfWsk7SNzHiPIwQsseEw0/limq
         XRSw==
X-Forwarded-Encrypted: i=1; AHgh+RogUZhFHipWa5jbXeG+sHqY5eAL8vQpAQiTfG1J98dl9jWnw2yq+xndYcOhBaaO2uEdpDrmQqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YydaznmlaaRT6WqOApb65UMm2BiDhIJTvoBB65zcTYZ8SNoDko6
	3dkAvkuZHyI6wbu2XsuE8SmWgGXLvDdiz98Icg1seT+T3AM6I6I4rrodoa+22eeCblKudiB7r4L
	pnKoe89Vz9lUCWG6MNwuur9CINq9sWadZOSOaP2I3xxZ/oD407pJVKGI9/g==
X-Gm-Gg: AR+sD10yJQWUduyCIgJCkbDUCd4tuo1/B/e3BuhRFKwpP++YWY/o8mUTV+93abRb2l0
	AMcW1wwKM0AQVT0C510at/rbNtEETtcd5tKeBelOAUgaVXLnz5wUWPzmAvffpf9tHW15kmLQIZN
	PxaYbJc2reAkH5BPApLPM1Wd471K1vqWjTNFjgJnHlsPpaKVr6AZ4n3H2jipyT6kpMvf+KkFveC
	1Hqy5zgq/KjaSKbe68lv6zCctadGB3ytABkTsW30ZZAb7dlPXce2cNhBmbTOlZHvf+yT/ZpAqN+
	IaMRX6n63BzFoeiWbo7ZPYGkb08vd3ATI++5DnJOFm66F3vzH+MwIJjI6drrlkF2+CIcm846rK3
	QUyPmfE7tg1Dj4PwPPOMKYw==
X-Received: by 2002:a05:600c:6298:b0:493:c182:6b08 with SMTP id 5b1f17b1804b1-4954a5125a0mr259977645e9.36.1784707769965;
        Wed, 22 Jul 2026 01:09:29 -0700 (PDT)
X-Received: by 2002:a05:600c:6298:b0:493:c182:6b08 with SMTP id 5b1f17b1804b1-4954a5125a0mr259976855e9.36.1784707769278;
        Wed, 22 Jul 2026 01:09:29 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495653bfabesm141254965e9.10.2026.07.22.01.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 01:09:28 -0700 (PDT)
Date: Wed, 22 Jul 2026 04:09:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>,
	Brett Sheffield <brett@librecast.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] tun/tap & vhost-net: make qdisc backpressure
 opt-in via IFF_BACKPRESSURE
Message-ID: <20260722040722-mutt-send-email-mst@kernel.org>
References: <20260709095511.168235-1-simon.schippers@tu-dortmund.de>
 <20260714092506-mutt-send-email-mst@kernel.org>
 <5016ae84-7049-4a5f-91c9-ba0047b06ee3@tu-dortmund.de>
 <5089fc5e-2fb8-41fb-9aab-42b22cc2c201@tu-dortmund.de>
 <20260721105853-mutt-send-email-mst@kernel.org>
 <20260721100715.5b43412d@kernel.org>
 <20260722020611-mutt-send-email-mst@kernel.org>
 <8814700c-7549-4d12-b657-c990dfeec14f@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8814700c-7549-4d12-b657-c990dfeec14f@tu-dortmund.de>

On Wed, Jul 22, 2026 at 08:39:38AM +0200, Simon Schippers wrote:
> On 7/22/26 08:07, Michael S. Tsirkin wrote:
> > On Tue, Jul 21, 2026 at 10:07:15AM -0700, Jakub Kicinski wrote:
> >> On Tue, 21 Jul 2026 10:59:52 -0400 Michael S. Tsirkin wrote:
> >>>>> I prefer applying it, but you maintainers must decide that.
> >>>>
> >>>> Hi,
> >>>> just a gentle ping.
> >>>> Has there been any decision on this patch?
> >>>
> >>> Hi netdev maintainers. Given there's a perf regression otherwise,
> >>> we should either take this or revert the original and reapply
> >>> in next.
> >>
> >> Revert, please. We were AFK and are now working thru a backlog
> >> of 1k patches. The new IFF_* flag needs scrutiny we can't afford
> >> at present.
> > 
> > okay. Simon can you post it pls or should I? And once merged post
> > re-apply for next with the flag included?
> > 
> > Thanks!
> >
> 
> Would be great if you could do the revert.
> I don't want to mess it up. :P
> 
> For the re-apply:
> I can post a v13 to net-next soon with the flag included
> into the existing commits.
> Or would you rather take v12 plus this opt-in commit as-is?
> 
> Thanks!

jacub if the revert goes into next what is the process to
target a patch on top of it for net-next? Thanks!

