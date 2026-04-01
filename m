Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A393382DE;
	Wed,  1 Apr 2026 19:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775070068; cv=none; b=Q3xjrlw9Kv6z/ZZuPqDHyCOp94kobRdq9+z9mudVOAyw0J5vZ2FK26GmfMCZXT3XCaJT5ZQzdi5cORKT3Bp7cxMXyPXUe1+KzUxCLlLNYG5mRr1gBLbLCYNlmOBDqyMoVdmuvFaVGPOr00e0xaeKtzxPuLdjQ1ky3Dhiqr8m+HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775070068; c=relaxed/simple;
	bh=uvh8oOR8f012iFbqSPUUmUgjDYv1sLltGScE5WU8BrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6G1LyV7UF7kh0AY1xXDEqHh9ezsqi3AmKqfGLoZ8B8Tft8Pqtj1CubkD27RKljhXXpyCLeO7jQwy+i8+pNa1Mv4q0xQ1fwRymj2nSNyx13Fddq84Xoe3+GDtfX46MtWHI9Dbfbe4/05SxU9gpuW/W3ge89vXdg4709H9zBV0Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=x867PCu2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="x867PCu2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8MpH8X6sjaPrUpqh7/He3PqKvB7B8nmD6tdg+fBP6uI=; b=x867PCu238MpZ7Gonv8MF+FBKO
	2R8qti0IOEIscNfG9s4Qhcov6/9FV8f3bhiwehCJWt7Pt02/SrmPE7bHADzj/hWFfnD5eowxG7Fnp
	Py9i/cIc8Zo0lTwCEh2fh3UzfMvHQXOZQr7rMdglK8kyoDBY/PL6yVvK/rQ/NeSQjQo0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w80o7-00EP25-Ha; Wed, 01 Apr 2026 21:00:51 +0200
Date: Wed, 1 Apr 2026 21:00:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Jakub Kicinski <kuba@kernel.org>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/2] r8152: Add support for 5Gbit Link Speeds
 and EEE
Message-ID: <f308c593-a186-4a2b-ac4d-78491d6e7255@lunn.ch>
References: <20260324-rtl8157_next-v4-1-034312b12de5@birger-koblitz.de>
 <20260329193449.2764517-1-kuba@kernel.org>
 <50dc7e8c-6c6d-47d1-866e-677638b4deaf@birger-koblitz.de>
 <20260331175649.729e60a7@kernel.org>
 <59b4be26-1fee-40f1-b9ff-45881cddc7df@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59b4be26-1fee-40f1-b9ff-45881cddc7df@birger-koblitz.de>

>  One thing I
> noticed in particular is that the AI does not seem to take into account
> that the code actually works: suspecting broken SRAM-access or wrong
> descriptor-size settings would break the driver at such a fundamental level,
> it would not be able to work at all.

The flip side to this is that we get a lot of patches which are
compile tested only. So assuming the patch has run on real hardware is
a poor assumption to make.

We humans however do have a feeling about who is submitting the
patches and how likely they have run it on hardware. So we know to
look for fundamental problems or not.

	Andrew
