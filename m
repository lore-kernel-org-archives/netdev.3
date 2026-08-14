Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EE341D12C
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 08:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786694835; cv=none; b=kTVTPaDFTOT4o8pmpaWWNKDCbS8v5r6MBgGKn4mPWr599tMT5WuJ1fIf2oz7nbc6LYSFrtk4tq1B+jYK6ERBBFX0VX5lnh+IXER78LK9/+iwnliRgSne3cauqxCndzwAHp9tlICMyAECssVResMg90TJHRt5bKcrkgp0Tx4vja0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786694835; c=relaxed/simple;
	bh=Qx4LScBx71WFu++/USfAsOmtzilPUJrY4828cipc2EI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5xlWX4DpIjTqRkTilUnREmi5vC5jApaJM8btnjzDFT9atGBBRbuK8ebTNueOUSgV7vRsyiM9HieqixdFluncVzfRyLtDes6DYswr0QNcTm6Y8O1Vk33+K4pc9OY10F7fhhDmAgoV1rSdCZ7kwoehOjL3BPK2V/98jhh3mUMxuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oqw68CnD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oqw68CnD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D121C1F00A3A;
	Fri, 14 Aug 2026 08:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786694833;
	bh=O2KvK+dDWD+lxggjkeFjWjKL6VrmWECW2QAh9Fd6p8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Oqw68CnD/2E21tXqxDG4JzzNMlTCe5opETTVeoyA/RJiIDbJie0HV0g81Is5cT2Cb
	 nX4Eu4y/yiVSv50nH/sLk/YtRoyjDui05afb06saBvIxGswSIjNE6xMoGzoVXxLebH
	 nChijFRo07KX7FKVQxKFwlyJN6kyvAtn9BPf/9vA+W839itprAT4wH9fhhd4qLdIz+
	 AwWFOZQQay39XYev3HiappYIq1PAfhEWfN2qyGVh9DWI/4+wn95sEvCUrGWx3iPXs4
	 sdN5UC7B5vo63Vd8zTU7lL8wbOnZ/4tmvlxfd/CXcvYXQtRntBE1TWyxKDn16+E1UX
	 FSZYYO2WMiZjA==
Date: Fri, 14 Aug 2026 09:07:09 +0100
From: Simon Horman <horms@kernel.org>
To: Dave Ertman <david.m.ertman@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] ice: Fix incorrect LLDP
 filter assumptions
Message-ID: <20260814080709.GF265046@horms.kernel.org>
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

