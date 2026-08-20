Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037D639B959
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 21:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787260931; cv=none; b=nTyh9qjIIvn6Nhy1mga77kCj0qxs4uZSJRBcIloLbZzSqYj0dVUUzx7/B0iIdhGbbVMENl5ezgZthEPq1KVw2wz67Mc+zB3St8eGwxmbcqsyOsOt0VBK5pdk5q83tM4Wo4QKQin5W4FxI7a09gxBESrLL5Z+9yULTGOWAIa2oik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787260931; c=relaxed/simple;
	bh=nbWeyZ2IzlTGLPxR+/+qB4M4eSAWMjkX27Vw6utmM/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGnzn/EkzXzEbdz63iSNvWHMTYToHmHrB5k9QVWNuro2jYZRw0+3XLmDS0IZH/H6qs5Sv5Q8/YMT0FyB8HNbgzm5gg+NgEs1X3pDN0ohaU2D7BO+BJUNZXOPLsLfKV4cWqgsPQkHVSRLlOC4jljHve+I4VVC/lEtAvJOBBUC/vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ExeDnlFL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ExeDnlFL"
Received: from LAPTOP-F8U7OQUB.localdomain (unknown [167.220.24.32])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0B54E20B7128;
	Thu, 20 Aug 2026 14:21:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0B54E20B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787260900;
	bh=0N1jL7SZbZ6OJ6R63ohP6IKu7MTGTQW20CvpYo7lNuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ExeDnlFLBRUWlDnxXyBZ4C0DlXun0JtO3U55naobHGL/xv5kE+ZOK3PcNv+gp6cqW
	 IpAAVkP9oP+X7Q2RMVpAhP2TdL+6Lb7MyMwsXsOX3dXgcejzb5oEc0o6oPXy/VpAAD
	 YSYafy/mnMyalV7Ei7aMKLlL9gO1W4mYe/o8XQ7M=
Date: Thu, 20 Aug 2026 14:21:41 -0700
From: Tahera Fahimi <taherafahimi@linux.microsoft.com>
To: Sasha Levin <sashal@kernel.org>
Cc: netdev@vger.kernel.org, sashal@kernel.org, steffen.klassert@secunet.com
Subject: Re: Backport xfrm race condition fix to stable kernel version 6.6.y
Message-ID: <aodv5ebOtrsRQhSH@LAPTOP-F8U7OQUB.localdomain>
References: <20260817221108.778584-2-taherafahimi@linux.microsoft.com>
 <20260818220420.14@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818220420.14@kernel.org>

On Tue, Aug 18, 2026 at 11:32:28PM -0400, Sasha Levin wrote:
> On Mon, Aug 17, 2026 at 03:10:09PM -0700, Tahera Fahimi wrote:
> > I am writing to request the backport of the following patch to stable kernel versions 6.6.y,
> > addressing CVE-2026-31516.
> >
> > Patch to Apply:
> >     Subject: xfrm: prevent policy_hthresh.work from racing with netns teardown
> >     Commit ID: 29fe3a61bcdce398ee3955101c39f89c01a8a77e
Hi Sasha,
Thanks for your reply.
You are totally right. I noticed the issue after I sent the email. I sent this fix patch for review.
https://lore.kernel.org/all/20260820211418.1409602-1-taherafahimi@linux.microsoft.com/
Thanks,
Tahera
> This one is already in 7.1.y, 6.18.y and 6.12.y, but it can't be taken
> as-is on 6.6 and older: the line it adds calls disable_work_sync(), which
> only exists from v6.10 onwards, 86898fa6b8cd ("workqueue: Implement
> disable/enable for (delayed) work items"). The cherry-pick applies
> cleanly and then fails to build.
> 
> Substituting cancel_work_sync() compiles, but it drops the re-queue
> prevention the commit exists to add, and I'd rather not make that
> substitution silently on a CVE fix.
> 
> Could you send a tested backport for the pre-6.10 trees (6.6, 6.1, 5.15,
> 5.10)? Netdev folks Cc'd in case they'd rather do it.
> 
> -- 
> Thanks,
> Sasha
