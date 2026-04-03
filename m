Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C31C2AEE1
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 22:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775256338; cv=none; b=hvq9XcIamJ8eOJogXD4wVtUeg6928vkeXZPLToeGdaV/a+WCm6aNGN8Lg8+KNdgppBjSiraDCi0I0AqobhpBGPBEYb3Skwxr/Kb467v3vMzq2rzs+dNq9+WT/MBvi+2dKMRWErCrkdNW4EZDTjXIk3Z9IopWkgcyIG235jAN7As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775256338; c=relaxed/simple;
	bh=OlaIPCXK2Sjbt11aK/KetL4kjEhVvvZu3fOpiCH8GyI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PWIgaSqobBThywpNViSOHT2ETUB849m0XNC3bYfINOFcZPB5z0ldthbQvPrrt1e4ubnuYQxSPqeQvsRmO21UxIU22YlqYXMlJt7dFXi5T4EALCWdrthpJ667S3C9E0fzIAe7jeXX5ixST1z/JeDD5MiLFVCOh2qRRZpGJGLqRJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1i119mi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1i119mi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78449C4CEF7;
	Fri,  3 Apr 2026 22:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775256337;
	bh=OlaIPCXK2Sjbt11aK/KetL4kjEhVvvZu3fOpiCH8GyI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q1i119miT7oKLppNHhu8ZEX894c4qfXi1N3oClds5IjyAH9+P9XO5fnoRmilhf8pQ
	 0nb7KII1qwiTNBlI1KSbC2xls8UiiaGd7is3wipzs8FNFim9OuGPqG1u4TmavlHJ2f
	 sr28fi8A8c4/+eYZdhVc9cpho5XT5QkqXvnrQ/f4CMHwf+IoCW+lyMlLO6zpWijX4E
	 3rdNBG+6I99f6evZjVUF0KmBIgNwc1CgYXpZ4M6Siw6oGPXMZX9i41q2LFK72pGhVt
	 vDt7yEVNEs2ebl4cf+TWudhWCobTPTJQIPhdRYNG+aZQWcDiZr2KNX25yDxh9EHoJt
	 3AIGNHn01JnGg==
Date: Fri, 3 Apr 2026 15:45:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yiqi Sun <sunyiqixm@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] ipv4: icmp: fix null-ptr-deref in
 icmp_build_probe()
Message-ID: <20260403154536.5decaedc@kernel.org>
In-Reply-To: <20260402070419.2291578-1-sunyiqixm@gmail.com>
References: <20260402070419.2291578-1-sunyiqixm@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  2 Apr 2026 15:04:19 +0800 Yiqi Sun wrote:
> Instead, silently discard the request. RFC 8335 does not appear to
> define a specific response for the case where an IPv6 interface
> identifier is syntactically valid but the implementation cannot perform
> the lookup at runtime, and silently dropping the request may safer than
> misreporting "No Such Interface".

Well, my intuition would be to fall thru and make the check after the
switch handle error pointers. But I guess this version gives us the
opportunity to delete the just-added check on net->net-next merge so ok.
