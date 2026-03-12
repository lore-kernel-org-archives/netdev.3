Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B723A4F2C
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 14:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773326547; cv=none; b=hwM4EbuLr1xPBZO0/SXE5fbJfqZULMM4D5RXSLwsBh+UZC8FSYO0D+2mWJRoIKisZQdguq2Z+3zaQgWphDSMMtuurCsOjQl6rZs3/4tZdHqduEUOD3SRd8bczO3D1BH5irPuvx7Rm9TMzQ39c4P7xRbIlz/o3LInVjWuezvcRQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773326547; c=relaxed/simple;
	bh=6Qr5Lqzt2TKO4ndBM40+Rf8eOWfEXXbUKDK6Jz+dC7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eYJsT/mDIgQ9McG4fWZMivAtqiENbHuETRlem417FqWCPmUTt6ognZhpYgidghqBPpl+yvd7GUPFNo0hpHCD5Z4rhf/i1JKYaf+srewkRzrLgRDUsaRgwEaMt4wK4yMgSyRpBFtZPoFxeBVQreP1gNZkRx8CJluATlkJBem5tUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpMxmg5U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpMxmg5U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919D0C4CEF7;
	Thu, 12 Mar 2026 14:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773326546;
	bh=6Qr5Lqzt2TKO4ndBM40+Rf8eOWfEXXbUKDK6Jz+dC7Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bpMxmg5UOAiMC6OE7QbjMoUeH54aXEm+/rIn7I67Jte7+lCVTSt8PNv/SK/2PgcJ1
	 7NnqyTBM3or2V3JebBnKcKwo9q4AFoIUKqKNTvuAThRp9F3MmA6LpsRhyniNBCkxnd
	 a8EPBFNOG3M34p9mANm+KD3SRHwncDo0Umyp3ZBBQMgLk+DrOcKZein6OEVjdmVxoK
	 Wxs70TUQvDOL3fYvT+C9Bp4X9YvAK+si0DtWrPjV/QOBvQDs18CvxZIHGOEoDAsCtS
	 afLceEvdHAJ9NExeK9ptPZhHzoj4Ts+IytMXDssGBM24hQ6fCQrG7amoWN0ZV1t7SU
	 qPo5WmV+bZ/4Q==
Date: Thu, 12 Mar 2026 07:42:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com
Subject: Re: [PATCH iwl-next v4 1/2] ethtool: treat RXH_GTP_TEID as
 intrinsically symmetric
Message-ID: <20260312074225.27a4a7b3@kernel.org>
In-Reply-To: <20260312093101.1589970-2-aleksandr.loktionov@intel.com>
References: <20260312093101.1589970-1-aleksandr.loktionov@intel.com>
	<20260312093101.1589970-2-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Mar 2026 10:31:00 +0100 Aleksandr Loktionov wrote:
> +	/* Strip TEID before checking - it carries no src/dst asymmetry */
> +	rxfh &= ~(u64)RXH_GTP_TEID;

No need for the u64 cast.
