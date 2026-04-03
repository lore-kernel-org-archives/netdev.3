Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D61A18AFE
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 13:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775224004; cv=none; b=bc9wY4SjFauAc5/kdz0eA/lZXw4DKlu7CzOtU+XUXDALLBM/SXfLvkqq1B7PTv+/bWUPIiRJygEkU2IauciJ+p+QiAgmLmIq/ijekSZsqt2/fHbg9BOKMjk98XvmMb/B5gt9uRpl3mZI5yUmn3h8K+SkF1sFAZXzibQ94jpS/Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775224004; c=relaxed/simple;
	bh=dhORVKWFgjtVArpJ/zyWhD6ZCl+KA8tWqkp4buwBhVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRcOq6/3nt05n3fepNRxkhRhQeippXzYCBnD7Ucm9bwXWiVpKMcV821/O86aMZq0JyxQvi0WjHgDMm+Mdd+90JgNdj5t7zl4e2JddKui40bho0bGiVUEIlGMdXZM7/Blp5CyqPDSfHu7173C8QuHWGjW+vLXHrvGpo9wDofS2ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=td0Sco6p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="td0Sco6p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2F8C4CEF7;
	Fri,  3 Apr 2026 13:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775224003;
	bh=dhORVKWFgjtVArpJ/zyWhD6ZCl+KA8tWqkp4buwBhVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=td0Sco6pI+LxyaIhFPmXSLmUkKKwdApeH2C2hVh83THoIuY85J2eBJ2r4F5l5UNMn
	 F8tOC1z5zuCKJrd2ZmDV3DcJH7CV4SHKLPcMfZJnzK2qXc+319MlYKxVzt4i31O/3Q
	 1JlmkYIre6WzEO6NbaJbSnE/Sy8M9fNKyuRhnRCGfG59f0/ZV3OC7syhptbDxYhPXv
	 5pA8iyVmjkxqkrKRhzXpyDFRDZVJNegQuC1Tenh+Mf90FS50jqJhncnQ1ZZxkPHht4
	 EQvtcSaJ0RQDRFNKZgyvk6z7FS0EVwlUMDllVjJvN20HvQcoKdHBUgdmXy/RDapie3
	 eN6Oa/WwJlomA==
Date: Fri, 3 Apr 2026 14:46:40 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: Re: [PATCH iwl-next] ixgbe: fix cls_u32 nexthdr path returning
 success when no entry installed
Message-ID: <20260403134640.GG113102@horms.kernel.org>
References: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
 <20260327073046.134085-8-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327073046.134085-8-aleksandr.loktionov@intel.com>

On Fri, Mar 27, 2026 at 08:30:42AM +0100, Aleksandr Loktionov wrote:
> ixgbe_configure_clsu32() returns 0 (success) after the nexthdr loop
> even when ixgbe_clsu32_build_input() fails for every candidate entry
> and no jump-table slot is actually programmed.  Callers that test the
> return value would then falsely believe the filter was installed.
> 
> The variable 'err' already tracks the last ixgbe_clsu32_build_input()
> return value; if the loop completes with a successful break, err is 0.
> If all attempts failed, err holds the last failure code.  Change the
> unconditional 'return 0' to 'return err' so errors are propagated
> correctly.
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>

This feels like a bug fix that should be routed via iwl-net with
a Fixes tag and some description of the user-visible effect
of this bug.

Else, please clearly state in the commit message that this is not a bug.

...
