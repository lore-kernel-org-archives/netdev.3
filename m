Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046A64C98
	for <netdev@vger.kernel.org>; Sat,  1 Mar 2025 00:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740788350; cv=none; b=bqoEAOMsgo1y3cpb6MTuCWLIS7TsWIi9DIT2ktrVMbAa9YPXwEPz4WsPxLAfuWUprodrU4urnnyGm7YxWpB+2MyLYRnWFaoK+aLLEsEIRSXFQHDthaSHcK0jdCebKHBZH5Pcla1kiFQVy1q8q4JIW+2ZYiLPuKH6W+yNixJnNzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740788350; c=relaxed/simple;
	bh=dPdLstrfbT7/S+KIZ0mekeNancQ5apILDGFFLCPIHBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t7IqedzG0/iOL2TqDltdPgh4xinXbAp8EQOcBRsLPyTWarsSiHmHA5eaMqYbnvZ7WBlbuxK+tOjYpfUvJPgah3+FguvKQXczXfXauImR/OVOTL9owAzezhwmhxAt8pt9O5FhAjji6lWOmahAjAt3tGgiuS4CHJ4/F6HX9Bqv1yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMhBQ3hf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMhBQ3hf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B10C4CED6;
	Sat,  1 Mar 2025 00:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740788349;
	bh=dPdLstrfbT7/S+KIZ0mekeNancQ5apILDGFFLCPIHBQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PMhBQ3hfOF8bxEHjokK0+pWsCK/8EohL1rQM68MLmtHUzsmbMwnAaOpx3fesyOvKH
	 u4D7JSrRj5i1Zb8CmLmhe8EB10I6eRVU/atdX4B5V6nUDSV+Zhf1siqEDe0CGbGNqF
	 b/ZkrH/d7spGFpWappAXcYL52yjH7Eew11M3MY1P+n1u05sBLfpR8W4kF7EU9sSuQ3
	 4hA2edSGyt3thDeiOTxxxFgu9+B56pED4vn50FDch8EdTL+yftHd0lY5/pN+fDwImb
	 HNM2XoMczWcseNdiAqQnRFq2h0cExHvHoNb3qP0MdNEuL13KZTnF/2rvSnj+INMisa
	 VE7JMu7cvOWKA==
Date: Fri, 28 Feb 2025 16:19:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: allison.henderson@oracle.com
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH 1/6] net/rds: Avoid queuing superfluous send and recv
 work
Message-ID: <20250228161908.3d7c997c@kernel.org>
In-Reply-To: <20250227042638.82553-2-allison.henderson@oracle.com>
References: <20250227042638.82553-1-allison.henderson@oracle.com>
	<20250227042638.82553-2-allison.henderson@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 21:26:33 -0700 allison.henderson@oracle.com wrote:
> +	/* clear_bit() does not imply a memory barrier */
> +	smp_mb__before_atomic();
> +	clear_bit(RDS_SEND_WORK_QUEUED, &cp->cp_flags);
> +	/* clear_bit() does not imply a memory barrier */
> +	smp_mb__after_atomic();

I'm guessing the comments were added because checkpatch asked for them.
The comments are supposed to indicate what this barrier pairs with.
I don't see the purpose of these barriers, please document..
