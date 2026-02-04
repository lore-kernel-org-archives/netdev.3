Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4F03D7D94
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 10:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770200960; cv=none; b=Etz3KLfCvQ2WHMtc6U6x///kh+NQOYQ4bg+n2lZJ4DKRTvjglSDoCXLE4Ep8Q328d032mnGRF/g2U+zVj6pCiIYLkay8lz8Xetjznrp+YG77W2tTsS1c4WPB4vqaasxSZMhgJVzkLUJWblmBYkhIAs6R7g+jaZEt2NrNdoLWhb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770200960; c=relaxed/simple;
	bh=kJqMcwbZsco3DykrcuTlzy0g2zNDqIBy9W4bsxhrGfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/ZlfQapuzel6QZNnJ4PuXiqcz5YHsyn92agPyke8iesgQJSDe4GZ5kC0Geyb/uRTWLeNuC94s+iIDbUfS9fFGe+5el/57/mDkNsKU7oGEA7hfd0TrurdF6fEMPikY91dsJdt9ioX9WoW6BAdJhFmbrtJTLLTvZPUrDaFSjek38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugzf1akZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugzf1akZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E43C16AAE;
	Wed,  4 Feb 2026 10:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770200960;
	bh=kJqMcwbZsco3DykrcuTlzy0g2zNDqIBy9W4bsxhrGfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ugzf1akZClvEEwvzlAn2Y8+gS19oFDpMqRFCjokvnJ4Fzcw6X3zHRiNi3cwZD3sbW
	 9Vxw7ROSMikEapXdvH2sYuyA6ptV6DGnz17oKo4OpihVIfXi097baVtxQDqJqqrk4V
	 0cARHfxWayRwU4YI4wdIn7JHPbTKravtxtjSfqp2VCRpFoUTbw60qMRbYN/vk051BD
	 sfQ62epSGXvDJ2tp5g3+hGVdU0e3CeIdpGkXCJ8FkMpSXxSBnjTTf6NvyEiGe0obFq
	 nSFvBICxUSRnUKzzI1S3XkDAg6JGkHVDfItOWSrUu2gz8+wDdEGaNZgYoNWXmDf2WC
	 t2UoMBUTwP5jg==
Date: Wed, 4 Feb 2026 10:29:15 +0000
From: Simon Horman <horms@kernel.org>
To: Kohei Enju <kohei@enjuk.jp>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vitaly Lifshits <vitaly.lifshits@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	kohei.enju@gmail.com
Subject: Re: [PATCH v2 iwl-next 1/3] igc: prepare for RSS key get/set support
Message-ID: <aYMfeyYpFJ87TOlF@horms.kernel.org>
References: <20260131163037.88108-1-kohei@enjuk.jp>
 <20260131163037.88108-2-kohei@enjuk.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260131163037.88108-2-kohei@enjuk.jp>

On Sat, Jan 31, 2026 at 04:29:36PM +0000, Kohei Enju wrote:
> Store the RSS key inside struct igc_adapter and introduce the
> igc_write_rss_key() helper function. This allows the driver to program
> the RSSRK registers using a persistent RSS key, instead of using a
> stack-local buffer in igc_setup_mrqc().
> 
> This is a preparation patch for adding RSS key get/set support in
> subsequent changes, and no functional change is intended in this patch.
> 
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>

Reviewed-by: Simon Horman <horms@kernel.org>

