Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE053E6DCE
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 02:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780625115; cv=none; b=AHop5lC4S77syUOnJrjOTZIcR1R9Y+X/zgKGT5Xs3t8tMgw5OGnxLuBHf0BHc4gopyyTVS6VXQMNoM5XhztIQJMzvryvo54z8JnEpI/lOPGUhjhOrPMNNQB/nHnwtBX6/637B8YbK56xCtQFRD6dklKAro77aJNmManaeSnzngA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780625115; c=relaxed/simple;
	bh=zwnCPhYlPB6oT77FyXyeja7i6xE/0SDarZyYfs5JuTU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fmochIwUbWmHWdtyOFOa568tQZtS82MHxie3O4rw152qwDLsmcXCLqFQsZT2zT8Q6Rq2x0cbk/Hei0/lZVg2/34PX2Ls6fHQbNeqoceAjqEAxdDIMoqw35xfS/7duqon1nADrAbaApk5G7/WzpvFOljA24NDamLEZCZlpXi28vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXj0i/iK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXj0i/iK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608E21F00898;
	Fri,  5 Jun 2026 02:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780625106;
	bh=IoGezIQY8JwjEgJLtk9qmtIkob+44rNUO48LJRDa2Vo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GXj0i/iKeM+ZnpE1cotIxgyXfp4QcXowbRPYndm9qLgaJ+IAa/EzCIpiVFIUWF8Un
	 Gb2JgZO2bJSVSiv3PV9Ot2cykXaGUXYJp3pyOwwdbVlJEph6K9pVkh1zPI+3xVLBmh
	 YiQnw73Nb46cU8SEtkM1NBkQcDX1dJPgPItalw5LgVRnnXxwNFy4c5f7VbQRcMwL3A
	 B3tRf5SwPPbfW9IsiozG3rThlHpw9uUA3RwZrKtRDVaZ/ftQZrTt1m+Qrp9lihBKJa
	 utyhfIjT0YNRKldppCwPTLfqBG8996/TeZGY2uivpuO/CrXVOzGUaaBP10GboOUx9b
	 RKRC9SXA3YvbQ==
Date: Thu, 4 Jun 2026 19:05:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 marcin.szycik@linux.intel.com, aleksandr.loktionov@intel.com,
 sandeep.penigalapati@intel.com, ananth.s@intel.com,
 alexander.duyck@gmail.com
Subject: Re: [PATCH net-next 00/10][pull request] ice: Add ACL support
Message-ID: <20260604190505.14a40272@kernel.org>
In-Reply-To: <20260603220828.829969-1-anthony.l.nguyen@intel.com>
References: <20260603220828.829969-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Jun 2026 15:08:16 -0700 Tony Nguyen wrote:
> The following are changes since commit dfcc2ff12925d99e858eaf539eaa4aaaf81fe2a6:
>   selftests/net: bind_bhash: fix memory leak in bind_socket
> and are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

There's seems to be 30 issues reported by both Sashikos. 
I'm going to assume that at least one of them is valid.
Please LMK if that's not the case

https://sashiko.dev/#/patchset/20260603220828.829969-4-anthony.l.nguyen@intel.com
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260603220828.829969-4-anthony.l.nguyen@intel.com
-- 
pw-bot: cr
