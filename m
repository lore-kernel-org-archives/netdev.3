Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598792BE630;
	Thu, 10 Sep 2026 00:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789001441; cv=none; b=LFCHQ9AYMunm0VxNRAj5c+GAnqP0Z49kbNTnQb+TqpBTsgS0LADa4I7Or9WRsnGzuwEpe0dbvnhMfOrE8uIK6TpObI3ILwlYA/oKmXGiTtreXHlB8rvyPSAWZViewptxLst1CbKr50IceX52pN4Qz8ly8Tmuzn6z/XyXGu2y560=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789001441; c=relaxed/simple;
	bh=OUfqSaSl4/5o/CPGEXy3/ysZj47tIBJetf6QTFDcMjs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dZhMY0UteTwvbT0uCGPFga1vc32ElnSudyZzqk08a83ujq9U2e+oC4W7hxCr/37h87KZth4P4Q6PAXdw/FXU+/2YWW1phM46nOMSFyiZka6PpQeJ0zHsgc+KpfgiM1HpLprRo3sd9W3Y2sAbZgxNrYSt8KLOxy0LerB7CLfylnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVH16en9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVH16en9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79931F000FF;
	Thu, 10 Sep 2026 00:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789001440;
	bh=AUSqn64YUdfo6g8K8mt+IbHKto1e+nIlwSperkdCI9k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bVH16en9C+TaBgytEXWkNqD0miCCc7zQ1X565iWLbt0QuEbUwxMDup8KnJAR7FFIt
	 BASBRwhllvvAeDud2fXaposD7XIStImzOp8cs2LzcSPO8PlPkOZtfg1U9pesVvlH8P
	 oKXt80H3Gc+qpyu+cgqn9A0ghj6VrJBdNTa0KruTzQHm/8ioNFYuTOX8FDuhshuq9H
	 UDvIifoW1z7CS7PUUBO/983IR/0dGKzNRJ84qGEmRdCGUwq2hINR6FgDWQK/cYX6cz
	 WKAhihb9IorrrB9iOMsdp1i7xmRbi9YvpwgLbEf0/d/11IVoGB8qBzCRmZPbAOyV4y
	 BnFp4aWaRd5cA==
Date: Wed, 9 Sep 2026 17:50:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Hemanth Selam <hemanth.selam@gmail.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, <intel-wired-lan@lists.osuosl.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH iwl-next v2 0/4] intel: fix typos in comments
Message-ID: <20260909175039.5149a58e@kernel.org>
In-Reply-To: <e798b454-1f26-4502-a705-9e32dedcdcb6@intel.com>
References: <20260907095446.27290-1-hemanth.selam@gmail.com>
	<e798b454-1f26-4502-a705-9e32dedcdcb6@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Sep 2026 14:07:25 -0700 Tony Nguyen wrote:
> On 9/7/2026 2:54 AM, Hemanth Selam wrote:
> > Comment typos across the Intel ethernet drivers, split per driver.  Found with scripts/checkpatch.pl using the
> > misspelling list in scripts/spelling.txt.  Comments only, no code
> > changes.
> > 
> > v1 went out with a bare [PATCH] and a "net:" subject prefix.  As
> > maintainer-netdev.rst asks, v2 designates the patches to a tree, and
> > each subject now names the component it touches instead of "net:".  The
> > series is rebased onto that tree; the diff is unchanged.  
> 
> Thanks for the changes; looks good. However...
> 
> netdev maintainers: Everything looks good to me and since there's no 
> testing to be done. Did you want to take this directly?
> 
> If so,
> 
> Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>

SGTM, probably saves everyone a little bit of time if we take directly
