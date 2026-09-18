Received: from mta0.migadu.com (out-224.mta0.migadu.com [91.218.175.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811473DDDDA
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 07:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789716792; cv=none; b=OUWYBcaUfG1UWFkmV5bEq14LS1aH9y4oYmTAmMxbsJClqtKjMPPPWzd4tq/Kfu4piP3FH+RxhRfo1XZHLHgRQPreNDL5P8qrk5S00CUz2ICmDQnIXvZ/aF+zX5ARY7wzJ6BmCMQf59x+7ebL86DK5Mn93CuYXMHoAlvIVtBRmL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789716792; c=relaxed/simple;
	bh=Gg1Ve84BH1KMyY5R4zfF/nmRSZBe/jom/oYoUmPRmRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KH4g9bAq2hJNfVMfbBp3spZscsDc15ASGvxQaBKy0UFIa6N2przv68QDoNJArO3PDTm/CwhNJLk74QLIFTXlT+Itc81256q3r2+U/ajmUKZAontbBZJzWifg49EfET89mgkUAcEGls72OrfcMDUkQFEoHFhF7Je6wwjxEK63U9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LoBOGfWk; arc=none smtp.client-ip=91.218.175.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LoBOGfWk"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Gg1Ve84BH1KMyY5R4zfF/nmRSZBe/jom/oYoUmPRmRI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789716788; v=1; x=1790321588;
 b=LoBOGfWkC3YDNORNTroR9+BsRilTTbYOJVAcRtE0+D4BXwrGqlS+dsx9gZQ9UCQLeXn0osf4
 g+9GUbaRNNKMArbC3HkVP0tD8yJmgfmNa8s5pU21Fl5btmchssi1LuXefIcDmWyuBSUJWMBJww7
 oUCJPiytlgTSuFshoIlG4Uw0=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 7691ecdcd9b7d1da;
	Fri, 18 Sep 2026 07:33:08 +0000
X-Mizu-Trace-ID: 7691ecdcd9b7d1da
X-Migadu-Flow: FLOW_OUT
Date: Fri, 18 Sep 2026 15:32:59 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: sashiko-reviews@lists.linux.dev
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next 5/6] netlink: specs: rt-route: describe lwt BPF
 program options
Message-ID: <aqzpK1H8Pib6bVcY@fedora>
References: <20260917-ynl_rt_encap-v1-0-fbbe6e680571@kylinos.cn>
 <20260917-ynl_rt_encap-v1-5-fbbe6e680571@kylinos.cn>
 <20260918063655.EA1DC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918063655.EA1DC1F00893@smtp.kernel.org>

On Fri, Sep 18, 2026 at 06:36:55AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] netlink: specs: build failure due to missing header in lwt-bpf-prog
> --
> 
> commit 73e4e6736fda4554b1e22b6360a42d9d2e02b4dc
> Author: Hangbin Liu <liuhangbin@kylinos.cn>
> 
> netlink: specs: rt-route: describe lwt BPF program options
> 
> This replaces binary BPF attributes with a nested lwt-bpf-prog attribute
> to support lwt bpf prog options.
> 
> > diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
> > index 6030d7cb8d0d1..5e9537f7dfad4 100644
> > --- a/Documentation/netlink/specs/rt-route.yaml
> > +++ b/Documentation/netlink/specs/rt-route.yaml
> 
> [ ... ]
> 
> > @@ -610,6 +614,16 @@ attribute-sets:
> >        -
> >          name: hwid
> >          type: u8
> > +  -
> > +    name: lwt-bpf-prog
> > +    name-prefix: lwt-bpf-prog-
> > +    attributes:
> 
> [Severity: Low]
> Will this cause a build failure in the generated YNL tools due to a missing
> header?
> 
> Because the header property is omitted for the lwt-bpf-prog attribute set,
> the YNL code generator will automatically output the C enumerators
> LWT_BPF_PROG_FD and LWT_BPF_PROG_NAME in its generated header.
> 
> Other attribute sets in this spec correctly specify header: linux/lwtunnel.h,
> which causes the generated YNL header to globally include it. Since the
> kernel header linux/lwtunnel.h already defines LWT_BPF_PROG_FD and
> LWT_BPF_PROG_NAME, compiling the userspace YNL tools will result in a fatal
> redefinition error.
> 
> Should a header property mapping to linux/lwtunnel.h be added here?

Yes, I will do it.
