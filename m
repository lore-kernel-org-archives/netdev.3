Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33F43F12E4;
	Wed,  8 Jul 2026 15:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524533; cv=none; b=PzfV1Bd+fcevfQ+TYN9+4A8W2d+hr2jPt7Prq74vm0qSr4bdYvwYWiL7/ibmCX0hd2cNBv//JHNLKi3FFpQtQw6/DJie/QSowyJRkYWqcDzeItBMHh9geprD6pbe73gKc5L6rldchVtHFPsciRaEk2P4yk/pH5vCUtfMNv5X7uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524533; c=relaxed/simple;
	bh=1ju68Xv/NlzZW//1sBD79uM3omaujy+mnV+pNBjuuUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbNmjCQeIP9zLX21UBS5FiO6EP9FXXnmMzUmlkC/cuLcA45yFj0ck/jBfAzvFYjBco+hyBsDx3R4An8KqXigS2QqtXH79q7rfRBPQuW2s63o+w8tZx/fevQRx+k2qaFk3imq2XXfXctZTyZxIkA96pwHL41JiywrPtjdFslk69I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=dzkd2OQ3; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="dzkd2OQ3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1ju68Xv/NlzZW//1sBD79uM3omaujy+mnV+pNBjuuUI=; b=dzkd2OQ3ZsiyvJsUAsdLfm+6sm
	qA3P/1H8aWGrS2pt7Dgn1YFPB7flBNCdF/3FGFiEB1arva54JGo5cUQTEJ/S5XsX0FPJQLrO3k8xH
	+WZUYC/yEb7uNSxFuQu/yexNHCtaQfHFEn72fummTIUK+fiqxGcd1SXs0JbYY4gQAKPtId0Kto6qE
	wlF5QluNdETfauSRoeJg58q15zdg5FrFWB6laYleujHfpEcbgNnjxCUi6H+lxMqcxHNwMuajRO9GJ
	S0L/HOOg2zId1427jswtOKFv68jy639LF0t64x1ojQvZ4ulDmv6BIa7DjYxGyMPIsj6YIuuC5iZx6
	MfPeiRDA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1whUCX-0032iJ-28;
	Wed, 08 Jul 2026 15:28:42 +0000
Date: Wed, 8 Jul 2026 08:28:36 -0700
From: Breno Leitao <leitao@debian.org>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com, 
	sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch, corbet@lwn.net, 
	kuba@kernel.org, horms@kernel.org, linux-doc@vger.kernel.org, pabeni@redhat.com, 
	vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com, edumazet@google.com, 
	enelsonmoore@gmail.com, skhan@linuxfoundation.org, hkallweit1@gmail.com, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v21 net-next 01/12] net/nebula-matrix: add minimum nbl
 build framework
Message-ID: <ak5sjL21NQSWDB9S@gmail.com>
References: <20260708064742.35391-1-illusion.wang@nebula-matrix.com>
 <20260708064742.35391-2-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708064742.35391-2-illusion.wang@nebula-matrix.com>
X-Debian-User: leitao

On Wed, Jul 08, 2026 at 02:47:27PM +0800, illusion.wang wrote:
> From: illusion wang <illusion.wang@nebula-matrix.com>
> +Support
> +=======
> +
> +For more information about m18110-NIC/m18000-NIC, please visit the following URL:
> +https://www.nebula-matrix.com/

Do you have a link for the site in english?

Thanks
