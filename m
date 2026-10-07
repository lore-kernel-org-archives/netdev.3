Received: from mail.planestimations.com (mail.planestimations.com [45.92.8.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E691F2B8D
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 01:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.92.8.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791422764; cv=none; b=Fs9uaSFxbVOq5qWT5JC4XKQBOTeFSDugctjnLQVa8UuOSy4/awL4Z5lOqzs/O1xiGQf6yrw+e1p5bCUoiTTU0PIopAjunooKcT5LtRs3eXUqRNFnn0gqJOIKzhJwrXk71iB4epp91QbI4MF4PhpYkafBk/2r0vGWMr1CUTTuycc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791422764; c=relaxed/simple;
	bh=8ddUMviyaTIE/b3Q7TESwbCHvmG/uyPLPPeK9owdoOI=;
	h=References:In-Reply-To:Message-ID:From:To:Subject:Date:
	 MIME-Version:Content-Type; b=VzTbv+SBlcXCpFKxnpH4vsR6Bi3AQReEONtf4Th5h2AKLCRAhwvbx7Taulpw1vP9mX54TACwEcb3liJSByBeEBG3e1AxbA3eUhQ8ka2KCmr1Cs6oXCQvXcsJELnn7xusJhRZVoqbvM5m9HD+vS/RbstV1J3c0t89SJjRexbfJTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=planestimations.com; spf=pass smtp.mailfrom=planestimations.com; dkim=pass (2048-bit key) header.d=planestimations.com header.i=@planestimations.com header.b=R+gNr+aO; arc=none smtp.client-ip=45.92.8.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=planestimations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=planestimations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=planestimations.com header.i=@planestimations.com header.b="R+gNr+aO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=planestimations.com;
	s=202505; t=1791382385;
	bh=8ddUMviyaTIE/b3Q7TESwbCHvmG/uyPLPPeK9owdoOI=;
	h=References:In-Reply-To:From:To:Subject:List-Unsubscribe:Date:
	 From;
	b=R+gNr+aOjMhzdp6jql40iOK7Eha5NB47o9AuSIP9PyGBvcJ8Zn/dEptmnqr3V8d2N
	 cMage6YnAn91RvHvB/r2CPfPgHqsUyT29el0v4CQ8cCZg4P0ts/M84hluDkzGmzCvo
	 CW++0N4/Jo7TOAsezaEdKULqugzNvenGFGYkHAcg0Ob17LdbrG5iIg+FpHlxkBlhmH
	 HmhKwXqrJbBFunKzoHMJJWrW/5Cf/veWEpiqaOBfVg6xdXS1h99JEfyBPgwNVx6I59
	 1QEpDAY21MNpaiR2FlF5O6TNqxaFdcaSltRxk+ioSuabkHbksClq9jc+3cnHdi1dM9
	 /yPdvIsyjN0Sg==
Received: from [127.0.0.1] (ec2-34-228-56-192.compute-1.amazonaws.com [34.228.56.192])
	by mail.planestimations.com (Postfix) with ESMTPSA id B70D5502443
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 16:13:04 +0200 (CEST)
References: <31587773-4622-48b8-b41f-fdaeaff202b1@planestimations.com>
In-Reply-To: <31587773-4622-48b8-b41f-fdaeaff202b1@planestimations.com>
Message-ID: <d88599a2-3397-4dd4-af60-06a38ae52d64@planestimations.com>
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Jane Wells <janew@planestimations.com>
To: netdev@vger.kernel.org
Subject: Re: Comprehensive Construction Trade Takeoff Support for Your Next
 Build
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 14:13:03 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hey ,

I wanted to share a quick example of our project breakdown.

We recently completed a full CSI takeoff covering roofing, MEP, structural,=
 and finishes with clear cost breakdowns.

If you'd like, I can share a =
similar sample tailored to your work scope.

Do you want that?

Regards,

Jane Wells | Sales Representative
Plan Estimating

Click Here to =
Unsubscribe
