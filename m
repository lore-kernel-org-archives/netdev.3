Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FFA70818;
	Fri, 15 May 2026 00:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778804077; cv=none; b=TKsgBsZZHLtBDlNegWtm4Z78uvzFvDeI41dmYacCjiy38yL/a9o7e2k/F2xe+cQyAlnDp+yaqqD5xUGMkyWtG/+5u5av5TBCGhddeJww2PnuXItZhWicOC6S7xJdSPvWnoTjzB4htdraLh4deDeLbhxfa1lGa3TKopnNRT9Kr6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778804077; c=relaxed/simple;
	bh=RK4Vq+dmrSCj6fWFvDRaTdOqSaIk/MDA7iUmkXXKjmI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pqlMyt6ndZtbSt5jfLfURCRkdwBUBNFdzNEb/HK/lToDftiTVpLEn7bBDKLwSKKGmP6DVuTHmxoXkyGopt9PRY+ktbYLMP7/8YV2GwqdKrWyGl5loPiUaC7nuOYnOwsrJmmVJKV2K6+SmzP+OknI8HaJeJfwgHIFtuU0E3wfiV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrexBl54; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrexBl54"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0977C2BCB3;
	Fri, 15 May 2026 00:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778804076;
	bh=RK4Vq+dmrSCj6fWFvDRaTdOqSaIk/MDA7iUmkXXKjmI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jrexBl54pJ8RTXsAX/Kpd+76mDt6+B3jopW9zWcqkFz8DTdjR8+zbAZMGeWI9VqBj
	 aXDZUSMRDuiVuI2XhtUrK4JuCpW+LUfdWvnA3d0P7zM3yDPkeYbxsjOBFxg0dkDw+l
	 219ACzox3oH3MyM9QL6hYQ6rfls/2BLFWarSWoJMNqLLcwr0BoK1pE+ysOfPFtXuZw
	 +KJ4+0fhGIuBvCElTFniwpKFyQL6g8wQT2eDOqPd+NRUCWChg2EBSNBdaPoDQW/yUa
	 BuC4mDooCC+f1QQR4F1NoMj+LGR4Jwct/yHB96M1FumETBknWWeIyVHcvl8HQHELkO
	 eKdW37DxcYklA==
Date: Thu, 14 May 2026 17:14:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jakub Raczynski <j.raczynski@samsung.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 net-next] net/sun: Fix multiple typos in comments
Message-ID: <20260514171435.385932bc@kernel.org>
In-Reply-To: <20260512151931.3576906-1-j.raczynski@samsung.com>
References: <CGME20260512151955eucas1p16e090b7d76aea8c5e37d7c401a21638f@eucas1p1.samsung.com>
	<20260512151931.3576906-1-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 May 2026 17:19:32 +0200 Jakub Raczynski wrote:
> Also fix double spaces in lines where typos are fixed, but don't change any
> other double spaces, since it would obfuscate typo changes.

Please don't.
-- 
pw-bot: cr
