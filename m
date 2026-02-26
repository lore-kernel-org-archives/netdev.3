Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4077E372B26
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 15:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118312; cv=none; b=Mv90XCUiJdC6WR6p8WQefq5kp4vY2+SeTuLleV/rSjZPcZcaBxAleIo+TM17ykkz28Qj6TRWp51f5bTKuw6TPNh+ioasa0sHrA58HaZIk2lJeXG6SfsaWnnGC6qrfYe8Sc/GptpRFEp2Wsl/O5x7pMsn3jZ1xkD9A4Bvo325kFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118312; c=relaxed/simple;
	bh=200LdCyQcja9I4GzpcFFWyhPdX9NYk+rNmyQKKm7fk0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jGEjfnk9SGz2MbV4P4JiI/n8bru4DpxCgLdAQO3vTwmFjklPxxlEiZ3+iVSEkReRMsTXfMxdkuh7c9h/mr0OTAMb5dLbMi0QB5ypsnWvc59OyK2KdzMIoHbRdnlklGKXYnMILGbahVx91+PvrsH1pPvbPUi/wCnaN06vtJHP8o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gn46H3YL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gn46H3YL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50ECC116C6;
	Thu, 26 Feb 2026 15:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772118311;
	bh=200LdCyQcja9I4GzpcFFWyhPdX9NYk+rNmyQKKm7fk0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gn46H3YLwillrfzwpYBkGbAGDt6vP0TWuekxiMYVZSXsbMyEEDNKa6gR9v2KD4qtf
	 iPMX9q6qQ/JRnPVtKKIZvSV1nDIuCJK6pF1uGwjq77cF5v9xodqQTo8Nx5G4H565Z4
	 4mITKtpDerWHqEbgDaXLRQA3avGsIpm4Ed3CXehpD6lOp9X7tD0x8g+q9W6D5PqOTi
	 kuwDjD3LCPn4ZO8e7oy8yT9W2XFOzVGiw2P8AW4opzM0D+1WxH8F+82dttnSUB2+7t
	 xLnay/AYwU9JT5i7oN2Ixu+5WOGvqkDD/fkE4H/D8cCJTR5wV5AOxVquYY5Ob8ZHqL
	 pzU+ZmzEfo7Gg==
Date: Thu, 26 Feb 2026 07:05:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Riana Tauro <riana.tauro@intel.com>
Cc: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <aravind.iddamsetty@linux.intel.com>, <anshuman.gupta@intel.com>,
 <joonas.lahtinen@linux.intel.com>, <simona.vetter@ffwll.ch>,
 <airlied@gmail.com>, <pratik.bari@intel.com>,
 <joshua.santosh.ranjan@intel.com>, <ashwin.kumar.kulkarni@intel.com>,
 <shubham.kumar@intel.com>, <ravi.kishore.koppuravuri@intel.com>,
 <raag.jadav@intel.com>, <anvesh.bakwad@intel.com>, Zack McKevitt
 <zachary.mckevitt@oss.qualcomm.com>, Lijo Lazar <lijo.lazar@amd.com>,
 "Hawking Zhang" <Hawking.Zhang@amd.com>, "David S. Miller"
 <davem@davemloft.net>, "Paolo Abeni" <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v8 1/5] drm/ras: Introduce the DRM RAS infrastructure
 over generic netlink
Message-ID: <20260226070509.2c7346b3@kernel.org>
In-Reply-To: <53fc3f6f-b5b6-4ec6-9468-3cd668efb070@intel.com>
References: <20260223060541.526397-7-riana.tauro@intel.com>
	<20260223060541.526397-8-riana.tauro@intel.com>
	<20260224162203.279f7b74@kernel.org>
	<686b63cc-2dfb-467b-a472-b6766b2c8dd2@intel.com>
	<20260225161857.55fd4ba4@kernel.org>
	<53fc3f6f-b5b6-4ec6-9468-3cd668efb070@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Feb 2026 15:17:55 +0530 Riana Tauro wrote:
> > Oh interesting.. that's technically supported but the regen script
> > uses "-o $file --cmp-out" instead of "> $file". If we were to use
> > a shell redirect we override the file each time which makes incremental
> > kernel builds much larger.  
> 
> If i am using this for the first time (not every time). Shouldn't it 
> include the header file (#include "drm_ras_nl.h) too?
> 
> tools/net/ynl/pyynl/ynl_gen_c.py --spec 
> Documentation/netlink/specs/drm_ras.yaml --mode kernel --source
> 
> But i am seeing this include only when i regenerate using ynl-regen.sh.
> Is it mandatory to regenerate after the initial use of the above command.
> 
> >   
> >> I used above commands to generate the initial files moving the
> >> drm_ras_nl.h from include/ to drm layer.
> >>
> >> Even after that if i regen using tools/net/ynl/ynl-regen.sh -f
> >> I see the above diff.
> >>
> >> Am i using the commands wrong or missing something?  
> > 
> > If you use the redirect the script doesn't know what the file name is
> > so it gives up on adding the local header. If you really want to have
> > the header under include we can just add an option for "--no-auto-hdr"  
> 
> No its not necessary to be in the include directory as it is used 
> internally by drm code.  @Rodrigo I will move this since this is used 
> only by drm_ras.c
> 
> But even after i move it to drivers/gpu/drm/. The initial generation 
> using ynl_gen_c.py doesn't include this header even if the header was 
> generated first.
> 
> The header is included only when i use ynl-regen. Is that expected?

As I explained above you should use the -o $file argument rather than 
a redirect of stdout.
