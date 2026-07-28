Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740E73E5ED1
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 22:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785276815; cv=none; b=c6a5sJIESTph4S3fwEM+K3x9JRrtsxHrVqrzFsLE2G5/v6FDsgSw4qd+a1wF4vA0Qb4SCPqRewudxBo4wFxE0uKs2ilPhsSlApI33tLTxQarrk3AGuL/TGVEQeLTXhL4PtjekyWWAswLa6oUIzfKtyTbGZXP6rSAWBHyvnjF7/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785276815; c=relaxed/simple;
	bh=g4CHU5iAJvnza+psD0M59zfnV5uD3RKym/uwa2ESE1c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bgDLdQ5iKUUszKo1g+qgpDeuzlZKJGxH6F0nitQTTu2evEuTU83hfxD6sUp5NH00dHay6wKKotS2MaL4K4jVArua52sznzAO0Aq0YDoxRkgIsHELbkijdQFkLznhy2fiE87pNulxftzQ1m06fF2t8h2qhjbXHWvlyP2mStYDeSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2WVKZ94; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2WVKZ94"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46861F000E9;
	Tue, 28 Jul 2026 22:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785276814;
	bh=g4CHU5iAJvnza+psD0M59zfnV5uD3RKym/uwa2ESE1c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Q2WVKZ94HPHBGY1q1RnaWArkEzKTzulULZcukAVkOsmwxwmsyelfFkAs5Uzq6d5Mc
	 FC05QizL0Wef+PbQ2UIfDyolDNKP4ElSuSw9z/S7l/jSGWk56XP0Sr10cGwd9wDIrS
	 5axyHTbgCOoflSmzyucXQVnrr0Dte2ONV4xpr7r7U/RvyfNTl5fDOawoIMMRprnQNT
	 IvwzEM9usJwd9d+OawM1KMsUJzYQ103qW5rPJndWY0fsHrY3W5/QTyXBuvk8/8G5Bq
	 NlD/iSKPFa0OqcJI89BcjZJS6naPfEf4YH89ar8lLodZmAMnqxGRclj27l65X+VPX/
	 VMSFl7ff+j42g==
Date: Tue, 28 Jul 2026 15:13:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sheena Mohan <sheenamo@google.com>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org,
 Willem de Bruijn <willemb@google.com>
Subject: Re: [TEST] google runner needs nested cases
Message-ID: <20260728151333.2d778f4f@kernel.org>
In-Reply-To: <CADWJPTs6G7zy+9aLxz9QD9Fk1szZK0b-vEFUm2jxTMtxt+t1uQ@mail.gmail.com>
References: <20260721063829.7d9e6c7f@kernel.org>
	<CADWJPTsP=2=JFE9Oh5ym_wz4vROEFOCqa+dyCLRymyYLRB1BSg@mail.gmail.com>
	<20260723103607.55debff2@kernel.org>
	<CADWJPTs6G7zy+9aLxz9QD9Fk1szZK0b-vEFUm2jxTMtxt+t1uQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jul 2026 10:07:15 -0700 Sheena Mohan wrote:
> The recent updates have been merged, and the tests should now report
> sub-case results.
> Please let us know if any further improvements are needed.

Looks good, thanks!

I'm still waiting on the device node, but I assume we're stacking that
separately.
