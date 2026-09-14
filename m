Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6766233F58B
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 17:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789406470; cv=none; b=tiOew201pejnQBPbNDUzp/J6fEvMqsj3tNh3xnmGwTIgR2k7r9e/qh2AYPhwKkeWedFgNAVKbI/ybJ+FONh80lawrepJypnnz/8Ew/NhTDfImlGVqCZNVjoPnWq4APZTrRGLo+d+UazVFjT3+LwKusuT+GLXFgAO8q7s54/c2EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789406470; c=relaxed/simple;
	bh=JsU17Dj6KOJtke4K8xCarl6MCp1n+IG115vNSUn/wts=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cuHVWV5zhtIi+8OF63gDztAk8V84NP8mcKMNMtNs763Y0NAApdizDTaZYA6AamdsORCR5/d4FaAjsm5x5cw4YluuLveFV5Ql/1J0iw6IEyv26nQlR1+9hhVRGi1ZZWAJD4YmTcdfa5nSHXm+9LY7Q9rvovBnJfvCaSFSBjGrzSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYk4haTR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYk4haTR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07D91F000FF;
	Mon, 14 Sep 2026 17:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789406469;
	bh=BvrlFkCkOhXibiEwYGcrb8JFDiRKbu0Rr/a/Eme3EV0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LYk4haTRFOmW+syEMnAFAnicuDWSo1P2Owst4OMf2U94IBFGENX3MA2NY99stjSOg
	 hQ+wmVBNeyh/YMCKhJTR2TLro+JbZM/jZr8G7AiiD20cl09quK70KxzculjJnIEzHz
	 9Sb9FdxM1+HHfj/A8avcoFit8T0TbE1416UolJkNgiOZIbRX3k28K48n+4NcZmTmKE
	 Om5k816qlrdLgxtk+lf990E90Q+KzUbm2YE1FbikgSrrO/yp//xVY80y2Y56ea8F5x
	 7UhVc1PfmcDfgu/PkMfdpuRFr13rb0m6Hmo3yKkh9Fy9h2JVrOwO19tv6mBE7II267
	 WMpJjC3pAq1ag==
Date: Mon, 14 Sep 2026 10:21:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Quentin Armitage <quentin@armitage.org.uk>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org
Subject: Re: net: parsing IFLA_INET_CONF broken since 7.1 if NLA_F_NESTED
 not set
Message-ID: <20260914102108.788e700f@kernel.org>
In-Reply-To: <49f5ad9f2a4c1f2178f64383b4f05c21106fce7b.camel@armitage.org.uk>
References: <49f5ad9f2a4c1f2178f64383b4f05c21106fce7b.camel@armitage.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 15:21:59 +0100 Quentin Armitage wrote:
> Commit fa8fca88714c - "ipv4: validate IPV4_DEVCONF attributes properly" changed
> inet_validate_link_af() to call nla_parse_nested() rather than
> nla_for_each_nested() for IFLA_INET_CONF. A side effect of this change is that
> the code now checks that NLA_F_NESTED is set for IFLA_INET_CONF, and rejects the
> message if it is not, whereas previously there was no check for NLA_F_NESTED
> being set.
> 
> The consequence of this is that code which worked prior to Linux 7.1, albeit
> erroneously not setting NLA_F_NESTED now fails.
> 
> In order to maintain backward compatibility, rather than calling
> nla_parse_nested(), nla_parse_nested_deprecated() should be called, as it is
> earlier in the function.

Please explain how you discovered the problem.
Is there some open source or closed source SW you're aware of which
breaks?
