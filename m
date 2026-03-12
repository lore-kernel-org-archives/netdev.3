Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22C033B6DA
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 00:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773275354; cv=none; b=mGVnBC3D7Q6HfaR9EUSCajTTZ+sCytz+jJ/fST/DyK9s9p/C/oAJCwJSV2g7xJ9RjajXWw0xYtfBZFTP8l8GZJj1aezfLeS53xG0vd0T+ylpWpXKwUAumQLPV52k7pV3ubqi666ZFi/n6yhSI3NIEcQ9gRFJEu1Ru+e3Ee/R5vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773275354; c=relaxed/simple;
	bh=IoR6lqedT9ZLR/3Sp34HdPCvvTBO8x+GArpju4CwWa8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N5+Y9m7iqIfncsqH1tbXBdiRFJOuKbXq5l2269JA45p9GovdztJ/VTDNOddmx4MSY6YmHhooTxm/o5qaawTI3bmMI2aiK0DUV19xTtLTnG/IXVCY8J5i9AMjLBsRbNTXKB5268yghh4rZ0EkKQdKBenDfNSOSExva+Im92EQ0XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kspXrAFA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kspXrAFA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF247C4CEF7;
	Thu, 12 Mar 2026 00:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773275353;
	bh=IoR6lqedT9ZLR/3Sp34HdPCvvTBO8x+GArpju4CwWa8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kspXrAFAbogg3zaGMyeN7CcnfHo/BsvM4ffIYWlFDykGHvOy0wTuwpFgeCJo017oA
	 EqGftW69oUQH+g/b69shg8LVok3mdp4ctYFd9p8hfJMdUPj/iPUWWzp4S6bvAET15z
	 Ivx3rQIfLK3v8O5yunbRR43gAeg2shU3H73ryRjzLDLambkg7Tk5mRpDhWbNiB+6Dg
	 mBVhs5TIHeHf/T669KC0MLbfYLoNOFXNEo+2jGTkmT66sJikwOrfwmI9iFyGdUgC0R
	 N2NHfaK/zppW+eDdGD4NQprTfw3sDXBCRJUQobHtmZrZ4hLNdttCkc/vOerru+aUOM
	 kuJTxu4B3cZ6A==
Date: Wed, 11 Mar 2026 17:29:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Riana Tauro <riana.tauro@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org, aravind.iddamsetty@linux.intel.com,
 anshuman.gupta@intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, simona.vetter@ffwll.ch, airlied@gmail.com,
 pratik.bari@intel.com, joshua.santosh.ranjan@intel.com,
 ashwin.kumar.kulkarni@intel.com, shubham.kumar@intel.com,
 ravi.kishore.koppuravuri@intel.com, raag.jadav@intel.com,
 anvesh.bakwad@intel.com, maarten.lankhorst@linux.intel.com, Zack McKevitt
 <zachary.mckevitt@oss.qualcomm.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>
Subject: Re: [PATCH 1/4] drm/drm_ras: Add clear-error-counter netlink
 command to drm_ras
Message-ID: <20260311172907.0ac81a25@kernel.org>
In-Reply-To: <20260311102913.3387468-7-riana.tauro@intel.com>
References: <20260311102913.3387468-6-riana.tauro@intel.com>
	<20260311102913.3387468-7-riana.tauro@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Mar 2026 15:59:15 +0530 Riana Tauro wrote:
>  Documentation/gpu/drm-ras.rst            |  8 +++++
>  Documentation/netlink/specs/drm_ras.yaml | 13 ++++++-

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
