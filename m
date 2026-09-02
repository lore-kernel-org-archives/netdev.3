Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0594A4846
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361244; cv=none; b=JFEg5vu/X0ekCuAPBakvivWRyZGNK2dGzeutN6fJWXTwEzoLtHpbnLv8p9vL3AigIRhOIy1jg7XwlUoujARwkB84RrbvcPXRdlQylpcbIenwWzsrgnR92K9xfEkvl9MsutYkCQT5L8EsyxE6JneHvHUpNmSR5d9jQ8XCr4h9rTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361244; c=relaxed/simple;
	bh=yVJj/ezX1/2qUVh10GmGox7+p4nsIGp0iDuqeVNxV9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBRAHCCSt6qBL39PTPbIAKiFJOmj5UnbUvq/1s5XUH0t8b7GLcQCiV/VGs70XHv207DiftuSjWqUuF65RFSMusjH2yc7vzbOIWacm5m4VdnfuOZnnffPiGIvrPyaVJ5XU3e7VZTeIVIh6dCd4TJ0lzMNNGOVknFMcuyu9IibSjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1HXbdB6; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1HXbdB6"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c259e5c22ffso194407866b.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 08:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788361241; x=1788966041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cCdMXwfzfL+0pK/AJnd89dTMFr+Rd2uI7eohWuk6MzQ=;
        b=m1HXbdB6ngLGmbxOAVFG7tSgIaFTdLN8nwpaGQfchGky5U8uw0q56V7iZ74aG99OjJ
         4GzCp2hgnuEQZ63PWG9+CytnZ4dkjrU9gVAw1IdqcmbqpjyKlyKSvBE2xq3DxsY+MinO
         tOT8RIxKzj5RpGr1/YzIOiBaJXbPP45mzRiNcJsRldtAtUu3/74m+A+1XdmWXor83PnO
         d13fR/kJdjKy/w+BKrDYQOCNrgn2bfTAZk2gNLG+dr9iMtm23mesnDd6CdWRG12tc1AT
         sZO4Dcoiu7KcPNwL+VqPkAzAy4KputzkS9A+8+ZKh+NHfG7xWKJ1OhdJrgJdKravyMLC
         cstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788361241; x=1788966041;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cCdMXwfzfL+0pK/AJnd89dTMFr+Rd2uI7eohWuk6MzQ=;
        b=l5ZWn9NGBRYAD3hiDMoys8Eza04lsr/YK3GRGeoORFXtm0WWdgP7pwn3HFiZ8Li1vi
         hCZsvxEhyx7oelhRXb0vweJedtXu/vKGOmQgh5U80e6DUrIWRWIdAReOw/5uawEkDzlO
         9oebNMOO4lhFKe/mHx0eeWLV+XqeMEXK2OgV5Dpu7zoog38BXg3o6sBfiag7Ofh6k54Y
         82MGYfdyGgxU95LTuEDo46g69seJvYByGn7AazJW2f9sxnJsHcBS1Ted/Yqxgp5tokyp
         zvWxrBlTx3OOYmrV+ePrgsly+w6chzAUANQj2eMB30WSUECeRn3F4yp/vdLy0uz26R6k
         4hzw==
X-Forwarded-Encrypted: i=1; AKwUvBwZLXpsUAm3fTVRheBlbcawcUKz3KJ5A7hGLtlfqgiNu4CO6XTpG45kguVEceaKDXgHL9wAekI=@vger.kernel.org
X-Gm-Message-State: AFuF++l0QroH9/MNh47DldeUh82GuL/nOf8WfrYYuzquj0viG/jCIDaV
	2o43QZeHMvaYczerIFKlsTZFcJWKwizYzrKMo0Fw6ejQzsLf0HFZTAOt
X-Gm-Gg: AYBFou3dkoAF4PrgSFHfuRSwehNO96CzOCGe9dfJTw8aiYUk6V16zaMLzWdK7GtvhG+
	QuC26pCAokY4rYVEu1Ghw1Vs1yY9ZMhD9wt95h+qp7EOHWBR3RWQddjsu5etvqUnBYK3vs2Tsey
	ZSNFmiaK4PCAMkLg4yig3Lhg+Qn02g58QWSr0H7pJqT7nuyN/Kc2l5D5eoIBA5fP0aPWPTDKaAx
	ERDMF8MyY0kVFr32/G+iez74+cUoYu/fpaj9eUsb/j3/9KOb41c2vSTuTiAiDDW0g3ASPpPEe9K
	xvU7R3HseMVpXR1VC1IsDLCC2fylp8amSEEqF+ItA/WceWeK9Y+SYEfAeoPe0d4z11vUL6Su0KF
	prAQqQBGzGcx+w2tN5h+OKaPS42PW8GaCM6AGjicOWj5uVUAY6y0WRtbyJfnxGLeooFR/93wDMN
	w5XUlGt/KTdL1gqycZeBrVAUzHuNHTNj3l1YYILktC8c0ha2iBx85v1eLrbSS3WQJ4PWB2
X-Received: by 2002:a17:907:6d25:b0:c1c:4e36:eec6 with SMTP id a640c23a62f3a-c25d54f1adfmr332289166b.18.1788361240672;
        Wed, 02 Sep 2026 08:00:40 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25d03f4e92sm152109366b.44.2026.09.02.08.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 08:00:40 -0700 (PDT)
Date: Wed, 2 Sep 2026 15:11:14 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, lsm <linux-security-module@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <matt@bobrowski.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	David Fernandez Gonzalez <daferna3@isovalent.com>
Subject: Re: [PATCH bpf-next 0/7] Add new way to add BPF LSM hooks
Message-ID: <apg8krBwREwiByiH@mail.gmail.com>
References: <20260831110934.241898-1-a.s.protopopov@gmail.com>
 <20260831153456.5a7d6937@kernel.org>
 <apbFG4WKaZNsURo8@mail.gmail.com>
 <20260901174926.12cc95f1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901174926.12cc95f1@kernel.org>

On 26/09/01 05:49PM, Jakub Kicinski wrote:
> On Tue, 1 Sep 2026 12:29:15 +0000 Anton Protopopov wrote:
> > On 26/08/31 03:34PM, Jakub Kicinski wrote:
> > > On Mon, 31 Aug 2026 11:09:25 +0000 Anton Protopopov wrote:  
> > > > The BPF LSM programs are allowed to attach to LSM hooks. This enables
> > > > operators to mitigate known bugs without a need to reboot or livepatch
> > > > machines.  BPF has shown very useful to create such runtime policies.
> > > > However, many APIs and parts of kernel aren't covered by existing LSM
> > > > hooks and this would be beneficial to extend the coverage.  
> > > 
> > > Dunno. Do you have any reason to believe that any of the CVEs your LLM
> > > gathered for you here are actually getting exploited? Spot checking 
> > > a few they seem to be mostly driver bugs. What security model do you
> > > have in mind? Untrusted/malicious users with physical NIC access?  
> > 
> > For the untrusted part, here are some existing examples:
> > 
> >   * old untrusted bugs: CVE-2022-50651, CVE-2025-40255
> >   * "namespace CAP_NET_ADMIN" bugs: CVE-2024-43836, CVE-2025-21921
> 
> These span 4 years.
> 
> > Also, the recent copy-fail is a stronger example (though not generic
> > netlink-related).
> 
> Yes, if anything it proves that serious security issues are usually
> on the datapath for networking, not what you're covering.

I've skimmed through the kernelCTF list. The one ethtool-related CVE
which is addressed by ethtool hooks in this series is CVE-2025-21701
The more prominent producers there are net/sched (CVE-2026-23074,
14 bugs from 2025), nftables (CVE-2026-23111, CVE-2026-23231,
CVE-2026-23272, CVE-2026-23278, CVE-2026-23351, CVE-2026-23392),
rtnetlink (CVE-2026-23209). So bugs do occur in netlink-related paths,
and are used to capture flags.

The generic netlink was chosen as the first one, as the patch is only 10
lines long, but the hook would allow to block ~200 [historical] bugs.
End users might find the new hooks useful when they encounter
new bugs on their systems, which will be blockable by these hooks.
But to do this, hooks should be present before bugs occur.

> > The general idea is that we gate the common de-multiplexors such that
> > not only known bugs, but mainly those which will appear in future are
> > covered. Rough numbers for coverage: around 5% of known cves are
> > covered with existing LSM hooks. Another ~5-7% can be covered if we
> > add netlink-related hooks [this series + net/sched, nftables,
> > rtnetlink, others smaller]. So, statistically, we know where
> > bugs had appeared in the past, so we can "predict" where new
> > will appear. Some of them might be severe, so this would be
> > good to have hooks in place to be able to "mitigate" them.
> 
> Easy to PoC stuff with LLMs these days. I'd like to hear from
> an end user who would find these hooks useful, in more detail.
> Anyone with an ounce of gray matter will run untrusted workloads
> _at least_ in a VM today.
>
> > Just in case, to test this patch locally, I've found around 10 new
> > ethtool-related bug candidates. I've sent a fix to one, d09c98a6da21
> > ("virtio_net: Fix resize of the RX ring"), which was easy to
> > reproduce in a VM. Others require specific hardware, though popular,
> > so I can try to reproduce some, and was planning to do this later.
> > Of those findings one is unprivileged, it triggers a OOB read.
> 
> Please send the fixes along. The hash you mention requires
> CAP_NET_ADMIN on a real interface, not a serious security
> issue.

I wasn't saying it was. (It was just fun to test the patch with
a bug which wasn't already fixed/published.)
