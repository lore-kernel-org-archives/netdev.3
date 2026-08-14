Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510A142C51D
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 08:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786697959; cv=none; b=mY4Z0Ugsxu9Lb/wP1F7fQguWxWBl7kNvMY2PILI3AmovOnieo2E7SN6l0mrrL5yZhGbkypvwEobfze+5HN0MgWCZnfYTaWpRYms7lxSTzUpcYNhr+tfaZDjnSCyfeH9cAUg7eF18ZKK8E0aCGbTbvg8lR7iLiptdWxhcYCl7oCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786697959; c=relaxed/simple;
	bh=ZiqjF/AGyQMjbQYwni2wOT4pZgwDwnIuchRheZ8+iKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3uNlbSeV03M5UKufG3CRBTs5e9lb2Kgeg/ABpCf5Y35bcqOF/s8oG6ghFxvmaivgRDAewUpMvMeYIiRd3IrSb270y/RlqghwOsbVhITTw1CvDTP5vH6SDRcWzYysanLpIyVrnhmSZxXQ80aYUWxz7/VmABnEDn26VVyz0mtmoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnOzR989; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnOzR989"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E15F1F000E9;
	Fri, 14 Aug 2026 08:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786697956;
	bh=9XIZceZi/Vth8ThKEJJfdNlyvXugHG+VbBwkmtjj7Hs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FnOzR9891i0yO5BqTHyAOG53NRbJ2nXAVdCxd87AVyQ1TpPlh1Fy08Pizi7hSdyWc
	 ukYnjzLiT3oVBWKkBb6OYjCZYrfgg/9FFHL8uZ7W4xHBT5ZMtdU7dYHjMkielCCei3
	 bBzB0VHThQyhGcNz8GoLBYPzkc37BIJePKv3uCqQUcmiNDENk2VsHu9erKXhkvx9Od
	 4b6P2SQ+1ePArCCV/O0YEU79Pmanpf/2XTedP++pv4qx+cP3xdiO3LNWALhmO+UUIJ
	 T35CLuR1PLBlsH5kBUWFL8qAfMur0MGSmYo0rcvoarfYmUMmtqrYiumdO/r/fYaAMD
	 FtkmPUMTprNeQ==
Date: Fri, 14 Aug 2026 09:59:14 +0100
From: Simon Horman <horms@kernel.org>
To: Dave Ertman <david.m.ertman@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] ice: Fix incorrect LLDP
 filter assumptions
Message-ID: <20260814085914.GH265046@horms.kernel.org>
References: <20260811181127.1142095-1-david.m.ertman@intel.com>
 <20260814080709.GF265046@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814080709.GF265046@horms.kernel.org>

On Fri, Aug 14, 2026 at 09:07:09AM +0100, Simon Horman wrote:
> On Tue, Aug 11, 2026 at 02:11:27PM -0400, Dave Ertman wrote:
> > In commit 4d5a1c4e6d49 ("ice: do not add LLDP-specific filter if not
> > necessary"), it was assumed that llpd_fltr_ctrl was a unique application
> > of a filter instance and the other command in the flow was generic.
> > This is an incorrect assumption, they are both meant to add a filter to
> > handle LLDP packets and only varied in the actual AQ call made.  The
> > newer AQ call was created to handle a special case in some NVM images
> > where a LLDP filter was already existent and the old AQ command would
> > generate an error if a new filter was attempted to be added. The newer
> > AQ command would detect this case and instead would add the current
> > target to the existing filter rule.
> > 
> > Fix the flow so that the newer command is always used if available and
> > only fall back to the older command when that is the only solution.
> > 
> > Also remove the obsolete state flag from the PF struct.
> > 
> > Fixes: 4d5a1c4e6d49 ("ice: do not add LLDP-specific filter if not necessary")
> > Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Sorry for the duplicate, I forgot that I'd already sent this yesterday.
