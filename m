Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7926474267
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 13:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629561; cv=none; b=uvIkYrBbiV00CWhCbp4OxZ17L4uoa+9iSjJinACUq01qdNo/2/xQ16wbCfUNWVFifJBmaMMHFSyvVm6u/Kdgl6toxofXDcndyo3llX6D6UIRnIWGl0Zxm9pn+8yUTPlDI8oQ//+72BpdPTjq5URpMkPDEalOX3kNbDjZEZuobgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629561; c=relaxed/simple;
	bh=Qx4LScBx71WFu++/USfAsOmtzilPUJrY4828cipc2EI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8G//hamoXZF+23h7RXX5XKxdN6pbmuXvkAM1O+/PofflTHrC9k4KZfCEJUamzuk0gJNqSuRr/poKQidus9UKTV5oy4OTVfoNI2iayhQQA3Y5WvN38Po9oauDJUf9wgRTn6/hz6GUl9Uf/5idg54BVDGw01EeZLRWguB6QL1zbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OafavZya; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OafavZya"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C151F00A3A;
	Thu, 13 Aug 2026 13:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786629559;
	bh=O2KvK+dDWD+lxggjkeFjWjKL6VrmWECW2QAh9Fd6p8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OafavZya8KFKh3Gg3LOhqKz+WkmMIMr1SuUwv+mr+wJik4AthzfHWiTjr9eOrVuJx
	 z4WNzDnndpsiyXXjJNJrm0bhEbANBTRaIYEs4NgnQBtj/YMLCWhi7a5U/4edIdSeAl
	 qzmD1DTBQp+Hd2vJHEXv1U1rxDzkthlF6udb/NYf35I5WFyah8nUAj7+X2a8NlU/KR
	 5x5HARqvQGMBIXX59hzY30+Ko5j58ZpaIPPuVRK1hC/AFDGutBHaDXA43cl39i1Gmv
	 nnSOLklkmBDgrf8tLh2psyxhg98zWJ2aCfi+c+iPKO8IB+TxRo/ag6JQcjKvC2tNNO
	 c/iNg4H+0M2jQ==
Date: Thu, 13 Aug 2026 14:59:16 +0100
From: Simon Horman <horms@kernel.org>
To: Dave Ertman <david.m.ertman@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] ice: Fix incorrect LLDP
 filter assumptions
Message-ID: <20260813135916.GE265046@horms.kernel.org>
References: <20260811181127.1142095-1-david.m.ertman@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811181127.1142095-1-david.m.ertman@intel.com>

On Tue, Aug 11, 2026 at 02:11:27PM -0400, Dave Ertman wrote:
> In commit 4d5a1c4e6d49 ("ice: do not add LLDP-specific filter if not
> necessary"), it was assumed that llpd_fltr_ctrl was a unique application
> of a filter instance and the other command in the flow was generic.
> This is an incorrect assumption, they are both meant to add a filter to
> handle LLDP packets and only varied in the actual AQ call made.  The
> newer AQ call was created to handle a special case in some NVM images
> where a LLDP filter was already existent and the old AQ command would
> generate an error if a new filter was attempted to be added. The newer
> AQ command would detect this case and instead would add the current
> target to the existing filter rule.
> 
> Fix the flow so that the newer command is always used if available and
> only fall back to the older command when that is the only solution.
> 
> Also remove the obsolete state flag from the PF struct.
> 
> Fixes: 4d5a1c4e6d49 ("ice: do not add LLDP-specific filter if not necessary")
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

