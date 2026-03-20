Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADE0248886
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 06:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773986734; cv=none; b=KEmEnptPcFStfQbmwl3oOaL2z2jx0vvpm2Qjlyolvcb9PvoWgjRQAcfKGbjdOCnHm1u3JOjEZNGr6Zz7IlKqEHcd4KvQFJ7YzlVCshhETHx2IAXyDODeDdHIOqu+3GqTwS+UhAmPRcjTc05eSEG/ueOCyu1vxmJ3Fuh8sWDZin8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773986734; c=relaxed/simple;
	bh=oNWHVssiMzmZKcyAJfV+YaiiycDV97vQmqxRd4IUuvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2uBGUKXABmEj0ldTI3nB1zcwQlLu0HXmoPEyyB/ulo90PRUmJSfrUxmHCfdiQ/yUqB4maxLsgdfxYArO57qN7vBS5/vJsCF6sIY1Y0HLJYHv0KhbEtRBjhZbeaNlSkIRs5JwjBwgJNnw+RtSmINS2kYxB3aEqI7oWX3543vz3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=lZx4xLIU; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="lZx4xLIU"
Received: from x1 (122.24.31.150.dy.iij4u.or.jp [150.31.24.122])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62K65Nak002627
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 20 Mar 2026 15:05:25 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=pzYpIbPQzLRmoVZlDhNsuUG/czPwk1YNqqtzPT/dJxg=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1773986725; v=1;
        b=lZx4xLIUMlFm6VvvIcjQMDAwFDO6xfzJHhgAN1JZKocAiGrvKB95zon25WEawmoC
         kXOgFIX3ds5c9IUSx43WNIo2gfse8JSHJ0P7SIHH55CyxVsbyjO4EucWlZAiBrB7
         Y/LbvS07zdGnILzZ0pLYp6vejzPIIqh8Tm9kgWZayHbBoXxTUt+uD/oTCil9ylsb
         CIkHI2HVwa19jAQ4HORh8g3ZCxAmXKWzrdQ8IEO7y4vCZKyjsCUQ/rJyq754gYr8
         ALGUq3r50UKWo1kBXu44yNhNhx0GYvg7ey9D1zicQyHX+HHjyboqAsEJyv8M3IoI
         bX3UNSNWkZSfItW7ycg3ng==
Date: Fri, 20 Mar 2026 15:05:23 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        Simon Horman <horms@kernel.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, dima.ruinskiy@intel.com,
        kohei.enju@gmail.com
Subject: Re: [PATCH iwl-next v2 0/2] igc: enable build_skb path
Message-ID: <abzhZsk5FdB2eWeN@x1>
References: <20260317062205.39406-1-kohei@enjuk.jp>
 <20260319161140.GI1753385@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260319161140.GI1753385@horms.kernel.org>

On 03/19 16:11, Simon Horman wrote:
> On Tue, Mar 17, 2026 at 06:21:44AM +0000, Kohei Enju wrote:
> > This series enables the build_skb RX path in igc, which is currently not
> > enabled in any configuration.
> > 
> > Patch 1/2 adds missing RX hardware timestamp handling in the build_skb
> > path.
> > Patch 2/2 enables the build_skb path when XDP is inactive and other
> > conditions are met.
> > 
> > Tested on Intel Corporation Ethernet Controller I226-V (rev 04).
> > 
> > Changes:
> >   v2:
> >     - don't insist on reverse christmas tree, reducing net diff in the
> >       patch 1/2 (Dima)
> >   v1: https://lore.kernel.org/intel-wired-lan/20260307182808.155027-1-kohei@enjuk.jp/
> > 
> > Kohei Enju (2):
> >   igc: set RX hardware timestamps in igc_build_skb()
> >   igc: enable build_skb on the non-XDP small-frame RX path
> 
> For the series:
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Hi Tony, thanks for applying this series to next-queue.
I have a question about the process of patch submission.

Sometimes reviewers give RB tags for a whole series like this, but I
think that those tags on the cover letter are not collected
automatically, right?

In this case, should I add RB tags to each patch if I respin for other
reasons, or what is the recommended way to handle this?
