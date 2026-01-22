Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1557D259CAF
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769095741; cv=none; b=FgFhg01h+9UPkfa5cEAZlTcbcyqcIcJaCOuMB0f98GfVQx6BVr3ppJ0WiqT1JcnXkkD0/tuSgiF3kFE2gR0OEPg6vvWJK7tdjSU5dxP8HJKufE4PfbQBeNTVoXjHh/GS4Us3os9j8lBrNmkUJIOH9+wQzCUl68prbfVo+T0lyaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769095741; c=relaxed/simple;
	bh=dEiBGlsD4gpRdVxjCcq+07sVoFNHxQjESs/rev7O2Qk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VBzn0R4qJAgy/MT4l7kjxJPqdfH0qpBqoPc6kmFALQsmHkDDD7IWW2oyAym1WEqLCaagVwonCKaHAHZCp+G5YDPWTf7r4V431EMy2oZoHVPPk2iav8LODhLE7o/SLwf3DuGdU0Tlw6HTOLg9k5VdmeUX++tF2sWQlo2yvIHBzF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPhescQY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPhescQY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4097C116C6;
	Thu, 22 Jan 2026 15:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769095740;
	bh=dEiBGlsD4gpRdVxjCcq+07sVoFNHxQjESs/rev7O2Qk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qPhescQYwKn+qdqA2JkiaMcalARkgHELVxCtAQaJLeYMqiLXHSZvhKzNOue3r9O/B
	 UoBP0sTtVMQqO9lMfNN1RtGZ79gbVHQ9KRSKLd1MSMWmrlfkp5iYN0OwO/M3rTH8uU
	 bsK+w6L5hrP+w1RImxRR7M0mOSOvYdVc+ux5qh9vEylkSFG3nVtca0qIBuyKDXAlgW
	 95is3v0cERyUH0Jd6tQ2OxxY6NiHBeX1v0IbPAcNiEa1gcgvaoAVM5pecHGXP73dpD
	 dQ2NTp7CsE7ORDja9bHz43G5qfZJyhg/STrj9cVDw48g/xne8Mcug02DYHU9agaNGC
	 hJAJBUI6XSPTQ==
Date: Thu, 22 Jan 2026 07:28:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, syzkaller@googlegroups.com, andy@greyhouse.net,
 eric.dumazet@gmail.com, pabeni@redhat.com, j.vosburgh@gmail.com,
 davem@davemloft.net
Subject: Re: [net] bonding: annotate data-races around slave->last_rx
Message-ID: <20260122072858.2b652eb7@kernel.org>
In-Reply-To: <CANn89iLK1saW=7jxhtew_skR-rPPonFi71brvTApeKM5VVadiA@mail.gmail.com>
References: <20260120152856.1694824-1-edumazet@google.com>
	<20260122022237.2529455-1-kuba@kernel.org>
	<CANn89iLK1saW=7jxhtew_skR-rPPonFi71brvTApeKM5VVadiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Jan 2026 05:42:55 +0100 Eric Dumazet wrote:
> > This seems like the same concurrent access pattern that the ARP IPv4 path
> > needed fixing for.  
> 
> I saw this spot, but determined this was used at setup time, not in
> packet processing.
> 
> I was maybe wrong.

I guess if nothing else we should do it for consistency?
