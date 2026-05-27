Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EFC363C60
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 22:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779921379; cv=none; b=kmDSKIyPsEBUFKdkJgphwEMJkID81musxX/1mg65m5Smk6qvuqoCV4V9DbdnU6vBMc1bOzKZmEcyNeZn+CQPcosxxt4PugQoVdLYnFeJuf1C3LhwYyMWrOXeCsrIQuiuUqVWYV+3Wd4C5P/XVod80M+9kgFGsrqIw6wjXyUqX50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779921379; c=relaxed/simple;
	bh=VEHvifIf2h4ngrtdzTMJGFGtQoqcD392zoSfpiPmBBA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NvAf0lIuGCdeZUjl6R2v3SWjqZJAKbw1CiQohazL/XAfmVz6CazymFtGoIOxYF9LlfuCP4JrSId2Cb1l4J9Nun0SAhgyb9Ftt/VAD3CppL7uJ2QelopqWS/RxJxJonFUqEBUXdJ2Xe45TeCGQKTPtJQgI1iYUXyxMy0DdvwRWgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKwADrgr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKwADrgr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0CF1F000E9;
	Wed, 27 May 2026 22:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779921378;
	bh=0yabREBtdvuWZG8/PEf31cTg/2D8cnUNoAqn0QYoWYw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AKwADrgrdN/ehavWYCEP96O3nQXa2svNKfgzZV8jDnuTvQ0ze5bx5gLcH9iLxLwke
	 x6I0bEx/uk8FFwzsJIkhwaT6a4xfYi5CDDrHVyyNTtagk5b6ZrYLPH0PrXhIrY6QR5
	 +5XAkl9xBzt00QelIRAgkFEzyFlo1g5OpqhFvtqIkZjWHHvKtqnwEl+0sudC8MoCPl
	 5EhWqRWGCAkjYNCgTwktksF38xf0ZAetwC1bvAXBTTmsKCCuEcgYv5V69+VGWfF7+w
	 HpRKbjWSaNJ0c1uojHlwEFDDHO4bs0jfu8iA4ecV7gFQDveLur+onU6By8T2yMRvuC
	 KlSbZKO/RcIow==
Date: Wed, 27 May 2026 15:36:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antony Antony <antony@phenome.org>
Cc: steffen.klassert@secunet.com, netdev@vger.kernel.org
Subject: Re: nipa: tree selection fails for ipsec-next series?
Message-ID: <20260527153616.17c2b5e4@kernel.org>
In-Reply-To: <ahaz550I55ZvMRDI@Antony2201.local>
References: <ahaz550I55ZvMRDI@Antony2201.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 May 2026 11:05:43 +0200 Antony Antony wrote:
> Looking at the nipa source, series_tree_name_direct() matches the cover
> letter subject against _trees.keys(). Since ipsec and ipsec-next are not
> in the deployed conf_trees, the match fails and nipa falls back to
> guessing against net-next. I am guessing ipsec-next is missing in the config too.
> Where is the config nipa runs use? I didn't find the exact config nipa bot 
> used.

The netdev@ NIPA is for the netdev+bpf patchwork instance, and 
the related trees. Should be easy for y'all to spin up an instance 
for ipsec.. ?
