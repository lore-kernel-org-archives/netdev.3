Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D04A1B4F09
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 21:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779918713; cv=none; b=qPBLK7mHMrq+2YmuNtF0vg5/BSqAMpO7cx3OyKbf+3E22O6+jEVRuvpXFwp9CBs3a+gKaf1IE/iTwD5kwgyIDzppK6HaNnDQxZPZORHUy5AE7h2GsYV8F3obYLOm3meBXR+P73lP8OEiGTDGnuB1xe6P7bbAHoe+pEsY/3Hd904=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779918713; c=relaxed/simple;
	bh=wWNhOUMwRVFn2Mjm4uo3AX/+rDJ8F3MGHjJ0OUlxJc0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ViCcnrbWsznW09WJEsdQ3ZatYxxVmTUjKF7L9i6cOzdLjqJBBQGbZXcgqXKkPwVf7HmiDBRqfHF3HJgZnQUBnvlhs2VYo3UI51yMfxyyeC/WTWQfm/Rt9smvX2P8e22Wr2s4T6hvVU/fFjuObe3g0WqVuJQifmyhvNJFaDL9nZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIoR6YVi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIoR6YVi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730601F000E9;
	Wed, 27 May 2026 21:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779918711;
	bh=eez/iIj6PgCHufxZ0PQHpNz8tvOEK/g8lRPcxRpbijQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NIoR6YVifrSW7bWwFRsNhwrHzb/iaEnfJy1cDdMDhQwuFlqYSk3BgjzrDX2/+j0WP
	 1EtVmS4Jg2PPupJ73m6wEdKKUi+qofRG9SldnQY4tXYdPQivkcvnoz2pzuMQ5+Qe/+
	 co/9UXiIEVH9u9rDoFRn4jR3eZ6QABY36XdikSuAyT/X/QO965VaynBpFc9owFWHVr
	 7JxgjzteCplwcBn1SstjZAWlKxuvOemmAcEEjdz5MI6Axk6iJocFOjurGdTB+3koMD
	 0FpC8Wa0eXj0TCp+2BwpB8kIn0lipq+qjyqD8FYmHg2QpZN2GDaeIuPfJTg43eDvy/
	 xmKCLNSFedJSg==
Date: Wed, 27 May 2026 14:51:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chris Adams <linux@cmadams.net>
Cc: netdev@vger.kernel.org, Yumei Huang <yuhuang@redhat.com>, Fernando
 Fernandez Mancera <fmancera@suse.de>, Ido Schimmel <idosch@idosch.org>
Subject: Re: Problem with IPv6 privacy addresses in 7.0
Message-ID: <20260527145150.18037ee6@kernel.org>
In-Reply-To: <20260527211356.GA16443@cmadams.net>
References: <20260521135310.GC977@cmadams.net>
	<20260526175743.1f2c3761@kernel.org>
	<20260527010641.GA21073@cmadams.net>
	<20260526183122.348e44e7@kernel.org>
	<20260527211356.GA16443@cmadams.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 May 2026 16:13:56 -0500 Chris Adams wrote:
> > > I figured out that it happens after stopping a VM (and I usually
> > > start/stop a VM for a bit in the morning, which is why it happened more
> > > than once).  So I set up a VM with a nested VM, running up-to-date
> > > Fedora 44, and then was able to bisect pretty easily, and it landed on
> > > this commit.
> > > 
> > > Fedora is using NetworkManager, and IIRC NM does some part of privacy
> > > address management (right?).  NM didn't change, so maybe this commit is
> > > confusing something in NM?  
> > 
> > Sounds plausible, pretty sure we knew this commit was risky to begin
> > with, but we had no direct proof that it'd break real life users.
> > 
> > Revert is the right course of action here. Would you be willing/able
> > to send the revert with your problem description and a Fixes tag
> > pointing to the reverted commit?  
> 
> So... I'm not very git-fluent and haven't submitted a kernel patch in
> many years, so really am not sure of the necessary/proper steps.

I wonder how you managed to bisect it then :)

git clone ..
git revert cb3de96eea66

you can use db5dadb562cabb6 for inspiration on how to format 
the commit message. You can use an LLM to help, they are plenty
capable enough to handle a revert. For sending either git send-email
or you can use b4 relay. https://b4.docs.kernel.org/en/latest/

If you prefer us to handle this - that's perfectly fine, just let me
know. I'm asking if you _want_ to handle it, as some folks like the
sense of accomplishment of having upstream commits.
