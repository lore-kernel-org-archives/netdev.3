Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A573C2882CD;
	Fri, 14 Aug 2026 02:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786674545; cv=none; b=dUJ6gGUmBLX/Ajtlxtq9OWgKuq+ZTs1SypoyfV/M2ZxQjlkNkrSjhE7Up0CARl5VzjKUN3MDT4k/G6FONKyIWqos6mZr5plLwYq+dhWJTQW5/W56zhEyLcmUTabyZzo0eid11rAQ8PKE2z4Aix/ajodEIFH5IYFGvN+AIvIB2v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786674545; c=relaxed/simple;
	bh=AxBb9YAIlWppSbcEhoQDKw6qFZOV/TonZe4Se+sDc3A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DPMStfYP57AMLEjuZmaWsvK3Ky9fFzo67g9YLzF6YR0jHn+x8aByVj4BppTekVF7l3ij3kjyYmjPxtqu8Ri+6aqN8OXXXjY8S9W9JBVkHPvihRQoZ7menyyWha883nLOXaqaEQ8SRQry5zlLwoKCEOhEtAe+lA6J2Uqw0lBB3fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Od5MEoUo; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Od5MEoUo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1786673994;
	bh=pqfVBxh1vtvMohYaoZPYGpzRgASu6k/jkQ6BT8b1J30=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Od5MEoUoZrVfgRcSVkJ86KUzO9AN54DKFEpgKWkVWCKJMfxoAg4J6K8Zxsl63yQLD
	 iw5SGk309j0WaYYOLU55HZYdtBWmV7gbgr8pgkf9EjKc+D/AHQ8Ep9wg/GLoxYJCwb
	 aZMN9ik0SDu0Pv342HRLmPMnY/udJ3xj0t/vVLXs+ulcL87PT9VDkQ5Gk17O4Vtpwn
	 vjr2c4/Zi/5LwqoouE+zVXe/g7VatAIrVP3SadKeDCGCmyT2UqxkjDGyz/7CgFS0ev
	 byb9GofOWD3Lrb/7EQZqT3pIchzKV0i8VZqce19uV+D7DzcN9Fi1XTsC0CyDxAQNqX
	 kj3Opu6WZmlqg==
Received: from [172.20.12.181] (unknown [12.110.208.163])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 30DA1679E1;
	Fri, 14 Aug 2026 10:19:48 +0800 (AWST)
Message-ID: <55cd94e61d68d95e9db16f21980a532f4edf70e1.camel@codeconstruct.com.au>
Subject: Re: [PATCH] net: mctp: hold a reference to the route device in
 mctp_route_lookup()
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>, Matt Johnston
	 <matt@codeconstruct.com.au>, Yiqi Sun <sunyiqixm@gmail.com>
Cc: davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 13 Aug 2026 21:19:44 -0500
In-Reply-To: <20260813022102.2792032-1-qwe.aldo@gmail.com>
References: <20260813022102.2792032-1-qwe.aldo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Aldo,

> mctp_route_lookup() uses rt->dev without holding a reference on it.

[...]

> Take a reference with refcount_inc_not_zero() before touching rt->dev,
> skip a device that is already dead, and drop the reference once the
> destination has taken its own.

This looks the same as Yiqi Sun's analysis:

  https://lore.kernel.org/netdev/20260731022926.913865-1-sunyiqixm@gmail.co=
m/

I had requested some simplifications for the proposed fix, which would
likely result in something very close to your contribution here.

Yiqi had not followed up from that review as yet, though; so if we don't
see any updated patch shortly, then your implementation looks reasonable.

Regards,


Jeremy
