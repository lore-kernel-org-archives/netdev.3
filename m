Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0F942C511
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 10:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786442647; cv=none; b=g1DuAvt8yYc4qX/RaDZxbx3E5bdsCOUE6RaS4cfz88x4O23BC+BsEDUY30B1Wh3DHNgeqrKp9CNlmpGvqPYF5ORR9v7Rk5ZmAglfebK/w5XntXcqHSW8b7jS2ckLqnkotReCrb8ypgFxFIYxclJuthCWk5DS+2l/WXBW8/bLaWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786442647; c=relaxed/simple;
	bh=ysysp3yIZz2SxofpZmT+sO47G/4wKYWs/9yRLsRfSqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=quyPGFP2S9dNWK9HpDXCDuK0HLyQI1zE1wiAKAu+L76qpiDZQGaakGG3DBsPaW6ZnEjzq5G9NmGcTcFXzOWeIuHXjbgzsMEIjF3CicR+eVb7QSFgERNI/pAP3IZfW2IugpQTKrth1HfftICFkVoNdfTLP37/V4m3miiCGebt4R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=BvWIFWl3; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="BvWIFWl3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Jr+RY+ZxZSaCBW1arh8puWLtGzveQVnAkJoERCklgP0=; b=BvWIFWl3KeOfQbCjZ1TouC3Qbn
	mAzqq3kd5LaV//lGpbPyUC5NEzxpFGLhVxUFVFbC1YDddrq2G4/RZWqenVyErXgdAv8ikLakpt0Sx
	DWjsqoCHLrtYib0yORUBj1KyKQ8FOMmtuFCbVVIC8GrtAfG+vS1OFsg5MU79Y/DDjfuUbdPY4vKtR
	XKa8JlI6UosIuKBpAfZCTPV8DGSgjUgGx12iTxsEacX23WZsxOaME8TdCT8Ui/o8aV+/QpL4HImP8
	gKZVjsFZE+nR/pXCQZNHvRR5Mj08hwRNYc6mlTt4Rpf+s0P6aQJn3YOG7F8Vf0pOLk6P3BW8sjNv/
	Ot2iFEHQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wtjKs-003UB2-1M;
	Tue, 11 Aug 2026 10:03:54 +0000
Date: Tue, 11 Aug 2026 03:03:49 -0700
From: Breno Leitao <leitao@debian.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, Kees Cook <kees@kernel.org>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Larysa Zaremba <larysa.zaremba@intel.com>
Subject: Re: [PATCH net-next] net: libwx: rename wx_pf_flags to wx_flags
Message-ID: <anrzfWvCkNTLPbmt@gmail.com>
References: <D43B3418D188B057+20260811065038.58345-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D43B3418D188B057+20260811065038.58345-1-jiawenwu@trustnetic.com>
X-Debian-User: leitao

On Tue, Aug 11, 2026 at 02:50:38PM +0800, Jiawen Wu wrote:
> The flags defined in `enum wx_pf_flags` and its terminator
> `WX_PF_FLAGS_NBITS` were originally named with a "PF" (Physical Function)
> prefix. However, these flags are not exclusive to PFs and are also
> utilized by Virtual Functions (VFs).
> 
> Rename the enumeration to `enum wx_flags` and the bit count to
> `WX_FLAGS_NBITS` to accurately reflect their shared usage across both PF
> and VF drivers, and to prevent potential confusion.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Breno Leitao <leitao@debian.org>
